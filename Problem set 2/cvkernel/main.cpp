#include <iostream>
#include <iomanip>
#include <math.h>
#define _USE_MATH_DEFINES
#include <fstream>
#include <string>
#include <cstdlib> // for exit()
#include <vector>

using namespace std;

const int N = 19107;

double abs(double x)
{
    double retval = x;
    if (x<0)
        retval = -x;
    return retval;
}

double reciprocal(double x)
{
    double y = 1/x;
    return y;
}

double normpdf(double x)
{
    double fx = exp(-pow(x,2)/2)/sqrt(2*M_PI);
    return fx;
}

double normpdfdiff(double x)
{
    double fx = -x*normpdf(x);
    return fx;
}

//kernel estimator takes data, size of the data n, kernel function, and point x
double kernel(double data[], int n, double (*k)(double), double h, double x)
{
    double fhat = 0;
    double xi;
    for(int counter = 0; counter < n; ++counter)
        xi = data[counter];
        fhat = fhat + k((x-xi)/h);
    fhat = fhat/(n*h);
    return fhat;
}

//cross validation, kd is the derivative of the kernel, returns the derivative of cross validation objective to pass to root solver
double cvobjective(double data[], int n, double (*k)(double), double (*kd)(double), double h)
{
    double cvob = 0;
    double xi;
    double xj;
    for(int i = 0; i < n; ++i)
    {
        xi = data[i];
        double sumki = 0;
        double sumkdi = 0;
        for(int j = 0; j < n; ++j) //find sum of k((xj-xi)/h) and k'((xj-xi)/h)*(xj-xi)
        {
            xj = data[j];
            if(j==i)
                continue;
            sumki = sumki + k((xj-xi)/h);
            sumkdi = sumkdi + kd((xj-xi)/h)*(xj-xi);
        }
        sumki = sumki-k(1/h);//gets rid of the terms where i=j
        sumkdi = sumkdi-kd(1/h);
        cvob = cvob - reciprocal(sumki)*(reciprocal(h)*sumki+reciprocal(pow(h,2))*sumkdi);
    }
    return cvob;
}

class kernelwdata
{
public:
    double observations[N];
    double cvobj(double h)
    {
        return cvobjective(observations,N,normpdf,normpdfdiff,h);
    }
};

double secantmethod(kernelwdata obj, double init, double tolerance, int giveup)
{
    double x = init;
    double old = init+1;
    double newp;
    double fold = obj.cvobj(old);
    double fnew;

    for(int i=0;i<giveup;++i)
    {
        fnew = obj.cvobj(x);
        cout << "fnew is " << fnew << " when x is " << x << endl;
        if(abs(fnew-fold)<tolerance)
        {
            cout << "Objective values get too close after " << i << " iterations." << endl;
            break;
        }
        newp = newp - (x-old)*reciprocal(fnew-fold)*fnew;
        old = x;
        x = newp;
        //cout << "Estimate is currently: " << x << endl;
        fold = fnew;

        if(abs(fnew)<tolerance)
            break;
        if(i == giveup - 1)
            cout << "Secant algorithm did not converge." << endl;
    }
    return newp;
}

double silverman(double data[], int n)
{
    double mean = 0;
    for(int counter = 0; counter < n; ++counter)
        mean = mean+data[counter]/n;
    double sigmahat = 0;
    for(int counter = 0; counter < n; ++counter)
    {
        sigmahat = sigmahat + pow(data[counter]-mean,2);
    }
    sigmahat = sigmahat/(n-1);
    sigmahat = sqrt(sigmahat);
    double m = (double) n;
    return sigmahat*pow(m,-0.2);
}

double bisection(kernelwdata obj, double init0, double init1, double tolerance, int giveup)
{
    double x0 = init0;
    double x1 = init1;
    double f0 = obj.cvobj(init0);
    double f1 = obj.cvobj(init1);
    double x = (x0+x1)/2;
    double fx;
    //need check that f0 and f1 opposite sign
    for(int counter = 0; counter < giveup; ++counter)
    {
        fx = obj.cvobj(x);
        cout << "x0 is " << x0 << ", x is " << x << ", x1 is " << x1 << "." << endl;
        cout << "f0 is " << f0 << ", fx is " << fx << ", f1 is " << f1 << "." << endl;
        if(fx*f0>0)//i.e. if fx and f0 have the same sign
        {
            x0 = x;
            f0 = fx;
        }
        if(fx*f1>0)//if fx and f1 have the same sign
        {
            x1 = x;
            f1 = fx;
        }
        x = (x0+x1)/2;//bisect
        if(abs(x0-x1)<tolerance)
        {
            cout << x0 << " and " << x1 << endl;
            cout << x0-x1 << " < " << tolerance << endl;
            cout << "h values close enough to call it a day." << endl;
            break;
        }

        if(abs(fx)<tolerance)
        {
            cout << "Objective close enough to 0 to call it a day." << endl;
            break;
        }
    }
    return x;
}

int main()
{
    kernelwdata incomes;
    std::ifstream ifile("incomes.csv", std::ios::in);
    std::vector<double> scores;

    //check to see that the file was opened correctly:
    if (!ifile.is_open()) {
        std::cerr << "There was a problem opening the input file.\n";
        exit(1);//exit or do additional error checking
    }

    double num = 0.0;
    //keep storing values from the text file so long as data exists:
    while (ifile >> num) {
        scores.push_back(num);
    }

    //verify that the scores were stored correctly:
    for (int i = 0; i < scores.size(); ++i) {
        incomes.observations[i]=scores[i];
    }

    //double sv = silverman(incomes.observations,N);
    //cout << "Silverman bandwidth is: " << sv << "." << endl;

    double cvbandwidth = secantmethod(incomes,0.075,0.000001,100);
    cout << "The cross-validation bandwidth is: " << setprecision(10) << cvbandwidth << "." << endl;
    //double cvbandwidth1 = bisection(incomes,914,1200,0.000001,1000);//inits taken from secant iterations
    //cout << "The first cross-validation bandwidth is :" << setprecision(10) << cvbandwidth1 << "." << endl;
    //double cvbandwidth2 = bisection(incomes,9000,18000,0.000001,1000);
    //cout << "The second cross-validation bandwidth is :" << setprecision(10) << cvbandwidth2 << "." << endl;
    return 0;
}


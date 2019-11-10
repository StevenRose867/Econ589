#include <iostream>
#include <math.h>
#define _USE_MATH_DEFINES
#include <fstream>
#include <string>
#include <cstdlib> // for exit()
#include <vector>

using namespace std;

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
            sumki = sumki + k((xj-xi)/h);
            sumkdi = sumkdi + kd((xj-xi)/h)*(xj-xi);
        }
        sumki = sumki-k(0);//gets rid of the terms where i=j
        sumkdi = sumkdi-kd(0);
        cvob = cvob - reciprocal(sumki)*(reciprocal(h)*sumki+reciprocal(pow(h,2))*sumkdi);
    }
    return cvob;
}

double secantmethod(double (*obj)(double), double init, double tolerance, int giveup)
{
    double x = init;
    double old = init+1;
    double newp;
    double fold = obj(old);
    double fnew;

    for(int i=0;i<giveup;++i)
    {
        fnew = obj(x);
        if(abs(fnew-fold)<tolerance)
        {
            cout << "Objective values get too close after " << i << " iterations." << endl;
            break;
        }
        newp = newp - (x-old)*reciprocal(fnew-fold)*fnew;
        old = x;
        x = newp;
        cout << "Estimate is currently: " << x << endl;
        fold = fnew;

        if(abs(fnew)<tolerance)
            break;
        if(i == giveup - 1)
            cout << "Secant algorithm did not converge." << endl;
    }
    return newp;
}

double cvobj(double h)
{
    return cvobjective(double data[],19107,normpdf,normpdfdiff,h);
}


int main()
{
    const int N = 19107;
    double incomes[N];
    std::ifstream ifile("incomes.csv", std::ios::in);
    std::vector<double> scores;

    //check to see that the file was opened correctly:
    if (!ifile.is_open()) {
        std::cerr << "There was a problem opening the input file, sucker.\n";
        exit(1);//exit or do additional error checking
    }

    double num = 0.0;
    //keep storing values from the text file so long as data exists:
    while (ifile >> num) {
        scores.push_back(num);
    }

    //verify that the scores were stored correctly:
    for (int i = 0; i < scores.size(); ++i) {
        incomes[i]=scores[i];
    }

    double cvbandwidth = secantmethod(cvobj,silverman,0.000001,100);

    cout << setprecision(10) << cvbandwidth << endl;


    return 0;
}

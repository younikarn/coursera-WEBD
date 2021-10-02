#include <iostream>
using namespace std;
int main()
{
    int w,x, i, j, k, sum;
    cout << "Enter the no of rows and columns of array 1: " <<endl;
    cin >> w >>x;
    int a[w][x];
    int y,z;
     cout << "Enter the no of rows and columns of array 2: " <<endl;
    cin >> y >> z;
    int b[y][z];
    cout << "Enter the values of matrix 1:" << endl;
    for(i=0;i<w;i++)
    {
        for(j=0;j<x;j++)
        {
           cin >> a[i][j];
        }
    }

    cout << " Enter the values of matrix 2" << endl;
    for(i=0;i<y;i++)
    {
        for(j=0;j<z;j++)
        {
           cin >> b[i][j];
        }
    }
     int c[w][z];
    if(x!=y)
    {
        cout << "These matrices cannot be multiplied." << endl;
    }
    else
    {
    for(i=0;i<w;i++)
    {
        for(j=0;j<z;j++)
        {
            sum=0;
           for(k=0;k<x;k++)
           {
               sum=sum+a[i][k]*b[k][j];
           }
           c[i][j]=sum;
        }
    }
    cout<<"The new matrix is"<<endl;
    for(i=0;i<w;i++)
    {
        for(j=0;j<z;j++)
           cout<<" " <<c[i][j];
           cout<<"\n";
    }


}
}

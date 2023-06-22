#include <stdio.h> 
#include <stdlib.h>
#include <assert.h>
void next_greater(long long* A,long long* B,int n);  
int main()
{
    int n;
    scanf("%d", &n);
    long long A[n],B[n];
    for (int i = 0; i < n; i++)
    {
        scanf("%lld", &A[i]);
        
    }
    next_greater( A,B,n);
    for (int i = 0; i < n; i++)
    {
        printf("%lld ", B[i]);
    }
    printf("\n");
    return 0;
}
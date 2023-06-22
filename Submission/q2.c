#include <stdio.h>
long long equal_halfsum(int n,int diff);
/*int equal_halfsum(int n, int diff)
{
    if (diff > 0)
    {
        if (diff > n)
            return 0;
    }
    if (diff < 0)
    {
        if ((-1 * diff) > n)
            return 0;
    }
    if (n == 1 && diff == 0)
        return 2;
    if (n == 1 &&(diff==1||diff==-1))
        return 1;
    int res = equal_halfsum(n - 1, diff + 1) +2 *equal_halfsum(n - 1, diff) +equal_halfsum(n - 1, diff - 1);
    return res;
}
int count(int n)
{
    return (equal_halfsum(n,0));
}
*/

int main()
{
    int n;
    long long k = 0;
    scanf("%d", &n);
    k = equal_halfsum(n,0);
    printf("%lld\n", k);
    return 0;
}

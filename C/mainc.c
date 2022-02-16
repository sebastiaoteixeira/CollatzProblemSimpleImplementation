#include <stdio.h>

int main() {
    unsigned int x;
    for (unsigned int i = 1; i < 0xffffffff; i++){
        x = i;
        while(x != 1){
            if (x % 2 == 0){
                x /= 2;
            } else {
                x *= 3;
                x += 1;
            }

            if (x < i && i % 100000 == 0){
                printf("%d\n", i);
                break;
            }
        }
    }

    return 0;
}

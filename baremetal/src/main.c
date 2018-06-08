
static volatile int cnt = 0;
static volatile int cnt2 = 5;


void mainfunc() {
    int val = cnt+cnt2;

    while(1) {
        val++;
    }
}
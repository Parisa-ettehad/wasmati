void *malloc(unsigned long size);
void free(void *ptr);


void use(int *p) {
    *p = 42;
}

void bad() {
    int *v1 = (int *)malloc(5 * sizeof(int));
    free(v1);
    use(v1);   // ❌ UAF
}

void good() {
    int *v1 = (int *)malloc(5 * sizeof(int));
    use(v1);
    free(v1);  // ✅ safe
}

void good_different_pointer() {
    int *v1 = (int *)malloc(5 * sizeof(int));
    int *v2 = (int *)malloc(5 * sizeof(int));

    free(v1);
    use(v2);   // ✅ safe (different pointer)
    free(v2);
}

void good_stack_pointer() {
    int x = 5;
    int *v1 = (int *)malloc(5 * sizeof(int));

    free(v1);
    use(&x);   // ✅ safe (not heap pointer)
}
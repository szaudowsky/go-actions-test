package main

import (
	"fmt"
	"testing"
)

func TestSum(t *testing.T) {
	var tests = []struct {
		a, b int
		want int
	}{
		{
			a:    1,
			b:    2,
			want: 3,
		},
		{
			a:    2,
			b:    2,
			want: 4,
		},
	}

	for _, tt := range tests {
		testname := fmt.Sprintf("a: %d b: %d want: %d", tt.a, tt.b, tt.want)
		t.Run(testname, func(t *testing.T) {
			sum := add(tt.a, tt.b)
			if sum != tt.want {
				t.Errorf("got: %d want: %d", sum, tt.want)
			}
		})
	}
}

module HazardDetectionUnit(Flush, pcsrc, takenbranch);
output Flush;
input pcsrc, takenbranch;

// implementation details are left to the student……
OR o1(Flush, pcsrc, takenbranch);

endmodule

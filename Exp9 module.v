//Name:haz  
//ID:0191894


// No. Cycles (including reset)=_______________


////////////////////////////////////////////////////////////////

module HazardDetectionUnit(Flush, pcsrc, takenbranch);
output Flush;
input pcsrc, takenbranch;

// implementation details are left to the student……
OR o1(Flush, pcsrc, takenbranch);

endmodule

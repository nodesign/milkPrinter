void initKernnings() {
  kernTable.put("VA", -123);
  kernTable.put("P,", -139);
  kernTable.put("L”", -135); 
  kernTable.put("F.", -110 );
  kernTable.put("YA", -104 );
  kernTable.put("Te", -98);
  kernTable.put("AV", -97 );
  kernTable.put("Vr", -86 );
  kernTable.put("PA", -85 );
  kernTable.put("m”", -82 );
  kernTable.put("a”", -79 );
  kernTable.put("FA", -78 );
  kernTable.put("UA", -78 );
  kernTable.put("w.", -73);
  kernTable.put("Yt", -72 );
  kernTable.put("LT", -64 );
  kernTable.put("r,", -63 );
  kernTable.put("Xv", -54 );
  kernTable.put("Ku", -46 );
  kernTable.put("D,", -40 );
  kernTable.put("D”", -36 );
  kernTable.put("OA", -36);
  kernTable.put("Hv", -33 );
  kernTable.put("T:", -32 );
  kernTable.put("DY", -30 );
  kernTable.put("c”", -25 );
  kernTable.put("my", -23 );
  kernTable.put("Ru", -21 );
  kernTable.put("aj", -19 );
  kernTable.put("bv", -16);
  kernTable.put("Sp", -14 );
  kernTable.put("ro", -13 );
  kernTable.put("SR", -12 );
  kernTable.put("lp", -12 );
  kernTable.put("ot", -11 );
  kernTable.put("tt", -10 );
  kernTable.put("am", -9 );
  kernTable.put("fe", -9);
  kernTable.put("vo", -8 );
  kernTable.put("xc", -8 );
  kernTable.put("yo", -8 );
  kernTable.put("Ix", -6 );
  kernTable.put("e,", -6 );
  kernTable.put("st", -5 );
  kernTable.put("he", -4 );
  kernTable.put("Fw", -3);
  kernTable.put("us", -3 );
  kernTable.put("Ak", 3 );
  kernTable.put("la", 40);
  kernTable.put("al", -10);
  kernTable.put("Oj", 5 );
  kernTable.put("il", 5 );
  kernTable.put("CO", 7 );
  kernTable.put("bc", 9 );
  kernTable.put("Xf", 10);
  kernTable.put("fr", 10 );
  kernTable.put("F”", 12 );
  kernTable.put("wb", 12 );
  kernTable.put("YW", 13 );
  kernTable.put("So", 14 );
  kernTable.put("Co", 15 );
  kernTable.put("VT", 16 );
  kernTable.put("cv", 16);
  kernTable.put("Dv", 17 );
  kernTable.put("OC", 18 );
  kernTable.put("Bc", 20 );
  kernTable.put("RX", 20 );
  kernTable.put("T”", 22 );
  kernTable.put("gy", 24 );
  kernTable.put("r:", 24 );
  kernTable.put("XA", 25);
  kernTable.put("ry", 29 );
  kernTable.put("w;", 31 );
  kernTable.put("f?", 76 );
  kernTable.put("f”", 121);
}

int getKerning(char firstLetter, char secondLetter) {
  String pair =  Character.toString(firstLetter) + Character.toString(secondLetter);
  int val = 0;
  try {
    val = kernTable.get(pair);
  } 
  catch (Exception e) {
  }

  return val;
}


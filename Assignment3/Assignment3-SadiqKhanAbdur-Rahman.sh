java -cp . Assignment3 -h
java -cp . Assignment3 -ln -sm
java -cp . Assignment3 -ln "" -sm 1
java -cp . Assignment3 -ln "%##$" -sm 1
java -cp . Assignment3 -ln "80 90" -sm 1
java -cp . Assignment3 -ln "80 90" -sm 2
java -cp . Assignment3 -ln "3;4;5" -sm 2
java -cp . Assignment3 -ln "2 3 5" 2
java -cp . Assignment3 -ln "80 90" -sm 3
java -cp . Assignment3 -ln "2.5 2.5 3.5 3.5" -sm 3
java -cp . Assignment3 -ln ".5 +3 0.5 1.5" -sm 3
java -cp . Assignment3 -ln "1 1.0 2 2.0 3.0" -sm 3
java -cp . Assignment3 -ln "3 7 11 13 17 19 23 27 37 43 47" -sm 4
java -cp . Assignment3 -ln "3 4 5" -sm 5
java -cp . Assignment3 -im
java -cp . Assignment3 -ln "trash 7 !!! 8.5 begin" -sm 5
java -cp . Assignment3 -sm 6
(echo "1 2 3" && echo "1") | java -cp . Assignment3 -im
java -cp . Assignment3 -ln "3 7 11 13 17 19 23 27 37 43 47" -sm 6
java -cp . Assignment3 -ln "3 4 5" -sm 7
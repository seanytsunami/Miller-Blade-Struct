 system "rm -rf GNUPLOT"
 system "mkdir GNUPLOT"
 set terminal png transparent nocrop enhanced font 
 arial 14 size 600,600 linewidth 1.75
 set style line 2 lc rgb 'red'
 reset
 set style line 2 lc rgb 'red'

 #  Blade Planform
 set output './GNUPLOT/chord_vs_r.png'
 set xlabel "r / R"
 set ylabel "Chord / R"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.5,0.1,0.5
 set mytics 2
 plot [0.0:1.0] [-0.5:0.5] 
 "XTurb_gnuplot_data.plt" using 1:2 notitle with lines,"XTurb_gnuplot_data.plt" using 1:3 notitle with lines
  ls 2

 #  Blade Twist
 set output './GNUPLOT/twist_vs_r.png'
 set xlabel "r / R"
 set ylabel "Blade Twist [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,5.0,60.0
 set mytics 5
 plot [0.0:1.0] [0.0:60.0] 
 "XTurb_gnuplot_data.plt" using 1:4 notitle with lines

 #  Blade Polar
 set output './GNUPLOT/lift_vs_r.png'
 set xlabel "r / R"
 set ylabel "Coefficient of Lift, C_{l}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,2.5
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set mytics 5
 plot [0.0:1.0] [0.0:2.5] "XTurb_gnuplot_data.plt" using 1:7 
 title "C_{l}" with lines

 set output './GNUPLOT/finesse_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Finesse, C_{l}/C_{d}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,20.0,180.0
 set mytics 4
 plot [0.0:1.0] [0.0:180] "XTurb_gnuplot_data.plt" using 1:9 
 title "C_{l}/C_{d}" with lines

 #  Flow Angles
 set output './GNUPLOT/angles_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Angle of Attack, {/Symbol a} [deg]   Local Flow Angle, {/Symbol f} [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,10.0,90.0
 set mytics 2
 plot [0.0:1.0] [0.0:90.0] "XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" with lines,"XTurb_gnuplot_data.plt" using 1:6 
 title "{/Symbol f}" with lines

 #  Equivalent Blade Circulation
 set output './GNUPLOT/gamma_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.1,0.05,0.2
 set ytics add ( "0.00" 0.0)
 set ytics add ( "0.10" 0.1)
 set ytics add ( "0.20" 0.2)
 set mytics 5
 plot [0.0:1.0] [-0.1:0.2] "XTurb_gnuplot_data.plt" using 1:10 
 notitle with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" with points

 # Circulation vs Angle of Attack
 set output './GNUPLOT/gamma_and_aoa.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set y2label "Local Angle of Attack, {/Symbol a} [deg]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.1,0.05,0.2
 set yrange [-0.1:0.2]
 set ytics add ( "0.00" 0.0)
 set mytics 5
 set y2tics 0.0,5.0,45.0
 set y2range [0.0:45.0]
 set my2tics 2
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:10 
 notitle axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" axes x1y2 with lines

 #  Equivalent Induction Factors
 set output './GNUPLOT/inductfact_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Induction Factors, a & a'"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.5,0.1,0.5
 set ytics add ( "0.0" 0.0)
 set mytics 5
 plot [0.0:1.0] [-0.5:0.5] "XTurb_gnuplot_data.plt" using 1:11 
 title "a " with lines,"XTurb_gnuplot_data.plt" using 1:12 
 title "a'" with lines

 #  Normal/Tangential Force Coeff.
 set output './GNUPLOT/CnCt_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Normal Force Coefficient, C_{n}"
 set y2label "Tangential Force Coefficient, C_{t}"
 set yrange [0.0:3.0]
 set y2range [-0.5:1.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -0.5,0.25,1.5
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set y2tics add ( " 1.00" 1.0)
 set y2tics add ( " 1.50" 1.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:13 
 title "C_{n}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:14 
 title "C_{t}" axes x1y2 with lines

 #  Thrust/Torque Coeff.
 set output './GNUPLOT/CthCto_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust Coefficient, C_{th} & C_{th,visc.}"
 set y2label "Torque Coefficient, C_{to} & C_{to,visc.}"
 set yrange [0.0:3.0]
 set y2range [-1.5:0.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -1.5,0.25,0.5
 set y2tics add ( "-1.50" -1.5)
 set y2tics add ( "-1.00" -1.0)
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:15 
 title "C_{th}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:16 
 title "C_{th,visc.}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:17 
 title "C_{to}" axes x1y2 with lines,"XTurb_gnuplot_data.plt" using 1:18 
 title "C_{to,visc.}" axes x1y2 with lines

 #  Thrust/Torque per Unit Span
 set output './GNUPLOT/ThTo_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust per Unit Span, Th'  [N/m / (V_{0}^{2}R)]"
 set y2label "Torque per Unit Span, To'  [Nm/m / (V_{0}^{2}R^{2})]"
 set yrange [0.0:1.0]
 set y2range [-0.25:0.25]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.1,1.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set mytics 5
 set y2tics -0.25,0.05,0.25
 set y2tics add ( "-0.20" -0.2)
 set y2tics add ( "-0.10" -0.1)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.10" 0.1)
 set y2tics add ( " 0.20" 0.2)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:19 
 title "Th'" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:20 
 title "To'" axes x1y2 with lines
 reset
 set style line 2 lc rgb 'red'

 #  Blade Planform
 set output './GNUPLOT/chord_vs_r.png'
 set xlabel "r / R"
 set ylabel "Chord / R"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.5,0.1,0.5
 set mytics 2
 plot [0.0:1.0] [-0.5:0.5] 
 "XTurb_gnuplot_data.plt" using 1:2 notitle with lines,"XTurb_gnuplot_data.plt" using 1:3 notitle with lines
  ls 2

 #  Blade Twist
 set output './GNUPLOT/twist_vs_r.png'
 set xlabel "r / R"
 set ylabel "Blade Twist [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,5.0,60.0
 set mytics 5
 plot [0.0:1.0] [0.0:60.0] 
 "XTurb_gnuplot_data.plt" using 1:4 notitle with lines

 #  Blade Polar
 set output './GNUPLOT/lift_vs_r.png'
 set xlabel "r / R"
 set ylabel "Coefficient of Lift, C_{l}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,2.5
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set mytics 5
 plot [0.0:1.0] [0.0:2.5] "XTurb_gnuplot_data.plt" using 1:7 
 title "C_{l}" with lines

 set output './GNUPLOT/finesse_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Finesse, C_{l}/C_{d}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,20.0,180.0
 set mytics 4
 plot [0.0:1.0] [0.0:180] "XTurb_gnuplot_data.plt" using 1:9 
 title "C_{l}/C_{d}" with lines

 #  Flow Angles
 set output './GNUPLOT/angles_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Angle of Attack, {/Symbol a} [deg]   Local Flow Angle, {/Symbol f} [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,10.0,90.0
 set mytics 2
 plot [0.0:1.0] [0.0:90.0] "XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" with lines,"XTurb_gnuplot_data.plt" using 1:6 
 title "{/Symbol f}" with lines

 #  Equivalent Blade Circulation
 set output './GNUPLOT/gamma_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.1,0.05,0.2
 set ytics add ( "0.00" 0.0)
 set ytics add ( "0.10" 0.1)
 set ytics add ( "0.20" 0.2)
 set mytics 5
 plot [0.0:1.0] [-0.1:0.2] "XTurb_gnuplot_data.plt" using 1:10 
 notitle with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" with points

 # Circulation vs Angle of Attack
 set output './GNUPLOT/gamma_and_aoa.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set y2label "Local Angle of Attack, {/Symbol a} [deg]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.1,0.05,0.2
 set yrange [-0.1:0.2]
 set ytics add ( "0.00" 0.0)
 set mytics 5
 set y2tics 0.0,5.0,45.0
 set y2range [0.0:45.0]
 set my2tics 2
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:10 
 notitle axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" axes x1y2 with lines

 #  Equivalent Induction Factors
 set output './GNUPLOT/inductfact_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Induction Factors, a & a'"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.5,0.1,0.5
 set ytics add ( "0.0" 0.0)
 set mytics 5
 plot [0.0:1.0] [-0.5:0.5] "XTurb_gnuplot_data.plt" using 1:11 
 title "a " with lines,"XTurb_gnuplot_data.plt" using 1:12 
 title "a'" with lines

 #  Normal/Tangential Force Coeff.
 set output './GNUPLOT/CnCt_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Normal Force Coefficient, C_{n}"
 set y2label "Tangential Force Coefficient, C_{t}"
 set yrange [0.0:3.0]
 set y2range [-0.5:1.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -0.5,0.25,1.5
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set y2tics add ( " 1.00" 1.0)
 set y2tics add ( " 1.50" 1.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:13 
 title "C_{n}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:14 
 title "C_{t}" axes x1y2 with lines

 #  Thrust/Torque Coeff.
 set output './GNUPLOT/CthCto_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust Coefficient, C_{th} & C_{th,visc.}"
 set y2label "Torque Coefficient, C_{to} & C_{to,visc.}"
 set yrange [0.0:3.0]
 set y2range [-1.5:0.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -1.5,0.25,0.5
 set y2tics add ( "-1.50" -1.5)
 set y2tics add ( "-1.00" -1.0)
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:15 
 title "C_{th}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:16 
 title "C_{th,visc.}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:17 
 title "C_{to}" axes x1y2 with lines,"XTurb_gnuplot_data.plt" using 1:18 
 title "C_{to,visc.}" axes x1y2 with lines

 #  Thrust/Torque per Unit Span
 set output './GNUPLOT/ThTo_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust per Unit Span, Th'  [N/m / (V_{0}^{2}R)]"
 set y2label "Torque per Unit Span, To'  [Nm/m / (V_{0}^{2}R^{2})]"
 set yrange [0.0:1.0]
 set y2range [-0.25:0.25]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.1,1.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set mytics 5
 set y2tics -0.25,0.05,0.25
 set y2tics add ( "-0.20" -0.2)
 set y2tics add ( "-0.10" -0.1)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.10" 0.1)
 set y2tics add ( " 0.20" 0.2)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:19 
 title "Th'" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:20 
 title "To'" axes x1y2 with lines
 reset
 set style line 2 lc rgb 'red'

 #  Blade Planform
 set output './GNUPLOT/chord_vs_r.png'
 set xlabel "r / R"
 set ylabel "Chord / R"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.5,0.1,0.5
 set mytics 2
 plot [0.0:1.0] [-0.5:0.5] 
 "XTurb_gnuplot_data.plt" using 1:2 notitle with lines,"XTurb_gnuplot_data.plt" using 1:3 notitle with lines
  ls 2

 #  Blade Twist
 set output './GNUPLOT/twist_vs_r.png'
 set xlabel "r / R"
 set ylabel "Blade Twist [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,5.0,60.0
 set mytics 5
 plot [0.0:1.0] [0.0:60.0] 
 "XTurb_gnuplot_data.plt" using 1:4 notitle with lines

 #  Blade Polar
 set output './GNUPLOT/lift_vs_r.png'
 set xlabel "r / R"
 set ylabel "Coefficient of Lift, C_{l}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,2.5
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set mytics 5
 plot [0.0:1.0] [0.0:2.5] "XTurb_gnuplot_data.plt" using 1:7 
 title "C_{l}" with lines

 set output './GNUPLOT/finesse_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Finesse, C_{l}/C_{d}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,20.0,180.0
 set mytics 4
 plot [0.0:1.0] [0.0:180] "XTurb_gnuplot_data.plt" using 1:9 
 title "C_{l}/C_{d}" with lines

 #  Flow Angles
 set output './GNUPLOT/angles_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Angle of Attack, {/Symbol a} [deg]   Local Flow Angle, {/Symbol f} [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,10.0,90.0
 set mytics 2
 plot [0.0:1.0] [0.0:90.0] "XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" with lines,"XTurb_gnuplot_data.plt" using 1:6 
 title "{/Symbol f}" with lines

 #  Equivalent Blade Circulation
 set output './GNUPLOT/gamma_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.1,0.05,0.2
 set ytics add ( "0.00" 0.0)
 set ytics add ( "0.10" 0.1)
 set ytics add ( "0.20" 0.2)
 set mytics 5
 plot [0.0:1.0] [-0.1:0.2] "XTurb_gnuplot_data.plt" using 1:10 
 notitle with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" with points

 # Circulation vs Angle of Attack
 set output './GNUPLOT/gamma_and_aoa.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set y2label "Local Angle of Attack, {/Symbol a} [deg]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.1,0.05,0.2
 set yrange [-0.1:0.2]
 set ytics add ( "0.00" 0.0)
 set mytics 5
 set y2tics 0.0,5.0,45.0
 set y2range [0.0:45.0]
 set my2tics 2
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:10 
 notitle axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" axes x1y2 with lines

 #  Equivalent Induction Factors
 set output './GNUPLOT/inductfact_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Induction Factors, a & a'"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.5,0.1,0.5
 set ytics add ( "0.0" 0.0)
 set mytics 5
 plot [0.0:1.0] [-0.5:0.5] "XTurb_gnuplot_data.plt" using 1:11 
 title "a " with lines,"XTurb_gnuplot_data.plt" using 1:12 
 title "a'" with lines

 #  Normal/Tangential Force Coeff.
 set output './GNUPLOT/CnCt_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Normal Force Coefficient, C_{n}"
 set y2label "Tangential Force Coefficient, C_{t}"
 set yrange [0.0:3.0]
 set y2range [-0.5:1.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -0.5,0.25,1.5
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set y2tics add ( " 1.00" 1.0)
 set y2tics add ( " 1.50" 1.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:13 
 title "C_{n}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:14 
 title "C_{t}" axes x1y2 with lines

 #  Thrust/Torque Coeff.
 set output './GNUPLOT/CthCto_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust Coefficient, C_{th} & C_{th,visc.}"
 set y2label "Torque Coefficient, C_{to} & C_{to,visc.}"
 set yrange [0.0:3.0]
 set y2range [-1.5:0.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -1.5,0.25,0.5
 set y2tics add ( "-1.50" -1.5)
 set y2tics add ( "-1.00" -1.0)
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:15 
 title "C_{th}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:16 
 title "C_{th,visc.}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:17 
 title "C_{to}" axes x1y2 with lines,"XTurb_gnuplot_data.plt" using 1:18 
 title "C_{to,visc.}" axes x1y2 with lines

 #  Thrust/Torque per Unit Span
 set output './GNUPLOT/ThTo_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust per Unit Span, Th'  [N/m / (V_{0}^{2}R)]"
 set y2label "Torque per Unit Span, To'  [Nm/m / (V_{0}^{2}R^{2})]"
 set yrange [0.0:1.0]
 set y2range [-0.25:0.25]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.1,1.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set mytics 5
 set y2tics -0.25,0.05,0.25
 set y2tics add ( "-0.20" -0.2)
 set y2tics add ( "-0.10" -0.1)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.10" 0.1)
 set y2tics add ( " 0.20" 0.2)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:19 
 title "Th'" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:20 
 title "To'" axes x1y2 with lines
 reset
 set style line 2 lc rgb 'red'

 #  Blade Planform
 set output './GNUPLOT/chord_vs_r.png'
 set xlabel "r / R"
 set ylabel "Chord / R"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.5,0.1,0.5
 set mytics 2
 plot [0.0:1.0] [-0.5:0.5] 
 "XTurb_gnuplot_data.plt" using 1:2 notitle with lines,"XTurb_gnuplot_data.plt" using 1:3 notitle with lines
  ls 2

 #  Blade Twist
 set output './GNUPLOT/twist_vs_r.png'
 set xlabel "r / R"
 set ylabel "Blade Twist [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,5.0,60.0
 set mytics 5
 plot [0.0:1.0] [0.0:60.0] 
 "XTurb_gnuplot_data.plt" using 1:4 notitle with lines

 #  Blade Polar
 set output './GNUPLOT/lift_vs_r.png'
 set xlabel "r / R"
 set ylabel "Coefficient of Lift, C_{l}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,2.5
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set mytics 5
 plot [0.0:1.0] [0.0:2.5] "XTurb_gnuplot_data.plt" using 1:7 
 title "C_{l}" with lines

 set output './GNUPLOT/finesse_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Finesse, C_{l}/C_{d}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,20.0,180.0
 set mytics 4
 plot [0.0:1.0] [0.0:180] "XTurb_gnuplot_data.plt" using 1:9 
 title "C_{l}/C_{d}" with lines

 #  Flow Angles
 set output './GNUPLOT/angles_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Angle of Attack, {/Symbol a} [deg]   Local Flow Angle, {/Symbol f} [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,10.0,90.0
 set mytics 2
 plot [0.0:1.0] [0.0:90.0] "XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" with lines,"XTurb_gnuplot_data.plt" using 1:6 
 title "{/Symbol f}" with lines

 #  Equivalent Blade Circulation
 set output './GNUPLOT/gamma_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.1,0.05,0.2
 set ytics add ( "0.00" 0.0)
 set ytics add ( "0.10" 0.1)
 set ytics add ( "0.20" 0.2)
 set mytics 5
 plot [0.0:1.0] [-0.1:0.2] "XTurb_gnuplot_data.plt" using 1:10 
 notitle with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" with points

 # Circulation vs Angle of Attack
 set output './GNUPLOT/gamma_and_aoa.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set y2label "Local Angle of Attack, {/Symbol a} [deg]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.1,0.05,0.2
 set yrange [-0.1:0.2]
 set ytics add ( "0.00" 0.0)
 set mytics 5
 set y2tics 0.0,5.0,45.0
 set y2range [0.0:45.0]
 set my2tics 2
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:10 
 notitle axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" axes x1y2 with lines

 #  Equivalent Induction Factors
 set output './GNUPLOT/inductfact_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Induction Factors, a & a'"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.5,0.1,0.5
 set ytics add ( "0.0" 0.0)
 set mytics 5
 plot [0.0:1.0] [-0.5:0.5] "XTurb_gnuplot_data.plt" using 1:11 
 title "a " with lines,"XTurb_gnuplot_data.plt" using 1:12 
 title "a'" with lines

 #  Normal/Tangential Force Coeff.
 set output './GNUPLOT/CnCt_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Normal Force Coefficient, C_{n}"
 set y2label "Tangential Force Coefficient, C_{t}"
 set yrange [0.0:3.0]
 set y2range [-0.5:1.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -0.5,0.25,1.5
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set y2tics add ( " 1.00" 1.0)
 set y2tics add ( " 1.50" 1.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:13 
 title "C_{n}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:14 
 title "C_{t}" axes x1y2 with lines

 #  Thrust/Torque Coeff.
 set output './GNUPLOT/CthCto_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust Coefficient, C_{th} & C_{th,visc.}"
 set y2label "Torque Coefficient, C_{to} & C_{to,visc.}"
 set yrange [0.0:3.0]
 set y2range [-1.5:0.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -1.5,0.25,0.5
 set y2tics add ( "-1.50" -1.5)
 set y2tics add ( "-1.00" -1.0)
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:15 
 title "C_{th}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:16 
 title "C_{th,visc.}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:17 
 title "C_{to}" axes x1y2 with lines,"XTurb_gnuplot_data.plt" using 1:18 
 title "C_{to,visc.}" axes x1y2 with lines

 #  Thrust/Torque per Unit Span
 set output './GNUPLOT/ThTo_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust per Unit Span, Th'  [N/m / (V_{0}^{2}R)]"
 set y2label "Torque per Unit Span, To'  [Nm/m / (V_{0}^{2}R^{2})]"
 set yrange [0.0:1.0]
 set y2range [-0.25:0.25]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.1,1.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set mytics 5
 set y2tics -0.25,0.05,0.25
 set y2tics add ( "-0.20" -0.2)
 set y2tics add ( "-0.10" -0.1)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.10" 0.1)
 set y2tics add ( " 0.20" 0.2)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:19 
 title "Th'" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:20 
 title "To'" axes x1y2 with lines
 reset
 set style line 2 lc rgb 'red'

 #  Blade Planform
 set output './GNUPLOT/chord_vs_r.png'
 set xlabel "r / R"
 set ylabel "Chord / R"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.5,0.1,0.5
 set mytics 2
 plot [0.0:1.0] [-0.5:0.5] 
 "XTurb_gnuplot_data.plt" using 1:2 notitle with lines,"XTurb_gnuplot_data.plt" using 1:3 notitle with lines
  ls 2

 #  Blade Twist
 set output './GNUPLOT/twist_vs_r.png'
 set xlabel "r / R"
 set ylabel "Blade Twist [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,5.0,60.0
 set mytics 5
 plot [0.0:1.0] [0.0:60.0] 
 "XTurb_gnuplot_data.plt" using 1:4 notitle with lines

 #  Blade Polar
 set output './GNUPLOT/lift_vs_r.png'
 set xlabel "r / R"
 set ylabel "Coefficient of Lift, C_{l}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,2.5
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set mytics 5
 plot [0.0:1.0] [0.0:2.5] "XTurb_gnuplot_data.plt" using 1:7 
 title "C_{l}" with lines

 set output './GNUPLOT/finesse_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Finesse, C_{l}/C_{d}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,20.0,180.0
 set mytics 4
 plot [0.0:1.0] [0.0:180] "XTurb_gnuplot_data.plt" using 1:9 
 title "C_{l}/C_{d}" with lines

 #  Flow Angles
 set output './GNUPLOT/angles_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Angle of Attack, {/Symbol a} [deg]   Local Flow Angle, {/Symbol f} [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,10.0,90.0
 set mytics 2
 plot [0.0:1.0] [0.0:90.0] "XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" with lines,"XTurb_gnuplot_data.plt" using 1:6 
 title "{/Symbol f}" with lines

 #  Equivalent Blade Circulation
 set output './GNUPLOT/gamma_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.1,0.05,0.2
 set ytics add ( "0.00" 0.0)
 set ytics add ( "0.10" 0.1)
 set ytics add ( "0.20" 0.2)
 set mytics 5
 plot [0.0:1.0] [-0.1:0.2] "XTurb_gnuplot_data.plt" using 1:10 
 notitle with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" with points

 # Circulation vs Angle of Attack
 set output './GNUPLOT/gamma_and_aoa.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set y2label "Local Angle of Attack, {/Symbol a} [deg]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.1,0.05,0.2
 set yrange [-0.1:0.2]
 set ytics add ( "0.00" 0.0)
 set mytics 5
 set y2tics 0.0,5.0,45.0
 set y2range [0.0:45.0]
 set my2tics 2
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:10 
 notitle axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" axes x1y2 with lines

 #  Equivalent Induction Factors
 set output './GNUPLOT/inductfact_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Induction Factors, a & a'"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.5,0.1,0.5
 set ytics add ( "0.0" 0.0)
 set mytics 5
 plot [0.0:1.0] [-0.5:0.5] "XTurb_gnuplot_data.plt" using 1:11 
 title "a " with lines,"XTurb_gnuplot_data.plt" using 1:12 
 title "a'" with lines

 #  Normal/Tangential Force Coeff.
 set output './GNUPLOT/CnCt_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Normal Force Coefficient, C_{n}"
 set y2label "Tangential Force Coefficient, C_{t}"
 set yrange [0.0:3.0]
 set y2range [-0.5:1.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -0.5,0.25,1.5
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set y2tics add ( " 1.00" 1.0)
 set y2tics add ( " 1.50" 1.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:13 
 title "C_{n}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:14 
 title "C_{t}" axes x1y2 with lines

 #  Thrust/Torque Coeff.
 set output './GNUPLOT/CthCto_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust Coefficient, C_{th} & C_{th,visc.}"
 set y2label "Torque Coefficient, C_{to} & C_{to,visc.}"
 set yrange [0.0:3.0]
 set y2range [-1.5:0.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -1.5,0.25,0.5
 set y2tics add ( "-1.50" -1.5)
 set y2tics add ( "-1.00" -1.0)
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:15 
 title "C_{th}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:16 
 title "C_{th,visc.}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:17 
 title "C_{to}" axes x1y2 with lines,"XTurb_gnuplot_data.plt" using 1:18 
 title "C_{to,visc.}" axes x1y2 with lines

 #  Thrust/Torque per Unit Span
 set output './GNUPLOT/ThTo_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust per Unit Span, Th'  [N/m / (V_{0}^{2}R)]"
 set y2label "Torque per Unit Span, To'  [Nm/m / (V_{0}^{2}R^{2})]"
 set yrange [0.0:1.0]
 set y2range [-0.25:0.25]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.1,1.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set mytics 5
 set y2tics -0.25,0.05,0.25
 set y2tics add ( "-0.20" -0.2)
 set y2tics add ( "-0.10" -0.1)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.10" 0.1)
 set y2tics add ( " 0.20" 0.2)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:19 
 title "Th'" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:20 
 title "To'" axes x1y2 with lines
 reset
 set style line 2 lc rgb 'red'

 #  Blade Planform
 set output './GNUPLOT/chord_vs_r.png'
 set xlabel "r / R"
 set ylabel "Chord / R"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.5,0.1,0.5
 set mytics 2
 plot [0.0:1.0] [-0.5:0.5] 
 "XTurb_gnuplot_data.plt" using 1:2 notitle with lines,"XTurb_gnuplot_data.plt" using 1:3 notitle with lines
  ls 2

 #  Blade Twist
 set output './GNUPLOT/twist_vs_r.png'
 set xlabel "r / R"
 set ylabel "Blade Twist [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,5.0,60.0
 set mytics 5
 plot [0.0:1.0] [0.0:60.0] 
 "XTurb_gnuplot_data.plt" using 1:4 notitle with lines

 #  Blade Polar
 set output './GNUPLOT/lift_vs_r.png'
 set xlabel "r / R"
 set ylabel "Coefficient of Lift, C_{l}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,2.5
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set mytics 5
 plot [0.0:1.0] [0.0:2.5] "XTurb_gnuplot_data.plt" using 1:7 
 title "C_{l}" with lines

 set output './GNUPLOT/finesse_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Finesse, C_{l}/C_{d}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,20.0,180.0
 set mytics 4
 plot [0.0:1.0] [0.0:180] "XTurb_gnuplot_data.plt" using 1:9 
 title "C_{l}/C_{d}" with lines

 #  Flow Angles
 set output './GNUPLOT/angles_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Angle of Attack, {/Symbol a} [deg]   Local Flow Angle, {/Symbol f} [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,10.0,90.0
 set mytics 2
 plot [0.0:1.0] [0.0:90.0] "XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" with lines,"XTurb_gnuplot_data.plt" using 1:6 
 title "{/Symbol f}" with lines

 #  Equivalent Blade Circulation
 set output './GNUPLOT/gamma_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.1,0.05,0.2
 set ytics add ( "0.00" 0.0)
 set ytics add ( "0.10" 0.1)
 set ytics add ( "0.20" 0.2)
 set mytics 5
 plot [0.0:1.0] [-0.1:0.2] "XTurb_gnuplot_data.plt" using 1:10 
 notitle with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" with points

 # Circulation vs Angle of Attack
 set output './GNUPLOT/gamma_and_aoa.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set y2label "Local Angle of Attack, {/Symbol a} [deg]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.1,0.05,0.2
 set yrange [-0.1:0.2]
 set ytics add ( "0.00" 0.0)
 set mytics 5
 set y2tics 0.0,5.0,45.0
 set y2range [0.0:45.0]
 set my2tics 2
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:10 
 notitle axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" axes x1y2 with lines

 #  Equivalent Induction Factors
 set output './GNUPLOT/inductfact_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Induction Factors, a & a'"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.5,0.1,0.5
 set ytics add ( "0.0" 0.0)
 set mytics 5
 plot [0.0:1.0] [-0.5:0.5] "XTurb_gnuplot_data.plt" using 1:11 
 title "a " with lines,"XTurb_gnuplot_data.plt" using 1:12 
 title "a'" with lines

 #  Normal/Tangential Force Coeff.
 set output './GNUPLOT/CnCt_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Normal Force Coefficient, C_{n}"
 set y2label "Tangential Force Coefficient, C_{t}"
 set yrange [0.0:3.0]
 set y2range [-0.5:1.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -0.5,0.25,1.5
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set y2tics add ( " 1.00" 1.0)
 set y2tics add ( " 1.50" 1.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:13 
 title "C_{n}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:14 
 title "C_{t}" axes x1y2 with lines

 #  Thrust/Torque Coeff.
 set output './GNUPLOT/CthCto_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust Coefficient, C_{th} & C_{th,visc.}"
 set y2label "Torque Coefficient, C_{to} & C_{to,visc.}"
 set yrange [0.0:3.0]
 set y2range [-1.5:0.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -1.5,0.25,0.5
 set y2tics add ( "-1.50" -1.5)
 set y2tics add ( "-1.00" -1.0)
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:15 
 title "C_{th}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:16 
 title "C_{th,visc.}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:17 
 title "C_{to}" axes x1y2 with lines,"XTurb_gnuplot_data.plt" using 1:18 
 title "C_{to,visc.}" axes x1y2 with lines

 #  Thrust/Torque per Unit Span
 set output './GNUPLOT/ThTo_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust per Unit Span, Th'  [N/m / (V_{0}^{2}R)]"
 set y2label "Torque per Unit Span, To'  [Nm/m / (V_{0}^{2}R^{2})]"
 set yrange [0.0:1.0]
 set y2range [-0.25:0.25]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.1,1.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set mytics 5
 set y2tics -0.25,0.05,0.25
 set y2tics add ( "-0.20" -0.2)
 set y2tics add ( "-0.10" -0.1)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.10" 0.1)
 set y2tics add ( " 0.20" 0.2)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:19 
 title "Th'" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:20 
 title "To'" axes x1y2 with lines
 reset
 set style line 2 lc rgb 'red'

 #  Blade Planform
 set output './GNUPLOT/chord_vs_r.png'
 set xlabel "r / R"
 set ylabel "Chord / R"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.5,0.1,0.5
 set mytics 2
 plot [0.0:1.0] [-0.5:0.5] 
 "XTurb_gnuplot_data.plt" using 1:2 notitle with lines,"XTurb_gnuplot_data.plt" using 1:3 notitle with lines
  ls 2

 #  Blade Twist
 set output './GNUPLOT/twist_vs_r.png'
 set xlabel "r / R"
 set ylabel "Blade Twist [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,5.0,60.0
 set mytics 5
 plot [0.0:1.0] [0.0:60.0] 
 "XTurb_gnuplot_data.plt" using 1:4 notitle with lines

 #  Blade Polar
 set output './GNUPLOT/lift_vs_r.png'
 set xlabel "r / R"
 set ylabel "Coefficient of Lift, C_{l}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,2.5
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set mytics 5
 plot [0.0:1.0] [0.0:2.5] "XTurb_gnuplot_data.plt" using 1:7 
 title "C_{l}" with lines

 set output './GNUPLOT/finesse_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Finesse, C_{l}/C_{d}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,20.0,180.0
 set mytics 4
 plot [0.0:1.0] [0.0:180] "XTurb_gnuplot_data.plt" using 1:9 
 title "C_{l}/C_{d}" with lines

 #  Flow Angles
 set output './GNUPLOT/angles_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Angle of Attack, {/Symbol a} [deg]   Local Flow Angle, {/Symbol f} [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,10.0,90.0
 set mytics 2
 plot [0.0:1.0] [0.0:90.0] "XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" with lines,"XTurb_gnuplot_data.plt" using 1:6 
 title "{/Symbol f}" with lines

 #  Equivalent Blade Circulation
 set output './GNUPLOT/gamma_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.1,0.05,0.2
 set ytics add ( "0.00" 0.0)
 set ytics add ( "0.10" 0.1)
 set ytics add ( "0.20" 0.2)
 set mytics 5
 plot [0.0:1.0] [-0.1:0.2] "XTurb_gnuplot_data.plt" using 1:10 
 notitle with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" with points

 # Circulation vs Angle of Attack
 set output './GNUPLOT/gamma_and_aoa.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set y2label "Local Angle of Attack, {/Symbol a} [deg]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.1,0.05,0.2
 set yrange [-0.1:0.2]
 set ytics add ( "0.00" 0.0)
 set mytics 5
 set y2tics 0.0,5.0,45.0
 set y2range [0.0:45.0]
 set my2tics 2
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:10 
 notitle axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" axes x1y2 with lines

 #  Equivalent Induction Factors
 set output './GNUPLOT/inductfact_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Induction Factors, a & a'"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.5,0.1,0.5
 set ytics add ( "0.0" 0.0)
 set mytics 5
 plot [0.0:1.0] [-0.5:0.5] "XTurb_gnuplot_data.plt" using 1:11 
 title "a " with lines,"XTurb_gnuplot_data.plt" using 1:12 
 title "a'" with lines

 #  Normal/Tangential Force Coeff.
 set output './GNUPLOT/CnCt_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Normal Force Coefficient, C_{n}"
 set y2label "Tangential Force Coefficient, C_{t}"
 set yrange [0.0:3.0]
 set y2range [-0.5:1.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -0.5,0.25,1.5
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set y2tics add ( " 1.00" 1.0)
 set y2tics add ( " 1.50" 1.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:13 
 title "C_{n}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:14 
 title "C_{t}" axes x1y2 with lines

 #  Thrust/Torque Coeff.
 set output './GNUPLOT/CthCto_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust Coefficient, C_{th} & C_{th,visc.}"
 set y2label "Torque Coefficient, C_{to} & C_{to,visc.}"
 set yrange [0.0:3.0]
 set y2range [-1.5:0.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -1.5,0.25,0.5
 set y2tics add ( "-1.50" -1.5)
 set y2tics add ( "-1.00" -1.0)
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:15 
 title "C_{th}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:16 
 title "C_{th,visc.}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:17 
 title "C_{to}" axes x1y2 with lines,"XTurb_gnuplot_data.plt" using 1:18 
 title "C_{to,visc.}" axes x1y2 with lines

 #  Thrust/Torque per Unit Span
 set output './GNUPLOT/ThTo_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust per Unit Span, Th'  [N/m / (V_{0}^{2}R)]"
 set y2label "Torque per Unit Span, To'  [Nm/m / (V_{0}^{2}R^{2})]"
 set yrange [0.0:1.0]
 set y2range [-0.25:0.25]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.1,1.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set mytics 5
 set y2tics -0.25,0.05,0.25
 set y2tics add ( "-0.20" -0.2)
 set y2tics add ( "-0.10" -0.1)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.10" 0.1)
 set y2tics add ( " 0.20" 0.2)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:19 
 title "Th'" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:20 
 title "To'" axes x1y2 with lines
 reset
 set style line 2 lc rgb 'red'

 #  Blade Planform
 set output './GNUPLOT/chord_vs_r.png'
 set xlabel "r / R"
 set ylabel "Chord / R"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.5,0.1,0.5
 set mytics 2
 plot [0.0:1.0] [-0.5:0.5] 
 "XTurb_gnuplot_data.plt" using 1:2 notitle with lines,"XTurb_gnuplot_data.plt" using 1:3 notitle with lines
  ls 2

 #  Blade Twist
 set output './GNUPLOT/twist_vs_r.png'
 set xlabel "r / R"
 set ylabel "Blade Twist [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,5.0,60.0
 set mytics 5
 plot [0.0:1.0] [0.0:60.0] 
 "XTurb_gnuplot_data.plt" using 1:4 notitle with lines

 #  Blade Polar
 set output './GNUPLOT/lift_vs_r.png'
 set xlabel "r / R"
 set ylabel "Coefficient of Lift, C_{l}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,2.5
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set mytics 5
 plot [0.0:1.0] [0.0:2.5] "XTurb_gnuplot_data.plt" using 1:7 
 title "C_{l}" with lines

 set output './GNUPLOT/finesse_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Finesse, C_{l}/C_{d}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,20.0,180.0
 set mytics 4
 plot [0.0:1.0] [0.0:180] "XTurb_gnuplot_data.plt" using 1:9 
 title "C_{l}/C_{d}" with lines

 #  Flow Angles
 set output './GNUPLOT/angles_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Angle of Attack, {/Symbol a} [deg]   Local Flow Angle, {/Symbol f} [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,10.0,90.0
 set mytics 2
 plot [0.0:1.0] [0.0:90.0] "XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" with lines,"XTurb_gnuplot_data.plt" using 1:6 
 title "{/Symbol f}" with lines

 #  Equivalent Blade Circulation
 set output './GNUPLOT/gamma_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.1,0.05,0.2
 set ytics add ( "0.00" 0.0)
 set ytics add ( "0.10" 0.1)
 set ytics add ( "0.20" 0.2)
 set mytics 5
 plot [0.0:1.0] [-0.1:0.2] "XTurb_gnuplot_data.plt" using 1:10 
 notitle with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" with points

 # Circulation vs Angle of Attack
 set output './GNUPLOT/gamma_and_aoa.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set y2label "Local Angle of Attack, {/Symbol a} [deg]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.1,0.05,0.2
 set yrange [-0.1:0.2]
 set ytics add ( "0.00" 0.0)
 set mytics 5
 set y2tics 0.0,5.0,45.0
 set y2range [0.0:45.0]
 set my2tics 2
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:10 
 notitle axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" axes x1y2 with lines

 #  Equivalent Induction Factors
 set output './GNUPLOT/inductfact_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Induction Factors, a & a'"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.5,0.1,0.5
 set ytics add ( "0.0" 0.0)
 set mytics 5
 plot [0.0:1.0] [-0.5:0.5] "XTurb_gnuplot_data.plt" using 1:11 
 title "a " with lines,"XTurb_gnuplot_data.plt" using 1:12 
 title "a'" with lines

 #  Normal/Tangential Force Coeff.
 set output './GNUPLOT/CnCt_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Normal Force Coefficient, C_{n}"
 set y2label "Tangential Force Coefficient, C_{t}"
 set yrange [0.0:3.0]
 set y2range [-0.5:1.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -0.5,0.25,1.5
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set y2tics add ( " 1.00" 1.0)
 set y2tics add ( " 1.50" 1.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:13 
 title "C_{n}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:14 
 title "C_{t}" axes x1y2 with lines

 #  Thrust/Torque Coeff.
 set output './GNUPLOT/CthCto_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust Coefficient, C_{th} & C_{th,visc.}"
 set y2label "Torque Coefficient, C_{to} & C_{to,visc.}"
 set yrange [0.0:3.0]
 set y2range [-1.5:0.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -1.5,0.25,0.5
 set y2tics add ( "-1.50" -1.5)
 set y2tics add ( "-1.00" -1.0)
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:15 
 title "C_{th}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:16 
 title "C_{th,visc.}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:17 
 title "C_{to}" axes x1y2 with lines,"XTurb_gnuplot_data.plt" using 1:18 
 title "C_{to,visc.}" axes x1y2 with lines

 #  Thrust/Torque per Unit Span
 set output './GNUPLOT/ThTo_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust per Unit Span, Th'  [N/m / (V_{0}^{2}R)]"
 set y2label "Torque per Unit Span, To'  [Nm/m / (V_{0}^{2}R^{2})]"
 set yrange [0.0:1.0]
 set y2range [-0.25:0.25]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.1,1.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set mytics 5
 set y2tics -0.25,0.05,0.25
 set y2tics add ( "-0.20" -0.2)
 set y2tics add ( "-0.10" -0.1)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.10" 0.1)
 set y2tics add ( " 0.20" 0.2)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:19 
 title "Th'" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:20 
 title "To'" axes x1y2 with lines
 reset
 set style line 2 lc rgb 'red'

 #  Blade Planform
 set output './GNUPLOT/chord_vs_r.png'
 set xlabel "r / R"
 set ylabel "Chord / R"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.5,0.1,0.5
 set mytics 2
 plot [0.0:1.0] [-0.5:0.5] 
 "XTurb_gnuplot_data.plt" using 1:2 notitle with lines,"XTurb_gnuplot_data.plt" using 1:3 notitle with lines
  ls 2

 #  Blade Twist
 set output './GNUPLOT/twist_vs_r.png'
 set xlabel "r / R"
 set ylabel "Blade Twist [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,5.0,60.0
 set mytics 5
 plot [0.0:1.0] [0.0:60.0] 
 "XTurb_gnuplot_data.plt" using 1:4 notitle with lines

 #  Blade Polar
 set output './GNUPLOT/lift_vs_r.png'
 set xlabel "r / R"
 set ylabel "Coefficient of Lift, C_{l}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,2.5
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set mytics 5
 plot [0.0:1.0] [0.0:2.5] "XTurb_gnuplot_data.plt" using 1:7 
 title "C_{l}" with lines

 set output './GNUPLOT/finesse_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Finesse, C_{l}/C_{d}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,20.0,180.0
 set mytics 4
 plot [0.0:1.0] [0.0:180] "XTurb_gnuplot_data.plt" using 1:9 
 title "C_{l}/C_{d}" with lines

 #  Flow Angles
 set output './GNUPLOT/angles_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Angle of Attack, {/Symbol a} [deg]   Local Flow Angle, {/Symbol f} [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,10.0,90.0
 set mytics 2
 plot [0.0:1.0] [0.0:90.0] "XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" with lines,"XTurb_gnuplot_data.plt" using 1:6 
 title "{/Symbol f}" with lines

 #  Equivalent Blade Circulation
 set output './GNUPLOT/gamma_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.1,0.05,0.2
 set ytics add ( "0.00" 0.0)
 set ytics add ( "0.10" 0.1)
 set ytics add ( "0.20" 0.2)
 set mytics 5
 plot [0.0:1.0] [-0.1:0.2] "XTurb_gnuplot_data.plt" using 1:10 
 notitle with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" with points

 # Circulation vs Angle of Attack
 set output './GNUPLOT/gamma_and_aoa.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set y2label "Local Angle of Attack, {/Symbol a} [deg]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.1,0.05,0.2
 set yrange [-0.1:0.2]
 set ytics add ( "0.00" 0.0)
 set mytics 5
 set y2tics 0.0,5.0,45.0
 set y2range [0.0:45.0]
 set my2tics 2
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:10 
 notitle axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" axes x1y2 with lines

 #  Equivalent Induction Factors
 set output './GNUPLOT/inductfact_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Induction Factors, a & a'"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.5,0.1,0.5
 set ytics add ( "0.0" 0.0)
 set mytics 5
 plot [0.0:1.0] [-0.5:0.5] "XTurb_gnuplot_data.plt" using 1:11 
 title "a " with lines,"XTurb_gnuplot_data.plt" using 1:12 
 title "a'" with lines

 #  Normal/Tangential Force Coeff.
 set output './GNUPLOT/CnCt_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Normal Force Coefficient, C_{n}"
 set y2label "Tangential Force Coefficient, C_{t}"
 set yrange [0.0:3.0]
 set y2range [-0.5:1.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -0.5,0.25,1.5
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set y2tics add ( " 1.00" 1.0)
 set y2tics add ( " 1.50" 1.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:13 
 title "C_{n}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:14 
 title "C_{t}" axes x1y2 with lines

 #  Thrust/Torque Coeff.
 set output './GNUPLOT/CthCto_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust Coefficient, C_{th} & C_{th,visc.}"
 set y2label "Torque Coefficient, C_{to} & C_{to,visc.}"
 set yrange [0.0:3.0]
 set y2range [-1.5:0.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -1.5,0.25,0.5
 set y2tics add ( "-1.50" -1.5)
 set y2tics add ( "-1.00" -1.0)
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:15 
 title "C_{th}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:16 
 title "C_{th,visc.}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:17 
 title "C_{to}" axes x1y2 with lines,"XTurb_gnuplot_data.plt" using 1:18 
 title "C_{to,visc.}" axes x1y2 with lines

 #  Thrust/Torque per Unit Span
 set output './GNUPLOT/ThTo_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust per Unit Span, Th'  [N/m / (V_{0}^{2}R)]"
 set y2label "Torque per Unit Span, To'  [Nm/m / (V_{0}^{2}R^{2})]"
 set yrange [0.0:1.0]
 set y2range [-0.25:0.25]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.1,1.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set mytics 5
 set y2tics -0.25,0.05,0.25
 set y2tics add ( "-0.20" -0.2)
 set y2tics add ( "-0.10" -0.1)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.10" 0.1)
 set y2tics add ( " 0.20" 0.2)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:19 
 title "Th'" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:20 
 title "To'" axes x1y2 with lines
 reset
 set style line 2 lc rgb 'red'

 #  Blade Planform
 set output './GNUPLOT/chord_vs_r.png'
 set xlabel "r / R"
 set ylabel "Chord / R"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.5,0.1,0.5
 set mytics 2
 plot [0.0:1.0] [-0.5:0.5] 
 "XTurb_gnuplot_data.plt" using 1:2 notitle with lines,"XTurb_gnuplot_data.plt" using 1:3 notitle with lines
  ls 2

 #  Blade Twist
 set output './GNUPLOT/twist_vs_r.png'
 set xlabel "r / R"
 set ylabel "Blade Twist [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,5.0,60.0
 set mytics 5
 plot [0.0:1.0] [0.0:60.0] 
 "XTurb_gnuplot_data.plt" using 1:4 notitle with lines

 #  Blade Polar
 set output './GNUPLOT/lift_vs_r.png'
 set xlabel "r / R"
 set ylabel "Coefficient of Lift, C_{l}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,2.5
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set mytics 5
 plot [0.0:1.0] [0.0:2.5] "XTurb_gnuplot_data.plt" using 1:7 
 title "C_{l}" with lines

 set output './GNUPLOT/finesse_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Finesse, C_{l}/C_{d}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,20.0,180.0
 set mytics 4
 plot [0.0:1.0] [0.0:180] "XTurb_gnuplot_data.plt" using 1:9 
 title "C_{l}/C_{d}" with lines

 #  Flow Angles
 set output './GNUPLOT/angles_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Angle of Attack, {/Symbol a} [deg]   Local Flow Angle, {/Symbol f} [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,10.0,90.0
 set mytics 2
 plot [0.0:1.0] [0.0:90.0] "XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" with lines,"XTurb_gnuplot_data.plt" using 1:6 
 title "{/Symbol f}" with lines

 #  Equivalent Blade Circulation
 set output './GNUPLOT/gamma_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.1,0.05,0.2
 set ytics add ( "0.00" 0.0)
 set ytics add ( "0.10" 0.1)
 set ytics add ( "0.20" 0.2)
 set mytics 5
 plot [0.0:1.0] [-0.1:0.2] "XTurb_gnuplot_data.plt" using 1:10 
 notitle with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" with points

 # Circulation vs Angle of Attack
 set output './GNUPLOT/gamma_and_aoa.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set y2label "Local Angle of Attack, {/Symbol a} [deg]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.1,0.05,0.2
 set yrange [-0.1:0.2]
 set ytics add ( "0.00" 0.0)
 set mytics 5
 set y2tics 0.0,5.0,45.0
 set y2range [0.0:45.0]
 set my2tics 2
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:10 
 notitle axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" axes x1y2 with lines

 #  Equivalent Induction Factors
 set output './GNUPLOT/inductfact_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Induction Factors, a & a'"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.5,0.1,0.5
 set ytics add ( "0.0" 0.0)
 set mytics 5
 plot [0.0:1.0] [-0.5:0.5] "XTurb_gnuplot_data.plt" using 1:11 
 title "a " with lines,"XTurb_gnuplot_data.plt" using 1:12 
 title "a'" with lines

 #  Normal/Tangential Force Coeff.
 set output './GNUPLOT/CnCt_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Normal Force Coefficient, C_{n}"
 set y2label "Tangential Force Coefficient, C_{t}"
 set yrange [0.0:3.0]
 set y2range [-0.5:1.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -0.5,0.25,1.5
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set y2tics add ( " 1.00" 1.0)
 set y2tics add ( " 1.50" 1.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:13 
 title "C_{n}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:14 
 title "C_{t}" axes x1y2 with lines

 #  Thrust/Torque Coeff.
 set output './GNUPLOT/CthCto_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust Coefficient, C_{th} & C_{th,visc.}"
 set y2label "Torque Coefficient, C_{to} & C_{to,visc.}"
 set yrange [0.0:3.0]
 set y2range [-1.5:0.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -1.5,0.25,0.5
 set y2tics add ( "-1.50" -1.5)
 set y2tics add ( "-1.00" -1.0)
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:15 
 title "C_{th}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:16 
 title "C_{th,visc.}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:17 
 title "C_{to}" axes x1y2 with lines,"XTurb_gnuplot_data.plt" using 1:18 
 title "C_{to,visc.}" axes x1y2 with lines

 #  Thrust/Torque per Unit Span
 set output './GNUPLOT/ThTo_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust per Unit Span, Th'  [N/m / (V_{0}^{2}R)]"
 set y2label "Torque per Unit Span, To'  [Nm/m / (V_{0}^{2}R^{2})]"
 set yrange [0.0:1.0]
 set y2range [-0.25:0.25]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.1,1.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set mytics 5
 set y2tics -0.25,0.05,0.25
 set y2tics add ( "-0.20" -0.2)
 set y2tics add ( "-0.10" -0.1)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.10" 0.1)
 set y2tics add ( " 0.20" 0.2)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:19 
 title "Th'" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:20 
 title "To'" axes x1y2 with lines
 reset
 set style line 2 lc rgb 'red'

 #  Blade Planform
 set output './GNUPLOT/chord_vs_r.png'
 set xlabel "r / R"
 set ylabel "Chord / R"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.5,0.1,0.5
 set mytics 2
 plot [0.0:1.0] [-0.5:0.5] 
 "XTurb_gnuplot_data.plt" using 1:2 notitle with lines,"XTurb_gnuplot_data.plt" using 1:3 notitle with lines
  ls 2

 #  Blade Twist
 set output './GNUPLOT/twist_vs_r.png'
 set xlabel "r / R"
 set ylabel "Blade Twist [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,5.0,60.0
 set mytics 5
 plot [0.0:1.0] [0.0:60.0] 
 "XTurb_gnuplot_data.plt" using 1:4 notitle with lines

 #  Blade Polar
 set output './GNUPLOT/lift_vs_r.png'
 set xlabel "r / R"
 set ylabel "Coefficient of Lift, C_{l}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,2.5
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set mytics 5
 plot [0.0:1.0] [0.0:2.5] "XTurb_gnuplot_data.plt" using 1:7 
 title "C_{l}" with lines

 set output './GNUPLOT/finesse_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Finesse, C_{l}/C_{d}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,20.0,180.0
 set mytics 4
 plot [0.0:1.0] [0.0:180] "XTurb_gnuplot_data.plt" using 1:9 
 title "C_{l}/C_{d}" with lines

 #  Flow Angles
 set output './GNUPLOT/angles_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Angle of Attack, {/Symbol a} [deg]   Local Flow Angle, {/Symbol f} [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,10.0,90.0
 set mytics 2
 plot [0.0:1.0] [0.0:90.0] "XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" with lines,"XTurb_gnuplot_data.plt" using 1:6 
 title "{/Symbol f}" with lines

 #  Equivalent Blade Circulation
 set output './GNUPLOT/gamma_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.1,0.05,0.2
 set ytics add ( "0.00" 0.0)
 set ytics add ( "0.10" 0.1)
 set ytics add ( "0.20" 0.2)
 set mytics 5
 plot [0.0:1.0] [-0.1:0.2] "XTurb_gnuplot_data.plt" using 1:10 
 notitle with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" with points

 # Circulation vs Angle of Attack
 set output './GNUPLOT/gamma_and_aoa.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set y2label "Local Angle of Attack, {/Symbol a} [deg]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.1,0.05,0.2
 set yrange [-0.1:0.2]
 set ytics add ( "0.00" 0.0)
 set mytics 5
 set y2tics 0.0,5.0,45.0
 set y2range [0.0:45.0]
 set my2tics 2
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:10 
 notitle axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" axes x1y2 with lines

 #  Equivalent Induction Factors
 set output './GNUPLOT/inductfact_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Induction Factors, a & a'"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.5,0.1,0.5
 set ytics add ( "0.0" 0.0)
 set mytics 5
 plot [0.0:1.0] [-0.5:0.5] "XTurb_gnuplot_data.plt" using 1:11 
 title "a " with lines,"XTurb_gnuplot_data.plt" using 1:12 
 title "a'" with lines

 #  Normal/Tangential Force Coeff.
 set output './GNUPLOT/CnCt_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Normal Force Coefficient, C_{n}"
 set y2label "Tangential Force Coefficient, C_{t}"
 set yrange [0.0:3.0]
 set y2range [-0.5:1.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -0.5,0.25,1.5
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set y2tics add ( " 1.00" 1.0)
 set y2tics add ( " 1.50" 1.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:13 
 title "C_{n}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:14 
 title "C_{t}" axes x1y2 with lines

 #  Thrust/Torque Coeff.
 set output './GNUPLOT/CthCto_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust Coefficient, C_{th} & C_{th,visc.}"
 set y2label "Torque Coefficient, C_{to} & C_{to,visc.}"
 set yrange [0.0:3.0]
 set y2range [-1.5:0.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -1.5,0.25,0.5
 set y2tics add ( "-1.50" -1.5)
 set y2tics add ( "-1.00" -1.0)
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:15 
 title "C_{th}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:16 
 title "C_{th,visc.}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:17 
 title "C_{to}" axes x1y2 with lines,"XTurb_gnuplot_data.plt" using 1:18 
 title "C_{to,visc.}" axes x1y2 with lines

 #  Thrust/Torque per Unit Span
 set output './GNUPLOT/ThTo_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust per Unit Span, Th'  [N/m / (V_{0}^{2}R)]"
 set y2label "Torque per Unit Span, To'  [Nm/m / (V_{0}^{2}R^{2})]"
 set yrange [0.0:1.0]
 set y2range [-0.25:0.25]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.1,1.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set mytics 5
 set y2tics -0.25,0.05,0.25
 set y2tics add ( "-0.20" -0.2)
 set y2tics add ( "-0.10" -0.1)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.10" 0.1)
 set y2tics add ( " 0.20" 0.2)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:19 
 title "Th'" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:20 
 title "To'" axes x1y2 with lines
 reset
 set style line 2 lc rgb 'red'

 #  Blade Planform
 set output './GNUPLOT/chord_vs_r.png'
 set xlabel "r / R"
 set ylabel "Chord / R"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.5,0.1,0.5
 set mytics 2
 plot [0.0:1.0] [-0.5:0.5] 
 "XTurb_gnuplot_data.plt" using 1:2 notitle with lines,"XTurb_gnuplot_data.plt" using 1:3 notitle with lines
  ls 2

 #  Blade Twist
 set output './GNUPLOT/twist_vs_r.png'
 set xlabel "r / R"
 set ylabel "Blade Twist [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,5.0,60.0
 set mytics 5
 plot [0.0:1.0] [0.0:60.0] 
 "XTurb_gnuplot_data.plt" using 1:4 notitle with lines

 #  Blade Polar
 set output './GNUPLOT/lift_vs_r.png'
 set xlabel "r / R"
 set ylabel "Coefficient of Lift, C_{l}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,2.5
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set mytics 5
 plot [0.0:1.0] [0.0:2.5] "XTurb_gnuplot_data.plt" using 1:7 
 title "C_{l}" with lines

 set output './GNUPLOT/finesse_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Finesse, C_{l}/C_{d}"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,20.0,180.0
 set mytics 4
 plot [0.0:1.0] [0.0:180] "XTurb_gnuplot_data.plt" using 1:9 
 title "C_{l}/C_{d}" with lines

 #  Flow Angles
 set output './GNUPLOT/angles_vs_r.png'
 set xlabel "r / R"
 set ylabel "Local Angle of Attack, {/Symbol a} [deg]   Local Flow Angle, {/Symbol f} [deg]"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,10.0,90.0
 set mytics 2
 plot [0.0:1.0] [0.0:90.0] "XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" with lines,"XTurb_gnuplot_data.plt" using 1:6 
 title "{/Symbol f}" with lines

 #  Equivalent Blade Circulation
 set output './GNUPLOT/gamma_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics -0.1,0.05,0.2
 set ytics add ( "0.00" 0.0)
 set ytics add ( "0.10" 0.1)
 set ytics add ( "0.20" 0.2)
 set mytics 5
 plot [0.0:1.0] [-0.1:0.2] "XTurb_gnuplot_data.plt" using 1:10 
 notitle with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" with points

 # Circulation vs Angle of Attack
 set output './GNUPLOT/gamma_and_aoa.png'
 set xlabel "r / R"
 set ylabel "Equivalent Blade Circulation, {/Symbol G}/(V_{0}R)"
 set y2label "Local Angle of Attack, {/Symbol a} [deg]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.1,0.05,0.2
 set yrange [-0.1:0.2]
 set ytics add ( "0.00" 0.0)
 set mytics 5
 set y2tics 0.0,5.0,45.0
 set y2range [0.0:45.0]
 set my2tics 2
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:10 
 notitle axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:21 
 title "Max" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:22 
 title "Min" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:23 
 title "Inflection" axes x1y1 with points,"XTurb_gnuplot_data.plt" using 1:5 
 title "{/Symbol a}" axes x1y2 with lines

 #  Equivalent Induction Factors
 set output './GNUPLOT/inductfact_vs_r.png'
 set xlabel "r / R"
 set ylabel "Equivalent Induction Factors, a & a'"
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics nomirror
 set ytics -0.5,0.1,0.5
 set ytics add ( "0.0" 0.0)
 set mytics 5
 plot [0.0:1.0] [-0.5:0.5] "XTurb_gnuplot_data.plt" using 1:11 
 title "a " with lines,"XTurb_gnuplot_data.plt" using 1:12 
 title "a'" with lines

 #  Normal/Tangential Force Coeff.
 set output './GNUPLOT/CnCt_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Normal Force Coefficient, C_{n}"
 set y2label "Tangential Force Coefficient, C_{t}"
 set yrange [0.0:3.0]
 set y2range [-0.5:1.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -0.5,0.25,1.5
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set y2tics add ( " 1.00" 1.0)
 set y2tics add ( " 1.50" 1.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:13 
 title "C_{n}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:14 
 title "C_{t}" axes x1y2 with lines

 #  Thrust/Torque Coeff.
 set output './GNUPLOT/CthCto_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust Coefficient, C_{th} & C_{th,visc.}"
 set y2label "Torque Coefficient, C_{to} & C_{to,visc.}"
 set yrange [0.0:3.0]
 set y2range [-1.5:0.5]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.5,3.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set ytics add ( "3.0" 3.0)
 set mytics 5
 set y2tics -1.5,0.25,0.5
 set y2tics add ( "-1.50" -1.5)
 set y2tics add ( "-1.00" -1.0)
 set y2tics add ( "-0.50" -0.5)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.50" 0.5)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:15 
 title "C_{th}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:16 
 title "C_{th,visc.}" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:17 
 title "C_{to}" axes x1y2 with lines,"XTurb_gnuplot_data.plt" using 1:18 
 title "C_{to,visc.}" axes x1y2 with lines

 #  Thrust/Torque per Unit Span
 set output './GNUPLOT/ThTo_vs_r.png'
 set xlabel "r / R"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust per Unit Span, Th'  [N/m / (V_{0}^{2}R)]"
 set y2label "Torque per Unit Span, To'  [Nm/m / (V_{0}^{2}R^{2})]"
 set yrange [0.0:1.0]
 set y2range [-0.25:0.25]
 set xtics 0.0,0.1,1.0
 set xtics add ( "0.0" 0.0)
 set xtics add ( "1.0" 1.0)
 set mxtics 2
 set ytics 0.0,0.1,1.0
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set mytics 5
 set y2tics -0.25,0.05,0.25
 set y2tics add ( "-0.20" -0.2)
 set y2tics add ( "-0.10" -0.1)
 set y2tics add ( " 0.00" 0.0)
 set y2tics add ( " 0.10" 0.1)
 set y2tics add ( " 0.20" 0.2)
 set my2tics 5
 plot [0.0:1.0] "XTurb_gnuplot_data.plt" using 1:19 
 title "Th'" axes x1y1 with lines,"XTurb_gnuplot_data.plt" using 1:20 
 title "To'" axes x1y2 with lines

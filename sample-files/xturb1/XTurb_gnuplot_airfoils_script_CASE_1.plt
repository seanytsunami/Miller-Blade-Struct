 system "rm -rf GNUPLOT_AIRFOILS"
 system "mkdir GNUPLOT_AIRFOILS"
 set terminal png transparent nocrop enhanced font 
 arial 14 size 600,600 linewidth 1.75
 set style line 2 lc rgb 'red'

 #  Airfoil Data  -  1
 set output './GNUPLOT_AIRFOILS/lift_vs_aoa.png'
 set xlabel "alpha [deg]"
 set ylabel "Coefficient of Lift, C_{l}"
 set xtics -10.0,5.0,30.0
 set mxtics 10
 set ytics -1.5,0.5,2.5
 set ytics add ( "-1.0" -1.0)
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set mytics 5
 plot [-10.0:30.0] [-1.5:2.5] 
 "XTurb_gnuplot_airfoils_data_CASE_1.plt" using 2:3 
 title "Polar Data" with lines,"XTurb_gnuplot_airfoils_data_CASE_1.plt" using 10:8 
 title "Operational" with points

 #  Airfoil Data  -  2
 set output './GNUPLOT_AIRFOILS/drag_vs_aoa.png'
 set xlabel "alpha [deg]"
 set ylabel "Coefficient of Drag, C_{d}"
 set xtics -10.0,5.0,30.0
 set mxtics 10
 set ytics 0.0,0.1,0.5
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set mytics 5
 plot [-10.0:30.0] [0.0:0.5] 
 "XTurb_gnuplot_airfoils_data_CASE_1.plt" using 2:4 
 title "Polar Data" with lines,"XTurb_gnuplot_airfoils_data_CASE_1.plt" using 10:9 
 title "Operational" with points

 #  Airfoil Data  -  3
 set output './GNUPLOT_AIRFOILS/pitching_moment_vs_aoa.png'
 set xlabel "alpha [deg]"
 set ylabel "Pitching Moment Coefficient, C_{m}"
 set xtics -10.0,5.0,30.0
 set mxtics 10
 set ytics -0.7,0.1,0.6
 plot [-10.0:30.0] [-0.7:0.6] 
 "XTurb_gnuplot_airfoils_data_CASE_1.plt" using 2:6 
 title "Airfoil Data  -  3" with lines

 #  Airfoil Data  -  4
 set output './GNUPLOT_AIRFOILS/lift_vs_drag.png'
 set xlabel "Coefficient of Drag, C_{d}"
 set ylabel "Coefficient of Lift, C_{l}"
 set xtics 0.0,0.02,0.1
 set xtics add ( "0.00" 0.00)
 set mxtics 6
 set ytics -1.0,0.5,2.0
 set ytics add ( "-1.0" -1.0)
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set mytics 5
 plot [0.0:0.1] [-1.0:2.0] "XTurb_gnuplot_airfoils_data_CASE_1.plt" using 4:3 
 title "Polar Data" with lines,"XTurb_gnuplot_airfoils_data_CASE_1.plt" using 9:8 
 title "Operational" with points

 #  Airfoil Data  -  5
 set output './GNUPLOT_AIRFOILS/local_finesse_vs_aoa.png'
 set xlabel "Angle of Attack (Deg)"
 set ylabel "Local Finesse, C_{l}/C_{d}"
 set xtics -10.0,5.0,30.0
 set xtics add ( "0.0" 0.0)
 set mxtics 2
 set ytics -80.0,20.0,180.0
 set mytics 4
 plot [-10.0:30.0] [-80.0:180] 
 "XTurb_gnuplot_airfoils_data_CASE_1.plt" using 2:7 
 title "C_{l}/C_{d}" with lines

 #  Airfoil Data  -  6
 set output './GNUPLOT_AIRFOILS/global_polar.png'
 set xlabel "Coefficient of Drag, C_{d}"
 set ylabel "Coefficient of Lift, C_{l}"
 set xtics 0.0,0.02,0.1
 set xtics add ( "0.00" 0.00)
 set mxtics 6
 set ytics -1.0,0.5,2.0
 set ytics add ( "-1.0" -1.0)
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set ytics add ( "2.0" 2.0)
 set mytics 5
 set palette model RGB defined ( 0 "red", 0.5 "yellow", 1 "green" )
 plot [0.0:0.1] [-1.0:2.0] "XTurb_gnuplot_airfoils_data_CASE_1.plt" using 9:8 
 title "Operational" with points

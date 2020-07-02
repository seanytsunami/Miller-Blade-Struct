 system "rm -rf GNUPLOT_Global"
 system "mkdir GNUPLOT_Global"
 set terminal png transparent nocrop enhanced font 
 arial 14 size 600,600 linewidth 1.75
 set style line 2 lc rgb 'red'

 #  Force Coefficients
 set output './GNUPLOT_Global/CPCTCB_vs_Vwind.png'
 set xlabel "V_{Wind} [m/s]"
 set ytics nomirror
 set y2tics
 set ylabel "Force Coefficients, C_{T}
 set y2label "Force Coefficients, C_{P}  C_{B}
 set yrange [-1.0:1.0]
 set y2range [1.0:-1.0]
 set xtics 0.0,5.0,30.0
 set mxtics 5
 set ytics -1.0,0.2,1.0
 set ytics add ( "-1.0" -1.0)
 set ytics add ( "0.0" 0.0)
 set ytics add ( "1.0" 1.0)
 set mytics 2
 set y2tics 1.0,-0.2,-1.0
 set y2tics add ( " 1.0" 1.0)
 set y2tics add ( " 0.0" 0.0)
 set y2tics add ( "-1.0" -1.0)
 set my2tics 2
 plot [0.0:30.0] [-1.0:1.0] "XTurb_gnuplot_global_data.plt" using 2:6 
 title "C_{T}" axes x1y1 with lines,"XTurb_gnuplot_global_data.plt" using 2:7 
 title "C_{P}" axes x1y2 with lines,"XTurb_gnuplot_global_data.plt" using 2:8 
 title "C_{B}" axes x1y2 with lines

 #  PITCH/TSR/RPM
 reset
 set output './GNUPLOT_Global/PitchTsrRpm_vs_Vwind.png'
 set xlabel "V_{Wind} [m/s]"
 set ytics nomirror
 set y2tics
 set ylabel "Tip Pitch [deg]  ,  Tip Speed Ratio"
 set y2label "RPM [1/min]"
 set yrange [-4.0:20.0]
 set xtics 0.0,5.0,30.0
 set mxtics 5
 set ytics -4.0,2.0,20.0
 set mytics 2
 plot [0.0:30.0]  "XTurb_gnuplot_global_data.plt" using 2:5 
 title "Tip Pitch" axes x1y1 with lines,"XTurb_gnuplot_global_data.plt" using 2:4 
 title "Tip Speed Ratio" axes x1y1 with lines,"XTurb_gnuplot_global_data.plt" using 2:3 
 title "RPM" axes x1y2 with lines

 #  Thrust/BendingMoment
 reset
 set output './GNUPLOT_Global/ThrustBendingMoment_vs_Vwind.png'
 set xlabel "V_{Wind} [m/s]"
 set ytics nomirror
 set y2tics
 set ylabel "Thrust [kN]
 set y2label "Bending Moment [kN*m]"
 set xtics 0.0,5.0,30.0
 set mxtics 5
 plot [0.0:30.0]  "XTurb_gnuplot_global_data.plt" using 2:9 
 title "Thrust" axes x1y1 with lines,"XTurb_gnuplot_global_data.plt" using 2:12 
 title "Bending Moment" axes x1y2 with lines

 #  Power/Torque
 reset
 set output './GNUPLOT_Global/PowerTorque_vs_Vwind.png'
 set xlabel "V_{Wind} [m/s]"
 set ytics nomirror
 set y2tics
 set ylabel "Power [kW]
 set y2label "Torque [kN*m]"
 set xtics 0.0,5.0,30.0
 set mxtics 5
 plot [0.0:30.0]  "XTurb_gnuplot_global_data.plt" using 2:10 
 title "Power" axes x1y1 with lines,"XTurb_gnuplot_global_data.plt" using 2:11 
 title "Torque" axes x1y2 with lines

// Program made by Krzysztof Zajączkowski
// owner of page https://obliczeniowo.com.pl
// that let You draw stuff and export it
// to OpenSCAD format file

function distance(point1, point2) = sqrt(
      (point1[0] - point2[0]) * (point1[0] - point2[0])
      +
      (point1[1] - point2[1]) * (point1[1] - point2[1])
      +
      (point1[2] - point2[2]) * (point1[2] - point2[2])
    );
module cylinderByTwoPoints(r, point1, point2){

    alpha = atan2(point2[1] - point1[1], point2[0] - point1[0]);
    betha = atan2(sqrt(pow(point2[0] - point1[0], 2) + pow(point2[1] - point1[1], 2)), point2[2] - point1[2]);

    translate(point1)
    rotate([0, betha, alpha])
    cylinder(r = r, h = sqrt(
                pow(point2[0] - point1[0], 2) +
                pow(point2[1] - point1[1], 2) +
                pow(point2[2] - point1[2], 2)
                )
    );
}
module cylindersByPoints(r, points){
    union(){
        for(index = [0: 1: len(points) - 2])
        {
            point1 = len(points[index]) == 3 ? points[index] : [points[index][0], points[index][1], 0];
            point2 = len(points[index + 1]) == 3 ? points[index + 1] : [points[index + 1][0], points[index + 1][1], 0];
            cylinderByTwoPoints(r, point1, point2);
            if(index < len(points) - 2){
                translate(points[index + 1])
                sphere(r = r);
            }
        }
    }
}
module distX(point1, point2, length = 20, ray = 1, prefix="", size = 10){

    maxy = point1[1] > point2[1] ? point1[1] : point2[1];

    distx = distance(
      [
        point1[0],
        0,
        0
      ],
      [
        point2[0],
        0,
        0
      ]
    );

    if (distx) {

      color([0.1, 0.1, 0.1]){
          $fn = 20;
          dist = 4;
          cylindersByPoints(
              ray,
              [
                  point1,
                  [
                      point1[0],
                      maxy + length,
                      point1[2]
                  ]
              ]
          );
          cylindersByPoints(
              ray,
              [
                  point2,
                  [
                      point2[0],
                      maxy + length,
                      point2[2]
                  ]
              ]
          );
          cylindersByPoints(
              ray,
              [
                  [
                      point1[0],
                      maxy + length - dist * length / abs(length),
                      point1[2]
                  ],
                  [
                      point2[0],
                      maxy + length - dist * length / abs(length),
                      point1[2]
                  ]
              ]
          );

          angle = 180;

          translate(
                      [
                          (point1[0] + point2[0]) / 2,
                          maxy + length + ( length < 0 ? 2 * dist : 0) - size * 0.7,
                          point1[2]
                      ]
                  )
          rotate([0, 0, angle])
          text(text = str(prefix, distx), size = size, halign="center");
      }
    }
}
module distY (point1, point2, length = 20, ray = 1, prefix="", size = 10){

    maxx = point1[0] > point2[0] ? point1[0] : point2[0];

    disty = distance(
      [
          0,
          point1[1],
          0
      ],
      [
          0,
          point2[1],
          0
      ]
    );

    if (disty) {

        color([0.1, 0.1, 0.1]){
            $fn = 20;
            dist = 4;
            cylindersByPoints(
                ray,
                [
                    point1,
                    [
                        maxx + length,
                        point1[1],
                        point1[2]
                    ]
                ]
            );
            cylindersByPoints(
                ray,
                [
                    point2,
                    [
                        maxx + length,
                        point2[1],
                        point2[2]
                    ]
                ]
            );

            cylindersByPoints(
                ray,
                [
                    [
                        maxx + length - dist * length / abs(length),
                        point1[1],
                        point1[2]
                    ],
                    [
                        maxx + length - dist * length / abs(length),
                        point2[1],
                        point2[2]
                    ]
                ]
            );

            angle = 90;

            translate(
                        [
                            maxx +  + length + ( length < 0 ? 2 * dist : 0) - size * 0.7,
                            (point1[1] + point2[1]) / 2,
                            point1[2]
                        ]
                    )
            rotate([0, 0, angle])
            text(text = str(prefix, disty), size = size, halign="center");
        }
    }
}

module Polygon_1(displayDistance = true) {

P0dx = 0;
P0dy = 0;
P0 = [P0dx, P0dy];
    
    hr = 15;
    wr = 25;
    hr2 = 75;

P1dx = 0;
P1dy = 9 * wr + hr2 + 25;
P1 = [P0[0] + P1dx, P0[1] + P1dy];

P2dx = 280;
P2dy = 0;
P2 = [P1[0] + P2dx, P1[1] + P2dy];

P3dx = 0;
P3dy = -P1dy;
P3 = [P2[0] + P3dx, P2[1] + P3dy];

P4dx = -40;
P4dy = 0;
P4 = [P3[0] + P4dx, P3[1] + P4dy];

P5dx = 0;
P5dy = wr;
P5 = [P4[0] + P5dx, P4[1] + P5dy];

P6dx = hr;
P6dy = 0;
P6 = [P5[0] + P6dx, P5[1] + P6dy];

P7dx = 0;
P7dy = wr;
P7 = [P6[0] + P7dx, P6[1] + P7dy];

P8dx = -hr;
P8dy = 0;
P8 = [P7[0] + P8dx, P7[1] + P8dy];

P9dx = 0;
P9dy = wr;
P9 = [P8[0] + P9dx, P8[1] + P9dy];

P10dx = hr;
P10dy = 0;
P10 = [P9[0] + P10dx, P9[1] + P10dy];

P11dx = 0;
P11dy = wr;
P11 = [P10[0] + P11dx, P10[1] + P11dy];

P12dx = -hr;
P12dy = 0;
P12 = [P11[0] + P12dx, P11[1] + P12dy];

P13dx = 0;
P13dy = wr;
P13 = [P12[0] + P13dx, P12[1] + P13dy];

P14dx = hr;
P14dy = 0;
P14 = [P13[0] + P14dx, P13[1] + P14dy];

P15dx = 0;
P15dy = wr;
P15 = [P14[0] + P15dx, P14[1] + P15dy];

P16dx = -hr;
P16dy = 0;
P16 = [P15[0] + P16dx, P15[1] + P16dy];

P17dx = 0;
P17dy = wr;
P17 = [P16[0] + P17dx, P16[1] + P17dy];

P18dx = hr;
P18dy = 0;
P18 = [P17[0] + P18dx, P17[1] + P18dy];

P19dx = 0;
P19dy = wr;
P19 = [P18[0] + P19dx, P18[1] + P19dy];

P20dx = -hr;
P20dy = 0;
P20 = [P19[0] + P20dx, P19[1] + P20dy];

P21dx = 0;
P21dy = wr;
P21 = [P20[0] + P21dx, P20[1] + P21dy];

P22dx = hr;
P22dy = 0;
P22 = [P21[0] + P22dx, P21[1] + P22dy];

P23dx = 0;
P23dy = hr2;
P23 = [P22[0] + P23dx, P22[1] + P23dy];

P24dx = -230;
P24dy = 0;
P24 = [P23[0] + P24dx, P23[1] + P24dy];

P25dx = 0;
P25dy = -hr2;
P25 = [P24[0] + P25dx, P24[1] + P25dy];

P26dx = hr;
P26dy = 0;
P26 = [P25[0] + P26dx, P25[1] + P26dy];

P27dx = 0;
P27dy = -wr;
P27 = [P26[0] + P27dx, P26[1] + P27dy];

P28dx = -hr;
P28dy = 0;
P28 = [P27[0] + P28dx, P27[1] + P28dy];

P29dx = 0;
P29dy = -wr;
P29 = [P28[0] + P29dx, P28[1] + P29dy];

P30dx = hr;
P30dy = 0;
P30 = [P29[0] + P30dx, P29[1] + P30dy];

P31dx = 0;
P31dy = -wr;
P31 = [P30[0] + P31dx, P30[1] + P31dy];

P32dx = -hr;
P32dy = 0;
P32 = [P31[0] + P32dx, P31[1] + P32dy];

P33dx = 0;
P33dy = -wr;
P33 = [P32[0] + P33dx, P32[1] + P33dy];

P34dx = hr;
P34dy = 0;
P34 = [P33[0] + P34dx, P33[1] + P34dy];

P35dx = 0;
P35dy = -wr;
P35 = [P34[0] + P35dx, P34[1] + P35dy];

P36dx = -hr;
P36dy = 0;
P36 = [P35[0] + P36dx, P35[1] + P36dy];

P37dx = 0;
P37dy = -wr;
P37 = [P36[0] + P37dx, P36[1] + P37dy];

P38dx = hr;
P38dy = 0;
P38 = [P37[0] + P38dx, P37[1] + P38dy];

P39dx = 0;
P39dy = -wr;
P39 = [P38[0] + P39dx, P38[1] + P39dy];

P40dx = -hr;
P40dy = 0;
P40 = [P39[0] + P40dx, P39[1] + P40dy];

P41dx = 0;
P41dy = -wr;
P41 = [P40[0] + P41dx, P40[1] + P41dy];

P42dx = hr;
P42dy = 0;
P42 = [P41[0] + P42dx, P41[1] + P42dy];

P43dx = 0;
P43dy = -wr;
P43 = [P42[0] + P43dx, P42[1] + P43dy];

translate([0, 0, -500])
linear_extrude(height = 500)
polygon([P0,
P1,
P2,
P3,
P4,
P5,
P6,
P7,
P8,
P9,
P10,
P11,
P12,
P13,
P14,
P15,
P16,
P17,
P18,
P19,
P20,
P21,
P22,
P23,
P24,
P25,
P26,
P27,
P28,
P29,
P30,
P31,
P32,
P33,
P34,
P35,
P36,
P37,
P38,
P39,
P40,
P41,
P42,
P43]);
if (displayDistance) {
distY(
          [
            P1[0],
            P1[1],
            2
          ],
          [
            P0[0],
            P0[1],
            2
          ],
          -40,
          1,
          "P1dy = ",
          10
        );
distX(
          [
            P1[0],
            P1[1],
            2
          ],
          [
            P0[0],
            P0[1],
            2
          ],
          40,
          1,
          "P1dx = ",
          10
        );
distY(
          [
            P2[0],
            P2[1],
            2
          ],
          [
            P1[0],
            P1[1],
            2
          ],
          40,
          1,
          "P2dy = ",
          10
        );
distX(
          [
            P2[0],
            P2[1],
            2
          ],
          [
            P1[0],
            P1[1],
            2
          ],
          80,
          1,
          "P2dx = ",
          10
        );
distY(
          [
            P3[0],
            P3[1],
            2
          ],
          [
            P2[0],
            P2[1],
            2
          ],
          140,
          1,
          "P3dy = ",
          10
        );
distX(
          [
            P3[0],
            P3[1],
            2
          ],
          [
            P2[0],
            P2[1],
            2
          ],
          40,
          1,
          "P3dx = ",
          10
        );
distY(
          [
            P4[0],
            P4[1],
            2
          ],
          [
            P3[0],
            P3[1],
            2
          ],
          40,
          1,
          "P4dy = ",
          10
        );
distX(
          [
            P4[0],
            P4[1],
            2
          ],
          [
            P3[0],
            P3[1],
            2
          ],
          -40,
          1,
          "P4dx = ",
          10
        );
distY(
          [
            P5[0],
            P5[1],
            2
          ],
          [
            P4[0],
            P4[1],
            2
          ],
          80,
          1,
          "P5dy = ",
          10
        );
distX(
          [
            P5[0],
            P5[1],
            2
          ],
          [
            P4[0],
            P4[1],
            2
          ],
          40,
          1,
          "P5dx = ",
          10
        );
distY(
          [
            P6[0],
            P6[1],
            2
          ],
          [
            P5[0],
            P5[1],
            2
          ],
          40,
          1,
          "P6dy = ",
          10
        );
distX(
          [
            P6[0],
            P6[1],
            2
          ],
          [
            P5[0],
            P5[1],
            2
          ],
          40,
          1,
          "P6dx = ",
          10
        );
distY(
          [
            P7[0],
            P7[1],
            2
          ],
          [
            P6[0],
            P6[1],
            2
          ],
          100,
          1,
          "P7dy = ",
          10
        );
distX(
          [
            P7[0],
            P7[1],
            2
          ],
          [
            P6[0],
            P6[1],
            2
          ],
          40,
          1,
          "P7dx = ",
          10
        );
distY(
          [
            P8[0],
            P8[1],
            2
          ],
          [
            P7[0],
            P7[1],
            2
          ],
          40,
          1,
          "P8dy = ",
          10
        );
distX(
          [
            P8[0],
            P8[1],
            2
          ],
          [
            P7[0],
            P7[1],
            2
          ],
          40,
          1,
          "P8dx = ",
          10
        );
distY(
          [
            P9[0],
            P9[1],
            2
          ],
          [
            P8[0],
            P8[1],
            2
          ],
          150,
          1,
          "P9dy = ",
          10
        );
distX(
          [
            P9[0],
            P9[1],
            2
          ],
          [
            P8[0],
            P8[1],
            2
          ],
          40,
          1,
          "P9dx = ",
          10
        );
distY(
          [
            P10[0],
            P10[1],
            2
          ],
          [
            P9[0],
            P9[1],
            2
          ],
          40,
          1,
          "P10dy = ",
          10
        );
distX(
          [
            P10[0],
            P10[1],
            2
          ],
          [
            P9[0],
            P9[1],
            2
          ],
          40,
          1,
          "P10dx = ",
          10
        );
distY(
          [
            P11[0],
            P11[1],
            2
          ],
          [
            P10[0],
            P10[1],
            2
          ],
          65,
          1,
          "P11dy = ",
          10
        );
distX(
          [
            P11[0],
            P11[1],
            2
          ],
          [
            P10[0],
            P10[1],
            2
          ],
          40,
          1,
          "P11dx = ",
          10
        );
distY(
          [
            P12[0],
            P12[1],
            2
          ],
          [
            P11[0],
            P11[1],
            2
          ],
          40,
          1,
          "P12dy = ",
          10
        );
distX(
          [
            P12[0],
            P12[1],
            2
          ],
          [
            P11[0],
            P11[1],
            2
          ],
          40,
          1,
          "P12dx = ",
          10
        );
distY(
          [
            P13[0],
            P13[1],
            2
          ],
          [
            P12[0],
            P12[1],
            2
          ],
          115,
          1,
          "P13dy = ",
          10
        );
distX(
          [
            P13[0],
            P13[1],
            2
          ],
          [
            P12[0],
            P12[1],
            2
          ],
          40,
          1,
          "P13dx = ",
          10
        );
distY(
          [
            P14[0],
            P14[1],
            2
          ],
          [
            P13[0],
            P13[1],
            2
          ],
          40,
          1,
          "P14dy = ",
          10
        );
distX(
          [
            P14[0],
            P14[1],
            2
          ],
          [
            P13[0],
            P13[1],
            2
          ],
          40,
          1,
          "P14dx = ",
          10
        );
distY(
          [
            P15[0],
            P15[1],
            2
          ],
          [
            P14[0],
            P14[1],
            2
          ],
          135,
          1,
          "P15dy = ",
          10
        );
distX(
          [
            P15[0],
            P15[1],
            2
          ],
          [
            P14[0],
            P14[1],
            2
          ],
          40,
          1,
          "P15dx = ",
          10
        );
distY(
          [
            P16[0],
            P16[1],
            2
          ],
          [
            P15[0],
            P15[1],
            2
          ],
          40,
          1,
          "P16dy = ",
          10
        );
distX(
          [
            P16[0],
            P16[1],
            2
          ],
          [
            P15[0],
            P15[1],
            2
          ],
          40,
          1,
          "P16dx = ",
          10
        );
distY(
          [
            P17[0],
            P17[1],
            2
          ],
          [
            P16[0],
            P16[1],
            2
          ],
          80,
          1,
          "P17dy = ",
          10
        );
distX(
          [
            P17[0],
            P17[1],
            2
          ],
          [
            P16[0],
            P16[1],
            2
          ],
          40,
          1,
          "P17dx = ",
          10
        );
distY(
          [
            P18[0],
            P18[1],
            2
          ],
          [
            P17[0],
            P17[1],
            2
          ],
          40,
          1,
          "P18dy = ",
          10
        );
distX(
          [
            P18[0],
            P18[1],
            2
          ],
          [
            P17[0],
            P17[1],
            2
          ],
          40,
          1,
          "P18dx = ",
          10
        );
distY(
          [
            P19[0],
            P19[1],
            2
          ],
          [
            P18[0],
            P18[1],
            2
          ],
          100,
          1,
          "P19dy = ",
          10
        );
distX(
          [
            P19[0],
            P19[1],
            2
          ],
          [
            P18[0],
            P18[1],
            2
          ],
          40,
          1,
          "P19dx = ",
          10
        );
distY(
          [
            P20[0],
            P20[1],
            2
          ],
          [
            P19[0],
            P19[1],
            2
          ],
          40,
          1,
          "P20dy = ",
          10
        );
distX(
          [
            P20[0],
            P20[1],
            2
          ],
          [
            P19[0],
            P19[1],
            2
          ],
          40,
          1,
          "P20dx = ",
          10
        );
distY(
          [
            P21[0],
            P21[1],
            2
          ],
          [
            P20[0],
            P20[1],
            2
          ],
          150,
          1,
          "P21dy = ",
          10
        );
distX(
          [
            P21[0],
            P21[1],
            2
          ],
          [
            P20[0],
            P20[1],
            2
          ],
          40,
          1,
          "P21dx = ",
          10
        );
distY(
          [
            P22[0],
            P22[1],
            2
          ],
          [
            P21[0],
            P21[1],
            2
          ],
          40,
          1,
          "P22dy = ",
          10
        );
distX(
          [
            P22[0],
            P22[1],
            2
          ],
          [
            P21[0],
            P21[1],
            2
          ],
          40,
          1,
          "P22dx = ",
          10
        );
distY(
          [
            P23[0],
            P23[1],
            2
          ],
          [
            P22[0],
            P22[1],
            2
          ],
          65,
          1,
          "P23dy = ",
          10
        );
distX(
          [
            P23[0],
            P23[1],
            2
          ],
          [
            P22[0],
            P22[1],
            2
          ],
          40,
          1,
          "P23dx = ",
          10
        );
distY(
          [
            P24[0],
            P24[1],
            2
          ],
          [
            P23[0],
            P23[1],
            2
          ],
          40,
          1,
          "P24dy = ",
          10
        );
distX(
          [
            P24[0],
            P24[1],
            2
          ],
          [
            P23[0],
            P23[1],
            2
          ],
          70,
          1,
          "P24dx = ",
          10
        );
distY(
          [
            P25[0],
            P25[1],
            2
          ],
          [
            P24[0],
            P24[1],
            2
          ],
          40,
          1,
          "P25dy = ",
          10
        );
distX(
          [
            P25[0],
            P25[1],
            2
          ],
          [
            P24[0],
            P24[1],
            2
          ],
          40,
          1,
          "P25dx = ",
          10
        );
distY(
          [
            P26[0],
            P26[1],
            2
          ],
          [
            P25[0],
            P25[1],
            2
          ],
          40,
          1,
          "P26dy = ",
          10
        );
distX(
          [
            P26[0],
            P26[1],
            2
          ],
          [
            P25[0],
            P25[1],
            2
          ],
          40,
          1,
          "P26dx = ",
          10
        );
distY(
          [
            P27[0],
            P27[1],
            2
          ],
          [
            P26[0],
            P26[1],
            2
          ],
          40,
          1,
          "P27dy = ",
          10
        );
distX(
          [
            P27[0],
            P27[1],
            2
          ],
          [
            P26[0],
            P26[1],
            2
          ],
          40,
          1,
          "P27dx = ",
          10
        );
distY(
          [
            P28[0],
            P28[1],
            2
          ],
          [
            P27[0],
            P27[1],
            2
          ],
          40,
          1,
          "P28dy = ",
          10
        );
distX(
          [
            P28[0],
            P28[1],
            2
          ],
          [
            P27[0],
            P27[1],
            2
          ],
          40,
          1,
          "P28dx = ",
          10
        );
distY(
          [
            P29[0],
            P29[1],
            2
          ],
          [
            P28[0],
            P28[1],
            2
          ],
          40,
          1,
          "P29dy = ",
          10
        );
distX(
          [
            P29[0],
            P29[1],
            2
          ],
          [
            P28[0],
            P28[1],
            2
          ],
          40,
          1,
          "P29dx = ",
          10
        );
distY(
          [
            P30[0],
            P30[1],
            2
          ],
          [
            P29[0],
            P29[1],
            2
          ],
          40,
          1,
          "P30dy = ",
          10
        );
distX(
          [
            P30[0],
            P30[1],
            2
          ],
          [
            P29[0],
            P29[1],
            2
          ],
          40,
          1,
          "P30dx = ",
          10
        );
distY(
          [
            P31[0],
            P31[1],
            2
          ],
          [
            P30[0],
            P30[1],
            2
          ],
          40,
          1,
          "P31dy = ",
          10
        );
distX(
          [
            P31[0],
            P31[1],
            2
          ],
          [
            P30[0],
            P30[1],
            2
          ],
          40,
          1,
          "P31dx = ",
          10
        );
distY(
          [
            P32[0],
            P32[1],
            2
          ],
          [
            P31[0],
            P31[1],
            2
          ],
          40,
          1,
          "P32dy = ",
          10
        );
distX(
          [
            P32[0],
            P32[1],
            2
          ],
          [
            P31[0],
            P31[1],
            2
          ],
          40,
          1,
          "P32dx = ",
          10
        );
distY(
          [
            P33[0],
            P33[1],
            2
          ],
          [
            P32[0],
            P32[1],
            2
          ],
          40,
          1,
          "P33dy = ",
          10
        );
distX(
          [
            P33[0],
            P33[1],
            2
          ],
          [
            P32[0],
            P32[1],
            2
          ],
          40,
          1,
          "P33dx = ",
          10
        );
distY(
          [
            P34[0],
            P34[1],
            2
          ],
          [
            P33[0],
            P33[1],
            2
          ],
          40,
          1,
          "P34dy = ",
          10
        );
distX(
          [
            P34[0],
            P34[1],
            2
          ],
          [
            P33[0],
            P33[1],
            2
          ],
          40,
          1,
          "P34dx = ",
          10
        );
distY(
          [
            P35[0],
            P35[1],
            2
          ],
          [
            P34[0],
            P34[1],
            2
          ],
          40,
          1,
          "P35dy = ",
          10
        );
distX(
          [
            P35[0],
            P35[1],
            2
          ],
          [
            P34[0],
            P34[1],
            2
          ],
          40,
          1,
          "P35dx = ",
          10
        );
distY(
          [
            P36[0],
            P36[1],
            2
          ],
          [
            P35[0],
            P35[1],
            2
          ],
          40,
          1,
          "P36dy = ",
          10
        );
distX(
          [
            P36[0],
            P36[1],
            2
          ],
          [
            P35[0],
            P35[1],
            2
          ],
          40,
          1,
          "P36dx = ",
          10
        );
distY(
          [
            P37[0],
            P37[1],
            2
          ],
          [
            P36[0],
            P36[1],
            2
          ],
          40,
          1,
          "P37dy = ",
          10
        );
distX(
          [
            P37[0],
            P37[1],
            2
          ],
          [
            P36[0],
            P36[1],
            2
          ],
          40,
          1,
          "P37dx = ",
          10
        );
distY(
          [
            P38[0],
            P38[1],
            2
          ],
          [
            P37[0],
            P37[1],
            2
          ],
          40,
          1,
          "P38dy = ",
          10
        );
distX(
          [
            P38[0],
            P38[1],
            2
          ],
          [
            P37[0],
            P37[1],
            2
          ],
          40,
          1,
          "P38dx = ",
          10
        );
distY(
          [
            P39[0],
            P39[1],
            2
          ],
          [
            P38[0],
            P38[1],
            2
          ],
          40,
          1,
          "P39dy = ",
          10
        );
distX(
          [
            P39[0],
            P39[1],
            2
          ],
          [
            P38[0],
            P38[1],
            2
          ],
          40,
          1,
          "P39dx = ",
          10
        );
distY(
          [
            P40[0],
            P40[1],
            2
          ],
          [
            P39[0],
            P39[1],
            2
          ],
          40,
          1,
          "P40dy = ",
          10
        );
distX(
          [
            P40[0],
            P40[1],
            2
          ],
          [
            P39[0],
            P39[1],
            2
          ],
          40,
          1,
          "P40dx = ",
          10
        );
distY(
          [
            P41[0],
            P41[1],
            2
          ],
          [
            P40[0],
            P40[1],
            2
          ],
          40,
          1,
          "P41dy = ",
          10
        );
distX(
          [
            P41[0],
            P41[1],
            2
          ],
          [
            P40[0],
            P40[1],
            2
          ],
          40,
          1,
          "P41dx = ",
          10
        );
distY(
          [
            P42[0],
            P42[1],
            2
          ],
          [
            P41[0],
            P41[1],
            2
          ],
          40,
          1,
          "P42dy = ",
          10
        );
distX(
          [
            P42[0],
            P42[1],
            2
          ],
          [
            P41[0],
            P41[1],
            2
          ],
          40,
          1,
          "P42dx = ",
          10
        );
distY(
          [
            P43[0],
            P43[1],
            2
          ],
          [
            P42[0],
            P42[1],
            2
          ],
          80,
          1,
          "P43dy = ",
          10
        );
distX(
          [
            P43[0],
            P43[1],
            2
          ],
          [
            P42[0],
            P42[1],
            2
          ],
          40,
          1,
          "P43dx = ",
          10
        );

}
}

Polygon_1();
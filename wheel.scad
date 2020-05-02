// Program made by Krzysztof Zajączkowski
// owner of page https://obliczeniowo.com.pl
// that let You draw stuff and export it
// to OpenSCAD format file

$fn = 100;

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
      module Polygon_0(displayDistance = true) {

P0dx = 152;
P0dy = 160;
P0 = [P0dx, P0dy];

P1dx = 120;
P1dy = 0;
P1 = [P0[0] + P1dx, P0[1] + P1dy];

P2dx = 20;
P2dy = 20;
P2 = [P1[0] + P2dx, P1[1] + P2dy];

P3dx = 100;
P3dy = 0;
P3 = [P2[0] + P3dx, P2[1] + P3dy];

P4dx = 20;
P4dy = -20;
P4 = [P3[0] + P4dx, P3[1] + P4dy];

P5dx = 100;
P5dy = 0;
P5 = [P4[0] + P5dx, P4[1] + P5dy];

P6dx = 20;
P6dy = -20;
P6 = [P5[0] + P6dx, P5[1] + P6dy];

P7dx = 0;
P7dy = -20;
P7 = [P6[0] + P7dx, P6[1] + P7dy];

P8dx = -400;
P8dy = 0;
P8 = [P7[0] + P8dx, P7[1] + P8dy];

P9dx = 0;
P9dy = 15;
P9 = [P8[0] + P9dx, P8[1] + P9dy];

polygon([P0,
P1,
P2,
P3,
P4,
P5,
P6,
P7,
P8,
P9]);
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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

}
}

Polygon_0();
      
      rotate([0, 90, 0])
      rotate_extrude(angle = 360)
      rotate([0, 0, 90])
      Polygon_0(false);
      
    


      module Polygon_1(displayDistance = true) {

P0dx = 0;
P0dy = 0;
P0 = [P0dx, P0dy];

P1dx = 0;
P1dy = 45;
P1 = [P0[0] + P1dx, P0[1] + P1dy];

P2dx = 75;
P2dy = 20;
P2 = [P1[0] + P2dx, P1[1] + P2dy];

P3dx = 0;
P3dy = 75;
P3 = [P2[0] + P3dx, P2[1] + P3dy];

P4dx = -35;
P4dy = 35;
P4 = [P3[0] + P4dx, P3[1] + P4dy];

P5dx = 0;
P5dy = 45;
P5 = [P4[0] + P5dx, P4[1] + P5dy];

P6dx = 35;
P6dy = 35;
P6 = [P5[0] + P6dx, P5[1] + P6dy];

P7dx = 0;
P7dy = 70;
P7 = [P6[0] + P7dx, P6[1] + P7dy];

P8dx = -15;
P8dy = 15;
P8 = [P7[0] + P8dx, P7[1] + P8dy];

P9dx = -35;
P9dy = 0;
P9 = [P8[0] + P9dx, P8[1] + P9dy];

P10dx = -15;
P10dy = 15;
P10 = [P9[0] + P10dx, P9[1] + P10dy];

P11dx = 0;
P11dy = 30;
P11 = [P10[0] + P11dx, P10[1] + P11dy];

P12dx = 15;
P12dy = 0;
P12 = [P11[0] + P12dx, P11[1] + P12dy];

P13dx = 0;
P13dy = -10;
P13 = [P12[0] + P13dx, P12[1] + P13dy];

P14dx = 160;
P14dy = 0;
P14 = [P13[0] + P14dx, P13[1] + P14dy];

P15dx = 0;
P15dy = 10;
P15 = [P14[0] + P15dx, P14[1] + P15dy];

P16dx = 15;
P16dy = 0;
P16 = [P15[0] + P16dx, P15[1] + P16dy];

P17dx = 0;
P17dy = -30;
P17 = [P16[0] + P17dx, P16[1] + P17dy];

P18dx = -15;
P18dy = -15;
P18 = [P17[0] + P18dx, P17[1] + P18dy];

P19dx = -50;
P19dy = 0;
P19 = [P18[0] + P19dx, P18[1] + P19dy];

P20dx = -15;
P20dy = -15;
P20 = [P19[0] + P20dx, P19[1] + P20dy];

P21dx = 0;
P21dy = -70;
P21 = [P20[0] + P21dx, P20[1] + P21dy];

P22dx = 35;
P22dy = -35;
P22 = [P21[0] + P22dx, P21[1] + P22dy];

P23dx = 95;
P23dy = 0;
P23 = [P22[0] + P23dx, P22[1] + P23dy];

P24dx = 20;
P24dy = -20;
P24 = [P23[0] + P24dx, P23[1] + P24dy];

P25dx = 0;
P25dy = -40;
P25 = [P24[0] + P25dx, P24[1] + P25dy];

P26dx = -150;
P26dy = 0;
P26 = [P25[0] + P26dx, P25[1] + P26dy];

P27dx = 0;
P27dy = -160;
P27 = [P26[0] + P27dx, P26[1] + P27dy];

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
P27]);
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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

}
}

Polygon_1();
      
      rotate([0, 90, 0])
      rotate_extrude(angle = 270)
      rotate([0, 0, 90])
      Polygon_1(false);
      
    


      module Polygon_2(displayDistance = true) {

P0dx = 27;
P0dy = 376;
P0 = [P0dx, P0dy];

P1dx = -1;
P1dy = 18;
P1 = [P0[0] + P1dx, P0[1] + P1dy];

P2dx = -40;
P2dy = 61;
P2 = [P1[0] + P2dx, P1[1] + P2dy];

P3dx = -25;
P3dy = 85;
P3 = [P2[0] + P3dx, P2[1] + P3dy];

P4dx = 25;
P4dy = 75;
P4 = [P3[0] + P4dx, P3[1] + P4dy];

P5dx = 40;
P5dy = 45;
P5 = [P4[0] + P5dx, P4[1] + P5dy];

P6dx = 146;
P6dy = 0;
P6 = [P5[0] + P6dx, P5[1] + P6dy];

P7dx = 40;
P7dy = -45;
P7 = [P6[0] + P7dx, P6[1] + P7dy];

P8dx = 25;
P8dy = -75;
P8 = [P7[0] + P8dx, P7[1] + P8dy];

P9dx = -25;
P9dy = -85;
P9 = [P8[0] + P9dx, P8[1] + P9dy];

P10dx = -40;
P10dy = -61;
P10 = [P9[0] + P10dx, P9[1] + P10dy];

P11dx = 0;
P11dy = -20;
P11 = [P10[0] + P11dx, P10[1] + P11dy];

P12dx = -11;
P12dy = 2;
P12 = [P11[0] + P12dx, P11[1] + P12dy];

P13dx = 0;
P13dy = 20;
P13 = [P12[0] + P13dx, P12[1] + P13dy];

P14dx = 35;
P14dy = 55;
P14 = [P13[0] + P14dx, P13[1] + P14dy];

P15dx = 27;
P15dy = 86;
P15 = [P14[0] + P15dx, P14[1] + P15dy];

P16dx = -25;
P16dy = 75;
P16 = [P15[0] + P16dx, P15[1] + P16dy];

P17dx = -30;
P17dy = 30;
P17 = [P16[0] + P17dx, P16[1] + P17dy];

P18dx = -135;
P18dy = 1;
P18 = [P17[0] + P18dx, P17[1] + P18dy];

P19dx = -37;
P19dy = -45;
P19 = [P18[0] + P19dx, P18[1] + P19dy];

P20dx = -21;
P20dy = -60;
P20 = [P19[0] + P20dx, P19[1] + P20dy];

P21dx = 29;
P21dy = -91;
P21 = [P20[0] + P21dx, P20[1] + P21dy];

P22dx = 33;
P22dy = -50;
P22 = [P21[0] + P22dx, P21[1] + P22dy];

P23dx = 1;
P23dy = -23;
P23 = [P22[0] + P23dx, P22[1] + P23dy];

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
P23]);
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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
          40,
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

}
}

Polygon_2();
      
      rotate([0, 90, 0])
      rotate_extrude(angle = 270)
      rotate([0, 0, 90])
      Polygon_2(false);
      
    
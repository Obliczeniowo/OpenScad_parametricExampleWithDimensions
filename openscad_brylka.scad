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
}module Polygon_0(displayDistance = true) {

P0dx = 0;
P0dy = 0;
P0 = [P0dx, P0dy];

P1dx = 100;
P1dy = 0;
P1 = [P0[0] + P1dx, P0[1] + P1dy];

P2dx = -100;
P2dy = 100;
P2 = [P1[0] + P2dx, P1[1] + P2dy];

polygon([P0,
P1,
P2]);
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

}
}

module Polygon_1(displayDistance = true) {

P0dx = 300;
P0dy = 0;
P0 = [P0dx, P0dy];

P1dx = 0;
P1dy = -165;
P1 = [P0[0] + P1dx, P0[1] + P1dy];

P2dx = 50;
P2dy = -50;
P2 = [P1[0] + P2dx, P1[1] + P2dy];

P3dx = 115;
P3dy = 0;
P3 = [P2[0] + P3dx, P2[1] + P3dy];

P4dx = 50;
P4dy = 50;
P4 = [P3[0] + P4dx, P3[1] + P4dy];

P5dx = 0;
P5dy = 100;
P5 = [P4[0] + P5dx, P4[1] + P5dy];

P6dx = 300;
P6dy = 0;
P6 = [P5[0] + P6dx, P5[1] + P6dy];

P7dx = 0;
P7dy = 65;
P7 = [P6[0] + P7dx, P6[1] + P7dy];

polygon([P0,
P1,
P2,
P3,
P4,
P5,
P6,
P7]);
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

}
}

module Polygon_2(displayDistance = true) {

P0dx = 300;
P0dy = 0;
P0 = [P0dx, P0dy];

P1dx = 470;
P1dy = 0;
P1 = [P0[0] + P1dx, P0[1] + P1dy];

P2dx = 40;
P2dy = 40;
P2 = [P1[0] + P2dx, P1[1] + P2dy];

P3dx = 0;
P3dy = 100;
P3 = [P2[0] + P3dx, P2[1] + P3dy];

P4dx = -40;
P4dy = 40;
P4 = [P3[0] + P4dx, P3[1] + P4dy];

P5dx = -470;
P5dy = 0;
P5 = [P4[0] + P5dx, P4[1] + P5dy];

polygon([P0,
P1,
P2,
P3,
P4,
P5]);
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

}
}


module Polygon_3(displayDistance = true) {

P0dx = 300;
P0dy = 0;
P0 = [P0dx, P0dy];

P1dx = 0;
P1dy = 180;
P1 = [P0[0] + P1dx, P0[1] + P1dy];

P2dx = -215;
P2dy = 0;
P2 = [P1[0] + P2dx, P1[1] + P2dy];

P3dx = 0;
P3dy = -40;
P3 = [P2[0] + P3dx, P2[1] + P3dy];

P4dx = 150;
P4dy = 0;
P4 = [P3[0] + P4dx, P3[1] + P4dy];

P5dx = 0;
P5dy = -100;
P5 = [P4[0] + P5dx, P4[1] + P5dy];

P6dx = -150;
P6dy = 0;
P6 = [P5[0] + P6dx, P5[1] + P6dy];

P7dx = 0;
P7dy = -40;
P7 = [P6[0] + P7dx, P6[1] + P7dy];

polygon([P0,
P1,
P2,
P3,
P4,
P5,
P6,
P7]);
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

}
}
if (false) {
    translate([-300, 0, 0]){
        rotate([-90,0,0])
        Polygon_1(false);
        Polygon_2(false);
    }

    rotate([0, 90, 0])
    translate([-300, 0, 0])
    Polygon_3(false);
}

if (true) {
    intersection() {

        translate([-300, 0, 0]){
        intersection(){
            rotate([-90,0,0])
            linear_extrude(180)
            Polygon_1(false);
            linear_extrude(220)
            Polygon_2(false);
        }
        }

        rotate([0, 90, 0])
        linear_extrude(550)
        translate([-300, 0, 0])
        Polygon_3(false);
    }
}

import 'dart:math';
import 'dart:ui';

import 'package:ShareApp/constants/color_constant.dart';
import 'package:ShareApp/models/buttontapped.dart';
import 'package:ShareApp/screens/Local_Sharing/createGrp.dart';
import 'package:ShareApp/screens/Local_Sharing/joinGrp.dart';
import 'package:ShareApp/screens/Local_Sharing/recieveOne.dart';
import 'package:ShareApp/screens/Local_Sharing/sendOne.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearby_connections/nearby_connections.dart';
// import 'package:ShareApp/models/try_switch.dart';

class Local_Sharing extends StatefulWidget {
  @override
  _Local_SharingState createState() => _Local_SharingState();
}

class _Local_SharingState extends State<Local_Sharing> {
  final String userName = Random().nextInt(10000).toString();
  bool toggleValue = false;
  // bool check = CrazySwitch.isChecked;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Center(
              child: Text('Hi Someone, or anyother text if any ',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      color: mTitleColor,
                      fontSize: 16)),
            ),
          ),
          SizedBox(height: 30),
          // All the Images and

          // bool check = CrazySwitch.isChecked;
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          offset: Offset(0.0, 0.2),
                          blurRadius: 6.0,
                        )
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      'assets/images/main.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Row(
            children: <Widget>[
              SizedBox(width: MediaQuery.of(context).size.width / 3 + 10),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 40.0,
                width: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: toggleValue == false
                      ? Colors.blueAccent[100]
                      : Colors.blueAccent[100],
                ),
                child: Stack(
                  children: <Widget>[
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                      top: 3.0,
                      left: toggleValue ? 60.0 : 0.0,
                      right: toggleValue ? 0.0 : 60.0,
                      child: InkWell(
                        onTap: toggleButton,
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                                child: child, scale: animation);
                          },
                          child: !toggleValue
                              ? Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 35.0,
                                  key: UniqueKey(),
                                )
                              : Icon(
                                  Icons.group,
                                  color: Colors.white,
                                  size: 35.0,
                                  key: UniqueKey(),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Center(
            child: Column(
              children: <Widget>[
                buildHomeScreenButton(context, toggleValue),
              ],
            ),
          ),

          // ends
        ],
      ),
    );
  }

  Widget buildHomeScreenButton(BuildContext context, bool value) {
    if (!value) {
      return Padding(
          padding: EdgeInsets.all(16),
          child: Row(children: <Widget>[
            Expanded(
                child: GestureDetector(
              onTap: () async {
                if (await Nearby().checkLocationPermission()) {
                  if (await Nearby().checkExternalStoragePermission()) {
                    if (await Nearby().checkLocationEnabled()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => sendOne(userName)));
                    } else {
                      if (await Nearby().enableLocationServices()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => sendOne(userName)));
                      }
                    }
                  } else {
                    Nearby().askExternalStoragePermission();
                    if (await Nearby().checkLocationEnabled()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => sendOne(userName)));
                    } else {
                      if (await Nearby().enableLocationServices()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => sendOne(userName)));
                      }
                    }
                  }
                } else {
                  if (await Nearby().askLocationPermission()) {
                    if (await Nearby().checkExternalStoragePermission()) {
                      if (await Nearby().checkLocationEnabled()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => sendOne(userName)));
                      } else {
                        if (await Nearby().enableLocationServices()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => sendOne(userName)));
                        }
                      }
                    } else {
                      Nearby().askExternalStoragePermission();
                      if (await Nearby().checkLocationEnabled()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => sendOne(userName)));
                      } else {
                        if (await Nearby().enableLocationServices()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => sendOne(userName)));
                        }
                      }
                    }
                  }
                }
              },
              child: ButtonTapped(icon: Icons.share),

            )),
            Expanded(
                child: GestureDetector(
              onTap: () async {
                if (await Nearby().checkLocationPermission()) {
                  if (await Nearby().checkExternalStoragePermission()) {
                    if (await Nearby().checkLocationEnabled()) {
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => sharing("recieve",userName)));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => recieveOne(userName)));
                    } else {
                      if (await Nearby().enableLocationServices()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => recieveOne(userName)));
                      }
                    }
                  } else {
                    Nearby().askExternalStoragePermission();
                    if (await Nearby().checkLocationEnabled()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => recieveOne(userName)));
                    } else {
                      if (await Nearby().enableLocationServices()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => recieveOne(userName)));
                      }
                    }
                  }
                } else {
                  if (await Nearby().askLocationPermission()) {
                    if (await Nearby().checkExternalStoragePermission()) {
                      if (await Nearby().checkLocationEnabled()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => recieveOne(userName)));
                      } else {
                        if (await Nearby().enableLocationServices()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => recieveOne(userName)));
                        }
                      }
                    } else {
                      Nearby().askExternalStoragePermission();
                      if (await Nearby().checkLocationEnabled()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => recieveOne(userName)));
                      } else {
                        if (await Nearby().enableLocationServices()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => recieveOne(userName)));
                        }
                      }
                    }
                  }
                }
              },
              child: ButtonTapped(icon: Icons.call_received),
            ))
          ]));
    } else {
      return Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: GestureDetector(
                // ON TAP FUCNTION FOR JOIN A GROUP
                onTap: () async {
                  if (await Nearby().checkLocationPermission()) {
                    if (await Nearby().checkExternalStoragePermission()) {
                      if (await Nearby().checkLocationEnabled()) {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => sharing("recieve",userName)));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => joinGrp(userName)));
                      } else {
                        if (await Nearby().enableLocationServices()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => joinGrp(userName)));
                        }
                      }
                    } else {
                      Nearby().askExternalStoragePermission();
                      if (await Nearby().checkLocationEnabled()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => joinGrp(userName)));
                      } else {
                        if (await Nearby().enableLocationServices()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => joinGrp(userName)));
                        }
                      }
                    }
                  } else {
                    if (await Nearby().askLocationPermission()) {
                      if (await Nearby().checkExternalStoragePermission()) {
                        if (await Nearby().checkLocationEnabled()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => joinGrp(userName)));
                        } else {
                          if (await Nearby().enableLocationServices()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => joinGrp(userName)));
                          }
                        }
                      } else {
                        Nearby().askExternalStoragePermission();
                        if (await Nearby().checkLocationEnabled()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => joinGrp(userName)));
                        } else {
                          if (await Nearby().enableLocationServices()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => joinGrp(userName)));
                          }
                        }
                      }
                    }
                  }
                },
                child: ButtonTapped(icon: Icons.group_add_rounded),
              )),
              Expanded(
                  child: GestureDetector(
                //  on tap function for join the group
                onTap: () async {
                  if (await Nearby().checkLocationPermission()) {
                    if (await Nearby().checkExternalStoragePermission()) {
                      if (await Nearby().checkLocationEnabled()) {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => sharing("recieve",userName)));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => createGrp(userName)));
                      } else {
                        if (await Nearby().enableLocationServices()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => createGrp(userName)));
                        }
                      }
                    } else {
                      Nearby().askExternalStoragePermission();
                      if (await Nearby().checkLocationEnabled()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => createGrp(userName)));
                      } else {
                        if (await Nearby().enableLocationServices()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => createGrp(userName)));
                        }
                      }
                    }
                  } else {
                    if (await Nearby().askLocationPermission()) {
                      if (await Nearby().checkExternalStoragePermission()) {
                        if (await Nearby().checkLocationEnabled()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => createGrp(userName)));
                        } else {
                          if (await Nearby().enableLocationServices()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => createGrp(userName)));
                          }
                        }
                      } else {
                        Nearby().askExternalStoragePermission();
                        if (await Nearby().checkLocationEnabled()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => createGrp(userName)));
                        } else {
                          if (await Nearby().enableLocationServices()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => createGrp(userName)));
                          }
                        }
                      }
                    }
                  }
                },
                child: ButtonTapped(icon: Icons.add_box_rounded),
              )),
            ],
          ));
    }
    // return Padding(
    //             padding: EdgeInsets.all(16),
    //             child: Row(
    //               children: <Widget>[
    //                 Expanded(
    //                     child: GestureDetector(
    //                   onTap: () async {
    //                     if (await Nearby().checkLocationPermission()) {
    //                       if (await Nearby()
    //                           .checkExternalStoragePermission()) {
    //                         if (await Nearby().checkLocationEnabled()) {
    //                           Navigator.push(
    //                               context,
    //                               MaterialPageRoute(
    //                                   builder: (context) =>
    //                                       sendOne(userName)));
    //                         } else {
    //                           if (await Nearby().enableLocationServices()) {
    //                             Navigator.push(
    //                                 context,
    //                                 MaterialPageRoute(
    //                                     builder: (context) =>
    //                                         sendOne(userName)));
    //                           }
    //                         }
    //                       } else {
    //                         Nearby().askExternalStoragePermission();
    //                         if (await Nearby().checkLocationEnabled()) {
    //                           Navigator.push(
    //                               context,
    //                               MaterialPageRoute(
    //                                   builder: (context) =>
    //                                       sendOne(userName)));
    //                         } else {
    //                           if (await Nearby().enableLocationServices()) {
    //                             Navigator.push(
    //                                 context,
    //                                 MaterialPageRoute(
    //                                     builder: (context) =>
    //                                         sendOne(userName)));
    //                           }
    //                         }
    //                       }
    //                     } else {
    //                       if (await Nearby().askLocationPermission()) {
    //                         if (await Nearby()
    //                             .checkExternalStoragePermission()) {
    //                           if (await Nearby().checkLocationEnabled()) {
    //                             Navigator.push(
    //                                 context,
    //                                 MaterialPageRoute(
    //                                     builder: (context) =>
    //                                         sendOne(userName)));
    //                           } else {
    //                             if (await Nearby().enableLocationServices()) {
    //                               Navigator.push(
    //                                   context,
    //                                   MaterialPageRoute(
    //                                       builder: (context) =>
    //                                           sendOne(userName)));
    //                             }
    //                           }
    //                         } else {
    //                           Nearby().askExternalStoragePermission();
    //                           if (await Nearby().checkLocationEnabled()) {
    //                             Navigator.push(
    //                                 context,
    //                                 MaterialPageRoute(
    //                                     builder: (context) =>
    //                                         sendOne(userName)));
    //                           } else {
    //                             if (await Nearby().enableLocationServices()) {
    //                               Navigator.push(
    //                                   context,
    //                                   MaterialPageRoute(
    //                                       builder: (context) =>
    //                                           sendOne(userName)));
    //                             }
    //                           }
    //                         }
    //                       }
    //                     }
    //                   },
    //                   child: ButtonTapped(icon: Icons.share),
    //                 )),
    //                 Expanded(
    //                     child: GestureDetector(
    //                   onTap: () async {
    //                     if (await Nearby().checkLocationPermission()) {
    //                       if (await Nearby()
    //                           .checkExternalStoragePermission()) {
    //                         if (await Nearby().checkLocationEnabled()) {
    //                           //Navigator.push(context, MaterialPageRoute(builder: (context) => sharing("recieve",userName)));
    //                           Navigator.push(
    //                               context,
    //                               MaterialPageRoute(
    //                                   builder: (context) =>
    //                                       recieveOne(userName)));
    //                         } else {
    //                           if (await Nearby().enableLocationServices()) {
    //                             Navigator.push(
    //                                 context,
    //                                 MaterialPageRoute(
    //                                     builder: (context) =>
    //                                         recieveOne(userName)));
    //                           }
    //                         }
    //                       } else {
    //                         Nearby().askExternalStoragePermission();
    //                         if (await Nearby().checkLocationEnabled()) {
    //                           Navigator.push(
    //                               context,
    //                               MaterialPageRoute(
    //                                   builder: (context) =>
    //                                       recieveOne(userName)));
    //                         } else {
    //                           if (await Nearby().enableLocationServices()) {
    //                             Navigator.push(
    //                                 context,
    //                                 MaterialPageRoute(
    //                                     builder: (context) =>
    //                                         recieveOne(userName)));
    //                           }
    //                         }
    //                       }
    //                     } else {
    //                       if (await Nearby().askLocationPermission()) {
    //                         if (await Nearby()
    //                             .checkExternalStoragePermission()) {
    //                           if (await Nearby().checkLocationEnabled()) {
    //                             Navigator.push(
    //                                 context,
    //                                 MaterialPageRoute(
    //                                     builder: (context) =>
    //                                         recieveOne(userName)));
    //                           } else {
    //                             if (await Nearby().enableLocationServices()) {
    //                               Navigator.push(
    //                                   context,
    //                                   MaterialPageRoute(
    //                                       builder: (context) =>
    //                                           recieveOne(userName)));
    //                             }
    //                           }
    //                         } else {
    //                           Nearby().askExternalStoragePermission();
    //                           if (await Nearby().checkLocationEnabled()) {
    //                             Navigator.push(
    //                                 context,
    //                                 MaterialPageRoute(
    //                                     builder: (context) =>
    //                                         recieveOne(userName)));
    //                           } else {
    //                             if (await Nearby().enableLocationServices()) {
    //                               Navigator.push(
    //                                   context,
    //                                   MaterialPageRoute(
    //                                       builder: (context) =>
    //                                           recieveOne(userName)));
    //                             }
    //                           }
    //                         }
    //                       }
    //                     }
    //                   },
    //                   child: ButtonTapped(icon: Icons.call_received),
    //     )),
    //     Expanded(
    //         child: GestureDetector(
    //       // ON TAP FUCNTION FOR JOIN A GROUP
    //       onTap: () async {
    //         if (await Nearby().checkLocationPermission()) {
    //           if (await Nearby()
    //               .checkExternalStoragePermission()) {
    //             if (await Nearby().checkLocationEnabled()) {
    //               //Navigator.push(context, MaterialPageRoute(builder: (context) => sharing("recieve",userName)));
    //               Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: (context) =>
    //                           joinGrp(userName)));
    //             } else {
    //               if (await Nearby().enableLocationServices()) {
    //                 Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (context) =>
    //                             joinGrp(userName)));
    //               }
    //             }
    //           } else {
    //             Nearby().askExternalStoragePermission();
    //             if (await Nearby().checkLocationEnabled()) {
    //               Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: (context) =>
    //                           joinGrp(userName)));
    //             } else {
    //               if (await Nearby().enableLocationServices()) {
    //                 Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (context) =>
    //                             joinGrp(userName)));
    //               }
    //             }
    //           }
    //         } else {
    //           if (await Nearby().askLocationPermission()) {
    //             if (await Nearby()
    //                 .checkExternalStoragePermission()) {
    //               if (await Nearby().checkLocationEnabled()) {
    //                 Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (context) =>
    //                             joinGrp(userName)));
    //               } else {
    //                 if (await Nearby().enableLocationServices()) {
    //                   Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (context) =>
    //                               joinGrp(userName)));
    //                 }
    //               }
    //             } else {
    //               Nearby().askExternalStoragePermission();
    //               if (await Nearby().checkLocationEnabled()) {
    //                 Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (context) =>
    //                             joinGrp(userName)));
    //               } else {
    //                 if (await Nearby().enableLocationServices()) {
    //                   Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (context) =>
    //                               joinGrp(userName)));
    //                 }
    //               }
    //             }
    //           }
    //         }
    //       },
    //       child: ButtonTapped(icon: Icons.group_add_rounded),
    //     )),
    //     Expanded(
    //         child: GestureDetector(
    //       //  on tap function for join the group
    //       onTap: () async {
    //         if (await Nearby().checkLocationPermission()) {
    //           if (await Nearby()
    //               .checkExternalStoragePermission()) {
    //             if (await Nearby().checkLocationEnabled()) {
    //               //Navigator.push(context, MaterialPageRoute(builder: (context) => sharing("recieve",userName)));
    //               Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: (context) =>
    //                           createGrp(userName)));
    //             } else {
    //               if (await Nearby().enableLocationServices()) {
    //                 Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (context) =>
    //                             createGrp(userName)));
    //               }
    //             }
    //           } else {
    //             Nearby().askExternalStoragePermission();
    //             if (await Nearby().checkLocationEnabled()) {
    //               Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: (context) =>
    //                           createGrp(userName)));
    //             } else {
    //               if (await Nearby().enableLocationServices()) {
    //                 Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (context) =>
    //                             createGrp(userName)));
    //               }
    //             }
    //           }
    //         } else {
    //           if (await Nearby().askLocationPermission()) {
    //             if (await Nearby()
    //                 .checkExternalStoragePermission()) {
    //               if (await Nearby().checkLocationEnabled()) {
    //                 Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (context) =>
    //                             createGrp(userName)));
    //               } else {
    //                 if (await Nearby().enableLocationServices()) {
    //                   Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (context) =>
    //                               createGrp(userName)));
    //                 }
    //               }
    //             } else {
    //               Nearby().askExternalStoragePermission();
    //               if (await Nearby().checkLocationEnabled()) {
    //                 Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (context) =>
    //                             createGrp(userName)));
    //               } else {
    //                 if (await Nearby().enableLocationServices()) {
    //                   Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (context) =>
    //                               createGrp(userName)));
    //                 }
    //               }
    //             }
    //           }
    //         }
    //       },
    //       child: ButtonTapped(icon: Icons.add_box_rounded),
    //     )),
    //   ],
    // ),
    //           );
  }

  void toggleButton() {
    setState(() {
      toggleValue = !toggleValue;
    });
  }
}

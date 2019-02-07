import QtQuick 2.11
import QtQuick.Window 2.11

import QtQuick.Controls 2.4
import QtDataVisualization 1.2

Window {
    id: root
    visible: true
    width: 640
    height: 680
    title: qsTr("SH")



    Item {
        focus: true

        id: chart_3d
        width: 640
        height: 480

        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "red"
        }

        Surface3D {
            width: parent.width
            height: parent.height

            axisY: ValueAxis3D {
                autoAdjustRange: false
                min: -5
                max: 5
                segmentCount: 5
            }

            polar: true

            shadowQuality: AbstractGraph3D.ShadowQualityNone

            Surface3DSeries {
                drawMode: Surface3DSeries.DrawSurface

                itemLabelFormat: "SH value at (@xLabel, @zLabel): @yLabel"
                ItemModelSurfaceDataProxy {

                    itemModel: model_SH
                    // Mapping model roles to surface series rows, columns, and values.
                    rowRole: "theta"
                    columnRole: "phi"
                    yPosRole: "sh_val"
                }
            }


        }
        Keys.onSpacePressed: {
            if( model_SH.count !=0 )
                model_SH.clear();

            populateSH_Model();
        }
    }

    Slider {
        id: slid_1
        anchors.top: chart_3d.bottom
        anchors.left: chart_3d.left
        anchors.right:  chart_3d.right

        from: -1; value: 1; to: 3
        stepSize: 0.1
        live: false

        onValueChanged: {
            recalculate_SH( 1, value );
        }
    }

    Slider {
        id: slid_2
        anchors.top: slid_1.bottom
        anchors.left: slid_1.left
        anchors.right:  slid_1.right

        from: -1; value: 1; to: 3
        stepSize: 0.1
        snapMode: Slider.SnapAlways
        live: false

        onValueChanged: {
            recalculate_SH( 2, value );
        }
    }


    Slider {
        id: slid_3
        anchors.top: slid_2.bottom
        anchors.left: slid_2.left
        anchors.right:  slid_2.right

        from: -1; value: 1; to: 3
        stepSize: 0.1
        live: false

        onValueChanged: {
            recalculate_SH( 3, value );
        }
    }

    //L2
    Slider {
        id: slid_4
        anchors.top: slid_3.bottom
        anchors.left: slid_3.left
        anchors.right:  slid_3.right

        from: -1; value: 1; to: 3
        stepSize: 0.1
        live: false

        onValueChanged: {
            recalculate_SH( 4, value );
        }
    }
    Slider {
        id: slid_5
        anchors.top: slid_4.bottom
        anchors.left: slid_4.left
        anchors.right:  slid_4.right

        from: -1; value: 1; to: 3
        stepSize: 0.1
        live: false

        onValueChanged: {
            recalculate_SH( 5, value );
        }
    }
    Slider {
        id: slid_6
        anchors.top: slid_5.bottom
        anchors.left: slid_5.left
        anchors.right:  slid_5.right

        from: -1; value: 1; to: 3
        stepSize: 0.1
        live: false

        onValueChanged: {
            recalculate_SH( 6, value );
        }
    }
    Slider {
        id: slid_7
        anchors.top: slid_6.bottom
        anchors.left: slid_6.left
        anchors.right:  slid_6.right

        from: -1; value: 1; to: 3
        stepSize: 0.1
        live: false

        onValueChanged: {
            recalculate_SH( 7, value );
        }
    }
    Slider {
        id: slid_8
        anchors.top: slid_7.bottom
        anchors.left: slid_7.left
        anchors.right:  slid_7.right

        from: -1; value: 1; to: 3
        stepSize: 0.1
        live: false

        onValueChanged: {
            recalculate_SH( 8, value );
        }
    }

    // sum
    ListModel{
        id: model_SH
    }

    //L1
    ListModel{
        id: model_Y_n1_1
    }

    ListModel{
        id: model_Y_0_1
    }

    ListModel{
        id: model_Y_1_1
    }

    //L2
    ListModel{
        id: model_Y_n2_2
    }

    ListModel{
        id: model_Y_n1_2
    }

    ListModel{
        id: model_Y_0_2
    }

    ListModel{
        id: model_Y_1_2
    }

    ListModel{
        id: model_Y_2_2
    }



    property int theta_step: 180
    property int phi_step: 360
    property real divisor: 3



    function recalculate_SH( degree, coefficient ){
//        degree = 1;

        switch(degree){

        // L1
        case 1:
            for( var i =0; i<model_SH.count; i++  ){
                var sh_val = model_SH.get(i).sh_val;
                var sh_old_val = model_Y_n1_1.get(i).sh_val;
                var sh_old_val_c = model_Y_n1_1.get(i).sh_val_c;
                var sh_old_c = model_Y_n1_1.get(i).coefficient;
                var sh_new_val_c = sh_old_val * coefficient;
                sh_val = sh_val - sh_old_val_c + sh_new_val_c;

                model_Y_n1_1.setProperty( i, "sh_val_c", sh_new_val_c );
                model_Y_n1_1.setProperty( i, "coefficient", coefficient );
                model_SH.setProperty( i, "sh_val", sh_val );
            }
            console.log( "1: " + sh_old_c)
            console.log( "1: " + coefficient)
            console.log( model_SH.count)
            break;
        case 2:
            for( i =0; i<model_SH.count; i++  ){
                sh_val = model_SH.get(i).sh_val;
                sh_old_val = model_Y_0_1.get(i).sh_val;
                sh_old_val_c = model_Y_0_1.get(i).sh_val_c;
                sh_old_c = model_Y_0_1.get(i).coefficient;
                sh_new_val_c = sh_old_val * coefficient;
                sh_val = sh_val - sh_old_val_c + sh_new_val_c;

                model_Y_0_1.setProperty( i, "sh_val_c", sh_new_val_c );
                model_Y_0_1.setProperty( i, "coefficient", coefficient );
                model_SH.setProperty( i, "sh_val", sh_val );
            }
            console.log( "2: " + sh_old_c)
            console.log( "2: " + coefficient)
            console.log( model_SH.count)
            break;
        case 3:
            for( i =0; i<model_SH.count; i++  ){
                sh_val = model_SH.get(i).sh_val;
                sh_old_val = model_Y_1_1.get(i).sh_val;
                sh_old_val_c = model_Y_1_1.get(i).sh_val_c;
                sh_old_c = model_Y_1_1.get(i).coefficient;
                sh_new_val_c = sh_old_val * coefficient;
                sh_val = sh_val - sh_old_val_c + sh_new_val_c;

                model_Y_1_1.setProperty( i, "sh_val_c", sh_new_val_c );
                model_Y_1_1.setProperty( i, "coefficient", coefficient );
                model_SH.setProperty( i, "sh_val", sh_val );
            }
            console.log( "3: " + sh_old_c)
            console.log( "3: " + coefficient)
            console.log( model_SH.count)
            break;

            // L2
        case 4:
            for( i =0; i<model_SH.count; i++  ){
                sh_val = model_SH.get(i).sh_val;
                sh_old_val = model_Y_n2_2.get(i).sh_val;
                sh_old_val_c = model_Y_n2_2.get(i).sh_val_c;
                sh_old_c = model_Y_n2_2.get(i).coefficient;
                sh_new_val_c = sh_old_val * coefficient;
                sh_val = sh_val - sh_old_val_c + sh_new_val_c;

                model_Y_n2_2.setProperty( i, "sh_val_c", sh_new_val_c );
                model_Y_n2_2.setProperty( i, "coefficient", coefficient );
                model_SH.setProperty( i, "sh_val", sh_val );
            }
            console.log( "4: " + sh_old_c)
            console.log( "4: " + coefficient)
            console.log( model_SH.count)
            break;
        case 5:
            for( i =0; i<model_SH.count; i++  ){
                sh_val = model_SH.get(i).sh_val;
                sh_old_val = model_Y_n1_2.get(i).sh_val;
                sh_old_val_c = model_Y_n1_2.get(i).sh_val_c;
                sh_old_c = model_Y_n1_2.get(i).coefficient;
                sh_new_val_c = sh_old_val * coefficient;
                sh_val = sh_val - sh_old_val_c + sh_new_val_c;

                model_Y_n1_2.setProperty( i, "sh_val_c", sh_new_val_c );
                model_Y_n1_2.setProperty( i, "coefficient", coefficient );
                model_SH.setProperty( i, "sh_val", sh_val );
            }
            console.log( "5: " + sh_old_c)
            console.log( "5: " + coefficient)
            console.log( model_SH.count)
            break;
        case 6:
            for( i =0; i<model_SH.count; i++  ){
                sh_val = model_SH.get(i).sh_val;
                sh_old_val = model_Y_0_2.get(i).sh_val;
                sh_old_val_c = model_Y_0_2.get(i).sh_val_c;
                sh_old_c = model_Y_0_2.get(i).coefficient;
                sh_new_val_c = sh_old_val * coefficient;
                sh_val = sh_val - sh_old_val_c + sh_new_val_c;

                model_Y_0_2.setProperty( i, "sh_val_c", sh_new_val_c );
                model_Y_0_2.setProperty( i, "coefficient", coefficient );
                model_SH.setProperty( i, "sh_val", sh_val );
            }
            console.log( "6: " + sh_old_c)
            console.log( "6: " + coefficient)
            console.log( model_SH.count)
            break;

        case 7:
            for( i =0; i<model_SH.count; i++  ){
                sh_val = model_SH.get(i).sh_val;
                sh_old_val = model_Y_1_2.get(i).sh_val;
                sh_old_val_c = model_Y_1_2.get(i).sh_val_c;
                sh_old_c = model_Y_1_2.get(i).coefficient;
                sh_new_val_c = sh_old_val * coefficient;
                sh_val = sh_val - sh_old_val_c + sh_new_val_c;

                model_Y_1_2.setProperty( i, "sh_val_c", sh_new_val_c );
                model_Y_1_2.setProperty( i, "coefficient", coefficient );
                model_SH.setProperty( i, "sh_val", sh_val );
            }
            console.log( "7: " + sh_old_c)
            console.log( "7: " + coefficient)
            console.log( model_SH.count)
            break;

        case 8:
            for( i =0; i<model_SH.count; i++  ){
                sh_val = model_SH.get(i).sh_val;
                sh_old_val = model_Y_2_2.get(i).sh_val;
                sh_old_val_c = model_Y_2_2.get(i).sh_val_c;
                sh_old_c = model_Y_2_2.get(i).coefficient;
                sh_new_val_c = sh_old_val * coefficient;
                sh_val = sh_val - sh_old_val_c + sh_new_val_c;

                model_Y_2_2.setProperty( i, "sh_val_c", sh_new_val_c );
                model_Y_2_2.setProperty( i, "coefficient", coefficient );
                model_SH.setProperty( i, "sh_val", sh_val );
            }
            console.log( "8: " + sh_old_c)
            console.log( "8: " + coefficient)
            console.log( model_SH.count)
            break;
        }
    }

    function populateSH_Model(){
        for( var theta=0; theta<=theta_step; theta+=divisor){
            for( var phi=0; phi<=phi_step; phi+=divisor ){

                var theta_rad = theta * Math.PI / 180;
                var phi_rad = phi * Math.PI / 180;

                var Y_0_0 = Math.pow( 1/4*Math.PI, 0.5 );

                // L1
                var Y_n1_1 = Math.pow( 3/4*Math.PI, 0.5 ) * Math.sin(phi_rad) * Math.sin(theta_rad);
                model_Y_n1_1.append( {"theta": theta, "phi": phi, "sh_val": Y_n1_1, "coefficient": 1, "sh_val_c": Y_n1_1*1 } );

                var Y_0_1 = Math.pow( 3/4*Math.PI, 0.5 ) * Math.cos( theta_rad );
                model_Y_0_1.append( {"theta": theta, "phi": phi, "sh_val": Y_0_1, "coefficient": 1, "sh_val_c": Y_0_1*1 } );

                var Y_1_1 = Math.pow( 3/4*Math.PI, 0.5 ) * Math.cos(phi_rad) * Math.sin(theta_rad);
                model_Y_1_1.append( {"theta": theta, "phi": phi, "sh_val": Y_1_1, "coefficient": 1, "sh_val_c": Y_1_1*1 } );

                // L2
                var Y_n2_2 = Math.pow( 15/4*Math.PI, 0.5 ) * Math.sin(phi_rad) * Math.cos(phi_rad)* Math.pow(Math.sin(theta_rad),2);
                model_Y_n2_2.append( {"theta": theta, "phi": phi, "sh_val": Y_n2_2, "coefficient": 1, "sh_val_c": Y_n2_2*1 } );

                var Y_n1_2 = Math.pow( 15/4*Math.PI, 0.5 ) * Math.sin(phi_rad) * Math.sin(theta_rad)* Math.cos(theta_rad);
                model_Y_n1_2.append( {"theta": theta, "phi": phi, "sh_val": Y_n1_2, "coefficient": 1, "sh_val_c": Y_n1_2*1 } );

                var Y_0_2 = Math.pow( 5/16*Math.PI, 0.5 ) * 3 * Math.pow(Math.cos(theta_rad),2) - 1;
                model_Y_0_2.append( {"theta": theta, "phi": phi, "sh_val": Y_0_2, "coefficient": 1, "sh_val_c": Y_0_2*1 } );

                var Y_1_2 = Math.pow( 15/4*Math.PI, 0.5 ) * Math.cos(phi_rad) * Math.sin(theta_rad)* Math.cos(theta_rad);
                model_Y_1_2.append( {"theta": theta, "phi": phi, "sh_val": Y_1_2, "coefficient": 1, "sh_val_c": Y_1_2*1 } );

                var Y_2_2 = Math.pow( 15/16*Math.PI, 0.5 ) * (Math.pow(Math.cos(phi_rad),2) - Math.pow(Math.sin(phi_rad),2)) * Math.pow(Math.sin(theta_rad),2);
                model_Y_2_2.append( {"theta": theta, "phi": phi, "sh_val": Y_2_2, "coefficient": 1, "sh_val_c": Y_2_2*1 } );


                model_SH.append( {"theta": theta, "phi": phi, "sh_val": Y_n1_1 + Y_0_1 + Y_1_1 + Y_n2_2 + Y_n1_2 + Y_0_2 + Y_1_2 + Y_2_2 } );
            }
        }
    }
}

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2963E1CF913
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 17:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbgELPYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 11:24:35 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:36954 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730490AbgELPYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:24:33 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04CFIae7000767;
        Tue, 12 May 2020 10:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=KUG1ObVe4yGotkC8/s5inkX9+6CBrdkS/vw5VCRergo=;
 b=OefLpTIfyARdxCPrwfKw5ohoiXhW9VVhupFuwk7bpYkYkDmZOGeGHIg1axgYUjs8b7DA
 kkW3Qb2OXBmss8f3QTcOAHHJmJH8o++1z3XXCEklbQRGPImgakVY3ZThOHKUNgJ79+ze
 5J71VnhYkyYzyap6lCxRoIcwyYDXjbeEGmCz+WyKbMgELKAm11DrIAgWuU12ugAc3TgM
 BIFnq1iLckNJtzpNaCmcZYdwCtpUZf43UT64gKQaZ67v3OQI63uBzLg17tZvQdm+YvFr
 6XkGLuw12Sl3xZ8fwVRjd6BrT5G6a9IEgRYp0QHMJmgz1au8t5Zz0ziAgTEbmu8wZzgc mg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 30wsx3msj9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 May 2020 10:24:01 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 12 May
 2020 16:23:59 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 12 May 2020 16:23:59 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3B85F2C6;
        Tue, 12 May 2020 15:23:59 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <linus.walleij@linaro.org>
CC:     <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH v3 3/5] pinctrl: lochnagar: Move binding over to dtschema
Date:   Tue, 12 May 2020 16:23:56 +0100
Message-ID: <20200512152359.11839-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200512152359.11839-1-ckeepax@opensource.cirrus.com>
References: <20200512152359.11839-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v2:
 - Removed description for gpio-controller
 - Force pin node to be called pin-settings
 - Simplify -pins pattern
 - Add additional blank line

Thanks,
Charles

 .../bindings/pinctrl/cirrus,lochnagar.txt          | 141 ---------------
 .../bindings/pinctrl/cirrus,lochnagar.yaml         | 190 +++++++++++++++++++++
 2 files changed, 190 insertions(+), 141 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt b/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt
deleted file mode 100644
index a87447180e838..0000000000000
--- a/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt
+++ /dev/null
@@ -1,141 +0,0 @@
-Cirrus Logic Lochnagar Audio Development Board
-
-Lochnagar is an evaluation and development board for Cirrus Logic
-Smart CODEC and Amp devices. It allows the connection of most Cirrus
-Logic devices on mini-cards, as well as allowing connection of
-various application processor systems to provide a full evaluation
-platform.  Audio system topology, clocking and power can all be
-controlled through the Lochnagar, allowing the device under test
-to be used in a variety of possible use cases.
-
-This binding document describes the binding for the pinctrl portion
-of the driver.
-
-Also see these documents for generic binding information:
-  [1] GPIO : ../gpio/gpio.txt
-  [2] Pinctrl: ../pinctrl/pinctrl-bindings.txt
-
-And these for relevant defines:
-  [3] include/dt-bindings/pinctrl/lochnagar.h
-
-This binding must be part of the Lochnagar MFD binding:
-  [4] ../mfd/cirrus,lochnagar.txt
-
-Required properties:
-
-  - compatible : One of the following strings:
-                 "cirrus,lochnagar-pinctrl"
-
-  - gpio-controller : Indicates this device is a GPIO controller.
-  - #gpio-cells : Must be 2. The first cell is the pin number, see
-    [3] for available pins and the second cell is used to specify
-    optional parameters, see [1].
-  - gpio-ranges : Range of pins managed by the GPIO controller, see
-    [1]. Both the GPIO and Pinctrl base should be set to zero and the
-    count to the appropriate of the LOCHNAGARx_PIN_NUM_GPIOS define,
-    see [3].
-
-  - pinctrl-names : A pinctrl state named "default" must be defined.
-  - pinctrl-0 : A phandle to the default pinctrl state.
-
-Required sub-nodes:
-
-The pin configurations are defined as a child of the pinctrl states
-node, see [2]. Each sub-node can have the following properties:
-  - groups : A list of groups to select (either this or "pins" must be
-    specified), available groups:
-      codec-aif1, codec-aif2, codec-aif3, dsp-aif1, dsp-aif2, psia1,
-      psia2, gf-aif1, gf-aif2, gf-aif3, gf-aif4, spdif-aif, usb-aif1,
-      usb-aif2, adat-aif, soundcard-aif
-  - pins : A list of pin names to select (either this or "groups" must
-    be specified), available pins:
-      fpga-gpio1, fpga-gpio2, fpga-gpio3, fpga-gpio4, fpga-gpio5,
-      fpga-gpio6, codec-gpio1, codec-gpio2, codec-gpio3, codec-gpio4,
-      codec-gpio5, codec-gpio6, codec-gpio7, codec-gpio8, dsp-gpio1,
-      dsp-gpio2, dsp-gpio3, dsp-gpio4, dsp-gpio5, dsp-gpio6, gf-gpio2,
-      gf-gpio3, gf-gpio7, codec-aif1-bclk, codec-aif1-rxdat,
-      codec-aif1-lrclk, codec-aif1-txdat, codec-aif2-bclk,
-      codec-aif2-rxdat, codec-aif2-lrclk, codec-aif2-txdat,
-      codec-aif3-bclk, codec-aif3-rxdat, codec-aif3-lrclk,
-      codec-aif3-txdat, dsp-aif1-bclk, dsp-aif1-rxdat, dsp-aif1-lrclk,
-      dsp-aif1-txdat, dsp-aif2-bclk, dsp-aif2-rxdat,
-      dsp-aif2-lrclk, dsp-aif2-txdat, psia1-bclk, psia1-rxdat,
-      psia1-lrclk, psia1-txdat, psia2-bclk, psia2-rxdat, psia2-lrclk,
-      psia2-txdat, gf-aif3-bclk, gf-aif3-rxdat, gf-aif3-lrclk,
-      gf-aif3-txdat, gf-aif4-bclk, gf-aif4-rxdat, gf-aif4-lrclk,
-      gf-aif4-txdat, gf-aif1-bclk, gf-aif1-rxdat, gf-aif1-lrclk,
-      gf-aif1-txdat, gf-aif2-bclk, gf-aif2-rxdat, gf-aif2-lrclk,
-      gf-aif2-txdat, dsp-uart1-rx, dsp-uart1-tx, dsp-uart2-rx,
-      dsp-uart2-tx, gf-uart2-rx, gf-uart2-tx, usb-uart-rx,
-      codec-pdmclk1, codec-pdmdat1, codec-pdmclk2, codec-pdmdat2,
-      codec-dmicclk1, codec-dmicdat1, codec-dmicclk2, codec-dmicdat2,
-      codec-dmicclk3, codec-dmicdat3, codec-dmicclk4, codec-dmicdat4,
-      dsp-dmicclk1, dsp-dmicdat1, dsp-dmicclk2, dsp-dmicdat2, i2c2-scl,
-      i2c2-sda, i2c3-scl, i2c3-sda, i2c4-scl, i2c4-sda, dsp-standby,
-      codec-mclk1, codec-mclk2, dsp-clkin, psia1-mclk, psia2-mclk,
-      gf-gpio1, gf-gpio5, dsp-gpio20, led1, led2
-  - function : The mux function to select, available functions:
-      aif, fpga-gpio1, fpga-gpio2, fpga-gpio3, fpga-gpio4, fpga-gpio5,
-      fpga-gpio6, codec-gpio1, codec-gpio2, codec-gpio3, codec-gpio4,
-      codec-gpio5, codec-gpio6, codec-gpio7, codec-gpio8, dsp-gpio1,
-      dsp-gpio2, dsp-gpio3, dsp-gpio4, dsp-gpio5, dsp-gpio6, gf-gpio2,
-      gf-gpio3, gf-gpio7, gf-gpio1, gf-gpio5, dsp-gpio20, codec-clkout,
-      dsp-clkout, pmic-32k, spdif-clkout, clk-12m288, clk-11m2986,
-      clk-24m576, clk-22m5792, xmos-mclk, gf-clkout1, gf-mclk1,
-      gf-mclk3, gf-mclk2, gf-clkout2, codec-mclk1, codec-mclk2,
-      dsp-clkin, psia1-mclk, psia2-mclk, spdif-mclk, codec-irq,
-      codec-reset, dsp-reset, dsp-irq, dsp-standby, codec-pdmclk1,
-      codec-pdmdat1, codec-pdmclk2, codec-pdmdat2, codec-dmicclk1,
-      codec-dmicdat1, codec-dmicclk2, codec-dmicdat2, codec-dmicclk3,
-      codec-dmicdat3, codec-dmicclk4, codec-dmicdat4, dsp-dmicclk1,
-      dsp-dmicdat1, dsp-dmicclk2, dsp-dmicdat2, dsp-uart1-rx,
-      dsp-uart1-tx, dsp-uart2-rx, dsp-uart2-tx, gf-uart2-rx,
-      gf-uart2-tx, usb-uart-rx, usb-uart-tx, i2c2-scl, i2c2-sda,
-      i2c3-scl, i2c3-sda, i2c4-scl, i2c4-sda, spdif-aif, psia1,
-      psia1-bclk, psia1-lrclk, psia1-rxdat, psia1-txdat, psia2,
-      psia2-bclk, psia2-lrclk, psia2-rxdat, psia2-txdat, codec-aif1,
-      codec-aif1-bclk, codec-aif1-lrclk, codec-aif1-rxdat,
-      codec-aif1-txdat, codec-aif2, codec-aif2-bclk, codec-aif2-lrclk,
-      codec-aif2-rxdat, codec-aif2-txdat, codec-aif3, codec-aif3-bclk,
-      codec-aif3-lrclk, codec-aif3-rxdat, codec-aif3-txdat, dsp-aif1,
-      dsp-aif1-bclk, dsp-aif1-lrclk, dsp-aif1-rxdat, dsp-aif1-txdat,
-      dsp-aif2, dsp-aif2-bclk, dsp-aif2-lrclk, dsp-aif2-rxdat,
-      dsp-aif2-txdat, gf-aif3, gf-aif3-bclk, gf-aif3-lrclk,
-      gf-aif3-rxdat, gf-aif3-txdat, gf-aif4, gf-aif4-bclk,
-      gf-aif4-lrclk, gf-aif4-rxdat, gf-aif4-txdat, gf-aif1,
-      gf-aif1-bclk, gf-aif1-lrclk, gf-aif1-rxdat, gf-aif1-txdat,
-      gf-aif2, gf-aif2-bclk, gf-aif2-lrclk, gf-aif2-rxdat,
-      gf-aif2-txdat, usb-aif1, usb-aif2, adat-aif, soundcard-aif,
-
-  - output-enable : Specifies that an AIF group will be used as a master
-    interface (either this or input-enable is required if a group is
-    being muxed to an AIF)
-  - input-enable : Specifies that an AIF group will be used as a slave
-    interface (either this or output-enable is required if a group is
-    being muxed to an AIF)
-
-Example:
-
-lochnagar-pinctrl {
-	compatible = "cirrus,lochnagar-pinctrl";
-
-	gpio-controller;
-	#gpio-cells = <2>;
-	gpio-ranges = <&lochnagar 0 0 LOCHNAGAR2_PIN_NUM_GPIOS>;
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&pin-settings>;
-
-	pin-settings: pin-settings {
-		ap-aif {
-			input-enable;
-			groups = "gf-aif1";
-			function = "codec-aif3";
-		};
-		codec-aif {
-			output-enable;
-			groups = "codec-aif3";
-			function = "gf-aif1";
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml b/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml
new file mode 100644
index 0000000000000..420d74856032f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml
@@ -0,0 +1,190 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/cirrus,lochnagar.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic Lochnagar Audio Development Board
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+description: |
+  Lochnagar is an evaluation and development board for Cirrus Logic
+  Smart CODEC and Amp devices. It allows the connection of most Cirrus
+  Logic devices on mini-cards, as well as allowing connection of various
+  application processor systems to provide a full evaluation platform.
+  Audio system topology, clocking and power can all be controlled through
+  the Lochnagar, allowing the device under test to be used in a variety of
+  possible use cases.
+
+  This binding document describes the binding for the pinctrl portion of
+  the driver.
+
+  Also see these documents for generic binding information:
+    [1] GPIO : ../gpio/gpio.txt
+    [2] Pinctrl: ../pinctrl/pinctrl-bindings.txt
+
+  And these for relevant defines:
+    [3] include/dt-bindings/pinctrl/lochnagar.h
+
+  This binding must be part of the Lochnagar MFD binding:
+    [4] ../mfd/cirrus,lochnagar.yaml
+
+properties:
+  compatible:
+    enum:
+      - cirrus,lochnagar-pinctrl
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    description:
+      The first cell is the pin number and the second cell is used
+      to specify optional parameters.
+    const: 2
+
+  gpio-ranges:
+    description:
+      Range of pins managed by the GPIO controller, see [1]. Both the
+      GPIO and Pinctrl base should be set to zero and the count to the
+      appropriate of the LOCHNAGARx_PIN_NUM_GPIOS define, see [3].
+    maxItems: 1
+
+  pinctrl-0:
+    description:
+      A phandle to the default pinctrl state.
+
+  pinctrl-names:
+    description:
+      A pinctrl state named "default" must be defined.
+    const: default
+
+  pin-settings:
+    type: object
+    patternProperties:
+      '-pins$':
+        description:
+          The pin configurations are defined as a child of the pinctrl
+          states node, see [2]. Each sub-node can have the following
+          properties.
+        type: object
+        allOf:
+          - $ref: pincfg-node.yaml#
+          - $ref: pinmux-node.yaml#
+
+        properties:
+          groups:
+            description:
+              A list of groups to select (either this or "pins" must be
+              specified), available groups.
+            enum: [ codec-aif1, codec-aif2, codec-aif3, dsp-aif1,
+                    dsp-aif2, psia1, psia2, gf-aif1, gf-aif2, gf-aif3,
+                    gf-aif4, spdif-aif, usb-aif1, usb-aif2, adat-aif,
+                    soundcard-aif ]
+
+          pins:
+            description:
+              A list of pin names to select (either this or "groups" must
+              be specified), available pins.
+            enum: [ fpga-gpio1, fpga-gpio2, fpga-gpio3, fpga-gpio4,
+                    fpga-gpio5, fpga-gpio6, codec-gpio1, codec-gpio2,
+                    codec-gpio3, codec-gpio4, codec-gpio5, codec-gpio6,
+                    codec-gpio7, codec-gpio8, dsp-gpio1, dsp-gpio2,
+                    dsp-gpio3, dsp-gpio4, dsp-gpio5, dsp-gpio6,
+                    gf-gpio2, gf-gpio3, gf-gpio7, codec-aif1-bclk,
+                    codec-aif1-rxdat, codec-aif1-lrclk, codec-aif1-txdat,
+                    codec-aif2-bclk, codec-aif2-rxdat, codec-aif2-lrclk,
+                    codec-aif2-txdat, codec-aif3-bclk, codec-aif3-rxdat,
+                    codec-aif3-lrclk, codec-aif3-txdat, dsp-aif1-bclk,
+                    dsp-aif1-rxdat, dsp-aif1-lrclk, dsp-aif1-txdat,
+                    dsp-aif2-bclk, dsp-aif2-rxdat, dsp-aif2-lrclk,
+                    dsp-aif2-txdat, psia1-bclk, psia1-rxdat, psia1-lrclk,
+                    psia1-txdat, psia2-bclk, psia2-rxdat, psia2-lrclk,
+                    psia2-txdat, gf-aif3-bclk, gf-aif3-rxdat,
+                    gf-aif3-lrclk, gf-aif3-txdat, gf-aif4-bclk,
+                    gf-aif4-rxdat, gf-aif4-lrclk, gf-aif4-txdat,
+                    gf-aif1-bclk, gf-aif1-rxdat, gf-aif1-lrclk,
+                    gf-aif1-txdat, gf-aif2-bclk, gf-aif2-rxdat,
+                    gf-aif2-lrclk, gf-aif2-txdat, dsp-uart1-rx,
+                    dsp-uart1-tx, dsp-uart2-rx, dsp-uart2-tx,
+                    gf-uart2-rx, gf-uart2-tx, usb-uart-rx, codec-pdmclk1,
+                    codec-pdmdat1, codec-pdmclk2, codec-pdmdat2,
+                    codec-dmicclk1, codec-dmicdat1, codec-dmicclk2,
+                    codec-dmicdat2, codec-dmicclk3, codec-dmicdat3,
+                    codec-dmicclk4, codec-dmicdat4, dsp-dmicclk1,
+                    dsp-dmicdat1, dsp-dmicclk2, dsp-dmicdat2, i2c2-scl,
+                    i2c2-sda, i2c3-scl, i2c3-sda, i2c4-scl, i2c4-sda,
+                    dsp-standby, codec-mclk1, codec-mclk2, dsp-clkin,
+                    psia1-mclk, psia2-mclk, gf-gpio1, gf-gpio5,
+                    dsp-gpio20, led1, led2 ]
+
+          function:
+            description:
+              The mux function to select, available functions.
+            enum: [ aif, fpga-gpio1, fpga-gpio2, fpga-gpio3, fpga-gpio4,
+                    fpga-gpio5, fpga-gpio6, codec-gpio1, codec-gpio2,
+                    codec-gpio3, codec-gpio4, codec-gpio5, codec-gpio6,
+                    codec-gpio7, codec-gpio8, dsp-gpio1, dsp-gpio2,
+                    dsp-gpio3, dsp-gpio4, dsp-gpio5, dsp-gpio6,
+                    gf-gpio2, gf-gpio3, gf-gpio7, gf-gpio1, gf-gpio5,
+                    dsp-gpio20, codec-clkout, dsp-clkout, pmic-32k,
+                    spdif-clkout, clk-12m288, clk-11m2986, clk-24m576,
+                    clk-22m5792, xmos-mclk, gf-clkout1, gf-mclk1,
+                    gf-mclk3, gf-mclk2, gf-clkout2, codec-mclk1,
+                    codec-mclk2, dsp-clkin, psia1-mclk, psia2-mclk,
+                    spdif-mclk, codec-irq, codec-reset, dsp-reset,
+                    dsp-irq, dsp-standby, codec-pdmclk1, codec-pdmdat1,
+                    codec-pdmclk2, codec-pdmdat2, codec-dmicclk1,
+                    codec-dmicdat1, codec-dmicclk2, codec-dmicdat2,
+                    codec-dmicclk3, codec-dmicdat3, codec-dmicclk4,
+                    codec-dmicdat4, dsp-dmicclk1, dsp-dmicdat1,
+                    dsp-dmicclk2, dsp-dmicdat2, dsp-uart1-rx,
+                    dsp-uart1-tx, dsp-uart2-rx, dsp-uart2-tx,
+                    gf-uart2-rx, gf-uart2-tx, usb-uart-rx, usb-uart-tx,
+                    i2c2-scl, i2c2-sda, i2c3-scl, i2c3-sda, i2c4-scl,
+                    i2c4-sda, spdif-aif, psia1, psia1-bclk, psia1-lrclk,
+                    psia1-rxdat, psia1-txdat, psia2, psia2-bclk,
+                    psia2-lrclk, psia2-rxdat, psia2-txdat, codec-aif1,
+                    codec-aif1-bclk, codec-aif1-lrclk, codec-aif1-rxdat,
+                    codec-aif1-txdat, codec-aif2, codec-aif2-bclk,
+                    codec-aif2-lrclk, codec-aif2-rxdat, codec-aif2-txdat,
+                    codec-aif3, codec-aif3-bclk, codec-aif3-lrclk,
+                    codec-aif3-rxdat, codec-aif3-txdat, dsp-aif1,
+                    dsp-aif1-bclk, dsp-aif1-lrclk, dsp-aif1-rxdat,
+                    dsp-aif1-txdat, dsp-aif2, dsp-aif2-bclk,
+                    dsp-aif2-lrclk, dsp-aif2-rxdat, dsp-aif2-txdat,
+                    gf-aif3, gf-aif3-bclk, gf-aif3-lrclk, gf-aif3-rxdat,
+                    gf-aif3-txdat, gf-aif4, gf-aif4-bclk, gf-aif4-lrclk,
+                    gf-aif4-rxdat, gf-aif4-txdat, gf-aif1, gf-aif1-bclk,
+                    gf-aif1-lrclk, gf-aif1-rxdat, gf-aif1-txdat, gf-aif2,
+                    gf-aif2-bclk, gf-aif2-lrclk, gf-aif2-rxdat,
+                    gf-aif2-txdat, usb-aif1, usb-aif2, adat-aif,
+                    soundcard-aif ]
+
+          output-enable:
+            description:
+              Specifies that an AIF group will be used as a master
+              interface (either this or input-enable is required if a
+              group is being muxed to an AIF)
+
+          input-enable:
+            description:
+              Specifies that an AIF group will be used as a slave
+              interface (either this or output-enable is required if a
+              group is being muxed to an AIF)
+
+        additionalProperties: false
+
+        required:
+          - function
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - gpio-controller
+  - '#gpio-cells'
+  - gpio-ranges
+  - pinctrl-0
+  - pinctrl-names
-- 
2.11.0


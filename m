Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C6A1B107C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 17:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgDTPoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 11:44:54 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:54062 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729025AbgDTPov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:44:51 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03KFcDWs020255;
        Mon, 20 Apr 2020 10:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=gvL+afiF6keopn4BKwOSCEZIgLKzvZkhXiBgys2AvoE=;
 b=RpsmHG8zstX7EEmfVJvmenFVX4Dnw7F0kpcx/9aLDQNhjuszF0xW6UbzW8r9SP25tBtC
 jsGTAgDnGmsWcDFGsiGJJZEyxIiPb4ioNQqVJgDUd8GPWRx6rOL1fbQ/2D11cAJnlHoH
 FFejnju06uEG08gYu343p2JWapaOUmHtGPDF55vZ3+4lw3tjJ6RwfZmP/O4TLZRajjyZ
 1VlhWOis9OGWSXoMFVplAzELfjyZeFc8jSkoFNMn7BqjZiaDb0y7zdVh3pVTFsWY1uP4
 13Q2c6U1vCdHWWkxTk1qf8vXhYgHzcyY1ec4RnEG9scyXhnQdG8My+hvlt3J3xCUX9zl tg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 30fxy4b9hq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Apr 2020 10:44:47 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 20 Apr
 2020 16:44:44 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 20 Apr 2020 16:44:44 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A6DEE2C5;
        Mon, 20 Apr 2020 15:44:44 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>, <robh+dt@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>
CC:     <myungjoo.ham@samsung.com>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 2/4] extcon: arizona: Move binding over to dtschema
Date:   Mon, 20 Apr 2020 16:44:42 +0100
Message-ID: <20200420154444.12332-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200420154444.12332-1-ckeepax@opensource.cirrus.com>
References: <20200420154444.12332-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 .../devicetree/bindings/extcon/extcon-arizona.txt  |  76 -------------
 .../devicetree/bindings/extcon/wlf,arizona.yaml    | 125 +++++++++++++++++++++
 2 files changed, 125 insertions(+), 76 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-arizona.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/wlf,arizona.yaml

diff --git a/Documentation/devicetree/bindings/extcon/extcon-arizona.txt b/Documentation/devicetree/bindings/extcon/extcon-arizona.txt
deleted file mode 100644
index 208daaff0be4f..0000000000000
--- a/Documentation/devicetree/bindings/extcon/extcon-arizona.txt
+++ /dev/null
@@ -1,76 +0,0 @@
-Cirrus Logic Arizona class audio SoCs
-
-These devices are audio SoCs with extensive digital capabilities and a range
-of analogue I/O.
-
-This document lists Extcon specific bindings, see the primary binding document:
-  ../mfd/arizona.txt
-
-Optional properties:
-
-  - wlf,hpdet-channel : Headphone detection channel.
-    ARIZONA_ACCDET_MODE_HPL or 1 - Headphone detect mode is set to HPDETL
-    ARIZONA_ACCDET_MODE_HPR or 2 - Headphone detect mode is set to HPDETR
-    If this node is not mentioned or if the value is unknown, then
-    headphone detection mode is set to HPDETL.
-
-  - wlf,use-jd2 : Use the additional JD input along with JD1 for dual pin jack
-    detection.
-  - wlf,use-jd2-nopull : Internal pull on JD2 is disabled when used for
-    jack detection.
-  - wlf,jd-invert : Invert the polarity of the jack detection switch
-
-  - wlf,micd-software-compare : Use a software comparison to determine mic
-    presence
-  - wlf,micd-detect-debounce : Additional software microphone detection
-    debounce specified in milliseconds.
-  - wlf,micd-pol-gpio : GPIO specifier for the GPIO controlling the headset
-    polarity if one exists.
-  - wlf,micd-bias-start-time : Time allowed for MICBIAS to startup prior to
-    performing microphone detection, specified as per the ARIZONA_MICD_TIME_XXX
-    defines.
-  - wlf,micd-rate : Delay between successive microphone detection measurements,
-    specified as per the ARIZONA_MICD_TIME_XXX defines.
-  - wlf,micd-dbtime : Microphone detection hardware debounces specified as the
-    number of measurements to take, valid values being 2 and 4.
-  - wlf,micd-timeout-ms : Timeout for microphone detection, specified in
-    milliseconds.
-  - wlf,micd-force-micbias : Force MICBIAS continuously on during microphone
-    detection.
-  - wlf,micd-configs : Headset polarity configurations (generally used for
-    detection of CTIA / OMTP headsets), the field can be of variable length
-    but should always be a multiple of 3 cells long, each three cell group
-    represents one polarity configuration.
-    The first cell defines the accessory detection pin, zero will use MICDET1
-    and all other values will use MICDET2.
-    The second cell represents the MICBIAS to be used.
-    The third cell represents the value of the micd-pol-gpio pin.
-
-  - wlf,gpsw : Settings for the general purpose switch, set as one of the
-    ARIZONA_GPSW_XXX defines.
-
-Example:
-
-codec: wm8280@0 {
-	compatible = "wlf,wm8280";
-	reg = <0>;
-	...
-
-	wlf,use-jd2;
-	wlf,use-jd2-nopull;
-	wlf,jd-invert;
-
-	wlf,micd-software-compare;
-	wlf,micd-detect-debounce = <0>;
-	wlf,micd-pol-gpio = <&codec 2 0>;
-	wlf,micd-rate = <ARIZONA_MICD_TIME_8MS>;
-	wlf,micd-dbtime = <4>;
-	wlf,micd-timeout-ms = <100>;
-	wlf,micd-force-micbias;
-	wlf,micd-configs = <
-		0 1 0 /* MICDET1 MICBIAS1 GPIO=low */
-		1 2 1 /* MICDET2 MICBIAS2 GPIO=high */
-	>;
-
-	wlf,gpsw = <ARIZONA_GPSW_OPEN>;
-};
diff --git a/Documentation/devicetree/bindings/extcon/wlf,arizona.yaml b/Documentation/devicetree/bindings/extcon/wlf,arizona.yaml
new file mode 100644
index 0000000000000..47ae53a658843
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/wlf,arizona.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/extcon/wlf,arizona.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic/Wolfson Microelectronics Arizona class audio SoCs
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+description: |
+  These devices are audio SoCs with extensive digital capabilities and a
+  range of analogue I/O.
+
+  This document lists Extcon specific bindings, see the primary binding
+  document ../mfd/arizona.yaml
+
+properties:
+  wlf,hpdet-channel:
+    description:
+      Headphone detection channel.  ARIZONA_ACCDET_MODE_HPL/1 sets the
+      headphone detect mode to HPDETL, ARIZONA_ACCDET_MODE_HPR/2 sets it
+      to HPDETR.  If this node is not included or if the value is unknown,
+      then headphone detection mode is set to HPDETL.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 1
+    maximum: 2
+
+  wlf,use-jd2:
+    description:
+      Use the additional JD input along with JD1 for dual pin jack detection.
+    type: boolean
+
+  wlf,use-jd2-nopull:
+    description:
+      Internal pull on JD2 is disabled when used for jack detection.
+    type: boolean
+
+  wlf,jd-invert:
+    description:
+      Invert the polarity of the jack detection switch.
+    type: boolean
+
+  wlf,micd-software-compare:
+    description:
+      Use a software comparison to determine mic presence.
+    type: boolean
+
+  wlf,micd-detect-debounce:
+    description:
+      Additional software microphone detection debounce specified in
+      milliseconds.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  wlf,micd-pol-gpio:
+    description:
+      GPIO specifier for the GPIO controlling the headset polarity if one
+      exists.
+    maxItems: 1
+
+  wlf,micd-bias-start-time:
+    description:
+      Time allowed for MICBIAS to startup prior to performing microphone
+      detection, specified as per the ARIZONA_MICD_TIME_XXX defines.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 12
+
+  wlf,micd-rate:
+    description:
+      Delay between successive microphone detection measurements, specified
+      as per the ARIZONA_MICD_TIME_XXX defines.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 12
+
+  wlf,micd-dbtime:
+    description:
+      Microphone detection hardware debounces specified as the number of
+      measurements to take, valid values being 2 and 4.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    enum: [2, 4]
+
+  wlf,micd-timeout-ms:
+    description:
+      Timeout for microphone detection, specified in milliseconds.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  wlf,micd-force-micbias:
+    description:
+      Force MICBIAS continuously on during microphone detection.
+    type: boolean
+
+  wlf,micd-configs:
+    description:
+      Headset polarity configurations (generally used for detection of
+      CTIA / OMTP headsets), the field can be of variable length but
+      should always be a multiple of 3 cells long, each three cell group
+      represents one polarity configuration.
+    $ref: "/schemas/types.yaml#/definitions/uint32-matrix"
+    items:
+      items:
+        - description:
+            The first cell defines the accessory detection pin, zero
+            will use MICDET1 and 0x2000 will use MICDET2.
+          enum: [ 0, 0x2000 ]
+        - description:
+            The second cell represents the MICBIAS to be used. Zero
+            will use MICVDD, 1-3 will use MICBIASx.
+          minimum: 0
+          maximum: 3
+        - description:
+            The third cell represents the value of the micd-pol-gpio
+            pin.
+          minimum: 0
+          maximum: 1
+
+  wlf,gpsw:
+    description:
+      Settings for the general purpose switch, set as one of the
+      ARIZONA_GPSW_XXX defines.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 3
-- 
2.11.0


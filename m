Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9731F1C7587
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 17:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbgEFP6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 11:58:08 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:58904 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729455AbgEFP6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:58:07 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 046Fri6W028143;
        Wed, 6 May 2020 10:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=ZUV1lwKXBHO9x6o9eiH67NwiBdI+w5GFIjfClIMjUpg=;
 b=WfWbCXAy9bLTFkxfbE33o3vNSEhKWWCrK9x95XLfRgeOcIukgnqyI81VuignEJiGKyM/
 CjIQ0L8/xr8dq1/6lNCQtQrZhGIQ8w5LFe+jJiwytHvOUnnEnSfPCZ4uL/CDklAedtb9
 jBeSkaEPj/6HPZ20n6zs+ygZkO3LhgtkU6NGG6Jhz0KaooD6mDJE+P04Y2JEBjsX34BX
 lghWkcZEGFv9wfMbxtrKh+FDv31gyR+EG+TEwf5JzsvbAAwMTDOOfhLpUjorr9Brdu2X
 jzPWHGjCALNIjtyKqVHvL9N7rsCuJPFFuD14hTV/eYtiLjBs/Fv6TnSBi2cDwK4JMwb9 SQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 30s6937h76-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 06 May 2020 10:58:01 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 6 May 2020
 16:57:59 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 6 May 2020 16:57:59 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1772944A;
        Wed,  6 May 2020 15:57:59 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>, <robh+dt@kernel.org>,
        <lee.jones@linaro.org>, <linus.walleij@linaro.org>,
        <broonie@kernel.org>
CC:     <myungjoo.ham@samsung.com>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 2/7] extcon: arizona: Move binding over to dtschema
Date:   Wed, 6 May 2020 16:57:53 +0100
Message-ID: <20200506155758.14643-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200506155758.14643-1-ckeepax@opensource.cirrus.com>
References: <20200506155758.14643-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Removed some description that duplicates constraints

Thanks,
Charles

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
index 0000000000000..f9845dc2f5ae5
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
+      measurements to take.
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


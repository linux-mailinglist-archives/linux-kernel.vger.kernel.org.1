Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FA81C758E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 17:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbgEFP61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 11:58:27 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:40256 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729431AbgEFP6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:58:07 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 046Fv9kD002695;
        Wed, 6 May 2020 10:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=RXYKMKi+QEbFQDflMloDHZ74pkpU04OaQGCgNtwOO9I=;
 b=X1XpkUTRXsckl4hdGAQvtQr+v3fBBsSliqUgq0UZswpmYvmoaYjiHzUPpDfzzwnAq53J
 GZVpUfnVIsVE6rxsI/Rl3wKWTKSST+qm4w6/aOou29IkfJAsHfUgk1OHsWZIcZc4zKny
 u5Ijq07M/njJH2xfN79+fu+GDtOY9MD72T14uV2uLhXRkQGvhLTGirbl2cpnPb/b1R0R
 HUotdIOkFUw+JzbOllzz4zLp9r/oRtMO+74/oq2BE1EFGmf8l1D/Jo65O7s0aEw/GKEO
 kWap6YsDV/oGQNtTYOd+BHs33UCbIczV8WcCuugJiY4G9DzQw7JyfEniZnkn8s9cDZe5 ZA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 30s59pqch3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 06 May 2020 10:58:00 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 6 May 2020
 16:57:59 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 6 May 2020 16:57:59 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4ADA92C8;
        Wed,  6 May 2020 15:57:59 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>, <robh+dt@kernel.org>,
        <lee.jones@linaro.org>, <linus.walleij@linaro.org>,
        <broonie@kernel.org>
CC:     <myungjoo.ham@samsung.com>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 5/7] ASoC: madera: Move binding over to dtschema
Date:   Wed, 6 May 2020 16:57:56 +0100
Message-ID: <20200506155758.14643-5-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200506155758.14643-1-ckeepax@opensource.cirrus.com>
References: <20200506155758.14643-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

New since v1, putting in the same series as Arizona since they share the
same regulator binding.

Thanks,
Charles

 .../devicetree/bindings/sound/cirrus,madera.yaml   | 113 +++++++++++++++++++++
 Documentation/devicetree/bindings/sound/madera.txt |  67 ------------
 2 files changed, 113 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,madera.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/madera.txt

diff --git a/Documentation/devicetree/bindings/sound/cirrus,madera.yaml b/Documentation/devicetree/bindings/sound/cirrus,madera.yaml
new file mode 100644
index 0000000000000..c4cd58b5acd46
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cirrus,madera.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/cirrus,madera.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic Madera class audio CODECs
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+description: |
+  This describes audio configuration bindings for these codecs.
+
+  See also the core bindings for the parent MFD driver:
+
+    Documentation/devicetree/bindings/mfd/cirrus,madera.yaml
+
+  and defines for values used in these bindings:
+
+    include/dt-bindings/sound/madera.h
+
+  The properties are all contained in the parent MFD node.
+
+properties:
+  '#sound-dai-cells':
+    description:
+      The first cell indicating the audio interface.
+    const: 1
+
+  cirrus,inmode:
+    description:
+      A list of input mode settings for each input. A maximum
+      of 24 cells, with four cells per input in the order INnAL,
+      INnAR INnBL INnBR.  For non-muxed inputs the first two cells
+      for that input set the mode for the left and right channel
+      and the second two cells must be 0.  For muxed inputs the
+      first two cells for that input set the mode of the left and
+      right A inputs and the second two cells set the mode of the
+      left and right B inputs.  Valid mode values are one of the
+      MADERA_INMODE_xxx. If the array is shorter than the number
+      of inputs the unspecified inputs default to MADERA_INMODE_DIFF.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 24
+    items:
+      minimum: 0
+      maximum: 1
+      default: 0
+
+  cirrus,out-mono:
+    description:
+      Mono bit for each output, maximum of six cells if the array
+      is shorter outputs will be set to stereo.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 6
+    items:
+      minimum: 0
+      maximum: 1
+      default: 0
+
+  cirrus,dmic-ref:
+    description: |
+      Indicates how the MICBIAS pins have been externally connected
+      to DMICs on each input, one cell per input.
+
+        <IN1 IN2 IN3 ...>
+
+      A value of 0 indicates MICVDD and is the default,
+      other values depend on the codec: For CS47L35 one of the
+      CS47L35_DMIC_REF_xxx values For all other codecs one of
+      the MADERA_DMIC_REF_xxx values Also see the datasheet for a
+      description of the INn_DMIC_SUP field.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 6
+    items:
+      minimum: 0
+      maximum: 3
+      default: 0
+
+  cirrus,max-channels-clocked:
+    description:
+      Maximum number of channels that I2S clocks will be generated
+      for. Useful when clock master for systems where the I2S bus
+      has multiple data lines.  One cell for each AIF, use a value
+      of zero for AIFs that should be handled normally.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 4
+    items:
+      default: 0
+
+  cirrus,pdm-fmt:
+    description:
+      PDM speaker data format, must contain 2 cells (OUT5 and
+      OUT6). See the PDM_SPKn_FMT field in the datasheet for a
+      description of this value. The second cell is ignored for
+      codecs that do not have OUT6.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 2
+
+  cirrus,pdm-mute:
+    description: |
+      PDM mute format, must contain 2 cells (OUT5 and OUT6). See the
+      PDM_SPKn_CTRL_1 register in the datasheet for a description
+      of this value.  The second cell is ignored for codecs that
+      do not have OUT6.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 2
diff --git a/Documentation/devicetree/bindings/sound/madera.txt b/Documentation/devicetree/bindings/sound/madera.txt
deleted file mode 100644
index 5e669ce552f47..0000000000000
--- a/Documentation/devicetree/bindings/sound/madera.txt
+++ /dev/null
@@ -1,67 +0,0 @@
-Cirrus Logic Madera class audio codecs
-
-This describes audio configuration bindings for these codecs.
-
-See also the core bindings for the parent MFD driver:
-See Documentation/devicetree/bindings/mfd/madera.txt
-
-and defines for values used in these bindings:
-include/dt-bindings/sound/madera.h
-
-These properties are all contained in the parent MFD node.
-
-Optional properties:
-  - cirrus,dmic-ref : Indicates how the MICBIAS pins have been externally
-    connected to DMICs on each input, one cell per input.
-    <IN1 IN2 IN3 ...>
-    A value of 0 indicates MICVDD and is the default, other values depend on the
-    codec:
-    For CS47L35 one of the CS47L35_DMIC_REF_xxx values
-    For all other codecs one of the MADERA_DMIC_REF_xxx values
-    Also see the datasheet for a description of the INn_DMIC_SUP field.
-
-  - cirrus,inmode : A list of input mode settings for each input. A maximum of
-    16 cells, with four cells per input in the order INnAL, INnAR INnBL INnBR.
-    For non-muxed inputs the first two cells for that input set the mode for
-    the left and right channel and the second two cells must be 0.
-    For muxed inputs the first two cells for that input set the mode of the
-    left and right A inputs and the second two cells set the mode of the left
-    and right B inputs.
-    Valid mode values are one of the MADERA_INMODE_xxx. If the array is shorter
-    than the number of inputs the unspecified inputs default to
-    MADERA_INMODE_DIFF.
-
-  - cirrus,out-mono : Mono bit for each output, maximum of six cells if the
-    array is shorter outputs will be set to stereo.
-
-  - cirrus,max-channels-clocked : Maximum number of channels that I2S clocks
-    will be generated for. Useful when clock master for systems where the I2S
-    bus has multiple data lines.
-    One cell for each AIF, use a value of zero for AIFs that should be handled
-    normally.
-
-  - cirrus,pdm-fmt : PDM speaker data format, must contain 2 cells
-    (OUT5 and OUT6). See the PDM_SPKn_FMT field in the datasheet for a
-    description of this value.
-    The second cell is ignored for codecs that do not have OUT6.
-
-  - cirrus,pdm-mute : PDM mute format, must contain 2 cells
-    (OUT5 and OUT6). See the PDM_SPKn_CTRL_1 register in the datasheet for a
-    description of this value.
-    The second cell is ignored for codecs that do not have OUT6.
-
-Example:
-
-cs47l35@0 {
-	compatible = "cirrus,cs47l35";
-
-	cirrus,dmic-ref = <0 0 CS47L35_DMIC_REF_MICBIAS1B 0>;
-	cirrus,inmode = <
-		MADERA_INMODE_DMIC MADERA_INMODE_DMIC /* IN1A digital */
-		MADERA_INMODE_SE   MADERA_INMODE_SE   /* IN1B single-ended */
-		MADERA_INMODE_DIFF MADERA_INMODE_DIFF /* IN2 differential */
-		0 0 	/* not used on this codec */
-	>;
-	cirrus,out-mono = <0 0 0 0 0 0>;
-	cirrus,max-channels-clocked = <2 0 0>;
-};
-- 
2.11.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E741C7589
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 17:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgEFP6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 11:58:15 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:53228 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729775AbgEFP6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:58:08 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 046Fv9kF002695;
        Wed, 6 May 2020 10:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=dDdOENLO0jD3jK9pMcs1F2XFE3EGaqojlzP5MCx3afU=;
 b=B4nGjIMZlW1EnpETcR0HEGQbMKYlhEw4rc3JFnBVxf+y4An5YgH1m56mJGLW2IqWyoq+
 63DMtXC+03OnDC5wU68NK5O1yuFfLG0Bz2COyuxBsqh4gdFWi/Z1ystAEgMPrDVBn+Y2
 yX7Dc9LCUjU6sjRo7yZxfCOErVXNdnRI0K21CRYwc+9O1uvZu01GkMql4EvZUviH9BC6
 Xl5lqE+RcA4I7WVFOvbdZP5KIui0lXtH/5WOF7mSPaAOJdwjWjNOrFZ/nCOPcPfatLtV
 9aLE5kye1Aa45oUtt/buAIr1KPMIJO51X7ur4Wts8A5JCvJAu4Md4fy3Lw/ydlMH53Q+ BQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 30s59pqch3-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 06 May 2020 10:58:01 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 6 May 2020
 16:57:59 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 6 May 2020 16:57:59 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 29A172C5;
        Wed,  6 May 2020 15:57:59 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>, <robh+dt@kernel.org>,
        <lee.jones@linaro.org>, <linus.walleij@linaro.org>,
        <broonie@kernel.org>
CC:     <myungjoo.ham@samsung.com>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 3/7] ASoC: arizona: Move binding over to dtschema
Date:   Wed, 6 May 2020 16:57:54 +0100
Message-ID: <20200506155758.14643-3-ckeepax@opensource.cirrus.com>
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

Changes since v1:
 - Removed some description that duplicates constraints

Thanks,
Charles

 .../devicetree/bindings/sound/wlf,arizona.txt      |  53 ----------
 .../devicetree/bindings/sound/wlf,arizona.yaml     | 114 +++++++++++++++++++++
 2 files changed, 114 insertions(+), 53 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,arizona.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,arizona.yaml

diff --git a/Documentation/devicetree/bindings/sound/wlf,arizona.txt b/Documentation/devicetree/bindings/sound/wlf,arizona.txt
deleted file mode 100644
index e172c62dc2dff..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,arizona.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-Cirrus Logic Arizona class audio SoCs
-
-These devices are audio SoCs with extensive digital capabilities and a range
-of analogue I/O.
-
-This document lists sound specific bindings, see the primary binding
-document:
-  ../mfd/arizona.txt
-
-Optional properties:
-
-  - wlf,inmode : A list of INn_MODE register values, where n is the number
-    of input signals. Valid values are 0 (Differential), 1 (Single-ended) and
-    2 (Digital Microphone). If absent, INn_MODE registers set to 0 by default.
-    If present, values must be specified less than or equal to the number of
-    input signals. If values less than the number of input signals, elements
-    that have not been specified are set to 0 by default. Entries are:
-    <IN1, IN2, IN3, IN4> (wm5102, wm5110, wm8280, wm8997)
-    <IN1A, IN2A, IN1B, IN2B> (wm8998, wm1814)
-  - wlf,out-mono : A list of boolean values indicating whether each output is
-    mono or stereo. Position within the list indicates the output affected
-    (eg. First entry in the list corresponds to output 1). A non-zero value
-    indicates a mono output. If present, the number of values should be less
-    than or equal to the number of outputs, if less values are supplied the
-    additional outputs will be treated as stereo.
-
-  - wlf,dmic-ref : DMIC reference voltage source for each input, can be
-    selected from either MICVDD or one of the MICBIAS's, defines
-    (ARIZONA_DMIC_xxxx) are provided in <dt-bindings/mfd/arizona.txt>. If
-    present, the number of values should be less than or equal to the
-    number of inputs, unspecified inputs will use the chip default.
-
-  - wlf,max-channels-clocked : The maximum number of channels to be clocked on
-    each AIF, useful for I2S systems with multiple data lines being mastered.
-    Specify one cell for each AIF to be configured, specify zero for AIFs that
-    should be handled normally.
-    If present, number of cells must be less than or equal to the number of
-    AIFs. If less than the number of AIFs, for cells that have not been
-    specified the corresponding AIFs will be treated as default setting.
-
-  - wlf,spk-fmt : PDM speaker data format, must contain 2 cells (OUT5 and OUT6).
-    See the datasheet for values.
-    The second cell is ignored for codecs that do not have OUT6 (wm5102, wm8997,
-      wm8998, wm1814)
-
-  - wlf,spk-mute : PDM speaker mute setting, must contain 2 cells (OUT5 and OUT6).
-    See the datasheet for values.
-    The second cell is ignored for codecs that do not have OUT6 (wm5102, wm8997,
-    wm8998, wm1814)
-
-  - wlf,out-volume-limit : The volume limit value that should be applied to each
-    output channel. See the datasheet for exact values. Channels are specified
-    in the order OUT1L, OUT1R, OUT2L, OUT2R, etc.
diff --git a/Documentation/devicetree/bindings/sound/wlf,arizona.yaml b/Documentation/devicetree/bindings/sound/wlf,arizona.yaml
new file mode 100644
index 0000000000000..22d54be7900a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,arizona.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/wlf,arizona.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic/Wolfson Microelectronics Arizona class audio SoCs
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+description: |
+  These devices are audio SoCs with extensive digital capabilities and a range
+  of analogue I/O.
+
+  This document lists sound specific bindings, see the primary binding
+  document ../mfd/arizona.yaml
+
+properties:
+  '#sound-dai-cells':
+    description:
+      The first cell indicating the audio interface.
+    const: 1
+
+  wlf,inmode:
+    description:
+      A list of INn_MODE register values, where n is the number of input
+      signals. Valid values are 0 (Differential), 1 (Single-ended) and
+      2 (Digital Microphone). If absent, INn_MODE registers set to 0 by
+      default.  If present, values must be specified less than or equal
+      to the number of input signals. If values less than the number of
+      input signals, elements that have not been specified are set to 0 by
+      default. Entries are <IN1, IN2, IN3, IN4> (wm5102, wm5110, wm8280,
+      wm8997) and <IN1A, IN2A, IN1B, IN2B> (wm8998, wm1814)
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 4
+    items:
+      minimum: 0
+      maximum: 2
+      default: 0
+
+  wlf,out-mono:
+    description:
+      A list of boolean values indicating whether each output is mono
+      or stereo. Position within the list indicates the output affected
+      (eg. First entry in the list corresponds to output 1). A non-zero
+      value indicates a mono output. If present, the number of values
+      should be less than or equal to the number of outputs, if less values
+      are supplied the additional outputs will be treated as stereo.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 6
+    items:
+      minimum: 0
+      maximum: 1
+      default: 0
+
+  wlf,dmic-ref:
+    description:
+      DMIC reference voltage source for each input, can be selected from
+      either MICVDD or one of the MICBIAS's, defines (ARIZONA_DMIC_xxxx)
+      are provided in dt-bindings/mfd/arizona.h. If present, the number
+      of values should be less than or equal to the number of inputs,
+      unspecified inputs will use the chip default.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 4
+    items:
+      minimum: 0
+      maximum: 3
+      default: 0
+
+  wlf,max-channels-clocked:
+    description:
+      The maximum number of channels to be clocked on each AIF, useful for
+      I2S systems with multiple data lines being mastered.  Specify one
+      cell for each AIF to be configured, specify zero for AIFs that should
+      be handled normally.  If present, number of cells must be less than
+      or equal to the number of AIFs. If less than the number of AIFs, for
+      cells that have not been specified the corresponding AIFs will be
+      treated as default setting.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 3
+    items:
+      default: 0
+
+  wlf,spk-fmt:
+    description:
+      PDM speaker data format, must contain 2 cells (OUT5 and OUT6).  See
+      the datasheet for values.  The second cell is ignored for codecs that
+      do not have OUT6 (wm5102, wm8997, wm8998, wm1814)
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 2
+
+  wlf,spk-mute:
+    description:
+      PDM speaker mute setting, must contain 2 cells (OUT5 and OUT6).  See
+      the datasheet for values.  The second cell is ignored for codecs that
+      do not have OUT6 (wm5102, wm8997, wm8998, wm1814)
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 2
+
+  wlf,out-volume-limit:
+    description:
+      The volume limit value that should be applied to each output
+      channel. See the datasheet for exact values. Channels are specified
+      in the order OUT1L, OUT1R, OUT2L, OUT2R, etc.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 12
-- 
2.11.0


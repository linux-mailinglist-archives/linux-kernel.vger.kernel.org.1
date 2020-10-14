Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD0528E099
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 14:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgJNMgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 08:36:52 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:52923 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726394AbgJNMgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 08:36:51 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09ECRGnc023713;
        Wed, 14 Oct 2020 14:35:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=a6IV5Cv8z3GpD5NHvsPPGT16JAZW0AbP5VtlTBCZgbY=;
 b=0gW3dTGUMUCPCrLlHSKbLXNUakOrE1zSS5pc8R4iwImq9dmyN8jYSMPtrnaYSkyrykfV
 7+fnKYW3/gxGpk1teSImS2SFtMyGBfTAQ1mSF+IxGduO+IT6i/MQMDTuxp2Q/R8s4O68
 EyH5zrjGFmkmZd61NQdVcNamD0ru9hXfZ0Jw+iTQxrWWSjYKw/Q+3BXTZ021nSyh6X1y
 RKcwAtrn9B01U+7SNaQOqIjhUTgEHeGTtwtlixKDnYtBmB+OuVLC7QWa5oN00DGtltbh
 +ZnktVyB3bRl2RVsa1n0IdnjMmckEGTKcr6PxZRQb516T16Jn8Z7Se3BCVfUq7uI8XB5 0g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3435875rh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 14:35:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 732A010002A;
        Wed, 14 Oct 2020 14:35:54 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E8B382D0088;
        Wed, 14 Oct 2020 14:35:53 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 14 Oct 2020 14:35:53
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alexandre.torgue@st.com>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <olivier.moysan@st.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <arnaud.pouliquen@st.com>
Subject: [PATCH 1/1] ASoC: dt-bindings: stm32: convert audio dfsdm to json-schema
Date:   Wed, 14 Oct 2020 14:35:31 +0200
Message-ID: <20201014123531.6991-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-14_07:2020-10-14,2020-10-14 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the STM32 DFSDM audio bindings to DT schema format
using json-schema.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 .../bindings/sound/st,stm32-adfsdm.txt        | 63 -------------------
 .../bindings/sound/st,stm32-adfsdm.yaml       | 42 +++++++++++++
 2 files changed, 42 insertions(+), 63 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-adfsdm.yaml

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt b/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
deleted file mode 100644
index 864f5b00b031..000000000000
--- a/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
+++ /dev/null
@@ -1,63 +0,0 @@
-STMicroelectronics Audio Digital Filter Sigma Delta modulators(DFSDM)
-
-The DFSDM allows PDM microphones capture through SPI interface. The Audio
-interface is seems as a sub block of the DFSDM device.
-For details on DFSDM bindings refer to ../iio/adc/st,stm32-dfsdm-adc.txt
-
-Required properties:
-  - compatible: "st,stm32h7-dfsdm-dai".
-
-  - #sound-dai-cells : Must be equal to 0
-
-  - io-channels : phandle to iio dfsdm instance node.
-
-Example of a sound card using audio DFSDM node.
-
-	sound_card {
-		compatible = "audio-graph-card";
-
-		dais = <&cpu_port>;
-	};
-
-	dfsdm: dfsdm@40017000 {
-		compatible = "st,stm32h7-dfsdm";
-		reg = <0x40017000 0x400>;
-		clocks = <&rcc DFSDM1_CK>;
-		clock-names = "dfsdm";
-		#interrupt-cells = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		dfsdm_adc0: filter@0 {
-			compatible = "st,stm32-dfsdm-dmic";
-			reg = <0>;
-			interrupts = <110>;
-			dmas = <&dmamux1 101 0x400 0x00>;
-			dma-names = "rx";
-			st,adc-channels = <1>;
-			st,adc-channel-names = "dmic0";
-			st,adc-channel-types = "SPI_R";
-			st,adc-channel-clk-src = "CLKOUT";
-			st,filter-order = <5>;
-
-			dfsdm_dai0: dfsdm-dai {
-				compatible = "st,stm32h7-dfsdm-dai";
-				#sound-dai-cells = <0>;
-				io-channels = <&dfsdm_adc0 0>;
-				cpu_port: port {
-				dfsdm_endpoint: endpoint {
-					remote-endpoint = <&dmic0_endpoint>;
-				};
-			};
-		};
-	};
-
-	dmic0: dmic@0 {
-		compatible = "dmic-codec";
-		#sound-dai-cells = <0>;
-		port {
-			dmic0_endpoint: endpoint {
-				remote-endpoint = <&dfsdm_endpoint>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.yaml b/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.yaml
new file mode 100644
index 000000000000..d953ec524ba2
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/st,stm32-adfsdm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics Audio Digital Filter Sigma Delta modulators(DFSDM)
+
+maintainers:
+  - Olivier Moysan <olivier.moysan@st.com>
+
+description:
+  The DFSDM allows PDM microphones capture through the SPI interface.
+  The Audio interface is seen as a sub block of the DFSDM device.
+  For details on DFSDM bindings refer to ../iio/adc/st,stm32-dfsdm-adc.yaml
+
+properties:
+  compatible:
+    enum:
+      - st,stm32h7-dfsdm-dai
+
+  "#sound-dai-cells":
+    const: 0
+
+  io-channels:
+    description: phandle to iio dfsdm instance node
+    maxItems: 1
+
+required:
+  - compatible
+  - "#sound-dai-cells"
+  - io-channels
+
+examples:
+  - |
+    asoc_pdm0: dfsdm-dai {
+      compatible = "st,stm32h7-dfsdm-dai";
+      #sound-dai-cells = <0>;
+      io-channels = <&dfsdm0 0>;
+    };
+
+...
-- 
2.17.1


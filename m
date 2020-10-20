Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D6B294011
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 17:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437008AbgJTP6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 11:58:11 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:60342 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436986AbgJTP6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 11:58:09 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09KFftEv008243;
        Tue, 20 Oct 2020 17:57:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=0NhB4w744ex1Ld0LhQH7gI4YdESY0PjtXTk+Jpsh0+k=;
 b=zIqV5ThP10kLzp7eDK8XzS13yQqtsZJBJAD/FCmHZMMyLgO8fGvTpTrNAntXZ3LhLd95
 oIka79m8/OPeHn7bJo+CWEIQti28DOPYiT1PgLLLRPW5X2hYKjgwFGF/ZKXREFvwl6vk
 UbdrOrbos97Q6qQAnbL9rKY1ER8C8d4lR8+MHiOKB6X1ldnR1U+jpPjoHVE+eUakjsHg
 aSuA5oUZjc07ASZuHC7Jn1S2eUhTz9/lx7ShxBfAirdHVgcevWZhK8Ei743Ol0NX+LIA
 IDAOCgkdkj3NgmwsZg/gBrgxluGsqZdpRa4N8OLCTvEcB9JC22Ae4mStLaU5FfpgDP5a ug== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 347pcwuuwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 17:57:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 33FD4100038;
        Tue, 20 Oct 2020 17:57:15 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 22AFF206290;
        Tue, 20 Oct 2020 17:57:15 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Oct 2020 17:57:14
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alexandre.torgue@st.com>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <olivier.moysan@st.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <arnaud.pouliquen@st.com>
Subject: [PATCH v2 2/2] dt-bindings: stm32: dfsdm: remove stm32-adfsdm.txt binding
Date:   Tue, 20 Oct 2020 17:57:09 +0200
Message-ID: <20201020155709.2621-3-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201020155709.2621-1-olivier.moysan@st.com>
References: <20201020155709.2621-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-20_08:2020-10-20,2020-10-20 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree audio configuration for STM32 DFSDM is already
covered in the following binding:
Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
Remove stm32-adfsdm.txt obsolete binding.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 .../bindings/sound/st,stm32-adfsdm.txt        | 63 -------------------
 1 file changed, 63 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt

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
-- 
2.17.1


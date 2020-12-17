Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73402DD46D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 16:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgLQPms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 10:42:48 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:14326 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728628AbgLQPmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 10:42:46 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BHFPi98001634;
        Thu, 17 Dec 2020 09:41:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=aMP9SGT4gnrlMbPsjRxvLdeVb+dW0Od9NGiAjNHZ9Go=;
 b=ZdUObY09lFBzRA8no5KR/ntljZAELrY2xAQPg3mQZRWOaESHNWQFv51c1VwXslEBq9uX
 Xbh3yP6D0tfrDCgRTTw6vpT+NOdTf5wyhnjqYgqv0QtnAw/Xj7/TrX9ZKIgJoij26oUB
 fNfLFtXAoeWuG5GDH1N/DQXniokp/eg5luGwfZzJOte/dvdZQT6BUQmErdUsi3iUwA/P
 /aDy70F8zaEitRU97wyVrtx4vP8tHzhg6aBAj+3QtGR0pH1/3mfvjNOCUseGLjYP221+
 RkcZR62t+EmHqULX3RTJtTyv4Do7HHd+gfQIs6tukeim54NFGJ8W9G3b4a1Ton4NtqLD Jg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 35cu5rxy90-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Dec 2020 09:41:48 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 17 Dec
 2020 15:41:46 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 17 Dec 2020 15:41:46 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.236])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 304CF11CB;
        Thu, 17 Dec 2020 15:41:46 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <kuninori.morimoto.gx@renesas.com>, <nsaenzjulienne@suse.de>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 2/6] ASoC: audio-graph-card: Add plls and sysclks DT bindings
Date:   Thu, 17 Dec 2020 15:41:38 +0000
Message-ID: <20201217154142.24301-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201217154142.24301-1-rf@opensource.cirrus.com>
References: <20201217154142.24301-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012170108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audio-graph-card driver has bindings for configuring the clocking
for DAIs within a component, but is missing bindings for setting
up the PLLs and sysclks of the component.

This patch adds the two new bindings 'plls' and 'sysclks' so that the
audio-graph-driver can fully configure the component clocking.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 .../bindings/sound/audio-graph-card.txt       | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
index d5f6919a2d69..30405e64cfbb 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-card.txt
+++ b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
@@ -32,6 +32,40 @@ Required properties:
 Optional properties:
 - pa-gpios: GPIO used to control external amplifier.
 
+- plls: A list of component pll settings. There are 4 cells per PLL setting:
+	- phandle to the node of the codec or cpu component,
+	- component PLL id,
+	- component clock source id,
+	- frequency (in Hz) of the PLL output clock.
+
+	The PLL id and clock source id are specific to the particular component
+	so see the relevant component driver for the ids. Typically the
+	clock source id indicates the pin the source clock is connected to.
+
+	The same phandle can appear in multiple entries so that several plls
+	can be set in the same component.
+
+- plls-clocks: A list of clock names giving the source clock for each setting
+	in the plls property.
+
+- sysclks: A list of component sysclk settings.  There are 4 cells per sysclk
+	setting:
+	- phandle to the node of the codec or cpu component,
+	- component sysclk id,
+	- component clock source id,
+	- direction of the clock: 0 if the clock is an input to the component,
+	  1 if it is an output.
+
+	The sysclk id and clock source id are specific to the particular
+	component so see the relevant component driver for the ids. Typically
+	the clock source id indicates the pin the source clock is connected to.
+
+	The same phandle can appear in multiple entries so that several sysclks
+	can be set in the same component.
+
+- sysclks-clocks: A list of clock names giving the source clock for each setting
+	in the sysclks property.
+
 -----------------------
 Example: Single DAI case
 -----------------------
@@ -335,3 +369,41 @@ Example: Multi DAI with DPCM
 			};
 		};
 	};
+
+-----------------------
+Example: Set component sysclks and PLLs
+-----------------------
+
+	sound {
+		compatible = "audio-graph-card";
+
+		clocks = <&audioclk>, <&pll1>;
+		clock-names = "audioclk", "pll1";
+
+		plls = <&cs47l15 MADERA_FLL1_REFCLK MADERA_FLL_SRC_MCLK1 98304000>;
+		plls-clocks = "audioclk";
+
+		sysclks = <&cs47l15 MADERA_CLK_SYSCLK_1 MADERA_CLK_SRC_FLL1 0>;
+		sysclks-clocks = "pll1";
+
+		dais = <&cpu_i2s_port>;
+
+		pll1: pll1 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <98304000>;
+		};
+	};
+
+	cs47l15: codec@0 {
+		...
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cs47l15_aif1_port: port@0 {
+				reg = <0>;
+				cs47l15_aif1: endpoint {
+					remote-endpoint = <&cpu_i2s_endpoint>;
+				};
+			};
+	};
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36A72A03B3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgJ3LIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:08:30 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:62503 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ3LI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604056109; x=1635592109;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kwu6wFirYHrNnqXi/rLUZjAILQtZP2nj8vZsvUbfRSA=;
  b=GJQKkupz98TytEMY++LdsumevsjmFFVO5KIYiMHrLkMZNiT3Olj4Tg2n
   FQA+ZkKqbIlhx+PT3lhDDdP+IN+LWbJm066ZyfTnAG1DAWNAsCPvvaAlM
   NAXw3EMxxclbbjouihuGZ1TUngCft7B+urirDwma+Uut2xJyyis+tTQ4m
   2A+OoV9qGBGdr8jkHjKHU9xg6iEfIAihwnCc6CTQ8EgzUCMqHRzSVwAio
   Wnn1UBLW0q1ed1g9X5wIr2B61XVrtjOA3CgvMp9AAdh0iUUmkLUF94wSR
   Ie48nUVv7vn3SOV57/J929mHiJUr1S5e7bDqKp4SlDvCXam1ZzjwbB/JS
   Q==;
IronPort-SDR: IQrekuPNvcAZNATE+6UEjfmPDbdZjvz7oTLSrySo91q02TY2y3dczA8cX3Q3hanB/i+lkM8uKF
 XY/2Fbpd7jSmRyMqYMPsZUMALTJ4dM/SmDDc7ppqVZ15rsfyjzUhYy8m92DjyBu9ibutuwnhFL
 ps6fX9AtNfQ7hrt8g0FCg+5l3zCfzAAGD2Mic8GOEHflMgkby8JrpqXJsBSJz9+B2r+4uh+muf
 hbLICV+RpsYAiMlfU0sy9/GMuHiSvVN3UJWgDsPFjaTbXdryXTWC8JQwq1XHm+HRKeqD/8qjjp
 oTs=
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="101570517"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Oct 2020 04:08:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 30 Oct 2020 04:08:28 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 30 Oct 2020 04:08:26 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH] ARM: dts: at91: add serial MFD sub-node for usart
Date:   Fri, 30 Oct 2020 13:07:02 +0200
Message-ID: <20201030110702.886638-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "atmel,at91sam9260-usart" driver is a MFD driver, so it needs sub-nodes
to match the registered platform device. For this reason, we add a serial
subnode to all the "atmel,at91sam9260-usart" serial compatible nods. This
will also remove the boot warning:
"atmel_usart_serial: Failed to locate of_node [id: -2]"

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 arch/arm/boot/dts/at91-sam9x60ek.dts     |  3 +++
 arch/arm/boot/dts/at91rm9200.dtsi        | 15 ++++++++++++
 arch/arm/boot/dts/at91sam9261.dtsi       | 12 ++++++++++
 arch/arm/boot/dts/at91sam9261ek.dts      |  3 +++
 arch/arm/boot/dts/at91sam9263.dtsi       | 12 ++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi       | 15 ++++++++++++
 arch/arm/boot/dts/at91sam9n12.dtsi       | 15 ++++++++++++
 arch/arm/boot/dts/at91sam9rl.dtsi        | 15 ++++++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi        | 18 ++++++++++++++
 arch/arm/boot/dts/at91sam9x5_usart3.dtsi |  3 +++
 arch/arm/boot/dts/sam9x60.dtsi           |  3 +++
 arch/arm/boot/dts/sama5d2.dtsi           | 30 ++++++++++++++++++++++++
 arch/arm/boot/dts/sama5d3.dtsi           | 18 ++++++++++++++
 arch/arm/boot/dts/sama5d3_uart.dtsi      |  6 +++++
 arch/arm/boot/dts/sama5d4.dtsi           | 30 ++++++++++++++++++++++++
 15 files changed, 198 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index eae28b82c7fd..e317531f7363 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -280,6 +280,9 @@ AT91_XDMAC_DT_PERID(10))>,
 		atmel,use-dma-rx;
 		atmel,use-dma-tx;
 		status = "okay";
+		serial {
+			compatible = "atmel,at91rm9200-usart-serial";
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index d1181ead18e5..2abb646f6b68 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -602,6 +602,9 @@ dbgu: serial@fffff200 {
 				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart0: serial@fffc0000 {
@@ -615,6 +618,9 @@ usart0: serial@fffc0000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart1: serial@fffc4000 {
@@ -628,6 +634,9 @@ usart1: serial@fffc4000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart2: serial@fffc8000 {
@@ -641,6 +650,9 @@ usart2: serial@fffc8000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart3: serial@fffcc000 {
@@ -654,6 +666,9 @@ usart3: serial@fffcc000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usb1: gadget@fffb0000 {
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 7adc36ca8a46..e9602378f92c 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -187,6 +187,9 @@ usart0: serial@fffb0000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart1: serial@fffb4000 {
@@ -200,6 +203,9 @@ usart1: serial@fffb4000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart2: serial@fffb8000{
@@ -213,6 +219,9 @@ usart2: serial@fffb8000{
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			ssc0: ssc@fffbc000 {
@@ -307,6 +316,9 @@ dbgu: serial@fffff200 {
 				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			pinctrl@fffff400 {
diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
index beed819609e8..fae5d408268d 100644
--- a/arch/arm/boot/dts/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/at91sam9261ek.dts
@@ -176,6 +176,9 @@ tsc2046@2 {
 
 			dbgu: serial@fffff200 {
 				status = "okay";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			watchdog@fffffd40 {
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index fe45d96239c9..e4d370b582c8 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -546,6 +546,9 @@ dbgu: serial@ffffee00 {
 				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart0: serial@fff8c000 {
@@ -559,6 +562,9 @@ usart0: serial@fff8c000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart1: serial@fff90000 {
@@ -572,6 +578,9 @@ usart1: serial@fff90000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart2: serial@fff94000 {
@@ -585,6 +594,9 @@ usart2: serial@fff94000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			ssc0: ssc@fff98000 {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 19fc748a87c5..8aad026f10ec 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -682,6 +682,9 @@ dbgu: serial@ffffee00 {
 				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart0: serial@fff8c000 {
@@ -695,6 +698,9 @@ usart0: serial@fff8c000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart1: serial@fff90000 {
@@ -708,6 +714,9 @@ usart1: serial@fff90000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart2: serial@fff94000 {
@@ -721,6 +730,9 @@ usart2: serial@fff94000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart3: serial@fff98000 {
@@ -734,6 +746,9 @@ usart3: serial@fff98000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			macb0: ethernet@fffbc000 {
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 0785389f5507..f83d1a313edf 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -599,6 +599,9 @@ dbgu: serial@fffff200 {
 				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			ssc0: ssc@f0010000 {
@@ -624,6 +627,9 @@ usart0: serial@f801c000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart1: serial@f8020000 {
@@ -635,6 +641,9 @@ usart1: serial@f8020000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart2: serial@f8024000 {
@@ -646,6 +655,9 @@ usart2: serial@f8024000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart3: serial@f8028000 {
@@ -657,6 +669,9 @@ usart3: serial@f8028000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			i2c0: i2c@f8010000 {
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 5653e70c84b4..5480b6542c6a 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -183,6 +183,9 @@ usart0: serial@fffb0000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart1: serial@fffb4000 {
@@ -196,6 +199,9 @@ usart1: serial@fffb4000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart2: serial@fffb8000 {
@@ -209,6 +215,9 @@ usart2: serial@fffb8000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart3: serial@fffbc000 {
@@ -222,6 +231,9 @@ usart3: serial@fffbc000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			ssc0: ssc@fffc0000 {
@@ -353,6 +365,9 @@ dbgu: serial@fffff200 {
 				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			pinctrl@fffff400 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 4cdb05079cc7..52aa49b007d1 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -683,6 +683,9 @@ dbgu: serial@fffff200 {
 				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart0: serial@f801c000 {
@@ -697,6 +700,9 @@ usart0: serial@f801c000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart1: serial@f8020000 {
@@ -711,6 +717,9 @@ usart1: serial@f8020000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart2: serial@f8024000 {
@@ -725,6 +734,9 @@ usart2: serial@f8024000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			i2c0: i2c@f8010000 {
@@ -781,6 +793,9 @@ uart0: serial@f8040000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			uart1: serial@f8044000 {
@@ -792,6 +807,9 @@ uart1: serial@f8044000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			adc0: adc@f804c000 {
diff --git a/arch/arm/boot/dts/at91sam9x5_usart3.dtsi b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
index 098d3fef5c37..a80593188ac1 100644
--- a/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
@@ -53,6 +53,9 @@ usart3: serial@f8028000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
index 84066c1298df..ab4d80134d86 100644
--- a/arch/arm/boot/dts/sam9x60.dtsi
+++ b/arch/arm/boot/dts/sam9x60.dtsi
@@ -598,6 +598,9 @@ AT91_XDMAC_DT_PERID(28))>,
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 47>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			pinctrl: pinctrl@fffff400 {
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 2ddc85dff8ce..26f231147d21 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -444,6 +444,9 @@ AT91_XDMAC_DT_PERID(35))>,
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 24>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			uart1: serial@f8020000 {
@@ -460,6 +463,9 @@ AT91_XDMAC_DT_PERID(37))>,
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 25>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			uart2: serial@f8024000 {
@@ -476,6 +482,9 @@ AT91_XDMAC_DT_PERID(39))>,
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 26>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			i2c0: i2c@f8028000 {
@@ -536,6 +545,9 @@ AT91_XDMAC_DT_PER_IF(1) |
 					dma-names = "tx", "rx";
 					atmel,fifo-size = <32>;
 					status = "disabled";
+					serial {
+						compatible = "atmel,at91rm9200-usart-serial";
+					};
 				};
 
 				spi2: spi@400 {
@@ -606,6 +618,9 @@ AT91_XDMAC_DT_PER_IF(1) |
 					dma-names = "tx", "rx";
 					atmel,fifo-size = <32>;
 					status = "disabled";
+					serial {
+						compatible = "atmel,at91rm9200-usart-serial";
+					};
 				};
 
 				spi3: spi@400 {
@@ -771,6 +786,9 @@ AT91_XDMAC_DT_PERID(41))>,
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 27>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			uart4: serial@fc00c000 {
@@ -787,6 +805,9 @@ AT91_XDMAC_DT_PERID(43))>,
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 28>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			flx2: flexcom@fc010000 {
@@ -815,6 +836,9 @@ AT91_XDMAC_DT_PER_IF(1) |
 					dma-names = "tx", "rx";
 					atmel,fifo-size = <32>;
 					status = "disabled";
+					serial {
+						compatible = "atmel,at91rm9200-usart-serial";
+					};
 				};
 
 				spi4: spi@400 {
@@ -885,6 +909,9 @@ AT91_XDMAC_DT_PER_IF(1) |
 					dma-names = "tx", "rx";
 					atmel,fifo-size = <32>;
 					status = "disabled";
+					serial {
+						compatible = "atmel,at91rm9200-usart-serial";
+					};
 				};
 
 				spi5: spi@400 {
@@ -956,6 +983,9 @@ AT91_XDMAC_DT_PER_IF(1) |
 					dma-names = "tx", "rx";
 					atmel,fifo-size = <32>;
 					status = "disabled";
+					serial {
+						compatible = "atmel,at91rm9200-usart-serial";
+					};
 				};
 
 				spi6: spi@400 {
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 86137f8d2b45..1791de52d1c3 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -203,6 +203,9 @@ usart0: serial@f001c000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 12>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart1: serial@f0020000 {
@@ -217,6 +220,9 @@ usart1: serial@f0020000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			uart0: serial@f0024000 {
@@ -228,6 +234,9 @@ uart0: serial@f0024000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			pwm0: pwm@f002c000 {
@@ -389,6 +398,9 @@ usart2: serial@f8020000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart3: serial@f8024000 {
@@ -403,6 +415,9 @@ usart3: serial@f8024000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			sha@f8034000 {
@@ -497,6 +512,9 @@ dbgu: serial@ffffee00 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 2>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			aic: interrupt-controller@fffff000 {
diff --git a/arch/arm/boot/dts/sama5d3_uart.dtsi b/arch/arm/boot/dts/sama5d3_uart.dtsi
index a3eaba995cf4..b9f83b771a09 100644
--- a/arch/arm/boot/dts/sama5d3_uart.dtsi
+++ b/arch/arm/boot/dts/sama5d3_uart.dtsi
@@ -45,6 +45,9 @@ uart0: serial@f0024000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			uart1: serial@f8028000 {
@@ -56,6 +59,9 @@ uart1: serial@f8028000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 17>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 04f24cf752d3..0627fa8cdaf4 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -284,6 +284,9 @@ uart0: serial@f8004000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 27>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			ssc0: ssc@f8008000 {
@@ -443,6 +446,9 @@ usart0: serial@f802c000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart1: serial@f8030000 {
@@ -461,6 +467,9 @@ usart1: serial@f8030000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			mmc1: mmc@fc000000 {
@@ -496,6 +505,9 @@ uart1: serial@fc004000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 28>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart2: serial@fc008000 {
@@ -514,6 +526,9 @@ usart2: serial@fc008000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 29>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart3: serial@fc00c000 {
@@ -532,6 +547,9 @@ usart3: serial@fc00c000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 30>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			usart4: serial@fc010000 {
@@ -550,6 +568,9 @@ usart4: serial@fc010000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 31>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			ssc1: ssc@fc014000 {
@@ -568,6 +589,9 @@ ssc1: ssc@fc014000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 49>;
 				clock-names = "pclk";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			spi1: spi@fc018000 {
@@ -588,6 +612,9 @@ spi1: spi@fc018000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 38>;
 				clock-names = "spi_clk";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 			spi2: spi@fc01c000 {
@@ -794,6 +821,9 @@ dbgu: serial@fc069000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 45>;
 				clock-names = "usart";
 				status = "disabled";
+				serial {
+					compatible = "atmel,at91rm9200-usart-serial";
+				};
 			};
 
 
-- 
2.25.1


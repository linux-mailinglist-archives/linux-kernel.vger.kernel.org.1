Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5882EA9BA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 12:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbhAELUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 06:20:16 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:52695 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbhAELUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 06:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1609845608; x=1641381608;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=K1ZVRShcvmk5YfFs3uIXX0LUIC7opQXrnO735QjgTVI=;
  b=TCSJ5j0VUT8mLe4CYna3BxOFQ9NQ+FmlxV2Pu/dT8P7NVbDWDTqqVyzh
   MhWdtP0UhOldA128QhtZl+/cOtX4hiaYj6XO0PXuHIqClvuNn6Id1npfk
   J+lxZrTwOhQ0VLX+vZGCUk2Gi9rXg2UcZ0V/NhjG2CsBRNrkfVWzKl6HT
   0BI6cYR54evkmWGdPe9GVj3+3SgMQ4a5Ov47WM20vrsCIfzwVSUDFgQt7
   hLSnugUgf6rENuHcMfsowK0RonD9XeZY9fflAmXPKZwT8a+ZGC0dl7GW+
   7fA2pbLiaZhoRh9cPkyX52fI7a5xmDKbuir7/fjH2a0breZBW0ruocK41
   g==;
IronPort-SDR: PIPqYiu/RlJphDhc78OvKhF2T4Q/jHDswbrWKdBuZAArDAs7Cyz8B1fSrPCL3TBzJQExFXAy3R
 a53gYcMvvTkNNsdp6utQgxe1/72PctbwUPzCrrBEnyO2xmZ2Z1yy/tYghli2GfiRp7bAB82yl4
 rZy4WnJGJviTJcN/nO1YJMC9EDjFydoxUg42quhMQcTjNRHKPlVOzHYSN2Mx0Ag31YAXseg64C
 tTgpWg1Dsed9hqVhn7CF0XHqK2vUG90pCs8638/c3xrLIJeU+Hf0d0V555vu0zlzBdf9vuHgA4
 Sbg=
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="101796283"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jan 2021 04:18:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 5 Jan 2021 04:18:52 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 5 Jan 2021 04:18:48 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama5d2: remove atmel,wakeup-type references
Date:   Tue, 5 Jan 2021 13:18:45 +0200
Message-ID: <1609845525-10766-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atmel,wakeup-type DT property is not referenced anywhere in the current
and previous version of the code thus remove it.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-kizbox3_common.dtsi    | 1 -
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts   | 1 -
 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts | 1 -
 arch/arm/boot/dts/at91-sama5d2_icp.dts        | 1 -
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts     | 1 -
 arch/arm/boot/dts/at91-sama5d2_xplained.dts   | 1 -
 6 files changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/at91-kizbox3_common.dtsi b/arch/arm/boot/dts/at91-kizbox3_common.dtsi
index 9ce513dd514b..c4b3750495da 100644
--- a/arch/arm/boot/dts/at91-kizbox3_common.dtsi
+++ b/arch/arm/boot/dts/at91-kizbox3_common.dtsi
@@ -341,7 +341,6 @@
 
 	input@0 {
 		reg = <0>;
-		atmel,wakeup-type = "low";
 	};
 };
 
diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
index 0e159f879c15..84e1180f3e89 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -142,7 +142,6 @@
 
 				input@0 {
 					reg = <0>;
-					atmel,wakeup-type = "low";
 				};
 			};
 
diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
index 6b38fa3f5568..180a08765cb8 100644
--- a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
@@ -209,7 +209,6 @@
 
 	input@0 {
 		reg = <0>;
-		atmel,wakeup-type = "low";
 	};
 };
 
diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/at91-sama5d2_icp.dts
index 6783cf16ff81..46722a163184 100644
--- a/arch/arm/boot/dts/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_icp.dts
@@ -697,7 +697,6 @@
 
 	input@0 {
 		reg = <0>;
-		atmel,wakeup-type = "low";
 	};
 };
 
diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
index c894c7c788a9..8de57d164acd 100644
--- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
@@ -206,7 +206,6 @@
 
 				input@0 {
 					reg = <0>;
-					atmel,wakeup-type = "low";
 				};
 			};
 
diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 058fae1b4a76..4e7cf21f124c 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -351,7 +351,6 @@
 
 				input@0 {
 					reg = <0>;
-					atmel,wakeup-type = "low";
 				};
 			};
 
-- 
2.7.4


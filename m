Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CEF26E4B9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgIQSzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:55:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbgIQSzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:55:14 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5F272087D;
        Thu, 17 Sep 2020 18:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600368913;
        bh=m4d0Mo6h1I7U3GsnUnxj8fcz6YwDuFfT5VSLKP1B/iY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x/xflhKP6mZ4B8OkK2KFxTyt9GC+YDF1SisePZY73pcj9lxWGr+Ylo1IAXBSQ3HgF
         gd85f0TkUkWb/cK/FvJpmotOOkvJKKsBZGDzdkSVuFP5iyClQosrLaMp4VrtIXwqa1
         JvDCy4SIGZvANA4TI3WUYyU/1fRw02dc5D1xvwHo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Robin Gong <yibin.gong@nxp.com>,
        Peter Chen <peter.chen@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 4/4] arm64: dts: imx8mq: correct interrupt flags
Date:   Thu, 17 Sep 2020 20:54:49 +0200
Message-Id: <20200917185449.5687-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917185449.5687-1-krzk@kernel.org>
References: <20200917185449.5687-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
These are simple defines so they could be used in DTS but they will not
have the same meaning:
1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING

Correct the interrupt flags, assuming the author of the code wanted same
logical behavior behind the name "ACTIVE_xxx", this is:
  ACTIVE_LOW  => IRQ_TYPE_LEVEL_LOW

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on HW.

Changes since v1:
1. Correct title
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 5 +++--
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi       | 3 ++-
 arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts       | 3 ++-
 arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts        | 3 ++-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index cce1b595e2d6..af139b283daf 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "dt-bindings/input/input.h"
+#include <dt-bindings/interrupt-controller/irq.h>
 #include "dt-bindings/pwm/pwm.h"
 #include "dt-bindings/usb/pd.h"
 #include "imx8mq.dtsi"
@@ -60,7 +61,7 @@
 			label = "WWAN_WAKE";
 			gpios = <&gpio3 8 GPIO_ACTIVE_LOW>;
 			interrupt-parent = <&gpio3>;
-			interrupts = <8 GPIO_ACTIVE_LOW>;
+			interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
 			wakeup-source;
 			linux,code = <KEY_PHONE>;
 		};
@@ -288,7 +289,7 @@
 		#clock-cells = <0>;
 		clock-output-names = "pmic_clk";
 		interrupt-parent = <&gpio1>;
-		interrupts = <3 GPIO_ACTIVE_LOW>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 		rohm,reset-snvs-powered;
 
 		regulators {
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 56295dd2fa8f..0c13b70192af 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "dt-bindings/input/input.h"
+#include <dt-bindings/interrupt-controller/irq.h>
 #include "dt-bindings/pwm/pwm.h"
 #include "dt-bindings/usb/pd.h"
 #include "imx8mq.dtsi"
@@ -640,7 +641,7 @@
 		clock-names = "osc";
 		clock-output-names = "pmic_clk";
 		interrupt-parent = <&gpio1>;
-		interrupts = <7 GPIO_ACTIVE_LOW>;
+		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
 		rohm,reset-snvs-powered;
 
 		regulators {
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts b/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
index d6d3a3d5abc3..a3b9d615a3b4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "imx8mq.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "Google i.MX8MQ Phanbell";
@@ -125,7 +126,7 @@
 		clocks = <&pmic_osc>;
 		clock-output-names = "pmic_clk";
 		interrupt-parent = <&gpio1>;
-		interrupts = <3 GPIO_ACTIVE_LOW>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 
 		regulators {
 			buck1: BUCK1 {
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts b/arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts
index f4d5748a7bd6..89cbec5c41b2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts
@@ -9,6 +9,7 @@
 /dts-v1/;
 
 #include "imx8mq.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "TechNexion PICO-PI-8M";
@@ -70,7 +71,7 @@
 		clock-names = "osc";
 		clock-output-names = "pmic_clk";
 		interrupt-parent = <&gpio1>;
-		interrupts = <3 GPIO_ACTIVE_LOW>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-names = "irq";
 
 		regulators {
-- 
2.17.1


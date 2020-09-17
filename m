Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C8026E4BE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgIQS5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:57:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbgIQSy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:54:59 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3169A2087D;
        Thu, 17 Sep 2020 18:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600368898;
        bh=U0vVjhUISNwPrjeZu16FGsqMLDo7E7ppL+M4B8scFkg=;
        h=From:To:Cc:Subject:Date:From;
        b=Aeq5BGF1fX3kvLjtgdh+DZzkwA7lzl0Lsiw+EsCiLRyssJWgEgr3lfJjQ0+/JQmxz
         5LbXiGtsRroKboaxJXsyDwXCvhwHkRzzAkgJefhhRixYNpmxSzfOsfFro6DtMYX4TR
         0fKMYDalTBEZ5pTXa2KL5p47V2i1FEdPK/z+PRcQ=
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
Subject: [PATCH v2 1/4] ARM: dts: imx6qdl-gw5xxx: correct interrupt flags
Date:   Thu, 17 Sep 2020 20:54:46 +0200
Message-Id: <20200917185449.5687-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
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
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw560x.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw5907.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw5910.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw5912.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw5913.dtsi | 3 ++-
 14 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index 4d01c3300b97..3c04b5a4f3cb 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -152,7 +153,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index f6182a9d201c..736074f1c3ef 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -217,7 +218,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index a28e79463d0c..8072ed47c6bb 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -210,7 +211,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 55f368e192c0..8c9bcdd39830 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/sound/fsl-imx-audmux.h>
 
 / {
@@ -247,7 +248,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
index 1516e2b0bcde..e5d803d023c8 100644
--- a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
@@ -48,6 +48,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/media/tda1997x.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/sound/fsl-imx-audmux.h>
 
 / {
@@ -219,7 +220,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
index 0da6e6f7482b..290a607fede9 100644
--- a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -144,7 +145,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
index faf9a3ba61b2..c15b9cc63bf8 100644
--- a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
@@ -47,6 +47,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -180,7 +181,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw560x.dtsi b/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
index f68f9dada5b0..093a219a77ae 100644
--- a/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
@@ -47,6 +47,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -294,7 +295,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
index fbe6c32bd756..e1c8dd233cab 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
@@ -47,6 +47,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	chosen {
@@ -235,7 +236,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
index 23c6e4047621..3cd2e717c1da 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
@@ -47,6 +47,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -257,7 +258,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw5907.dtsi b/arch/arm/boot/dts/imx6qdl-gw5907.dtsi
index b1ff7c859c4d..21c68a55bcb9 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5907.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5907.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -154,7 +155,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw5910.dtsi b/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
index 6c943a517ad7..ed4e22259959 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -163,7 +164,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw5912.dtsi b/arch/arm/boot/dts/imx6qdl-gw5912.dtsi
index 441d8ce97aa4..797f160249f7 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5912.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5912.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -158,7 +159,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw5913.dtsi b/arch/arm/boot/dts/imx6qdl-gw5913.dtsi
index d62a8da49367..4cd7d290f5b2 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5913.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5913.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -139,7 +140,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
-- 
2.17.1


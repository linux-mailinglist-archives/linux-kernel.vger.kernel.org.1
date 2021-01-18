Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5192F9D52
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389739AbhARK62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:58:28 -0500
Received: from comms.puri.sm ([159.203.221.185]:59760 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389763AbhARK5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:57:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 47B7FE00D9;
        Mon, 18 Jan 2021 02:55:27 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yRjvhTAmIEAZ; Mon, 18 Jan 2021 02:55:25 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, krzk@kernel.org,
        kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 9/9] arm64: dts: Add Librem5 Evergreen
Date:   Mon, 18 Jan 2021 11:54:25 +0100
Message-Id: <20210118105425.425-10-martin.kepplinger@puri.sm>
In-Reply-To: <20210118105425.425-1-martin.kepplinger@puri.sm>
References: <20210118105425.425-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add librem5-r4 with specifics to that revision like the near-level,
battery and charger properties. For schematics and more information,
see https://developer.puri.sm/Librem5/Hardware_Reference/Evergreen.html

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../boot/dts/freescale/imx8mq-librem5-r4.dts  | 35 +++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 38559943c15d..e814ee98fecf 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -48,6 +48,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mq-hummingboard-pulse.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-devkit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-r2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-r3.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-r4.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-nitrogen.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-phanbell.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-pico-pi.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts
new file mode 100644
index 000000000000..cbfb49aa2563
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2020 Purism SPC <kernel@puri.sm>
+
+/dts-v1/;
+
+#include "imx8mq-librem5.dtsi"
+
+/ {
+	model = "Purism Librem 5r4";
+	compatible = "purism,librem5r4", "purism,librem5", "fsl,imx8mq";
+};
+
+&accel_gyro {
+	mount-matrix =  "1",  "0",  "0",
+			"0",  "1",  "0",
+			"0",  "0", "-1";
+};
+
+&bat {
+	maxim,rsns-microohm = <1667>;
+};
+
+&bq25895 {
+	ti,battery-regulation-voltage = <4200000>; /* uV */
+	ti,charge-current = <1500000>; /* uA */
+	ti,termination-current = <144000>;  /* uA */
+};
+
+&led_backlight {
+	led-max-microamp = <25000>;
+};
+
+&proximity {
+	proximity-near-level = <10>;
+};
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A999D1B132A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 19:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgDTRcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 13:32:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgDTRcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:32:14 -0400
Received: from localhost.localdomain (unknown [157.46.94.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6547320782;
        Mon, 20 Apr 2020 17:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587403934;
        bh=ELExJDrsHxAW1f5Po7cKx9b1yYQLw/eUqCrMgMTSams=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eeDtm9R7Vj2lgcVJLc0IDHvZwr8k9g7zw9MiZhYvATtfV6QoUOtbuuWCBUBvYnCb4
         iEZjdvAnAdcMq6lvZHJB29A89CJURyVTJtDgoRwMd0GNGy35aLlaprosVgkEOLT5bc
         K7y+xUqPw+dIZh4Q43ISBDFrFWVA7+wo9zud7N2o=
From:   mani@kernel.org
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 6/6] ARM: dts: stm32mp1: Add IoT Box board support
Date:   Mon, 20 Apr 2020 23:01:24 +0530
Message-Id: <20200420173124.27416-7-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420173124.27416-1-mani@kernel.org>
References: <20200420173124.27416-1-mani@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

IoT Box is an IoT gateway device based on Stinger96 board powered by
STM32MP1 SoC, designed and manufactured by Shiratech Solutions. This
device makes use of Stinger96 board by having it as a base board with
one additional mezzanine on top.

Following are the features exposed by this device in addition to the
Stinger96 board:

* WiFi/BT
* CCS811 VOC sensor
* 2x Digital microphones IM69D130
* 12x WS2812B LEDs

Following peripherals are tested and known to work:

* WiFi/BT
* CCS811

More information about this device can be found in Shiratech website:
https://www.shiratech-solutions.com/products/iot-box/

Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 arch/arm/boot/dts/Makefile                |  1 +
 arch/arm/boot/dts/stm32mp157a-iot-box.dts | 92 +++++++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32mp157a-iot-box.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 966b81dfffd6..455ec6eb6303 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1030,6 +1030,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
 	stm32h743i-disco.dtb \
 	stm32mp157a-avenger96.dtb \
 	stm32mp157a-dk1.dtb \
+	stm32mp157a-iot-box.dtb \
 	stm32mp157a-stinger96.dtb \
 	stm32mp157c-dhcom-pdk2.dtb \
 	stm32mp157c-dk2.dtb \
diff --git a/arch/arm/boot/dts/stm32mp157a-iot-box.dts b/arch/arm/boot/dts/stm32mp157a-iot-box.dts
new file mode 100644
index 000000000000..fa1c006ce531
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp157a-iot-box.dts
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2020 Manivannan Sadhasivam
+ */
+
+/dts-v1/;
+#include "stm32mp157a-stinger96.dtsi"
+
+/ {
+	model = "Shiratech STM32MP157A IoT Box";
+	compatible = "shiratech,stm32mp157a-iot-box", "st,stm32mp157";
+
+	wlan_pwr: regulator-wlan {
+		compatible = "regulator-fixed";
+
+		regulator-name = "wl-reg";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpiog 3 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&i2c2 {
+	ccs811@5b {
+		compatible = "ams,ccs811";
+		reg = <0x5b>;
+		wakeup-gpios = <&gpioa 12 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpioa 11 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pinctrl {
+	/*
+	 * Note: The SDMMC2 pins lack external pullups on data lines. Hence,
+	 * we need to enable it in the SoC.
+	 */
+	sdmmc2_b4_pins_pull: sdmmc2-b4-pull {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
+				 <STM32_PINMUX('B', 15, AF9)>, /* SDMMC2_D1 */
+				 <STM32_PINMUX('B', 3, AF9)>, /* SDMMC2_D2 */
+				 <STM32_PINMUX('B', 4, AF9)>, /* SDMMC2_D3 */
+				 <STM32_PINMUX('G', 6, AF10)>; /* SDMMC2_CMD */
+			slew-rate = <1>;
+			bias-pull-up;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('E', 3, AF9)>; /* SDMMC2_CK */
+			slew-rate = <2>;
+			drive-push-pull;
+			bias-disable;
+		};
+	};
+};
+
+/* WiFi */
+&sdmmc2 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc2_b4_pins_pull>;
+	pinctrl-1 = <&sdmmc2_b4_od_pins_b>;
+	pinctrl-2 = <&sdmmc2_b4_sleep_pins_a>;
+	broken-cd;
+	non-removable;
+	st,neg-edge;
+	bus-width = <1>;
+	vmmc-supply = <&wlan_pwr>;
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	brcmf: bcrmf@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
+/* Bluetooth */
+&uart4 {
+	/* Note: HW flow control is broken, hence using custom CTS/RTS gpios */
+	/delete-property/st,hw-flow-ctrl;
+	cts-gpios = <&gpioa 15 GPIO_ACTIVE_LOW>;
+	rts-gpios = <&gpiob 0 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	bluetooth {
+		shutdown-gpios = <&gpiog 2 GPIO_ACTIVE_HIGH>;
+		compatible = "brcm,bcm43438-bt";
+		max-speed = <115200>;
+	};
+};
-- 
2.17.1


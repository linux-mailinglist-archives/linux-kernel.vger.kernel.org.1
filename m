Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDBF2E20CE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 20:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgLWTS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 14:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgLWTSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 14:18:25 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67041C06179C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 11:17:45 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id w5so198945pgj.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 11:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jQDHwm8Q1G8tzmRwRpzQML3DFcNr08btuCeAhlW/y4M=;
        b=D8WmdU9cZxnOdTUI4YYJHZFP+kB5qPcGMDn/rwM9iETsxFB801Udz53DPGhvnfjhPu
         /2lt7XoaM4L+wmUtMw/j+io+GwM3RlfuAPb7gJ4Z6iDqQXmJbPZwzHScM1ct1dhuC/s9
         Qv6cONVQ1urwGxeO8PjpuPsnzT5lZLbXe20io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jQDHwm8Q1G8tzmRwRpzQML3DFcNr08btuCeAhlW/y4M=;
        b=aM8Tv6w7WiCnoaVqMmlg83MehMKJ8rHTVWthcrn/nRqW1KAYLawJD/l0q/JDZgg2W3
         eIw2oUjMMuu8PDTyAm2ECqJZr6n3Uqfh0VotGBoEiDB2A22EfV6N8OD1Hl9PL3ytCL7I
         jQdKgN631g1DoNPHGlrg3s29CUdoOr5vyrAftbP488iE9uCTBS9OcgQkoQAoJFIc1Xh3
         mTo7bc5l6UJEEFrrH8xokWNpOy18IBS4EHv28+NrLtsenr127O7m2uRoAlPaitj/dk4a
         MUu+LW24anqpLL3KwzpEqsgbfLJQcgdLMplcX1p2oQJ5h1+l69P25pQZfVjnW/RW6rj/
         7aDA==
X-Gm-Message-State: AOAM532TXVqy4NZl7Mg7i8g0i1uZc50i2+GTieXoDqMpplC02GBn32B5
        hP75HnB1oCKMxu9RXageT3rWPw==
X-Google-Smtp-Source: ABdhPJzsuuJ4+gK/q8ZxMWImUZ2M7v/+/1QV2w4Q3FX96WAbdEGRckAHqsd09D6NRexK/ELQK0blqw==
X-Received: by 2002:a65:6116:: with SMTP id z22mr23233285pgu.264.1608751065006;
        Wed, 23 Dec 2020 11:17:45 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a884:29f0:6e54:608c:e1b9])
        by smtp.gmail.com with ESMTPSA id i2sm397640pjd.21.2020.12.23.11.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 11:17:44 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Francesco Utel <francesco.utel@engicam.com>,
        Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: [PATCH 5/5] ARM: dts: stm32: Add Engicam MicroGEA STM32MP1 MicroDev 2.0 7" OF
Date:   Thu, 24 Dec 2020 00:44:02 +0530
Message-Id: <20201223191402.378560-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201223191402.378560-1-jagan@amarulasolutions.com>
References: <20201223191402.378560-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7" OF is a capacitive touch 7" Open Frame panel solutions with
- 7" AUO B101AW03 LVDS panel
- EDT, FT5526 Touch

MicroGEA STM32MP1 is an EDIMM SoM based on STM32MP157A from Engicam.

MicroDev 2.0 is a general purpose miniature carrier board with CAN,
LTE and LVDS panel interfaces.

MicroGEA STM32MP1 needs to mount on top of MicroDev 2.0 board with
pluged 7" OF for creating complete MicroGEA STM32MP1 MicroDev 2.0
7" Open Frame Solution board.

Add support for it.

Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
Signed-off-by: Francesco Utel <francesco.utel@engicam.com>
Signed-off-by: Mirko Ardinghi <mirko.ardinghi@engicam.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 ...157a-microgea-stm32mp1-microdev2.0-of7.dts | 120 ++++++++++++++++++
 2 files changed, 121 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b4a9cd071f99..1332622a3f9f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1072,6 +1072,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
 	stm32mp157a-dk1.dtb \
 	stm32mp157a-iot-box.dtb \
 	stm32mp157a-microgea-stm32mp1-microdev2.0.dtb \
+	stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dtb \
 	stm32mp157a-stinger96.dtb \
 	stm32mp157c-dhcom-pdk2.dtb \
 	stm32mp157c-dhcom-picoitx.dtb \
diff --git a/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts b/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts
new file mode 100644
index 000000000000..b96e683072e2
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (c) STMicroelectronics 2019 - All Rights Reserved
+ * Copyright (c) 2020 Engicam srl
+ * Copyright (c) 2020 Amarula Solutons(India)
+ */
+
+/dts-v1/;
+#include "stm32mp157.dtsi"
+#include "stm32mp157a-engicam-microdev2.0.dtsi"
+#include "stm32mp157a-microgea-stm32mp1.dtsi"
+
+/ {
+	model = "Engicam MicroGEA STM32MP1 MicroDev 2.0 7\" Open Frame";
+	compatible = "engicam,microgea-stm32mp1-microdev2.0-of7",
+		     "engicam,microgea-stm32mp1", "st,stm32mp157";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	backlight: backlight {
+		compatible = "gpio-backlight";
+		gpios = <&gpiod 13 GPIO_ACTIVE_HIGH>;
+		default-on;
+	};
+
+	lcd_3v3: regulator-lcd-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpiof 10 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+		power-supply = <&panel_pwr>;
+	};
+
+	panel_pwr: regulator-panel-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "panel_pwr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpiob 10 GPIO_ACTIVE_HIGH>;
+		regulator-always-on;
+	};
+
+	panel {
+		compatible = "auo,b101aw03";
+		backlight = <&backlight>;
+		enable-gpios = <&gpiof 2 GPIO_ACTIVE_HIGH>;
+		power-supply = <&lcd_3v3>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&ltdc_ep0_out>;
+			};
+		};
+	};
+};
+
+&i2c2 {
+	i2c-scl-falling-time-ns = <20>;
+	i2c-scl-rising-time-ns = <185>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-1 = <&i2c2_sleep_pins_a>;
+	status = "okay";
+};
+
+&ltdc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ltdc_pins>;
+	status = "okay";
+
+	port {
+		ltdc_ep0_out: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
+
+&pinctrl {
+	ltdc_pins: ltdc {
+		pins {
+			pinmux = <STM32_PINMUX('G', 10, AF14)>,	/* LTDC_B2 */
+				 <STM32_PINMUX('H', 12, AF14)>,	/* LTDC_R6 */
+				 <STM32_PINMUX('H', 11, AF14)>,	/* LTDC_R5 */
+				 <STM32_PINMUX('D', 10, AF14)>,	/* LTDC_B3 */
+				 <STM32_PINMUX('D', 9, AF14)>,	/* LTDC_B0 */
+				 <STM32_PINMUX('E', 5, AF14)>,	/* LTDC_G0 */
+				 <STM32_PINMUX('E', 6, AF14)>,	/* LTDC_G1 */
+				 <STM32_PINMUX('E', 13, AF14)>,	/* LTDC_DE */
+				 <STM32_PINMUX('E', 15, AF14)>,	/* LTDC_R7 */
+				 <STM32_PINMUX('G', 7, AF14)>,	/* LTDC_CLK */
+				 <STM32_PINMUX('G', 12, AF14)>,	/* LTDC_B1 */
+				 <STM32_PINMUX('H', 2, AF14)>,	/* LTDC_R0 */
+				 <STM32_PINMUX('H', 3, AF14)>,	/* LTDC_R1 */
+				 <STM32_PINMUX('H', 8, AF14)>,	/* LTDC_R2 */
+				 <STM32_PINMUX('H', 9, AF14)>,	/* LTDC_R3 */
+				 <STM32_PINMUX('H', 10, AF14)>,	/* LTDC_R4 */
+				 <STM32_PINMUX('H', 13, AF14)>,	/* LTDC_G2 */
+				 <STM32_PINMUX('H', 14, AF14)>,	/* LTDC_G3 */
+				 <STM32_PINMUX('H', 15, AF14)>,	/* LTDC_G4 */
+				 <STM32_PINMUX('I', 0, AF14)>,	/* LTDC_G5 */
+				 <STM32_PINMUX('I', 1, AF14)>,	/* LTDC_G6 */
+				 <STM32_PINMUX('I', 2, AF14)>,	/* LTDC_G7 */
+				 <STM32_PINMUX('I', 4, AF14)>,	/* LTDC_B4 */
+				 <STM32_PINMUX('I', 5, AF14)>,	/* LTDC_B5 */
+				 <STM32_PINMUX('B', 8, AF14)>,	/* LTDC_B6 */
+				 <STM32_PINMUX('I', 7, AF14)>,	/* LTDC_B7 */
+				 <STM32_PINMUX('I', 9, AF14)>,	/* LTDC_VSYNC */
+				 <STM32_PINMUX('I', 10, AF14)>;	/* LTDC_HSYNC */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <3>;
+		};
+	};
+};
-- 
2.25.1


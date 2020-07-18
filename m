Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1411224A6C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 11:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgGRJoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 05:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgGRJoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 05:44:09 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3462C0619D2;
        Sat, 18 Jul 2020 02:44:08 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z2so13500512wrp.2;
        Sat, 18 Jul 2020 02:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pJC59erINRP0bf+MfLFMFuLvKJR8XJ12i44RcGLpj2E=;
        b=K9QT3C2Fo0BAUMHNyX3U4ftKh4xnp1K2XduPyzDaECoO/WN3zucjokxEjQ74cXkE60
         s61JsdHudGJFaD/IxOROlIJov5QJuxZwH4Zz/9zNBgpb4mexzQzSBZUxLIH+qVo9HGgb
         eg0+CEOWFF74Cj6KFiZ7gYPVc1ok1u2aG33K82gwBLIYjkho518oOXQEY7fgK5k+dbkO
         SooVdg9hTTmK4rYEm7Csrb0eerIIwmrfqkEnOzbUao94HOcf0Qq+yCP8qeKBFCQVRByY
         rVbCYEK628YdFtE1kBmT234CH+i4tg4whqPmwCZOn6BXxvnTaboa5ZYUuyzV8CZV0w8D
         GqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pJC59erINRP0bf+MfLFMFuLvKJR8XJ12i44RcGLpj2E=;
        b=Cb5LvErwJ3/qbtW4viAbXlWdAH2ryevIUeDE3RRRP0sMwf67gd2ESqSGGu+SYIZlpH
         rbQMSsYTszh9LTNJDFqWrVzFWtA4EnRYdFFXJ8yj2hPW7HTBPfUeZU53TcRBCLIOE/e7
         zml4iuldVYSPre1LI8zwkkKOMYnDHlL8e/IU9Bmsj8MmaC+M0+q1I+LnE+DeBb4p72Dg
         QoBnSffsVK0A+bcSz+6ykV2K+mWii3npNMCdphbrRNzL/U73hgNxNdTS6p5nCm6YfCe+
         El0S6TIuq4AMHTcKzE1V3MH+OWIv5NQ0OeSE9Icg+GMKSQ/F0kE84jGJxr83seit70VF
         GZWg==
X-Gm-Message-State: AOAM530lQTW++YTALDj95ZQCgvxAyRl+tyABFXGSG/ZJNgnEZyXVTh4m
        sjD2RLC6jyShpj83dAGVcQ4=
X-Google-Smtp-Source: ABdhPJwpyc2BrlitG3628ecIb+6jNMA6OCTk8cqDcXSd/35mA/hDehcbPn/lMSDSvPbhB1SVauU1mA==
X-Received: by 2002:a5d:420e:: with SMTP id n14mr14909876wrq.164.1595065447652;
        Sat, 18 Jul 2020 02:44:07 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id v11sm16764554wmb.3.2020.07.18.02.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 02:44:07 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 2/2] arm64: dts: meson: add support for the WeTek Core 2
Date:   Sat, 18 Jul 2020 09:44:00 +0000
Message-Id: <20200718094400.1185-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200718094400.1185-1-christianshewitt@gmail.com>
References: <20200718094400.1185-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WeTek Core2 is a commercial device based on the Amlogic Q200 reference
design but with the following differences:

- 3GB RAM, 32GB eMMC
- Blue and Red LEDs used to signal on/off status
- uart_AO can be accessed after opening the case; soldering required
- USB OTG is not accessible (inside the case)
- Realtek RTL8152 Ethernet (internal USB connection)

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |  1 +
 .../dts/amlogic/meson-gxm-wetek-core2.dts     | 87 +++++++++++++++++++
 2 files changed, 88 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-wetek-core2.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 5cac4d1d487d..4e2239ffcaa5 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -41,6 +41,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q201.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-rbox-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-s912-libretech-pc.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-vega-s96.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxm-wetek-core2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-c4.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-wetek-core2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-wetek-core2.dts
new file mode 100644
index 000000000000..b81f90015bd0
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-wetek-core2.dts
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-gxm.dtsi"
+#include "meson-gx-p23x-q20x.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	compatible = "wetek,core2", "amlogic,s912", "amlogic,meson-gxm";
+	model = "WeTek Core 2";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>; /* 2 GiB or 3 GiB */
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		blue {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio GPIODV_24 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1710000>;
+
+		button-update {
+			label = "update";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <10000>;
+		};
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <100>;
+
+		button-power {
+			label = "power";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+/* Disabled as Realtek RTL8152 USB provides Ethernet */
+&ethmac {
+	status = "disabled";
+};
+
+&internal_phy {
+	status = "disabled";
+};
+
+&ir {
+	linux,rc-map-name = "rc-wetek-play2";
+};
+
+/* This is connected to the Bluetooth module: */
+&uart_A {
+	status = "okay";
+	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		enable-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
+		clocks = <&wifi32k>;
+		clock-names = "lpo";
+	};
+};
-- 
2.17.1


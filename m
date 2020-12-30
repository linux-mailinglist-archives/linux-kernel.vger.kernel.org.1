Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EA62E77CA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 11:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgL3KiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 05:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgL3KiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 05:38:19 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3B4C06179C;
        Wed, 30 Dec 2020 02:37:39 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id g185so4399705wmf.3;
        Wed, 30 Dec 2020 02:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6t28SHKcchxFFDmVg/DTxzcIcnwyXJGZEre60W6J1QA=;
        b=pILmpAubTM/HAKupW6uGgH59+masSEE8xchp+TYZtQgIgr3owYgMk+45/fdLviQ37l
         UwkjdGj9HJnS5ZDL80c6gpa5l4JxwcBiw9a9KtrVdLcDHyi0F/bhOeJQwtCImqwrc52h
         NwA5QCR4BMGFdHYxDM+kAd8kmLf9nKSkxJNjL5fATu+DYMEf8NUjKrCnVLENNBdAbH9I
         W5RLeb9w4a+NxqzU1PT5YJtHfNOdQHDrzvpg5SwmhEB9IzUSzrBiodKfaVBm2nWhz3tG
         dGwDJHNeTyQ+uZe360/yZvv/WHww0oYkcPX7TSNMmhhHdK9F4D7n+zLSNSK8pLH0qDvs
         LIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6t28SHKcchxFFDmVg/DTxzcIcnwyXJGZEre60W6J1QA=;
        b=hx5rBtRU0hJYsXWjkg3i4jZnrCC6XwMweu7NRyf+QRIDD/YlfSMUn75UePYn1FanxM
         IM3CCQ+P6t5aiezYI6y9g1ALm3WqLKWgSTw+RbWtuvZVoHVdqIz/t9Y+WMYSu+wggXNP
         jFgfhSDUA2xyrvPBfMUG9n1Q+mVX/143H8i2ouexwoQjYoeEMKhzFskSVqtx3T0UUWB/
         yKD2cXRPwHqsotuEKk+UsqOB71VELp/MJTbeygcYhqzOYvY5ZVsAGT0hsuAHM/Gzkxv5
         g0FZmT24RKnThFwpGpOGsj8bdLQvibo+XatgcDKVO8zjrJd9IuybP4JOxqe5IP0zN8gv
         OyqQ==
X-Gm-Message-State: AOAM532WF3vTQ2mjZSszVAw8/j6cNk8K79tj8LrmCvwY1DgWACMi/Akw
        SJeZScmlGtLR10HUGPZBGqI=
X-Google-Smtp-Source: ABdhPJyw0o+67rpXjqph6wMQ/Vk2mxdEEMm6eA011bsDDZ65OGooFqn5qoTn6wRgjbnxMQmIuHdqrA==
X-Received: by 2002:a1c:e084:: with SMTP id x126mr7003022wmg.109.1609324658172;
        Wed, 30 Dec 2020 02:37:38 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id j15sm66672156wrr.85.2020.12.30.02.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 02:37:37 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 2/2] arm64: dts: meson: add initial Beelink GS-King-X device-tree
Date:   Wed, 30 Dec 2020 10:37:29 +0000
Message-Id: <20201230103729.2272-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201230103729.2272-1-christianshewitt@gmail.com>
References: <20201230103729.2272-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Shenzen AZW (Beelink) GS-King-X is based on the Amlogic W400 reference
board with an S922X-H chip.

- 4GB LPDDR4 RAM
- 64GB eMMC storage
- 10/100/1000 Base-T Ethernet
- AP6356S Wireless (802.11 a/b/g/n/ac, BT 4.1)
- HDMI 2.1 video
- S/PDIF optical output
- 2x ESS9018 audio DACs
- 4x Ricor RT6862 audio amps
- Analogue headphone output
- 1x USB 2.0 OTG port
- 3x USB 3.0 ports
- IR receiver
- 1x micro SD card slot (internal)
- USB SATA controller with 2x 3.5" drive bays
- 1x Power on/off button

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../boot/dts/amlogic/meson-g12b-gsking-x.dts  | 133 ++++++++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index ced03946314f..dce41cd3f347 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-axg-s400.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-sei510.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-x96-max.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gsking-x.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts
new file mode 100644
index 000000000000..c9d9dcb0cd65
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Copyright (c) 2019 Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-g12b-w400.dtsi"
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
+
+/ {
+	compatible = "azw,gsking-x", "amlogic,g12b";
+	model = "Beelink GS-King X";
+
+	aliases {
+		rtc0 = &rtc;
+		rtc1 = &vrtc;
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <100>;
+
+		power-button {
+			label = "power";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "G12B-GSKING-X";
+		audio-aux-devs = <&tdmout_a>;
+		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 1",
+				"TDMOUT_A IN 1", "FRDDR_B OUT 1",
+				"TDMOUT_A IN 2", "FRDDR_C OUT 1",
+				"TDM_A Playback", "TDMOUT_A OUT";
+
+		assigned-clocks = <&clkc CLKID_MPLL2>,
+				  <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&frddr_a>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&frddr_b>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&frddr_c>;
+		};
+
+		/* 8ch hdmi interface */
+		dai-link-3 {
+			sound-dai = <&tdmif_a>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			dai-tdm-slot-tx-mask-1 = <1 1>;
+			dai-tdm-slot-tx-mask-2 = <1 1>;
+			dai-tdm-slot-tx-mask-3 = <1 1>;
+			mclk-fs = <256>;
+
+			codec {
+				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_A>;
+			};
+		};
+
+		dai-link-4 {
+			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
+
+			codec {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&arb {
+	status = "okay";
+};
+
+&clkc_audio {
+	status = "okay";
+};
+
+&frddr_a {
+	status = "okay";
+};
+
+&frddr_b {
+	status = "okay";
+};
+
+&frddr_c {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+	pinctrl-0 = <&i2c3_sda_a_pins>, <&i2c3_sck_a_pins>;
+	pinctrl-names = "default";
+
+	rtc: rtc@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+		wakeup-source;
+	};
+};
+
+&tdmif_a {
+	status = "okay";
+};
+
+&tdmout_a {
+	status = "okay";
+};
+
+&tohdmitx {
+	status = "okay";
+};
-- 
2.17.1


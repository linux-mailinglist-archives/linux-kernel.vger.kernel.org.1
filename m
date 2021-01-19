Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2272FBE65
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390008AbhASR5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbhASO6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:58:25 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E983C061757;
        Tue, 19 Jan 2021 06:57:44 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c128so27793wme.2;
        Tue, 19 Jan 2021 06:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gvg6EKXcV+ZlSGn2h1lTgKayE+k74jIv1PZxsFjQ3l0=;
        b=AitiDzLbEtdu6gr3W9KisuygAfgqX1HpLdIK8cXlQ4ucnOZsFug1FnIYd/PTvD+cxO
         g4yg6UjEGR1eeoo38Eh6aIZ7atjf465w4hLS3GGFK53OgY7GbBIxX6rQuXHS4UYfpWgX
         51bfbuq1HwQXWFmfPtlXR2nOV+WqEMvvD91HvVh+q6GXr5ptXghK8W58b0bjj4MP01Ge
         lRQ6UE/4ATMZu1mt3N8tHVqTrLZgTN4ee57/i2hlL7LvGLGtR42RupZJfaoKP1yM59Fn
         SQlFfRYu4at5C257zD/R7Q27iyIjDuhy34vBd5c6pcEq6jGjqaFGGM/IjbrvSPOrWrnX
         2WWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gvg6EKXcV+ZlSGn2h1lTgKayE+k74jIv1PZxsFjQ3l0=;
        b=gnYVVlX5S272I4d0D3IO9pdjNUaMTwco1YeydtAfyX8aTxvbIA4U3/Pi6qQI3w7/F/
         utMDelm0CpCEX5EK/uQZXu6cD0dd6p6lq2HTLxpCdGOdnxgaLvLS63WmF2ivvOfPE4Bn
         ZeKtlrCiH/ecE7CD0Yv2lgES5DJYGGnp5V+vp756ZZChl4N4/fuv4BiJrNqyOw08ZTJL
         NyCt8cbKyX00vHdoZVyxg8PmAg6xlDk2b1gQyuTolz2Rt/dIFrK/JGwEF2JxcjjNiFFb
         /d+5E50lT8M2ruAEf8U9th2hoYD6nTDBcYj/5XwvSPvbcrREwAyg0LhVoUNJBSAyxAfH
         XLXA==
X-Gm-Message-State: AOAM531AieGx7GjG2DfyF0KcR4SZtmpvDng3WXVvpcTVUG9AEWS7KtwD
        48FU8SQNAr5YIe09HJTtGLg=
X-Google-Smtp-Source: ABdhPJyuXhJoZcY0Sle5Q4xr5UPf9w6X82S1erR93cLl3TJ4Jj3FNWQ7RML2DGJo2T7A+WDhiQKupw==
X-Received: by 2002:a05:600c:268b:: with SMTP id 11mr35008wmt.132.1611068262984;
        Tue, 19 Jan 2021 06:57:42 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id s1sm36786893wrv.97.2021.01.19.06.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 06:57:42 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v3 2/2] arm64: dts: meson: add initial Beelink GS-King-X device-tree
Date:   Tue, 19 Jan 2021 14:57:34 +0000
Message-Id: <20210119145734.12675-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210119145734.12675-1-christianshewitt@gmail.com>
References: <20210119145734.12675-1-christianshewitt@gmail.com>
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
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
---
Single change since v2 to shorten the audio card name to align with the
audio card name changes submitted in [0] (no dependency on the patch).

[0] https://patchwork.kernel.org/project/linux-amlogic/patch/20210101063737.26635-1-christianshewitt@gmail.com/

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
index 000000000000..211191f66344
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
+		model = "GSKING-X";
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


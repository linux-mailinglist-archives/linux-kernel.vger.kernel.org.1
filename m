Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934C326B71A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgIPARF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgIOOW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:22:58 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2E0C0611C1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 07:21:30 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so3553246wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 07:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k+cVukl4tya2DjuLEpOgBg4zNG49MfEZgMGjfR4kTzg=;
        b=WKqVKobHY1jHH8tkNtkhYLlP7ATqAAzDVvqNZUm+Br7u6ul67dLVjsY/vt6EfYmzIf
         4P/EXiI2nw/Ml9fNKIZfdtji++GNNWwX5fP3AhdDiWk5vxuSUgclfsEOe7qgrUVkBJZ4
         wwlTW2Mc4t1ZdOT0aslC1JzbLuk0iaYF9jbmzU9HfECeaUPUY3mMJscNkdvheAaEnCRN
         xZmQvLXmrqYcEMC3wjNP6vVM/S1/bxmxFwLY+flxpu4dZrTVfoA/BRBSPCLU2WNEo/13
         4OqIET1xWV8m5yR/dPAsQpXcmq8qemuveeA021GpgwdQGSa6UIuaJKX5Aqhw+RjMiMoi
         BCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k+cVukl4tya2DjuLEpOgBg4zNG49MfEZgMGjfR4kTzg=;
        b=kLOlUaL48zJzCme7goBbincPQAh5BiNTwfH5HvdynctiIGy87rCDN/CFsJLgQAL2FC
         bE4um80F2LEurmITmm6F81ENaP4Htx0oE5uQVYguyfoHwi5sDsL7W7hGBvy1VyMbQ9vC
         d1h0YMUANCqUWE5JjfBi9tdC++JrlFuBmq2tb37AfxCE/NIRpW2yPExPupcn6M3hzwkl
         KoHhDsKbm7//pkUsQ+h3jVtCr2ldc58Ev3ok5EZPWxw6FegT+bKzdQ6r71sHK+tIYP7s
         cl2uiFS8eAm87a39kw41kGcEpxsw8OhTlt8xjHft8pARTLl+McfOZhljtldfB2iou29o
         mUYQ==
X-Gm-Message-State: AOAM533eiDztsFbDF8QNqCv876eDBdAN2rvtjL/7vhyOYa2koDUY12Ag
        P7Zd0MVqnebp245zBv4NUzJvbA==
X-Google-Smtp-Source: ABdhPJysY9eaFewh/ggXi7rv2lyBPvOm1bGaZDKsKz/BySSLn1nY0UmvqnRhwZbP1w6qN4uRgbIkcg==
X-Received: by 2002:a5d:4a4a:: with SMTP id v10mr17652811wrs.72.1600179688723;
        Tue, 15 Sep 2020 07:21:28 -0700 (PDT)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id d2sm27821482wro.34.2020.09.15.07.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 07:21:28 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: meson: initial support for aml-s905x-cc v2
Date:   Tue, 15 Sep 2020 16:19:21 +0200
Message-Id: <20200915141921.57258-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200915141921.57258-1-jbrunet@baylibre.com>
References: <20200915141921.57258-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for the libretech aml-s905x-cc (Le Potato) v2

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../meson-gxl-s905x-libretech-cc-v2.dts       | 318 ++++++++++++++++++
 2 files changed, 319 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 4e2239ffcaa5..be5277b7fbf4 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -24,6 +24,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s805x-libretech-ac.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-hwacom-amazetv.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-khadas-vim.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc-v2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
new file mode 100644
index 000000000000..675eaa87963e
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/sound/meson-aiu.h>
+
+#include "meson-gxl-s905x.dtsi"
+
+/ {
+	compatible = "libretech,aml-s905x-cc-v2", "amlogic,s905x",
+		     "amlogic,meson-gxl";
+	model = "Libre Computer AML-S905X-CC V2";
+
+	aliases {
+		serial0 = &uart_AO;
+		ethernet0 = &ethmac;
+		spi0 = &spifc;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_tmds_out>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio GPIODV_24 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			panic-indicator;
+		};
+
+		led-green {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DISK_ACTIVITY;
+			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "disk-activity";
+		};
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+
+	ao_5v: regulator-ao_5v {
+		compatible = "regulator-fixed";
+		regulator-name = "AO_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_in>;
+		regulator-always-on;
+	};
+
+	dc_in: regulator-dc_in {
+		compatible = "regulator-fixed";
+		regulator-name = "DC_IN";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+
+	vcck: regulator-vcck {
+		compatible = "regulator-fixed";
+		regulator-name = "VCCK";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&ao_5v>;
+		regulator-always-on;
+	};
+
+	vcc_card: regulator-vcc_card {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_CARD";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vddio_ao3v3>;
+
+		gpio = <&gpio GPIOCLK_1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vcc5v: regulator-vcc5v {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&ao_5v>;
+
+		gpio = <&gpio GPIOH_3 GPIO_OPEN_DRAIN>;
+	};
+
+	vddio_ao3v3: regulator-vddio_ao3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&ao_5v>;
+		regulator-always-on;
+	};
+
+
+	vddio_card: regulator-vddio-card {
+		compatible = "regulator-gpio";
+		regulator-name = "VDDIO_CARD";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
+		gpios-states = <0>;
+
+		states = <3300000 0>,
+			 <1800000 1>;
+
+		regulator-settling-time-up-us = <200>;
+		regulator-settling-time-down-us = <50000>;
+	};
+
+	vddio_ao18: regulator-vddio_ao18 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO18";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vddio_ao3v3>;
+		regulator-always-on;
+	};
+
+	vcc_1v8: regulator-vcc_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC 1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vddio_ao3v3>;
+		regulator-always-on;
+	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXL-LIBRETECH-S905X-CC-V2";
+		assigned-clocks = <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>,
+				  <&clkc CLKID_MPLL2>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
+			dai-format = "i2s";
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
+			};
+		};
+
+		dai-link-2 {
+			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
+
+			codec-0 {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+
+&aiu {
+	status = "okay";
+};
+
+&cec_AO {
+	status = "okay";
+	pinctrl-0 = <&ao_cec_pins>;
+	pinctrl-names = "default";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
+
+&ethmac {
+	status = "okay";
+};
+
+&internal_phy {
+	pinctrl-0 = <&eth_link_led_pins>, <&eth_act_led_pins>;
+	pinctrl-names = "default";
+};
+
+&ir {
+	status = "okay";
+	pinctrl-0 = <&remote_input_ao_pins>;
+	pinctrl-names = "default";
+};
+
+&hdmi_tx {
+	status = "okay";
+	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
+	hdmi-supply = <&vcc5v>;
+	pinctrl-names = "default";
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
+&saradc {
+	status = "okay";
+	vref-supply = <&vddio_ao18>;
+};
+
+/* SD card */
+&sd_emmc_b {
+	pinctrl-0 = <&sdcard_pins>;
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-ddr50;
+	max-frequency = <100000000>;
+	disable-wp;
+
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
+
+	vmmc-supply = <&vcc_card>;
+	vqmmc-supply = <&vddio_card>;
+
+	status = "okay";
+};
+
+/* eMMC */
+&sd_emmc_c {
+	pinctrl-0 = <&emmc_pins>;
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	max-frequency = <200000000>;
+	disable-wp;
+
+	mmc-pwrseq = <&emmc_pwrseq>;
+	vmmc-supply = <&vddio_ao3v3>;
+	vqmmc-supply = <&vcc_1v8>;
+
+	status = "okay";
+};
+
+&spifc {
+	status = "okay";
+	pinctrl-0 = <&nor_pins>;
+	pinctrl-names = "default";
+
+	nor_4u1: spi-flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <3000000>;
+	};
+};
+
+&uart_AO {
+	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
+};
+
+&usb {
+	status = "okay";
+	dr_mode = "host";
+};
+
+&usb2_phy0 {
+	pinctrl-names = "default";
+	phy-supply = <&vcc5v>;
+};
+
+&usb2_phy1 {
+	phy-supply = <&vcc5v>;
+};
-- 
2.25.4


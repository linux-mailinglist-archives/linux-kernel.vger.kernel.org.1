Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE4B274E19
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgIWBFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:05:02 -0400
Received: from relay5.mymailcheap.com ([159.100.248.207]:49530 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgIWBE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:04:58 -0400
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.66.162])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id E94A0260EC;
        Wed, 23 Sep 2020 01:04:54 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay2.mymailcheap.com (Postfix) with ESMTPS id 8BC923ECD9;
        Wed, 23 Sep 2020 03:04:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 6C2532A913;
        Wed, 23 Sep 2020 03:04:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1600823093;
        bh=CCPZEQWOsilO9Ws3sgJ39rNzSgwJY9kO6OcGHL39LNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tWriv9AJGSQsqyVHsa+NjYnxTWjZ4dOUrh1+ec7z8dJ16q/+7rfZVqgYFFcD8hsQd
         lyR3n5YuwYPzsPUdpSoFfIb3EI3OSaQDq0v4wghSo0zshWQmhmly7ZGHaSFicnvXEV
         sjt/LVxaPm/OBy7MkkHM8GB8SykVg1A/DY/Mo4YM=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T7CajxRBT3_O; Wed, 23 Sep 2020 03:04:52 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Wed, 23 Sep 2020 03:04:52 +0200 (CEST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id B128141034;
        Wed, 23 Sep 2020 01:04:51 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="dnXm7COi";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.160.155])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 14F2B40858;
        Wed, 23 Sep 2020 01:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1600822954; bh=CCPZEQWOsilO9Ws3sgJ39rNzSgwJY9kO6OcGHL39LNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dnXm7COiw2142nhV8mR8ryXG2ZuUo35MwbyUdnJCA1Q27xeWDdH6IWzPZ4AKHzgWH
         XS8UBmZb0xLVjZ6/B3BOqH9nHOfn2W3pVIhCRo0bH9RuaR1/ZijDV0kiyPK3F5Qi1o
         2vGtu+fEzMBmt2OGHoXDMEVjuVIerQP28P+8tak8=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 7/7] ARM: dts: sun8i: s3l: add support for Pine64 PineCube IP camera
Date:   Wed, 23 Sep 2020 09:02:15 +0800
Message-Id: <20200923010215.148819-2-icenowy@aosc.io>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200923010215.148819-1-icenowy@aosc.io>
References: <20200923005709.147966-1-icenowy@aosc.io>
 <20200923010215.148819-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B128141034
X-Spamd-Result: default: False [6.40 / 20.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.160.155:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all:c];
         DMARC_NA(0.00)[aosc.io];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[8];
         MID_CONTAINS_FROM(1.00)[];
         DBL_PROHIBIT(0.00)[0.0.0.0:email,0.0.0.34:email];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Pine64 PineCube IP camera is an IP camera with SoChip S3 SoC.

It comes with a main board, an expansion board and a camera.

The main board features a Micro-USB power-only jack, a USB Type-A port,
an Ethernet port connected to the internal PHY of the SoC and a Realtek
RTL8189ES SDIO Wi-Fi module. A RGB LCD connector is reserved on the
board.

The expansion board features a TF slot, a microphone, a speaker
connector with on-board amplifier and a few IR LEDs.

Add support for the kit, with features on the main board and the
expansion board now.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/Makefile              |   1 +
 arch/arm/boot/dts/sun8i-s3-pinecube.dts | 235 ++++++++++++++++++++++++
 2 files changed, 236 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-s3-pinecube.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e7c59d0c8598..b163c8f1cefc 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1198,6 +1198,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-r16-parrot.dtb \
 	sun8i-r40-bananapi-m2-ultra.dtb \
 	sun8i-s3-lichee-zero-plus.dtb \
+	sun8i-s3-pinecube.dtb \
 	sun8i-t3-cqa3t-bv3.dtb \
 	sun8i-v3s-licheepi-zero.dtb \
 	sun8i-v3s-licheepi-zero-dock.dtb \
diff --git a/arch/arm/boot/dts/sun8i-s3-pinecube.dts b/arch/arm/boot/dts/sun8i-s3-pinecube.dts
new file mode 100644
index 000000000000..9bab6b7f4014
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-s3-pinecube.dts
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR X11)
+/*
+ * Copyright 2019 Icenowy Zheng <icenowy@aosc.io>
+ */
+
+/dts-v1/;
+#include "sun8i-v3.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "PineCube IP Camera";
+	compatible = "pine64,pinecube", "allwinner,sun8i-s3";
+
+	aliases {
+		serial0 = &uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led1 {
+			label = "pine64:ir:led1";
+			gpios = <&pio 1 10 GPIO_ACTIVE_LOW>; /* PB10 */
+		};
+
+		led2 {
+			label = "pine64:ir:led2";
+			gpios = <&pio 1 12 GPIO_ACTIVE_LOW>; /* PB12 */
+		};
+	};
+
+	reg_vcc5v0: vcc5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_vcc_wifi: vcc-wifi {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-wifi";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pio 1 2 GPIO_ACTIVE_LOW>; /* PB2 WIFI-EN */
+		vin-supply = <&reg_dcdc3>;
+		startup-delay-us = <200000>;
+	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&pio 1 3 GPIO_ACTIVE_LOW>; /* PB3 WIFI-RST */
+		post-power-on-delay-ms = <200>;
+	};
+};
+
+&csi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&csi1_8bit_pins>;
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		csi1_ep: endpoint {
+			remote-endpoint = <&ov5640_ep>;
+			bus-width = <8>;
+			hsync-active = <1>; /* Active high */
+			vsync-active = <0>; /* Active low */
+			data-active = <1>;  /* Active high */
+			pclk-sample = <1>;  /* Rising */
+		};
+	};
+};
+
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	axp209: pmic@34 {
+		compatible = "x-powers,axp203",
+			     "x-powers,axp209";
+		reg = <0x34>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pe_pins>;
+	status = "okay";
+
+	ov5640: camera@3c {
+		compatible = "ovti,ov5640";
+		reg = <0x3c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&csi1_mclk_pin>;
+		clocks = <&ccu CLK_CSI1_MCLK>;
+		clock-names = "xclk";
+
+		AVDD-supply = <&reg_ldo3>;
+		DOVDD-supply = <&reg_ldo3>;
+		DVDD-supply = <&reg_ldo4>;
+		reset-gpios = <&pio 4 23 GPIO_ACTIVE_LOW>; /* PE23 */
+		powerdown-gpios = <&pio 4 24 GPIO_ACTIVE_HIGH>; /* PE24 */
+
+		port {
+			ov5640_ep: endpoint {
+				remote-endpoint = <&csi1_ep>;
+				bus-width = <8>;
+				hsync-active = <1>; /* Active high */
+				vsync-active = <0>; /* Active low */
+				data-active = <1>;  /* Active high */
+				pclk-sample = <1>;  /* Rising */
+			};
+		};
+	};
+};
+
+&lradc {
+	vref-supply = <&reg_ldo2>;
+	status = "okay";
+
+	button-200 {
+		label = "Setup";
+		linux,code = <KEY_SETUP>;
+		channel = <0>;
+		voltage = <190000>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_dcdc3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&mmc1 {
+	vmmc-supply = <&reg_vcc_wifi>;
+	vqmmc-supply = <&reg_dcdc3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+};
+
+&pio {
+	vcc-pd-supply = <&reg_dcdc3>;
+	vcc-pe-supply = <&reg_ldo3>;
+};
+
+#include "axp209.dtsi"
+
+&ac_power_supply {
+	status = "okay";
+};
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1250000>;
+	regulator-max-microvolt = <1250000>;
+	regulator-name = "vdd-sys-cpu-ephy";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-3v3";
+};
+
+&reg_ldo1 {
+	regulator-name = "vdd-rtc";
+};
+
+&reg_ldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
+
+&reg_ldo3 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "avdd-dovdd-2v8-csi";
+	regulator-soft-start;
+	regulator-ramp-delay = <1600>;
+};
+
+&reg_ldo4 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "dvdd-1v8-csi";
+};
+
+&spi0 {
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "winbond,w25q128", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+	};
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_vbus-supply = <&reg_vcc5v0>;
+	status = "okay";
+};
-- 
2.27.0

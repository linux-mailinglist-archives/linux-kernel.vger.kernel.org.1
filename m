Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351F22FEB67
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731786AbhAUNRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729434AbhAUKaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:30:03 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9F5C0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:27:27 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id kg20so1374895ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MMnhToLH/oL7+PAHD1u5/+z7FjzPl/2S18N2vJzcyBA=;
        b=i+klUy9WjEUr+17aVZv9DBOyUwn7IqC9ra2z4JJWj6qLigrNZ+kjk8xv6F/OLJV8mO
         NyNDo3kHTgoXb5/qtbGyRUrMxX3n07Noc3myIfBIEJh4Rf4cnyU1sygBt+0a44275del
         vVwAKoBDMHphjxZmMfFYJxfFhCacUN+hCMKhXnzWmYHa0jW/YcCQxSyskmgd9i43e66D
         TT3BI5T2ofaOPagZb0KRaXmXpP/HanLBsnEkQrym5XXoBtPnWk+AzMQX7DdG+f39J9uz
         XBAvB8NPj5j6F5SqwxYaQzFND7dFXjkOuRIr4l4XIw3ari8AeuuUFHp8TU2kGp5kew9D
         uojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MMnhToLH/oL7+PAHD1u5/+z7FjzPl/2S18N2vJzcyBA=;
        b=gIe1qbnMzUeawfnCJn2Y/nk+VpGw9CLRA2x04PMtUhnOpooNovuWMeA24nY+jaRFin
         g7MvV5oWtyCa2lGzZRWiwPWy8SW4ejoXzLPAk+nHihV/485KEfMpuff+okNAFeCoR9OY
         Mdo0MoFltqc6IB2jBjmRGiyZJvTK+lVOpeKIMFmjkXqG6fKqaeEbBKN1cKr4chUdjC0L
         KqJqB0FRlFE6YOcUPF18CyGL+/aqiMgp/2g3tq2F+X4W3WJYf2/XG4F9CLVExEzxyHia
         fd0e80/XRDLmgAnmMwe+AZwCZmBkkXl2q4mx3g1S6kCPGYu4UEKgdtgIPoIpS1fF4Qsf
         cEZA==
X-Gm-Message-State: AOAM531dK6eODIs9mrtyPRm5bZyTW4NpeOR++GqfABfMWVJ8SM/CuMih
        W+oY/oxROZG/zOjnmXnX93+zVN9/jOlJsP+z
X-Google-Smtp-Source: ABdhPJxEK9a59OCZZGcDUX0yer/EG45ono5rDJ/IWsHFAXAQkJmX0wu2su9i9tgiq4WwcfjEONqk9A==
X-Received: by 2002:a17:906:5958:: with SMTP id g24mr8555243ejr.377.1611224846258;
        Thu, 21 Jan 2021 02:27:26 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id q16sm858657ejd.39.2021.01.21.02.27.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 02:27:25 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 12/12] arm64: dts: zynqmp: Add description for zcu104 revC
Date:   Thu, 21 Jan 2021 11:27:00 +0100
Message-Id: <17f68c235ea1ce96c3293ca0cf3178951d6663f7.1611224800.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611224800.git.michal.simek@xilinx.com>
References: <cover.1611224800.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx ZynqMP zcu104 revC and newer board revisions have different i2c
structure compare to revA. The rest of the board is the same from software
perspective.
Also enable DMAs and QSPI.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/Makefile           |   1 +
 .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    | 282 ++++++++++++++++++
 2 files changed, 283 insertions(+)
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts

diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
index 60f5443f3ef4..11fb4fd3ebd4 100644
--- a/arch/arm64/boot/dts/xilinx/Makefile
+++ b/arch/arm64/boot/dts/xilinx/Makefile
@@ -13,5 +13,6 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revB.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-rev1.0.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revC.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu106-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu111-revA.dtb
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
new file mode 100644
index 000000000000..414f98f1831e
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP ZCU104
+ *
+ * (C) Copyright 2017 - 2020, Xilinx, Inc.
+ *
+ * Michal Simek <michal.simek@xilinx.com>
+ */
+
+/dts-v1/;
+
+#include "zynqmp.dtsi"
+#include "zynqmp-clk-ccf.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/phy/phy.h>
+
+/ {
+	model = "ZynqMP ZCU104 RevC";
+	compatible = "xlnx,zynqmp-zcu104-revC", "xlnx,zynqmp-zcu104", "xlnx,zynqmp";
+
+	aliases {
+		ethernet0 = &gem3;
+		i2c0 = &i2c1;
+		mmc0 = &sdhci1;
+		rtc0 = &rtc;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &dcc;
+	};
+
+	chosen {
+		bootargs = "earlycon";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+
+	ina226 {
+		compatible = "iio-hwmon";
+		io-channels = <&u183 0>, <&u183 1>, <&u183 2>, <&u183 3>;
+	};
+
+	clock_8t49n287_5: clk125 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	clock_8t49n287_2: clk26 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+	};
+
+	clock_8t49n287_3: clk27 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <27000000>;
+	};
+};
+
+&can1 {
+	status = "okay";
+};
+
+&dcc {
+	status = "okay";
+};
+
+&fpd_dma_chan1 {
+	status = "okay";
+};
+
+&fpd_dma_chan2 {
+	status = "okay";
+};
+
+&fpd_dma_chan3 {
+	status = "okay";
+};
+
+&fpd_dma_chan4 {
+	status = "okay";
+};
+
+&fpd_dma_chan5 {
+	status = "okay";
+};
+
+&fpd_dma_chan6 {
+	status = "okay";
+};
+
+&fpd_dma_chan7 {
+	status = "okay";
+};
+
+&fpd_dma_chan8 {
+	status = "okay";
+};
+
+&gem3 {
+	status = "okay";
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-id";
+	phy0: ethernet-phy@c {
+		reg = <0xc>;
+		ti,rx-internal-delay = <0x8>;
+		ti,tx-internal-delay = <0xa>;
+		ti,fifo-depth = <0x1>;
+		ti,dp83867-rxctrl-strap-quirk;
+	};
+};
+
+&gpio {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	tca6416_u97: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		/*
+		 * IRQ not connected
+		 * Lines:
+		 * 0 - IRPS5401_ALERT_B
+		 * 1 - HDMI_8T49N241_INT_ALM
+		 * 2 - MAX6643_OT_B
+		 * 3 - MAX6643_FANFAIL_B
+		 * 5 - IIC_MUX_RESET_B
+		 * 6 - GEM3_EXP_RESET_B
+		 * 7 - FMC_LPC_PRSNT_M2C_B
+		 * 4, 10 - 17 - not connected
+		 */
+	};
+
+	/* Another connection to this bus via PL i2c via PCA9306 - u45 */
+	i2c-mux@74 { /* u34 */
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x74>;
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			/*
+			 * IIC_EEPROM 1kB memory which uses 256B blocks
+			 * where every block has different address.
+			 *    0 - 256B address 0x54
+			 * 256B - 512B address 0x55
+			 * 512B - 768B address 0x56
+			 * 768B - 1024B address 0x57
+			 */
+			eeprom: eeprom@54 { /* u23 */
+				compatible = "atmel,24c08";
+				reg = <0x54>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+			};
+		};
+
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			clock_8t49n287: clock-generator@6c { /* 8T49N287 - u182 */
+				reg = <0x6c>;
+			};
+		};
+
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			irps5401_43: irps5401@43 { /* IRPS5401 - u175 */
+				compatible = "infineon,irps5401";
+				reg = <0x43>; /* pmbus / i2c 0x13 */
+			};
+			irps5401_44: irps5401@44 { /* IRPS5401 - u180 */
+				compatible = "infineon,irps5401";
+				reg = <0x44>; /* pmbus / i2c 0x14 */
+			};
+		};
+
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			u183: ina226@40 { /* u183 */
+				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
+				reg = <0x40>;
+				shunt-resistor = <5000>;
+			};
+		};
+
+		i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+
+		/* 4, 6 not connected */
+	};
+};
+
+&qspi {
+	status = "okay";
+	flash@0 {
+		compatible = "m25p80", "jedec,spi-nor"; /* n25q512a 128MiB */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x0>;
+	};
+};
+
+&rtc {
+	status = "okay";
+};
+
+&psgtr {
+	status = "okay";
+	/* nc, sata, usb3, dp */
+	clocks = <&clock_8t49n287_5>, <&clock_8t49n287_2>, <&clock_8t49n287_3>;
+	clock-names = "ref1", "ref2", "ref3";
+};
+
+&sata {
+	status = "okay";
+	/* SATA OOB timing settings */
+	ceva,p0-cominit-params = /bits/ 8 <0x18 0x40 0x18 0x28>;
+	ceva,p0-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
+	ceva,p0-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
+	ceva,p0-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
+	ceva,p1-cominit-params = /bits/ 8 <0x18 0x40 0x18 0x28>;
+	ceva,p1-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
+	ceva,p1-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
+	ceva,p1-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
+	phy-names = "sata-phy";
+	phys = <&psgtr 3 PHY_TYPE_SATA 1 1>;
+};
+
+/* SD1 with level shifter */
+&sdhci1 {
+	status = "okay";
+	no-1-8-v;
+	xlnx,mio-bank = <1>;
+	disable-wp;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+/* ULPI SMSC USB3320 */
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
+};
+
+&watchdog0 {
+	status = "okay";
+};
-- 
2.30.0


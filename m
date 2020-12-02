Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317FC2CBF16
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 15:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbgLBOIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388940AbgLBOIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:08:00 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19CFC08E861
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 06:06:40 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id d17so4452212ejy.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 06:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ds9qLi+pz1g1OhGvJze7udHxEk/HtgVmujD01NJgnrU=;
        b=aLfhH9W2jYts06BShnEEn+N7F6fofgIzZjBKfVwxTc4PYP2zRIr4ZnVfsaUbnNj63r
         k/UPk2MkPGQ0JlMMUu8th/JAm49uonwS/Eu4MU4iT8XHGqKCn35X1N7kMSsxCGGPH9Q6
         2GSLyh6H0UkhNvkfg0YvwrbhCi4ZWvhKR0dB5aQwq39dLWJl8xDuDX3hL1O+4WpOAebU
         0eFoNAE8IvWMAP1ts4mE4XoOZ6dRSehroS0saWox/CHBqPjiQ+rgPMrEtSigcYBsPBFF
         VFaFZ0Eg4bMFIAM0XLddB0MPLHOjkryNAn8Nnv8PkNueYuolv3GZBE+HIVRTM0JDIwRk
         zsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Ds9qLi+pz1g1OhGvJze7udHxEk/HtgVmujD01NJgnrU=;
        b=dcMJIIKcnA6TtsrziTnlLiTZj1TDojhiccCANSxZeTgw/w9+YQiAeGd8RQcWtDutJS
         0f4paF7qPghrnKrdNrITYvCOErwjrC2eXOFdPeg+BdtW444DYYn4mpvarEZD6VymtU0S
         c/+DuLrgo+ZHOf5e9FqsZep5R/y2+cf0PJxMC2l8+I80OvZQ5gnTHB/+vHSUd86lP6pd
         tGQAaVuZ3mSCYnnl/vlPjy1pUa7LhtxWvwoNyhcgSbcxl+EdJwG9+9WlxDYCc/Xfpxy8
         NI/FBJPzfye6gnOjat2zR2jyYeA2Wk8QaE3Bl0LMUu85f32/B3E+3F0MihMj5RxxGBoa
         7oPA==
X-Gm-Message-State: AOAM531dXXEafx8rnKlOPe8XKVgYUuj7hwOOEMoNeZdl36lRNckacS3x
        4PCWRI61Z/T8ncPg7vSz9LG7YfcHJnDCyPkU
X-Google-Smtp-Source: ABdhPJxBU/ZdslDgPwAEg/jquaCrf5GGzSjUQCC95mijGM8ohQ87PLq2XzazpKCv/gZ/2O1tnm61sQ==
X-Received: by 2002:a17:907:d8b:: with SMTP id go11mr2440282ejc.247.1606917999037;
        Wed, 02 Dec 2020 06:06:39 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id d14sm22091edn.31.2020.12.02.06.06.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Dec 2020 06:06:38 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 12/12] arm64: dts: zynqmp: Add description for zcu104 revC
Date:   Wed,  2 Dec 2020 15:06:11 +0100
Message-Id: <5b670099adb67b06ec0a7d1b04ed9f4076e520c1.1606917949.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606917949.git.michal.simek@xilinx.com>
References: <cover.1606917949.git.michal.simek@xilinx.com>
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
2.29.2


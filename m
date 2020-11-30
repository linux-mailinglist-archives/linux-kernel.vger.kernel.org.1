Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFBE2C7D08
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 03:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgK3Cy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 21:54:58 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:39127 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgK3Cy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 21:54:57 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2263A891AD;
        Mon, 30 Nov 2020 15:54:14 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1606704854;
        bh=5duDv7eykB7bit0CVC0NGZgjQxvStw5WM/ThXhoo6K4=;
        h=From:To:Cc:Subject:Date;
        b=HaKZIMNIyNAaXnawp+65wJF3kp9rqjC8EqbOs6Oy4n1Cr/r3a6daxWtzoel9o8cvW
         RWlsEEnSMpiVp4AHbYvm2e/1bHa6KpORnSQxDBFBaemVYMo6pA752qT/ccanFwjOxu
         iO1I7wYJB8+zFcUS5dGkM60zI5Yq0oOxXsukSaPZAfDxZj6Xo2Te/04Jtd6Gu6NXOs
         zm82genF2m3OU1keeeYzECgv60h8/cXxVbY9R0fqX1seM8evEX0b3s8so0As6Lk+9Z
         Ul0HSmDsuXyVnYV36JzVq7FWth5MtIW8z9M9a8IVsL74Dczt0qxT4i1jsTT1F3v1sk
         a0g276LTwmz/g==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5fc45ed60000>; Mon, 30 Nov 2020 15:54:14 +1300
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.21.30])
        by smtp (Postfix) with ESMTP id 1B3B113EE9C;
        Mon, 30 Nov 2020 15:54:13 +1300 (NZDT)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
        id D86EF14C2F82; Mon, 30 Nov 2020 15:54:13 +1300 (NZDT)
From:   Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To:     jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
        Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Subject: [PATCH] ARM: dts: mvebu: Add device tree for ATL-x530 Board
Date:   Mon, 30 Nov 2020 15:54:10 +1300
Message-Id: <20201130025410.6669-1-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree file for x530 board. This has an Armada 385 SoC. Has
NAND-flash for user storage and SPI for booting. Covers majority of x530
and GS980MX variants.

Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-385-atl-x530.dts | 235 ++++++++++++++++++++++
 1 file changed, 235 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-385-atl-x530.dts

diff --git a/arch/arm/boot/dts/armada-385-atl-x530.dts b/arch/arm/boot/dt=
s/armada-385-atl-x530.dts
new file mode 100644
index 000000000000..2041bf09c578
--- /dev/null
+++ b/arch/arm/boot/dts/armada-385-atl-x530.dts
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Device Tree file for Armada 385 Allied Telesis x530/GS980MX Board.
+ (x530/AT-GS980MX)
+ *
+ Copyright (C) 2020 Allied Telesis Labs
+ */
+
+/dts-v1/;
+#include "armada-385.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model =3D "x530/AT-GS980MX";
+	compatible =3D "alliedtelesis,gs980mx", "alliedtelesis,x530", "marvell,=
armada385", "marvell,armada380";
+
+	chosen {
+		stdout-path =3D "serial1:115200n8";
+	};
+
+	memory {
+		device_type =3D "memory";
+		reg =3D <0x00000000 0x40000000>; /* 1GB */
+	};
+
+	soc {
+		ranges =3D <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
+			  MBUS_ID(0x01, 0x3d) 0 0xf4800000 0x80000
+			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
+
+		internal-regs {
+			i2c0: i2c@11000 {
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&i2c0_pins>;
+				status =3D "okay";
+			};
+
+			uart0: serial@12000 {
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&uart0_pins>;
+				status =3D "okay";
+			};
+		};
+	};
+};
+
+&pciec {
+	status =3D "okay";
+};
+
+&pcie1 {
+	status =3D "okay";
+	reset-gpios =3D <&gpio1 23 GPIO_ACTIVE_LOW>;
+	reset-delay-us =3D <400000>;
+};
+
+&pcie2 {
+	status =3D "okay";
+};
+
+&devbus_cs1 {
+	compatible =3D "marvell,mvebu-devbus";
+	status =3D "okay";
+
+	devbus,bus-width    =3D <8>;
+	devbus,turn-off-ps  =3D <60000>;
+	devbus,badr-skew-ps =3D <0>;
+	devbus,acc-first-ps =3D <124000>;
+	devbus,acc-next-ps  =3D <248000>;
+	devbus,rd-setup-ps  =3D <0>;
+	devbus,rd-hold-ps   =3D <0>;
+
+	/* Write parameters */
+	devbus,sync-enable =3D <0>;
+	devbus,wr-high-ps  =3D <60000>;
+	devbus,wr-low-ps   =3D <60000>;
+	devbus,ale-wr-ps   =3D <60000>;
+
+	nvs@0 {
+		status =3D "okay";
+
+		compatible =3D "mtd-ram";
+		reg =3D <0 0x00080000>;
+		bank-width =3D <1>;
+		label =3D "nvs";
+	};
+};
+
+&pinctrl {
+	i2c0_gpio_pins: i2c-gpio-pins-0 {
+		marvell,pins =3D "mpp2", "mpp3";
+		marvell,function =3D "gpio";
+	};
+};
+
+&i2c0 {
+	clock-frequency =3D <100000>;
+	status =3D "okay";
+
+	pinctrl-names =3D "default", "gpio";
+	pinctrl-0 =3D <&i2c0_pins>;
+	pinctrl-1 =3D <&i2c0_gpio_pins>;
+	scl-gpio =3D <&gpio0 2 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+	sda-gpio =3D <&gpio0 3 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+
+	i2c0mux: mux@71 {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		compatible =3D "nxp,pca9544";
+		reg =3D <0x71>;
+		i2c-mux-idle-disconnect;
+
+		i2c@0 { /* POE devices MUX */
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0>;
+		};
+
+		i2c@1 {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <1>;
+
+			adt7476_2e: hwmon@2e {
+				compatible =3D "adi,adt7476";
+				reg =3D <0x2e>;
+			};
+
+			adt7476_2d: hwmon@2d {
+				compatible =3D "adi,adt7476";
+				reg =3D <0x2d>;
+			};
+		};
+
+		i2c@2 {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <2>;
+
+			rtc@68 {
+				compatible =3D "dallas,ds1340";
+				reg =3D <0x68>;
+			};
+		};
+
+		i2c@3 {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <3>;
+
+			gpio@20 {
+				compatible =3D "nxp,pca9554";
+				gpio-controller;
+				#gpio-cells =3D <2>;
+				reg =3D <0x20>;
+			};
+		};
+	};
+};
+
+&usb0 {
+	status =3D "okay";
+};
+
+&spi1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&spi1_pins>;
+	status =3D "okay";
+
+	spi-flash@0 {
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		compatible =3D "jedec,spi-nor";
+		reg =3D <1>; /* Chip select 1 */
+		spi-max-frequency =3D <54000000>;
+
+		partitions {
+			compatible =3D "fixed-partitions";
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			partition@u-boot {
+				reg =3D <0x00000000 0x00100000>;
+				label =3D "u-boot";
+			};
+			partition@u-boot-env {
+				reg =3D <0x00100000 0x00040000>;
+				label =3D "u-boot-env";
+			};
+			partition@unused {
+				reg =3D <0x00140000 0x00e80000>;
+				label =3D "unused";
+			};
+			partition@idprom {
+				reg =3D <0x00fc0000 0x00040000>;
+				label =3D "idprom";
+			};
+		};
+	};
+};
+
+&nand_controller {
+	status =3D "okay";
+
+	nand@0 {
+		reg =3D <0>;
+		label =3D "pxa3xx_nand-0";
+		nand-rb =3D <0>;
+		nand-on-flash-bbt;
+		nand-ecc-strength =3D <4>;
+		nand-ecc-step-size =3D <512>;
+
+		marvell,nand-enable-arbiter;
+
+		partitions {
+			compatible =3D "fixed-partitions";
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			partition@user {
+				reg =3D <0x00000000 0x0f000000>;
+				label =3D "user";
+			};
+			partition@errlog {
+				/* Maximum mtdoops size is 8MB, so set to that. */
+				reg =3D <0x0f000000 0x00800000>;
+				label =3D "errlog";
+			};
+			partition@nand-bbt {
+				reg =3D <0x0f800000 0x00800000>;
+				label =3D "nand-bbt";
+			};
+		};
+	};
+};
+
--=20
2.29.2


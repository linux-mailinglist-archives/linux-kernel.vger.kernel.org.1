Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9803F2C4E13
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 05:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387669AbgKZEp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 23:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387571AbgKZEpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 23:45:55 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D4DC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 20:45:55 -0800 (PST)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 8A594806A8;
        Thu, 26 Nov 2020 17:45:49 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1606365949;
        bh=fpmZlWWGYYvSibpY0vtVoSbzv6E2nviLb/qUCvY6RIE=;
        h=From:To:Cc:Subject:Date;
        b=FXpZIIiD3YTopcPuSzOIl8YS4Ol4mwWSe9xQqWjPGARH+uWXgSUbOHTzZW/DP3PXO
         vOGPWXg56oJaPRe3oS2QVqA539sQOL8DS4WQBZKsTz5QVpmAR3CRxHwJ5y08E40/CR
         l9ugtbbGbK0WxR5oBNL5OgaKzADYMAPKQG1gqgQI04KXjB8w+hL834UaF6TwofrqEQ
         VS3oxtvEZyxYcdaBegsM8x1SUK4Xz8B4Ql0TZ4w1++guveCRvPvrHnGP3cmdMUZ5Nk
         d/p53r0ToJTuRyZpExfFDgo7ZjDtPAqh5LqzCxtCr4P6MEGj/2Y5ofk9XllVnmesZC
         xbpFWcJ/FK+0Q==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5fbf32fd0000>; Thu, 26 Nov 2020 17:45:49 +1300
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.21.30])
        by smtp (Postfix) with ESMTP id E1E1113EE9C;
        Thu, 26 Nov 2020 17:45:48 +1300 (NZDT)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
        id 38BB014C00BB; Thu, 26 Nov 2020 17:45:49 +1300 (NZDT)
From:   Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2] ARM: dts: mvebu: Add device tree for RD-AC3X-48G4X2XL board
Date:   Thu, 26 Nov 2020 17:45:44 +1300
Message-Id: <20201126044544.17829-1-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree for RD-AC3X-48G4X2XL board. This has a Armada 382 SoC on
a interposer board connected to a baseboard with a Prestera AC3X ASIC
connected via PCI.

Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    -Added comment for CPLD

 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/armada-382-rd-ac3x-48g4x2xl.dts  | 112 ++++++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-382-rd-ac3x-48g4x2xl.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ce66ffd5a1bb..a60407ad7347 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1319,6 +1319,7 @@ dtb-$(CONFIG_MACH_ARMADA_370) +=3D \
 dtb-$(CONFIG_MACH_ARMADA_375) +=3D \
 	armada-375-db.dtb
 dtb-$(CONFIG_MACH_ARMADA_38X) +=3D \
+	armada-382-rd-ac3x-48g4x2xl.dtb \
 	armada-385-clearfog-gtr-s4.dtb \
 	armada-385-clearfog-gtr-l8.dtb \
 	armada-385-db-88f6820-amc.dtb \
diff --git a/arch/arm/boot/dts/armada-382-rd-ac3x-48g4x2xl.dts b/arch/arm=
/boot/dts/armada-382-rd-ac3x-48g4x2xl.dts
new file mode 100644
index 000000000000..584f0d0398a5
--- /dev/null
+++ b/arch/arm/boot/dts/armada-382-rd-ac3x-48g4x2xl.dts
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Device Tree file for Marvell Armada 382 reference board
+ * (RD-AC3X-48G4X2XL)
+ *
+ * Copyright (C) 2020 Allied Telesis Labs
+ */
+
+/dts-v1/;
+#include "armada-385.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model =3D "Marvell Armada 382 RD-AC3X";
+	compatible =3D "marvell,rd-ac3x-48g4x2xl", "marvell,rd-ac3x",
+			 "marvell,armada385", "marvell,armada380";
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+
+	aliases {
+		ethernet0 =3D &eth1;
+	};
+
+	memory {
+		device_type =3D "memory";
+		reg =3D <0x00000000 0x20000000>; /* 512MB */
+	};
+
+	soc {
+		ranges =3D <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
+			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
+	};
+};
+
+&i2c0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&i2c0_pins>;
+	status =3D "okay";
+
+	eeprom@53{
+		compatible =3D "atmel,24c64";
+		reg =3D <0x53>;
+	};
+
+	/* CPLD device present at 0x3c. Function unknown */
+};
+
+&uart0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&uart0_pins>;
+	status =3D "okay";
+};
+
+&eth1 {
+	status =3D "okay";
+	phy =3D <&phy0>;
+	phy-mode =3D "rgmii-id";
+};
+
+&mdio {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&mdio_pins>;
+
+	phy0: ethernet-phy@0 {
+		reg =3D <0>;
+	};
+};
+
+&pciec {
+	status =3D "okay";
+};
+
+&pcie1 {
+	/* Port 0, Lane 0 */
+	status =3D "okay";
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
+
+		partitions {
+			compatible =3D "fixed-partitions";
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			partition@0 {
+				reg =3D <0x00000000 0x00500000>;
+				label =3D "u-boot";
+			};
+			partition@500000{
+				reg =3D <0x00500000 0x00400000>;
+				label =3D "u-boot env";
+			};
+			partition@900000{
+				reg =3D <0x00900000 0x3F700000>;
+				label =3D "user";
+			};
+		};
+	};
+};
+
+&refclk {
+	clock-frequency =3D <200000000>;
+};
--=20
2.29.2


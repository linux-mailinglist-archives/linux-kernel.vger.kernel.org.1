Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5F127C1DA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgI2KCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:02:53 -0400
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:49659
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727892AbgI2KCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:02:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D40ML4NidF+uEgHksnQGCIw9V7IzpGGXZC1eUIcK39LRgp3Nx1L2i0s/CtKbOjW656w2wICtxouiP05Ot4Zcv/tMNH6LBzGnBIWkWQRELGv/y94ofMqlS6lE9+XBFH1UdApRDKGc55rnHOyklHkTcWQ7cI8ZOe6lLmvxggnf+fQDhaPCY3w/mypmHHeuJKeBqblCl2mM5uQkTQ3bMwgpProKU4Sira3Y7W0dZFIBkTQdMm750I/rV3Tr1+GEoTzWkQmmIJGGffRMp08OerK5ZUSDDIPla53rJ44mfou8sGwpE2abhEnfeY+0IDqgwuHlQj+ZVBXczqwj2PkfwBER3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiupPyU0eYIY9VG1HkODQf2t8UYDtIMpo4wU7o9ErwQ=;
 b=EbKdZb9FpExtxupKFL73/zw7b1/ZWp3baAw9Ex6zUDVKsEzk6Mn0zBQR16s4TbqAtkxDC57A6khW3R0dtNGY4L4aeUewn14U+MU2NGGl0rIz7LahemWh9CsilHjpqnoDOdDukjjHf9iBbaV2n8naHStgxDK9G9seYnU+BPNh0EhpgfM+7xnjGyUAfH2Fc5/VZJahiCZFWADPPzST86UivIyz1uHXyxejsJbDNXUo+ZkboQPUZ6HU8cbXXvXaGfm+AsnbLPLXjizkNWuP+inFPs6H80HJ8hSiiVM073N4AGT4LUxBMha/CbVfifIECgrfCS/mX/tEXcCCOhlDgOuseA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiupPyU0eYIY9VG1HkODQf2t8UYDtIMpo4wU7o9ErwQ=;
 b=Fsef0MnQzZj4tFO20sm9wxeSGQDteg9OIuubBvz1LMLLahGreYvARGuuHZjHpBFutSVvL+K/h2AftwBBPRbqEm7YilIrswhRiVj5cBFSrXDk9lPqCuJ0w+ABObj7ugthgiMjImq57xX0zLSM9rQgG9DTmmL9H7u57WgvdadFKpw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AM7PR04MB6968.eurprd04.prod.outlook.com (2603:10a6:20b:dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 10:02:46 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::f431:1df6:f18b:ad99]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::f431:1df6:f18b:ad99%6]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 10:02:46 +0000
From:   meenakshi.aggarwal@nxp.com
To:     shawnguo@kernel.org, robh+dt@kernel.org, V.sethi@nxp.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH v3 2/2] arm64: dts: lx2160a: add device tree for lx2162aqds board
Date:   Tue, 29 Sep 2020 15:31:58 +0530
Message-Id: <1601373718-13218-3-git-send-email-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601373718-13218-1-git-send-email-meenakshi.aggarwal@nxp.com>
References: <1599059610-7570-2-git-send-email-meenakshi.aggarwal@nxp.com>
 <1601373718-13218-1-git-send-email-meenakshi.aggarwal@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To AM7PR04MB6885.eurprd04.prod.outlook.com
 (2603:10a6:20b:10d::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03032.swis.in-blr01.nxp.com (14.142.151.118) by SG2PR02CA0005.apcprd02.prod.outlook.com (2603:1096:3:17::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3433.32 via Frontend Transport; Tue, 29 Sep 2020 10:02:43 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [14.142.151.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd6b9033-a2d4-41db-6b0d-08d8645ed08a
X-MS-TrafficTypeDiagnostic: AM7PR04MB6968:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB6968E35437918F0DE21A703E8E320@AM7PR04MB6968.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QB561MzpH4M2tqdv24CaS4AnL7S4H/+8TMoYI5+iT3yAACI3ZB0DL5R3irffB2Oxqg5pxgMtOdMtqcwQqu1BqX375AfI7Q3ghuJh6nTGuuFd+gN0TLuNwhx/azGNRid1/XGJp2dd6KjmAOUFoBgq1jzLgJVigxdP07OpEdKxl0KjlJMZv3LyFWiAY/k2I7GdkVSkTyVpvBZzmQwNwRmL/LQAd1q15lTYDEI6berTjiPfiGQZjEj6F7c4yzGXaNSUWgrFFC6zNM4GHuCVgicLAINvU5QX0rNqjhgpxKURbP2Ozh85ZyojXeN0XN/B7S3o13p4uJ1er/w8a/4yzeTxtZvqxd+m5hxcddv3gsmPpvwdira3l7qQEkeWJKvQK9eOTqw0ekSY+Hyv6ylqAbyJ3x6oWs564AOQcllDPgT3Rq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(5660300002)(66556008)(66476007)(36756003)(66946007)(316002)(9686003)(2616005)(1006002)(4326008)(6486002)(26005)(52116002)(7696005)(956004)(86362001)(54906003)(6666004)(2906002)(186003)(8936002)(478600001)(16526019)(8676002)(55236004)(110426005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gBO7V2QZGr7xe/KBDykXo+6l3hJFd3HBNU01PU6b4mgm1nYfYWpqiIN7WLpm56hKtDCRPUBWymV7UCID93ZxHcufFWHWYU3hMY8ql6pm1wDzmYI2vkUDq4ujcvMlOuZt6SEHvHPluxPmuwTRdX5kwSlZLPLfaUB+Kr5fQw3ujsASl+BAOwlTGq06iIQBjZEu4MHw+9F+dYFYxARAiOj3t7PmPNhF8FlatrH8hOHIPsviIlr7wxTYtVEvI0gOrGzipKGOBav3QbihUWgMHpncXJLV5MZ9TTm0v+rbL6cmIBFoou6eU0ba6s7dLMu8KTZm2Ft4KEVX+do1Ta6ed6JK+KX+/UMExPkG3SZYZldtWKBf0at+Xl/MmO7QjRB6j2FHTBFndjS8/4lUDyh2CsfB2u3mmvHOYIr2S/O1uFEG4T30PoBtQbAT1NE4DLRKTGSJAv937tY+l+QyDpSnknBPUQROSvs6gZnVZ7QoMKl59gTLVBhaekcVSQEGekJOoXFw3vMTu4WNkwpJsdZLU1vG8G/eGB2lQ+KUw1yckljnv9f4ZfumYiCdAL5oscFB+X0G06zXpWnl/JQUr47S4/M2rsihoSzkHP4ejvj43OxMAJvQasMmAxfvr2FZnnqpE2TLbEPGWmUlilMEQiIxgcq8rg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6b9033-a2d4-41db-6b0d-08d8645ed08a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 10:02:46.3153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4asMbxHlhSgPe8A4sECXLeyq5WmGhbxJaQtkCt3gID4dhHJOsbDnNBTp+g5YPQCSzCaKTs4Q2EQ5GHJiOFgCWWcyuuHD2yTCqfZpm+STd6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6968
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

Add device tree support for LX2162AQDS board.
LX2162A has same die as of LX2160A with different packaging.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts | 334 ++++++++++++++++++++++
 2 files changed, 335 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 903c0eb..0edc8ab 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -27,6 +27,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-clearfog-cx.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-honeycomb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
new file mode 100644
index 0000000..b29174e
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Device Tree file for LX2162AQDS
+//
+// Copyright 2020 NXP
+
+/dts-v1/;
+
+#include "fsl-lx2160a.dtsi"
+
+/ {
+	model = "NXP Layerscape LX2162AQDS";
+	compatible = "nxp,lx2162a-qds", "fsl,lx2160a";
+
+	aliases {
+		crypto = &crypto;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	sb_3v3: regulator-sb3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "LTM4619-3.3VSB";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	mdio-mux-1 {
+		compatible = "mdio-mux-multiplexer";
+		mux-controls = <&mux 0>;
+		mdio-parent-bus = <&emdio1>;
+		#address-cells=<1>;
+		#size-cells = <0>;
+
+		mdio@0 { /* On-board RTL8211F PHY #1 RGMII1 */
+			reg = <0x00>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			rgmii_phy1: ethernet-phy@1 {
+				compatible = "ethernet-phy-id001c.c916";
+				reg = <0x1>;
+				eee-broken-1000t;
+			};
+		};
+
+		mdio@8 { /* On-board RTL8211F PHY #2 RGMII2 */
+			reg = <0x8>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			rgmii_phy2: ethernet-phy@2 {
+				compatible = "ethernet-phy-id001c.c916";
+				reg = <0x2>;
+				eee-broken-1000t;
+			};
+		};
+
+		mdio@18 { /* Slot #1 */
+			reg = <0x18>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@19 { /* Slot #2 */
+			reg = <0x19>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@1a { /* Slot #3 */
+			reg = <0x1a>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@1b { /* Slot #4 */
+			reg = <0x1b>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@1c { /* Slot #5 */
+			reg = <0x1c>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@1d { /* Slot #6 */
+			reg = <0x1d>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@1e { /* Slot #7 */
+			reg = <0x1e>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@1f { /* Slot #8 */
+			reg = <0x1f>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	mdio-mux-2 {
+		compatible = "mdio-mux-multiplexer";
+		mux-controls = <&mux 1>;
+		mdio-parent-bus = <&emdio2>;
+		#address-cells=<1>;
+		#size-cells = <0>;
+
+		mdio@0 { /* Slot #1 (secondary EMI) */
+			reg = <0x00>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@1 { /* Slot #2 (secondary EMI) */
+			reg = <0x01>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@2 { /* Slot #3 (secondary EMI) */
+			reg = <0x02>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@3 { /* Slot #4 (secondary EMI) */
+			reg = <0x03>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@4 { /* Slot #5 (secondary EMI) */
+			reg = <0x04>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@5 { /* Slot #6 (secondary EMI) */
+			reg = <0x05>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@6 { /* Slot #7 (secondary EMI) */
+			reg = <0x06>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@7 { /* Slot #8 (secondary EMI) */
+			reg = <0x07>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&crypto {
+	status = "okay";
+};
+
+&dpmac17 {
+	phy-handle = <&rgmii_phy1>;
+	phy-connection-type = "rgmii-id";
+};
+
+&dpmac18 {
+	phy-handle = <&rgmii_phy2>;
+	phy-connection-type = "rgmii-id";
+};
+
+&dspi0 {
+	status = "okay";
+
+	dflash0: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+	};
+};
+
+&dspi1 {
+	status = "okay";
+
+	dflash1: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+	};
+};
+
+&dspi2 {
+	status = "okay";
+
+	dflash2: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+	};
+};
+
+&emdio1 {
+	status = "okay";
+};
+
+&emdio2 {
+	status = "okay";
+};
+
+&esdhc0 {
+	status = "okay";
+};
+
+&esdhc1 {
+	status = "okay";
+};
+
+&fspi {
+	status = "okay";
+
+	mt35xu512aba0: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		m25p,fast-read;
+		spi-max-frequency = <50000000>;
+		reg = <0>;
+		spi-rx-bus-width = <8>;
+		spi-tx-bus-width = <8>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+
+	fpga@66 {
+		compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c",
+			     "simple-mfd";
+		reg = <0x66>;
+
+		mux: mux-controller {
+			compatible = "reg-mux";
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x54 0xf8>, /* 0: reg 0x54, bits 7:3 */
+					<0x54 0x07>; /* 1: reg 0x54, bit 2:0 */
+		};
+	};
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9547";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2>;
+
+			power-monitor@40 {
+				compatible = "ti,ina220";
+				reg = <0x40>;
+				shunt-resistor = <500>;
+			};
+
+			power-monitor@41 {
+				compatible = "ti,ina220";
+				reg = <0x41>;
+				shunt-resistor = <1000>;
+			};
+		};
+
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x3>;
+
+			temperature-sensor@4c {
+				compatible = "nxp,sa56004";
+				reg = <0x4c>;
+				vcc-supply = <&sb_3v3>;
+			};
+
+			rtc@51 {
+				compatible = "nxp,pcf2129";
+				reg = <0x51>;
+			};
+		};
+	};
+};
+
+&sata0 {
+	status = "okay";
+};
+
+&sata1 {
+	status = "okay";
+};
+
+&sata2 {
+	status = "okay";
+};
+
+&sata3 {
+	status = "okay";
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
+&usb0 {
+	status = "okay";
+};
-- 
2.7.4


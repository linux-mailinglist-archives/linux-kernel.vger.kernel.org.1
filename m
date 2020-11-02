Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED602A2490
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 07:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgKBGAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 01:00:11 -0500
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:51822
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727767AbgKBGAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 01:00:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6jsuiWDH5XCflYUz42yAdup9QpTkxXXGZYBoBqSXGr8FNNubLkUvw8u7xqCQUGL8RUBS9DkDq/DwULzU2+JX5K430PhoFvwlpBFOzfSx5S1c36K8BPju+H3jPnmi0Kt4VR81V1TB44/GmAbnp7dZnLFbvuMXol7bp76Xt0k4Xbraon6jwpYOEsAqDoBuCqo1eoQn/agwKZzCbXRMLS89yja0JraASlXIT1dKwVb1bT5jk85SD4NWxepm5aokB7sV23r01Ru4xOkJKOIwPY6iZEAR9JwY4an00P3DkAbH+EesAseJ7ZTjhe87v5S3ndj69e9lQBE5MmxA29/FVi17w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VV45zGjoZkM6oR7b/hy3YWYGtEmT6DnTerBtycqOJ3o=;
 b=Y5RZOT+opFVffmJzPWLQQQsnqWgO5jztpETmLlKWltpgx9i3CHptgB+Dj9yg1mNuzZAx8d5dutP4WcsiS33cO7GMYy9lXaSihHeW4u1SL3hXpJOE8CSsFzV64aL6m6CIWlY+Q6gkaQFxUIHJ5Or0eyR27f5REviOXcDep+qBM0H5qYZCctIwmV1EmMghGx+bUNyU70aPT1OsGMfqesdwzfD7/La2bJJTWRSi7cJozsNYmq1dxiyoC2gs2ynPjNDSanWVpP01KA/M6BGAsKrCNIbtkh+BX6oDzhNK+qjjdRM9FvqCpntfmgpIBoDS4B33hDQ8ju8wlYRL2FOwPC4oPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VV45zGjoZkM6oR7b/hy3YWYGtEmT6DnTerBtycqOJ3o=;
 b=AoC+Q7eSLBL5bPFFxb5FABRD7GZEV2TEqq9DcbL506QTiSxMyspQv+eHQSGdH5/cL8AzO1b6zyoVJwY/snwiVTJxuD5y4YiZo4v7kqYmveObON3zfn4NDFk1jahXO0a4fFY4HkFWWmw4CrBnpA5dVTqaSbZ1+jUzLQGO52LknZ0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB6893.eurprd04.prod.outlook.com (2603:10a6:803:133::7)
 by VE1PR04MB7439.eurprd04.prod.outlook.com (2603:10a6:800:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Mon, 2 Nov
 2020 06:00:05 +0000
Received: from VI1PR04MB6893.eurprd04.prod.outlook.com
 ([fe80::48ec:3370:b98c:ad13]) by VI1PR04MB6893.eurprd04.prod.outlook.com
 ([fe80::48ec:3370:b98c:ad13%2]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 06:00:05 +0000
From:   meenakshi.aggarwal@nxp.com
To:     shawnguo@kernel.org, robh+dt@kernel.org, V.sethi@nxp.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH v4 2/2] arm64: dts: lx2160a: add device tree for lx2162aqds board
Date:   Mon,  2 Nov 2020 11:29:41 +0530
Message-Id: <1604296781-28295-3-git-send-email-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604296781-28295-1-git-send-email-meenakshi.aggarwal@nxp.com>
References: <1601373718-13218-3-git-send-email-meenakshi.aggarwal@nxp.com>
 <1604296781-28295-1-git-send-email-meenakshi.aggarwal@nxp.com>
Content-Type: text/plain
X-Originating-IP: [14.142.151.118]
X-ClientProxiedBy: SG2PR02CA0067.apcprd02.prod.outlook.com
 (2603:1096:4:54::31) To VI1PR04MB6893.eurprd04.prod.outlook.com
 (2603:10a6:803:133::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03032.swis.in-blr01.nxp.com (14.142.151.118) by SG2PR02CA0067.apcprd02.prod.outlook.com (2603:1096:4:54::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3499.18 via Frontend Transport; Mon, 2 Nov 2020 06:00:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0dbd2108-5740-470f-8136-08d87ef48b5b
X-MS-TrafficTypeDiagnostic: VE1PR04MB7439:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB74390D77157355566C29CFA88E100@VE1PR04MB7439.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nx5xSQsNRCzcjdASyl+ZDOsEh6tCz3aEg9TNR5X3o8TABP541PpZ7UNcfLm/tJ2HeBiKRP5e3YmzAVrhcWYtzjjb5F5jl81Gu/XegpJTe0/zVzvpf3kcbRTfjhmL1e3guAvGQXHeGTjUeTcGtzuOT7FSKgNStuFsmA79E9n1LioNiK+28aoKqvPkgp0DNoDo6dQWdTKXBEflW52RHADCCiZ/5sqz6Atggoc0h8xeBLLi7w2GmNAeTnCwIcaemvPmyto574mol2HCFG/zVBvMUFqyr1b3/r2eaoQaRn6RVZblui57je3QFoBzM7Tbf8Ymcx0qCqr340AdlgiRDzKvrtS4+/PNQ/Mn62QRqi3CWnovcGtwPYZWYLJJj2mrg62x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6893.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(5660300002)(54906003)(66556008)(8936002)(6486002)(8676002)(9686003)(316002)(66476007)(1006002)(6666004)(66946007)(7696005)(86362001)(52116002)(4326008)(55236004)(16526019)(2616005)(36756003)(956004)(26005)(478600001)(186003)(2906002)(110426005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Hz2hLlOI98zXFYdNFTxS8nRsZ4l+co9YiJBdW47pWgUCGmcRjkmCWMVm+f1pRXnsxL4p+P0q9KH4WIp0R3s9UyDCXyZ7XDHu5ZzhdHMWOTziE6BAKRMp6257zgiLo0UEzOei9fEf0ssm8Nkc9dMkK/3J1NH07FgYR6jV37GgnV3sAXMWQld2zlU1OdaWhr38kn2vBSY1Tv+HUFVdogoxP5niIPVjyK0+jXBHxBsDaNlpVreHuojtjtaRFUA1NlaJaD7QU300sWiGT4frUJfCLpFy0aZUI4GzqBoToGmpeTxDh0XbOIGos1JMAbLp69fYFpRRUDA9xiXM0P+o/k/4E+Tb6stUNgiJSWN2AhjtcRH90JRUJ8MOc3JXlgcb25yogJn+D8otJUgU/h0tKGwx6zqFo2hdODUWVm9pXBKUuxM0z2vcO8eCQYuq5fk+DSQrgrbTEGDXccBo6Cft2DZM43UAl/1JQhJ6uKHNrPd5B1IS+HwaH0OAcNutvW4ykmR6SnVZ4pxoDN5YNIcnTnctAJgxjhWglPtapftPvo8NP+aJv+LnHWhHOhzgJ4/Jl8pQ66H1iEtRtC2WgNQxBJqM1sRCGkiXyozz+YMMO3L/A2lJgUshP73qHDH/sWhrt397Iy28oggZdDBIeLREEx7i6w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbd2108-5740-470f-8136-08d87ef48b5b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6893.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 06:00:05.2356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3a/tPBnydZJpYsdUw3Vziclmbq1wla/xxLpAJNkvFd3xq668Hg34/sowtETjtMHXTTjj4z+745PcjgVYRkWGLGPiCgQcY9ZvZ8LnmugmKZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7439
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
index 0000000..9178684
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
+	compatible = "fsl,lx2162a-qds", "fsl,lx2160a";
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


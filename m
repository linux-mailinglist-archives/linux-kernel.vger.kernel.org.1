Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C25C27FF46
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 14:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbgJAMfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 08:35:33 -0400
Received: from mail-eopbgr40106.outbound.protection.outlook.com ([40.107.4.106]:36099
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732026AbgJAMfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:35:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1XjsLIpV16+CtU63cZeezT5G7j/ASlH0GEXmdTQOVpQKm8i3nLyBFsjTK6/lTQLs7HCXOT7hoX/eaNskLYirbJxHqZzQjLAjcdUS0+wr93LWOkdT145ftHJ5RGLSI7BK3Y8NDZn4cS8oHJZnH6jkgCNlNAlhkKiwVxudHvcid2lyWx/a1j65vl8DdrO2eXr0FecPz7+201PpClEg0AbBSeouKVwPbElsE2jggkzYFnwrOboY+BC+nvUMlhgoAWe6wU8gmxgjT0b5AAkfECvg5OGodgw+ebz/mZdVndrUoE3YBUgvOVfvbROlwKYddsNqirbSrRnjwhknuQKHfDgIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8H0nsuVC5lXYgYk1R4oJ+4SBOUI4YRWtcO5cUaodd0=;
 b=SA1D+i+XZCWXdFNQhtIig30mb51phEVhYfKR0dh7E2VJ7JqSH2A14PccxU/VvdwOAs5kOLPaH952O6pKi2mrQheXxAEtiBh3J93XnyJIT3O30xgJ7OMtN52ynZDIWKJaXhpCMbxXe0HX5cnf+dLzI8mAGo7JcE4dtTkyelQvIqYLtsRsYDlAvp5e3cB037ga48EtyqiSGoqAzZlo48y0FFPIC55qMl6Q3VI57sKZUVK7ULWE/zetylJTVXalJKdNw7OB/JYnOhhX3cn+N7MdsrmJUfGMJmWQNNw4oVaRf5Mnhvb2vqCPRdRQP6138SClolfi6rAJlLKKjweIsJrxLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8H0nsuVC5lXYgYk1R4oJ+4SBOUI4YRWtcO5cUaodd0=;
 b=L6wOUxwmcYIEh6yg48wvllkNPD8XVggd4dc3mCQ9a1QZqica93lJ2P3/PVkeX4J8Ksr33+6v7VF3vqo47DiHrA3OMbPF6PezqsQK7+8gr5oKdYixfHSoA+RkP3ITmyLICwUAB2VUr4eMyeVmn8Sk35YMvsDUNChfCGln9kWVkrk=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB3252.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Thu, 1 Oct
 2020 12:35:27 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5%6]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 12:35:27 +0000
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Robin Gong <yibin.gong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: imx8mm-kontron: Add support for ultra high speed modes on SD card
Date:   Thu,  1 Oct 2020 14:34:32 +0200
Message-Id: <20201001123447.1610-2-frieder.schrempf@kontron.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001123447.1610-1-frieder.schrempf@kontron.de>
References: <20201001123447.1610-1-frieder.schrempf@kontron.de>
Content-Type: text/plain
X-Originating-IP: [89.247.42.197]
X-ClientProxiedBy: AM5P194CA0018.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::28) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fs-work.localdomain (89.247.42.197) by AM5P194CA0018.EURP194.PROD.OUTLOOK.COM (2603:10a6:203:8f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Thu, 1 Oct 2020 12:35:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13949782-2a40-4b66-c58e-08d866067a07
X-MS-TrafficTypeDiagnostic: AM0PR10MB3252:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR10MB3252570ECE32230E305C0F0BE9300@AM0PR10MB3252.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wnjiXUuvVVlsIkV6DDT8aTI9QXUt/DEzQ9qjzwrD4OXCv8vqHVWh2LkfLiGC7VJB3pBYoW3hXYZbNdsxmP4TaDOpu31w1aP03+mSMtfqGnzb/rlFnqtxy7FMa8SXS2DDRxASsn77yzDM7w+gULYW/6WUdKmPZ3LmtwuR90F82qRFdhsQcSzak4Yn5s8bJ4yAfkNs2NN84JtAlPyetPWoiAUmcOen3dSSn8oMRR0eIVtnIUr+KSbawRXHapJyrgz2v0y11VDR+KbYX91IgqsHaQmMIDFZMnG0wqIvtS9FUA9D0/EhqBy1OOwDxt+wfGCwO2B/nTL059GCAjTTynGbwqhktJowTiMuhSyZwfm1U70FBHbuyiTor5xMxYCpo4cX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(66476007)(66556008)(6512007)(8676002)(186003)(110136005)(16526019)(478600001)(52116002)(1076003)(4326008)(86362001)(316002)(2906002)(8936002)(36756003)(956004)(6506007)(2616005)(83380400001)(7416002)(6666004)(5660300002)(6486002)(26005)(66946007)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: vvy74Ctw9dbuCrvvBVCME1qHifK8uYBJZipdDi8Nu7b+FVqiNTAxE+7ICfOn3ManfI0fYAYr2VYvLKlaLXWXI5UoFA9AWTuyoJvsgH83u/dcuBD9ancygyOfE7+eOItxOujWhcH4jJsWh1TAuF1FmW90gBKh67kkwWI+SuQdKQgOHWAEAYIHIrZ1lwkNEmP0NliKDbWivXuBvoFMmHqkX/Kfg6GRgQgUeZDGuSCYF+fF+VeCuY8WhSYYTuHlKKvdhVIFp9XZBLDkdN/VNibBHS2d+pUVhnEZMkGeiUkvpg1wRu5hGnMkH1aeknaRmeOUpbpwarLlA01xG6RUmAYCHF4QPICC1qzsjy2RNsnMJldaTcZGfx3NavdASh9ztixWonrBGsmFnzD/JOHhKb0mh1zuWH78n+aYR9N15zhvX0qGlGKn8V5Gj4cC9jwixlP76tBWinv4yEKykuGE7qhXEfDMXwwoSplDnFnQFxOUe4H9DS6t5YJrW5/+Z34HLVuZrgzHCLHroOC1BvhgACPO0NaTcTgrePlbCB/i0NDl5dKFzGWlLBjepSCGIrKefVKY8SPgomm8OmAiAsBqJthJCX5oKsTZSepGgbAT3/HD1f3TiSz8crZwAD7oAiAfZl/A8Nwz39HACwBOXvZafZuCZQ==
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 13949782-2a40-4b66-c58e-08d866067a07
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 12:35:27.7640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CixBiwKkwhjjdDXwYJIXn0UCfa3dFD3sO1fTskXQh4xdRHsvXVW9Dlq5w/vYPWY6/i/mZ4XOHj+0oPBuDWbDNBdbZElzVOhaM8l+zWCG8W0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

In order to use ultra high speed modes (UHS) on the SD card slot, we
add matching pinctrls and fix the voltage switching for LDO5 of the
PMIC, by providing the SD_VSEL pin as GPIO to the PMIC driver.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 .../dts/freescale/imx8mm-kontron-n801x-s.dts  | 27 +++++++++++++++++++
 .../freescale/imx8mm-kontron-n801x-som.dtsi   |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
index 389e735b2880..6913aefa56aa 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
@@ -190,8 +190,11 @@
 };
 
 &usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
 	vmmc-supply = <&reg_vdd_3v3>;
 	vqmmc-supply = <&reg_nvcc_sd>;
 	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
@@ -320,4 +323,28 @@
 			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
 		>;
 	};
+
+	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x194
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d4
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d4
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x196
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d6
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d6
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
+		>;
+	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
index 5c6a660f4395..282a56fb3949 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
@@ -85,6 +85,7 @@
 		pinctrl-0 = <&pinctrl_pmic>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <0 GPIO_ACTIVE_LOW>;
+		sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
 
 		regulators {
 			reg_vdd_soc: BUCK1 {
@@ -224,6 +225,7 @@
 	pinctrl_pmic: pmicgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x41
+			MX8MM_IOMUXC_GPIO1_IO04_GPIO1_IO4		0x41
 		>;
 	};
 
-- 
2.17.1


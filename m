Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547EF2A2308
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 03:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbgKBCZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 21:25:09 -0500
Received: from mail-eopbgr130084.outbound.protection.outlook.com ([40.107.13.84]:19623
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727683AbgKBCZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 21:25:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNV9L/vlPV1BVlRCOg4vjeAODxtqmwkE2N6FYJBfXDAtafswyUZ0s3fdIkb/+ibRaqnhXy/NhdaqJrNu/72M/sb+XnhEPo5W1dUtgTcTV+1jjqw4It78+HLCXd2s02gLQJF6pRgArVkxPcLiAiYggERtEnxFBeqSUEw0hNvLOQ9GTPuNuWoTEh6HIbe7N3HRb4kMldlK5ivciS0BUHHVSs69+5sOUTUgY+wIg4KcQlO3DAwJFqIfm32+eN7nUKUEO8Z90OlO2UNM5dzdJ4q2+1LJC5nCUQzSfk2VE33H/pCI6lCZujH6lWewmphIBRwzDpyUJlCoPAN3BY+trJt49g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeYxswg2I7KmipZ8EJGU3AnDCse2PpHf+i3cVZ7kGHY=;
 b=YF3RhdlpCv/VPg7LYJfauPrFDvr4DEqFk+69GQGjHWbd5Gg1aOrF446iQob295kk961mYqP3MKytyWVXOxBRjR5UWWa3JLBDPf4UqcxUMBEInVDkAT13LpdQG7gfVazyFQ0wbW9T2E1Ra7SSfIbmI3CewGq/TCh9TOpJ5ezU9H8j4zyG4hlBvx0NIPAlDLKlvZILz9mj1dMRwEoPEsuSv42mzzTFweBQaHf+NvhwBDJnMprWAwv1hWa/03WAIWOVJkhBD4RYqjVaoiRtkOSs8aiq9jB2VQCKqThVewM47rtf5CaDW/7KjzYN6DYuha7WCzv89P7J+Lmoe0oKm+NXDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeYxswg2I7KmipZ8EJGU3AnDCse2PpHf+i3cVZ7kGHY=;
 b=ggZdxf7BAevdo5LCMyreB28ommxdI0Varl6nby6FTSGwAUf4HSKQbEWKTD/j4P0YfhYi5U0dfPuQyip4NGbMEk9cuh4yR8xXFolIm+zwZqu7/PMmDvSbCkmPGy8Id/ABZtvMOwrm0mN4MPGZ6+jdYRmPbV4mxAkhJDtF7GF8VnQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBBPR04MB7674.eurprd04.prod.outlook.com (2603:10a6:10:1f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 02:25:02 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc%8]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 02:25:02 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: imx8mn-evk: add IR support
Date:   Mon,  2 Nov 2020 10:25:27 +0800
Message-Id: <20201102022527.14265-4-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102022527.14265-1-qiangqing.zhang@nxp.com>
References: <20201102022527.14265-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27 via Frontend Transport; Mon, 2 Nov 2020 02:24:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6073c9dc-6016-4be1-804c-08d87ed68080
X-MS-TrafficTypeDiagnostic: DBBPR04MB7674:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7674A038D70B6D85DAB1D83FE6100@DBBPR04MB7674.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:267;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y/fcuIhm3fXWB1MPNuBQWsTnv1YZDswMSprm9jP4+7XU8DQtkMRxvkbHvA1WV4KkUHtqqvxOXLN/iYHTvP35NMQ3hCUEjslLLxXmNpJbcwuhpHJaZmCXSVCg6QUpYWIvfdhgKOH7IygLzSbTeY7e0j72+eQpfWmrjNwFFtT84u2D7VvM304Y8YlR15dYHPbQawJeaHJYdTyvW5p5OQBhjVb1eDjJ2ZgaJREMVdZa4ptKl6jBdBDn/73WeY3Pzo8V+oJ9znEUIA9FArl6Jm8QmLN4a66gGw7tYeOQE6SgeLzvdKa1uk4YJN6brgdNVyp2gD8+MaYZzHH5rWMl0wAhLV6OK6TKbFra6eL1R2+HmxbO9FpKt9NJuyp8i2qvePId+U9GAdCTOqkN63x1CYdXCBHICalotirU/JZu9+NGb7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(186003)(5660300002)(16526019)(26005)(2906002)(6486002)(6512007)(6666004)(6506007)(36756003)(478600001)(69590400008)(52116002)(66946007)(86362001)(8676002)(8936002)(66556008)(66476007)(4744005)(4326008)(1076003)(316002)(83380400001)(2616005)(956004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: uHJP06D9Moaa+P1bzGDJpNUzmxHsJcNmp2deVCLrWMgCyuOZqKR9aj8HWEqgLcFgjgPSmrSAJ0koCrS24Yopk2Bly0nW94mjY4QSlkiLFjs25jseA68GK/ccQnFHsr1nd7lujJwRGrMufB7RrErjm7WkDeDOAUnG+bFg3IAxYT9al9lC+LKrRqXVYcskRzIGXbKn3A3Jnp09t2aG3SUu6clDvJnHnQG09ZBIlx7WbZcunFwGrHHHy08ZM/YjxsaToVg2jx4fgP497j9377n25CrlCaUfwPtsRxAPAPUpBmvcwfGSk/V6GES8J2GZBSJBWaj5U3jqJvyZGwJY0SDFQAjOX8wGbknpc5St57QBeY61xDupt0zcuq0T5RNB8UiKSEyE1CnAzua9ulyDaOYQV68iIUGNRdU05+Eq7GgQrWaYpyZ6db8dR2qJfyMuZENo2FyOFQISYATtu8+cW9UNpPJGdVGRwx7OOiWn4OlxDrjA/YTHoKcPeTwS0d3eghlqKTQ49IPDG/mrhOVxkD6lo4ChjgebMiGN1hexcNF3tSwaK+e5dPoFtqXV45HDZMeBQv8LckSNvTw9G31gygTxUsdq4iZB9E82zi3WGdxvDgfxhFWx0yIQcGVb4OESXkob8GBPWGwMUe4bJyMVyFFGMg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6073c9dc-6016-4be1-804c-08d87ed68080
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 02:25:02.0157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGqGJPWnEUR/hemOXSkuaHRxDQMm8u7qHCOD57O/CIvnJQeudJOlyH6fTf22kOxpf86LuiTflRaguTcd6Vm9mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7674
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IR support on i.MX8MN EVK board.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index fda890589a09..76d042a4cf09 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -38,6 +38,14 @@
 		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ir>;
+		linux,autosuspend-period = <125>;
+	};
 };
 
 &fec1 {
@@ -202,6 +210,12 @@
 		>;
 	};
 
+	pinctrl_ir: irgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO13_GPIO1_IO13              0x4f
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX8MN_IOMUXC_I2C1_SCL_I2C1_SCL		0x400001c3
-- 
2.17.1


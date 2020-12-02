Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3544C2CB49B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 06:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgLBFmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 00:42:45 -0500
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:26739
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbgLBFmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 00:42:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8BoTZkUZ3hpKXHTzmT0pSKOzskGVuC7hbWOG9wi93QwClOl+1lZOkgmdi/48wR1whDpFJmkh1qRNMjuWSU5nbBuxVzVStsLRivVXYN3EKhsBKwlpv+1fN3qwhuJzqfsB8sztcMa/DcaZ4lJdp/ss7QYLuyPxwYq9folVe6p0vNmKOXIZ7fLK4vN7QliI3FbtEi2oKxJWXQ0prl03kGZiumunu79uktE0sIbKAzrLREvAlF/RYpOG7CE4C2KDjyXtpuaN0AqtLiPC89fxpvEmTCrJuXWmO5IeiY0nb90Zmrwm6vinn1uxlD7o+piaRJPlDlq6Hl8mWiCyAaXcm9boQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaD33NuIHYcPLEhIc3CTKMMfn1tDp8saCnf9+/I1PPs=;
 b=EJhWuGkmbHd+cDOMBOe6sZzZaY9yj0N+sqhnRqKQrfvIrNubULaBVsQkS/+Lzn0jryoli28Y/sLNim/j3ZqWbmIP900n6V/wThzXsP28knyKH5DRcHKv3HCsiYqjNFYVpSPMCbCOiYKQQtCCUWKrr4OJhq2U3R1aYAhwMzl8tYxVS5z+LIhjsTrYVzOx4tN2yIZHy0Ej+gSRDIp3jY20a47vcOicoquSnvTMPDoDOPeFMST1vLtUGNsNc8lwkwXtKbi9OFnYCwlhku8+bc0U9DD8Sj0fywawIMF4cAoNoL8vJVdU26MG1J4rm2GR/4HQcUlKJp2DC6mzONTVY83qxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaD33NuIHYcPLEhIc3CTKMMfn1tDp8saCnf9+/I1PPs=;
 b=pnZho1aBZQZo9sfKhrEbALKFInhd3euueah83fUHuKQR4xtYTXrpirmYKUUA7laawrwkccjkH+DizhyYw1myFa9afsU4M97GfUditFg3cyd3J7p3eig8+DVqDDE/sjIF3LK5o8Td3X2rwPrz3w7ztKJu4OSSXBLUBEMME2Dk/zk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB7085.eurprd04.prod.outlook.com (2603:10a6:800:122::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Wed, 2 Dec
 2020 05:41:39 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685%7]) with mapi id 15.20.3611.025; Wed, 2 Dec 2020
 05:41:39 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, robh+dt@kernel.org, aisheng.dong@nxp.com
Subject: [PATCH v2 4/4] clk: imx: clk-imx8qxp: Add some SCU clocks support for MIPI-LVDS subsystems
Date:   Wed,  2 Dec 2020 13:33:39 +0800
Message-Id: <1606887219-5854-5-git-send-email-victor.liu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606887219-5854-1-git-send-email-victor.liu@nxp.com>
References: <1606887219-5854-1-git-send-email-victor.liu@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR03CA0091.apcprd03.prod.outlook.com
 (2603:1096:4:7c::19) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0091.apcprd03.prod.outlook.com (2603:1096:4:7c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.8 via Frontend Transport; Wed, 2 Dec 2020 05:41:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 55f07647-95d0-4a8e-aaf5-08d89684f0a5
X-MS-TrafficTypeDiagnostic: VI1PR04MB7085:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB70851CA6460402A6D44A850698F30@VI1PR04MB7085.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RjBYFT+o09SFXWbxTb9cF1Emr0/gvH6Dteno28sTOjHruB8Kf0cTJkVN1WxNPSu86QN3NfLeDuLZ2jBNlHj2A4xTMPuGe06RwG8b4Pt0ulY7K23YFHCdqmrAKCGOcj+G15OC5tgTjJEHtCqHOO4VSfiYAMpOh4rS4a9xM0YJ6R4E8h0DTh9u5vEc8925bfVU3C8LiWcCm2/E/1ZiV24oNwgSvRXK7URJGBUnO9otSfcnwFygtBWgPQ/WrwiJJh/qEtfYV2tjUmvCazdgqKqxbeVSNC/wRIaxpoLcZ9s6ThDV9f6L1Lp3wRSzIQaNOJ0WOs+bmpXP+E0azrgk9W9x6HYy5jrE32woPlLz9FNgcRVKLx0YTwk6otDKL+hyFt2M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(4326008)(6512007)(83380400001)(6486002)(7416002)(8676002)(36756003)(5660300002)(2906002)(66946007)(66476007)(66556008)(8936002)(26005)(956004)(2616005)(186003)(16526019)(86362001)(316002)(52116002)(69590400008)(6506007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Tsv3y+J2Nay1wfc4roIn5ZhgFJGK4MMthqlMQJm8v73MQOUG2HEuJrk1cf83?=
 =?us-ascii?Q?VQXeiad7/k3DJr3oi9dUyhHDTCcdgqKDk8CvpCMe98BpYJsSD80PxnE4kp8c?=
 =?us-ascii?Q?tTUBznAl2MonzVMTQS+oQNo5YfiIYi0OkXdFqN66tTAbx1x+COwxaeOFUU5x?=
 =?us-ascii?Q?By9m0uOHcKGOnVFd8h+1hYKenKRhI2B78sKLGIY3YFgZHfN8TGw1n+PxaMH4?=
 =?us-ascii?Q?vFqCpQcw3gUiYc6b11cmSwLcy7UT6HwB2V51Vk3SfRVf+7EapM0LAvZaCB3Q?=
 =?us-ascii?Q?h49ajnFQ/zubsKzE512i2xg4j5Ct3cAbTLCTTsMV9hKASWAJl1a2bQmYMt6V?=
 =?us-ascii?Q?d8ue3v/pIdzsQHEPL1/hVKQs9S8sZn6uN5NlwCgINXydc2AujxaSQ/wDp480?=
 =?us-ascii?Q?n7BWSulLG9SjemDnvF/4GEItxN8c2eDg91LtMn0ndYGvPM8/1WzpfITCEVQB?=
 =?us-ascii?Q?J/Ea7K7KgfN0mXkATwMocv431hsW2VCHdsOKgjsDsPA7XNTgBIjBG2g2LeFN?=
 =?us-ascii?Q?yz9T/5q2Bm+BSCaUJey9PvwAPSi+ftgAA2jVF0h9vfTbLJp34kKgi9OG31vT?=
 =?us-ascii?Q?39HNPeGroU9vuvcwq3lVOSwGt4hA/HS1lN1irh8oTOjrFiwCvjMCcFyfDer/?=
 =?us-ascii?Q?ApQNY9h35h8Tm4yl1NROR4bCP6EIpavl/XOQj/b5B1uNMAMzUHzlF78EteNk?=
 =?us-ascii?Q?akEhmvSnVm2OATojUFKr4lntqJoDIYRcn7mUT69sXu17j5Qred0few+En0Fn?=
 =?us-ascii?Q?DqoGPbyZwO/khAExxjT1zpRoUCya79ekMI+SwM9wn8tAk/0VWbiwbB9C17vr?=
 =?us-ascii?Q?ZwSOPkmWkjQNKfNdg/nuyAqXh8PsAHaBdZ6GEDcDcPbfWQb3UvyUaUAMWpHt?=
 =?us-ascii?Q?iLW/noswWibftQK35VgEAAW5pdbU3aqPSa47pSSxxZtTqKvH0mRVHM4JH+FU?=
 =?us-ascii?Q?H0WxDxTm1lGfm4DFMEYiW95obDF5xD6F6+VsH6f8epVq/L0E3bjeBEe27iPj?=
 =?us-ascii?Q?o5wp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f07647-95d0-4a8e-aaf5-08d89684f0a5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 05:41:39.3621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKae0BbUxjYmGOdwY47HwuEJvME7roQJl12Vb+36bXQppZARpFeBNMVI0n8ujUXKjM+1Qm+HvJfctPrPxq2LLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds some SCU clocks support for i.MX8qxp MIPI-LVDS subsystems.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v1->v2:
* No change.

 drivers/clk/imx/clk-imx8qxp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 0b4bb2c..fbf1170 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -131,8 +131,18 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	clks[IMX_DC0_BYPASS1_CLK]	= imx_clk_scu("dc0_bypass1_clk", IMX_SC_R_DC_0_VIDEO1, IMX_SC_PM_CLK_BYPASS, clk_cells);
 
 	/* MIPI-LVDS SS */
+	clks[IMX_MIPI0_LVDS_PIXEL_CLK]	= imx_clk_scu("mipi0_lvds_pixel_clk", IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC2, clk_cells);
+	clks[IMX_MIPI0_LVDS_BYPASS_CLK]	= imx_clk_scu("mipi0_lvds_bypass_clk", IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_BYPASS, clk_cells);
+	clks[IMX_MIPI0_LVDS_PHY_CLK]	= imx_clk_scu("mipi0_lvds_phy_clk", IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC3, clk_cells);
 	clks[IMX_MIPI0_I2C0_CLK]	= imx_clk_scu("mipi0_i2c0_clk", IMX_SC_R_MIPI_0_I2C_0, IMX_SC_PM_CLK_MISC2, clk_cells);
 	clks[IMX_MIPI0_I2C1_CLK]	= imx_clk_scu("mipi0_i2c1_clk", IMX_SC_R_MIPI_0_I2C_1, IMX_SC_PM_CLK_MISC2, clk_cells);
+	clks[IMX_MIPI0_PWM0_CLK]	= imx_clk_scu("mipi0_pwm0_clk", IMX_SC_R_MIPI_0_PWM_0, IMX_SC_PM_CLK_PER, clk_cells);
+	clks[IMX_MIPI1_LVDS_PIXEL_CLK]	= imx_clk_scu("mipi1_lvds_pixel_clk", IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC2, clk_cells);
+	clks[IMX_MIPI1_LVDS_BYPASS_CLK]	= imx_clk_scu("mipi1_lvds_bypass_clk", IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_BYPASS, clk_cells);
+	clks[IMX_MIPI1_LVDS_PHY_CLK]	= imx_clk_scu("mipi1_lvds_phy_clk", IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC3, clk_cells);
+	clks[IMX_MIPI1_I2C0_CLK]	= imx_clk_scu("mipi1_i2c0_clk", IMX_SC_R_MIPI_1_I2C_0, IMX_SC_PM_CLK_MISC2, clk_cells);
+	clks[IMX_MIPI1_I2C1_CLK]	= imx_clk_scu("mipi1_i2c1_clk", IMX_SC_R_MIPI_1_I2C_1, IMX_SC_PM_CLK_MISC2, clk_cells);
+	clks[IMX_MIPI1_PWM0_CLK]	= imx_clk_scu("mipi1_pwm0_clk", IMX_SC_R_MIPI_1_PWM_0, IMX_SC_PM_CLK_PER, clk_cells);
 
 	/* MIPI CSI SS */
 	clks[IMX_CSI0_CORE_CLK]		= imx_clk_scu("mipi_csi0_core_clk", IMX_SC_R_CSI_0, IMX_SC_PM_CLK_PER, clk_cells);
-- 
2.7.4


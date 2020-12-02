Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537BF2CB48F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 06:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgLBFmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 00:42:22 -0500
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:26739
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbgLBFmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 00:42:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZmFBeAMvahKNskOnxdOX+heKbuxvHavJlmsrosQVKZtzIvNF4F9rp4s92h1GiaQBHFTH7CpqxXh2epCrNi2vrLHC8VjxVmale9JaK8WEvrwZckQzCe4GNsjitQn358j8HfN8zW18LESxx05eAO1ImqmkhwgbASfTAP4xj+vAFG/TvGMAQ4KzHuMeKoOZkrjeHC2480dQsY4rc/0iWYffTzvgtpPznb85mPIOOgRoQLkPnj7DhtNjW/BY9IDJK8dQkEXpLDjEO5NehWE1yydaYtzw8O1lfimZx+B91PNOjDMqkeqONTAJpUNbjmh+of+1wyZjUB1kxEefTt+yypAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1LejCQdTooB9PhbXFq6XHokkshS5eGbTar1U8Mod6Y=;
 b=aJMcKkIsAFMzp7MFbYDNRfkX0AIPsTJUs85DVl//4ALvRjNEuJ7PUXixRP7gJ+WVVYglcgmtib65tU0mv7zWS0LCT+fN3YFEsOt7SZCB6v0hecZNxQj+rc9txfqGvT6TnLhPdKwJG3n586DEFfacbaVrAD12epKEcX68PWbL+7jJucfohVLCoRZRmJMX33/Ca0XcNYEyCso3vUlYAviNqYHtXSvNXangZnyoy2GmyjE5m4yRwQvKm5R3EeRYfrQoKCa3p+audgNUiccF4ETPNWFZJbW9v7Y5JPVjaQS4jUUysxcUudni/upR2z4IfQeEvAhq3PGODHzDjttJr3tJ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1LejCQdTooB9PhbXFq6XHokkshS5eGbTar1U8Mod6Y=;
 b=Lz6BtJHq8AHK1jO6LySrNBI0zvJrvcgWPblVd3N2p/6Ka/nWyj4YnePj6PQ7WQ5GUzRM071dKcDibjGG6Me8RXpGpG5wZqj3vQlOEeB77/ojNKY9JxAVZt08T3fJYpLK+9FbBPMmZgsW+cJ+XjqvQXf+QgfBeUzY6RPFW1Uz+W8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB7085.eurprd04.prod.outlook.com (2603:10a6:800:122::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Wed, 2 Dec
 2020 05:41:31 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685%7]) with mapi id 15.20.3611.025; Wed, 2 Dec 2020
 05:41:31 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, robh+dt@kernel.org, aisheng.dong@nxp.com
Subject: [PATCH v2 2/4] clk: imx: clk-imx8qxp: Add SCU clocks support for DC0 bypass clocks
Date:   Wed,  2 Dec 2020 13:33:37 +0800
Message-Id: <1606887219-5854-3-git-send-email-victor.liu@nxp.com>
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
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0091.apcprd03.prod.outlook.com (2603:1096:4:7c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.8 via Frontend Transport; Wed, 2 Dec 2020 05:41:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a6c391b-e22b-4582-e0dc-08d89684ebbe
X-MS-TrafficTypeDiagnostic: VI1PR04MB7085:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB70855B8D801A7E62AF04E75198F30@VI1PR04MB7085.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 540LSHvc86MvV7aE7+b3SioOyTMjk72B+jr8vCsQhSxNwk7NC4+7ru+GP6kFfcxCZmbDFIzzrhu/WfZjTal37LKRjza8V2qf4aUnlOArdbDf3KLHGL6qwprrYRBMs83Y8sAed66RG7bcib/hYUcF+w9idAFGnmZIqDv7RmjDaGJrhZrEUyvgH+Pt0+LdHzp5pa7R3zbhuhijv33dNsIlJoCvAx1I0t18QqDmoTbacRzAhergsb6+qAOEbTlENFlAInZZh72OXVPj6K1S31geDeXNfKHtH36z3cHVgCHC1TjWWH8JEPjaZL0n49pREtp52bZACxmBhCicRfOs5B6mO6IUyHV88lINUSIUtR+ot0iXwnjfaGonCOSAvshapMn6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(4326008)(6512007)(83380400001)(6486002)(7416002)(8676002)(36756003)(5660300002)(2906002)(66946007)(66476007)(66556008)(8936002)(6666004)(26005)(956004)(2616005)(186003)(16526019)(86362001)(316002)(52116002)(69590400008)(6506007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4EToJ8vDa6Sqva6Zg+MruayQSMoOQsK/LwBFIwTes24OZTA502kpq4Rnxotq?=
 =?us-ascii?Q?2BCpVg8J5bG90zVe43BFRHwirei+balMt9xq5U5vk70v4wmi73jpigFyKXgg?=
 =?us-ascii?Q?MHDPCKVGRaLj7nBF/+C5oW0C52l9j9zf9XphnBtPowDtOS+IT8j3ZUIDl6Vk?=
 =?us-ascii?Q?qppv8yhZBHDkuipFXyin0kHG9DeRKd1ZIN19EOoEGC9VdvPbbD5kbMFDKSoy?=
 =?us-ascii?Q?GmrjjXl6lBlNWZLtnwucGi0cdR1xEs9EF3b/Nq/zR81btf6YVx1dz1Fs99dK?=
 =?us-ascii?Q?8psGsZ7XDEhFJpbprEw2cG+0Ux0t8w2w8Q11HO6T15ZwLu8uSoNQ7jp7RPo3?=
 =?us-ascii?Q?ZBAVwSMjqG4YQKxr7dI+wIbIqrVF/rqllCQMFRjav9b0vTxOcKobW5LCQp/G?=
 =?us-ascii?Q?FW/K6+3unftFVtihcepTWLCpufUmrNQusRM5VHTp5A8bCRYqGGvimemyC/Rc?=
 =?us-ascii?Q?NrUeyVCB6B/7rcZbibAykRPEW6j6EyGCtEpYjCD0VyU5jsXJXOxKTyqc8isF?=
 =?us-ascii?Q?QTP4ThqmqhKX5savGo9nucJzmZ6OOyrKV2rkn5UzlcrGatG1bK/eRe8C14NZ?=
 =?us-ascii?Q?2coD6GfUbPU+WqZZaDu/S8/jWTFQFtfQlEbzF0+GtSpmiiQ6+MLxscEsvyRr?=
 =?us-ascii?Q?D/xMJHFC5BOlJmFOB1I3SPo7VfSQ6uv0fagKcJsoopHjukP/W6cuOgTO6SsQ?=
 =?us-ascii?Q?htUg7Pd8T4QzTPsYz8SGDOsIqibQDLWo1kYtg9MCghNYKSbWwA0RgGVeu29H?=
 =?us-ascii?Q?9ZYM9O8EJO8MKFA1H6SlnMwI1CJmijoSM8Bttuod8GIVV0BR4kXzbj6Vvun7?=
 =?us-ascii?Q?EcyyCD3jyz1O8FiNQWi8lBGiRDesyxED/4T7Ju9z9gE+SKC6Nqs6j2Ysk+kY?=
 =?us-ascii?Q?3qSvdi12jP9ZKZVykmNdoQp0XUhee2SKLf7t3kuX3L6Spf/tkqFjzhu/g7yw?=
 =?us-ascii?Q?BUWt3KkDxylzJyQbctUbC5RSaz23xxDPgP/tps/pnx/BNRR0Ggnd3mkcuTFo?=
 =?us-ascii?Q?iJQg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6c391b-e22b-4582-e0dc-08d89684ebbe
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 05:41:30.9828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /vfBRc4rKcpXsIBITv7SKxH3Wp9823UhCTNXcYTG9iusTTvruZbRzN9/OIBHWu/moJ8hZHC6JMAC6vdAzKbTZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds SCU clocks support for i.MX8qxp DC0 subsystem bypass clocks.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v1->v2:
* Newly introduced in v2.

 drivers/clk/imx/clk-imx8qxp.c          | 2 ++
 include/dt-bindings/clock/imx8-clock.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index b48643e..af6a545 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -119,6 +119,8 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	clks[IMX_DC0_DISP1_CLK]		= imx_clk_scu("dc0_disp1_clk", IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC1, clk_cells);
 	clks[IMX_DC0_PLL0_CLK]		= imx_clk_scu("dc0_pll0_clk", IMX_SC_R_DC_0_PLL_0, IMX_SC_PM_CLK_PLL, clk_cells);
 	clks[IMX_DC0_PLL1_CLK]		= imx_clk_scu("dc0_pll1_clk", IMX_SC_R_DC_0_PLL_1, IMX_SC_PM_CLK_PLL, clk_cells);
+	clks[IMX_DC0_BYPASS0_CLK]	= imx_clk_scu("dc0_bypass0_clk", IMX_SC_R_DC_0_VIDEO0, IMX_SC_PM_CLK_BYPASS, clk_cells);
+	clks[IMX_DC0_BYPASS1_CLK]	= imx_clk_scu("dc0_bypass1_clk", IMX_SC_R_DC_0_VIDEO1, IMX_SC_PM_CLK_BYPASS, clk_cells);
 
 	/* MIPI-LVDS SS */
 	clks[IMX_MIPI0_I2C0_CLK]	= imx_clk_scu("mipi0_i2c0_clk", IMX_SC_R_MIPI_0_I2C_0, IMX_SC_PM_CLK_MISC2, clk_cells);
diff --git a/include/dt-bindings/clock/imx8-clock.h b/include/dt-bindings/clock/imx8-clock.h
index 673a8c6..82b1fc8 100644
--- a/include/dt-bindings/clock/imx8-clock.h
+++ b/include/dt-bindings/clock/imx8-clock.h
@@ -64,6 +64,8 @@
 #define IMX_DC0_PLL1_CLK				81
 #define IMX_DC0_DISP0_CLK				82
 #define IMX_DC0_DISP1_CLK				83
+#define IMX_DC0_BYPASS0_CLK				84
+#define IMX_DC0_BYPASS1_CLK				85
 
 /* MIPI-LVDS SS */
 #define IMX_MIPI_IPG_CLK				90
-- 
2.7.4


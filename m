Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2661B2CB49D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 06:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgLBFmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 00:42:52 -0500
Received: from mail-eopbgr40051.outbound.protection.outlook.com ([40.107.4.51]:14210
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbgLBFmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 00:42:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScNR2dA+VPb9KFem7Shc6Cn3oc7jEsGkKKokiitOaWDqIps7l8LJtgC76+kCnIVBiqWaLhQ/FzmaHI1F4hsSuOjka95B+vB9fJMifEazuyc/sQnaaQBFw2YKpOhBDLVVBBwYcrEM7iBKHs7jmBKnwWbn6cf0wi4IZ/t8ukjZeaNmzwTJmqG02MR5h2w4YPFu63BWppo3lz8s+RFoSK6O+RLyNHl9W02nGngunaVPHi160bkwN3pCjOEz8McOST+xbWRA/+7DHXDgJ7YX0s0Pm8rYbN78LPLNKRUZsbQT4fdiWgwYv7wsjolFysbVrHyFuEK7MGpX3drpzItYYM7tqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nqb1e6tZbn+80Ff+X/HFR5KfBmLY17WVPemDojg57Ok=;
 b=RTFSk6v1qV/jVTc94/v1TGUv9MzQ/IR1eeslikKD3swmuStm7wDFxetAbqGgTG6XxV9Yil9pz73Byb57FpliDkgO9s7koSzJ1cxCI9rK25Nl4JXr7xE3Ez6WCRIn7mnn+CfE63RIsuheHv8MOXSDIwESITjBCivtnWz9z8GWcusYFgQDoBE4xqfnJLTOiBoUjKFRfr5HyMzfL0kLkCjv7KxY2FvDBtt3lIiop7Z+4x4UBeemzUIeID5YXQK+ybVbDW84sp6mqI1rzyrxplWIkP081PigCdgyl+Y/E5oml/LsAzW8XciecGI880pE/Bosh3n2EyOj7n5jFd3Cfkymrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nqb1e6tZbn+80Ff+X/HFR5KfBmLY17WVPemDojg57Ok=;
 b=OV0R4/YohIB6fawrzzcrR5wWo7d1imgxoYlwr+aylDRaEz2o4AiSlSYgbKOq5Onie2z3QaL5+R9A8iv5Cn1kLgXrXTjdWPvI1FhKFD+NIQUa04Hm7rYstM2EUNlVtetDL3Uw3TiNnrkA3j9Ynwhf0+BiLBU97e8ldbBz8Efs2cM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB5184.eurprd04.prod.outlook.com (2603:10a6:803:5d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Wed, 2 Dec
 2020 05:41:27 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685%7]) with mapi id 15.20.3611.025; Wed, 2 Dec 2020
 05:41:27 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, robh+dt@kernel.org, aisheng.dong@nxp.com
Subject: [PATCH v2 1/4] clk: imx: clk-imx8qxp: Add SCU clocks support for DC0 PLL clocks
Date:   Wed,  2 Dec 2020 13:33:36 +0800
Message-Id: <1606887219-5854-2-git-send-email-victor.liu@nxp.com>
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
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0091.apcprd03.prod.outlook.com (2603:1096:4:7c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.8 via Frontend Transport; Wed, 2 Dec 2020 05:41:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84830c9a-1686-4152-474e-08d89684e951
X-MS-TrafficTypeDiagnostic: VI1PR04MB5184:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5184FFF6224EAC53416CC3AD98F30@VI1PR04MB5184.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZMH1W2fUbx8oKPbBFs+Y0T3KWp30auiWvzsq29PAr3i310UemOol+rEPUKmKt7DhXcGi1CfGfHDjI6QpB6M7K51FaC/pBk1vkWw4U0kv97OWjNtFOB2UGbk8st0YGXPgb6yQiy7MkBfTqFZpx0MwTAvOAax00jie+q84BUQILWR4X7iEDjX5Bqk8zXzDux+rToBCrR8vz6j5sz1LIdiyWHE0MMKSpTAmYrPrCgk/U4deDOEFdKnAnL1s5+QPLnrwVIUN/WC2Sif5Ate4ODiBRn/vTO5nWYF0OOKCUrozn21JK9v61RFWYoCYfRHfOA/VssH+7Cq82mpuTkpLPU3zbsW1gA17aeK9l6pI7AhzI3AyRUOtxxSSW2AmFGsE6u3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(6506007)(5660300002)(478600001)(26005)(36756003)(186003)(6512007)(69590400008)(16526019)(86362001)(6486002)(2616005)(66556008)(316002)(66946007)(8936002)(83380400001)(4326008)(52116002)(6666004)(66476007)(8676002)(2906002)(7416002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8cwrEt/asy7cS7b6cCjnakkB+10tMTLs6tSPLZQGwy6JhLQ0IOYP9rST+17T?=
 =?us-ascii?Q?RdzVfwYt8R4Mr4hS2s7Eac14xWhqvecfn/BKlY5M8JZlL5u3kf5pddd5/gSC?=
 =?us-ascii?Q?o14i6kkQKHrHRE5YcTsmUlArwOBujuEHLVI0dDGWKfzqC8eG7nxAhQHiowKo?=
 =?us-ascii?Q?0UIYj7R/s1qWZCSpcmX6WLITHT5iOh6NwZQrTzipu1lIPTUhEPOSVVkK2fU4?=
 =?us-ascii?Q?iS9pEkqh62SV1e/34E+WId1TyuXaNyGHjg9urSofz09PqKx3rIWmnEs96BD0?=
 =?us-ascii?Q?pnnNpYzoondCjSQ3nnlJOncWMHKtOGthQ9a1v9B86zVRJUpVls//p8+8GGlT?=
 =?us-ascii?Q?YtDSqO2eNTAnoPEzSVXyF3DCl8W4D667V2sJwe+8kOO46rY3HhI706DyoPqU?=
 =?us-ascii?Q?nFLZ1a5vx8qKgASfJjqZzrXo/Qnz1uClvt8JlKW8QIcWyWNGcjKkqZyPkmjm?=
 =?us-ascii?Q?4yXtAgqS53MZjxFatrfvQRWSDQDr5tbhL5IBxdDENansBLiGHAzCzqhagLgm?=
 =?us-ascii?Q?OpcJqrnWiylXkXBmPZDzwbkb5CvtVldsXgf19KvI2i9DNXJZB4ZaAof4JqXb?=
 =?us-ascii?Q?pgTSjU7QrIgrKfHFtEi1FRtLduVU+rDXQbjZSaVX2JQbc2ceqM9/Yq490j5Z?=
 =?us-ascii?Q?Zlwj6H3ihIOt6MMhjuRzKFPbBUo1VdDbF29jwffDFhiGijx0OJQFJB829aWJ?=
 =?us-ascii?Q?M7noqgQv9BCjzJGnpKZsskti/nDszU1ctIZqA2YsU5bKG+ZxCZyXSQa0dLVj?=
 =?us-ascii?Q?bp07v+5HkEulEdyzHPqOjm7TNHZKwJRTTF0eU99kdBcqtP8Z18a1s8Pik/rE?=
 =?us-ascii?Q?e5zxqpkXlH6hhbwl5fT2WJ6TuFWg9fJ7vWEaz13PRbxIfqyH0wUwrrc5G79z?=
 =?us-ascii?Q?pOm8Ntjcu7rfOSI11JJRLEq8K1QmMfhNL+ntF3T92sxxKujodOez2Gii8hQA?=
 =?us-ascii?Q?mq8yuozkIXFiaYjgGmnLFdDPvTXbuEbpiIo9j88a6rtA8WK0Mvf/CsUDoHf6?=
 =?us-ascii?Q?vBIz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84830c9a-1686-4152-474e-08d89684e951
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 05:41:26.9021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjJqEgO/bFnsCa6GP4Xygz5ojpt6TGbzCnin0e0diwfWX/003xhlac4vtgxKnDHjgoezz1D9Ocw8sN4OnITM9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5184
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds SCU clocks support for i.MX8qxp DC0 subsystem PLL clocks.

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
* Trivial tweak - Move PLL clocks down to display clocks.

 drivers/clk/imx/clk-imx8qxp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 5b3d4ed..b48643e 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -117,6 +117,8 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	/* Display controller SS */
 	clks[IMX_DC0_DISP0_CLK]		= imx_clk_scu("dc0_disp0_clk", IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC0, clk_cells);
 	clks[IMX_DC0_DISP1_CLK]		= imx_clk_scu("dc0_disp1_clk", IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC1, clk_cells);
+	clks[IMX_DC0_PLL0_CLK]		= imx_clk_scu("dc0_pll0_clk", IMX_SC_R_DC_0_PLL_0, IMX_SC_PM_CLK_PLL, clk_cells);
+	clks[IMX_DC0_PLL1_CLK]		= imx_clk_scu("dc0_pll1_clk", IMX_SC_R_DC_0_PLL_1, IMX_SC_PM_CLK_PLL, clk_cells);
 
 	/* MIPI-LVDS SS */
 	clks[IMX_MIPI0_I2C0_CLK]	= imx_clk_scu("mipi0_i2c0_clk", IMX_SC_R_MIPI_0_I2C_0, IMX_SC_PM_CLK_MISC2, clk_cells);
-- 
2.7.4


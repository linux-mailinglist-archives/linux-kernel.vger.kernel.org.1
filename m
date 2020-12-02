Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F18E2CB4A0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 06:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgLBFm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 00:42:56 -0500
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:23207
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbgLBFmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 00:42:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNXtYdVxkuccLVhN8pBcLh87iFuc8XzvPXoncX+voTX4t8xJ0C4uNVTqY0LuiQCGdeABRgKvZriVPZrw/96Z5yS+uKQFR5lN/Rd/wiJstKNmCdX6KYtkbcbuKTlvenm1YRzP8fD9UIK7xKEUYB++rnv/71Tlw9dMC3H2SgM+xgfmKrDRUYgmCHRMwQ9kmIDF25FiwXqAqvmA6hbmavdyS6zavA5CswiqMTTf1iSsp9auiVhgs1hiuZdtcsxVAMGpQnseTimXIwbLeajqh3kfLAzlneFHh3iaw4g4hwfZpZbfg0DiBQSRoNsB7BGU0zNhilZQRc+l2KLmR/FEuaadRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75vWFAhKvJ4eCHRq5/Rcu7lE64GAp/o9C/z8E2xA+FU=;
 b=U2w0FRstim5DmFDLrQAzaETXgg5dsMYdHDr5SyStr3JqShoAy73S1bDIqQ3JznC5erySqyjX2XUWPJSpNeOxohegxo9lOnATMJft8c0bbOSjXshB4n93t28hRNp8yC83u8VE6ulravhlmb0MSPltNgSasxAoLfkeH8iUHVADx35oCoXCh4ZWwD4k/z3Osj+YXj30WRJRFckhG6fkjMo5fZwPx/VGRzWPz0A9qjMfnQswRVvgTJJB7pwX31+datckqo5MTytUCmRtY5zfPBkDcIC0nkgANrQtFzGa+8xl1f8nPfFS0up0vpcThpJGKq+qH4LP514Jo3KvYKc5onL7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75vWFAhKvJ4eCHRq5/Rcu7lE64GAp/o9C/z8E2xA+FU=;
 b=rn4yPpJ7jJyArQxMvz2bKyheUdHZSfOruaTm0QhApOBKh03+/A+euFMMTB2QfhiKQ8LDvHV4JyAGLTyYpniW0cb+RnQ4/9A723pwMnVGPEm41KC6pdrvKu+Ehk0FgqhxcHzJq0hMl20uxqFEQccdYWKZud3dBUGonQ70+8CnkMo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB7085.eurprd04.prod.outlook.com (2603:10a6:800:122::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Wed, 2 Dec
 2020 05:41:35 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685%7]) with mapi id 15.20.3611.025; Wed, 2 Dec 2020
 05:41:35 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, robh+dt@kernel.org, aisheng.dong@nxp.com
Subject: [PATCH v2 3/4] clk: imx: clk-imx8qxp: Register DC0 display clocks with imx_clk_scu2()
Date:   Wed,  2 Dec 2020 13:33:38 +0800
Message-Id: <1606887219-5854-4-git-send-email-victor.liu@nxp.com>
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
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0091.apcprd03.prod.outlook.com (2603:1096:4:7c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.8 via Frontend Transport; Wed, 2 Dec 2020 05:41:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c16ea287-6ce2-4bfb-34a7-08d89684ee31
X-MS-TrafficTypeDiagnostic: VI1PR04MB7085:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB70852DDB321D5F9D16B692EA98F30@VI1PR04MB7085.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/jw7IJgIxXWJ1YiMqvBp6izN5sC8Vzt5r2twCMDCKdOVl1f1wXTQCa+qGyaGHbwGp6Mr62ltobdD+k+TB4LP9i2TZHV+zy+CkuQ63sn/ulWRwlb3sDdFaBrOAnWa1LtQ6hffzLxGg7TuA/KOgypfSIH5y+kqHT6fFDyuv2Ow/hgBRXstBGhpK5YZAWlA2FohzLYyLjNz7afxBrfC479Rikmvfr0RfhCrRwFdcgX3Om8h4VGT0lmt+bSp7c02Jn/zh3hIictw/RZz7ZDWEt6oxxTkq1xo3JwqyhSM1WJzP2iyfdhUFIuX2+1bFtIIiKFcgFsQEHBkWSxQmJZHW1oXk1WFccNNQjomf7iM69r0NUCs9IGTTOnukHNEistAEfy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(4326008)(6512007)(83380400001)(6486002)(7416002)(8676002)(36756003)(5660300002)(2906002)(66946007)(66476007)(66556008)(8936002)(26005)(956004)(2616005)(186003)(16526019)(86362001)(316002)(52116002)(69590400008)(6506007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PousRQVGrkt0VdfWkQhdIuL42531WWhwcOROZA0JLIo6DG5hXJRhfeIWYvag?=
 =?us-ascii?Q?C3zHYmCd+WzsiXiJFfbwqxSIaUbS6gIz6ua54TDKduWDmrcQ3g2YAbilwhg0?=
 =?us-ascii?Q?fFRnkOjO/tbC0F43l+YuKEJPWYYrFLJqTI54n9UQLkwtIa4eshdVuFgOhYnm?=
 =?us-ascii?Q?hhYKDUU2bomulkIg80c/rXB2qqVnt3FsuwCulqVa/3G9DdxH45Gt4wT9syA0?=
 =?us-ascii?Q?PsV/sNoWN+jSXawd0uAGDVPJho9li+YEtVNtNTOkQTj1v5b3agpxF4YG+xbE?=
 =?us-ascii?Q?KNXcKICxRB05fHhSja5tqRA+1KvW1uopBzlpVFux8LyKDPOTnl3BWWDhq0fX?=
 =?us-ascii?Q?RLUyodymYKAoYL3bVv/bV2Rh/3H9drheKbE+tfMtMsTY5zaJ9mzcPePa8ahK?=
 =?us-ascii?Q?XX6aVbKhhTb/XCLqhLpZiy6+mjzjXJQ1p4rgdUoXdkY28g3r8SgDPw/ipHzl?=
 =?us-ascii?Q?bfO9GNcZSnjngkIPRccUtiO0kSmlTDcJgHSOCcWCCgYYs3GTliQEznBI4fAX?=
 =?us-ascii?Q?A5dAlEHS5tW1HF65PZ3OVdkf/54IcQz4d6F0nG5Nb9cRqmB0rBX25Gzm2BAx?=
 =?us-ascii?Q?1BJY9+mg5279mRqGp6lQ59HdMu6bgFl8VLOPCOs6L1C3g6DMhRbnR3oOwnug?=
 =?us-ascii?Q?5BXE6NmVW8lQ5wu/ZWsO/JYD2laTchFTWYLpaSd7uBnkNEQOmGzEzBhbiIQ4?=
 =?us-ascii?Q?KD2RcSg+IHFWc9cDZQnWGeMbIHZPbtVxSm/vSHS9N2g1LuIQkfzuPuDInEbg?=
 =?us-ascii?Q?e1gXo5MdurkDVdhPkHOxDMARrWQg1sq6tcY2If31CfrMNr0pyupzMLlRUanB?=
 =?us-ascii?Q?cZuGP9lDR3HTqsjyvhIwHEs+W/PXT92ozlHJsu91tpU1ambEDqJuvlb6Y8VK?=
 =?us-ascii?Q?IE0tRFep5nfoJynjLqzVi8AmhiA7t6vP722oD44jIZ4pUXmlPESeBPBVdc7W?=
 =?us-ascii?Q?ewrNiz5US33q5glXLha4FxYeMpeHEjkXLHOsWxWvyQd9w51Hxo+8o19DBwM/?=
 =?us-ascii?Q?m98B?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16ea287-6ce2-4bfb-34a7-08d89684ee31
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 05:41:35.1415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mr2BLBU2DUYZZXP9DZxBBXEfd4ce2DdAwAPkTqc+4rtm9ZrfhgsgAlm+Z3v6Xah9fFJpfBLcO2YsNG8mCQ5eWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects display clocks for i.MX8qxp DC0 subsystem by
calling imx_clk_scu2() to register them, instead of calling
imx_clk_scu().  The reason is that the clocks can source from
various parents.  The clock source selection is controlled by
Distributed Slave System Controller(DSC).  According to the DSC spec,
the below table describes the generic source selections for clocks
with the same type in various subsystems.  And, the display controller
subsystem spec says the display clocks can source from PLL1, PLL2 or
bypass clock, thus we may specify the correct parents for imx_clk_scu2().

The bypass clock's parent is determined by the SCU firmware.
Currently, the parent is 'pixel_link_clk_in' from HW point of view.
To be more specific, the parent is dummy for i.MX8qxp DC0, while
HDMI TX PHY PLL for i.MX8qm DC0.  In practice, the display clocks
source from the bypass clock only when driving i.MX8qm HDMI TX.
So, for the both display clocks, we simply specify 'dc0_bypass0_clk'
bypass clock as a valid parent.

 -----------------------------------------
| src_sel[28:26] |                        |
 -----------------------------------------
| 0x0            | xtal24M                |
| 0x1            | PLL0                   |
| 0x2            | PLL1                   |
| 0x3            | PLL2                   |
| 0x4            | bypass reference clock |
| 0x5 to 0x7     | reserved               |
 -----------------------------------------

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
* Newly introduced in v2.

 drivers/clk/imx/clk-imx8qxp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index af6a545..0b4bb2c 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -17,6 +17,14 @@
 #include <dt-bindings/clock/imx8-clock.h>
 #include <dt-bindings/firmware/imx/rsrc.h>
 
+static const char *dc0_sels[] = {
+	"clk_dummy",
+	"clk_dummy",
+	"dc0_pll0_clk",
+	"dc0_pll1_clk",
+	"dc0_bypass0_clk",
+};
+
 static int imx8qxp_clk_probe(struct platform_device *pdev)
 {
 	struct device_node *ccm_node = pdev->dev.of_node;
@@ -115,8 +123,8 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	clks[IMX_CONN_USB2_LPM_CLK]	= imx_clk_scu("usb3_lpm_div", IMX_SC_R_USB_2, IMX_SC_PM_CLK_MISC, clk_cells);
 
 	/* Display controller SS */
-	clks[IMX_DC0_DISP0_CLK]		= imx_clk_scu("dc0_disp0_clk", IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC0, clk_cells);
-	clks[IMX_DC0_DISP1_CLK]		= imx_clk_scu("dc0_disp1_clk", IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC1, clk_cells);
+	clks[IMX_DC0_DISP0_CLK]		= imx_clk_scu2("dc0_disp0_clk", dc0_sels, ARRAY_SIZE(dc0_sels), IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC0, clk_cells);
+	clks[IMX_DC0_DISP1_CLK]		= imx_clk_scu2("dc0_disp1_clk", dc0_sels, ARRAY_SIZE(dc0_sels), IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC1, clk_cells);
 	clks[IMX_DC0_PLL0_CLK]		= imx_clk_scu("dc0_pll0_clk", IMX_SC_R_DC_0_PLL_0, IMX_SC_PM_CLK_PLL, clk_cells);
 	clks[IMX_DC0_PLL1_CLK]		= imx_clk_scu("dc0_pll1_clk", IMX_SC_R_DC_0_PLL_1, IMX_SC_PM_CLK_PLL, clk_cells);
 	clks[IMX_DC0_BYPASS0_CLK]	= imx_clk_scu("dc0_bypass0_clk", IMX_SC_R_DC_0_VIDEO0, IMX_SC_PM_CLK_BYPASS, clk_cells);
-- 
2.7.4


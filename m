Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA0C294D56
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 15:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442934AbgJUNQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 09:16:00 -0400
Received: from mail-eopbgr50079.outbound.protection.outlook.com ([40.107.5.79]:40069
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2442927AbgJUNP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:15:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjAUswF5CUgy0Aosv6cRDLnjQCDo7AlijejxQibwNlOCw2b/w7k2oVpPWRUcsm2XBGnjN4BV73POXxJXP8i2uxGZGxb/UdsA28rzN6nypqdEEbY/V/cbTSKgwV+9MOx/VFzWZGRA71G41jXdlyjTeTjjkrydyTnr7rTFYGu7rQ78V3FcBekqL/E+Y8T1naLRQt89NDLbjdGJMXy52/PCnshYTbqhjzsF12HmvdTzHCys62m/QoicvliyrusyDNzr/ehcrhZg++RQoRnNDLco2k4f11R7Cq5tNVnxrJocDifBVzqaHGkICTl6l+Dd065JznsGGHjJ3pE74MLHivnLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owP+ftRfPGXBy+W051+XVxhCLpMtPSVGkk2farXvbcE=;
 b=DTrn4oneyJmT2ZnGtgWuaVTPQScsGVXT12mWTofVcoxdyI9xbAQwE1kBQyFEGs+OkrqQlSeE97byTEgBYi1BQeTZilx9uvPriIUVp4WuSmw3gfbTckt1DMmVDqG5+JKPG+CeSQedzNwzQYigDEnChPfrjMKJWTirt19kEd7lslv0eXpqN7DX7XKRQjC+Q0iq8TOnEPrqSev/tDSZd8pxS5gYAr+Dg1Zm7/I1kHyoAqn6c3yfhtlS1FKNZEhSyTnIwyANULnpcAVEKZ0I6JBFdQr5lO00Xk3fdrDBTUzfjasGmdEFnIEyiRkmFO9zEKUs2WwFMj+fCQoJTj7h6PUHuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owP+ftRfPGXBy+W051+XVxhCLpMtPSVGkk2farXvbcE=;
 b=NtbtICZ0lDInyLtQzlpE/o82i2h/q9MjnU+EVRk9MRAzCMEFq1ZMbQfHYj1/7eElwb4/UxCxZOEa1WRro8m7RWgdjkIWyrhFOyUJo0qlmXXe1ASGEtoVVvKGypqXYWp49Ddc7LkanCg44MUoMFGznMOsWZQcNbJrSLW3B9ILY8k=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5995.eurprd04.prod.outlook.com (2603:10a6:10:8e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.26; Wed, 21 Oct
 2020 13:15:54 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 13:15:54 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 4/5] clk: imx8mn: fix bus critical clk registration
Date:   Wed, 21 Oct 2020 21:10:19 +0800
Message-Id: <1603285820-30196-5-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603285820-30196-1-git-send-email-peng.fan@nxp.com>
References: <1603285820-30196-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR03CA0133.apcprd03.prod.outlook.com (2603:1096:4:c8::6)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0133.apcprd03.prod.outlook.com (2603:1096:4:c8::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3499.4 via Frontend Transport; Wed, 21 Oct 2020 13:15:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e7610d9-ed8b-4f9b-59e6-08d875c3709a
X-MS-TrafficTypeDiagnostic: DB7PR04MB5995:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5995F41A34D015F267E00B3A881C0@DB7PR04MB5995.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: usRcTucXWYA+Kc4KLtZpalq0IXr4eS7ZMmMS3WlPK/NIQfdb3u87CQOZjtB+3tIZyw8mXa0vJGeZaG3PsaV4ZBDMWetgdNX/uVQHBKGJHxmm+IzE7R+oqofge0LRAYrU6AAzWROP6XbTm6QEWYunUQoEtssF6IB6jdCRSOQmhnUFz7miO67K0gB7DkFsxzsSOImH4qDW5vf3+cuWQ5fy8nuxRU8ZmjDZYhnlIQr1u41yYl3J8xwdCZs+2A9ZP8Jl00fuYLDjfQhHySxOuQs+hEZi+nhJXHYka9qQMC2UAP9nOormx90smHJR9H/y29NMV8WP6Y68OfBCJHIwbTcOqhREwyTQgBEE1zV0Wgz4ctq5mwCXTP2+5PagfumhD9C+LGaPl/789QmWSHT9cmkiG0B1+E5pABfUSbwHWdSs20A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(8936002)(5660300002)(66946007)(4326008)(478600001)(316002)(8676002)(36756003)(66556008)(66476007)(52116002)(86362001)(6506007)(2906002)(2616005)(83380400001)(956004)(9686003)(6512007)(6666004)(186003)(16526019)(26005)(69590400008)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pqLlaIw6eodKONHoW37mYyOxfuiwlFnB0FDp8FbH/J6BpUk22TczjZkK51qh1SFRNyPm2hqz6BmhlClmG6PkazwAO1i/pgpfStVM78i24MiWlNpdF8gte5hyy8j7niY+ovmQhyQJoIBto1M24YsMKCU687Ed5vlDJ4s2VSoU/T2z3HVCruuRJwl4C3nVvIxYR62ZH26wFQcpW2uXj8k+OJXbcnndP8EckIkTRJ52a8Gt3/Rx5RD+ut33osFKbm8jwqE8Q1yncw3Rw7AZplcHRElRiVXW7qVTPKhSiYkUktru9hgDxe1QnJIMKrOSMTGenRpH4v7B8ZZ6zrWHTqV3sg7svynu7yFWY3DzOmGlWcugoZO2nxPJYutESPqLH61qr4p3VqhqRdB90BrxxLfCBHiM7ccCTIeg8LYXcVYYucOcDj6wnip/I63vmFu7kYBjGODhaRS0wqstDAedGi918qDxmHVX/WQt5r5yV7XFtcBrAvmnTlJ+QtrBnI23fIpHEzwaqSyf+xSm3sC18WTkAMq+U/z1t2ANY/YUnY9xXNI9ArUQ/ayqspiUx73SrwVXTrxFAppf0m77PJPlt0nc89xyGV54RiQAuYQ/0KAg9A62NwlJ3waFcg9oj0stwucogiXkOZm6A0M7fJhJfi0KNg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7610d9-ed8b-4f9b-59e6-08d875c3709a
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 13:15:54.3910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lOdLdtANWSiJast+iYdw0ISh0dKDm+80FXTAP2WnsjBT5Fi7delvGBKxKpwSXFJr4ud3YQSWP4ixWY+7XlQWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5995
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

noc/axi/ahb are bus clk, not peripheral clk.
Since peripheral clk has a limitation that for peripheral clock slice,
IP clock slices must be stopped to change the clock source.
So we added CLK_SET_PARENT_GATE flag to avoid glitch.

However if noc is marked as critical clk peripheral, the
assigned clock parent operation will fail.

Fix to register as composite bus critical.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mn.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index e984de543f0b..f3c5e6cf55dd 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -431,7 +431,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_CLK_A53_CORE] = imx_clk_hw_mux2("arm_a53_core", base + 0x9880, 24, 1, imx8mn_a53_core_sels, ARRAY_SIZE(imx8mn_a53_core_sels));
 
 	/* BUS */
-	hws[IMX8MN_CLK_MAIN_AXI] = imx8m_clk_hw_composite_critical("main_axi", imx8mn_main_axi_sels, base + 0x8800);
+	hws[IMX8MN_CLK_MAIN_AXI] = imx8m_clk_hw_composite_bus_critical("main_axi", imx8mn_main_axi_sels, base + 0x8800);
 	hws[IMX8MN_CLK_ENET_AXI] = imx8m_clk_hw_composite_bus("enet_axi", imx8mn_enet_axi_sels, base + 0x8880);
 	hws[IMX8MN_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite_bus("nand_usdhc_bus", imx8mn_nand_usdhc_sels, base + 0x8900);
 	hws[IMX8MN_CLK_DISP_AXI] = imx8m_clk_hw_composite_bus("disp_axi", imx8mn_disp_axi_sels, base + 0x8a00);
@@ -439,9 +439,9 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_CLK_USB_BUS] = imx8m_clk_hw_composite_bus("usb_bus", imx8mn_usb_bus_sels, base + 0x8b80);
 	hws[IMX8MN_CLK_GPU_AXI] = imx8m_clk_hw_composite_bus("gpu_axi", imx8mn_gpu_axi_sels, base + 0x8c00);
 	hws[IMX8MN_CLK_GPU_AHB] = imx8m_clk_hw_composite_bus("gpu_ahb", imx8mn_gpu_ahb_sels, base + 0x8c80);
-	hws[IMX8MN_CLK_NOC] = imx8m_clk_hw_composite_critical("noc", imx8mn_noc_sels, base + 0x8d00);
+	hws[IMX8MN_CLK_NOC] = imx8m_clk_hw_composite_bus_critical("noc", imx8mn_noc_sels, base + 0x8d00);
 
-	hws[IMX8MN_CLK_AHB] = imx8m_clk_hw_composite_critical("ahb", imx8mn_ahb_sels, base + 0x9000);
+	hws[IMX8MN_CLK_AHB] = imx8m_clk_hw_composite_bus_critical("ahb", imx8mn_ahb_sels, base + 0x9000);
 	hws[IMX8MN_CLK_AUDIO_AHB] = imx8m_clk_hw_composite_bus("audio_ahb", imx8mn_audio_ahb_sels, base + 0x9100);
 	hws[IMX8MN_CLK_IPG_ROOT] = imx_clk_hw_divider2("ipg_root", "ahb", base + 0x9080, 0, 1);
 	hws[IMX8MN_CLK_IPG_AUDIO_ROOT] = imx_clk_hw_divider2("ipg_audio_root", "audio_ahb", base + 0x9180, 0, 1);
-- 
2.28.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB21C29496A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 10:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441036AbgJUIhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 04:37:19 -0400
Received: from mail-am6eur05on2075.outbound.protection.outlook.com ([40.107.22.75]:22112
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440607AbgJUIhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 04:37:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SI+YewFD6u7VTOfKbdyWdpgLf9CiA7BOaYzxYc9R6toB5kD25rsVas3EKgrdOHQOzog3VZGxNRXqprNhRS+g5b1SzpCARpKGNIpCN+/pBp7pjSDDnYWiSlnUN1LyaKA84+Fm2C2+s+yjizc/c813wEcRUNcHtcgFZW/NVAfX8SOyG75RB7MpF0Z1zf/zQuzI88AovJIRIDGzznKnIacWHmcursJ8D+YBNUzRDeFc/Khn6z8Q8Ehxt/0EK5yNqKv9bhMHqxIz/Cu/QFjW6Bpf+peU+g/huXr5UyhvLz8q/r691ZlVYBX3jzQrlfgOsAjzojt+YNtJiuhfH0OqUAeCHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owP+ftRfPGXBy+W051+XVxhCLpMtPSVGkk2farXvbcE=;
 b=nP0e17otSN3YtzfrWmIXzT9aSmM8ifHCSaQV80UlQ5yJDvwV1m0HgnL/c+8yO4Ewt3Vy0rNgjr3UBpKvKvVFvgrjD4KCZihnxhvWxl72EqS37iMUM/3l4B6YNPSr+BbPXonpcqg2IsubnIZFai9tEpF8GItjSIg0x3di/+SfDqD2kxbqHo1f4bRje/HojCdtMw2VSD4NNX5cAE1EE+ySUpNPuhLgm7QyfEKunCF7aTv8bhf73aDIu7x2Q5oBUfLzkYZPJwOzAKKZSYEcjyP4TMKOSb34t8oRNrGhfMgROIe5k/XKw+G8/byapnxkzZdWn1FT4g3AQjKq3N+unEXIQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owP+ftRfPGXBy+W051+XVxhCLpMtPSVGkk2farXvbcE=;
 b=S+7WxWAUNW0wiVz7TXmAMSj8Dw81Y04UQFbM1H6iVPqmTq9jo5q9JfpEB4PE5mWtShY1TbvlCth8Sr6eVCd6CDXLekh90AzYATf934UlwCW8TtiCGJO6PpDtGvwkOzRKJLN4vR5i3r1HrnTGKjGViOjJwLdcey0jMtsdiUqnx2c=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4636.eurprd04.prod.outlook.com (2603:10a6:5:2e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Wed, 21 Oct
 2020 08:37:09 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 08:37:09 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/5] clk: imx8mn: fix bus critical clk registration
Date:   Wed, 21 Oct 2020 16:31:33 +0800
Message-Id: <1603269094-29367-5-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603269094-29367-1-git-send-email-peng.fan@nxp.com>
References: <1603269094-29367-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR03CA0155.apcprd03.prod.outlook.com
 (2603:1096:4:c9::10) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0155.apcprd03.prod.outlook.com (2603:1096:4:c9::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3499.4 via Frontend Transport; Wed, 21 Oct 2020 08:37:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9acd1a39-fb27-4ff6-6099-08d8759c7f7b
X-MS-TrafficTypeDiagnostic: DB7PR04MB4636:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB463661695EAC05721A2AD066881C0@DB7PR04MB4636.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7fjisP0jNYloMqHHYeDXmoooj1aXIH6OgTG5hqY4O1LVv/F9Vk1p4wiQLH0pK05nLHo/46Q8lK+o+k4n8R9Jd3TxQJkfKfGFvA8US55i/jFOuo3wb34bDg+d//HHKRIikyv05TP5Ox6pRw7+M+e4RqNa+RbHjEVNj67AuX1ubuw5k/dwHgaFbB2KVsANqCEshdoRbGbud+HxCcwk8xHWjTWytAf6/OYPP9EEW6ea/cZk7E7lzmfv+KbERzjtreDxAEuQFuPYlwsXsCy54QpUBmvA/NnqvDwmyWIA63dtwLKCj1yNHUad5sSlv4RT300D5+yVpfwvtLDYhH5ebEXZlOL6nQedcK1BRSXxpi5oCKFQT4Os0VKQ+NlXfTkYOVT27f20uMpNb8iOBtnacA5anHrGhliqXkrapl5cj5zwAk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(8936002)(36756003)(83380400001)(52116002)(2616005)(16526019)(6666004)(26005)(69590400008)(6506007)(956004)(6512007)(5660300002)(186003)(9686003)(8676002)(66556008)(4326008)(2906002)(86362001)(66946007)(66476007)(478600001)(316002)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7Fr6r+RyShhnxo3wRppn1jv85vAOciXYJwsvj+TWOys/1uSat7d7jujGuNwXZrwcnKxQ/AO0y9hWui/ELo4l4AFIDlv9PH64GHMZ2gndpE15OV8qITePEeTBpwSLnIWhuZYfDgFU8kishvvtDW4T/OMqKcg8P0cm+kz0aE5DqA3p1swdwN5jkVT1AuZX+ywCG+BPm5ppeXVoft4IsNmFgImSYw7CwFSO/4oD4xUHZdhwccHIMX5FvcuWGh3Ipgj2k1o2Im3/XryFWNF/zn0tW41R/Rbhx1k0jxGn7LOFLtZD8uh6tqv5gsn/vf3kD4Wgjzjw6l4REp5yLxXcN5eyDZjKl9VAkT1FNQIyLsin9HnjDrZkjTLy3DdkrjmitVUXufZ9Hx8rmB89jNR6wu2mvop59JeDaD4Y744uC7iP+rUbexXhvdNs+4MX22yWUEKjaulSJ7lph7q9UggFyEZ7bQ3mQn4W/LPLrejOXFp1x/mg44shlquau3Hm/Ap+xN5LPub0x5s/EITmEK5NpT9SyRFZc6yjp9O2YV8nXS09wvUuoIwVklWaerW39xawNazBcx8dqGxmmxFZZsKwHqAsE683nH2cCIJdkS9su+ItBaVj3juPvde1x6YQ7DFWc7a8QafFyEzao9ZTpL0SlDaFWA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acd1a39-fb27-4ff6-6099-08d8759c7f7b
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 08:37:08.9264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJ4J9CrTdDzdF2A9AIrz3CBAR2xK/KzWvPfQ8ZCNqyVyH3rKyZMgUsWA2MswBMAg8leImEIpp6Q2ZT944bbdhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4636
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


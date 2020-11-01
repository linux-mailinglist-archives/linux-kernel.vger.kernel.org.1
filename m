Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DAD2A1D9B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 12:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgKALaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 06:30:04 -0500
Received: from mail-eopbgr130079.outbound.protection.outlook.com ([40.107.13.79]:60416
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726347AbgKALaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 06:30:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OK9He4wXA18U6ZB3uBz95RUKkXdV5G73/1aK02gRhrWi3kfHNNL59FQskPRH1CYqYlIDWAGk7pewdWRMiPacdbPCMlxiTqDUpI2IBjtYmBvRciEbyrUtQc+edlInaHrik5I+CixpZxqgNKirL3gGgMkFlYcaPcu+fgazlSXniNzeQsa3KHXE3RJP0M3nUcjjLZN6IgIUIGgNTqau8zI2YW6lpj9AZNedypESRpIrf8NhAZa+JjINFYpMqbkP/iLOS0aw9PI6vqjTaN10mv1Vlfqw5lozJdXSJ0vnND9S3x9c91EhFWo+oe3QWId8gG9GulX662Pva3QA3HIyY4ANdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXH3l6jKvB2iel5Ew/1ZqjKB1O5olp2lBfG2Hok5sa8=;
 b=mqFjsqeRWp7yeSBuqi3yLBRmB4E8yCE52BlVXsxXzuN8PBcJt7tTIt5niOCTvxJZcmXq7Gspzp6CtW4i4wnyXkbqown5u/5QrK5FqVY4MWK2R9fiIohuTOBWnIYmPPdMI5KC6O+QcLEpap/oFMhmM9CRboSywQLjsJC1208UesI30W8JX7+xmqg631WrLrmCr3HyhyytLtstqk/jPqwHlX3prL5xksvkT2mlYuEHGTV4fQeynxrSw+mWQ8vQVDntwJeTLQa4x/F0SrGb5uIMMjUTAQfOVnI09nkcgE51/TNjg0CC7tgwB6+WKiNwPAU4XQy2QEgD71EKH5ql5h4mbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXH3l6jKvB2iel5Ew/1ZqjKB1O5olp2lBfG2Hok5sa8=;
 b=mceC+MwbinIwdKdm6qkW09sAdKwWKjAqBV14YDJ+T+WFeSWfjH+ZG37YVeSo6cEL7KSeZYaME1Rx4ZwicnweUuL4ZCBaz8b6bMJLqq3avKu0gR8c9O1+Rru4BjBtX8+JvAKzkKgHs8u9pL2lMXmJbatRMgsPLERzCA4z8dw8GUQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7657.eurprd04.prod.outlook.com (2603:10a6:10:1f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Sun, 1 Nov
 2020 11:29:51 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3499.029; Sun, 1 Nov 2020
 11:29:51 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3] clk: imx8m: fix bus critical clk registration
Date:   Sun,  1 Nov 2020 19:23:54 +0800
Message-Id: <1604229834-25594-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR02CA0091.apcprd02.prod.outlook.com
 (2603:1096:4:90::31) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0091.apcprd02.prod.outlook.com (2603:1096:4:90::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3499.19 via Frontend Transport; Sun, 1 Nov 2020 11:29:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 837923e2-3e60-4fa6-6f8b-08d87e59723f
X-MS-TrafficTypeDiagnostic: DBBPR04MB7657:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB76576462C4824EA885BA607788130@DBBPR04MB7657.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ekfpku3yqty83+QNbodK/JABCEnzUJO5bdJvNnK0K6gfhw67elzshXfZ7/tYIjN8CJ+kPALTSnX4gvBgb5BotO1qXXI4OD8S1mKx8Y2mjMlQ9WpiZOOzyIM8eoMHUUGP4kFcU6YMv/67HFTMXSeELOyJvTw/tc2pWStBWUPIfOwSlyxIAN6a4ioi4s7PgP1wE73I76mA7jT2ob3TfyNdvjLGli95H04WHclgaiyhMezF8Ut5snVl4VsAE3gyEnm+5mP4OUiIie4DxDMJY4KD/bqcGJtWVLSNouFAozXdhjudn7Bp6XKi5FN4alimCUafo2/VUwN5b9neseCp6LsbtRXe2k86aYXlyxQmglsXm4/CLZY7DNyij3LzPHxmO76KnRlpqomlYJZpcozwz7YX6y2d5mmAAh1huO8f9bKALaE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39850400004)(376002)(366004)(6506007)(956004)(52116002)(86362001)(83380400001)(478600001)(26005)(186003)(16526019)(316002)(2906002)(2616005)(4326008)(69590400008)(6666004)(8676002)(36756003)(66476007)(8936002)(9686003)(6486002)(66556008)(66946007)(5660300002)(30864003)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ASwUSzna4Nm2IZQBVJiWm26pcxARaYLDBv5mbI3cHuTq1X4BBTbxhRlzRpii0UMF4z0wplH/iEMCm0TOyWAgoTMl6FH0ANHrTb8lgTEDiCkoCc20xWeCZiQkuJMVMDnssdJnFBAhTdCJheZyDVxd1qVmx4injQ6IzRrwWUSHqP6pXL/SW301f/lLk/f4nbEyZzXpaMAaStj1DRkjd6zWuBsJ95ZXbm2jO6bb39ZRU6oipLWyO7YNbkRdSbzOhonpkd1QHeRHC7swib7O79BdrIIxBksVhE1RZ+gpDDr7yjBL+UNay0w/iJbgXnr6XfXP7B3pwNsT9c3exci71nVCeD0MdRpBtuwYjEqSUM/gappZxnlPjW3XUo1yihOXJv1AziaMib0JK464fp8ECWJywtlks4xn/3HPm6qQUGCaNvoYUXLTH1M0Fw7PZVXhlQeoCqbhRvahYFM3gJPCbF7zZFfk+zg5tPINW6NAxLB6kIy9hLOkMt5Cz8AA9trfWUsXXi04JyDn1N6Hl48/MEfy8ZVm3XnW9wKBqh5qNUEK+VgwUC98vu1tv/v2JSkaHDf+JUtzYpdUb3WS/1HUYdoPo/ccOpX8/5QTLkzWYUzCTmE4vqaXBBtiT7hG0gWEno8TEARlQaeydNCI/Vs+hpPcKw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837923e2-3e60-4fa6-6f8b-08d87e59723f
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2020 11:29:51.0752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Gc0dMq2eKZPKXQyB1wG0NEsRUBVeqNgIhSdnJNALvVmJQPkMRlkUv9bjRXeH2a5sHzoBsvjRC0kRhF4sV45qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7657
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

noc/axi/ahb are bus clk, not peripheral clk.
Since peripheral clk has a limitation that for peripheral clock slice,
IP clock slices must be stopped to change the clock source.

However if the bus clk is marked as critical clk peripheral, the
assigned clock parent operation will fail.

So we added CLK_SET_PARENT_GATE flag to avoid glitch.

And add imx8m_clk_hw_composite_bus_critical for bus critical clock usage

Fixes: 936c383673b9e ("clk: imx: fix composite peripheral flags")
Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Reported-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 Add R-b tags.
 Merged the V2 patchset into one patch, no code change.

V2:
 None changed, sent wrongly.

 drivers/clk/imx/clk-imx8mm.c | 10 +++++-----
 drivers/clk/imx/clk-imx8mn.c |  6 +++---
 drivers/clk/imx/clk-imx8mp.c | 10 +++++-----
 drivers/clk/imx/clk-imx8mq.c |  8 ++++----
 drivers/clk/imx/clk.h        |  5 +++++
 5 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 0de0be0cf548..f358ad907299 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -443,9 +443,9 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MM_CLK_A53_CORE] = imx_clk_hw_mux2("arm_a53_core", base + 0x9880, 24, 1, imx8mm_a53_core_sels, ARRAY_SIZE(imx8mm_a53_core_sels));
 
 	/* BUS */
-	hws[IMX8MM_CLK_MAIN_AXI] = imx8m_clk_hw_composite_critical("main_axi",  imx8mm_main_axi_sels, base + 0x8800);
+	hws[IMX8MM_CLK_MAIN_AXI] = imx8m_clk_hw_composite_bus_critical("main_axi",  imx8mm_main_axi_sels, base + 0x8800);
 	hws[IMX8MM_CLK_ENET_AXI] = imx8m_clk_hw_composite_bus("enet_axi", imx8mm_enet_axi_sels, base + 0x8880);
-	hws[IMX8MM_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite_critical("nand_usdhc_bus", imx8mm_nand_usdhc_sels, base + 0x8900);
+	hws[IMX8MM_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite_bus_critical("nand_usdhc_bus", imx8mm_nand_usdhc_sels, base + 0x8900);
 	hws[IMX8MM_CLK_VPU_BUS] = imx8m_clk_hw_composite_bus("vpu_bus", imx8mm_vpu_bus_sels, base + 0x8980);
 	hws[IMX8MM_CLK_DISP_AXI] = imx8m_clk_hw_composite_bus("disp_axi", imx8mm_disp_axi_sels, base + 0x8a00);
 	hws[IMX8MM_CLK_DISP_APB] = imx8m_clk_hw_composite_bus("disp_apb", imx8mm_disp_apb_sels, base + 0x8a80);
@@ -453,11 +453,11 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MM_CLK_USB_BUS] = imx8m_clk_hw_composite_bus("usb_bus", imx8mm_usb_bus_sels, base + 0x8b80);
 	hws[IMX8MM_CLK_GPU_AXI] = imx8m_clk_hw_composite_bus("gpu_axi", imx8mm_gpu_axi_sels, base + 0x8c00);
 	hws[IMX8MM_CLK_GPU_AHB] = imx8m_clk_hw_composite_bus("gpu_ahb", imx8mm_gpu_ahb_sels, base + 0x8c80);
-	hws[IMX8MM_CLK_NOC] = imx8m_clk_hw_composite_critical("noc", imx8mm_noc_sels, base + 0x8d00);
-	hws[IMX8MM_CLK_NOC_APB] = imx8m_clk_hw_composite_critical("noc_apb", imx8mm_noc_apb_sels, base + 0x8d80);
+	hws[IMX8MM_CLK_NOC] = imx8m_clk_hw_composite_bus_critical("noc", imx8mm_noc_sels, base + 0x8d00);
+	hws[IMX8MM_CLK_NOC_APB] = imx8m_clk_hw_composite_bus_critical("noc_apb", imx8mm_noc_apb_sels, base + 0x8d80);
 
 	/* AHB */
-	hws[IMX8MM_CLK_AHB] = imx8m_clk_hw_composite_critical("ahb", imx8mm_ahb_sels, base + 0x9000);
+	hws[IMX8MM_CLK_AHB] = imx8m_clk_hw_composite_bus_critical("ahb", imx8mm_ahb_sels, base + 0x9000);
 	hws[IMX8MM_CLK_AUDIO_AHB] = imx8m_clk_hw_composite_bus("audio_ahb", imx8mm_audio_ahb_sels, base + 0x9100);
 
 	/* IPG */
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
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 12ce4770f702..48e212477f52 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -557,9 +557,9 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	/* CORE SEL */
 	hws[IMX8MP_CLK_A53_CORE] = imx_clk_hw_mux2("arm_a53_core", ccm_base + 0x9880, 24, 1, imx8mp_a53_core_sels, ARRAY_SIZE(imx8mp_a53_core_sels));
 
-	hws[IMX8MP_CLK_MAIN_AXI] = imx8m_clk_hw_composite_critical("main_axi", imx8mp_main_axi_sels, ccm_base + 0x8800);
+	hws[IMX8MP_CLK_MAIN_AXI] = imx8m_clk_hw_composite_bus_critical("main_axi", imx8mp_main_axi_sels, ccm_base + 0x8800);
 	hws[IMX8MP_CLK_ENET_AXI] = imx8m_clk_hw_composite_bus("enet_axi", imx8mp_enet_axi_sels, ccm_base + 0x8880);
-	hws[IMX8MP_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite_critical("nand_usdhc_bus", imx8mp_nand_usdhc_sels, ccm_base + 0x8900);
+	hws[IMX8MP_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite_bus_critical("nand_usdhc_bus", imx8mp_nand_usdhc_sels, ccm_base + 0x8900);
 	hws[IMX8MP_CLK_VPU_BUS] = imx8m_clk_hw_composite_bus("vpu_bus", imx8mp_vpu_bus_sels, ccm_base + 0x8980);
 	hws[IMX8MP_CLK_MEDIA_AXI] = imx8m_clk_hw_composite_bus("media_axi", imx8mp_media_axi_sels, ccm_base + 0x8a00);
 	hws[IMX8MP_CLK_MEDIA_APB] = imx8m_clk_hw_composite_bus("media_apb", imx8mp_media_apb_sels, ccm_base + 0x8a80);
@@ -567,12 +567,12 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_HDMI_AXI] = imx8m_clk_hw_composite_bus("hdmi_axi", imx8mp_media_axi_sels, ccm_base + 0x8b80);
 	hws[IMX8MP_CLK_GPU_AXI] = imx8m_clk_hw_composite_bus("gpu_axi", imx8mp_gpu_axi_sels, ccm_base + 0x8c00);
 	hws[IMX8MP_CLK_GPU_AHB] = imx8m_clk_hw_composite_bus("gpu_ahb", imx8mp_gpu_ahb_sels, ccm_base + 0x8c80);
-	hws[IMX8MP_CLK_NOC] = imx8m_clk_hw_composite_critical("noc", imx8mp_noc_sels, ccm_base + 0x8d00);
-	hws[IMX8MP_CLK_NOC_IO] = imx8m_clk_hw_composite_critical("noc_io", imx8mp_noc_io_sels, ccm_base + 0x8d80);
+	hws[IMX8MP_CLK_NOC] = imx8m_clk_hw_composite_bus_critical("noc", imx8mp_noc_sels, ccm_base + 0x8d00);
+	hws[IMX8MP_CLK_NOC_IO] = imx8m_clk_hw_composite_bus_critical("noc_io", imx8mp_noc_io_sels, ccm_base + 0x8d80);
 	hws[IMX8MP_CLK_ML_AXI] = imx8m_clk_hw_composite_bus("ml_axi", imx8mp_ml_axi_sels, ccm_base + 0x8e00);
 	hws[IMX8MP_CLK_ML_AHB] = imx8m_clk_hw_composite_bus("ml_ahb", imx8mp_ml_ahb_sels, ccm_base + 0x8e80);
 
-	hws[IMX8MP_CLK_AHB] = imx8m_clk_hw_composite_critical("ahb_root", imx8mp_ahb_sels, ccm_base + 0x9000);
+	hws[IMX8MP_CLK_AHB] = imx8m_clk_hw_composite_bus_critical("ahb_root", imx8mp_ahb_sels, ccm_base + 0x9000);
 	hws[IMX8MP_CLK_AUDIO_AHB] = imx8m_clk_hw_composite_bus("audio_ahb", imx8mp_audio_ahb_sels, ccm_base + 0x9100);
 	hws[IMX8MP_CLK_MIPI_DSI_ESC_RX] = imx8m_clk_hw_composite_bus("mipi_dsi_esc_rx", imx8mp_mipi_dsi_esc_rx_sels, ccm_base + 0x9200);
 
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 8265d1d48af4..06292d4a98ff 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -431,7 +431,7 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MQ_CLK_A53_CORE] = imx_clk_hw_mux2("arm_a53_core", base + 0x9880, 24, 1, imx8mq_a53_core_sels, ARRAY_SIZE(imx8mq_a53_core_sels));
 
 	/* BUS */
-	hws[IMX8MQ_CLK_MAIN_AXI] = imx8m_clk_hw_composite_critical("main_axi", imx8mq_main_axi_sels, base + 0x8800);
+	hws[IMX8MQ_CLK_MAIN_AXI] = imx8m_clk_hw_composite_bus_critical("main_axi", imx8mq_main_axi_sels, base + 0x8800);
 	hws[IMX8MQ_CLK_ENET_AXI] = imx8m_clk_hw_composite_bus("enet_axi", imx8mq_enet_axi_sels, base + 0x8880);
 	hws[IMX8MQ_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite_bus("nand_usdhc_bus", imx8mq_nand_usdhc_sels, base + 0x8900);
 	hws[IMX8MQ_CLK_VPU_BUS] = imx8m_clk_hw_composite_bus("vpu_bus", imx8mq_vpu_bus_sels, base + 0x8980);
@@ -441,12 +441,12 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MQ_CLK_USB_BUS] = imx8m_clk_hw_composite_bus("usb_bus", imx8mq_usb_bus_sels, base + 0x8b80);
 	hws[IMX8MQ_CLK_GPU_AXI] = imx8m_clk_hw_composite_bus("gpu_axi", imx8mq_gpu_axi_sels, base + 0x8c00);
 	hws[IMX8MQ_CLK_GPU_AHB] = imx8m_clk_hw_composite_bus("gpu_ahb", imx8mq_gpu_ahb_sels, base + 0x8c80);
-	hws[IMX8MQ_CLK_NOC] = imx8m_clk_hw_composite_critical("noc", imx8mq_noc_sels, base + 0x8d00);
-	hws[IMX8MQ_CLK_NOC_APB] = imx8m_clk_hw_composite_critical("noc_apb", imx8mq_noc_apb_sels, base + 0x8d80);
+	hws[IMX8MQ_CLK_NOC] = imx8m_clk_hw_composite_bus_critical("noc", imx8mq_noc_sels, base + 0x8d00);
+	hws[IMX8MQ_CLK_NOC_APB] = imx8m_clk_hw_composite_bus_critical("noc_apb", imx8mq_noc_apb_sels, base + 0x8d80);
 
 	/* AHB */
 	/* AHB clock is used by the AHB bus therefore marked as critical */
-	hws[IMX8MQ_CLK_AHB] = imx8m_clk_hw_composite_critical("ahb", imx8mq_ahb_sels, base + 0x9000);
+	hws[IMX8MQ_CLK_AHB] = imx8m_clk_hw_composite_bus_critical("ahb", imx8mq_ahb_sels, base + 0x9000);
 	hws[IMX8MQ_CLK_AUDIO_AHB] = imx8m_clk_hw_composite_bus("audio_ahb", imx8mq_audio_ahb_sels, base + 0x9100);
 
 	/* IPG */
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 3b796b3da249..1d7be0c86538 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -549,6 +549,11 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 			IMX_COMPOSITE_BUS, \
 			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
 
+#define imx8m_clk_hw_composite_bus_critical(name, parent_names, reg)	\
+	imx8m_clk_hw_composite_flags(name, parent_names, ARRAY_SIZE(parent_names), reg, \
+			IMX_COMPOSITE_BUS, \
+			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE | CLK_IS_CRITICAL)
+
 #define imx8m_clk_hw_composite_core(name, parent_names, reg)	\
 	imx8m_clk_hw_composite_flags(name, parent_names, \
 			ARRAY_SIZE(parent_names), reg, \
-- 
2.28.0


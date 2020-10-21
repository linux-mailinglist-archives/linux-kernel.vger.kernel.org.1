Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9436229496C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 10:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441047AbgJUIhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 04:37:32 -0400
Received: from mail-am6eur05on2075.outbound.protection.outlook.com ([40.107.22.75]:22112
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2441027AbgJUIhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 04:37:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGzn9uQwIY9rENQmUXT0sCJoiKZG3z6pxdZRc4AKTXqvJa4HmLTCsIqhJnAQ9LQWNCsR1OUsYYnkRSdlGvRZamD5jO67tykNvj1X+SaUnWvFv3cEswALO+G2CLeVSu9U7K8TQlv2TcjacrA1ltZKqFsehKM1j7Mav/ofAW9W3ZECJegpuAQc8mgX+7klw6yqPRGEgywkjKg24wtCHR4RoL1BWQwG4XXXkCRxvNEwlOtmAlDhvTyVmcpeWzkCW2x4nutPkspGbolkNLOYEv6U5HPoW47nLti3wcCBD/NiKo6RiYpEF2Z0meR8tlyoKl2N+WKejQBm9nAKxKzIbuS5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAmWjAC2ceW+A8L2k1i/ZBYrzgXodgnO6OQiYKr8I4A=;
 b=BQW6Aa/Aku5w6/6d0oWF2r4YH+A1cFJHLUxtZpf91sggj+SETaezv4B3doAzir4ES7o1/rzWxs40KQnIEre1R7yIfflDQzYRNnHzBnXWrvfBRxW+78z44wbrh4mWh5T9iGbGPfu/zzt1hneNqXs9IAYJ2F2YKnLbBO7/jzlpVSVMXGTUcQHsTzFyumEwuObl/6ioNEK4xeFj8Y3A9NH9iQr+1MoQ19tzRZ6mmJ+KpcA/URrslY6IWElXty+u6bcGwjaX970UmJ2HMQG8P7fG+BZYC+a/qHxlEbquQY4/tjrWYRHYaou5EZyuCN1/l9wPcdYwMxsl66lDwW8/4KSIOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAmWjAC2ceW+A8L2k1i/ZBYrzgXodgnO6OQiYKr8I4A=;
 b=HtnsCF17oeD+guUNz8CBW/UG3XBS4oa3vwGB7g5WbO1WEWcowQEo7TIBsTwPUROQyxuzclLUDX4C0YSgE1Cg7sennlegrDyA8ohYwwlreg8PpFtAokzVJ0+yDRHrpW1L+ptGXWDvvK+FmSzN+T4Oi3TZ3immvs1OC1xqLAKf6gw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4636.eurprd04.prod.outlook.com (2603:10a6:5:2e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Wed, 21 Oct
 2020 08:37:13 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 08:37:13 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/5] clk: imx8mp: fix bus critical clk registration
Date:   Wed, 21 Oct 2020 16:31:34 +0800
Message-Id: <1603269094-29367-6-git-send-email-peng.fan@nxp.com>
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
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0155.apcprd03.prod.outlook.com (2603:1096:4:c9::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3499.4 via Frontend Transport; Wed, 21 Oct 2020 08:37:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8bee661f-c0c0-4c9f-4c3f-08d8759c81e6
X-MS-TrafficTypeDiagnostic: DB7PR04MB4636:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB46360BF6308137D86A8C6385881C0@DB7PR04MB4636.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EwC0NgmuZI3I+ZsMP9qfRxa0AiBUq2IYiwrh21X09jBqsYkklWVKhSBL25iP/ADSmTDNMtC8QDk4PRcEyyQ3koGNoMv8xn01252VOLxhMgIEc6p0n8/N0Xw0DZkgG2uN6gxxiX2paVXfqDXRhP9MWtiSsCY7MIxf28GwOPiOR+afwHY7UiCpimpsCIFh541+fb2aU2hhieHOUG855i/JRa1tu8SOhmCiSdGFx5FYps2sw4e5b4d9t+82kU0DkcCu2daKBqUvTuJTXiLStdjLUIlDqofLp4KDEsoSzt2NAPbtrqG3BtgBbNKQOHsYFOmBQYkvO39fd0Pjq5wsMF31RpE5GqsmQY9P7OGW0LT7EwPmCOIXewarY9M4HTeO01kPPxNqSxBvgy6QZXS2SGwRTWMCOieJp/m48zrGvBoOvpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(8936002)(36756003)(83380400001)(52116002)(2616005)(16526019)(6666004)(26005)(69590400008)(6506007)(956004)(6512007)(5660300002)(186003)(9686003)(8676002)(66556008)(4326008)(2906002)(86362001)(66946007)(66476007)(478600001)(316002)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: kii9USdaNvQYHBMlAXiC8zDYrCzJoUzMk7tRdT/6v/oIQf7/M3hCCfOuogHhMFELjy2l4tLvu6oRjIZkvP0rQwoKx8xy+PrkxZLN59VtcExOSJMvypRaNZLyKidPovwZJM1Lu+B8qf6fjTcLKkR+qSiRqKayRW7Jl9ZyETufnwHOq4hOJmLoI49yMBaOJQjm1Xr63cEziaSm1i7eKcWyQY/oeCNVkwi+/YSiH13NRlISZM62MbPwopTFnp8VnRJhHBNqrPXfQ+OC/81LyecsnLF41emVgu3sf/SveJCyXzaXwrFimydtGzNWs/nTmGcX7bNesMAj8zhtexNvGl02SP0Hx1OBFUzCQQbjrBjUt5qw5jqoeYCUymUGdepXDBmoKpmUo6353nwjTx6J8J+jmj7tohYRkf/FROxUy21aXlI8E5HAVTYkXk8NmFGB/i99LBQHfpWxHPFYUENtQsRJ0B2NCFM+SJcEjBIjv/lHNU9U1B1ulj37rzjI6uZZvv8oLlaoVXn5O/6/joTKjhw5HbJuWIpzA96UPrDVa4PpryHMJrHDpVZhO0G72YYll5Sy3mTWpwD37ABC+4khW4tW3Yd81rn02O/2j4hCKFp0PUjwUdSiSeIn7X3wgQv1hO6J6FSD4Asc1VKTpjlj0FofNQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bee661f-c0c0-4c9f-4c3f-08d8759c81e6
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 08:37:12.9915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbcF8/brmkI1UYxADYQs5HGXAsMlFIg4egXq5va7IGBO+hxLhk9EdqUMhePVUBK2furLtpx3XZomZS087JgBuQ==
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
 drivers/clk/imx/clk-imx8mp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

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
 
-- 
2.28.0


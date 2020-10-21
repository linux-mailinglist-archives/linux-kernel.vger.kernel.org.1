Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF56294D58
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 15:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442945AbgJUNQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 09:16:05 -0400
Received: from mail-vi1eur05on2059.outbound.protection.outlook.com ([40.107.21.59]:64352
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2442927AbgJUNQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:16:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+5zvQR8AIZfHrJjGH/KFUJ9ki2sn+q1gXmd50esG8QXo2EYTS38wE5UuEhXQtWlqfXzetfJEunk4H/KPY/MZKBoCricJgtZIYc3/6LJvIC/ZXlKw+rU2giuIsst5cPLVIsk70K0BARwTRfwjMEXDxy34XSGdql3aWoyKNcy06uUcuIU0U0DAg3nJkSna16lAiFGlAm92NWQJXFt+02Z9cJ4ShiyqkcGWdIkvuNfgbueAuTCDuHeXRb5WIKCWOwLzmIVnYOkACEhCfddliqVNwPqVDKcf2eUlUDrjJusSfrpDu8fK1/RGLsAxz3eCKiIDJv0+qL3u4xVv2DSPjU1XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAmWjAC2ceW+A8L2k1i/ZBYrzgXodgnO6OQiYKr8I4A=;
 b=AApUwBG0Bdhg26tx3Zcrd5AtDSfcyjYdxh/pRBQbdcSKXqTgMxUyYud5KxWpuLLzTSn3amOrt1jJwfeUSYKaRX/rtHWLrI1cX4JobwKmwAFTSdoZXVatPqpg2U8opPINf1I2BMLhrSLGowH/RJfDJe02AZ8Z3YN8rMjsUzJLzEjSQiVXFdT/UrThH4DaoF6+VfqTVssO/xYBzPO6jBH+fIfcgjc8S7e3TIo7vEQQiFhxlce2YQqAdkjlnX6VGIW8JkqF02i+fDra0SzZh2vjPG3PUFc1Kegk3BUOzO4f+siw+2Atpjqd9kMGlXxg3PD5rgCd8letjTAwtFOoj7ri/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAmWjAC2ceW+A8L2k1i/ZBYrzgXodgnO6OQiYKr8I4A=;
 b=ntlWMLKuJsRtX5iRA3XE1yqvGnDl2k+KeMoMOO/vWXxnsTibk8+wjn3Fw4cQcL5Hsre7RbwnLx0VM5XlnmrVhfk1nnPiznWzriCCQllQ8TikrFIr8fWU5FSjozErNyPQYMoiq6oADDkaxKR7xHBm7+MwmONbzu7B9dRloof0o1U=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5995.eurprd04.prod.outlook.com (2603:10a6:10:8e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.26; Wed, 21 Oct
 2020 13:15:59 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 13:15:59 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 5/5] clk: imx8mp: fix bus critical clk registration
Date:   Wed, 21 Oct 2020 21:10:20 +0800
Message-Id: <1603285820-30196-6-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603285820-30196-1-git-send-email-peng.fan@nxp.com>
References: <1603285820-30196-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR03CA0133.apcprd03.prod.outlook.com (2603:1096:4:c8::6)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0133.apcprd03.prod.outlook.com (2603:1096:4:c8::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3499.4 via Frontend Transport; Wed, 21 Oct 2020 13:15:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 51980df7-d314-45c3-a7df-08d875c3731d
X-MS-TrafficTypeDiagnostic: DB7PR04MB5995:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB599501286E90DC215B6FCEF9881C0@DB7PR04MB5995.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Zj3dUSGz8TQGeGVKO07HCIp7Y5G56urXmxj/+xQIaIhc+Sppbd4OfrLKe406cO94TuB4h/+MBXMlKJ5vkEPMeOaKcbFMGeJniPGAJ0UZwV3PlQG1tGPdoecXVhPPzJCjIvugsSLrh5irUCXHWV9uihqe5f49RWWNO1DVbysblVH1tmEm/r769ANyGRdR2IECWf08i78XU1c63WRyHvVcGUUaIk+3lg0ptfehdnFfH+pIVTmyPLnScDVhqIVGdhsFpPHwBZjIC3/MGjf+aDbteaWnJM2AsF9Ih/LZWgIRRoeEK78et3YdyQLSqKMumD4aKI9eKGCSAtHEtBshFZoCsEN1qo2SgaTqGfVfdbHY7pWRslFUVok/g9m8T3R5GEbnU9CwHEwYsjMSwKekiMcPpyFVna0/2e7W9PpXXWqVzs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(8936002)(5660300002)(66946007)(4326008)(478600001)(316002)(8676002)(36756003)(66556008)(66476007)(52116002)(86362001)(6506007)(2906002)(2616005)(83380400001)(956004)(9686003)(6512007)(6666004)(186003)(16526019)(26005)(69590400008)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8Lroq1MhGyTaHt9BsRIxBe7qv6ry3uVW3mpu+q1KHX0ovwalkNGCiwnbxoSRdAqWmpzV1otLALHQ0ctsyG2V9luEch0JMMlU+IP04U2LLwAu+m18ph15rOenVHOufVw6PfTbFxEMKkV/O7+dUVindJDK9oJhViwylR9QfYIwgVQ45eDT2CHAK32uTQ6/XYRqBKqxNhSIvPNgCwzjhaPoIU//1YIt8umhtB4K9wOteQidYE9SMciZWN4X0p0qRdasH5IPZl1Y15bdx7MvzMTeIQfZn6Z0eoyvtLC06VsoPmu5uPEZMXyC0kfoCZU9viS/5xxvddSquT05uAssg4e3cUwtV0J0uS/TtybqjGssy8bx16mWWufru7VHwBN6L/V8j0PaRGDxP2PUcSW8jCZ5aMXNpfde/SpKKwYeBk3hviWzkdMDPdkmcWCC4sYHV4zyFJ1HIqIMHurGFzZjRQSEy1aDEWUA0AV65aZa6wbGZc1jZsKMiB+33BgPjJvhMLgh+dg7AcCnAK8Kmv5zkvhsMc5HM7tnONlCMx/6tC/+o1RY5ZTek6QUOB3j+llyTAcFl1BFrfTWNE4ERGO+ponIrv1ZmqjWKqCvIzuYEDscDA9huI+ivRCU3NljY/5aTM3O2CAC76gKjbgGDXb9/Z/fFQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51980df7-d314-45c3-a7df-08d875c3731d
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 13:15:58.9418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSLSyP6Qve0nUYlIg5Jsm6CedyKB64UXGaiPX5LY+aZyQ6NlhHVhGdyL42wl88soGeNLEVO4QShfhqRAEoNqew==
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86F6294D50
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 15:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442916AbgJUNPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 09:15:51 -0400
Received: from mail-eopbgr50073.outbound.protection.outlook.com ([40.107.5.73]:32194
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2442908AbgJUNPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:15:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwCg/RQsYTFKyuzRlHoAkR5SxSj1rTDqMn3Dm+m/g6hMzZHTdtxczSbwN4A3gi4xYXqlIMZ4jImQLwYynsKiBsUC027n0WkiiUpgIlZzSUUzbx1kU8HUdgPgrp3xo6anEAMop6jqiYlMBTDvTqzJN8M56HMSlEyXmEGaygPk71TZHZe0h6nFGejYIUkG6KXmKH5fuznyuhBsyRCVZ0V/8fwl/0RlS2jqekeWD0pouSo9JOmJJ1fl9d8hz0tYZu2FOzCjRgOSlEQiQPYP1HRAUnv3kNt0vFaiGO/+vi1+m0fYCpW5HXIlusQzB8T1XdiA5DnfXtvbZdv0n/PceTTI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nl9FkLa0csOmTR9H1jJ3ma7EreWOQU+RKjYv5aIvuh8=;
 b=UjD3KvsweV+X/J/voD1lUlzo2SkBgO4uCN5NhR/QpNaFL27nZhH44glvqz88/ZebfMk5XG+c4zM7e5oUVTNep0C6qsqxdEouyLgY9eyPY9iqErxJ6cuzy+1gnD8cz9Mni53Q3istq4vNp7IJLD1RYwdnvpq/TmdbUXTJruZvp6LCIbEh01eE0t34UKTJZVDvcP0/N5JP5a4SlAlx06SgVuT9KYKEJdpbInP5+IHp5NLp8vaNnEjttMGyUAqRVm5Zj7n09Qyccp63UhrOhA6AHoCWlYoh9hp+R+98frdl64xXuNFQ5RDNTKxWs7dLDc2t1eMZUzE9ZubOI4t+PdzfDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nl9FkLa0csOmTR9H1jJ3ma7EreWOQU+RKjYv5aIvuh8=;
 b=a6aO+vGiIb8+TNVm0gGDQE3GiC59LTSpmN6J9OkIlcMlk8Jr49EUSFO9pnLC/MfGruTkm05ERfGmXYUYVfLUYMGestjudB2Pva2cm818MFiTB/3PcNBMzTSE0bnDaToAGE1lorEolj4fmyin7eeLxsy2Hf33vnrZQ1FeMxXDRjI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5995.eurprd04.prod.outlook.com (2603:10a6:10:8e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.26; Wed, 21 Oct
 2020 13:15:45 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 13:15:45 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/5] clk: imx8mq: fix noc and noc_io registration
Date:   Wed, 21 Oct 2020 21:10:17 +0800
Message-Id: <1603285820-30196-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603285820-30196-1-git-send-email-peng.fan@nxp.com>
References: <1603285820-30196-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR03CA0133.apcprd03.prod.outlook.com (2603:1096:4:c8::6)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0133.apcprd03.prod.outlook.com (2603:1096:4:c8::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3499.4 via Frontend Transport; Wed, 21 Oct 2020 13:15:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5b9384ed-6322-43d3-efd5-08d875c36b6b
X-MS-TrafficTypeDiagnostic: DB7PR04MB5995:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB59956F2D1BD9173D992A07D5881C0@DB7PR04MB5995.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QXyROQqc6xUnsldDpEueOFti5N+mZWOrVNmyOglMQYde77OV36gpQQQQCnXil5igeYk5uBlNV67piXqtmrmEK51/hpJHJKV4rWMjNLMfUPdfS8QChCyiQUSfFywzomRRa9Gd/c9nyKh+uMCnkwAtaTdlAZMslDh/MUUQwz3OFDKh4QIKBl8WteXdz6D1xKI8H9DP7V3dtUqfxd+Tu2+JdxhbqZt5XsDJXMbdZW0KYvTBCCf7aE+LaVKngeFqQ9vYFpVl8lHZzMdh1wYLLrvNljT/P9A54aIf5Gdz0SU4ryPvU/PRVuzEfQO7mjXAxGZrLRUOBia7Sx/JEhqKbFbHCilHBEayN2i4fwcV5NrK5vGgNBdJ4cVQU57Dgqox9mFY55iPK67noRdnMvLNdmOfxUs+I02A5jl1RdTYZeXhbco=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(8936002)(5660300002)(66946007)(4326008)(478600001)(316002)(8676002)(36756003)(66556008)(66476007)(52116002)(86362001)(6506007)(2906002)(2616005)(83380400001)(956004)(9686003)(6512007)(6666004)(186003)(16526019)(26005)(69590400008)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: PBrZhh2ItwrYG1EOCkc10i2n9hC1W9BDmnm+PNZXXL3B6kF3mLWC6zkk24IVe334fLwBCVJeQmdlHpSeihXz0DnXOEeRJlA1DDUZg5LKCezih3cHaXCTUxzru5dCJNUdCCIlv32ibQlB3FJCA2wqdXLIg2qzRNjlXkdbEac5Ch2MWkmO9ZybIwGdiVWvbNUWvKAE/MB2XS2RJuIUVaXpSjhbxFZjzOc9T9bjHwibNxPGpsCXMyakFC1Vhk3qAPQ3Ya7Y+/cxuWWiBD0O1Z7B6Z2m23/DgCoLNSgLOK2QzY+8Mtsk4fky8p/YtGKC1M0xEBp9/okbXSSrF2wLMfRaBpFoRfxGoPSTFVmgilEHIww1Y29jgMctlp8uUl3CYxI7XDbHRLME6DpmN9I3g8DJgSxXZWZoNAQqN6dSDVLNIpotRGNUndzvhxYVF4TpN0Hap7QxpxDuKH5Kp7Npj3L28fMgMscot82zKhsRWVmJlay44IdsVpDY3myTp1R5ecx12adbrDSBxDbSkdSQRJ2bEf9pVdgbIMetQk5xYYfNR+eetm9IdiX+NoXqR3YcVTgG/x+vt3HA7tLFHLZVZfSTwchOc+7Abx9P2fHPw4H3WG1ARmN2k3wT1vh9GW0ZnU0tJYnZDLlnEjVcEwkTI+htGQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9384ed-6322-43d3-efd5-08d875c36b6b
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 13:15:45.8381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqUMmeV0n3EgK15yX8sdG3AL4QJ15Lg/bsplnzG2izcetqNIMOcJ+xhu6gFWvYza19mVE2RxCJfJ1S3DGKWYjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5995
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

noc/axi/ahb  are bus clk, not peripheral clk.
Since peripheral clk has a limitation that for peripheral clock slice,
IP clock slices must be stopped to change the clock source.
So we added CLK_SET_PARENT_GATE flag to avoid glitch.

However if noc is marked as critical clk peripheral, the
assigned clock parent operation will fail.

Fix to register as composite bus critical.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index a06cc21181b4..28290e717d9c 100644
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
-- 
2.28.0


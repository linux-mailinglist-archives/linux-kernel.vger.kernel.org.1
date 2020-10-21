Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809E3294968
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 10:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441024AbgJUIhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 04:37:11 -0400
Received: from mail-eopbgr60044.outbound.protection.outlook.com ([40.107.6.44]:15054
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440607AbgJUIhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 04:37:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+1AUJXdLUCydx/KNU9FyVHBmVrNQSgNvtm+njjAw5vZFH5ZfNeMxyd2MlZ+zU3bTZjMllQMa5fenbX0orQBcTIgUyPmBvKVjwCaaVFm5FTe1u+6bNKoGcy87KQD9B5x+Qe7VeeO9xKocRumi9ldpuGzb83r1916OScxv3PPfZ3xqzJitP9TMruhtGfvepcHBnoXzAo4HFUmj0CxB4hjRi/iF2KHrnhHeIMWJ/mXOCoWmYq7gbi0/zD8awvS/2zt1WJzUVP4P1IOW1m/i5s/H4OL5BdxSyhO5qzgvwhUEBCdLLpdmPal45x6N5TxTSXJBpbRDV9ecceK3b+5EfoUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCr/GyqxcsNPxveAU84zLt1V/XRDFV1Uw/0VxQaEK6c=;
 b=fBMq1KNR2GYIS11MWOYIz49jEH+CSYJppTNRiAXTi/qGCrfMyopeM2Ie0VgxtpTDaBELDmOJMSIW2glYcfYi4MzQNkWsnzWnHQPV129QfJtub3e9GmVzoB7Zb8Rf+AOd3kvb2zm/RiXWpTEwiYbIe8bAcMFSx5Sb2IzsLN4fWOU7V5ZwB8Uj4v9GwA59SD9DbXhSF26i31JW4VZm1ZJVwaOIK0cniva27Gljnpwx6CmvtiayUMkYwYYVykZg7Ar0rwxWHi9nS4uG6Nta0CvZxVIlcGJxNkZGLFvN75iD+1hH1hDHD06LSlf4uykrLIMoNicnrCVevOmNhQgjxl7W8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCr/GyqxcsNPxveAU84zLt1V/XRDFV1Uw/0VxQaEK6c=;
 b=Wy3m4aoGXKvRNLHq//X6Dd+Quyp4j0z8tIIdT3ojgr/qyJgZCpDgwguxTCYG9XYgJndmdmlIJL/wWW0QxWiY/CusKeYoQ7zk5R2DXbERJsh5BdNKy30E+RIaAM1UyQZULkpWXPXQvzEDR35mTazrK2ZmS0rWwkDdLqffqGX4Jws=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0401MB2376.eurprd04.prod.outlook.com (2603:10a6:4:51::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Wed, 21 Oct
 2020 08:37:05 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 08:37:04 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/5] clk: imx8mm: fix bus critical clk registration
Date:   Wed, 21 Oct 2020 16:31:32 +0800
Message-Id: <1603269094-29367-4-git-send-email-peng.fan@nxp.com>
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
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0155.apcprd03.prod.outlook.com (2603:1096:4:c9::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3499.4 via Frontend Transport; Wed, 21 Oct 2020 08:37:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 71de34b6-a80b-48cc-dde7-08d8759c7cfb
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2376:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2376CF20E7AEC1F4F4E5BF1D881C0@DB6PR0401MB2376.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdSv8T5BYZUlBA2JSgJAwhV/ftVWBf8KwKvttJJctc+CHPgR0Do+zzRGSM4YuEIW670utXm0mfjw+IMvcl8qp2Cp5/PI/vsP9oNrrfDF0ZuH/a/sAVyzILIsgWnnuPW5CdH++jJIzeJS6FELOE7QMQ8dZb6nPu+lxyQS5bXAkS4h2/FWYof07IvC5DlK3fZChm9YHmbNCAhxaPqFwwxBSCFhofAI89PDwmRtJCeJ250x2k+ozay8EwpWQ/Wj0G8sxRkUiQx/qxLvQjQn4Q9Z+L1qWreCw1R0527odBlGcC0DgWo3SjZ8EGKSNWfFIaxNJfwECfXKZ4TDd5IFDa02H0IXQ3aY0MJ3A8/vBs47/hk5+qkCj6XdMdpdtNIKa9f947LtiRbE5lxN5W65cGiWloJJ74xjlNBh4uRazdQDHK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(69590400008)(956004)(2616005)(16526019)(5660300002)(83380400001)(26005)(52116002)(4326008)(6506007)(36756003)(316002)(478600001)(8936002)(66556008)(8676002)(186003)(66946007)(9686003)(6486002)(6666004)(86362001)(66476007)(6512007)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: atzAIXMULM1lj/ZPUsTfvgVCBLZ14ayI0jvU9rQ2yBwoj9xqX3f2NxDYsOtVl9Y1VvsTYGhkoGhUcnGXFqp9AuQ/9/53paOsbmBBFOqHgMb6kzhchF87vO0svaj09wYddoQa8/R6SrZhgpL+FC1ixI4W9DUFAqkG7yK3G7WhVNOKdeksSiyNuPL06VUQn5/NIOHHmHoGO0JlEJ5qR3qTGZ7BVW4tt/BWGe0XG+WjdSDQ6stAi0F/AEdvCu5q7YdiNSmJ8lI5cRVcwkoFBrFPQ4N5vTMjTeYyTWkqn7SecKw1O3c6SFLuUdLyY17Bv0VgkXSrdsTGNbLWdtxc0Hml8DnsAk1hMxzSkZn+S3/2G0mK8wTd9DN4PUizSeTwun0QMAPheylcjP5ouWI6u0cK5SIejRqRHBO+fxqxf4hsAyIFKFe/+/zvm7O5tvv1qeozzgfz61tMQtnfy6CgrDpntMA8k7bPdqPKxwlS3UoZTLwZHHaHtEu1EpYKq0X4nyKfgsVFzjHc2XjcRIjCAcVNBf6cNBx1MEiDpKy1me41relzCC41oOhrAj+rsZBhuxU5SG77R8Jal44+20ShMzHWQg2yZ0p4TSqS/jYMIto/5MKluyv/0P2pcFnWvsiC+q13gI175NDDFW0xlNOnwH6CVQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71de34b6-a80b-48cc-dde7-08d8759c7cfb
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 08:37:04.7893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UUiyOo6A91c7A3ix26AnNt4i3CiRD3eTKJ+y/Q6YUsCaRPt6CeYwGiE74lMBF34E5aUJ/aFOXcKjQjRp/Vs7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2376
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
 drivers/clk/imx/clk-imx8mm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

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
-- 
2.28.0


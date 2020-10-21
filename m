Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1CE294966
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 10:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440944AbgJUIhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 04:37:06 -0400
Received: from mail-eopbgr10067.outbound.protection.outlook.com ([40.107.1.67]:59471
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440607AbgJUIhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 04:37:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7P4wPR2eZjf/pOd3NNsM5scOHiXUxf/iRsTwvRef7y8M522RAr6hqSqPQm6PEPPop+EMTYn+pjDJi/1ZgFIBMk3ZhVPvrsrS2C4SxhBf42DowOpXPIKUB0l7Y7YQT6WLTe6ozkp/ys9AAu51NvAK8bg7jWMk6Bm+9iBRLEkZMME95Jigb+LbxuGqlyoPUBtpvc6MknoaT8+KoH3gV4P0C1DrYsEKv4DsqGqN+WsPPDLWE64j5fxHHLCdNIpPntD6GWUKjNfodgYrdJ6ww0RhEG1GzXAHarWa7UJgTQX4+A3ak/KkQVpEDN5twe4Fn5cEkdlZYTD6Xq6N9YkgpwT6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nl9FkLa0csOmTR9H1jJ3ma7EreWOQU+RKjYv5aIvuh8=;
 b=SCBPKVAQjKFhcwsK/1Z95driKPnRdyYiHY1bVbgfpjeUSxTq0Pf4V82i7OsfBiRMCVJqQqSEHSntPWFBoi7547eS0NIFWkd8z9KLSKygoXy/D8VDkSiir4nDM9aLvxj6vHjh1rEJU8wjhNvpPuN2nyrc0xKhEMKSmiGVbzyKgO4At/CZEJMmdACXFqpnfErTcdU3iXCnS4JrH/vfbJYF3HJD1JguxpTdxZXS/FqT5LaU5y7g00SKRFtJlc/ouBPOCzyWMa4WEjdvl0kPXCEe+yX8CbNvZhMXRxYPFgAP+rnkKXmzRyVgwZtIsC4D5Kl2XYAiU5yzZh6g/2P0Mi3N8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nl9FkLa0csOmTR9H1jJ3ma7EreWOQU+RKjYv5aIvuh8=;
 b=oUO6s51X1ufHEFoVFtqiEeU0oTcytltp5lQk9fwjQuwXLSG/arbvtVmwkSbBjFTkOyf6nkPh0zk13iPnaTtWEpFkm69bqxEhZpg5BAwpiRHqnN8nUwB9R2ky28qelzevQUOeKE/c2JgOgPDQ6aD/9j7egU5tbNCK1pij2BVzUMA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0401MB2376.eurprd04.prod.outlook.com (2603:10a6:4:51::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Wed, 21 Oct
 2020 08:37:00 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 08:37:00 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/5] clk: imx8mq: fix noc and noc_io registration
Date:   Wed, 21 Oct 2020 16:31:31 +0800
Message-Id: <1603269094-29367-3-git-send-email-peng.fan@nxp.com>
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
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0155.apcprd03.prod.outlook.com (2603:1096:4:c9::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3499.4 via Frontend Transport; Wed, 21 Oct 2020 08:36:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 536467eb-b84e-4fcc-2a99-08d8759c7a92
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2376:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2376376B2C2D6C58CB959F0C881C0@DB6PR0401MB2376.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smQib2ztNr79JjEHKoe0NCVxx8Yh8gnF/UJji+tNID+T3iHfaD78VooptXikxWZQnJ6I/tLTr5WGIWH1H4kx4Mk7O/hHAu/W/uGBlGFiDAECrWlDezXqA8AiA9rVjuzhG/FWyskfol0Lx/27Qtt3UZVtmyVHHxfBueA1mbFWkh9QuoKjLgRTfQ76UySeAz/i7SrXcLZ1Ri9mCh13il4JJfk6KEz750gv0+FgMhdJVSMZnbDsX3Q9/2/FdI9/bfmBCaOQpeAqHpWeoUk9t64rAjB+wFEOclbLX0RUz9Go63B88yWOQIb0zCP2AcCg6gyJAwlGULyP6oRmgxIz61g8971c/PJz/Wf+YPXE07STxWaKbcPp6qYz7n+aMvx2ddRHlug1BNcpOtnnn9DaJwB2BchiryWNGlXJOt7t9qX673s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(69590400008)(956004)(2616005)(16526019)(5660300002)(83380400001)(26005)(52116002)(4326008)(6506007)(36756003)(316002)(478600001)(8936002)(66556008)(8676002)(186003)(66946007)(9686003)(6486002)(6666004)(86362001)(66476007)(6512007)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: MuSo2IrkH5l+O1XAUkbpbfjT/eK7eQlKLUCnpys2Z6bD6hxSQgKrVENXSNj5cdpAZGSONCl1E0Dktv1ZECGLHfINnkJLSz+pFDt32cLhcdhpSzVWoLH/uKAMLWv3pUbaCRhYdUSHQ2VRBoeWPcuGE9tdJp5xxzD1/xJlp3TRuTgfoZpzrMJw9D3pTTj16lQXR82Bovwt/ntWX8skeCc5mO3HQ7dORtC1nVtpJbXH8FEhJ3ySE1xRpCvacaHaxKcGOmlVp6ERHW1saArCchMwjVAo6d3+z3We1KqkMAbts/UARXFvjA163Oa8eq/85gQzjhe1RZhh/tVKat9wP3AZOCK/sqlMg0VYnL/l1VmoxMk9KeckYOdclJQmVYnc7Mbs58vhfK1MRm99axf8ny8QHAjVqU+iWoGqqEFR1As0juMqGSvCKThERtGFTqioQjJJzbB/5Xgymct0U+vmThtSLV0E0wRRKCwBxS6p45N4Hb7QvshTPxeLjVoPZ2PRv1creVMN+PsMsEP8avuZK3Z4jLjdSuikFW9bZV3+sF6H5lix/bUtpQLtWzOIdLpAVbH80s8CtquFE9kIpBvEfIqH2hkSGPZXyizlHs1Sg0whKjU2qbTd1gavbTZ35Xnko1N1fCHpxfrOz/OSTnnHhsCx8A==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536467eb-b84e-4fcc-2a99-08d8759c7a92
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 08:37:00.6841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaP6eSEVgIywL61tu0LYbIyqYPPwhMtklQYMLxqPxAEwrmt/rANLmaFka0htvccBChSpeg0cL+ZxPoUTY9E40A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2376
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


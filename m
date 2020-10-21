Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D25294D54
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 15:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442929AbgJUNP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 09:15:56 -0400
Received: from mail-vi1eur05on2045.outbound.protection.outlook.com ([40.107.21.45]:62689
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2442918AbgJUNPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:15:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCrV0fPB7XUANdjJhxNMPZA0wWnt6mPJCtysfjqKjSFTQ+I7RLUf6uYMqbtPqtx7W6ltrOwOlfavXq0KX8z/+sdU2zcGtBQa6l7QcZyGulPXQPpZ0CqQVY15dR5tBf1zyy+DFvQAV1+a5NSfnmsvLbnYy3gkOuW0LFWhN3Krq3k9yxAIEj1tH/FuJCqYCL7VO5rZqEUQr2gu1LZHjxEAbZwGK6LVo2zYRgHcewJlsMkkVrqu0rZaM25cohLBXOI7ukvnXXcZKDMEPNi7toH96Y2Y+YbzkHPuxDlYKl2Kt4qivXcwZn14dX8HgDvz0K6GP3CDCOdEZWBDp7wVEI3cWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCr/GyqxcsNPxveAU84zLt1V/XRDFV1Uw/0VxQaEK6c=;
 b=WWv3iq21sfgMYm5gJqhPyFu/A7USMUDkVUjqe89GodIhk2R9mgbutfe9JpNMexQfF2Zl6bWW6c99+SMcjjUP/TnejB8BRXGAguZ7BFX13ijo5oMQ9MtJdC7oOKZ7MPZPWbeiLM/ZHWiIOJHDvSrHvLmUt7DEeXAr9dho/mdK6FyfbOpDkbYkOaQCCZ4PZF2UPT9Mo11pcmB5TdYK+b9FfYHHv6+sxSZv3qcH/qPxMyUEJZMAqqCKVaG51L/o0mEO0765hQoBCRDze1vd0nJq2BDvB8NYQbNScfY6gIjTAuz511Q9QHyRvu5KCsO6h8mP78N30kZ5Vx4eXCl5J5nolw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCr/GyqxcsNPxveAU84zLt1V/XRDFV1Uw/0VxQaEK6c=;
 b=ehObfFo0QAsr9RqP6AZK+5GZ+pg8aalVvmNY0zETA/LkttoyJO6sQY7mG1Dsf61dflotvdi/7lKsfc/6k7AsJV2Wxgb1cEn2oc/asgkeeU3G4IDWIrSKEKcYCYwI53nlLhElUpiYi3r3L/2YavUk5IluS5OazTi4FENuhL32R6I=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5995.eurprd04.prod.outlook.com (2603:10a6:10:8e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.26; Wed, 21 Oct
 2020 13:15:50 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 13:15:50 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/5] clk: imx8mm: fix bus critical clk registration
Date:   Wed, 21 Oct 2020 21:10:18 +0800
Message-Id: <1603285820-30196-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603285820-30196-1-git-send-email-peng.fan@nxp.com>
References: <1603285820-30196-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR03CA0133.apcprd03.prod.outlook.com (2603:1096:4:c8::6)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0133.apcprd03.prod.outlook.com (2603:1096:4:c8::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3499.4 via Frontend Transport; Wed, 21 Oct 2020 13:15:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e0277f33-0d52-4b23-dc12-08d875c36e1a
X-MS-TrafficTypeDiagnostic: DB7PR04MB5995:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5995DEA4ECE75623AA8C4C3D881C0@DB7PR04MB5995.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uJaf7ZQk4mhIwpNmq+WrKb7H6w3e9JwmlKboKaZtK7EotNrRzcPAqS8lt0+6+v49eNYn5ud5P2GQYLwJyGAAd8Hh/sW+lZH5N4wu+WHDvhZStFfagvKy2U+OIYff2z7CpxFW6w6FyuEvOOQ/rfogyX1B8rH3OuNRIBFAEVc6XYBnsmipFni7D3JFjJe15qiDaEov1poiNg3h+zVx1H5I80JjdznIJJCfA1VFe/Wveg8CpqaLkRcwwS2LkMlvrgki5/6uKvRYnBHdHaQNbzvLRCtWGGz6jPOxjJq0rbaJUOoL210LbFzLMWkQwZKMut3+zuTmMphIZUfjzhPUfsQUIFcO44A8Z4yqbNWQAM3zw3zKooAhGTJ1tjMcUjN2tQUeTylL/4qrU8IryZpUAidu/uBP9aJ1+ttyHTFrRoUZBI0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(8936002)(5660300002)(66946007)(4326008)(478600001)(316002)(8676002)(36756003)(66556008)(66476007)(52116002)(86362001)(6506007)(2906002)(2616005)(83380400001)(956004)(9686003)(6512007)(6666004)(186003)(16526019)(26005)(69590400008)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1xjxCNZleH8w9hzsfQf6yRv4yIt0ncCHlKfRdsSBJf8EX7xiBaNoyXEA7RprCgtEsSdZ2xeh8xFexeU/SF3ykw47K328Dh6cIh1pcTeLQMLh/KP1DT/V74+mlyIWcdR8naQNa7M4Srb1+4hgPq4DPmmWdcVkEL4ShXblaSWTmldYGJjO4VOQgI+39lCPsyGLRPV3qMdSUEmBfatmXyGdJA2/ScPB4smkszgOg5//w1IdaXaX+7CuoqWoTHMJnJpLy4pqbdB02Oqg4qAXSVkpsPxGMkz7oNKwIRs35vRfXi+wdRcom0p6bVMohFetlwAj4/QtQAmDwwKV+oAEUc0OTrhTfH3yh3Pmz7GJwPEb+rZx+2DANkSWeKMnYOUHRySWD1L4dZcg5fONjPwjGXu1eU0dWhsKvW8SpVajZNToh+b//HDbYRQRVZ5P4GgVYZUhCIStjw2JQxDrqHO7YUxTk1XcsYY78kI2Zwz5KFmDV3oieKqrtbnpmWIvXPPMr7kV0t/VCWvmOf1JYtIazZK8qZpRy7c8EvG+uMfCnindni0JwD+3K3if3HqFeOKQ7nqfjQGl7XM6gFfnz3j9VeYug5pV+Y5PNt9Ue5qZdCAzdWJwayld5rK66Vqk7TKypzVBp1vEyVrE9sOn/pBcV9x/9g==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0277f33-0d52-4b23-dc12-08d875c36e1a
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 13:15:50.1950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MJV5AO2TrIdhBCMhxzaX+Y+4342mQah9s2p5bAjuReUZImc43/8/OfbAy0ZkQLpWq+wXAncEmlxTVzeM7ppXA==
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


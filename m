Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8612C3DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 11:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgKYKjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 05:39:43 -0500
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:11588
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728295AbgKYKjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 05:39:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZT6Np/rm05c90RSyxEZy7bPzOhc2GQHKIIcAtnnljo/gVWzMVKxR4q8yYIpIt8rbw118T5S00jt/LRJyqL+Rh8wJ2aRxFMlAmwtwoQC5l7REvlRTN8BBubnjq1lUiYHaUyVwW0+jj1Rq519wH5/0tOCrMhNqjBLKS8harq5Fdrt+tHBUolBANyDoMCIsWQaW8gw+B3eIqVZ5hM87p5gplZsm/MNATsgeXyaplJ8j9vUePByZs8VXYUT1jA2s5jihlc5ds8syzw7JqnfPliJBjswflOWziGpFrz8n6V7WZiYURUIRIWtpkn/8hDFRiNIvAq+GdlyPrUvFAZZD6MiobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYIlt00GC+6NG7wPmPY0KToZIaiBPGNxuJE9qglCGLA=;
 b=MfmarIVysghdmRL+4q4z21YcXNQ91KQ6ATKqLeaW4k4bwm7v1OJIaAqv/Mm9AgojZ8RmG+tMav6bTpoUQjXfRy73Q9tHcmyJ6IMu6eC8ZHsXU7dKLtbiQMtJ2ox0GtRNZ8p3aLHe7hynbNOyfFI/l2t8FvWsX86cykgIF3AqX+YhBoJ3JEIXNrRYF8Mvzk9/oPMxOYr03TecOSTgjcr+ABxCP4Fbn2spyVRyQs0bhYZnEG3gpQ4Ce4lisjK0TOumGoeROc5Z2joaFTIyvg0BMTkxWFUxI6dGe1K013YJ5x0kaX5FeeRh2rifke1EjGMhRMREbzssQi39jwC3Z+XInA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYIlt00GC+6NG7wPmPY0KToZIaiBPGNxuJE9qglCGLA=;
 b=AnJHzhlZhe8tZtqe6Mz5Zla63OXLCrdZ0+69KBAW/CLHgeuCV/FQhu1XHTd+yfypZhDa2P1H7qVkLQUVvkOy+wctXTs6uhV1QZen21AWRRucQ2I1E5OBjQxsZ9E27mhbfRAP+eXC3oWDInbhrqOt3HurtUuvAo7x/OYWOtxPdbc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27) by VI1PR04MB6959.eurprd04.prod.outlook.com
 (2603:10a6:803:139::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Wed, 25 Nov
 2020 10:39:38 +0000
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::41ff:37e2:c7f5:56a1]) by VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::41ff:37e2:c7f5:56a1%5]) with mapi id 15.20.3611.023; Wed, 25 Nov 2020
 10:39:38 +0000
From:   Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mq: add DCSS node
Date:   Wed, 25 Nov 2020 12:39:08 +0200
Message-Id: <20201125103909.16548-1-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [83.217.231.2]
X-ClientProxiedBy: PR3P191CA0025.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::30) To VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-141.ea.freescale.net (83.217.231.2) by PR3P191CA0025.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:54::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Wed, 25 Nov 2020 10:39:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 707c45ed-d97e-45c7-6089-08d8912e689c
X-MS-TrafficTypeDiagnostic: VI1PR04MB6959:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB695979E0B4F887859DEFDF3DBEFA0@VI1PR04MB6959.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECPRtbe5SS5wV7aRkqXAiLb6mtRe39Kbq4NcyZC4ruVCdyDDPkyjiDFrLUkkn6P5OgVs3DH55mt4/yQjIuKtEuXKdTPQf0+WQ8k4eOMK6Qyoerx+4XYxmB495K/WZzXDKudNh0jMjhtoyc58UMkbaFjwfYwGOHKa64jkDPMWxs/XqLBEBu901etBU6T/ceEXzMuDER+JopEGSqRapFzF4fHeCokKbVIzH7T816B1VMZmbD83auuYQ23Fz64Xlsh5I066AgP3AbjpAQ6y4kad5YRFdyLoGKf03dkq38j+9HoeW09mK929PHLiyTq535w2K4zlycgokXsB2L+LSLRBNG2XG1SUs0bIN4a3ezzOtHuE+vhXfPThKostYYhoIHRK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3902.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(86362001)(316002)(2906002)(5660300002)(8676002)(4326008)(66946007)(6666004)(54906003)(110136005)(66476007)(66556008)(8936002)(16526019)(52116002)(186003)(6512007)(6486002)(478600001)(6506007)(83380400001)(2616005)(44832011)(956004)(1076003)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0jxOL/Mmw3y1hjb3bMQ99G1jP37CfEMr0+ZtbTN+e8Yyfuld99s9eCm5Fz92?=
 =?us-ascii?Q?pXDCz6QJAKY4Huhm+1qoyUhQ0hmBMbl8mb7vYMW2+LLb4jV6MNbSJ5M5Is9h?=
 =?us-ascii?Q?LgO71qQs/XQXeSgpq6UDFXy1r+sRjCujmyvCxyCaPgu3TqSGmXWR93EDoU94?=
 =?us-ascii?Q?eB+2jUTmGc0RGLPo7uNzlN0MzTyXwhOBsiMeTUWYt1wSqjmujDl1cCgTI/jS?=
 =?us-ascii?Q?xW3vITg0zZHcs/4MHOTUmrrABEsc3t6cPhLcsMTJ3/pELhEjmVsxoNIEgh5Y?=
 =?us-ascii?Q?EwCOy5Qlv0Sk9VbnahpFWml5ZMs7LEjp6sI2URwDsHegefGNU35tHRwf5Pm1?=
 =?us-ascii?Q?cQfsVcCunqYcu0uAWtnqId4LbLp/sXAiyA695NNFPSqJIlv/fG1Ai8/ChsGT?=
 =?us-ascii?Q?KiZDrLxc8KTIREMXv098AavHR5zVEEi/GXk6TsengvO1Mom0O3bPKC+522CE?=
 =?us-ascii?Q?oAURoa6ojI9i3X4mKEwYnXk1C3EhkNislglSy9OIIBw/htxYdsVK47TG8pcZ?=
 =?us-ascii?Q?jgBfWj1i/awyRQgv3g+tkMGrK3RDwZEbi/bTeBN6Kg1lCWA26wXkmVJ8d7/l?=
 =?us-ascii?Q?YtUPfoc5S6TRPW77vVEIdwKDQzeyFDKSa851y+tygELKtRRYD8Xfw9ULmsSN?=
 =?us-ascii?Q?d1nIDYnjvBlbTRhtL/5suAd+A7m4ttNhro0+1A5edDg0BWwONSjCU1nBarfp?=
 =?us-ascii?Q?7ojO8nKuoUhIvw0fmzV5gyAbu0HdXhtsZ2dfCmTHsVLKXdHg6VyxOh7aj5Oh?=
 =?us-ascii?Q?/+jaalXSqBJg94QFxK/8ZIwjTEktyfdFYcIqSW3XBeFhFN+hh64I8xgqYb8q?=
 =?us-ascii?Q?P5ZK5G0/xM4BrVF+d0ONt2+hSU6EFBXi5lnmoEjbBRh9WxUn46ka0FysTfKZ?=
 =?us-ascii?Q?2wEgJQDvdzhmw7nQn/u18XkQUgM0azu980bfXMh2K13XqKAxw61AbiwXZUSV?=
 =?us-ascii?Q?cT662YWeo59sDEB7Yv4vimzx2IPcjPa94r7yeqeIUQdGStWEhH3AFfoAp+C5?=
 =?us-ascii?Q?H7gd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707c45ed-d97e-45c7-6089-08d8912e689c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 10:39:38.4106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZFkXXLlg3MmqH40623Fw+ke1nTXzJKgyLukR16Txjw4VsB1rmrFTzfp12rqegeRLTbKu2HsApvSbGGMTk4YCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6959
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the node for iMX8MQ Display Controller Subsystem.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
Hi,

This is, actually, a resend of the patch because we decided to drop it
from the main DCSS patchset until the driver gets merged.

Now that the driver is in mainline, we can finally add DCSS node in DTS.

Thanks,
laurentiu

 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 5e0e7d0f1bc4..5a617f9ed8b5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1103,6 +1103,29 @@
 			#size-cells = <1>;
 			ranges = <0x32c00000 0x32c00000 0x400000>;
 
+			dcss: display-controller@32e00000 {
+				compatible = "nxp,imx8mq-dcss";
+				reg = <0x32e00000 0x2d000>, <0x32e2f000 0x1000>;
+				interrupts = <6>, <8>, <9>;
+				interrupt-names = "ctxld", "ctxld_kick", "vblank";
+				interrupt-parent = <&irqsteer>;
+				clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>,
+					 <&clk IMX8MQ_CLK_DISP_AXI_ROOT>,
+					 <&clk IMX8MQ_CLK_DISP_RTRM_ROOT>,
+					 <&clk IMX8MQ_VIDEO2_PLL_OUT>,
+					 <&clk IMX8MQ_CLK_DISP_DTRC>;
+				clock-names = "apb", "axi", "rtrm", "pix", "dtrc";
+				assigned-clocks = <&clk IMX8MQ_CLK_DISP_AXI>,
+						  <&clk IMX8MQ_CLK_DISP_RTRM>,
+						  <&clk IMX8MQ_VIDEO2_PLL1_REF_SEL>;
+				assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_800M>,
+							 <&clk IMX8MQ_SYS1_PLL_800M>,
+							 <&clk IMX8MQ_CLK_27M>;
+				assigned-clock-rates = <800000000>,
+						       <400000000>;
+				status = "disabled";
+			};
+
 			irqsteer: interrupt-controller@32e2d000 {
 				compatible = "fsl,imx8m-irqsteer", "fsl,imx-irqsteer";
 				reg = <0x32e2d000 0x1000>;
-- 
2.17.1


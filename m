Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067A92F70C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 03:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbhAOC63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 21:58:29 -0500
Received: from mail-vi1eur05on2052.outbound.protection.outlook.com ([40.107.21.52]:38689
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726239AbhAOC63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 21:58:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grLCcE7j2nGvKxJIx8REOpgRWp431mex+tXlrri5d1jFOL3FSu5Z3yHwLckF7GaAHkrOBqK7WnW7yi8c5LuiEnQydSpdhtPHIgp74jjBq4q6iqhuaeW0kk/DwQ51l9ho/zMCc5JNm6AGLB3fRJRNfJNslUn+uF73yf0CbPAs9mIlMDnoaizz62h29gVeOOaQG14xodv3wINb9wz3xMtT1JO1luWQRkq7oX50JsijrTXzhi/4hf8A4hEDQ4jXaUOhT1e7Psu6pk+o06sxuAW/8wtX1+GNo7lDxnAAIK3sxKVbRbC4vDPgop05FnGCgcQ9tbmDiP83N8zCW6T6GBuz/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4KkLJmzCS/HTFWj8OjtTZVVsRx+jWPUIc0U65M9Kp0=;
 b=XcG+CCgx2y7pcenyPS13FT+3k3uxtldSyCLpp8iOx99AIpoefi9Q2qabk0QmWJU8A6CU9kul/n2k6CewT/nmC0yJJhAtjUF+HvKCv6X4Eej5qnwl/wnxGW0pLu/LYycGJn5hAqz5dsQb8RJ04GEOhaoZVgP4CyR1h2tTZqqMJ8MgU+p2AS5HXuGdGnmW+rytiSDy63L/dTT7T+t/V5SV/adoJQh7GMrOeEXPKSJavbuiEh17rkGmm4jZwIjOkfV3V1hFj48KnHEDqta2EJMvXHjyEQC3iJquq6Z6hrciWSmu0DEUVkIOZTnw2mxVHr/zbRuxZwP2rXW/7tl7OHqWdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4KkLJmzCS/HTFWj8OjtTZVVsRx+jWPUIc0U65M9Kp0=;
 b=Ac9VNDqG13VAROxCSRoN/2K7HQbqjsINseVmMurM8lDdOGcPcS0I8MFfje+jnveutUBhl54sLaFd2zD6ByUM1mIIrwK9VcpoKTafsINTSyLK6eINJf7LpxPSE8jxPTsmvz6RM8QrMEkJ11m+QRp1p7cFqcJUtwyMINAWfTmZNUc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6617.eurprd04.prod.outlook.com (2603:10a6:10:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Fri, 15 Jan
 2021 02:57:40 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5%10]) with mapi id 15.20.3742.012; Fri, 15 Jan 2021
 02:57:40 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH] arm64: dts: imx8mq: use_dt_domains for pci node
Date:   Fri, 15 Jan 2021 11:26:57 +0800
Message-Id: <20210115032657.15390-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR02CA0083.apcprd02.prod.outlook.com
 (2603:1096:4:90::23) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR02CA0083.apcprd02.prod.outlook.com (2603:1096:4:90::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Fri, 15 Jan 2021 02:57:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f1c87d54-edca-433e-195c-08d8b9015217
X-MS-TrafficTypeDiagnostic: DB8PR04MB6617:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6617A3FF4D3947AEBF90FD04C9A70@DB8PR04MB6617.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9oY9XC486bOwoNH2tjqXY8Ai4A3p8JEpQZX8Gyb7uZ5iPUDgD+yjxyuNih0lqYeu2WtkFR/m/oMNGYFPVdaOcZoPGUhvDqRqTxuqY6BFy6YVpgs8K6C7qxIAv7oau5KPZ4RFfS6YmIGorUk/WJmfL/Dnbg2Djmm33vPnlaS75mv/DqCJc9FS0Tw9mMKUkD8S/BLKtqh4QfF8HKTWmOchGpetBOViuYDuUK7+9z9hiWLGp6/BVbmFHhCiN/5boFTKzdWvt8XAk/H6/1Q08odvJnp6hNRsi1zjNvtcLpWmzcsMeI6gQ9HpqexFPGKZZzzI/2HHPxmzInzCICPHf+HZaM0ZV6Us6BtNvsVAhCwd9a/I6KzhOmzAUVjR7DIRiHvAAIE1E4+GPGC+GVqLi3+hvHS/yP+J1UY2ySaMtUrhVVsRpayPpjRAcJeZD0FG5Zra
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(26005)(6666004)(52116002)(86362001)(478600001)(1076003)(316002)(8936002)(5660300002)(54906003)(6486002)(8676002)(186003)(6506007)(956004)(2616005)(2906002)(6512007)(16526019)(66556008)(66946007)(66476007)(4326008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pq+rrSQvHPHHzJ3CtkGvCy+c6AuEU+D8coJ8x3/uh+AkV5pmn0SbC1PpKJuV?=
 =?us-ascii?Q?RF3Cbi6bqm74QEGZI3x/ik5IYG4bVcegwUsvhpLTf2QlEEe4SRJlYURF5tTd?=
 =?us-ascii?Q?uT9VDOyATg3QtPaY1KQv4K794kRZ3RFnNVzQKJA4Ecest3i7klg/9J/ipag/?=
 =?us-ascii?Q?zXJYFtpOaaD7rmGfm8njeA+qbMHEgxMVO6G21fRGcc4inU3oXudaRLrj2JYZ?=
 =?us-ascii?Q?1Rj2D1V1PhE6glHRj8zcUrBwVp1GlikAmqdWCfRnQnyYa1MadMLIjd/VyycU?=
 =?us-ascii?Q?otBYTEPbevw/XtpR89DHVyzPpX/tmyQ80Eck39gqAC2wJkAUs2v6vzcCihfU?=
 =?us-ascii?Q?jwkaeBqRjM93fXgD23EUPmXxM5ooaTFA09mSROKWD3tfaU6zvmRai+XNTluK?=
 =?us-ascii?Q?+DkSrlJq5eDTUv/t/Sssb4nUYrXFhHq2U6cFTUEnObx65fHSUr4F/SjdQVUh?=
 =?us-ascii?Q?Mr/INOMmb9KwDcA0umA0uresHmLWqrI3Zu9i3Rw/tIdy1afEdnEu2QNobhG6?=
 =?us-ascii?Q?EIrHGkr3hRUzLH3zwH4GsxrnieKQgF1z7ejHL4TwskAxxuzJZYMzgXG31DR4?=
 =?us-ascii?Q?uuie6zjijvY1mM1YTH5w/ZFp6PwPYa5sV1er+pGtJ/WVbz/AByP3sQEvZgDj?=
 =?us-ascii?Q?1hgClW6fsuqQFjzcLauuSarTFI6yHT5Blv6X2CXATsRqLOFG41wX79N6uuPa?=
 =?us-ascii?Q?VXFE1X4Du7kHodzZjf917MmDrWNoUYe4zrD30YlnFgPlkL8t3aNHs5NOtnnF?=
 =?us-ascii?Q?0KAAD/hk7WKXfCZ9c64+4gqLOoRM+nM7+pI3RiiUn68mrOzp7j46ug027pRv?=
 =?us-ascii?Q?fLQQWhtgHJfpiz9iSA3ROSX3P50fCppHv/+HS3FybMyGuWXnZDJ3SPTNSWGO?=
 =?us-ascii?Q?N8t+4A8ZLy8XkoUZJ0A8Afygbb87clp5EedqsbLH1CxNZh1+sGoxkPZCNrQ+?=
 =?us-ascii?Q?a1PWRlAYQXGvxmKaOtl1IS6TJ3DdRhKRGC9NFAo1iZHkZxdfavsGq9oJEkWP?=
 =?us-ascii?Q?KXZL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c87d54-edca-433e-195c-08d8b9015217
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 02:57:39.9135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: di/1qxnCrPiGKXbjJlxqnPX/TriVAWg/Qb7EAEw9ZXo3CW4mpCu7OGBPmo06/HWntVxeBgnTxJBdj2kKDL3vjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6617
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

We are using Jailhouse Hypervsior which has virtual pci node that
use dt domains. so also use dt domains for pci node, this will avoid
conflict with Jailhouse Hypervisor to trigger the following error:
          pr_err("Inconsistent \"linux,pci-domain\" property in DT\n");

Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index a841a023e8e0..ac37cc86ad39 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1315,6 +1315,7 @@ pcie0: pcie@33800000 {
 			                <0 0 0 3 &gic GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
 			                <0 0 0 4 &gic GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
 			fsl,max-link-speed = <2>;
+			linux,pci-domain = <0>;
 			power-domains = <&pgc_pcie>;
 			resets = <&src IMX8MQ_RESET_PCIEPHY>,
 			         <&src IMX8MQ_RESET_PCIE_CTRL_APPS_EN>,
@@ -1344,6 +1345,7 @@ pcie1: pcie@33c00000 {
 					<0 0 0 3 &gic GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
 					<0 0 0 4 &gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			fsl,max-link-speed = <2>;
+			linux,pci-domain = <1>;
 			power-domains = <&pgc_pcie>;
 			resets = <&src IMX8MQ_RESET_PCIEPHY2>,
 			         <&src IMX8MQ_RESET_PCIE2_CTRL_APPS_EN>,
-- 
2.28.0


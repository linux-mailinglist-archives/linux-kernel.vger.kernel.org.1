Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4B92DCD05
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 08:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgLQHkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 02:40:31 -0500
Received: from mail-am6eur05on2081.outbound.protection.outlook.com ([40.107.22.81]:18624
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726503AbgLQHkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 02:40:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYlL3IBOkVsHp/3A/VMVwWI+CjPCAskZDJOgOvRTXTKgLL0EhF+dEJiHzr34Ya17HXjUMveHnaJxrrCn42p1EbNxe8FVwAmCo3CPRJz8p0ENUdP4sy5biibXoLnR7GaauwIOooX7J9DBnz/29QYpNfm6gEzWncvUWEwBcWCevV6rQaW/I/vlcwXtXnE950MBsR2026M4NzMhp79YL1ZesBAIOyQU08zgQETvuleRE9DyezXZYicS/fHGPT6NJLIZm9JkwOHFCz5e6fndyiICJYUcoTDB+92vg0fOZxrurFLblFHRXv0oACqzNh/yvmF6d0vDrcoJTrw93nPFVGQK9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Dw1tQzJ+Wbf625UjgsXSCt24bQI4ZVsGB5hUjMIghQ=;
 b=I9KoDLlEGXb1kdwapJpzrX6Tt20Zva1NuO7329L+7ORF8+AW0EmM8r2OkO2Te1C028Do1QuPx541cGMcN8Gy/rF0+E/ScQdvThJBxdLnx8XvbMGA1moP13HuCuiNil1t4qk55pIB01131XoesCZmgNCCPvFSh99JYWpSxlftZiGLnMhylC/wFWL4mGibG5+ccamnobDDi+yG4Q28JSv4Xqsxs14BTzkdvaVcVxyzyyPVp1S2YgGjvKpm/+z6VS0jFeQl5Z1h+rE4mqlDpfzGWVHVWQU/erYbcFCsdUyuuJwHvQg/FDIH7cAQ7IyMJ2UdjnpnzFAkKbmHEfVGijj7tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Dw1tQzJ+Wbf625UjgsXSCt24bQI4ZVsGB5hUjMIghQ=;
 b=Tck9z499v+iHfpYmHu6rgyg7d45SSIGslXyUdoMYhBjRjzflBTBGr05WLHcjHEUo890lSuh+rHI8/I3YPK4swUWGr4EyJape+cR1svnbYisU+EzYpTSGq4wLhrJdqHyZ7WSpb+RUEb065YDZ94LeTQPaUFuwV9IA36/9c9cREo4=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR04MB3126.eurprd04.prod.outlook.com (2603:10a6:6:7::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.17; Thu, 17 Dec 2020 07:39:40 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5%10]) with mapi id 15.20.3654.025; Thu, 17 Dec 2020
 07:39:40 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     catalin.marinas@arm.com, will@kernel.org, nsaenzjulienne@suse.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: Kconfig: select ZONE_DMA
Date:   Thu, 17 Dec 2020 16:08:02 +0800
Message-Id: <20201217080802.29023-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR02CA0069.apcprd02.prod.outlook.com
 (2603:1096:4:54::33) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR02CA0069.apcprd02.prod.outlook.com (2603:1096:4:54::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Thu, 17 Dec 2020 07:39:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e86ac3e5-1d3b-4f7b-857e-08d8a25ee9db
X-MS-TrafficTypeDiagnostic: DB6PR04MB3126:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR04MB3126E31F8CC55EA6E2E6E468C9C40@DB6PR04MB3126.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jI6NY+92o4lYCS/hlSz4vHysRBkJW4HmmOAqHwxvoETkjvRUK7VvQ1GSGjgKIZPfr+ZqMzxlxDHyk3o0cQ5uBDt1glLOSErARmi7sMD6d2vfLK+eWC8Jhsu+s6Qiw7wMXKSFr91YxOGIL8v2BsAUWSe4mFFrO5/qgcNo+NN4mmLwZPhuelQSaOy8nDeQLhiA6EOLgRl91RFOm0XZDztC5KQvb7mKYAGz+4OvwbIUKTW3kIVrMmMQ+yLOGbnjdujQTG14GpYgPru/13Me3OuOQXH0yGvYixor24bxBPpn+6nHzoYmQ9ixA9hluyKJ3LVC9js+dobl6lOwkbxdk4o7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(2906002)(4326008)(2616005)(26005)(316002)(1076003)(52116002)(6666004)(6486002)(66476007)(66946007)(956004)(83380400001)(66556008)(86362001)(8676002)(478600001)(6512007)(186003)(8936002)(4744005)(16526019)(6506007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?e5W/+SzYshoN8OgtYM7oGGFPur5ZomZPUN4cQo+qgGIBriAamzQOVXjvZXNw?=
 =?us-ascii?Q?Wqe2T0K1IVVTUT3/GHXbvefb9yObpQoMLIDKr7iYwTgyEIr9/GSIvJ7jmGa3?=
 =?us-ascii?Q?C8i30Fo5v3AptzUElzk8sW3OZ+/eMqlSs1WI297xzG3vvbo5LGUwCv7Zj045?=
 =?us-ascii?Q?hQO6I8yVfT8hF6Jfjv7+xRMzZAnQjB6KHz9zC7YxNydXu+Ok9Yt+qXxcJ4iz?=
 =?us-ascii?Q?vVb2bEN8M7OQ5tpmZBCfS23b/W48K+VSZ5FjqgThA5GLmwE8XHkGuMOgMB8k?=
 =?us-ascii?Q?v2DBIl06lW3bZJ7TRWd82xU83A0iYi95jGA83gQqibyZOVZyBt5pHsvu1R21?=
 =?us-ascii?Q?5KxHvf3qiCN1Tq4CN4aO1oi/m98h3WWfuNrUiGLhg/qy+L6JlG2QNV0lazSZ?=
 =?us-ascii?Q?Escu0UqCXS7mhH6mHvtwt5OlqRC2ePtxcVOrtkAMcgTDr5Ivmq7KgDXn0U5B?=
 =?us-ascii?Q?/3Rhy5z3AViRi6liTm0HMDRfZ4SHbAYfkEkO6NcjNBm6Aq+sMSoA29K1+9t9?=
 =?us-ascii?Q?aCdl4glbwMp5US9mpIu0p9uRRPUv/ivfjWrXiwzDTgchezPWBAd7lUnsogVl?=
 =?us-ascii?Q?MrCXUNHzF0gyyO5REIPwRxeaponCfLRPvv7gnOul62Udh+dPHA3Rm2yE9FGL?=
 =?us-ascii?Q?aWNdHuoUbpaeYVUq1jVLpmIec0Yr7H14bColF9veNET8JaSwDVlFrvBheLOt?=
 =?us-ascii?Q?W+lYS9Vq4acnvTwPcw71fvysDQc3b4thHlmlHdDhsMdl71bFm4E/jqRE38x3?=
 =?us-ascii?Q?dyyD6aJx75S5kS2W1tsSiHYx+07pIfqy2Wr24+P1Iqx/bYLyCFtANnsjpvu1?=
 =?us-ascii?Q?h73OXUWDD8IUn6ojkFVDOrKq5rIVs6Apmc0ss8iRQC93gg5kNSFeQs4kJUmU?=
 =?us-ascii?Q?Ez0/aRmYXcqL3LIqB2JQw8E1K2Yo0KMh4RYuEcNzdkJ5lBAnmyhZchdxrRyF?=
 =?us-ascii?Q?uMDc8E2cQOTLabQRhOWuR8gBG663fXpppmoOugAtgMcopHg0LaPxgF5gxQ8S?=
 =?us-ascii?Q?bvoi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 07:39:40.6738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: e86ac3e5-1d3b-4f7b-857e-08d8a25ee9db
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QqTZcJ/KjQY36/T+lAiXpA+sqFdHPOqe2V/kFfApJCTPdu66ES7AxNaK3pfWAB3kemBD2fPwalaa7/OzcgSiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3126
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

ZONE_DMA should not be disabled, otherwise arm64_dma_phys_limit is
left uninitialized and cause swiotlb have IO TLB above 4GB which
might crash some platforms

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

Not sure whether need to address code to initialize the variables or
force select ZONE_DMA

 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 33446269f692..377b391a41d6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -206,6 +206,7 @@ config ARM64
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
+	select ZONE_DMA
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
-- 
2.28.0


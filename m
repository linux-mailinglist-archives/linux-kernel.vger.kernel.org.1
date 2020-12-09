Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC782D3D2C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgLIIPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:15:39 -0500
Received: from mail-eopbgr50063.outbound.protection.outlook.com ([40.107.5.63]:30526
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbgLIIPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:15:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOq0//IEyEQTuz+8MAPs15IPDVNFuYVo1p/61m46xpSoIqeVv9xomLGes66pg+uJbZBSgRJP5hb3uxDIoJg6C9PcbVmCQAt2LuL5lWBQNPfYA2y5qpO1XUzzFlTkcUI7nN8hDmCPCUlOLsuqUUwndojcym/0+nxAJfEx+1PICwFaYvI7rLbueLnxCInhiSi3L+5XbGGutgi84vewuOjKSPIY5CQizGR75+mATeDDn6gRXFT3UHXaADcEWA+bSTht/cyqx6OJyP02ti9/n+bwlp74gOy/YQZL3glqw+33WC+QDMFbb7r2c12EEzwTXH1y7/S/l5eA83OHVK8jri9p/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjVzE9yY+s3OhY2/ta1zQi2oqeHQU8LSsa5TR34aPl0=;
 b=FK6L4D/qrYKfxX0rzh4+cs3EdtCsPF3UG2qKqxtIy01OTnnxsZEiQHsQ5SoSKkYfGYcuwIqOCMj85WrQL9m/qEPO6wETIoLqef+OZXoijHMgFOtM+KI9yffHFN3ovlRVlpfbkchsQw86U6xRFRL7uaT6zgAlOBl4lqzty+HHTLHxgg5cNuV3fw9jawCVHFmsc6O2gSUb0AS8LLhn+OQLLZY8oZKGQFXv5mYkEwPpz48fyqTBWR2Ud2QbXFSdsSoCda1Cz7V+F1UjZ5bZcT+V9ailYXdOdHo7ZfCnEVn3ErNqN7FAgRJ2yHqSYe0CCfAtbeZuxBUBuVH8yp1PKqqnwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjVzE9yY+s3OhY2/ta1zQi2oqeHQU8LSsa5TR34aPl0=;
 b=DGTcDFgyvXr48FOgLl/curCns+oD0hMwkPm85cTuLd4mZywaZu9ZdmUZh+yS5Z+SdSZQLt02JJl/P5OAhT8Js9K88HPoO+MnTMRcG1iUWHlA0sF9y7ApuoPdR6c3vAnqmaXI6d7oJMMkyg1gqq6oqJPUF2RNf75XOTRi8AI5Thk=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7515.eurprd04.prod.outlook.com (2603:10a6:10:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Wed, 9 Dec
 2020 08:14:11 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5%10]) with mapi id 15.20.3632.024; Wed, 9 Dec 2020
 08:14:11 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, catalin.marinas@arm.com,
        will@kernel.org, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        van.freenix@gmail.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/3] tools/virtio: add barrier for aarch64
Date:   Wed,  9 Dec 2020 16:42:05 +0800
Message-Id: <20201209084205.24062-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201209084205.24062-1-peng.fan@oss.nxp.com>
References: <20201209084205.24062-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR01CA0122.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::26) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR01CA0122.apcprd01.prod.exchangelabs.com (2603:1096:4:40::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 08:14:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 59f36820-576d-48f4-4fbf-08d89c1a6914
X-MS-TrafficTypeDiagnostic: DBBPR04MB7515:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB751533AEF22B4DC06B18D275C9CC0@DBBPR04MB7515.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MODZ9oR5XjYRSlWbJz99PiaqI+o/sUIJc8rAlFuBhctrCseeu4Y+443WYdGO0XGpXfhcOg9D8Fjv/T8WXfrsP9BPJfWC5Cf4qGBXoCneDodppvFgb+lIterP4hc2OkFw1xvjnaKiQA0s5E6mSVFDdaFLYR/8R5RH5OLFvQ10vAc0dhG/TUxxphpDzKLS1FNjVSCbz+A/3oVbS7WQvqXRCY5kSTaBwhqnA0YY2geRDHNGxah88QRbDI3lJKdCziFkle+eBdCWR7L5ywYjyd1F26ItankaS+f3eH0pn3WP7xtyzS6hzi2vHZBPEqK1YgKiRJPafOpRrYQP/HOND5rApAVWBuTgFadK6RYp4EvaweUtX/ien7eFtY470HWlxtjE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(66556008)(8676002)(66476007)(956004)(8936002)(4744005)(4326008)(1076003)(508600001)(66946007)(6506007)(6486002)(5660300002)(6512007)(86362001)(6666004)(16526019)(2906002)(2616005)(186003)(26005)(34490700003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VIuFCR9RkAMnYFGnKhlwhDi1CfZ/3+xnbWect67FvbaERkdYOws5cAMJOSV/?=
 =?us-ascii?Q?QLBu6X84nvossT/ZNSdKeVYbeC7S9Q0L9m0WSRe0uCmGR43LKzA7B/1x3ouU?=
 =?us-ascii?Q?olZwqi3Cy+Maqa+Itvvvgx5qPcD9luoci1rl2VsVk8oDBLO6rvJce0L8emWw?=
 =?us-ascii?Q?NTJj70BwfzsDsxxPAx+KIFi7zfO3tOCTSpwEa88WzbMtm0iJ1d1oEFPFRoff?=
 =?us-ascii?Q?G8EzLd5SVmFn0PTI5ntEDcrgIpj8s677wiarj+j5Bn+FkTZTcxSlYg7MTyU3?=
 =?us-ascii?Q?t8eMKLog0LpL1iKpoJDes7G254HQ7PVk+LykndunzXPpPraNd6GZkFzFUbdL?=
 =?us-ascii?Q?r2uCH5rX5MWla1jzBIEhlo213sPHZwh9gG+2iYJ1O4s2zW8iIe+AkBOw5UdJ?=
 =?us-ascii?Q?Kz/RfLCOimHDDYWG3dXeaqXP0qK7XfSfRV/nrXJxz93dwsr+3+DW259BvSxE?=
 =?us-ascii?Q?8Uy8lIu1Kyb7GqrnJX+xbQgiNiuYWQdhGmjlClxUP0Xwqiqyw0NkBjTObGRv?=
 =?us-ascii?Q?ekpYgWHSvm3VITg4osKBgsVNpk/5FCR/XN9orGI5iee49bHx3jkOcSxmcxNW?=
 =?us-ascii?Q?LUKkUO2DL8FRVG4nyZ8iVv4fdHAoOOzLbUYgZHi6KDwoFtlQXlWuGkYEU9ao?=
 =?us-ascii?Q?6IX7/WiTtgFDMupmpX4kdca2AJe6nOMJbE3+PAT8ZkccMSE7uuApd19CICSA?=
 =?us-ascii?Q?IDhO/oKRyJIK+reELaaBV8OVK7p4G0TlB+R3IUWCFH2wx6Qul/Qp91UKniVn?=
 =?us-ascii?Q?vqipbqeJhx2x74HbprutTtdNE0awGZgxAwxOxN7sF06fCOhGBhMfaQD+ant8?=
 =?us-ascii?Q?BeOwwkD28uVko7LWvvfnz/CcSIefHcblULdE6eeccZxXDD8aX9K6sjp52tgR?=
 =?us-ascii?Q?uB1q6g6XtG/LLCF0I20x5eUH2gbSsX4v5vFfjxRKLRsKyGXHBCvKT2CMWgA7?=
 =?us-ascii?Q?1mqKyy1G5WiFXZtrey7sSd4vSf28bTC/oNjJZ/D8q4W14wf5wntDnSDk1GEn?=
 =?us-ascii?Q?Bfxd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 08:14:11.8247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f36820-576d-48f4-4fbf-08d89c1a6914
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VI5Y40jKiSaBUI4Z8CHrTbzk/s/6Ji+bzuuep5dm3M1T930HBvMlD4vjsLnUVzfQAsCuv674tqhksh8B+Kvt/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7515
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add barrier for aarch64 for cross compiling, and  most are from Linux Kernel.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 tools/virtio/asm/barrier.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/virtio/asm/barrier.h b/tools/virtio/asm/barrier.h
index 04d563fc9b95..468435ed64e6 100644
--- a/tools/virtio/asm/barrier.h
+++ b/tools/virtio/asm/barrier.h
@@ -16,6 +16,16 @@
 # define mb() abort()
 # define dma_rmb() abort()
 # define dma_wmb() abort()
+#elif defined(__aarch64__)
+#define dmb(opt) asm volatile("dmb " #opt : : : "memory")
+#define virt_mb() __sync_synchronize()
+#define virt_rmb() dmb(ishld)
+#define virt_wmb() dmb(ishst)
+#define virt_store_mb(var, value)  do { WRITE_ONCE(var, value); dmb(ish); } while (0)
+/* Weak barriers should be used. If not - it's a bug */
+# define mb() abort()
+# define dma_rmb() abort()
+# define dma_wmb() abort()
 #else
 #error Please fill in barrier macros
 #endif
-- 
2.28.0


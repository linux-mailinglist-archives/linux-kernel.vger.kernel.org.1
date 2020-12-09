Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEDE2D3D2A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgLIIPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:15:12 -0500
Received: from mail-eopbgr50063.outbound.protection.outlook.com ([40.107.5.63]:30526
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbgLIIPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:15:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjAVNWIXBPAstFVJRo8uC37heYJc+bWzsOztzlAy/weKDNtkUoedqg1T8G8qR61eKDRrrZHsPj7w4aY8m/IFCs3ZPf9MDmUNTRDLN6vRi0+s+uEICrP55q2rNnt4e8JOPksXBI3aZ1GatfwPAhSl9D5LdWNBraRRDbG4Pd9P+njUcM5KUqj6U3fvtqRdgwq+4pSesuko3gFZwucvb7P9ZkB5hH7/K0ELG/rCf3Pzd3sQfmRurXfqMXxd66FChBy0v63pTNZi7ry7ey74vF/4EmaZpOs+7NCuirgGqQ7LyNj4mPNKU1sSwgCY4GvLApng0lJM20Vb0S46AJj7jTNpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I74ETKbtq0CprsA2HML/cgXuTTT5jy+1qAxEeD4OemM=;
 b=KapBFg00XpN+M4nL8erWZ4zMEWtcyrda15EcZSpJJkmg35JF/cIgcfvTrvthrFannBikrawyOS6bgaHBBv1Yh6UG6CvJ1nWh4lHzOqWuGFDL9ezeVy5LT/Y0/St3Md2a3CVoAPqL2hujmS32NyzlruK+aGcraOgPk/bALjdQHx9Hxopsk0LAZhsP/UW3V4LrOguaeDhqiUOxo7tHzaEw86RICQ7S721Yt8mtmzxoT2faI/E2X4h19lPDQERkq71qbcv6pOuCB5CDDXhYeG8a5g+ue0hT7Ub9AMsspAo74ReZ8fM2suGUjHlUCVY8tvdFaYcei9MceNybbNBJUqTdWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I74ETKbtq0CprsA2HML/cgXuTTT5jy+1qAxEeD4OemM=;
 b=BqsD82HVn2rhEA2qTFegzvw+0diSliOxS2By0GXpUePnK9NWEJ3oe/r5KcFoeG2n9reRMsBwMXNU7eHQCY1kE3kosQ6QI9M5vLPA1S4zhAwchntcizdalvedFns6kA49HNybIEXKLnzOPO09hM77ilOodH09GmBuzLZSM+mMwjc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7515.eurprd04.prod.outlook.com (2603:10a6:10:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Wed, 9 Dec
 2020 08:14:07 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5%10]) with mapi id 15.20.3632.024; Wed, 9 Dec 2020
 08:14:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, catalin.marinas@arm.com,
        will@kernel.org, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        van.freenix@gmail.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/3] tools/virtio: add krealloc_array
Date:   Wed,  9 Dec 2020 16:42:04 +0800
Message-Id: <20201209084205.24062-3-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR01CA0122.apcprd01.prod.exchangelabs.com (2603:1096:4:40::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 08:14:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 805f3d95-b7e3-4194-bb4d-08d89c1a669c
X-MS-TrafficTypeDiagnostic: DBBPR04MB7515:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB75152E97FF98BA968B9406D0C9CC0@DBBPR04MB7515.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vKz15OHSanIpaSV/1yaY/2MpFzJn8NSbywDuahFGhE1b/qCtprcRaUx/h9RJcCuRBbxwEn3YCLrleGv78R+Pf8aKYXMGQ5t+dmQ8je3brXdx6I5EDo+czOE3KH9kgjWDeRLF6T8MAV1W4dzQ3/JsWMO3a1oCob+c14y3iy2CpsBbS8G0uvYHrsVV9NSZ5vIDS+Hr99yUpdFMdgRHn5FbnplHgq3FTq+pytDq7KxExjwxgqeUR6MzzSywfyRH1sC8mAvhXFWlMQEBZbBcvIDk/MbFZOWxvKvXajSdNQL1hi4iaM0JOjFuHLAzM4M6k/rRxLoWOUO1rPthpgZ4N/9DFvFd8eKOYLrm5AlY1OYtNN8G54PkbacsgTl5iDrHTTN/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(66556008)(8676002)(66476007)(956004)(8936002)(4326008)(1076003)(508600001)(66946007)(6506007)(6486002)(5660300002)(6512007)(86362001)(16526019)(2906002)(2616005)(83380400001)(186003)(26005)(34490700003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?e/zHba9p6mf4I4mhhmm2eh+Oenp65AjhWim2tLf0sBehuv9dM8jRa2BEdJBm?=
 =?us-ascii?Q?7tjYp1TN4t6jQPRyjuyFHpudy8jGVpr1SgwFP8kT3ogTQdGfB6pEBdPFS5kF?=
 =?us-ascii?Q?H1xHPlgjGSm2Ry+vMBA2azbPROHftK+OLMgKIUhVj7RmPJCkWjcB2jIWNbDX?=
 =?us-ascii?Q?tFSBHAHMQWgh4xOYGIgda71J94N36JJWKsij+/DkPMF5tQnfZ7XFcIgIA0zq?=
 =?us-ascii?Q?+wRBuIVbcDFgqj+Fb+/+Od3QUTREEdwTVMMj4+KjhmfAspB4Zqpq3GIGFx86?=
 =?us-ascii?Q?bkoqRMkVN6zdkG/o0sXdBUnCrMD67l2T+0e0JgEYwRmHXNyHeMRpuFoVgbAG?=
 =?us-ascii?Q?rdqGdJK+RZMtMl5bNqgk1UnHcawLbMhvQ6rBQg9j4ovyNkjM1zE8AX0ILmyQ?=
 =?us-ascii?Q?WT3ENkPdHFwqF6HVsitu3vfWSWt0aKu0DYEx56HakxGy8ZbHE7KCDkMQYGsu?=
 =?us-ascii?Q?sb6Ve89OILEU3gHR70GLBCX6HGVq1XoadYvYYn6Fz2UOcOsdOdkhQpqY+XAZ?=
 =?us-ascii?Q?aagW2r62ApKjTarlW+6OZGlkfowX2RCCxZ866AQV2p/HMIXEyrDfBckz43MX?=
 =?us-ascii?Q?FoT2SRoxEbVb6HoAVrNN/CYS4MMj+Og5Z8YLyBDF8jGCT33kB2ZN6ZPlu0LR?=
 =?us-ascii?Q?AMt1e2yzsR7zU0tnEcANl0KtWcxc79m6XziOkDw14Tp8fdiSmkQMOB+xvpwU?=
 =?us-ascii?Q?pWrIzeRYKAslIOOhdHfp3l87LZosXIDSEEukbXK5y/Djb8sOU16N2XC7c0Ze?=
 =?us-ascii?Q?egcLZQjX0e2DkcAmVM5wwO/wjcLV0cLL6U9SawCsk5NXrU+Yj1a1eHLd+X5G?=
 =?us-ascii?Q?7E94JCtjLfa3DsAnODcdlzVpOuksHN10XUtjlsxU0zeEZLGvBdwKvqQuKstC?=
 =?us-ascii?Q?PgWFOnmqk+itAov/wpToqBkdiW4wXA7YKjOjof4t0CNSmQ8iGNZwl71g9o2O?=
 =?us-ascii?Q?TrEozwEm3zhyDoLgrUg2h9wzCQnB1H4hwllNqIxje1bcNQ9vSnlsPimrZ4u7?=
 =?us-ascii?Q?VC7w?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 08:14:07.5186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 805f3d95-b7e3-4194-bb4d-08d89c1a669c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ftB6blYgZstcaZSnwPnGljys7YTpy+51uRaG1xia7fhw6d+XmWTjaeyYhsMxMakq+X1Xdx6hOp9BCUX2J5SBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7515
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

krealloc_array is used in drivers/vhost/vringh.c, add it to avoid build
failure.

Drop WARN_ON_ONCE, because duplicated with the one in bug.h

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 tools/virtio/linux/kernel.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 315e85cabeda..0b493542e61a 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -11,6 +11,7 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <linux/overflow.h>
 #include <linux/list.h>
 #include <linux/printk.h>
 #include <linux/bug.h>
@@ -117,6 +118,16 @@ static inline void free_page(unsigned long addr)
 #  define unlikely(x)	(__builtin_expect(!!(x), 0))
 # endif
 
+static inline void *krealloc_array(void *p, size_t new_n, size_t new_size, gfp_t gfp)
+{
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
+		return NULL;
+
+	return krealloc(p, bytes, gfp);
+}
+
 #define pr_err(format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 #ifdef DEBUG
 #define pr_debug(format, ...) fprintf (stderr, format, ## __VA_ARGS__)
@@ -126,8 +137,6 @@ static inline void free_page(unsigned long addr)
 #define dev_err(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 #define dev_warn(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 
-#define WARN_ON_ONCE(cond) (unlikely(cond) ? fprintf (stderr, "WARNING\n") : 0)
-
 #define min(x, y) ({				\
 	typeof(x) _min1 = (x);			\
 	typeof(y) _min2 = (y);			\
-- 
2.28.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47EA2D3D2B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgLIIP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:15:26 -0500
Received: from mail-eopbgr10089.outbound.protection.outlook.com ([40.107.1.89]:7333
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbgLIIPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:15:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ly9WvN+Om9nFp8U/k3QQfgkMpC8Xrr1lQIarlmw5gE84PCw8NM5dilUCG1SOvMUHlQm04XiRFCc6EJ/V/a7a8E3xR6+Jc+CPaMv781PdZs/hIsGCozdS5coiO2Kk3POQftSpzasSKWpF3lIsN+hOZvQomUYJ5WEkfION04P6/0mq06L3jL3QiaQh/USHb4nSn5JE52AM5LlKvg7smLIUhzmYTeTxXjTMew7i6miIXUQ3edMH+4I9ya+66qFn2o+ECo/4/sFg41wbI8TLeOQlEpd147wBW2mK3Zeq5X2zXRczQwx3qfDodw9Yz030+s7b75ZvZs0HVtIvAuYJ+SpLiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2J7IGu5Vb2+sxt4U8j8vE9G2Gmbf6hNF1+OvoRJWb44=;
 b=Z7hE5pvFDACLYp1C2Q5Nj78bX/r0SFS4JOYuCBlI3jOS6ug0n7hI5mzrByLJsnVJqGkZbdZcqqQBjjYHk0yWNTk1OA0KgyVEchNNQcIrS/1W3ymtGqDF2EUNQ6zGivMV7Nbb1D5S5EQgIrfC56Vu+0LkLcQu+j8DUXMpu0khZdZG/jGJXBXJd/KeMahwuSLahIigBsi7U6GoWbCdFpeOkmzkWB30bXj9cmufWmweIRwqKy+zy/Rb618q4dJj8w77TeysLAhCJ2CJw04Q2j+5pDVeAutM2JWa7rnCKiLye6BpKo5FehRK1iZ3+5RnmhtmlFfzF06yWUxt112zjr3gwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2J7IGu5Vb2+sxt4U8j8vE9G2Gmbf6hNF1+OvoRJWb44=;
 b=CwLR+1XGHKmxX1R36f4rYIa+2o53tWT82BDFyO5/b+yvtqcjFu8Hhyjvq08MxW1lhD1Ky/mhbjqAPmBEVGnESs1IoanP0ey8LmSHuqmb8MDajzmtFBpIWFu5wXkHDG4bjl4JXJsq5hsdjzgYpTmmDtgb6z+EhJWhnVdrimw0Y8o=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7515.eurprd04.prod.outlook.com (2603:10a6:10:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Wed, 9 Dec
 2020 08:14:03 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5%10]) with mapi id 15.20.3632.024; Wed, 9 Dec 2020
 08:14:03 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, catalin.marinas@arm.com,
        will@kernel.org, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        van.freenix@gmail.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/3] tools/virtio: include asm/bug.h
Date:   Wed,  9 Dec 2020 16:42:03 +0800
Message-Id: <20201209084205.24062-2-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR01CA0122.apcprd01.prod.exchangelabs.com (2603:1096:4:40::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 08:13:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d9b11b07-e1bc-4929-6c18-08d89c1a6429
X-MS-TrafficTypeDiagnostic: DBBPR04MB7515:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7515A9BD408EEC25EA0F5318C9CC0@DBBPR04MB7515.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mW1Mfmj1aGLPOlTaEve4VvMVR+nIwmS4BQGjxbZQ4RpIPSnq3EVV7NsIZjHLXuNCJ7DKA8/5HRHF59Id1mLmNit2gOGs+ZLxFbgFw6Iilzf2I5vkFD1qHVtAzjMJ+PFzJUhxyh/5dg3FFwelYCZbaOrOrz53zGtAwktDPHuhqLK6fWwIJ11bxRYCyAz5UB3JkicsA6Hq2mnwgE5n9uTeJGCX4GLGU/DUU9lvk2Ipc6+lG2DxjuxUhzR/ZoE7IddaTH1Tageuwsu1Nefvtu0rDhTuagM7alXrPkLFlUMTC02E03HiamHyj69bJ4XuiCWaReg/Q4V6NcpEyjF3NcQMivDPGj3nK9TB4Ne5A/pDROBzRXLJOlIz30rMTtrVPFJ4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(66556008)(8676002)(66476007)(956004)(8936002)(4744005)(4326008)(1076003)(508600001)(66946007)(6506007)(6486002)(5660300002)(6512007)(86362001)(6666004)(16526019)(2906002)(2616005)(83380400001)(186003)(26005)(34490700003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QLHRwo8xXm+hYNnKbEqoKIUZnH5LExhN8l/e5Q0jQROAuaV2C8t2XnvFj8qt?=
 =?us-ascii?Q?Ax/eRyDdFO/gkUVq1PkrJLtImm+K81F7dq80e137a2hq1OFjBgNT8vwDNzq0?=
 =?us-ascii?Q?cgb0HM/pa7gwG8LXj8TwzOiqnbklRL4c8Xwzl/XJRNXF2fcKNQseLQ+bLUlp?=
 =?us-ascii?Q?xbRE+t0iK53lN6K61S7BxytoCEeHWL1/e1oie0SXSNkxVmjaajt8I9O1HmAm?=
 =?us-ascii?Q?/GrLj0/IsEqMbpr+Bj8i09i9n0OI1DdON/mT4k1NJVdfUfd3KyNW/NtYmypy?=
 =?us-ascii?Q?lBTnKKQzQw3dKercvR7KuTh464dyRyFDZibY2SxvngQda2EvLomynovyI2d8?=
 =?us-ascii?Q?q1Bd16gq8yUQKtIk1lJzp40CZiln1kWs8cJytie+YtXhf/qTkTWCR544lg/+?=
 =?us-ascii?Q?Ss5eLQzmoFFPIq66ZLoMYqKteju3J7MgcJ1q8fRfS7+79CujE3NOFxO+uCMs?=
 =?us-ascii?Q?y0aq0cbzdfQeYNtjBSftSYOPsJC4oHOpWB4872GbFzoTSH5fDycIzfQkbFw3?=
 =?us-ascii?Q?Zr//exLi3KDPwE7ssRHrwZJfGSQdx72XU/pK4ThA0nRHzvpBJkp4WqhPxRsd?=
 =?us-ascii?Q?FmYOZYVBGLYZ16YGzz0Npru5kTIl/XUyM4APACYNmP8XowtjaRCbi+WqpZ5b?=
 =?us-ascii?Q?nvPWbcMR7MChYiqdtc6f1C6qvSHcpuPsMMO36zHTYeQjCnoeA/6pLB/88M9B?=
 =?us-ascii?Q?/mf8rh/l9njS8Mguv1w+iFW/eT+14YtCB4HQo4H6oIm9Vg1QtxqqkIzpIlMb?=
 =?us-ascii?Q?99DW0JD1Sm1Hin/GdePzyt9oBWhctEv3/66Z8b1s7U8jfZUR9ejDi9btBBIb?=
 =?us-ascii?Q?pi9y61JWgyb6T328F8n7lp6qxWH1uXuX/507OVX7uz6xBan1tjyBZZUOIEZ+?=
 =?us-ascii?Q?TVleIyOJib6GYM/BmEPJylfnv6TwdkUt47vVY3xy579YOkVPK4YNqOcLwJ6W?=
 =?us-ascii?Q?y6vij2IlElFly6vhQpn4Obw/Nk1kegKUrfb5sj7vOwnNGstSBQI8WsSAvM/M?=
 =?us-ascii?Q?j/Tv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 08:14:03.5594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b11b07-e1bc-4929-6c18-08d89c1a6429
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2aJvautoINBReBwf0qfhh0E23EWwx6ilrmJ4OWeBtiEK6dNGUc4ZXRMWIZYL/rjGCfilBtJevvWdrPT/IpaEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7515
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

WARN_ON is used in drivers/vhost/vringh.c, to avoid build failure,
need include asm/bug.h

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 tools/virtio/linux/bug.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/virtio/linux/bug.h b/tools/virtio/linux/bug.h
index b14c2c3b6b85..813baf13f62a 100644
--- a/tools/virtio/linux/bug.h
+++ b/tools/virtio/linux/bug.h
@@ -2,6 +2,8 @@
 #ifndef BUG_H
 #define BUG_H
 
+#include <asm/bug.h>
+
 #define BUG_ON(__BUG_ON_cond) assert(!(__BUG_ON_cond))
 
 #define BUILD_BUG_ON(x)
-- 
2.28.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0966F278168
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgIYHWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:22:10 -0400
Received: from mail-eopbgr20077.outbound.protection.outlook.com ([40.107.2.77]:24084
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbgIYHWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:22:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yo3gp2qzbTUzpNrGSwtmRuhF3gLISfh7ZT4QS/pp7Q38t9FM5vR1rqz2X1Zad/var3DwSmWy/HuENpMsCE9VwE0esHmiSQF4Tmt8MsKpwoDSxyaEiH7B5eyuFgS/3Gxgc8uItvxyYTS+Kt0vGFrS1qhn4Dh8XH4Q0o2ubsQAUxCe9/NSA6QN334w6j15wzB9kpyx+ssgmm23UTYf9c6de98ydCAmEd0CdE8ckt9VItEJUv0DUGHa8loaHfD+oHCXejbB12It+gXprNyXGT34zIPlLJcqNhJ5VeDyABM8I3QDki+pCt8f7u5Ub/wZl4reJkIfkQAoM+/Dhz7hwLjKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gE+XbXpV89SupHrHZiMQpHBZJfZvcdggzft9GUyC/v0=;
 b=B19lvinTA7lVaHB3jBHRD8rW1feow0hr4W4NA2Sihn7jk4jq+LGPdjuqFXSJs7q4tNqiG6vH9R1F0EFIYYpbolCQAwiWpMGMucSYsfKEX6j2hoetevy2SXT9qzaQNqqYJCy87DcPQtkIziGBDka+pH6gGFawgM7tyOLDBHc6rEmV5QkyKQ3V4IJomnJNyh3f/HQ2z4e423TC+qq6vvl46m8nidK0Dmdy8r7TbtzxsHdAKT8yQTEybR3Mu0LpV00cHEn1jpFAAwS/MUH/vsjMFRnkXkmkT8271Ym6JKHZ1Y6jIPQ63vHeFnD/wdFoh0RT4fdAxOSeDqcDFtNz9BbVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gE+XbXpV89SupHrHZiMQpHBZJfZvcdggzft9GUyC/v0=;
 b=R7pCecWbi6QyAFMyX32wQpVZunRD3KqhUfWkpvlkR0oYhCND0qMOk+V29RELf4ftOY2bxP0bEWVeufsCENZ+4ZV876KNiX9IjnMVFlxS85jE72oAt/VV/bLssO+iNetF+YLsXMEXglNaxpexjDu0iX3HBVLCF+WbuXRUZbdWfA4=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB3277.eurprd04.prod.outlook.com (2603:10a6:802:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Fri, 25 Sep
 2020 07:22:05 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.024; Fri, 25 Sep 2020
 07:22:04 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, rikard.falkeborn@gmail.com,
        lee.jones@linaro.org, mst@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 2/4] misc: vop: build VOP based on CONFIG_VOP
Date:   Fri, 25 Sep 2020 15:18:29 +0800
Message-Id: <20200925071831.8025-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925071831.8025-1-sherry.sun@nxp.com>
References: <20200925071831.8025-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0118.eurprd07.prod.outlook.com
 (2603:10a6:207:7::28) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by AM3PR07CA0118.eurprd07.prod.outlook.com (2603:10a6:207:7::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.18 via Frontend Transport; Fri, 25 Sep 2020 07:22:00 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c41263d2-f501-4bad-2748-08d86123b3fc
X-MS-TrafficTypeDiagnostic: VI1PR04MB3277:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB32770B90D1566885DBBEC35892360@VI1PR04MB3277.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T7oNrC6H7h5Dpeh0NGvyyAkM6G7FJXjw6Vj4VVD/DHdOnW/9mXwAMvVfk5ho425aV6AY/qm/EhsoE0rR6xRJAnWlj/wfIvsfEDjLB1pAk05O+/nxFz+yF08L3g0qBAdwzTksjhcJH8g6d5oZvbo9aLzxoJtO562WJazLiARTsHVrUnbnOJOfEkvQgDt1m+lY+2AoLsdIYq2cVSPSOvysTJBHw5aC8ICEfX266Pa0sqxdfBrMjN+DtZWgy9Yecp6hAZTOdeNZvShCDWgOzmxE5P/hVPOkGoRxDpPMI/f1WQSqKeJdOf2itxQj5ScKGkTXZwIr4aw+aHaWLJ1rg6nwdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(316002)(2906002)(5660300002)(52116002)(6486002)(6506007)(186003)(16526019)(26005)(6512007)(36756003)(4744005)(1076003)(8936002)(2616005)(44832011)(66946007)(66556008)(478600001)(66476007)(86362001)(8676002)(6666004)(83380400001)(956004)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mFkivYkLfTNZM+4HOabBhaV1iGK5DpLNUTB+rjJ1v/EfHVGM2PJTUHAUEptDCK/Td8YiVYeWgVrYGFZ+KmTXZnHHrQNL2wWQub/ZjD8tg/kB5M6YH6Te0d/SYnfafwn/cGJZWjdaQHcHd6rJAeeif6yhalRky+Lrz096/ZcZJrxNOfiJifiljoGf5qc2rhBNc1UsUjjAyygarTaz2OCp88YV81ry+yd0yM9b16PjLX2md2HC8PYgUg5yQg2JuDzbykGzquUP6LeZjPA5jKp+thUE7XzuLyNciTXSlHJ4fCYKyOfAgw2vtqxqZlO/x9uMQexKcenIPMKwz4TXXbZ81I5JN4/OsVJb2txkSalYWwUPRiNzWep2tKkKppIxmM4ZSMM5ZMdOBgNYS1ha4+ej8h5KTd5YTNRhQxhZYlACDguQYlJr9Li0yccifnxuOmbNRcDRN9vYyRdFn8/pzdzyt0H+c00k4i1fz2CbGi3fiI0+I6EFr/pMhtwWXDuMDL9q4tVM7QuZk+q4d65wnZk043I+m2qYsg/Lh61NdyGZHLRXXXfVVZK3uXBXdZWGzLKl/Moe19S5es3A1XCWLo2v37YfK1OYgxNuLg0yIbimxMMLr9fMw1V04S5wsrlVWz7FMTqwgvZQa9DMIP8qIY9oQA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41263d2-f501-4bad-2748-08d86123b3fc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 07:22:04.8769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juNLiYIaeNpp05dJ5790lc6IEYlrZ7s21S3/Y1PLG2Na9ehuykJyavVCpb7poV62QGgemeLme792lih66iPgqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3277
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build module or builtin VOP based on CONFIG_VOP macro.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/misc/mic/vop/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mic/vop/Makefile b/drivers/misc/mic/vop/Makefile
index 579da3868c8e..51b9b0022786 100644
--- a/drivers/misc/mic/vop/Makefile
+++ b/drivers/misc/mic/vop/Makefile
@@ -3,7 +3,7 @@
 # Makefile - Intel MIC Linux driver.
 # Copyright(c) 2016, Intel Corporation.
 #
-obj-m := vop.o
+obj-$(CONFIG_VOP) := vop.o
 
 vop-objs += vop_main.o
 vop-objs += vop_debugfs.o
-- 
2.17.1


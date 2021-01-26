Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D441D304E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390508AbhA0AYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:24:50 -0500
Received: from mail-eopbgr750089.outbound.protection.outlook.com ([40.107.75.89]:13390
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389191AbhAZROM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:14:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbVUBC6bBbw8KJjXznC2q45wBClpjvsimctBajjP3sjwnSQz9IF7RLItzvdIK++O+5SgdCO+x5CsCf+/2m+omMr0Sem62F81iLcPSIZLajmb7jDdxR+HsziZhlJoJ1hsbfCdIJnO9UsVNEP7pDjIRAxDEPNYoXyQcv4BmlF5WKIgszDkPuDz2RDxc5rRIn9KGGLye7Op5SDo/3QZhsPdRcKdpkC81pOn/DspaUwafSqcLfDzCilV6czKLnATJ4WjGyTYdGUk816fTk0wuVA/ZKhCTO5EuPbJc5HgtMx3MGy/87Lhc5TF3EeFFbyQKW49F9NPxf+Faatjit1coiepSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxErnRnxqFGKk4dPWiB/SDO+5Gj8QWabcZ35H9qqN3I=;
 b=iSs6VjpExCITHL+NO6NxUHDRyue8FTQXu/0DQDne606ugZikr0iAlNs/NPQ2unkjyfp2sc3XHdJ4pVNB4BvXm7leIS+Htno5o4Kwkcyw/8DSVnS7s4sYBFl1Ey6y0oFxD9RKBPcobumzpUvPT2/ZJD8e74LxlHVXSFa2qjY1RjKWQdaqHWLsNDsao07Tf7Hb7hSm0CtF+U1x3onqoIHYVZQfxWAi5ZYVUh7YQOD2K8y2zJr5sWN0sR/sP5W8CPtHyxRVaSWU/ucdRFJUBr6Aq8hvP4BwlGw2geFxvSFeYR6Xz+c8Bej6SS4SCHwmQtA4Fi532m7osuO3ZAjWuqMgiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxErnRnxqFGKk4dPWiB/SDO+5Gj8QWabcZ35H9qqN3I=;
 b=gxVpPDBWcBrECo580aScfVBXP49UP4fQMDdJ6QSZGqGYYtKsN38Orp6jyZOEALSV19TCMhsS82RSeqsPhH2rwJ5bhFn8oZG303I33qTCZk4/CEgfal9HuriFIc/cPOlvaPk7yZYmCKaoAiLDJePf81/j5Yx9c10Yo/a1TFJaue8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2763.namprd11.prod.outlook.com (2603:10b6:5:c6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Tue, 26 Jan
 2021 17:12:29 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%4]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 17:12:29 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     lizefan@huawei.com, mingo@kernel.org, tglx@linutronix.de,
        josh@joshtriplett.org, yury.norov@gmail.com, peterz@infradead.org,
        paulmck@kernel.org, fweisbec@gmail.com, linux@rasmusvillemoes.dk,
        andriy.shevchenko@linux.intel.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 2/8] lib: test_bitmap: add more start-end:offset/len tests
Date:   Tue, 26 Jan 2021 12:11:35 -0500
Message-Id: <20210126171141.122639-3-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126171141.122639-1-paul.gortmaker@windriver.com>
References: <20210126171141.122639-1-paul.gortmaker@windriver.com>
Content-Type: text/plain
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::15) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yow-pgortmak-lx2.corp.ad.wrs.com (128.224.252.2) by YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 26 Jan 2021 17:12:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45b1dabd-7925-4d7f-50b6-08d8c21d8f5b
X-MS-TrafficTypeDiagnostic: DM6PR11MB2763:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB2763B4AC342A1B4451DEF33683BC9@DM6PR11MB2763.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJqlc1tLkt7ardI+cKYKhKX6GTi1dzzGQw2wHKXnwzvisUdN+1jbbBcww9ao3nF0hhmoTLqzchWXPN5clAYnBmV4XtBD6xE06f38LiwOl/U3/1S9w2PD0k7etC6IGf/PNa+zN6c+LCF5ytvsoJq67RAweOGKFVBqKQvFj+vVTOJ/kI4Z108WBxhHlvZDFlu96gjvG7gHw92M1nMVLYZVVwdDISmfLjTgeqq0kaWuSNocDeibk0p1r4aJcrPFeB7Jep3vpHJROskXPcbBaw9q37WcNvdtIrqVY5V/pZ4aCLZDWaJVK8b5OuCbkdRN98kF05BA+r3NWiFPB/qnwnF+fxZopBRDSWRZX3jVCT/vYLmMNeJw9mIKgrdKSIbOdEVUQ54pyZ6ok0bCSM7jf+/cdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(39850400004)(396003)(136003)(6666004)(86362001)(66946007)(316002)(8676002)(52116002)(186003)(26005)(2616005)(107886003)(1076003)(6512007)(66556008)(16526019)(478600001)(8936002)(6486002)(6506007)(5660300002)(2906002)(66476007)(956004)(44832011)(6916009)(36756003)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?w6b2Ya8uukJBXbBBwODMWKbxUXNk3qv9y9p49SL9+IR+5U/Y7dkqmCjCRvtj?=
 =?us-ascii?Q?a5AmqCDK3Y0s4g9Q3OzcvrmgFQOqujnu98IE0vEZUiE0henQ7JOBFWHwQ7ti?=
 =?us-ascii?Q?OhXcoFehgNYtbRNMoBZ61M3vt1MVurLYINuK+N8OBONUNLAIXpMMfYGTs3F6?=
 =?us-ascii?Q?yI+QoiWKi4b3lakNZpE0W9Q4Tup5yPzsRdVMSY2jeyoqQqEYr2N4wlo2yYVd?=
 =?us-ascii?Q?SNmzHWvtd1tkcDc1l8haHQfG8jg9jK9vPE3uzaLwxhExqcWTM67dsY+UF2G2?=
 =?us-ascii?Q?JGsnQEpqOdg6oUFXz1oYuz6atP05DrvKveSgbLWgmMm7InLl5Zi4FNVUxg00?=
 =?us-ascii?Q?aDqGLzsJJv6kvnrdNZuICcKOFZSWylZyY8bFClg1O0YcFe9ZPABaLuPNoCIU?=
 =?us-ascii?Q?bKAt/qGNy1QcBA/0GItH5BzLRhyZJii3sJfPx+F7in6BiA0PSKa1Ow1GKDwO?=
 =?us-ascii?Q?OalAIDVW+wBiIkE+jMCSa0Bo+8hmg8KPhdSm2G5ydIiUoaljurVckeNdnCN/?=
 =?us-ascii?Q?TkEd4/O+oxHak9+ao1q43+BAajiTHO/wywVKzp7tbY2K1wC4kBqRMSLccYz7?=
 =?us-ascii?Q?t00BhjAQAGtoTCLw5QKWuncerV0n842R0zggIeIX+rX718SG58WWKQD8B837?=
 =?us-ascii?Q?erQkuGJrAB+KwSr64IRhovE/+ADM2NLKT+zirFwssDbQhyhEDmFt9xFQh+aA?=
 =?us-ascii?Q?jW4WHOUkm+WLo1g92C77jzWz+mlYTNWtj6RR2Xjnta5G7ERcBh4HKAnfILLM?=
 =?us-ascii?Q?GKoYULizl0e1qt2Oavu8hQLCb5G0B5i/+LWJ29RT5k31IcGEcM34kUfT1ht/?=
 =?us-ascii?Q?nSZ1+YIdA3mXH6W9t37MTlufnxrr1uw3v5pFdyb1BUjULjDqXD+DrNcfTNAL?=
 =?us-ascii?Q?IePqfMVxius3hHoedzdKVhoC6EuYrhj8YrN3xxAAlApFqY/ePkkiVkQ3s18j?=
 =?us-ascii?Q?IOBHWMO03ZOp9w54UWaKk5AFB3GccDLjrYE6Ed68G3aMFzaWzG7ojpcN+z60?=
 =?us-ascii?Q?xTgiIPpFd3uB48d8kzJj+SCIfQ9Hce5O7rynXqgtOZwF8WaHinYo2NoWyZ01?=
 =?us-ascii?Q?x0UPXU1U?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b1dabd-7925-4d7f-50b6-08d8c21d8f5b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 17:12:28.9604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsJIp1FJpEXZTal0tmZ4GcLyPH6ezuSBPtUkOr77DM9RMJmxArE1G2NQpR2l9RxO2CA1A5+V+wo+xQ9a0Xv3ddZDouo+zUVo7CuW1L3O6Wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2763
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are inputs to bitmap_parselist() that would probably never
be entered manually by a person, but might result from some kind of
automated input generator.  Things like ranges of length 1, or group
lengths longer than nbits, overlaps, or offsets of zero.

Adding these tests serve two purposes:

1) document what might seem odd but nonetheless valid input.

2) don't regress from what we currently accept as valid.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 lib/test_bitmap.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 3d2cd3b1de84..807d1e8dd59c 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -35,6 +35,8 @@ static const unsigned long exp1[] __initconst = {
 	BITMAP_FROM_U64(0x3333333311111111ULL),
 	BITMAP_FROM_U64(0xffffffff77777777ULL),
 	BITMAP_FROM_U64(0),
+	BITMAP_FROM_U64(0x00008000),
+	BITMAP_FROM_U64(0x80000000),
 };
 
 static const unsigned long exp2[] __initconst = {
@@ -335,6 +337,26 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{0, " ,  ,,  , ,   ",		&exp1[12 * step], 8, 0},
 	{0, " ,  ,,  , ,   \n",		&exp1[12 * step], 8, 0},
 
+	{0, "0-0",			&exp1[0], 32, 0},
+	{0, "1-1",			&exp1[1 * step], 32, 0},
+	{0, "15-15",			&exp1[13 * step], 32, 0},
+	{0, "31-31",			&exp1[14 * step], 32, 0},
+
+	{0, "0-0:0/1",			&exp1[12 * step], 32, 0},
+	{0, "0-0:1/1",			&exp1[0], 32, 0},
+	{0, "0-0:1/31",			&exp1[0], 32, 0},
+	{0, "0-0:31/31",		&exp1[0], 32, 0},
+	{0, "1-1:1/1",			&exp1[1 * step], 32, 0},
+	{0, "0-15:16/31",		&exp1[2 * step], 32, 0},
+	{0, "15-15:1/2",		&exp1[13 * step], 32, 0},
+	{0, "15-15:31/31",		&exp1[13 * step], 32, 0},
+	{0, "15-31:1/31",		&exp1[13 * step], 32, 0},
+	{0, "16-31:16/31",		&exp1[3 * step], 32, 0},
+	{0, "31-31:31/31",		&exp1[14 * step], 32, 0},
+
+	{0, "0-31:1/3,1-31:1/3,2-31:1/3",	&exp1[8 * step], 32, 0},
+	{0, "1-10:8/12,8-31:24/29,0-31:0/3",	&exp1[9 * step], 32, 0},
+
 	{-EINVAL, "-1",	NULL, 8, 0},
 	{-EINVAL, "-0",	NULL, 8, 0},
 	{-EINVAL, "10-1", NULL, 8, 0},	/* (start > end) ; also ERANGE */
-- 
2.17.1


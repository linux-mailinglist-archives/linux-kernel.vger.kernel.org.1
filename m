Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27ADE304E65
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390758AbhA0AaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:30:04 -0500
Received: from mail-co1nam11on2053.outbound.protection.outlook.com ([40.107.220.53]:44705
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389673AbhAZRPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:15:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiWyQi9+WYYEQ9u4/KAkoJBBjc/PlofriRXt8XEdDoe7WWOrdXTXwxN8+dz5ws0Rg8xQ6tY0i7mXDa30TIEnnYUuB/mlclIXeRs54mmWhKFBIFQGn7Xk7T0P5vazAijBfun66BBUCwxMUy9X1cfeU1aQFs0xQoQjKNeXVVvIORDjFg47hhydxL7LmyCa8zWe1mdUXhFTu9qbhYDBZDSp74iM8YDj9LPb0oF4izZCuoYYI4PYuDUZGIi083RSzbMQm8OvN7GubsqS8a6kMTKBFMW+7cAdhj3zLbhtLrKCrQJKDCfZaWvwinRzdZYd5Mo+hOoLMgOgwCm9CuM8OS1V8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6E0XoQJ4MT18FQeTjnNNHXy1vhlKSsmitikBwfInma0=;
 b=Fivu5h6+kxpLF5wWSM4tg8S+/QSsuplOoTyTBXx6xAnjpVgUIIqNjNoDQswMW5euLXoEoLIaNkFk7FQwb/CWqI1titKa8ExVVCRQx3suqZ613UWDXjW7gJt9dtXTeXDiZPZ8re48W8J7NNZQGUz6vI1ETvbfMCl0dryo2uvocOofpjAdGynpgU3qsS6ychqTTLu2bxbn49iAB1R1kr1RWcYhHg6LSdy8aNbcbFyNfiuB2CL0eIHpr3TSH4gyLQz/TsNWcamwqm9QN9aDWanBbB/4sA/Vq6Q3Sl2P0PKmU7YXbF0xxmWyu/TkF5f5tEsinQ/GqvmPwyRjdN46pdA4bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6E0XoQJ4MT18FQeTjnNNHXy1vhlKSsmitikBwfInma0=;
 b=ki9kKOmvZgBIVDUX4tt09pAL+r7SsyIE30jyIuqnuoaCyd0a298NFrHSD7AeTFvZ8dTph7pdFneLTKiAbWsR5wSmoNjlSSdEWsQM7ii0LHSmmx01lQ4HrGfFJGgqBX2wJUpOQm0PDtHu6a0caUqPWBhI7AL1t3bipBQIIzthOis=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR11MB1900.namprd11.prod.outlook.com (2603:10b6:3:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Tue, 26 Jan
 2021 17:12:34 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%4]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 17:12:34 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     lizefan@huawei.com, mingo@kernel.org, tglx@linutronix.de,
        josh@joshtriplett.org, yury.norov@gmail.com, peterz@infradead.org,
        paulmck@kernel.org, fweisbec@gmail.com, linux@rasmusvillemoes.dk,
        andriy.shevchenko@linux.intel.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 7/8] lib: test_bitmap: add tests for "N" alias
Date:   Tue, 26 Jan 2021 12:11:40 -0500
Message-Id: <20210126171141.122639-8-paul.gortmaker@windriver.com>
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
Received: from yow-pgortmak-lx2.corp.ad.wrs.com (128.224.252.2) by YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 26 Jan 2021 17:12:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7c71196-86c9-461e-ebcd-08d8c21d92b9
X-MS-TrafficTypeDiagnostic: DM5PR11MB1900:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR11MB1900848A976C4E9352D8833D83BC9@DM5PR11MB1900.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ED2B9fRoa3KmFXbB+u9UtYzHYLrThwEUjqhDSLOaqaSJieXBRv5VZKIeqdD2oF8IlAW5Ogr1F3vew9GiM4mFb60Z1d4EpL3xUeUjYIneTKFlyqxan290/NrGyPkDojnEwwrXbDUyxoMSFzEYa2/npFz3D751LVPHn0T5jUmf0VEUu5JwHVlZS77SncSldk6EkY1p/idDkjqbuCUdhSOeiJLf1bLfaCrIw0ExC91Jp1ZvEh/PwQyRmvf5SKnEWUbWVCe3jY6rUl+b8WqGQPxCQ2jHMw5hlwGh5CZRGXpuEIemWu2AOIrgVv+KfAauB6QDZZnlzsuuJWx3gT6j4Rg8tjjKmG8AbM14/jSqUVFiAcr/ryzU12WWXtSQ0yS9x7SY/qU7sYqatIiPWvdqZVyzAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39850400004)(366004)(136003)(346002)(6506007)(6486002)(83380400001)(2906002)(66476007)(8936002)(16526019)(5660300002)(4326008)(36756003)(52116002)(956004)(6916009)(44832011)(2616005)(7416002)(66946007)(26005)(316002)(8676002)(186003)(86362001)(6666004)(6512007)(107886003)(66556008)(1076003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HKaoxcjxZJdsrMVtbbMepdLtLXzXz41w58M/ca9qfigbceiF38VNrsxvB5uO?=
 =?us-ascii?Q?Td7Lk0S5RZ6KsNweP8sCj/05UFHGauZZmmUjk9q1xLdktiPexsJ+42l8vNEm?=
 =?us-ascii?Q?hAPNKyYtFeCSQqmH0KAK3hfSAKBxQnD0408qaRkjxIsj39h+m1AYPGp3Qjm7?=
 =?us-ascii?Q?TlkayND8r3yU9oWqrq6QEMskUjE/jtO8o2uv0cilWGYJdvz5RtBSjYYTWRm+?=
 =?us-ascii?Q?7VhXD/eW5kLonq9J7dk5Zgg5lryAZd2zPHQ8k+XOGyhFb0hdqUbGfQCSm2xy?=
 =?us-ascii?Q?EZXKmdcGcF3luXF4JD4+oW3b+rg9Oc0aIz2OwjqXsCfP2wbilS6Z00cW1wUt?=
 =?us-ascii?Q?RxyRGb9y7zzfkRAGFg62yMUnu+A3UXMLGr7p0+EhkwjBfzjwR2VpyGotyXwO?=
 =?us-ascii?Q?TM4nrCWJlypC07o3aPCCzCKkq0I2HVVxiQF10XnQ42fCIHK0sVQ2QvrejI/K?=
 =?us-ascii?Q?dZiU8YGDudUfvpIgn+HUTijMpf6UWxxDMLlfKnnQBb7D4aHHPbCnyK+8U5U6?=
 =?us-ascii?Q?szoJz+b7UXc5rT4+bY8y+i9/VvUC7L2faReKohuLerjIxnNQS9omKfRAaCDj?=
 =?us-ascii?Q?B4K/3a1Fc7vimRF9A9ukjFKTvbYcwwtPvzjfooy3F3yNNnoDYictQHwuuBsv?=
 =?us-ascii?Q?W5bxCyPiP3vkOd8XF4RNd/KWmJHIA8jaQZHVyRLVp4LCJiwGwA+OQlg43vxo?=
 =?us-ascii?Q?TWC56ZCShT5y9i5kA5H2Clj03kYHdvmdFeoHlU/ZJyfIxAxDPffDR/zaur7t?=
 =?us-ascii?Q?EYJ/4Ghj/9lERwcDF+/MCnu35JzW072K0jYRtu4cDU+3ipODdE1Snr8TdHzo?=
 =?us-ascii?Q?CILKI+Rh1aQzxDVm3NeodX0dJVhT99QJxQgGOwIs8/f9hwH2cOcjXMmoJs63?=
 =?us-ascii?Q?CUv/YmVUOtFjG5wya4bnQ7DhGJ3t8iVaMWFzV92GfLf6X8lyltIziYtV/YKw?=
 =?us-ascii?Q?UH8CxSF5AaqMZEI/akmkTiMliLSe4GzlH/GoODokovILi4Dk0NYJf0RQv6HM?=
 =?us-ascii?Q?hvveTtJ9Gbx70ZiTrK8H9myqCMMl5nBZ6ncptQPfUX8pnyEh34z8k6WELwoC?=
 =?us-ascii?Q?yYF1ijHv?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c71196-86c9-461e-ebcd-08d8c21d92b9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 17:12:34.6922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XiBPye3Ynf2lxVAVXox5mdmLhJ80zPHwehvcH4xs7IWBh/B6RDoFmlZU1DRGYRRFno4xsH8sMu4wAE6VFB+BCJmSaZUqXsaBlSpCJD9ezFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1900
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are copies of existing tests, with just 31 --> N.  This ensures
the recently added "N" alias transparently works in any normally
numeric fields of a region specification.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 lib/test_bitmap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 807d1e8dd59c..2bcea2517c03 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -354,6 +354,16 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{0, "16-31:16/31",		&exp1[3 * step], 32, 0},
 	{0, "31-31:31/31",		&exp1[14 * step], 32, 0},
 
+	{0, "N-N",			&exp1[14 * step], 32, 0},
+	{0, "0-0:1/N",			&exp1[0], 32, 0},
+	{0, "0-0:N/N",			&exp1[0], 32, 0},
+	{0, "0-15:16/N",		&exp1[2 * step], 32, 0},
+	{0, "15-15:N/N",		&exp1[13 * step], 32, 0},
+	{0, "15-N:1/N",			&exp1[13 * step], 32, 0},
+	{0, "16-N:16/N",		&exp1[3 * step], 32, 0},
+	{0, "N-N:N/N",			&exp1[14 * step], 32, 0},
+
+	{0, "0-N:1/3,1-N:1/3,2-N:1/3",		&exp1[8 * step], 32, 0},
 	{0, "0-31:1/3,1-31:1/3,2-31:1/3",	&exp1[8 * step], 32, 0},
 	{0, "1-10:8/12,8-31:24/29,0-31:0/3",	&exp1[9 * step], 32, 0},
 
-- 
2.17.1


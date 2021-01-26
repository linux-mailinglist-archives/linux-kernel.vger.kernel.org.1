Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A89304E4F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390524AbhA0AZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:25:06 -0500
Received: from mail-dm6nam10on2064.outbound.protection.outlook.com ([40.107.93.64]:23968
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389296AbhAZROZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:14:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4CVPuvnT02EexdOrTGfxWQddyQZ0PG71F/VF8LwcdLOlY/pYVdlQNhZ7AiN8YU+nMft5XEM1mqsCXH/E0rRHLUT7OuW+xGizKWm5rMqPduXvnaPXJHfnN3vMjIU8x0vYk5rraMUPenK0dRNjm1IbQkgKwTv/+mP0dwN3Be0cbLb1vROJ2aEpYvdPdMv2dumAirKn6aIEH6MzE26EpN4yfOYGSV+S4Q7uPShS1jZfVAnPwLs4key6SVRdLVDFXQLza1Vn+ZjJYyldk8bvpaNyScsXC84rsvZF+EEvJWxShOrTDguAcnjuTUAPFuyqySnyQSEbR8IAXCs5H8FHe317A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPGqyTfluLn04owBRXkL270w0N1JSjYLZflejVexBHU=;
 b=F0HFXL9zMu5FjBP6WRSTMEgZDnXaWi5WkLAEnT5XrR9BTHfQWsnA4BnipbP0F8BmvnMheFt6kntfMAAa3Nv4GQiyzPLnYbxzct0g90KLwm95OGCXEafx7tKFTWCUCwl6hDUz9O1elddDN7/MLubXOs1SsnW4SjhAW1qfIIuEnK3ml0ci4DUkVLu2OM/3+1kjUrmFEDqgrA99mIzQ1qnbVpCNwMgzNC7k6Ct9PpE0EM3wPR27k94s4HPW37uk1RXTRPuo5cyGf98fJ/ywqekb47LJqXkvu1B67KR3FuZzsVa0DtbbBWFvz7Kkt7HmNJtR+5gS2m+cAmKaYGB07rhilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPGqyTfluLn04owBRXkL270w0N1JSjYLZflejVexBHU=;
 b=du7YnWkIM89xP5aPDhQHrzw4cOacnVszFTIt+NcYDHEXVRKfM/s5r9FdXkUf45L/wb5GaBeEIyOBzSnRhARAMzWsehvbiPOUR35f6exgSHDhhHw6mPN+vo4ALkjngXopA7B4jJYLUWA1Qhm7XNZHeupzJ2zXnB4W4o1thGitdq8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR11MB1900.namprd11.prod.outlook.com (2603:10b6:3:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Tue, 26 Jan
 2021 17:12:32 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%4]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 17:12:32 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     lizefan@huawei.com, mingo@kernel.org, tglx@linutronix.de,
        josh@joshtriplett.org, yury.norov@gmail.com, peterz@infradead.org,
        paulmck@kernel.org, fweisbec@gmail.com, linux@rasmusvillemoes.dk,
        andriy.shevchenko@linux.intel.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 5/8] lib: bitmap_getnum: separate arg into region and field
Date:   Tue, 26 Jan 2021 12:11:38 -0500
Message-Id: <20210126171141.122639-6-paul.gortmaker@windriver.com>
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
Received: from yow-pgortmak-lx2.corp.ad.wrs.com (128.224.252.2) by YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 26 Jan 2021 17:12:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0aba7cb-e3a7-438a-a8a8-08d8c21d9174
X-MS-TrafficTypeDiagnostic: DM5PR11MB1900:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR11MB190043BB44A440121905EDCC83BC9@DM5PR11MB1900.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZnIRoZXOZyVzKIMAhLfnbuCedszcSRSaXCXuwylv8oAxHew757tkEIEULPqB+yvBm/CxyeS7WL9/0WV+dHj2xn1sg9lXj7PaFfoqBcQGG81lBOLlZ9UHig9CAIQvUCELptoyk7MjFK5JXA0XMFYxILaetD79EWOJXvHB7Hl7SfEU8S1BlKCIzLxRa6MXB1gdE3VFv0uylUxH3fSjv+8uRtc7ds7B5bn1SddCpwDfoYLin2o8NaY6bJoDvdXgUYxfOcVzsh0lK5yDt0Q1S7at9lMebO+N3iV9Z/6EbKZPOlbp7synoyHCJKmY92eEwpNAJA4Zb4JjvmzSZkImVb+6zVfHEa4khZ0+BgFeey6LduHJcffw2kQGkc7zsYy0j/umDeFGplYV46UzUmrIAuk5cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39850400004)(366004)(136003)(346002)(6506007)(6486002)(83380400001)(2906002)(66476007)(8936002)(16526019)(5660300002)(4326008)(36756003)(52116002)(956004)(6916009)(44832011)(2616005)(7416002)(66946007)(26005)(316002)(8676002)(186003)(86362001)(6512007)(107886003)(66556008)(1076003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?grwLN7flC6dQX9IUquGCcX/1EcuZLDKQdQNwdbKSg1AXHPgWNFbm5EpHKoR4?=
 =?us-ascii?Q?lCGi/RN7Iy6P7EZShuHJoQUS4pZiL3MAuE0NJuFzjFhBrViIRpw1hA+MKXr/?=
 =?us-ascii?Q?yKseV03ntorEeTcJwRj2/OzO2AZsWEFTjoHHG5eo9C4vG2YvqHs9GJOTknNj?=
 =?us-ascii?Q?WLGIthFGN5f9xDWNuGNru6JImE1//1GoBLiWyxjpPoJtqnwgTmX6hw9ZwXHW?=
 =?us-ascii?Q?GBSM05tiXlq9CjsCg/OeIdfDxoXjR4PnOELFnlXxS80HYvsOC2s8jTJBDr96?=
 =?us-ascii?Q?nfTSQsfFE9tZzwWJxWanOQhV37TGoGDX+SDn8UFjIxrHFXs2P6XTUgtVjIxm?=
 =?us-ascii?Q?Iz0qzAArdvFK92zBntBOst2+W5y8QLkPcfb8MUK3zAMYPZcw1ESrgFVEvK17?=
 =?us-ascii?Q?XPu/d82xqWwKPm1Pf6rjrLCS4MyQf7klqQjskZ3gHMlIIkw8sySd4liuOYk6?=
 =?us-ascii?Q?IaCeqY6TPMgl+uLQMXxb32QwmPmIdroqN9B4/3/MRJeYp49vT/jk1EkW2lBI?=
 =?us-ascii?Q?PYFxigN89Y9ySwQxIUKQByCf08/uI3soNWHjaDSXDhij/PNWYSijPx0CcYiY?=
 =?us-ascii?Q?rumfG31J5pxrVPA8PaGzhrgI3kHBQZfaWx7MN1Oeelz0EAMNNm9cL3EpX+ou?=
 =?us-ascii?Q?ml5uriex3moomeeiIo9ydQ2khm5/9YSrKqhI6E7ws9vVFRNd/mWxTNpMOM0l?=
 =?us-ascii?Q?KZinKQwoPySKSmuSmS0AkvY4BxTIPpiHwgd8wGmvDs59bRz5RZ+4e2zr1Ls1?=
 =?us-ascii?Q?CbEWDbsXqeoiaZtiWkchiXtmB3yH8UzWVWLMLgspfyElJrygrEJXCU6DlbUy?=
 =?us-ascii?Q?ItyCZBtQ2EvCRGFROIL3AbtKMwHKdChFdYJsr53k08RuUTznm8RXv/8eXTEY?=
 =?us-ascii?Q?vWQUgq1bzExcfmQLFvIpfKVQc+T1CzuHmEiVVZOSHfPgMLxM/y1/ggKTHnjK?=
 =?us-ascii?Q?xJ1O86285/xvVUU8PNDGcjmxhKXjUKjpTp8wH0li2OPnpGs0gMIZ7zDWbH5P?=
 =?us-ascii?Q?+atzSudSQXaEGnj1CoOGOL0rBROrb1ircg3/vYuTTu9IgVAhielW/AxblP4K?=
 =?us-ascii?Q?CP+c3wZM?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0aba7cb-e3a7-438a-a8a8-08d8c21d9174
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 17:12:32.4680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5Br5H+87MYvChj7TpeRROlXhr+C3L/wGdoyvlJ9wWcCxQxaNNMQVYdgPdSKS0Kn6vVXULdQlgefCJowEG919S3ZuQjtJg+FWPx0mxCCgBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1900
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bitmap_getnum is only used on a region's start/end/off/group_len
field.  Trivially decouple the region from the field so that the region
pointer is available for a pending change.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 lib/bitmap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 833f152a2c43..f65be2f148fd 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -533,6 +533,7 @@ static const char *bitmap_getnum(const char *str, unsigned int *num)
 	*num = n;
 	return str + len;
 }
+#define bitmap_getrnum(s, r, pos) bitmap_getnum(s, &(r->pos))
 
 static inline bool end_of_str(char c)
 {
@@ -571,7 +572,7 @@ static const char *bitmap_find_region_reverse(const char *start, const char *end
 
 static const char *bitmap_parse_region(const char *str, struct region *r)
 {
-	str = bitmap_getnum(str, &r->start);
+	str = bitmap_getrnum(str, r, start);
 	if (IS_ERR(str))
 		return str;
 
@@ -581,7 +582,7 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
 	if (*str != '-')
 		return ERR_PTR(-EINVAL);
 
-	str = bitmap_getnum(str + 1, &r->end);
+	str = bitmap_getrnum(str + 1, r, end);
 	if (IS_ERR(str))
 		return str;
 
@@ -591,14 +592,14 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
 	if (*str != ':')
 		return ERR_PTR(-EINVAL);
 
-	str = bitmap_getnum(str + 1, &r->off);
+	str = bitmap_getrnum(str + 1, r, off);
 	if (IS_ERR(str))
 		return str;
 
 	if (*str != '/')
 		return ERR_PTR(-EINVAL);
 
-	return bitmap_getnum(str + 1, &r->group_len);
+	return bitmap_getrnum(str + 1, r, group_len);
 
 no_end:
 	r->end = r->start;
-- 
2.17.1


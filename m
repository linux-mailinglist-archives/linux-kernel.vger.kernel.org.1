Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165442FF805
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 23:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbhAUWfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 17:35:33 -0500
Received: from mail-bn8nam12on2053.outbound.protection.outlook.com ([40.107.237.53]:41085
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726501AbhAUWfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 17:35:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0KFoJqmZs+ftjugiPnbb56lNVWOeNvFzPiFLEmcUe9LDU8FSrqqNJqtr9TnCUFp4zk4EtPk0P+gJOoNOM6GqUJQFYur171tGagbQg2vrPd4pFvMU0syyygJ4k9Tt8ka/i2Sz0Z4M+VSrmZG0+/4LsFdfyNOyk1wcLDzveo/T8sad7uuM4rycTVGbf75U/5W9URcDJLlIDyvAEYqCFRdYrBwT/5/6vn6r+79mVX0gEbwYM61tYcK+A0PBnrSxfIaWjCjymXGTW3vjXFsKe5qz0OSZCO9wUC7v444jZESXfY75+utAi0PIf6xXo82yp6KtORvr6Wud2zxpDszh73ioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A5Sepq5BCfckorQUuh7RSm+qsW9Y+/2Tr2dTKUyca0=;
 b=f8151OMG0pC0zz3hG8CVq/pu4UaYqxcUAPanF+WBH05X/3+0XRxIsfsh+TsKdoGxi4YwY7lvJAlYVv+yWjBE70tY7p9qo1/63MUT85v/UVxwgjC66vcy4vMwGW81i8YuJmH7adziwJ6oBLPESxwUXoOVqmamA9bTlWfY1zXhLq7mLpmo/dDfyQgF2/FoibSwyq4cAuBtVqqfVnOl6TM98u+1sEoAYTK3jk6ih1ANNIfFlrTcJD4V7FX5vjWDqtqz46J/czjdJ/q7ZSxo13Wkc3Za+Ubc0kFz0JCXhWLqSVUlBb5N6dA30XDUKzmjV2H8hIdOMFZczxsB1o39Yw1Vhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A5Sepq5BCfckorQUuh7RSm+qsW9Y+/2Tr2dTKUyca0=;
 b=EzmxqGL1sTTJB9EZYiWgtP8eb+zOEtDQ1nHbyivyQZO7ULT9SsxIPIn/06m/0egrQP2rEKWUwzeq4ausjgZidLoKJk/E1jVZ7iaRBhlKEdd/un2hOmMpMYIJIJgIi8/siZg8HBMQtyL2sYfTgilUZ2CSinrGsQ5i6+VhlF+03MU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR11MB2011.namprd11.prod.outlook.com (2603:10b6:3:f::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.13; Thu, 21 Jan 2021 22:34:24 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%4]) with mapi id 15.20.3784.013; Thu, 21 Jan 2021
 22:34:24 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Yury Norov <yury.norov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 3/3] lib: support N as end of range in bitmap_parselist()
Date:   Thu, 21 Jan 2021 17:33:55 -0500
Message-Id: <20210121223355.59780-4-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121223355.59780-1-paul.gortmaker@windriver.com>
References: <20210121223355.59780-1-paul.gortmaker@windriver.com>
Content-Type: text/plain
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YTOPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::24) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yow-pgortmak-lx2.corp.ad.wrs.com (128.224.252.2) by YTOPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Thu, 21 Jan 2021 22:34:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d75c1791-b00f-43f1-1ac8-08d8be5cb3fc
X-MS-TrafficTypeDiagnostic: DM5PR11MB2011:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR11MB201133C0636895DCBFD3F94B83A10@DM5PR11MB2011.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e0sCtbxMo8q2CgqKaouJn5L1PiptOai7+ez+fHeh2RaDAmWpw3etAAIkNVFaA9+ZTEtiYekZGa56aUJbxHuS0DbS28T9KehdpdRpILXNAI5kd9RAADgGRS8XSHxjh8JN+DPHYEILFwXl+Q4SMBVDnGU0I2Wydpxy4XoVV6OlmRNUSNwkC8EVAQ3tsJuft7aIOdHnDiwdg4N0PaL6rxEIQuYFqGCLmZ6q+7KMh7J+ehp3Tza1uaZ3KSELnfIEUqwoGqya2Ck468vYst909S0wZy+5TxrNq2cnWig+M2HhudgmEUd34msLM6f5dfomNVYyYWtiRKROokRplc9qlS0dGTsHXVIKPFroiW8EfQAa7u40j0G3tDwmiCD/EOMvLW3dT4BwfcaKHIipiP1KenDBsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(136003)(376002)(366004)(5660300002)(86362001)(316002)(66946007)(66476007)(1076003)(52116002)(2616005)(44832011)(6486002)(956004)(54906003)(6666004)(83380400001)(186003)(26005)(16526019)(8676002)(2906002)(478600001)(8936002)(6512007)(36756003)(6916009)(6506007)(4326008)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2FDnclsUdal7XJuwylfspjU9UM7iD3oD6ZCCFo3aA65u16vDvjyPQSiO8wSS?=
 =?us-ascii?Q?QId4NFODK3WWtmv7jlS4HTWOlAZh7AsVlLSbIDrXqYxm4a/NujFByR9nqa28?=
 =?us-ascii?Q?hK3AwD4+7RrPzk5gZLEdkVOiijkyEJcoB2r0sbBK744rgYV/FGsaEKCy6gGH?=
 =?us-ascii?Q?9f5NstAbOlwFyNiBH9HhJx/byQgMB5PPyLWv9GrtAPYg/lKTtxUUszNKcVYB?=
 =?us-ascii?Q?4Ct+f37+zP1z7RBytZTvnAH96Z0aU/nmyDrilWpM8R2S8eScckTRD1FLOTSW?=
 =?us-ascii?Q?V3/tAoykZsd78MtWPJTTMmVoLYsvYZ6hBfspXo61NttVytWRw5Pu4xtgw2ZY?=
 =?us-ascii?Q?Fpeo4NBFyDhslvGaBwlXBv5vNElVd09uGau8KGandK/jPGg+A0uVcIyyJ8jj?=
 =?us-ascii?Q?6JVM9/cZhXke3BlEdwtEUwaljiJyLpg7K8rEKpYeI7Kt2pQHV+HVz4QrjQwg?=
 =?us-ascii?Q?3xDTcGAa67jJqTCFzB05tj/+vNlRXKbyM7cq3Em9Bj9vSOelLEG6u8Tza8sV?=
 =?us-ascii?Q?dJ9YGm7SXQ4a6P4OF7kjBoOp5g4+T42qhgcN9C4b71V8jNG3yDk3wvgAWCl/?=
 =?us-ascii?Q?/xFUjNNDVysRbE3CZPhWoN5TUMcPKCd4YSS0gt0XdEH1fiyCWp5pdPHyhsfk?=
 =?us-ascii?Q?UwL0HH/+ISVWva5QSdWYpUFRaZ+AGdM562irKn9l8/J6Dbk+Wp2RZqY+603P?=
 =?us-ascii?Q?EF+LF7YUGDJ6IVfLEtgdEEgqZ0ZbsR3mX2JGJtjieKC0YkZfo/CDTplDtPbG?=
 =?us-ascii?Q?5HUHCHeh7k+FQ2XgowkFdCpJ46cAC1DAmvsuDZtGHPdT8jxVnUvlpX418E9y?=
 =?us-ascii?Q?NrDv2MItOFuDmouvBtJ9vq6f+sBqthQ//KbBW+kdBBI3Nd5XR6M8RUYexkxn?=
 =?us-ascii?Q?dXULfbnCWRsXZESiUppYLDV9dDpuT9oaGJrcpGO4E8dD0OiPKLnu1VbnLgl0?=
 =?us-ascii?Q?A+aIib1uMWbRNe4dUrFWTLC7/foiTRYP3C5rSauOer8/UdpDXV2Nfq59m1h0?=
 =?us-ascii?Q?7j89?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75c1791-b00f-43f1-1ac8-08d8be5cb3fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 22:34:23.9982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmDYMkQwVbK/05mdLsAobkcH17dAKLPSOwh6FFTyhW1uccIUtDv1NUf/3+XKnbOfp1rPb+2p6TTuSclQH7xUVF/cbXM6UNaAoYF00YP2Wi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2011
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While this is done for all bitmaps, the original use case in mind was
for CPU masks and cpulist_parse().  Credit to Yury who suggested to
push it down from CPU subsys to bitmap - it simplified things a lot.

It seems that a common configuration is to use the 1st couple cores
for housekeeping tasks, and or driving a busy peripheral that generates
a lot of interrupts, or something similar.

This tends to leave the remaining ones to form a pool of similarly
configured cores to take on the real workload of interest to the user.

So on machine A - with 32 cores, it could be 0-3 for "system" and then
4-31 being used in boot args like nohz_full=, or rcu_nocbs= as part of
setting up the worker pool of CPUs.

But then newer machine B is added, and it has 48 cores, and so while
the 0-3 part remains unchanged, the pool setup cpu list becomes 4-47.

Deployment would be easier if we could just simply replace 31 and 47
with "N" and let the system substitute in the actual number at boot;
a number that it knows better than we do.

No need to have custom boot args per node, no need to do a trial boot
in order to snoop /proc/cpuinfo and/or /sys/devices/system/cpu - no
more fencepost errors of using 32 and 48 instead of 31 and 47.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 .../admin-guide/kernel-parameters.rst          |  4 ++++
 lib/bitmap.c                                   | 18 +++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 5e080080b058..668f0b69fb4f 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -68,6 +68,10 @@ For example one can add to the command line following parameter:
 
 where the final item represents CPUs 100,101,125,126,150,151,...
 
+The value "N" can be used as the end of a range, to represent the numerically
+last CPU on the system, i.e "foo_cpus=16-N" would be equivalent to "16-31" on
+a 32 core system.
+
 The following convenience aliases are also accepted and used:
 
         foo_cpus=all
diff --git a/lib/bitmap.c b/lib/bitmap.c
index a1010646fbe5..d498ea9d526b 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -571,7 +571,7 @@ static const char *bitmap_find_region_reverse(const char *start, const char *end
 	return end;
 }
 
-static const char *bitmap_parse_region(const char *str, struct region *r)
+static const char *bitmap_parse_region(const char *str, struct region *r, int nmaskbits)
 {
 	str = bitmap_getnum(str, &r->start);
 	if (IS_ERR(str))
@@ -583,9 +583,15 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
 	if (*str != '-')
 		return ERR_PTR(-EINVAL);
 
-	str = bitmap_getnum(str + 1, &r->end);
-	if (IS_ERR(str))
-		return str;
+	str++;
+	if (*str == 'N') {
+		r->end = nmaskbits - 1;
+		str++;
+	} else {
+		str = bitmap_getnum(str, &r->end);
+		if (IS_ERR(str))
+			return str;
+	}
 
 	if (end_of_region(*str))
 		goto no_pattern;
@@ -628,6 +634,8 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
  * Syntax: range:used_size/group_size
  * Example: 0-1023:2/256 ==> 0,1,256,257,512,513,768,769
  * Optionally the self-descriptive "all" or "none" can be used.
+ * The value 'N' can be used as the end of a range to indicate the maximum
+ * allowed value; i.e (nmaskbits - 1).
  *
  * Returns: 0 on success, -errno on invalid input strings. Error values:
  *
@@ -656,7 +664,7 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
 		if (buf == NULL)
 			return 0;
 
-		buf = bitmap_parse_region(buf, &r);
+		buf = bitmap_parse_region(buf, &r, nmaskbits);
 		if (IS_ERR(buf))
 			return PTR_ERR(buf);
 
-- 
2.17.1


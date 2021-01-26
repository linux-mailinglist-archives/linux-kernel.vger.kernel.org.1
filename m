Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF63304E48
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390360AbhA0AYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:24:09 -0500
Received: from mail-mw2nam12on2059.outbound.protection.outlook.com ([40.107.244.59]:56576
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730079AbhAZRNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:13:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMWUcG96Ys77DhjAzy0ptwKg5bONqnYjJTISkC6WNKdExplAApQFazoMN/hGtn2H1CV+MvXArn/n2dPiHqEGOivI93iI5u0K/th7UOiNjcXk69ljHXZqAJkadQDLxHxSbqLjNgvgW3/lM6EZqF6ztDVHKFX0LGygUR5egMUfACdB9AAfmjXcvdc9pLLtp06fYG4AqMpPX1ECo/iQFC9y8Xsjm/V3N1l/ct11PWRCShrQWyXWHLvVJxn3KGrEhQEC9tvwm4W8gL3DxVKRrXVXY2Aulw5ffI2XY2CpmsVHPt4wtBENMPjYiaSdKSuAPqrOWT3r56fIMMcp0td4FvtWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWvQ/n9z0RHlbo6ALA2WbI/zzptvfLlQQ63MCJO/muA=;
 b=YeyeYtkfUR39UFhIGqI/3+f2N+5g3OnJ/0fqJHZmqnR++CFTshaGPDTUjeWtLYW1LycvdY8Nmq4cvGr9t4PUlBZ4egrE2ALcr2/m5xxyaUlq+t+bdfObjO0h5Gu7dlKsDZCAzZLMBsew1C+REf1IZrnazTYXUQ6n4sB3wtOvRynyF9SGmkafwl0EG0qU2kNI8xlUW5bHu3bLEIgwZcj+GMMHow9EhxSS2GP3tPL3tTibf9khPKlBnmn0dd0h4ybH20PsKGLguTg1KLi1HC+eWtIcuA0mlnv8cEcPVD6zNakyUVgxRJUKRb/Wem6FpvyXjrZxQhK9UxYAZBrH9gZ8hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWvQ/n9z0RHlbo6ALA2WbI/zzptvfLlQQ63MCJO/muA=;
 b=Ezs9r9tUhNmxlNDyGQcmTwRcWDWChyHQk21DkSwmNx4BWAIsMaeTr2q6ALlq7lsNQOXLvVeXG5iAHABn8TdupYGj+qNrOV16N+1KNfsvD77FcvR7/jefzpDyuptZO4Fi89XGbZFCd54WFj+4gdqdNUG7LgRAA4ELbMiUxtn91q4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2763.namprd11.prod.outlook.com (2603:10b6:5:c6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Tue, 26 Jan
 2021 17:12:27 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%4]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 17:12:27 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     lizefan@huawei.com, mingo@kernel.org, tglx@linutronix.de,
        josh@joshtriplett.org, yury.norov@gmail.com, peterz@infradead.org,
        paulmck@kernel.org, fweisbec@gmail.com, linux@rasmusvillemoes.dk,
        andriy.shevchenko@linux.intel.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 1/8] lib: test_bitmap: clearly separate ERANGE from EINVAL tests.
Date:   Tue, 26 Jan 2021 12:11:34 -0500
Message-Id: <20210126171141.122639-2-paul.gortmaker@windriver.com>
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
Received: from yow-pgortmak-lx2.corp.ad.wrs.com (128.224.252.2) by YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 26 Jan 2021 17:12:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba38fada-e9e0-4306-745a-08d8c21d8eac
X-MS-TrafficTypeDiagnostic: DM6PR11MB2763:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB2763708BE947CD023346C94D83BC9@DM6PR11MB2763.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QZbCne1d1/xqG5t2L8qQ4sHglH2ac3n8G/SDT4xy+P/aStWOJPK3UmBL/AVY6Wi6uquGRfPcJgs+2DHWT/aSybOo9CXb4TTNyhH+PcrHSN5pZSmJ8LMmpcmWSS4QfyA8VCb06Q7WIXYJiPwEjcY80jGLWAF3OPXu6SBE9RR1rD3x+XQIXmQkzs4lU7+rzIkyg7xjt97Fw24+93gOIo8SfexVRwqImeHNlYc37gZSCklND4AZNEdv1XcSlllchUfLH/w2M/P0je33ZGdZ6Kn/2w9l1kKXoOwRbh9yA4Jwpc/vclvVPs6CLVhsLoTSwzHyQepNFZVem4/Yh5hPaSZKR/oSUjvtQ/S0IK/RjmSiy5sVFJ6bNrZ+8dUOX3B/AlevnKhNs2SkFRXjgAN0IfuscA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(39850400004)(396003)(136003)(6666004)(86362001)(66946007)(316002)(8676002)(52116002)(186003)(26005)(2616005)(107886003)(1076003)(6512007)(66556008)(16526019)(478600001)(8936002)(83380400001)(6486002)(6506007)(5660300002)(2906002)(66476007)(956004)(44832011)(6916009)(36756003)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mqSg7UFSwECDZ4JpWSk2enXVLUnk7OEqWaoy2h/BSSEcEYt/KxGPixWKfPDk?=
 =?us-ascii?Q?YLJmKv0ijBeTwgCfj36ucy8PN5kxDcQLYAytPSX8slVx8pQDsskDD5GkDiQf?=
 =?us-ascii?Q?DdFiAGLfG+mcBLjm72BAcNXedi4PqGiMGlKCr6ejV46UHdF+Hcq1/tD5DWwF?=
 =?us-ascii?Q?tQfC12mDcSLLpE225FKsmgDIzQC3DMdYnJurGX7GNl0XIxK9NVjoNu8vUVYe?=
 =?us-ascii?Q?qmDkiqGER4E0QUqQUeAPjzC5LA+W4DTj+8QY3e4rSTBc1MoJct/1Dqn7WOJ2?=
 =?us-ascii?Q?0uRejjG7n65+cOiUnx+Ej4pCI7Yl5qOUTyx1kXu3eOrvruMq/GvCM/1KMvuz?=
 =?us-ascii?Q?rvr3NzzVNQzE2z4qLj+YDql87mNDNNn3a2WsqpIxE7urReXXLgS2ITf7Joy7?=
 =?us-ascii?Q?+ZnDVW1fyCbaOyde/Vw8Z+tq7wRdzVF5KT0bN0JbFMfo/vNcbK+32c6ofRus?=
 =?us-ascii?Q?4ilI1R8kaDVchrzNxfRiiFThCjSu4/78FKMdD34u+nPf7LpyIvaAwuHU17L1?=
 =?us-ascii?Q?dbWeKbz9kbOzRjplmZdwbpfAqkKnaRUnYidjQwvUVx70WN1lYTq7+kV+BuQ0?=
 =?us-ascii?Q?hyNMCs/2wNwn6AqhES8dWkP7EjwRtAu+2ZXyW7eTHgPROhEQ5Q9LUOdNcTN9?=
 =?us-ascii?Q?zdOH7NLzuHySqVk1q9Awh3NJbtGs0G6paFCvd5R0McZp2AsMsnoTDu4rHTas?=
 =?us-ascii?Q?0MCYBkWqbVYCvsQ82cAu8AUuUIzVM41bDZmJZ+TC9U4Bd6gvR0oFZkpRWR3v?=
 =?us-ascii?Q?NjBZhEy7epJ79ZqT2GUqog5ZAJQYL4Xx+JGQunHu81cr6S8dNR60trnDoNUr?=
 =?us-ascii?Q?zJNH7oegWSFFMj7nLdrFvbTFGNbQv51bGx+H+VwoASTE3YC+1bq+GSSa8DH8?=
 =?us-ascii?Q?0XqC58mG27eGazmf8PBFcJymsUM4v0L0AUDrD0dBgHy+HkLmvfnytFp5j2c2?=
 =?us-ascii?Q?/hR2xe27/krEBL996jFXOvWiaQXN0dpA3ht1/dFROhv3HTouleu9/m6oKFi+?=
 =?us-ascii?Q?fd/24/4+HPg2GI72olHavK/+Oj5a9gajxSB6CU71B30H5gbInkvTSRtYtf2w?=
 =?us-ascii?Q?fX1OBLjw?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba38fada-e9e0-4306-745a-08d8c21d8eac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 17:12:27.8134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eD5KKTQhtFG1s5MLwrzP+gjtOxp1EBY8t/QvNUm1/f+Q8qXXVqrN7R/du9jLQPpbT+Qr191eK2X2EeXH3E66PpckxRU5nv3KpPTL07Lx20c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2763
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This block of tests was meant to find/flag incorrect use of the ":"
and "/" separators (syntax errors) and invalid (zero) group len.

However they were specified with an 8 bit width and 32 bit operations,
so they really contained two errors (EINVAL and ERANGE).

Promote them to 32 bit so it is clear what they are meant to target,
and then add tests specific for ERANGE (no syntax errors, just doing
32bit op on 8 bit width, plus a typical 9-on-8 fencepost error).

Note that the remaining "10-1" on 8 is left as-is, since that captures
the fact that we check for (r->start > r->end) ---> EINVAL before we
check for (r->end >= nbits) ---> ERANGE.  If the code is ever re-ordered
then this test will pick up the mismatched errno value.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 lib/test_bitmap.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 4425a1dd4ef1..3d2cd3b1de84 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -337,13 +337,15 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 
 	{-EINVAL, "-1",	NULL, 8, 0},
 	{-EINVAL, "-0",	NULL, 8, 0},
-	{-EINVAL, "10-1", NULL, 8, 0},
-	{-EINVAL, "0-31:", NULL, 8, 0},
-	{-EINVAL, "0-31:0", NULL, 8, 0},
-	{-EINVAL, "0-31:0/", NULL, 8, 0},
-	{-EINVAL, "0-31:0/0", NULL, 8, 0},
-	{-EINVAL, "0-31:1/0", NULL, 8, 0},
-	{-EINVAL, "0-31:10/1", NULL, 8, 0},
+	{-EINVAL, "10-1", NULL, 8, 0},	/* (start > end) ; also ERANGE */
+	{-ERANGE, "8-8", NULL, 8, 0},
+	{-ERANGE, "0-31", NULL, 8, 0},
+	{-EINVAL, "0-31:", NULL, 32, 0},
+	{-EINVAL, "0-31:0", NULL, 32, 0},
+	{-EINVAL, "0-31:0/", NULL, 32, 0},
+	{-EINVAL, "0-31:0/0", NULL, 32, 0},
+	{-EINVAL, "0-31:1/0", NULL, 32, 0},
+	{-EINVAL, "0-31:10/1", NULL, 32, 0},
 	{-EOVERFLOW, "0-98765432123456789:10/1", NULL, 8, 0},
 
 	{-EINVAL, "a-31", NULL, 8, 0},
-- 
2.17.1


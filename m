Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B379B2FF806
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 23:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbhAUWfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 17:35:36 -0500
Received: from mail-dm6nam11on2069.outbound.protection.outlook.com ([40.107.223.69]:28545
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726414AbhAUWfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 17:35:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+QUt6nvxwn/TIYJa0l8Znqkpq+Yw8rRDWHzulGXXTZvhL3i3eoctgIPYUqj532AHpaIvTDfZPFewgvujAfso+lYsUEoLFocxJpfmgKxZ7l2hka86V3q3Ch1sVXCgwjrXwDD6XMgViHzcM1hNBk84pSO8ydTcSxjlyLZhxrX/1YH3Er9hocAdjf7GM7aEMyFjtCGl6YGz5MtZct3SiNy3HEGZzf2iLedys7oA3veiwFWFYUvJvy7if74ZX6jBUrEdSr6GvdXhfj774j7oqz+qjnFdnpk3YtCzjrDnMTBAhwGgHUeHiC7lcP27s+WwVznKY/2sTn7ey4nfN7hUOXU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ro19xsPLKGbzOI5FwHUqYqDcQGpfUflPhEgtUcMlbgI=;
 b=Oqza9oKFSxE0pDx3m9ucakimi08FWwLclZTdHoLF9UwNvOlJGNBu8z7QYdBzr9qZV0RA2X8oHF3DIfDo3vt88cMEhvMrE74A97UeMMnit5x5KYL1PtutpqxjaDVlnTSOJDhT/fcCGxU1e+HA/FvYQMjGXDw0P4Fv9+uq9o8dZsqmXrIE0+N/ZX/xUIeo/o9+U3lLWnVTdGrLrhKitDw0oJRlfFnRVsEOfNcS8GhWabQuHdNzPueKUMku5At4f+2OnaleoJFM4NxO9jQRuG8naMbGUrOHLHIQKOvb9dGAyHT2QHX2eU4oMSHLDj1b6gWpFFStz+U2D3av7R1I8Ii83Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ro19xsPLKGbzOI5FwHUqYqDcQGpfUflPhEgtUcMlbgI=;
 b=U3/z0gTEcEMuNlLByVEXny9Xs4RywRJQcd58plwS0oBtOWtJ1pGEf4h4y53/WIXHUbEh4mHSTnGHF6uUbXKHvRrwho34oBkxR9tMa4iffLKqS+eOVX/OltlljjmXsyrSEcg57LOQNgEjObTwiZKA0/mIou8yiM1k5V62PMwGW1A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2763.namprd11.prod.outlook.com (2603:10b6:5:c6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Thu, 21 Jan
 2021 22:34:23 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%4]) with mapi id 15.20.3784.013; Thu, 21 Jan 2021
 22:34:23 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Yury Norov <yury.norov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 1/3] lib: add "all" and "none" as valid ranges to bitmap_parselist()
Date:   Thu, 21 Jan 2021 17:33:53 -0500
Message-Id: <20210121223355.59780-2-paul.gortmaker@windriver.com>
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
Received: from yow-pgortmak-lx2.corp.ad.wrs.com (128.224.252.2) by YTOPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Thu, 21 Jan 2021 22:34:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25de5695-07af-473d-b99c-08d8be5cb357
X-MS-TrafficTypeDiagnostic: DM6PR11MB2763:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB2763D20D2C38FE0269B3852583A19@DM6PR11MB2763.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aYvjVLQrfD5rWM8NmGM979QPOODALgp5z2u6IA6g3slG1/FCnC4WJnSaiL8TEvJkiLNSVhO9lBXfeBKIMweH/IUE15zQct8bNlsQOC6asbB4L09cswniIYM1jlrGdeylR2vxKAtb2iagrK580ExIV1DC1UJLtkOCFPGqTMdThzYxC+/OHTGL1H4NEqO4avMWd7Qa/AT9MESVV8ix3fDoAOT/ZE49C1eehqm0WJKHMo6mIU9/ItAOC00PsgcBjtjWyfrYg73tGZrGwB0a0D7HRwcMxPomYS2P4oLLFrVbeEm9Lv1fY6vf9iILRK2ITh4hmVWS66yHB4pTMIbkafqMmNNRTmdcG7Tz4t3hZ+s/CuM8bz6pZExzR3pk756yUMZ+QyAIF41qmhMR7gzEJxx0rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39850400004)(346002)(136003)(396003)(4326008)(66556008)(66946007)(8676002)(478600001)(6666004)(8936002)(6486002)(86362001)(66476007)(6512007)(36756003)(1076003)(44832011)(2906002)(2616005)(6916009)(83380400001)(316002)(26005)(5660300002)(54906003)(186003)(956004)(52116002)(16526019)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YwGpi+zioShTYj1nAvKsOKkxSydV7wWkXgopSaTRuA2lPw1EvnvKC4/W2LmO?=
 =?us-ascii?Q?tVcuLkwH7P4UUfvQxve3mcgbnzs7iZp18SnZbhXI/Rw/GIcXh5OCRhQGCWaw?=
 =?us-ascii?Q?DxVR4Ia0wu4jpxDj5koZiNWytqekYwuHbV1eDltu07ximTJpBTPMSPiRGmjC?=
 =?us-ascii?Q?g1Cpdk4g+AYMe0RUmZXpwIMIio1QvH90pcmw+bghHjCQaiNmJ7EeaSNnGaZ5?=
 =?us-ascii?Q?WoBmnE35QNFH8fj5jFkwk2a8Y6dOHVxSBVfcJJthC6c3S56403LEAsDEFwvZ?=
 =?us-ascii?Q?JTSLa6k6QEeNSyK3k9hH2AVC0aYR10SB8BJ5N9GgbTDGiBXTXUcsWXxOaKVF?=
 =?us-ascii?Q?uOniFdsMW6hgWuDnJX1V6EeWJDHqnY+J66viigT4YDxPYvT4oUMo08El16Jx?=
 =?us-ascii?Q?0dCdCk+0Y9E5qa+Bx/ERruzVBDY2tMO9aVhQiiN2QHhcjrtfoMDkPBC3UXj1?=
 =?us-ascii?Q?LyxZs8s7tS1S5i7G1TJYD+bReCBiDjD9BdqYGOw3brVWNyb/D7JTLm+q4twn?=
 =?us-ascii?Q?cd5gCarTrWgS0AZhMhQjuR3gNtYp6OH+XXEwRx6bX4m+eIKfkQ0axWlFNw4e?=
 =?us-ascii?Q?w3tcknuskr8sw4cXWAASx/8lDUPpMQMJsIgshbbmRedYVuFPcwQdBnxD3dkM?=
 =?us-ascii?Q?LZ7UakCa5I9gL3/qxbKCFPxulacn+qR1bBbAAd03hEaWHr8BItqygsYF4qOL?=
 =?us-ascii?Q?wzogRceO6JHS1fCQ1jil+phrRIGCK1YY5Uvwa8FDrB3WFQDq5hi1tw3eNqvJ?=
 =?us-ascii?Q?eGWIfIeBVgOfyQbTA4b98r3zrHd7ztvDXaVNxVr1kaO0QuXWKLzxWNXlRFM7?=
 =?us-ascii?Q?uBC+UC+DcAwPJepbvkdQjpoo50HCaDlpOKmtVo1uHFv2Wd8Nk7GZN7LAQk7a?=
 =?us-ascii?Q?OYYyO+6bWQpuMZQBS3roT+pEC/Y104nAYjdDqaZ2asl7WVED+KNhunvJbUJ6?=
 =?us-ascii?Q?DQdhMQv+NtSm46XzT5W5cRcoIbPFiQzbb326iBY+67H7tcQHSLYZaSvEkVak?=
 =?us-ascii?Q?OCqr?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25de5695-07af-473d-b99c-08d8be5cb357
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 22:34:23.0036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylfuRKQtcyrVqeV4LkmsEiAxqs7oBNnl9mFDMVL4a5oc5UCXN6OCXTtU64TxAQPBijEAo/36Op6OMSIjyMO5Gtr82nMusIcI7OhXhEsevDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2763
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of "all" was originally RCU specific - I'd pushed it down to
being used for any CPU lists -- then Yuri suggested pushing it down
further to be used by any bitmap, which is done here.

As a trivial one line extension, we also accept the inverse "none"
as a valid alias.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 Documentation/admin-guide/kernel-parameters.rst | 11 +++++++++++
 lib/bitmap.c                                    |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 682ab28b5c94..5e080080b058 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -68,7 +68,18 @@ For example one can add to the command line following parameter:
 
 where the final item represents CPUs 100,101,125,126,150,151,...
 
+The following convenience aliases are also accepted and used:
 
+        foo_cpus=all
+
+will provide an full/all-set cpu mask for the associated boot argument.
+
+        foo_cpus=none
+
+will provide an empty/cleared cpu mask for the associated boot argument.
+
+Note that "all" and "none" are not necessarily valid/sensible input values
+for each available boot parameter expecting a CPU list.
 
 This document may not be entirely up to date and comprehensive. The command
 "modinfo -p ${modulename}" shows a current list of all parameters of a loadable
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 75006c4036e9..a1010646fbe5 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -627,6 +627,7 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
  * From each group will be used only defined amount of bits.
  * Syntax: range:used_size/group_size
  * Example: 0-1023:2/256 ==> 0,1,256,257,512,513,768,769
+ * Optionally the self-descriptive "all" or "none" can be used.
  *
  * Returns: 0 on success, -errno on invalid input strings. Error values:
  *
@@ -640,8 +641,16 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
 	struct region r;
 	long ret;
 
+	if (!strcmp(buf, "all")) {
+		bitmap_fill(maskp, nmaskbits);
+		return 0;
+	}
+
 	bitmap_zero(maskp, nmaskbits);
 
+	if (!strcmp(buf, "none"))
+		return 0;
+
 	while (buf) {
 		buf = bitmap_find_region(buf);
 		if (buf == NULL)
-- 
2.17.1


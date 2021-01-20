Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F222FC6F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 02:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbhATBlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 20:41:01 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33238 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbhATBc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 20:32:27 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10K1TUOr177105;
        Wed, 20 Jan 2021 01:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=JlrDjAS7DcV9GpSQiM3WLIiosxkO/pdJVoM6B4mBrCc=;
 b=WhMsjwKMoDDBPavyfyXNr4+gGcYMpWXV99wQi7h2tFWHIs0Vhtr8FtmwHU1lK71MbpGC
 zcqDipvYqNOjSh6L1ASM6riGafQhjOlIx/puRDYUTdbfZCkFevjwLab8BXD9Sxj/ngoZ
 zkp46pfSnKLVZz6PUvS95n/0/rUQ0Kvb57YzxcOeDtuBY6OxKxYdEnO7PRBbFp/hHmxp
 /M27Besnh6WZq1RjzyCIjGx5TKxQ43z/4Oz3Y0ZLZDxrUbiBAwFjlpEazq70sWL9uanS
 RmAiKOnpVgl5v6KrrprR1A/Rg8DEK5wMLjJhpx+Xf66buCcY0hVR/HAUk7byJqQPRJqu pw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3668qa8amt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 01:31:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10K1UdWa007050;
        Wed, 20 Jan 2021 01:31:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by aserp3030.oracle.com with ESMTP id 3668qud5jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 01:31:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doWsLxmXtzOywdaJXzmu0keSkS5y832YQGaqamh6D329ZaGUz9AVJ+HZ+wZoiFN84aQRywlqFL8ZxBho249Z4eoctjhjEVCEF8fq0sCaa4++3oxc3QohIqcuuyVas9vJoEPVsBOjkh0o5YV85bl9+oi6Byzd4HXCY8KKNcHCAJIC50XHmkgov1SShyFzwWnkS6mhJm9RsAogLEckaqmWsbWzQpATGbwvyClY67LoOPKOPK90h/59sNrvTPdgkzdrNB6VVk1o7SaGe2G+5M4RNG/WprevKloLkBtHGOAqLYwV5zFftefmxJMTL4FVFusl6v0PkRt6ZA7jiUbhxBmvsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlrDjAS7DcV9GpSQiM3WLIiosxkO/pdJVoM6B4mBrCc=;
 b=aOl+gl+e9p1hKMfQzacPxlwRXp3y+Wx8Ip2K1lVXnbnFxLWUP6cGB0dNza8gpKpSfXC7S6Opt7HIwHaSHl+LeEC92udn2ZBCRtBS/dRS/DsUGOWJkI9fqoKDmYQER3Bkkl2/mXZD9CiaWQ5qCrB7tSuohRp19hHL4ZSjrQFjm36jmatis22SCrPpn0iIyvbD0JK56COVwmwyXSoscxaYiUGNFljI2P70ydHrNYGjgVtCF30Ntpb8Ix7tBvk6EPAw5LP+rCwhePXPKLv/YWsYvc1uqdODanlp7vVGIpmjg6EqvqZEzt0ScDuJfronmxTSLXAigym66b9MeIRp2WOXew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlrDjAS7DcV9GpSQiM3WLIiosxkO/pdJVoM6B4mBrCc=;
 b=Tx6RcMc4FV3BH/b83W/QJgRKet3YWkeuFwcG+uA1pb//JDc8dpvzQyZ+tlAGd56aEj9rOC2J+mYYVp2bRmayXIru2WVB4IbXKfKmjiOQKdUI/vlNqAkM5cfR26MEH3oh1jOjYGVANmCdUW1peOnHdYDx2CzpNhhpOXiMJhxwS/8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2384.namprd10.prod.outlook.com (2603:10b6:301:2d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 20 Jan
 2021 01:31:23 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 01:31:23 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 5/5] hugetlb: convert PageHugeFreed to HPageFreed flag
Date:   Tue, 19 Jan 2021 17:30:49 -0800
Message-Id: <20210120013049.311822-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120013049.311822-1-mike.kravetz@oracle.com>
References: <20210120013049.311822-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0178.namprd04.prod.outlook.com
 (2603:10b6:104:4::32) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by CO2PR04CA0178.namprd04.prod.outlook.com (2603:10b6:104:4::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Wed, 20 Jan 2021 01:31:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9edbbd05-759c-4eae-363f-08d8bce318db
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2384B4A2905CCCC1DDEC37ABE2A20@MWHPR1001MB2384.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/p7Kxv6qb44XPIp4KJEjNCiAOcLH/goKvk0sbypLqIjAbqKKkyv7xVwTRobVRrJHFNZmwnGoS0OTeFUVD4H6/Di5Wa9rE3zIarygIIMoU5WexkpYHQKV3S9JSKZq6NcEXjILOmR7cotgbqXsZLmJI67JgejBNdVNgPlWjnJ66NWpuIO0aZARTTrjHRMOxNrKlG7cLpe3k1am0nI2/ReNvEP2HTseQwq9GJj7Ns+oIS1FteUldCEIn5GBRCsbFlUprAG3/W8gxarkNnRkxHAUGm0k43iWlOxQCqYMgIGcR4RkKLQ+vwHL+hKlXWhSPvRNr5n4QlIHZ0CsrWYc86Yi6XFnv7tea5wnBbIvt2elKyYyXP+ma8Ico0t6BXYycn5RIiNlOXMvUcRQSJ7gnQZ3xY/3KSyu27TGZcxLsdOELXnmQW3V8hYUf+L/p46GF8p8ohNhIW3JiDgaA9a0Z4vuc487rzpymQgwVOBdbdM9RR4gZ7XqKini7KAkq/g2HeE6fnfC/666dUOsDiDs4CX+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(366004)(136003)(396003)(1076003)(8676002)(186003)(36756003)(107886003)(8936002)(478600001)(16526019)(4326008)(956004)(316002)(86362001)(5660300002)(54906003)(6486002)(2616005)(7696005)(66946007)(66476007)(66556008)(83380400001)(44832011)(2906002)(52116002)(6666004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?L7f0n8qnG+ZpKW3rYxU2NesnNAyaw7YJPLpURtY1TRROUPEafxY8Yjd5sVbA?=
 =?us-ascii?Q?pyBEPYldO3YjIyXES+CyAHEUl0/+sUhnjw298aN0BG/Agw11D8Dryfce4zYx?=
 =?us-ascii?Q?HLRQIG4n+tBPEpTRMr9AYi7Pt/zVQKrH+v+FmG2BKttaMr306mRCw+KVO4ow?=
 =?us-ascii?Q?oXoO7femGYo8L+lurE0OAON5FiujuGuY1Z567LUVjANAlt6zVfNe1Dsb30+m?=
 =?us-ascii?Q?c8FV2wJdhPbWBSrjwOXQCUtMDwmegGL2i6l50v0f/0n47+OLgg14zkgAoVOV?=
 =?us-ascii?Q?b+CTemnY+GMNipHGLHxgNRK4rHJwon8+hpmgx9bSyRXXp+n+Q3f2Q6GVq0Iu?=
 =?us-ascii?Q?Jpu/nlLDU/90K/6DT63DX2vNCrcSh+uqOM851UldwVEx2HFs+JyyUf6ztaB3?=
 =?us-ascii?Q?5DtBFjkNmVTdS3eFqOwJWeEXOtFrak7KmzW8xfEoVwak59xuUjTkXmznMj2C?=
 =?us-ascii?Q?u4zLelK33N7ONKJE2U/QQcgudwxdLgSN1QQjwLFl5V8RUENaJSPoZVaFMltK?=
 =?us-ascii?Q?ItWPuRGvuewQaQlBt+yRXL4ITd5S9nxT2ToeElwyqEASqKhovuEkfNs9ZO2D?=
 =?us-ascii?Q?kCpuIKYvEqJqhhNd9r6oiMJXP8PSxKylcosjHsVmBovcLWUsZ4nRshTxIk9f?=
 =?us-ascii?Q?QVkXlriNv/+G35fEzbmNfFvHWMWMznUcpwKdHT28g3NGYhWvMiE/iVgEJQqI?=
 =?us-ascii?Q?kNEy9xf2lmjwcpFzNscBTFaHjmopFEz2+1SqXnXPa83OuNaagShYt0jLAUKL?=
 =?us-ascii?Q?FG9fbligxp5NewFJc51+rQE1Rk8ZSkO4uaQ7UC9HISdSTEGMMddQq85GSv1p?=
 =?us-ascii?Q?zWvRU60Ks/SvHObrWFQjOHSunVlKjs89P4CpTF46m5fnMDeEgoP8rgI7Xi8D?=
 =?us-ascii?Q?zNvixUB6vJQWo+O5zF2ZmdXDSSqOat1foHdKHV6K/e/nHrEFbMDkLTsRTpHZ?=
 =?us-ascii?Q?Pe6uIL5yOmYG4qgalkpX3Xu/CDscoJOsU6xK+wysl+Ot47r/JKP4A/Rpvw1W?=
 =?us-ascii?Q?Nz7hHedn7E9Wb2Z6KgCX8VRb35Gj9sAQmfgKtFnHaiOLpqpVnIV7Yst25jh3?=
 =?us-ascii?Q?ER/ktMcq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edbbd05-759c-4eae-363f-08d8bce318db
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 01:31:23.5891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XplRZB7kAw7sz+2vrOG7W3YbWpGpu7shOClkq4GbtDMSCVeqFY1EAml7A1WltC90ppTz3wh8pR6DhMxAF8juHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2384
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200005
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200005
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new hugetlb specific HPageFreed flag to replace the
PageHugeFreed interfaces.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            | 23 ++++-------------------
 2 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ec329b9cc0fc..8fd0970cefdb 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -487,11 +487,13 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
  *	allocator.  Typically used for migration target pages when no pages
  *	are available in the pool.  The hugetlb free page path will
  *	immediately free pages with this flag set to the buddy allocator.
+ * HPG_freed - Set when page is on the free lists.
  */
 enum hugetlb_page_flags {
 	HPG_restore_reserve = 0,
 	HPG_migratable,
 	HPG_temporary,
+	HPG_freed,
 	__NR_HPAGEFLAGS,
 };
 
@@ -540,6 +542,7 @@ static inline void ClearHPage##uname(struct page *page)		\
 HPAGEFLAG(RestoreReserve, restore_reserve)
 HPAGEFLAG(Migratable, migratable)
 HPAGEFLAG(Temporary, temporary)
+HPAGEFLAG(Freed, freed)
 
 #ifdef CONFIG_HUGETLB_PAGE
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0d2bfc2b6adc..d5a78aedbfda 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -79,21 +79,6 @@ DEFINE_SPINLOCK(hugetlb_lock);
 static int num_fault_mutexes;
 struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 
-static inline bool PageHugeFreed(struct page *head)
-{
-	return page_private(head + 4) == -1UL;
-}
-
-static inline void SetPageHugeFreed(struct page *head)
-{
-	set_page_private(head + 4, -1UL);
-}
-
-static inline void ClearPageHugeFreed(struct page *head)
-{
-	set_page_private(head + 4, 0);
-}
-
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
 
@@ -1043,7 +1028,7 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
 	list_move(&page->lru, &h->hugepage_freelists[nid]);
 	h->free_huge_pages++;
 	h->free_huge_pages_node[nid]++;
-	SetPageHugeFreed(page);
+	SetHPageFreed(page);
 }
 
 static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
@@ -1060,7 +1045,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 
 		list_move(&page->lru, &h->hugepage_activelist);
 		set_page_refcounted(page);
-		ClearPageHugeFreed(page);
+		ClearHPageFreed(page);
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
 		return page;
@@ -1474,7 +1459,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	spin_lock(&hugetlb_lock);
 	h->nr_huge_pages++;
 	h->nr_huge_pages_node[nid]++;
-	ClearPageHugeFreed(page);
+	ClearHPageFreed(page);
 	spin_unlock(&hugetlb_lock);
 }
 
@@ -1747,7 +1732,7 @@ int dissolve_free_huge_page(struct page *page)
 		 * We should make sure that the page is already on the free list
 		 * when it is dissolved.
 		 */
-		if (unlikely(!PageHugeFreed(head))) {
+		if (unlikely(!HPageFreed(head))) {
 			rc = -EAGAIN;
 			goto out;
 		}
-- 
2.29.2


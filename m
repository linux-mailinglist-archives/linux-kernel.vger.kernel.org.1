Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAC2300FE8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbhAVWYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:24:13 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51934 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730620AbhAVTya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 14:54:30 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MJmvn6170550;
        Fri, 22 Jan 2021 19:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=93yiyvI7Fr4YjpmwKXt61gLFVpnhbSwn2zLTRdOyRMM=;
 b=s/eSTXjbHlZ1DraHmI0rUCXudsnvYmuvLHlrD8230zmgyf6ABVorhk/ww2CwxZphGNpn
 MgDCk0prt4XE6l87ES///kxRoH+EiMnTPJ8hEx0RkGIMGdLeYYYt7F7bgTa2se3dJy5f
 Wzrq8Plczs/DaAShgFWmSHmY1a/mNBMIVXga3OIb81y5Rv2Gd1slzqVZ9XZxP+kXPEdY
 97DaV3KxyV2KxWBMjgxg2ejBun9Cdw72xQNjPtOL3fqyEeI++o2+HlNyjHw9+KW54EDC
 d6n84KfMCHCqeTEskR3GG/BNEHt6cuz1xVBQObPLXEMJcvbrdgWL2fT2g8kd6YTnMuKW PA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 3668qrnvf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 19:53:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MJooOJ034944;
        Fri, 22 Jan 2021 19:53:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by aserp3030.oracle.com with ESMTP id 3668r0c41e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 19:53:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjMt5DS4Mmzo+O5hpboaVtD5qfqTg6CulDp6OQK9p5w10j3/g0s6577oSKxtAmZlukI0hHIUxfxNo9YfT5zCnnlaHvfUm/TGDP/k+xqnp5pw1iykKAyiuaL2MBt15EZ23veIoyTsojT/B7bCNMQCa2kDIX9Lz1fq+SxLUs6hHjxoUgssWvIddV9Tl/cR3L4GEQmcyYKKSE3Ag2ZnyhAaIfBswoDmk+jhspOUqZXwGL/VZiBjkaGuP6rJp1bH5e1n+oC3kpZbVHU12dJLs9hgcqC0mRUubvb6v+utd9b5rO2deLf6JnG6v6uO1k42U8dojVzvTC6zzvalmnnsfXly3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93yiyvI7Fr4YjpmwKXt61gLFVpnhbSwn2zLTRdOyRMM=;
 b=IofJHtToJ4oavjYatqx6L8Af+JfHPq6QIhuXzVTllF3PZFrobD5i0mfWaeeKDDvb1kJMjENFEM/safFBQj/gFvBXG6TuQOaU5HDZiqZNW28MDAhElcf8u0v/zD4YoecehZYJA4M0dv1IDVrw1lR6Yk/6RaLdQ/A8GHQaw6fcDmcqSIqbaJPIUai1xPhcI6GFaTU8rYQ3XCuC7hAGQwZsacZnfpwRHkQgfhmLpolRPq9LZaCm9+hcLOjPw41zRQsXezdx0uAhFukkDbWdGnWVg5PonDkyhfUpynvhnncbaXQ4uIuLsoEhCmC/uj75zR1gTEy8LzbIl8dmvM6CorB02g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93yiyvI7Fr4YjpmwKXt61gLFVpnhbSwn2zLTRdOyRMM=;
 b=DftnNwntTqOCzvgBT4+h0aCGeURpzRfsgskKs/WLS6QBIPOqZ74llJCjwMAyVzsVrlLxkL77R1c9CyCe8jSNY+LyXddzdZ/m29a4oTKzgWPLu1WH2yPX5lL7hDNECFqHzjvLzxXQeM8vc1ZnZlrf2xPoO6KHQKcV0cmD7cMb+rc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4723.namprd10.prod.outlook.com (2603:10b6:303:9c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Fri, 22 Jan
 2021 19:53:12 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.015; Fri, 22 Jan 2021
 19:53:12 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 3/5] hugetlb: only set HPageMigratable for migratable hstates
Date:   Fri, 22 Jan 2021 11:52:29 -0800
Message-Id: <20210122195231.324857-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122195231.324857-1-mike.kravetz@oracle.com>
References: <20210122195231.324857-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR19CA0071.namprd19.prod.outlook.com
 (2603:10b6:300:94::33) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR19CA0071.namprd19.prod.outlook.com (2603:10b6:300:94::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15 via Frontend Transport; Fri, 22 Jan 2021 19:53:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca7a12df-413e-4915-d313-08d8bf0f595e
X-MS-TrafficTypeDiagnostic: CO1PR10MB4723:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4723B6736B23291EC42CEB31E2A09@CO1PR10MB4723.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: adJatRg1t52VDhhsCHAL/PNdkBjlcGYXJeh6thIdVcy5EXlXNy6I6YUxW7UxaJx3oU0bTSRZJEW6DK3Z3LRvhAuiC00JNPYobJICzQ0Ii6L1ELQxb/8N693Ym/HD+aKpKNtpN99LmhEk4lbX9DmuQm6OSqWX1t065nzS73JnZ9tbTrQdZcgTvlAx2zO0bcGUGp/7mXL9K2FZmDGfITzJLimK5Eh3GzyGFxQhE9rl+CuoAkG/MfuDcIhCjTYMaXPbsPW9KT220rP9glA0PY8oS5xVkM2pmzBx+WsSb7PnIONjXL+tOk6iphEAJUzZxJJUS62U8zsqqyDDWtAgFdz6xLwS6KrhbOhEyaXRVvNYMl9WhWHwg9bxVJmgzuk2xO8D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(376002)(366004)(346002)(956004)(16526019)(186003)(2906002)(8676002)(2616005)(6486002)(8936002)(36756003)(44832011)(52116002)(478600001)(86362001)(26005)(66946007)(107886003)(7416002)(1076003)(83380400001)(66556008)(66476007)(6666004)(7696005)(316002)(5660300002)(54906003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LUrD2lcwkLWOiQIISAt3qRSlulQOzBslhpDBxZuAHhCxxok3WrLgOpDVari8?=
 =?us-ascii?Q?jX6VKUSJyJ6o4fKNcaWS6QfmhWII+vEI+paE9m8CdZHDmXSfDpBie856ohj5?=
 =?us-ascii?Q?3dcNVgk34wBtd48scspfoZ506o05M+HK/3OKCp6Dl4RQTr1OIlAdi99HWgN/?=
 =?us-ascii?Q?rCzMV5U3lTB6tmQyyRsg5PtekVm56huPhFoaiP8bwpnpfamEJfSI/+17JETG?=
 =?us-ascii?Q?Il5wzob3cfXKUALaopNXMKONC0OmhL5dUagHxvx23KEIzGpf4ZHl7NV8/1SE?=
 =?us-ascii?Q?HRP2Q/ZNgEfy2JhvMHWX43mFEQDXH+IFgRAst+zg2Ob+H8pz1kF/9uxlAd+a?=
 =?us-ascii?Q?VbfpRG1CzeydBEkr+94Qt8sxUmV+8lHv+AyAE8oO8YHBebN20gB/N0DueE3P?=
 =?us-ascii?Q?wNSRWpRkd/st769VJSO9Wzs5V7H9PTgg8MVN5VWYVjpcqfGSLn2fiR3i4mrX?=
 =?us-ascii?Q?MXzwnK/eJQtaG7DmEVQcUg1oN3apWtz5YZZ1+t4AORX43BOi6t17gey5VkZu?=
 =?us-ascii?Q?BAk6PpoxVBgYR327m9vynnLrZCKAV0nls7zVRboogb9HXC3IG5wK1s1kknJ8?=
 =?us-ascii?Q?w7O8/gy5LciSoh2HPomkLUth8Tj4aWWHN/fNa1u5hKAQPiMf/EvjrXJ4lf0l?=
 =?us-ascii?Q?8rkCaiG923GNC74U2xvpt2HpLAEHWQj58W3Y40RUTvMJU9WrPe0ZYfOd4qE9?=
 =?us-ascii?Q?3e0D649b7g0FO1tFgztM+uUWqKaGbNUJYWkW6wJOEXAoTKFg+r82bGTewz6G?=
 =?us-ascii?Q?QYlEylRi5HznZJRG932jlKm09bxqlz/2DIXtIerpn2s2d+c3Kc66GFODpLJc?=
 =?us-ascii?Q?mvC+9S5UntrYws1vR4mZbj8VnWW9L0XDHPDV0oSUJMw+HCE63HutQNm9SPLn?=
 =?us-ascii?Q?nJBFpWf6/I7M7/fsrJjzMSxYrYmwoHdXPgZS99f14mT1JJ+8MIEANYk9yMpe?=
 =?us-ascii?Q?brkTviXKiYnzeyCnQPjbE5kBq1B+yQTtAUgshCaMqvM7/O1/JGnvR5FjN/KA?=
 =?us-ascii?Q?SIEaBUxp6XLrbJFvxyiG8fVRpofJlKhZDpE1JUoks+1wvWC2YxM/3Bp3rQw9?=
 =?us-ascii?Q?j+szByTy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7a12df-413e-4915-d313-08d8bf0f595e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 19:53:11.9695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xMVXS4LRir6Sso//3FxkNDr7HCvqJ0YMQ8N0l9H71llZ2Khui/zKj8oPVJUmdgjXMNDeO5Jr7tEnB2z/PgdBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4723
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 mlxlogscore=730 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220101
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=786 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HP_Migratable flag indicates a page is a candidate for migration.
Only set the flag if the page's hstate supports migration.  This allows
the migration paths to detect non-migratable pages earlier.  If migration
is not supported for the hstate, HP_Migratable will not be set, the page
will not be isolated and no attempt will be made to migrate.  We should
never get to unmap_and_move_huge_page for a page where migration is not
supported, so throw a warning if we do.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c    | 2 +-
 include/linux/hugetlb.h | 9 +++++++++
 mm/hugetlb.c            | 8 ++++----
 mm/migrate.c            | 9 ++++-----
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index e1d7ed2a53a9..93f7b8d3c5fd 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -735,7 +735,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 
-		SetHPageMigratable(page);
+		SetHPageMigratableIfSupported(page);
 		/*
 		 * unlock_page because locked by add_to_page_cache()
 		 * put_page() due to reference from alloc_huge_page()
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 58be44a915d1..cd1960541f2a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -740,6 +740,15 @@ static inline bool hugepage_migration_supported(struct hstate *h)
 	return arch_hugetlb_migration_supported(h);
 }
 
+/*
+ * Only set HPageMigratable if migration supported for page
+ */
+static inline void SetHPageMigratableIfSupported(struct page *page)
+{
+	if (hugepage_migration_supported(page_hstate(page)))
+		SetHPageMigratable(page);
+}
+
 /*
  * Movability check is different as compared to migration check.
  * It determines whether or not a huge page should be placed on
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f1a3c8230dbf..4da1a29ac5e2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4194,7 +4194,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 				make_huge_pte(vma, new_page, 1));
 		page_remove_rmap(old_page, true);
 		hugepage_add_new_anon_rmap(new_page, vma, haddr);
-		SetHPageMigratable(new_page);
+		SetHPageMigratableIfSupported(new_page);
 		/* Make the old page be freed below */
 		new_page = old_page;
 	}
@@ -4436,7 +4436,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * been isolated for migration.
 	 */
 	if (new_page)
-		SetHPageMigratable(page);
+		SetHPageMigratableIfSupported(page);
 
 	unlock_page(page);
 out:
@@ -4747,7 +4747,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 
 	spin_unlock(ptl);
-	SetHPageMigratable(page);
+	SetHPageMigratableIfSupported(page);
 	if (vm_shared)
 		unlock_page(page);
 	ret = 0;
@@ -5589,7 +5589,7 @@ void putback_active_hugepage(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 	spin_lock(&hugetlb_lock);
-	SetHPageMigratable(page);
+	SetHPageMigratableIfSupported(page);
 	list_move_tail(&page->lru, &(page_hstate(page))->hugepage_activelist);
 	spin_unlock(&hugetlb_lock);
 	put_page(page);
diff --git a/mm/migrate.c b/mm/migrate.c
index a3e1acc72ad7..c8d19e83f372 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1275,13 +1275,12 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	struct address_space *mapping = NULL;
 
 	/*
-	 * Migratability of hugepages depends on architectures and their size.
-	 * This check is necessary because some callers of hugepage migration
-	 * like soft offline and memory hotremove don't walk through page
-	 * tables or check whether the hugepage is pmd-based or not before
-	 * kicking migration.
+	 * Support for migration should be checked at isolation time.
+	 * Therefore, we should never get here if migration is not supported
+	 * for the page.
 	 */
 	if (!hugepage_migration_supported(page_hstate(hpage))) {
+		VM_WARN_ON(1);
 		list_move_tail(&hpage->lru, ret);
 		return -ENOSYS;
 	}
-- 
2.29.2


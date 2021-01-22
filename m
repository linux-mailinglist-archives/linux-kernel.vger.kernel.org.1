Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D11300FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbhAVWYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:24:31 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51936 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730619AbhAVTya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 14:54:30 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MJmsV8170514;
        Fri, 22 Jan 2021 19:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=o4AB3ojJGlCjqbBcwbXii0wGgs998LKazPmP6JzeEbo=;
 b=o4Cm+ah4JRUvnLo2FkHIOtArn3mMxxTVU5Rp0M/n3pi5CBDeoKygu14tZQcm6I1vFF48
 V4GNK5ml6yehuo8fL0hL8azg/U2bMScdiJc7N+eiFfJ91SKXhObWSAhiCj/SeR4o5C21
 RhPgp8wj/Nq0zOzR49EJi2bXZaupQNPtD105ZkTQcJk4eQt9V69LMyRc5n+t4EtuUNGx
 HQ2kVJnkgiEucQaP3kRTMxQm5QpGDgjtKbhfLAn8C95JbGp7jd0prGbJ6UFlAYsFYDYz
 VuB4kUvoUIV3lI2vjL29qkptlEid9ATww5odujyY6OaHq4PPQOff1hZRyTR4TD3OSxBC QA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 3668qrnvey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 19:53:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MJoAfb135241;
        Fri, 22 Jan 2021 19:53:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 3668rj2syu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 19:53:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cz2fhMZ0ddzUSxstBwVV1E7l4mmuFA8BMxvvdhhBTEgzfycRgw3D4LfydOp3WFL3NU13TcIzivU9pS7pFNbxBiEnBYAFL0UF/53/3EXHyuQE6tYfyiF6ZhI8GDV9LwCNCQ89tNvmgTM7mfP44edL9dHZ4lZuAgVtCmvcurQbLPHCvRqxApA4D1uRx1ZGzTcEMQfKyGUg1Mcial4LFreWNPm8nPVDsC0/MgACuLV+GVvVIiPGhMJfHEktH1c8WEH0rEEZu5ckO2t3NtjZDvvMJPR7uf2hbZ+Y15G/0ug9jzULC8dxjY2x31lAxg8p/B7lWGYyYHiMEWsQFCscH9igQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4AB3ojJGlCjqbBcwbXii0wGgs998LKazPmP6JzeEbo=;
 b=DvZ+BJO39RK54y4v0jOpxo2CxOenztZAaODlCcBDyOOHjUqIuxDYIfnGu+WmjnTaAtA9T4QjSEGCQZfBxXLx6w+3o/C4kKfYtUH2RcmsX4nbbCjLgLM/Yp1xUI07Tj+/QjudjK08mJElavlO7Vwa1IhSpf+EuLb1XwnuDBhzMQfF5fteFN5Q0weeVrYQK+yYhmIGgyQ0cezvm43dfcfuJvGkmoYzyQ5wYntKnOnOpJtnG6+oiLGsLq3IPrHoBUEkLek6K6qvxXa9DpfBu6lYuksV3wdUp+JEXHPzpM2xPgnpZwOEN+l+hKKtHHS1aHiWbubF3xIz+EyRDLvZueK2MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4AB3ojJGlCjqbBcwbXii0wGgs998LKazPmP6JzeEbo=;
 b=lG4jWU1lfER5J+1Cb75z/FpG0TasdKLswVNIL/444CEIeE7yU4FkMZGNJ/4IBG8CB1XvRI4SdXkI5Irm6a5Xy5CxWrJqpoXxAgxFD7fJ6v8h327VlhYusngl6B3XiP9fREXePTh3nmao2nYIPmqWK9LxDhESoNr5AjChxWjlIPk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4723.namprd10.prod.outlook.com (2603:10b6:303:9c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Fri, 22 Jan
 2021 19:53:10 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.015; Fri, 22 Jan 2021
 19:53:10 +0000
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
Subject: [PATCH v3 2/5] hugetlb: convert page_huge_active() HPageMigratable flag
Date:   Fri, 22 Jan 2021 11:52:28 -0800
Message-Id: <20210122195231.324857-3-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR19CA0071.namprd19.prod.outlook.com (2603:10b6:300:94::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15 via Frontend Transport; Fri, 22 Jan 2021 19:53:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c239d85b-1af1-433b-53fa-08d8bf0f582d
X-MS-TrafficTypeDiagnostic: CO1PR10MB4723:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB47235068716A1717B5ECB4BDE2A09@CO1PR10MB4723.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SoTwNcl6v7MrJTiFxSmnvE6sCz6XKtgyhpCKlKg4/zXwjFfFstVhrOYn/Cw7kIy9NJLTpVeMFBlg63aniN+bzFG81EG+PEaQd+7d3LhMNRc0Gz70m7VJJlphUbeOMcezpWCIQaXLYxwnBl6JhjDu7gErAMMq64e6TORGzpfiIDSrtn1dvJ3uyYRrafc1BJsM87cXFhJeMMsuUInFrX67mgV6pZdoCSIBBV4s42YNhvHWISz+pB9ZCpBe9zQlZoHKbLih5IWpr89PGvSpqSA0ISzgS8x1KOeidJOVWXL3OKNt+SGImJAUIm7nE93kljDKKpSq9NUZi1yh7bvDVt4pgWBlLfE4yZ+gq8UDcRNXhCcSgQoaHE1vrSquG1MwRl48PHGX/XejVXxscSwH+H8iI8WbmL0hMHGBAfVcbMb17M5TRZrZ0vZ5Tsu3IqRREgY7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(376002)(366004)(346002)(956004)(16526019)(186003)(2906002)(8676002)(2616005)(6486002)(8936002)(36756003)(44832011)(52116002)(478600001)(86362001)(26005)(66946007)(107886003)(7416002)(1076003)(83380400001)(66556008)(66476007)(6666004)(7696005)(316002)(5660300002)(54906003)(4326008)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zastUYBfdtl3ZJnu8DQFq7gtrsnaHL0AVe6TQmLam8f+TOhS/ctf9ijDKySv?=
 =?us-ascii?Q?mZOFrSQFfbDM81XPtOBapmQu+rAFVeVfrohrDH+8XjNXObIcBcp8a8d0vHwO?=
 =?us-ascii?Q?qFFcwtKVtoU8WtAyTV5ctH7p94E2q6drUIC53TvQVO4uc6t7ym+E7CcTHFIg?=
 =?us-ascii?Q?NYmfWbqXY672N/5lzaiRe/KTbTGL29wUXaFEihnADPJHRR1xiABe+N+Swdx/?=
 =?us-ascii?Q?AsSm0BJPY7UZdFiAKppiX9hW2jKIfzCwUP1m0yKOiVFLFnhH3T4Bdua+QPkG?=
 =?us-ascii?Q?3AXAaGa77uNYb9uHzixY2NaNEPiSND34TfUWSg99Vz5MlY6tB0Jq+q5Djzx9?=
 =?us-ascii?Q?S68J0UPZ2/4V16SAx3H0HboX3Hml18rRCDu7uOj6imVnIojEluu254nj7WTY?=
 =?us-ascii?Q?DISwG+b0Ay+8fL649UmuZYKcjgSJPWuFwRShl1uLnnXCOVGO2+ugJCU/rXOW?=
 =?us-ascii?Q?WpIrudw+FOHuX+Ijri3k8J2ft7mL23+aGWOOZSkXu2fslMun3/cbw/2Yga3b?=
 =?us-ascii?Q?+mGgLOC/D7MvjPCgor2zXmTouzZibbVN4sLAl+v/wCxooDYuMrmsHp+gVyTA?=
 =?us-ascii?Q?tHHtY0HLuaumDS5WzTL3cxD11Rs2w2eh+WBr/GDIPgIERTLwh16s7Ui/awTe?=
 =?us-ascii?Q?yAZ4rdVV9g6jQdwskFavTJ0ObRF0ziUR/aHoUSi6XZE8181ttywr2K4m8S9e?=
 =?us-ascii?Q?0RP4yeap3ym1ROZpZj7NNcjJ2I0sCvHoBKpYbjO2KeDu4atlubDPwxCODlNx?=
 =?us-ascii?Q?ZMs6KzuFwtM11GSeU+nQCsK9m6pZq5NKZpOquNKgd/RhNqbv23eSOO/VMT/y?=
 =?us-ascii?Q?oqbLdxFTmP5ldR/wu1T9R52OXXqdSD7CI2FG7eAoZ5mxTKMEJRZYuGQn8G8V?=
 =?us-ascii?Q?KOLg5Oj0cORgo4uIcqv/qSbhpTbFHtG8J2EYQ1SuEwQzc8ncUXicA8ljDqg4?=
 =?us-ascii?Q?7NesPkfN9brzdDLl7wq9k9JC3nUS6MkWerVrbFAimDfkp2D9Dqjj3AAHTbFu?=
 =?us-ascii?Q?O6Vbo6oRuoieFFMPaVzg6bYeoXtc8jEZidZE7V1PbA5jxUFIVZbDbgukr0I1?=
 =?us-ascii?Q?oOJCa9S1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c239d85b-1af1-433b-53fa-08d8bf0f582d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 19:53:10.0094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cxfof56Xt/WcYJ3Bu1oqWSLk+0GdJTVe8F5YaNSCHs17iM4YbLkeqwJioWFFx8vgKQrpTBSFfPx9DP4LuRewMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4723
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220101
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new hugetlb page specific flag HPageMigratable to replace the
page_huge_active interfaces.  By it's name, page_huge_active implied
that a huge page was on the active list.  However, that is not really
what code checking the flag wanted to know.  It really wanted to determine
if the huge page could be migrated.  This happens when the page is actually
added to the page cache and/or task page table.  This is the reasoning
behind the name change.

The VM_BUG_ON_PAGE() calls in the *_huge_active() interfaces are not
really necessary as we KNOW the page is a hugetlb page.  Therefore, they
are removed.

The routine page_huge_active checked for PageHeadHuge before testing the
active bit.  This is unnecessary in the case where we hold a reference or
lock and know it is a hugetlb head page.  page_huge_active is also called
without holding a reference or lock (scan_movable_pages), and can race with
code freeing the page.  The extra check in page_huge_active shortened the
race window, but did not prevent the race.  Offline code calling
scan_movable_pages already deals with these races, so removing the check
is acceptable.  Add comment to racy code.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/hugetlbfs/inode.c       |  2 +-
 include/linux/hugetlb.h    |  5 +++++
 include/linux/page-flags.h |  6 -----
 mm/hugetlb.c               | 45 ++++++++++----------------------------
 mm/memory_hotplug.c        |  9 +++++++-
 5 files changed, 25 insertions(+), 42 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index b00801fd6002..e1d7ed2a53a9 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -735,7 +735,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 
-		set_page_huge_active(page);
+		SetHPageMigratable(page);
 		/*
 		 * unlock_page because locked by add_to_page_cache()
 		 * put_page() due to reference from alloc_huge_page()
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index a7eb05315c6e..58be44a915d1 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -480,9 +480,13 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
  * HPG_restore_reserve - Set when a hugetlb page consumes a reservation at
  *	allocation time.  Cleared when page is fully instantiated.  Free
  *	routine checks flag to restore a reservation on error paths.
+ * HPG_migratable  - Set after a newly allocated page is added to the page
+ *	cache and/or page tables.  Indicates the page is a candidate for
+ *	migration.
  */
 enum hugetlb_page_flags {
 	HPG_restore_reserve = 0,
+	HPG_migratable,
 	__NR_HPAGEFLAGS,
 };
 
@@ -525,6 +529,7 @@ static inline void ClearHPage##uname(struct page *page)		\
  * Create functions associated with hugetlb page flags
  */
 HPAGEFLAG(RestoreReserve, restore_reserve)
+HPAGEFLAG(Migratable, migratable)
 
 #ifdef CONFIG_HUGETLB_PAGE
 
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index ec5d0290e0ee..db914477057b 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -592,15 +592,9 @@ static inline void ClearPageCompound(struct page *page)
 #ifdef CONFIG_HUGETLB_PAGE
 int PageHuge(struct page *page);
 int PageHeadHuge(struct page *page);
-bool page_huge_active(struct page *page);
 #else
 TESTPAGEFLAG_FALSE(Huge)
 TESTPAGEFLAG_FALSE(HeadHuge)
-
-static inline bool page_huge_active(struct page *page)
-{
-	return 0;
-}
 #endif
 
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8ec6138ca81b..f1a3c8230dbf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1353,30 +1353,6 @@ struct hstate *size_to_hstate(unsigned long size)
 	return NULL;
 }
 
-/*
- * Test to determine whether the hugepage is "active/in-use" (i.e. being linked
- * to hstate->hugepage_activelist.)
- *
- * This function can be called for tail pages, but never returns true for them.
- */
-bool page_huge_active(struct page *page)
-{
-	return PageHeadHuge(page) && PagePrivate(&page[1]);
-}
-
-/* never called for tail page */
-void set_page_huge_active(struct page *page)
-{
-	VM_BUG_ON_PAGE(!PageHeadHuge(page), page);
-	SetPagePrivate(&page[1]);
-}
-
-static void clear_page_huge_active(struct page *page)
-{
-	VM_BUG_ON_PAGE(!PageHeadHuge(page), page);
-	ClearPagePrivate(&page[1]);
-}
-
 /*
  * Internal hugetlb specific page flag. Do not use outside of the hugetlb
  * code
@@ -1438,7 +1414,7 @@ static void __free_huge_page(struct page *page)
 	}
 
 	spin_lock(&hugetlb_lock);
-	clear_page_huge_active(page);
+	ClearHPageMigratable(page);
 	hugetlb_cgroup_uncharge_page(hstate_index(h),
 				     pages_per_huge_page(h), page);
 	hugetlb_cgroup_uncharge_page_rsvd(hstate_index(h),
@@ -4218,7 +4194,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 				make_huge_pte(vma, new_page, 1));
 		page_remove_rmap(old_page, true);
 		hugepage_add_new_anon_rmap(new_page, vma, haddr);
-		set_page_huge_active(new_page);
+		SetHPageMigratable(new_page);
 		/* Make the old page be freed below */
 		new_page = old_page;
 	}
@@ -4455,12 +4431,12 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	spin_unlock(ptl);
 
 	/*
-	 * Only make newly allocated pages active.  Existing pages found
-	 * in the pagecache could be !page_huge_active() if they have been
-	 * isolated for migration.
+	 * Only set HPageMigratable in newly allocated pages.  Existing pages
+	 * found in the pagecache may not have HPageMigratableset if they have
+	 * been isolated for migration.
 	 */
 	if (new_page)
-		set_page_huge_active(page);
+		SetHPageMigratable(page);
 
 	unlock_page(page);
 out:
@@ -4771,7 +4747,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 
 	spin_unlock(ptl);
-	set_page_huge_active(page);
+	SetHPageMigratable(page);
 	if (vm_shared)
 		unlock_page(page);
 	ret = 0;
@@ -5596,12 +5572,13 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
 	bool ret = true;
 
 	spin_lock(&hugetlb_lock);
-	if (!PageHeadHuge(page) || !page_huge_active(page) ||
+	if (!PageHeadHuge(page) ||
+	    !HPageMigratable(page) ||
 	    !get_page_unless_zero(page)) {
 		ret = false;
 		goto unlock;
 	}
-	clear_page_huge_active(page);
+	ClearHPageMigratable(page);
 	list_move_tail(&page->lru, list);
 unlock:
 	spin_unlock(&hugetlb_lock);
@@ -5612,7 +5589,7 @@ void putback_active_hugepage(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 	spin_lock(&hugetlb_lock);
-	set_page_huge_active(page);
+	SetHPageMigratable(page);
 	list_move_tail(&page->lru, &(page_hstate(page))->hugepage_activelist);
 	spin_unlock(&hugetlb_lock);
 	put_page(page);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f9d57b9be8c7..465164be4d2d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1260,7 +1260,14 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 		if (!PageHuge(page))
 			continue;
 		head = compound_head(page);
-		if (page_huge_active(head))
+		/*
+		 * This test is racy as we hold no reference or lock.  The
+		 * hugetlb page could have been free'ed and head is no longer
+		 * a hugetlb page before the following check.  In such unlikely
+		 * cases false positives and negatives are possible.  Calling
+		 * code must deal with these scenarios.
+		 */
+		if (HPageMigratable(head))
 			goto found;
 		skip = compound_nr(head) - (page - head);
 		pfn += skip - 1;
-- 
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C482F89FA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 01:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbhAPAel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 19:34:41 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50260 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbhAPAeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 19:34:36 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10G0TLKc139387;
        Sat, 16 Jan 2021 00:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=1+UJZoZJUHtRu356Yu5J7VTmRAWtMXyT4hDL9j2ixC8=;
 b=wRV9YPTP10Q0MhoZLzT8JYPELYqLCaXbT7ZGOu4ugH1nGFMpt6z2i+W6Jw3JpNzhOxrI
 CgBdb7R+GQ+8Nvp8vBwaw8ojDNFwAXfZd0iIK36e+M4ZiHoVow5Oo0M2ggPADUW4vhwT
 qTM9/4UhSBQcy02O3f0RXHfbPF0xu/6PCn3dFRGz9agFdDhBss4CHLF6APDxhBZGHXPX
 rKHfVzg6xG8gYKGi5XCQYSiEsfBUocHnXzwCWKuab1FtU26MAizrPKccVhxj5+qKOOwK
 e7ba3DYKU42T0XhQdF2o3QiaH58dWktpGLkFnESskqtTRBhCTZrluUZ3CeHYk3Y0Rzp0 fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 360kvkf62d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jan 2021 00:33:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10G0V38P035166;
        Sat, 16 Jan 2021 00:31:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by userp3030.oracle.com with ESMTP id 363n8qs8r3-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jan 2021 00:31:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1MaY3uoM8rf9Lr+6++0zu8FA7DozYLC8aIRRdhq9SHYuCzdIemqbxFherWGhQjGLJZIv3bhyccuOrXjr1+TifPuK7/psXHMkV9JlZt9vxqkORVwYsMJFMm4K+jTtWuk65XREsxSszFSaawsIYf4yUS8HiNYMfLinLTM5daA6cRqWZWTC9ZEtqHteqXBj6d/bEwSJzesRTXDQ14ASIz1F0BN1pgAe5FTrtGBJcZyKJjtr5C8HhUvYTq2tRmy9GkQcHAF1tMuBDP/o/V45LBHj6HLp6RpjQ0ofZeyxKerjf/ZMd7zybvj7Mpwsh2mMiISRpc6oj6cEjnh1XuBoxejxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+UJZoZJUHtRu356Yu5J7VTmRAWtMXyT4hDL9j2ixC8=;
 b=MxxXVxsFO7jvClwBIWZ2//Uyb7vPVlF2QkruxA5xS1ccAJcJzlfA690crl3eRg37mEi8YbRORIIFeCUQvFyJsPBvzNzgA1yZQ/0xFwJjuXmRYq07kb5Us4hLJu0oQUHrJ+f/XNdWpeOwSyR6JHKh4/tbHrOzOCavpv3wKoXaD4t63O0OMdPKEW/fkZILMCdoTExv/ACoqSaV+NcClk0L1XuAVikQhrTUMHk+/uXxN5ePcElGySRNJwvxYvGWM1j0v1M0/CqUAlBJ1CLeMkBdaFWtky6EsAjVtZ85IZV/ewKFRMvSh4yudNzB35YQujAsePB1XMpLEo51GadMfP/BFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+UJZoZJUHtRu356Yu5J7VTmRAWtMXyT4hDL9j2ixC8=;
 b=AK/HkJIAcAcmBbctt9MRVoIJ/1vHCuluIHaBsJl33DvbjVp8Sb0ZcxmsjgvLFrOkq5w0+mjxJCwUb6vEF/V6JjWV9vWzfqUt/69rPN5LOkeGb1VdsGO9tp7h07avtyFdxledqGnIXRJFSLC8PXq1tMcxnP2O4TModcbGmikmMWI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4450.namprd10.prod.outlook.com (2603:10b6:303:93::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Sat, 16 Jan
 2021 00:31:28 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3763.012; Sat, 16 Jan 2021
 00:31:28 +0000
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
Subject: [PATCH 2/5] hugetlb: convert page_huge_active() to HP_Migratable flag
Date:   Fri, 15 Jan 2021 16:31:02 -0800
Message-Id: <20210116003105.182918-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210116003105.182918-1-mike.kravetz@oracle.com>
References: <20210116003105.182918-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO1PR15CA0060.namprd15.prod.outlook.com
 (2603:10b6:101:1f::28) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by CO1PR15CA0060.namprd15.prod.outlook.com (2603:10b6:101:1f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11 via Frontend Transport; Sat, 16 Jan 2021 00:31:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e99cfc14-c953-4e21-13ba-08d8b9b6108c
X-MS-TrafficTypeDiagnostic: CO1PR10MB4450:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB445093DC6C911CC0A57820E6E2A60@CO1PR10MB4450.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RU8YNEVH7wsJ/3X6RoHYQkJoTyOXZzJ3AQhRJlV2TSeG2peJK70Ukpk1VP2ROnCW9qskiM8aPEIsVviYOV+KKocqgBib+oSeqMHKTYmuXTEOWkXec/4MDLYDLcirtGcDo72aXlx+UgIYXAnndegkkz9n5xspNLFZ6ygU6IoQnji7uvqUVFOzpClvzVHN1txfEGVfQIgsXUZVLGrRqD9K/LZb2+cTtTyabHVv8ELr2EJ8jZTNSa7IKbH4xvrY27vhZDDTK3hiK+QD3ckm9qq5erbuOROpIXzWmvTkm3NUy5PVnztnceBw4FUOUDtncPcQpEoJFx9oRgIVN7/PEBGMyJbAngb22Vr9bk9Lhah3i4esqG5usR1Xt5gZqROrSI8lmMrsqNkT57bCcfJETjeLAFB00rCmksA6DnNqyunlCVqXfBOiOSTdwZvu1gaMtKJr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39850400004)(136003)(346002)(366004)(6486002)(478600001)(1076003)(6666004)(86362001)(36756003)(2906002)(44832011)(316002)(5660300002)(956004)(8676002)(107886003)(16526019)(26005)(52116002)(4326008)(54906003)(8936002)(66946007)(66556008)(66476007)(2616005)(186003)(7696005)(83380400001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?syhWH4JXS9dd+8QhX0WvEWNBEOyY276SP528yGKurG9LVvxPqcaE18PkNx6n?=
 =?us-ascii?Q?osz/ZhesnspZZSyfKZKccj0kUQANFUbbFfOv9wLDaR/1yUm6tupNoW7VDaMm?=
 =?us-ascii?Q?KrzEgPzsj6I4dLfflkBa1GDO3dvu0aCz0zok//mWlcBOId7Bo3WgY3BOfv9Q?=
 =?us-ascii?Q?qSmoohyK9Jd5oKeCMQILeJno/4HbXl/nOkdgJVZq238ZafFTy4QloxvTY/qG?=
 =?us-ascii?Q?86l2PHPqzfpEpdTZ94ylu7LZ/CnoHV9ZVM2HdkgOdetRpXZvetr+hWH9cCAE?=
 =?us-ascii?Q?y1QDvOShqkK5S5hr3AtWGpsCrSVorn5BPibQr1e8M6AzCdS+zZ0rHTDpIXVT?=
 =?us-ascii?Q?0jyuSXhrlIA2FAKy6nS8NKnzO5g5stcWAeXElEqboDTCUx4D0Gzsl+4MEUXD?=
 =?us-ascii?Q?ejE0Bd+V7oGZ+an0mW9mpU0IIv+nqtRkwz6J6hc0SwRuafdjGVBi2j4df3O9?=
 =?us-ascii?Q?zqqyP1/JoFo1K+TdjDkwmNZ8CyhdLINQ56MZy0S9uB+mMwqNqKsa0mZsjuTh?=
 =?us-ascii?Q?5pHDAfiIaHGW7ja7WLGoIv9ndupAFIAU9hfpZcO8oSfleD/CbXX+03uTypTO?=
 =?us-ascii?Q?syppROJStZWC56VHc68GwYKH7zVyqSMOLNtDR87hkB1G+G0a23eK4momTaop?=
 =?us-ascii?Q?rAPIpx9LLCJYOpUU+79wnfHOQoBMLi8/WRUFL5/PgqjIJSDHrPTgR4FWy780?=
 =?us-ascii?Q?6+WH6pD/98Ukt31bIn+tUYclD8xX72x0AqW2u7Vue1M+K5jgDgRkhUPKdV50?=
 =?us-ascii?Q?hD63CepIvKuy5LHWUAp/2c7iQGxEohrlavWFOAJ7pBdH8rrVKPrhSN4uRm5d?=
 =?us-ascii?Q?RU0XF3igBPIF3rPCZz26d9iNpnxa6ZAr7+gYeSbfNwZ74UQ3UIAPfLjOmMKu?=
 =?us-ascii?Q?TjLPg3bT+j3LW4lL0eNb4WLzOmErnfwm+YldQVNRBoKabS0KiATvT8M2TbOD?=
 =?us-ascii?Q?2ZxzL7VagqkOFeCDyruqS9eCamwvjNN3z0GcSFGsz28=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99cfc14-c953-4e21-13ba-08d8b9b6108c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2021 00:31:28.7806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYWqgfvFxUUTopfzFF40y+yXcgV6Wuk5Hvfkv4y2jZH2mJ78imBy9zM4XACT+7/J3yGuVZK8wzFoMY5K9fqefA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4450
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9865 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101160002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9865 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101160002
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new hugetlb page specific flag HP_Migratable to replace the
page_huge_active interfaces.  By it's name, page_huge_active implied
that a huge page was on the active list.  However, that is not really
what code checking the flag wanted to know.  It really wanted to determine
if the huge page could be migrated.  This happens when the page is actually
added the page cache and/or task page table.  This is the reasoning behind
the name change.

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
is acceptable.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c       |  2 +-
 include/linux/hugetlb.h    |  4 ++++
 include/linux/page-flags.h |  6 -----
 mm/hugetlb.c               | 45 ++++++++++----------------------------
 mm/memory_hotplug.c        |  8 ++++++-
 5 files changed, 23 insertions(+), 42 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index b8a661780c4a..89bc9062b4f6 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -735,7 +735,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 
-		set_page_huge_active(page);
+		hugetlb_set_page_flag(page, HP_Migratable);
 		/*
 		 * unlock_page because locked by add_to_page_cache()
 		 * put_page() due to reference from alloc_huge_page()
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 64f8c7a64186..353d81913cc7 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -480,9 +480,13 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
  * HP_Restore_Reserve - Set when a hugetlb page consumes a reservation at
  *	allocation time.  Cleared when page is fully instantiated.  Free
  *	routine checks flag to restore a reservation on error paths.
+ * HP_Migratable - Set after a newly allocated page is added to the page
+ *	cache and/or page tables.  Indicates the page is a candidate for
+ *	migration.
  */
 enum hugetlb_page_flags {
 	HP_Restore_Reserve = 0,
+	HP_Migratable,
 };
 
 #ifdef CONFIG_HUGETLB_PAGE
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index bc6fd1ee7dd6..04a34c08e0a6 100644
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
index b01002d8fc2b..c43cebf2f278 100644
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
+	hugetlb_clear_page_flag(page, HP_Migratable);
 	hugetlb_cgroup_uncharge_page(hstate_index(h),
 				     pages_per_huge_page(h), page);
 	hugetlb_cgroup_uncharge_page_rsvd(hstate_index(h),
@@ -4221,7 +4197,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 				make_huge_pte(vma, new_page, 1));
 		page_remove_rmap(old_page, true);
 		hugepage_add_new_anon_rmap(new_page, vma, haddr);
-		set_page_huge_active(new_page);
+		hugetlb_set_page_flag(new_page, HP_Migratable);
 		/* Make the old page be freed below */
 		new_page = old_page;
 	}
@@ -4458,12 +4434,12 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	spin_unlock(ptl);
 
 	/*
-	 * Only make newly allocated pages active.  Existing pages found
-	 * in the pagecache could be !page_huge_active() if they have been
-	 * isolated for migration.
+	 * Only set HP_Migratable in newly allocated pages.  Existing pages
+	 * found in the pagecache may not have HP_Migratable set if they have
+	 * been isolated for migration.
 	 */
 	if (new_page)
-		set_page_huge_active(page);
+		hugetlb_set_page_flag(page, HP_Migratable);
 
 	unlock_page(page);
 out:
@@ -4774,7 +4750,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 
 	spin_unlock(ptl);
-	set_page_huge_active(page);
+	hugetlb_set_page_flag(page, HP_Migratable);
 	if (vm_shared)
 		unlock_page(page);
 	ret = 0;
@@ -5592,12 +5568,13 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
 	bool ret = true;
 
 	spin_lock(&hugetlb_lock);
-	if (!PageHeadHuge(page) || !page_huge_active(page) ||
+	if (!PageHeadHuge(page) ||
+	    !hugetlb_test_page_flag(page, HP_Migratable) ||
 	    !get_page_unless_zero(page)) {
 		ret = false;
 		goto unlock;
 	}
-	clear_page_huge_active(page);
+	hugetlb_clear_page_flag(page, HP_Migratable);
 	list_move_tail(&page->lru, list);
 unlock:
 	spin_unlock(&hugetlb_lock);
@@ -5608,7 +5585,7 @@ void putback_active_hugepage(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 	spin_lock(&hugetlb_lock);
-	set_page_huge_active(page);
+	hugetlb_set_page_flag(page, HP_Migratable);
 	list_move_tail(&page->lru, &(page_hstate(page))->hugepage_activelist);
 	spin_unlock(&hugetlb_lock);
 	put_page(page);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f9d57b9be8c7..10cdd281dd29 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1260,7 +1260,13 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 		if (!PageHuge(page))
 			continue;
 		head = compound_head(page);
-		if (page_huge_active(head))
+		/*
+		 * This test is racy as we hold no reference or lock.  The
+		 * hugetlb page could have been free'ed and head is no longer
+		 * a hugetlb page before the following check.  In such unlikely
+		 * cases false positives and negatives are possible.
+		 */
+		if (hugetlb_test_page_flag(head, HP_Migratable))
 			goto found;
 		skip = compound_nr(head) - (page - head);
 		pfn += skip - 1;
-- 
2.29.2


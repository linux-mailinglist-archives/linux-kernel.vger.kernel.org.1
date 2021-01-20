Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BEE2FC774
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 03:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbhATCFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 21:05:48 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50930 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbhATBeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 20:34:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10K1UDBc117229;
        Wed, 20 Jan 2021 01:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=1Td/TX8Ho0q33dZW3yzF+EiHcp4lTewFB9iBKRO8LT4=;
 b=LAQzsI2IZ0zRD+Ftb24xQdsn/IgtSw0FTj63LvSRSNNtZqWbhhzJ7nrNJlX9QnYPKg7m
 X04w81xRcOMLF0TEs80SmfxDzSRBWUhFktr2Gpevj/xtB1mp+pL2cnEukIZ+SIGITNwW
 L8wgl40CRijHvA2gqmdjBwT9uJkSuwLAkDvDUMRiMwVgjTNLfD+icU0gMsoNVJENS6MF
 mnT0VyNvUJ7Ke4XCqtXICWA3m4tHRqqum2MHKW/49ugC03iqBPUtJsDZVyWqWHjyGNVZ
 RQgrLlrfs5Lbsizp8DI7TS72wEryIHA7aBdUtP9U199IV48cQ/mNLCpH0TgrhbfrUY0B og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3668qmragc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 01:33:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10K1UeBc016838;
        Wed, 20 Jan 2021 01:31:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3020.oracle.com with ESMTP id 3668qv5kr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 01:31:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SH1LAcexUiNUt43xyHDVd4r34MzNMr3uMKjlI6rnQoy5RGvvlWSN1DFz1AAj4h6S0VkDqL2lyRNdIEmyhn/roovqPokhhtRqtDVAI3XJhYKAbcFrJd1yx+VFS9HGLOZ7utm10bcK14/BWCfOzQ9+3EVP+7s9Pyl7COX1StE8bfatXIfoKFmRT2lgN/YU3JVjCgQ/Xm9wp+y2UhEYXjkh2y1KIRhLyxJ67M0vqn/URhzYs0nLT7OHaPwkgr/VfID8vH4OxV/pMc/BXI30IQbbYi4xY9HyJst6yM1nVhU8AjEUR+z3KqLhmRM+jkp1X5IChTC7aU2Xb9zwKAwBaUiq3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Td/TX8Ho0q33dZW3yzF+EiHcp4lTewFB9iBKRO8LT4=;
 b=ZJDzap4pbrDuRlaqtkhYQelaQ8feSHfM5Wh95NF926us+rz2GTkYmkrpUMdEtd5+JuHxlCXCztFBoJPZY0oMLWu2AfUuYBfJKqC2+Xekmd+y1LDT6zq2jeERQvHIlv4ZyumE2yousqBF16WpnCAIEP54xF6I2K0s7VuRGn+pE6T6FrAFkVJu+P6fOTiAcn90C+SQoaJxkLo4xOaVrxlNY63C9iYkqwk0dt5/oRdDtikx3+isFLcJoaDNe2js/tDzgHwRGSUAf8meTJInWjGkgZ2xDfmHA21+7WebNHDFuGVua0/5wM3CkKiOeHKkG6gB87UNnz1MbIzKQh92xcBR5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Td/TX8Ho0q33dZW3yzF+EiHcp4lTewFB9iBKRO8LT4=;
 b=RrdkytVuPnp4k0K8jI3xLja5POP1zmvHSBRv8i+aKmJHmfeLNwYpGQ3BRk1NMVez2FfvNCXvgVLlwTEs3HhfmiZlUO958zwwqyampw0Kt6vI6b+IykC8+TcTXI2xkptRxdn9VDNKAbmmZJhCctYUfDktsbRs+2zNBdj6gV8keMc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2384.namprd10.prod.outlook.com (2603:10b6:301:2d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 20 Jan
 2021 01:31:19 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 01:31:19 +0000
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
Subject: [PATCH v2 3/5] hugetlb: only set HPageMigratable for migratable hstates
Date:   Tue, 19 Jan 2021 17:30:47 -0800
Message-Id: <20210120013049.311822-4-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by CO2PR04CA0178.namprd04.prod.outlook.com (2603:10b6:104:4::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Wed, 20 Jan 2021 01:31:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f785e2a-fefe-482e-2b9b-08d8bce3165a
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB23842363ABBC1DB0FF80357DE2A20@MWHPR1001MB2384.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XRhN3C8WVJyTjlcLXDerVXg06u0U/fpsF/Rxbw7X9zvAnWlCd1aV31WaaJOG+3WtFoRynWcc4XowAPqfLtN8r285Zg2QBw14S8UyJEJvowZ3jOJXlAioAZGcqn0hWEUUJ9kJiwnS1lv+kCECuTsL60egDHL4lnd6eczVwxFOXaL46crc7YZ+Nb0DgFIy1AxQ1B5Yism7Tlhl+w6NbU0wEXQ3LKw567vTlgk2/tol0meigZyeDx10C5UU5glwBOC7TABXxd2jR2iwflM0i2iFEPi1JGrVvg0yTzA3e064iyok+OR392NGzPUDJ4TT+C015g0M6D4C4J/vz7zus+OuZJ9deOuOqeraA6ZgbPZJ+5skeHugdExwVBnv87K0cFcUAEHEhCt+/uVh5ChwdomA8u4x+Q4bK3KWvQF+cs8FRtYoAs8wZ+7gIdL2M00YsAKECeoSN7h6HdZ+SqTCLONufsESDWdYoWyXflgyXeHrOSmcw1bzHoIJrDjHgjsfgPYrxEEC3PqqtU6QYLpI0XJ21A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(366004)(136003)(396003)(1076003)(8676002)(186003)(36756003)(107886003)(8936002)(478600001)(16526019)(4326008)(956004)(316002)(86362001)(5660300002)(54906003)(6486002)(2616005)(7696005)(66946007)(66476007)(66556008)(83380400001)(44832011)(2906002)(52116002)(6666004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nu0FIzCdiTXHTgSCAjcyYPhq2E9m25KtX77VsWFLNyFWH9z7OCRnQkmFO4T3?=
 =?us-ascii?Q?RI+3t/gJvwxALmrC/UcdA3tDIytFoeOCVSD+nQg7ADrBMD0S0FttYRiP2qcE?=
 =?us-ascii?Q?N9az6nglrz+FD+HXGWqmH8bmNHNh/HPln+CxAO/2VvzVGJ5+R5dSxXsaCKar?=
 =?us-ascii?Q?x/QwAJZU8Sa2JZ6YQfngc53tZUVe0jV3cx+hZpqahgr4YtMv9iQmAJIaUSqQ?=
 =?us-ascii?Q?l1lv2s7dt7HphJyU3OthMzjm60cgQjrd875t/wblRlPaEhpBtpbBLbuvr9Ce?=
 =?us-ascii?Q?HYusAJSLldaXFx2fV7PWxMx3rw483jXNvS4yjNaN3nIptOrW5IG5vgFPfp1s?=
 =?us-ascii?Q?LEwvHCWjRFJNzWXDsVEOTrW32LYOYoyAjVGjBXXka4EzXUXu44fyc/h5lt5E?=
 =?us-ascii?Q?hzoxZX5fvDGF0mNvxuDHqtgI18Izpz6WH4ABtLZFbE+ndf4CIFOrL3zx7XZL?=
 =?us-ascii?Q?YdVOyGjQa2fiiFsmRUmjEW3DWMHxzxv1cF/kcneAEgU0KTxWCeMzaNQv3RzS?=
 =?us-ascii?Q?uQaR9f3z3spsvF1mM7Vnmvkhxpz2us43VkGZQfAbq2f9TpjuCfQwUJh+hCbo?=
 =?us-ascii?Q?Igi9KkFhQeTBe1CVjf4OKGu1n29eJkdns5ohx5apU4KvWbrzg4/AVJ3GlSrA?=
 =?us-ascii?Q?8vB//wT3aZWtQIlFa8BTho+7ZGbwlcCaG2zvNjUuXp/3DXxUgW6Afypggxp5?=
 =?us-ascii?Q?Adwv5QOoCD5FegNT1G/7grP8M8yIPBgvnK4szN2r4cRzYV9mbwoKYu96tBV4?=
 =?us-ascii?Q?hdvgsEj9+0Od+/b02lGVXNcPD2BPBNONKjevWzCD0HQ+yQt8KIzIcQgh/wv2?=
 =?us-ascii?Q?BeX9AxT/nhLJEaBee7rw1D8YgdTU+g8SKwuZjSUCf7bRcnr2aenmM/Fmm5VY?=
 =?us-ascii?Q?mIkw1Mxfq8sJdBEtgOPTlsY0ibOtfeaJk2pvKW2sGB0djxcWEM5vhshrfAT5?=
 =?us-ascii?Q?xxz+ewCzvYQcZ3jL1oUrUZwsj99QVOkVMN87JKNkI3ZY5UNuzsGMZSmrNcsm?=
 =?us-ascii?Q?dswrzJNp+uYCohzjkfN4hDeqH+tZqIPAhSNKondWANyGxMj8jdjgA55YEKKA?=
 =?us-ascii?Q?6HlnIiwp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f785e2a-fefe-482e-2b9b-08d8bce3165a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 01:31:19.3900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dN+0g+IOXPACFd6gaf6x0H4ODFVq29ip6xHeSz1u4x6+5mI47GnmXriEnAVEO0r5w7bpKIT9XYKR0IYxXyvIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2384
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=710 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200005
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxlogscore=760 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200005
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
index ec9f03aa2738..8b8acdafd0be 100644
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
index ce3d03da0133..1e17529c8b81 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -744,6 +744,15 @@ static inline bool hugepage_migration_supported(struct hstate *h)
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
index c24da40626d3..6e32751489e8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4196,7 +4196,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 				make_huge_pte(vma, new_page, 1));
 		page_remove_rmap(old_page, true);
 		hugepage_add_new_anon_rmap(new_page, vma, haddr);
-		SetHPageMigratable(new_page);
+		SetHPageMigratableIfSupported(new_page);
 		/* Make the old page be freed below */
 		new_page = old_page;
 	}
@@ -4438,7 +4438,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * been isolated for migration.
 	 */
 	if (new_page)
-		SetHPageMigratable(page);
+		SetHPageMigratableIfSupported(page);
 
 	unlock_page(page);
 out:
@@ -4749,7 +4749,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 
 	spin_unlock(ptl);
-	SetHPageMigratable(page);
+	SetHPageMigratableIfSupported(page);
 	if (vm_shared)
 		unlock_page(page);
 	ret = 0;
@@ -5584,7 +5584,7 @@ void putback_active_hugepage(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 	spin_lock(&hugetlb_lock);
-	SetHPageMigratable(page);
+	SetHPageMigratableIfSupported(page);
 	list_move_tail(&page->lru, &(page_hstate(page))->hugepage_activelist);
 	spin_unlock(&hugetlb_lock);
 	put_page(page);
diff --git a/mm/migrate.c b/mm/migrate.c
index 0339f3874d7c..943391cd1a7c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1273,13 +1273,12 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
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


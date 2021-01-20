Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89092FC773
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 03:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbhATCFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 21:05:37 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52868 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbhATBeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 20:34:22 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10K1SeBL121604;
        Wed, 20 Jan 2021 01:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=GkEtRCoCPbH2VxS8quwLysFsPwNTBQ+D3u0/k/wZa04=;
 b=EjkESOLVEQmZuFB1go6Z21hwwLt4H20skqKWxsgeFblBAUjHLGYc4QCEAaeO24sKuP64
 F8V8eGKUguAWgjUJgUQ1qlcAAmD66YJ+wJ4P8K1/ND+GupQHQ+FW/sI4bdYnM0tgwspI
 UGiE/xlQOpXCY5ckzIOTYlLXw2dQfbGtDkEfJmzKvJh08m+P8FMaRJ4NWX1QZCP3TW6m
 O8m7MBWzaNmzjWjNSXp9wbT9m+Yk9XM/ueQcDYABecKd514c4FrVuCoFTYNAM9bDk2f1
 LHmOhrvfxQEeigMf1AjIJwnAzFyqs2KEXhG3CJlkT7akINmY74DFOyquAXk5Moh/fo6q MQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 3668qr8ah7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 01:33:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10K1Tjrb072254;
        Wed, 20 Jan 2021 01:31:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by aserp3020.oracle.com with ESMTP id 3668rd56g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 01:31:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=be5EN3cfQIWaHsqzfX+GpMiTu/SfNFEVFe5e2BMaPCR0qFmwetttn30IP4M+MilhiX4y1PLkL/WI6md/dN3Nt0puX3rKfvy9AjlJA6q1wixQaSyCI6iDB0JvDQF56/CVB+w1Z267Wxg8Xwc95BWcQUboulYmwidb79QWOuHZwx9rkQa3Sm/bJ0p3imVftbijnBcG1k57wRovkJbKJuhyfBbpxCPqU+b3YBN1IkVw0fzn2JSJhT3xPwbhEiTJ0PL58SLDzp9yYlKFLGUZTzGXy7CszJQKQ4NCimnxIqjlHrk56258RMWCmZXr0At4i27BNxb/6pNtWpr1DfSW6HrOTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkEtRCoCPbH2VxS8quwLysFsPwNTBQ+D3u0/k/wZa04=;
 b=Q2kFcJa0tw533b109iO8edn61Lmcv+xWel+9xV1Rk7Oc/uOlg8DwUuxHNixWsALdCR0mTLWt+/8hvZo6B3KUsqKlf8gN/pDhKF4Oj5JNLYGXBus8Y4u/I8v5+r61Hh3a10qaaRrDDuyjfBGqaJH8TjJk2/2sCWyD6lVaogL7DgbRCf7k7xOcaPQpWRbmogEYKd9OSnFVpRBCQ/+zg+9W+GbdkTy6YPhZpG6xtSHccWw+/0j3a82s7Mb8dTVPT+t/N/v6w72rVpoVGIhfKzf2fb79pgs//MbLJu88iOuGoPyCYC9E5NVCXJVHtwIe39gdCkMHT3rJfHbcDlFO+HVV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkEtRCoCPbH2VxS8quwLysFsPwNTBQ+D3u0/k/wZa04=;
 b=ERsZm35kspP/WEUB8vgnS8bq6sXYShBvJ5EjK6YHEKKXd8YwX9yNPlYT8wIKVdBnEa1cGDDsPpDHsFCLxBDxzoaeADkDN8X8LCzh4vt73jXUnhSXtqvOqqRktPPazqM3/EyUOj+46BnC90xBVhpHslHkjfH7WXDdbX7zxPlVlfk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2384.namprd10.prod.outlook.com (2603:10b6:301:2d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 20 Jan
 2021 01:31:17 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 01:31:17 +0000
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
Subject: [PATCH v2 2/5] hugetlb: convert page_huge_active() HPageMigratable flag
Date:   Tue, 19 Jan 2021 17:30:46 -0800
Message-Id: <20210120013049.311822-3-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by CO2PR04CA0178.namprd04.prod.outlook.com (2603:10b6:104:4::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Wed, 20 Jan 2021 01:31:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0d9e085-0b14-4b72-0682-08d8bce3153e
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB23847988DA34527C7472AF75E2A20@MWHPR1001MB2384.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uky+p+qNNKCnR6uR6r+iGbkrv5ND83yhINZGrp2XEdEju2LuuU5sBravHVVuXEPiDoHn8EvB86J4G6iImT9tKmO1GbYmx5eWbhszxkn5zp50Omcz1WdjcNkMmYJxT7aDH/nIgffJxwbaW+tGtUs8ZqG8V6fTyZ+BdYjKjCKX+6iPKy1aoCKc1+78OPeKsQYFUok3OdsfNOttssTq8vaDujrle4p3dlFnxIVzZfnRSbjtfqHXYpnt9I+egeAb00S/DkZOVMSHJxA2gGL1UbucSw2uDFwpJnAtjDIxD2+6BA9IoimIls1A80fOMBys/yp/35NrAKwK7bHSXBZ1AjhuTMOAUEYZXzWrlyknvNJtnxoNuFVHoehAbCXGPRWPkjE6K3VLjOaxnZqssws28tqBdWRgfO3hmHaBuRvi72cj6RGk4VEa8YHxbwPo+zkyMsuu7sibGPEOA6nxW0g49lz/LQWhfbi82BNL0Ka6/Gc/+7vHkylWngrhipxbwqZanlBnTg1UdJoQdsIU/pNj47wT2jGLva+Yb/2qUduDzoO4/BlNvtaaVAs8onDFaSSRlBP4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(366004)(136003)(396003)(1076003)(8676002)(186003)(36756003)(107886003)(8936002)(478600001)(16526019)(4326008)(956004)(316002)(86362001)(5660300002)(54906003)(6486002)(2616005)(7696005)(66946007)(66476007)(66556008)(83380400001)(44832011)(2906002)(52116002)(6666004)(26005)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QQprUyw28FEtVCEmXd/q+R3oONHAbCUgC2AvwIjr+/g3fO+WH9wdiWHN9sq8?=
 =?us-ascii?Q?EwAyA9utIcquz/U9iOnCVJpaFpeqVRCnAkEbFEE6F7PIToSC0Ie1iSJBdYpk?=
 =?us-ascii?Q?hCZ89YxYunMhmqAJAwu6Q9Dzz1Yql/Ijh7CLk0vUb4SWtJdUkcPnN2YctowA?=
 =?us-ascii?Q?6ec2TgvC21Ybk8LGt79kVlb/EgTESCsaZJza/p8XH+YHckrlS2FyELAO3Xsv?=
 =?us-ascii?Q?J5J0r8hOfUFmKCOgRp5FIb8ys6zU72p1+aTx+LbmVSH7OfKIxtr2LD9f1XuY?=
 =?us-ascii?Q?tm3RbyAJ2C26WzwFRdDVDwH0kI1nBNwv+fqHxG3HzkljJVV1PPn8Z9DIgDE6?=
 =?us-ascii?Q?M+s4FWNT7zB2YcxAZ8KV/I/lf5wgcNcvOe7qFMdyx7Lvwp4BDqMDbaFOKMDN?=
 =?us-ascii?Q?lLDQRVA4lDVGaLb7+2H4/eW025RSiCpiPXlA6gVrDrk3bpE3IgWYdIirHkwS?=
 =?us-ascii?Q?JUKPFu/Dl4MNIXZu5W/OPflzOd/Kn1zG0YdC5kEHPGUDxSYsdOSgsPMPZSan?=
 =?us-ascii?Q?nYaOCKdl79SR6RFp02y/EnXo4oXvyS4TU+kGCm+7ucoLbS2gmQ60CrrtnpQu?=
 =?us-ascii?Q?hC9f8jwvqP4qjpGBVCneSCgrei7hyvHIPB0r7pCY+HCCt6wrOMGzLIcC/NwJ?=
 =?us-ascii?Q?kWF8FI218iIbYkDUhE/uNc+gOxtljO49qKcIABPyRzFHzy1fCKIWp9/E8q+/?=
 =?us-ascii?Q?8klLqcp3X5luxbd5S40JpT59PrmXgPYjO3dZglL9Upy0zwVOkjCqKC0CXmf0?=
 =?us-ascii?Q?+ifHTOpecEMWKydA2C39M0/6c6DldPWMviBeKUpe5vh/YbHdeK5rveEvykm+?=
 =?us-ascii?Q?uLysymPPr0pcPiC5y1c1IoVWeeZ302IYSn42Y6JLR8+/hi4YkMWWTby+O25J?=
 =?us-ascii?Q?lOAGs35kqFIAU5OKe4hWgu8KJrFrzk/ii2+EKOFtWvJlyr3pY0LNj8KDrZSa?=
 =?us-ascii?Q?3TX+BC41ZpymskokQViIXtYKLnpxizLX53260GgdAY3YsLOgXdXVsCV7tyg4?=
 =?us-ascii?Q?9iXgdk819hvMjmLCx5L6cfzEA3jBlApRj8/I/Kgc97f0XZ5n98E/qee3tGMq?=
 =?us-ascii?Q?jFtoaC4M?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d9e085-0b14-4b72-0682-08d8bce3153e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 01:31:17.4588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: du3cj/HSWycxuFgPgeGjypPPRnzrr+FqyGrlx88ChOFHJEDvf2Smgf+ye5/95i53eAt0JxQq6nErLxkDCdChgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2384
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200005
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101200005
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new hugetlb page specific flag HPageMigratable to replace the
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
is acceptable.  Add comment to racy code.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c       |  2 +-
 include/linux/hugetlb.h    |  5 +++++
 include/linux/page-flags.h |  6 -----
 mm/hugetlb.c               | 45 ++++++++++----------------------------
 mm/memory_hotplug.c        |  8 ++++++-
 5 files changed, 24 insertions(+), 42 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index b8a661780c4a..ec9f03aa2738 100644
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
index be71a00ee2a0..ce3d03da0133 100644
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
 
@@ -529,6 +533,7 @@ static inline void ClearHPage##uname(struct page *page)		\
  * Create functions associated with hugetlb page flags
  */
 HPAGEFLAG(RestoreReserve, restore_reserve)
+HPAGEFLAG(Migratable, migratable)
 
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
index 8bed6b5202d2..c24da40626d3 100644
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
@@ -4220,7 +4196,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 				make_huge_pte(vma, new_page, 1));
 		page_remove_rmap(old_page, true);
 		hugepage_add_new_anon_rmap(new_page, vma, haddr);
-		set_page_huge_active(new_page);
+		SetHPageMigratable(new_page);
 		/* Make the old page be freed below */
 		new_page = old_page;
 	}
@@ -4457,12 +4433,12 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
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
@@ -4773,7 +4749,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 
 	spin_unlock(ptl);
-	set_page_huge_active(page);
+	SetHPageMigratable(page);
 	if (vm_shared)
 		unlock_page(page);
 	ret = 0;
@@ -5591,12 +5567,13 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
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
@@ -5607,7 +5584,7 @@ void putback_active_hugepage(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 	spin_lock(&hugetlb_lock);
-	set_page_huge_active(page);
+	SetHPageMigratable(page);
 	list_move_tail(&page->lru, &(page_hstate(page))->hugepage_activelist);
 	spin_unlock(&hugetlb_lock);
 	put_page(page);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f9d57b9be8c7..563da803e0e0 100644
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
+		if (HPageMigratable(head))
 			goto found;
 		skip = compound_nr(head) - (page - head);
 		pfn += skip - 1;
-- 
2.29.2


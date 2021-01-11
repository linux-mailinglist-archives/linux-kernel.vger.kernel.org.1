Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2210B2F217D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389549AbhAKVFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:05:10 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48560 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389211AbhAKVFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:05:08 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10BKx1G9130703;
        Mon, 11 Jan 2021 21:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=cmMCRA+QnuJMI16EDYG2Oyfmelmp1l1H3Ogz1i+kVL4=;
 b=vRXcCob/25NsDZIyoiZTgXRI+Jfap33j0jqfrdnCGUAeCHgMxH4QO+py5BWhJdSeAnTq
 hCZAz+ZyxZq0xBYx3r5uL3/eoIO98/1LD5DxVKK3AF2OFSYxjwoDHk3JloavRvpEWKSh
 VTd7psp6iRhjRjvtbWpeMH59S8vgeOxm2kREvsMHPfKU2tRZNnD+oWJPO89h779pqeKp
 4LgyiHV+7k6++17BBIKKuyG5Zc5nhmPR/L+i7w4bYUc1CuHyECtvU9zRNhMQ13Qsb4dz
 XBdiHf6Nk5gODIqEZcKUbw6ihafkhCcwk8XDUgQeJ1vofVwGBiOUkw9cJA9gLadiTF9B YA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 360kvju865-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jan 2021 21:04:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10BL1Maw178669;
        Mon, 11 Jan 2021 21:02:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3020.oracle.com with ESMTP id 360ke5heph-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jan 2021 21:02:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpYt3v5btuZP2CEtaTzhcK5fF6otZb6X82+A3nU573VbwFg9/YkgzmjsXAXbkrBLLOJEzO59ap2Qw3pCVSaPwuxAzTT4jVEnD8dO+GhsjSfp1NlDh6geKzwUCkdV9/OMXQMZAqqYg9fzxU32UD7RIcOUbes8CEKPurF2FGcv/gbNuoJAFvGeKdFssE+6yNlLNG/C3cdnb1oD2VDhBZ1GqMDCljs611f7E1HXWtsskuY5RoxjLuUadPS1uYfGX/CVN50p4x9tZAlDUk7IMe9S0rNxVK2pbTusafw8GNgRbG8wR0TORMphou3p4dJnKwkpb0cTAvQNCxg/tMUmi0y3zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmMCRA+QnuJMI16EDYG2Oyfmelmp1l1H3Ogz1i+kVL4=;
 b=CfsdlOiXv49sn+Jk+qYdPNKtzHyr6NBP8Zn7KMyAaYXFsvnM5lMXjDoY1oc3JB7vkluhTPeGOIhrWqtqVpMUXCA8S5RUeKr6piIm86rDjVxM87AWS5Gx6XT8V2Oc8QHRnXgFEiraSzrBKo0jQulgBOU5t7m9li2y4XAmBXsa7fX4ZjJvuT7Cj5EBcHvL+GYvnXgHu4bq/qDo71c4wHv1DcVrqcfJ50UGjes1hI20mlAr/hzzh9r2TNsmYJay/5Uk1hnJWmhVLSq05YETiV29M9OtRxnwyoXMAD+8y6dzMTqXsJGT4laVqcNM/94MRpw4PdWU/N/zFqPNpQ7V6yaIiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmMCRA+QnuJMI16EDYG2Oyfmelmp1l1H3Ogz1i+kVL4=;
 b=UGPZvHeVyvAyxHBvx6vERg38AeB8SMzS38yJLXYKK1tr9+/Aw334HS6l/7GdwUrQEZzcKMFTy6RHCFbF5BdXmCRZjbKP1cG86zDszrGO3Nfb5rwO9E7Ha2xLmrO9/VH5KCMJ9Qa3luD7NO7DgjHve5wmQe6pZEBc1KQjf+QLg4A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1711.namprd10.prod.outlook.com (2603:10b6:301:a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 21:02:10 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 21:02:10 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 1/3] hugetlb: use page.private for hugetlb specific page flags
Date:   Mon, 11 Jan 2021 13:01:50 -0800
Message-Id: <20210111210152.118394-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210111210152.118394-1-mike.kravetz@oracle.com>
References: <20210111210152.118394-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:300:115::14) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR11CA0028.namprd11.prod.outlook.com (2603:10b6:300:115::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 21:02:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90d78c9b-6910-4ae6-9b91-08d8b67429fb
X-MS-TrafficTypeDiagnostic: MWHPR10MB1711:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB17116F3EF86B64F7695015FBE2AB0@MWHPR10MB1711.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dTS9eZKGRGuBCnuVAkkJ+z/mg8MYHPfhCpWHMTyWe/FncQcHaml99AX6fhgtcIzpT1kKVGrs9WQOZVvG7tu1bWgMqiiq4CPfeQwbd/Fhd3FC8zsKRcy3Mm4i2QR2m7Y2mUvkJdUjhqAQFKs6idDqMxny7cZVhr01UwI9vZCXkk06uGgoj1HoSsGMiOvzHWISDlvZBPdVXtNWnwycslw4MmpgH/BxjwJgXdQcewO3CqObMEjwboLa0ayoh0f2Z/G0ladDKUbkcv2GugAt61XIbUQhkVuM53klVdeI5h/njvg2ZGtUlz6R5zVnp/iDEts+fKIqscJ96WpYi9y5N9b/+RQuBe33TUrqOJwxo5sUGGROnOkv6fx5o91p1dbOajdL0YNlwMWwp+6OByYE20Eg5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(376002)(39850400004)(396003)(186003)(16526019)(4326008)(1076003)(8676002)(6666004)(2616005)(54906003)(478600001)(107886003)(956004)(26005)(316002)(83380400001)(8936002)(5660300002)(2906002)(6486002)(86362001)(66556008)(52116002)(66946007)(7696005)(36756003)(66476007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bnMHglmVaHwL65pW9TucSvuAV9Mj17b8z+fY9U5LninxtSGbOsEfKEvaqn4y?=
 =?us-ascii?Q?W/DiF9+eendCK4tnLVxeolBlqaHku2sMj2V0y2HXCxsNEVO3jBuO5MZ5FI9A?=
 =?us-ascii?Q?DfSHSCH2TZAUSa3zgWK7N1e1zLCTgQj37G+GUgrODMIVqX9gk5KMm+hGBa1c?=
 =?us-ascii?Q?ch4Jotsg9nHwcykkGYlNOAHS3NL9oSNKzriJbMDV4J7XJG3Pj+LFpVyDQV0c?=
 =?us-ascii?Q?pufnIxYwHx77oYtkQyVEFkk6le+FG7pM3b0TH4YbSDBNG578cf0cE1L/Ochg?=
 =?us-ascii?Q?FyaklLgkTbnP3RuKjdv6k4p/O/z0ypgUUrz/aFh1HYt5/ARcaahkU7IL89lq?=
 =?us-ascii?Q?WdXoU55SO1ro88NL2ocbmpdx5Sg6EtPmgIOBkPxUWMlieg4S2ilc1ol2Q/mi?=
 =?us-ascii?Q?vapmqQJxcgGdbbSz7RbCLP3IaB75QMb5s7RxW8IL5oDmu40vq3GhpdiDOJen?=
 =?us-ascii?Q?rEFgTpoqNIoXSnYK+lmMSfYdwsT0qSFz+F/ou9+N/FlTux77BYUcap/aItRz?=
 =?us-ascii?Q?P8oUPFbgQTJNArFqpKx7QxNrVDIgIZ3STzZLY6R7WnpGP1Vy1ey+tL7OTniH?=
 =?us-ascii?Q?qmQs45drcG+JUIKh4LEfLbX5w4XaWYsXIQ42kiOxgS4NESkCfNA1ki9AYQ5J?=
 =?us-ascii?Q?ZokGCNj+jTxEloZbnnMoY1bhto6r5geaRkoKteaycqZp04WqhZnatGyMReGs?=
 =?us-ascii?Q?JeHoBE2ZPEyf+c4JEUyfuMIly0Us9fGFyqrrM5MAzRCjjnV/xLpqLwYK63X5?=
 =?us-ascii?Q?9Z9pQsfFXOgtoJofXWFt8YEMqqILRMiPjZH2o8m/NUbD4NmXfFVA7LSRkROG?=
 =?us-ascii?Q?VNr49El4J6OYlJX6QKN63K8aE65varkBD4tZarRsxwUTXH5Np6kqpGwUDomQ?=
 =?us-ascii?Q?voAdU4aJyF3ywrC+r9QL+byjyl/j6dpIb+xnbSWQVQpP60v8La4HcTk+YYQ2?=
 =?us-ascii?Q?hQWn3mCFgKwPa1LXvztcTUl0HaBro+FAQEcfuhCgDMM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 21:02:10.8142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d78c9b-6910-4ae6-9b91-08d8b67429fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQ6sDC/J8onrJdfE35zc8m3TfMJ4LAPg9Ht5YrTkzJgkKRfYM06gj5fk7ttYN1ohtzfEI9u0Od6vs57EZQFsXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1711
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=917 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101110118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=969 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101110118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As hugetlbfs evolved, state information about hugetlb pages was added.
One 'convenient' way of doing this was to use available fields in tail
pages.  Over time, it has become difficult to know the meaning or contents
of fields simply be looking at a small bit of code.  Sometimes, the
naming is just confusing.  For example: The PagePrivate flag indicates
a huge page reservation was consumed and needs to be restored if an error
is encountered and the page is freed before it is instantiated.  The
page.private field contains the pointer to a subpool if the page is
associated with one.

In an effort to make the code more readable, use page.private to contain
hugetlb specific flags.  These flags will have test, set and clear functions
similar to those used for 'normal' page flags.  More importantly, the
flags will have names which actually reflect their purpose.

In this patch,
- Create infrastructure for huge page flag functions
- Move subpool pointer to page[1].private to make way for flags
  Create routines with meaningful names to modify subpool field
- Use new HPageRestoreReserve reserve flag instead of PagePrivate

Conversion of other state information will happen in subsequent patches.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c    | 11 +++---
 include/linux/hugetlb.h |  2 ++
 mm/hugetlb.c            | 80 +++++++++++++++++++++++++++++++----------
 3 files changed, 67 insertions(+), 26 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index b5c109703daa..8bfb80bc6e96 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -966,14 +966,11 @@ static int hugetlbfs_migrate_page(struct address_space *mapping,
 		return rc;
 
 	/*
-	 * page_private is subpool pointer in hugetlb pages.  Transfer to
-	 * new page.  PagePrivate is not associated with page_private for
-	 * hugetlb pages and can not be set here as only page_huge_active
-	 * pages can be migrated.
+	 * Transfer any subpool pointer to the new page.
 	 */
-	if (page_private(page)) {
-		set_page_private(newpage, page_private(page));
-		set_page_private(page, 0);
+	if (hpage_spool(page)) {
+		set_hpage_spool(newpage, hpage_spool(page));
+		set_hpage_spool(page, 0);
 	}
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ebca2ef02212..4f0159f1b9cc 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -104,6 +104,8 @@ extern int hugetlb_max_hstate __read_mostly;
 struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
 						long min_hpages);
 void hugepage_put_subpool(struct hugepage_subpool *spool);
+struct hugepage_subpool *hpage_spool(struct page *hpage);
+void set_hpage_spool(struct page *hpage, struct hugepage_subpool *spool);
 
 void reset_vma_resv_huge_pages(struct vm_area_struct *vma);
 int hugetlb_sysctl_handler(struct ctl_table *, int, void *, size_t *, loff_t *);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3b38ea958e95..3eb3b102c589 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -52,6 +52,49 @@ static struct cma *hugetlb_cma[MAX_NUMNODES];
 #endif
 static unsigned long hugetlb_cma_size __initdata;
 
+/*
+ * hugetlb specific state flags located in hpage.private
+ */
+enum htlb_page_flags {
+	HPAGE_RestoreReserve = 0,
+};
+
+/*
+ * Macros to create function definitions for hpage flags
+ */
+#define TESTHPAGEFLAG(flname)					\
+static inline int HPage##flname(struct page *page)		\
+	{ return test_bit(HPAGE_##flname, &(page->private)); }
+
+#define SETHPAGEFLAG(flname)					\
+static inline void SetHPage##flname(struct page *page)		\
+	{ set_bit(HPAGE_##flname, &(page->private)); }
+
+#define CLEARHPAGEFLAG(flname)					\
+static inline void ClearHPage##flname(struct page *page)	\
+	{ clear_bit(HPAGE_##flname, &(page->private)); }
+
+#define HPAGEFLAG(flname)					\
+	TESTHPAGEFLAG(flname)					\
+	SETHPAGEFLAG(flname)					\
+	CLEARHPAGEFLAG(flname)
+
+HPAGEFLAG(RestoreReserve)
+
+/*
+ * hugetlb page subpool pointer located in hpage[1].private
+ */
+struct hugepage_subpool *hpage_spool(struct page *hpage)
+{
+	return (struct hugepage_subpool *)(hpage+1)->private;
+}
+
+void set_hpage_spool(struct page *hpage,
+		struct hugepage_subpool *spool)
+{
+	set_page_private(hpage+1, (unsigned long)spool);
+}
+
 /*
  * Minimum page order among possible hugepage sizes, set to a proper value
  * at boot time.
@@ -1116,7 +1159,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
 	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
 	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
-		SetPagePrivate(page);
+		SetHPageRestoreReserve(page);
 		h->resv_huge_pages--;
 	}
 
@@ -1391,20 +1434,19 @@ static void __free_huge_page(struct page *page)
 	 */
 	struct hstate *h = page_hstate(page);
 	int nid = page_to_nid(page);
-	struct hugepage_subpool *spool =
-		(struct hugepage_subpool *)page_private(page);
+	struct hugepage_subpool *spool = hpage_spool(page);
 	bool restore_reserve;
 
 	VM_BUG_ON_PAGE(page_count(page), page);
 	VM_BUG_ON_PAGE(page_mapcount(page), page);
 
-	set_page_private(page, 0);
+	set_hpage_spool(page, 0);
 	page->mapping = NULL;
-	restore_reserve = PagePrivate(page);
-	ClearPagePrivate(page);
+	restore_reserve = HPageRestoreReserve(page);
+	ClearHPageRestoreReserve(page);
 
 	/*
-	 * If PagePrivate() was set on page, page allocation consumed a
+	 * If RestoreReserve was set on page, page allocation consumed a
 	 * reservation.  If the page was associated with a subpool, there
 	 * would have been a page reserved in the subpool before allocation
 	 * via hugepage_subpool_get_pages().  Since we are 'restoring' the
@@ -2213,9 +2255,9 @@ static long vma_add_reservation(struct hstate *h,
  * This routine is called to restore a reservation on error paths.  In the
  * specific error paths, a huge page was allocated (via alloc_huge_page)
  * and is about to be freed.  If a reservation for the page existed,
- * alloc_huge_page would have consumed the reservation and set PagePrivate
+ * alloc_huge_page would have consumed the reservation and set RestoreReserve
  * in the newly allocated page.  When the page is freed via free_huge_page,
- * the global reservation count will be incremented if PagePrivate is set.
+ * the global reservation count will be incremented if RestoreReserve is set.
  * However, free_huge_page can not adjust the reserve map.  Adjust the
  * reserve map here to be consistent with global reserve count adjustments
  * to be made by free_huge_page.
@@ -2224,13 +2266,13 @@ static void restore_reserve_on_error(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address,
 			struct page *page)
 {
-	if (unlikely(PagePrivate(page))) {
+	if (unlikely(HPageRestoreReserve(page))) {
 		long rc = vma_needs_reservation(h, vma, address);
 
 		if (unlikely(rc < 0)) {
 			/*
 			 * Rare out of memory condition in reserve map
-			 * manipulation.  Clear PagePrivate so that
+			 * manipulation.  Clear RestoreReserve so that
 			 * global reserve count will not be incremented
 			 * by free_huge_page.  This will make it appear
 			 * as though the reservation for this page was
@@ -2239,7 +2281,7 @@ static void restore_reserve_on_error(struct hstate *h,
 			 * is better than inconsistent global huge page
 			 * accounting of reserve counts.
 			 */
-			ClearPagePrivate(page);
+			ClearHPageRestoreReserve(page);
 		} else if (rc) {
 			rc = vma_add_reservation(h, vma, address);
 			if (unlikely(rc < 0))
@@ -2247,7 +2289,7 @@ static void restore_reserve_on_error(struct hstate *h,
 				 * See above comment about rare out of
 				 * memory condition.
 				 */
-				ClearPagePrivate(page);
+				ClearHPageRestoreReserve(page);
 		} else
 			vma_end_reservation(h, vma, address);
 	}
@@ -2328,7 +2370,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 		if (!page)
 			goto out_uncharge_cgroup;
 		if (!avoid_reserve && vma_has_reserves(vma, gbl_chg)) {
-			SetPagePrivate(page);
+			SetHPageRestoreReserve(page);
 			h->resv_huge_pages--;
 		}
 		spin_lock(&hugetlb_lock);
@@ -2346,7 +2388,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 
 	spin_unlock(&hugetlb_lock);
 
-	set_page_private(page, (unsigned long)spool);
+	set_hpage_spool(page, spool);
 
 	map_commit = vma_commit_reservation(h, vma, addr);
 	if (unlikely(map_chg > map_commit)) {
@@ -4150,7 +4192,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 	spin_lock(ptl);
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
-		ClearPagePrivate(new_page);
+		ClearHPageRestoreReserve(new_page);
 
 		/* Break COW */
 		huge_ptep_clear_flush(vma, haddr, ptep);
@@ -4217,7 +4259,7 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 
 	if (err)
 		return err;
-	ClearPagePrivate(page);
+	ClearHPageRestoreReserve(page);
 
 	/*
 	 * set page dirty so that it will not be removed from cache/file
@@ -4379,7 +4421,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		goto backout;
 
 	if (anon_rmap) {
-		ClearPagePrivate(page);
+		ClearHPageRestoreReserve(page);
 		hugepage_add_new_anon_rmap(page, vma, haddr);
 	} else
 		page_dup_rmap(page, true);
@@ -4693,7 +4735,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	if (vm_shared) {
 		page_dup_rmap(page, true);
 	} else {
-		ClearPagePrivate(page);
+		ClearHPageRestoreReserve(page);
 		hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
 	}
 
-- 
2.29.2


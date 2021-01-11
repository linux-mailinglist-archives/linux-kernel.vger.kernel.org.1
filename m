Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFBE2F2165
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733258AbhAKVDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:03:10 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43544 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731724AbhAKVDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:03:08 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10BKxwSW083388;
        Mon, 11 Jan 2021 21:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=UgN5twgSWvQcZKB3lK+jcCBLgDNbvPqPqtLFyqE8a/c=;
 b=HM2/Zn+aLUHR6IDEBOjaMA1fXASNjBbRa6kXs2QmwWTLlDH6PKhkv1Jv3t9+fT4W4zWL
 DVT+p6eVkXsI6ECp/f94X91oBAkos6Yz/uvplGQAwDEMqpZpUyz7v5dkAbfcdqolhNkR
 f3oxCsB2IyyitlrCB7NEgdQDEeZ4DZLsCUif+WMHl4k093qLANHf4BEkFqw1XdwxXixx
 OhjbbfNDL4XFujUjT8jjCmAdHudJVVg7CFbkvECSSbHIvxOMWVTms3OZuY5IdavpZVil
 0T08aLGMq4h/OPWL1K6e3HMwh/yfLo4HIr2uH4qvFvbd06FYdrG7eXyrIiXw25PyNCIM pA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 360kcykc0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jan 2021 21:02:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10BKxtc2145947;
        Mon, 11 Jan 2021 21:02:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by aserp3030.oracle.com with ESMTP id 360kewtt5w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jan 2021 21:02:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNJBR6d2wnaWqicCKNF2daVLEa8jkIQ/kxT/SeJ7ZFjSHumLFBQTg8msW8thXoE4rUk79FoY9wtZ6ak73LgPQW2QYfwEuZpZ1Sfw7uh/8UJ9Y0eDBTTnmjWjfVZPtcjE4Q4babDlt87HKglivj8BU4jcUYNfzoE/jTPYtxZNOnuNurlGA94OtC4j2s6WGUQVNpKBkCUnAMxp3RNItm8UoO0qc6SZo/wQIV+aImVug/xj97YYxskuv1HVhVriev34J8MxTI5UfKBoULcZVNZ7inxhVmB9tN/h3N7JhEndN/gdlV9xjMpooybcHUBo5crHohPUuzPhidI/0Rn8EeuIkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgN5twgSWvQcZKB3lK+jcCBLgDNbvPqPqtLFyqE8a/c=;
 b=TDOszykLy8a6QpbkVzj8mclVJ61XhsiEHXoiLXI+1B/nmlO0t8jwvCs6wFfBqxGxNNkVCHzl14tndCvnHwk2UVOvCl1F2S3pNrMY6LHiZEOwAyG96NMmcpnz/XcDFktRm77KhY0pq5RtGY5fX2BL/Y/pJfMH0+RgnprZXCwijhe/PCZfMy3BUjICE0HZrxMQVSejvUmrwQJRTsV6kO9tUBbvfTFDB+8Q4suYbO2xUzGe9u+1QOIUvFGmWpDMUEvFnceh36spTzSFbOou7E3P3rx+YeNj82TTZIo64eQbP2+E+mkTtdRA2U1tQGyzAJ4nS4/70ODhZcMzHg0Ne2O4Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgN5twgSWvQcZKB3lK+jcCBLgDNbvPqPqtLFyqE8a/c=;
 b=PulN2JOlFsqZEoDWVgQiZW2jnWODTq8KoocpFN/f8gUwe/eDiRnDE0sXZhalR+l3ngK3CO6FcrtK61hMmhuv2tP5+SeFPITEeRrkF9d4M9MZIrpw5JWcNZQ+7FqM4GSw3Ffa9knEeG/cva01kLd2AvE/iLBVSjL3njPkP1Nbpls=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1711.namprd10.prod.outlook.com (2603:10b6:301:a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 21:02:13 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 21:02:13 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 2/3] hugetlb: convert page_huge_active() to HPageMigratable flag
Date:   Mon, 11 Jan 2021 13:01:51 -0800
Message-Id: <20210111210152.118394-3-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR11CA0028.namprd11.prod.outlook.com (2603:10b6:300:115::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 21:02:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb034516-c2ca-4438-bf2b-08d8b6742b3b
X-MS-TrafficTypeDiagnostic: MWHPR10MB1711:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1711AF3023825C2575B0B697E2AB0@MWHPR10MB1711.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ORX1GhDXgr2rdQDVpBO/gqRE5soS1+nbztDaqwRVpm2SZMU1svAcAtRQIt2VhYBxk6oKXvQDSSti2unF8Q+etES162LcFQrPiRjAQC1tNA8uzzERVCcM1n8wISbagM7r4OgH3i5rvdd8v1Tt8/T3jpiOQD5KCJCOaS35ahA+xxxKSHLm4RNLwyQyiAJPn7cxU6o02NONxM/+Tv95ipT+T0HKMUCU2e/oYmuKh7vnLos91tFK7ItYDTyvJlRTRGmz1h45NTYu3AByhjwYZt74GnOb0ihZu9NmYgBQK09zypjAC0kvb9QEh1ENCzaf5GbWClkutq+dFhbTJPfgo7U/R4J8JYFt8T+wxrJxaWSu/NoTljx3jK0DJW5Ox1p6lMxnwbHPihP16QHw23PnoKRw/G+NJ9IxJ7APywaPXVV2uluUIFjKeEMmK7YNa1ihf70B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(376002)(39850400004)(396003)(186003)(16526019)(4326008)(1076003)(8676002)(6666004)(2616005)(54906003)(478600001)(107886003)(956004)(26005)(316002)(83380400001)(8936002)(5660300002)(2906002)(6486002)(86362001)(66556008)(52116002)(66946007)(7696005)(36756003)(66476007)(44832011)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qqZKd+CdIrp1o3TkA6DRBvZbymhZ1ar1irtdqJkEVJG7KO/ob7uK/rksoblY?=
 =?us-ascii?Q?X1rBEVrmPzThHVqzpdHv1KHVrXybMV7otFtl0ykr9p+WPEXu56Vkpeg9wH9/?=
 =?us-ascii?Q?Iuw3s1lBFdg9PueP6DgrmK01gZWe+ixeAZul/KcJGSA1A2DBlbMUhtLpwUtO?=
 =?us-ascii?Q?PcGeNjvDK64k0BU17asQqHoT8P40SVWFJTlgECCKujyRYt49zrwNv+GZNE2Z?=
 =?us-ascii?Q?wYu45gYuEn2xynQeAyPmtlxvAq6eBarEfzKz1lG8FDF8cSRUu8inYGn3hYod?=
 =?us-ascii?Q?netaPdSTGUHlOqdkXDK5rpXyS1bbD8O2UGCf6BsIBO5MYMBnW5dTFY7bFuIl?=
 =?us-ascii?Q?gAMwH/N1TkXGEiPXYaUSpF6jEstT2J4A8hFwIt7neukdjesPSejv2uaPB9SL?=
 =?us-ascii?Q?H3bFk6lkY3G69pVMugvwzEIQLXLQ+Vb+zjQO31MbG8gWxJF/W00Rb2zcaCeo?=
 =?us-ascii?Q?pBJCM/BszcZMwm+Lj3OjMPWffeVECQ97drLpmwLT7k1Dqhn6u13ca2KlHymG?=
 =?us-ascii?Q?98xVgfeIrIA33UeYqJ0Q7TlB+wpbofwGWvCgh5XwQno81EyLTweh9oeoD6um?=
 =?us-ascii?Q?s4n9uQFmCfCeQyT8pySyCLM7qWEscoRLKRkXA80r4quvRwIE6ztKhj9cXPoR?=
 =?us-ascii?Q?12ACywTfUwP3jh4y+vIBVjwIuYg5SY/LbuHgmHdqMbMYBJwxdn6Y3biySu2r?=
 =?us-ascii?Q?wSWAzmOO4rdnRgdMattJXivUzaFjJE0gPXqWeakkhj6C+DXZjMhan/LPKrO7?=
 =?us-ascii?Q?2wcWfo4dV6icMXaSQfCfNqYQGaeiffjNxom9owyNV9Z87r7mPe75TubauejG?=
 =?us-ascii?Q?48Cd6B7UqZxdkq80WhAgp8s/IOtROAZbHDT1dVXujtkz3u4WnpuLnqJjRlPI?=
 =?us-ascii?Q?u+mKWP+Rz4NAszm/ZNruEedv5wjxsRGS4VaZ/esarjy6IuwqaHDmJf9nRYIt?=
 =?us-ascii?Q?5cSjaB7jZLXAVEh7whCe1LhJGc941pemtAtV1fy5clA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 21:02:12.9683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-Network-Message-Id: fb034516-c2ca-4438-bf2b-08d8b6742b3b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmksL7k5feqHPHvgsvylpDv6t4s7nsmN/dl1Vfyml0kq405LEVZpUjnaq9EBO2mV9DrjGif3id+I1LomQ9KM3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1711
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101110118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101110118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new hugetlb page specific flag to replace the page_huge_active
interfaces.  By it's name, page_huge_active implied that a huge page
was on the active list.  However, that is not really what code checking
the flag wanted to know.  It really wanted to determine if the huge
page could be migrated.  This happens when the page is actually added
the page cache and/or task page table.  This is the reasoning behind the
name change.

The VM_BUG_ON_PAGE() calls in the interfaces were not really necessary
as in all case but one we KNOW the page is a hugetlb page.  Therefore,
they are removed.  In one call to HPageMigratable() is it possible for
the page to not be a hugetlb page due to a race.  However, the code
making the call (scan_movable_pages) is inherently racy, and page state
will be validated later in the migration process.

Note:  Since HPageMigratable is used outside hugetlb.c, it can not be
static.  Therefore, a new set of hugetlb page flag macros is added for
non-static flag functions.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h    | 17 +++++++++++
 include/linux/page-flags.h |  6 ----
 mm/hugetlb.c               | 60 +++++++++++++++++---------------------
 mm/memory_hotplug.c        |  2 +-
 4 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 4f0159f1b9cc..46e590552d55 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -190,6 +190,9 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 
 bool is_hugetlb_entry_migration(pte_t pte);
 
+int HPageMigratable(struct page *page);
+void SetHPageMigratable(struct page *page);
+void ClearHPageMigratable(struct page *page);
 #else /* !CONFIG_HUGETLB_PAGE */
 
 static inline void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
@@ -370,6 +373,20 @@ static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
 	return 0;
 }
 
+static inline int HPageMigratable(struct page *page)
+{
+	return(0);
+}
+
+static inline void SetHPageMigratable(struct page *page)
+{
+	return;
+}
+
+static inline void ClearHPageMigratable(struct page *page)
+{
+	return;
+}
 #endif /* !CONFIG_HUGETLB_PAGE */
 /*
  * hugepages at page global directory. If arch support
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4f6ba9379112..167250466c9c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -593,15 +593,9 @@ static inline void ClearPageCompound(struct page *page)
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
index 3eb3b102c589..34ce82f4823c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -57,6 +57,7 @@ static unsigned long hugetlb_cma_size __initdata;
  */
 enum htlb_page_flags {
 	HPAGE_RestoreReserve = 0,
+	HPAGE_Migratable,
 };
 
 /*
@@ -79,7 +80,25 @@ static inline void ClearHPage##flname(struct page *page)	\
 	SETHPAGEFLAG(flname)					\
 	CLEARHPAGEFLAG(flname)
 
+#define EXT_TESTHPAGEFLAG(flname)					\
+int HPage##flname(struct page *page)		\
+	{ return test_bit(HPAGE_##flname, &(page->private)); }
+
+#define EXT_SETHPAGEFLAG(flname)					\
+void SetHPage##flname(struct page *page)		\
+	{ set_bit(HPAGE_##flname, &(page->private)); }
+
+#define EXT_CLEARHPAGEFLAG(flname)					\
+void ClearHPage##flname(struct page *page)	\
+	{ clear_bit(HPAGE_##flname, &(page->private)); }
+
+#define EXT_HPAGEFLAG(flname)					\
+	EXT_TESTHPAGEFLAG(flname)					\
+	EXT_SETHPAGEFLAG(flname)					\
+	EXT_CLEARHPAGEFLAG(flname)
+
 HPAGEFLAG(RestoreReserve)
+EXT_HPAGEFLAG(Migratable)
 
 /*
  * hugetlb page subpool pointer located in hpage[1].private
@@ -1379,31 +1398,6 @@ struct hstate *size_to_hstate(unsigned long size)
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
-	VM_BUG_ON_PAGE(!PageHuge(page), page);
-	return PageHead(page) && PagePrivate(&page[1]);
-}
-
-/* never called for tail page */
-static void set_page_huge_active(struct page *page)
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
@@ -1465,7 +1459,7 @@ static void __free_huge_page(struct page *page)
 	}
 
 	spin_lock(&hugetlb_lock);
-	clear_page_huge_active(page);
+	ClearHPageMigratable(page);
 	hugetlb_cgroup_uncharge_page(hstate_index(h),
 				     pages_per_huge_page(h), page);
 	hugetlb_cgroup_uncharge_page_rsvd(hstate_index(h),
@@ -4201,7 +4195,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 				make_huge_pte(vma, new_page, 1));
 		page_remove_rmap(old_page, true);
 		hugepage_add_new_anon_rmap(new_page, vma, haddr);
-		set_page_huge_active(new_page);
+		SetHPageMigratable(new_page);
 		/* Make the old page be freed below */
 		new_page = old_page;
 	}
@@ -4439,11 +4433,11 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 
 	/*
 	 * Only make newly allocated pages active.  Existing pages found
-	 * in the pagecache could be !page_huge_active() if they have been
+	 * in the pagecache could be !HPageMigratable if they have been
 	 * isolated for migration.
 	 */
 	if (new_page)
-		set_page_huge_active(page);
+		SetHPageMigratable(page);
 
 	unlock_page(page);
 out:
@@ -4754,7 +4748,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 
 	spin_unlock(ptl);
-	set_page_huge_active(page);
+	SetHPageMigratable(page);
 	if (vm_shared)
 		unlock_page(page);
 	ret = 0;
@@ -5580,11 +5574,11 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
 
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 	spin_lock(&hugetlb_lock);
-	if (!page_huge_active(page) || !get_page_unless_zero(page)) {
+	if (!HPageMigratable(page) || !get_page_unless_zero(page)) {
 		ret = false;
 		goto unlock;
 	}
-	clear_page_huge_active(page);
+	ClearHPageMigratable(page);
 	list_move_tail(&page->lru, list);
 unlock:
 	spin_unlock(&hugetlb_lock);
@@ -5595,7 +5589,7 @@ void putback_active_hugepage(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 	spin_lock(&hugetlb_lock);
-	set_page_huge_active(page);
+	SetHPageMigratable(page);
 	list_move_tail(&page->lru, &(page_hstate(page))->hugepage_activelist);
 	spin_unlock(&hugetlb_lock);
 	put_page(page);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0f855deea4b2..fefd43757017 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1261,7 +1261,7 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 		if (!PageHuge(page))
 			continue;
 		head = compound_head(page);
-		if (page_huge_active(head))
+		if (HPageMigratable(head))
 			goto found;
 		skip = compound_nr(head) - (page - head);
 		pfn += skip - 1;
-- 
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1382F89F9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 01:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbhAPAeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 19:34:37 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37358 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbhAPAeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 19:34:36 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10G0XVeJ029233;
        Sat, 16 Jan 2021 00:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=wV6ngGm8Bte5h7bTxXDmG6bO4Bbj07mbez4jVE4asdI=;
 b=Yc5Sbn2WxMO+MlQHUNLXz84Vq5yFlMZpcoN0HKyDVI/S6CDLzc1Yr5oJhJ9H3toqPaTh
 Ic8TRUne5yxcWfnB19aSUrUbqFlHjt1yAk2wZTXm4ECW5+qQKVq+pdt7357QbsHRB1tS
 UsezcxD6lCqNd+C/vQvidfI2auCcbANOEHNXe/E93/PAvdnf9OILnbgXgDV2cSMozGDC
 J9qBucrxCwxZ3PkAuyB7WcEvMwoxirHXyYtIdZB5MqJ+s5Bl7vr9HlN1TKC6dCQehLnU
 PlXg0r5KxVOrouuZN2vOPm5Dt/eU5taVjkkqUdEUilZfXmO8ZpSvvFpGE/tl9iAKbT// yQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 360kd077pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jan 2021 00:33:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10G0V38M035166;
        Sat, 16 Jan 2021 00:31:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by userp3030.oracle.com with ESMTP id 363n8qs8r3-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jan 2021 00:31:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3kE54KquXzqytOTOPzJSL1JgUFHti5Pr6GxENdGIuQ3hm/QvmkNwWGnC0HgzDLSzQlFR7kWFRIvcnyaqJY4o/vVOew3Z+FhFwRFTlVu0Q3lZBmxMfV5raXSEbLLsvkJsK1iBbYPzmGdLnLp6kiPFKmq2zE3oTCEa3WnUmkGkR9vGT4lZ+6wX7Qezp8GLla4vr77j30aaNvGN2QDvIr38+S42Q1sFgsMJVWePk/iI90Xe7thbR5sZYHBNTzD1DBBzCK5F1F6JupaEKgj/dVN/kYeKKLvdkJkD80+xAyQ/ZI+EVv8Ln81cfDIDEp5SydknjDhOBmFYIVhKIlSZEvoJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wV6ngGm8Bte5h7bTxXDmG6bO4Bbj07mbez4jVE4asdI=;
 b=CNTEpkGlcj58zOLNVrq0G45PGuB8WnjUiA9ja0Msk7YXvU3q924btkrbADyIyL9NgZY4NBN80dCJgmGqLsXAzfx7rGpBnWwPMtp/tBU7XcTFVgh50A1/2CZ98MAh6bTPYQXiJlcJjYijS8C/jojU01+AtccgFt/UQ5DTxkP+DNUH57u/r3y36TQYMPkC9Bu5zwyekGWFFbDHaE8qNkz4fHFHQIXY3IbQzgmZHAJ/mxQ5bOETUsodqMEvVsWCxSttHUWt3T2oqUfSfXxHlmplzrPXChkNQ1m+Ko52MNqKQ+IMiYrr43P5AqsKmD4l56JfTk6/9Wk2bi1FRsmZW49YVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wV6ngGm8Bte5h7bTxXDmG6bO4Bbj07mbez4jVE4asdI=;
 b=HHBsktYZ6AYcmAdUeK84GM2l+43iJv93CgWsQOPvAe4y7f8aQdP/DH30k8PFNfM2G1lS6rhjmuJxE0RSo7Xl9bckLDJ1y/gR9zjJzBeL6GWK58GCuW7q0QecxUqbC8Urw2x7T41hF+G0xtjSlV4Rp9XKngPpDDoMXjgerSzJ83g=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4450.namprd10.prod.outlook.com (2603:10b6:303:93::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Sat, 16 Jan
 2021 00:31:26 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3763.012; Sat, 16 Jan 2021
 00:31:26 +0000
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
Subject: [PATCH 1/5] hugetlb: use page.private for hugetlb specific page flags
Date:   Fri, 15 Jan 2021 16:31:01 -0800
Message-Id: <20210116003105.182918-2-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by CO1PR15CA0060.namprd15.prod.outlook.com (2603:10b6:101:1f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11 via Frontend Transport; Sat, 16 Jan 2021 00:31:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b56a337f-3391-40c9-c66b-08d8b9b60f20
X-MS-TrafficTypeDiagnostic: CO1PR10MB4450:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4450E85F307E034D746FC77CE2A60@CO1PR10MB4450.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kU0zFwKu3mseaJMKG72USYR6YoUDnOH4k5ilz6FjJmxTrcpoMiKz/Y2EmumxU1o5qV3PCaavVL0aQQ+qFJJJZf24XbPLREwGoQUM3SadoIUE14TXokfbXVhijzeeEkjRMfZa7QasPRZsnfIONmdPePthbCdAz1jloz7SaZU2Zzz4gsMvJGm+jyiqgmQJgwxxt7fO8QBS9FWu41RRghbzyrlotneYvfZRNbNU/la6113l+UGzhv0c8RC9DO9XSl/48PUFSvfeDeZbV6OYmTweToBmFDF9qRDU4JS2gJTv+JjyZfPphukC3I8z4jq4cXYqNJAEmtaN1fORlY8CKCfLAazmB8mbDkqQgL571avy5Zpft/IsKyy3AHYUNqGAxYsds/FOk1S9NxVMkRZw3QTPAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39850400004)(136003)(346002)(366004)(6486002)(478600001)(1076003)(30864003)(6666004)(86362001)(36756003)(2906002)(44832011)(316002)(5660300002)(956004)(8676002)(107886003)(16526019)(26005)(52116002)(4326008)(54906003)(8936002)(66946007)(66556008)(66476007)(2616005)(186003)(7696005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fIZp6t+ZPtqPuc07403jENoiOlt5jcHZI23utCeQ8FAN8bZ54gzAUaiDzcCz?=
 =?us-ascii?Q?F6OEY1K7QASGFkt0W0h36Cgrr8O+YIIhbaFhvAzfXIl2ixW7+aJpLoUxHL4I?=
 =?us-ascii?Q?F/CqhgjhbVGPFQnpUir5QNJAid9njkDd2AI/OJQiKeKCTOd72iGlWzVl64jN?=
 =?us-ascii?Q?EAUpcNO2THQ2XqXaGfdrIt7PfgAOHSVXcP0ZofnWyZN/F5jZO7I3UYoNDtG+?=
 =?us-ascii?Q?5T8xREPDqnGyaATkqUaMHeUqyGxxPFG+r6c4uoT5QtznwX8lWPMBJZ2Tykuc?=
 =?us-ascii?Q?/IBPmoOys7/DpLv5xZjPRLGWCIJx4749ib09OneLqYMdJwMotnuq6gWYAPQF?=
 =?us-ascii?Q?moE0N9Pkn4fdbR55FscmfuUXG0pgT7cd8sWGLKjBvbkSY90KLsSeoSkxX3t2?=
 =?us-ascii?Q?koP3xYotBiyEZLtoVTYyYsjcb1h5QJPLRA56T2T6f7zPADq0dbv7v0bXNrxF?=
 =?us-ascii?Q?2p02DRktt3mxsFRtYeoPs7uY9aIpMWo9rayW7oKONjtZ39+Nmq42GkR8brP3?=
 =?us-ascii?Q?uiU2Gnow1TB+EIhQFDeKr/rdcQfaA9IGX5D9q5M8NgJxJGjevCbNmce0EJ19?=
 =?us-ascii?Q?oVwcOfNJqtiEgdXYaIAVTh5SI2NnCQbkvDEylvUhIfvt4hKaNZ6r6X7uxmrh?=
 =?us-ascii?Q?Vplec5ov/Q+Hhq4RkoEcGzb6Tj3ZZVI5/5Po/foEgjeLqIubhk0TvE4w/l7V?=
 =?us-ascii?Q?4YlXTMJd+39xqA+AfozfsBrqsigsOF4heQuWqOtoDsGZ2+EdyZiUquen5HhB?=
 =?us-ascii?Q?XwsMdoC66Sm65SUrX7IeQi2Fg3BVD4Sq35ZO05GKpJKkQ45e/P11mP4HSiMC?=
 =?us-ascii?Q?8HX8DcMyxudh82zT4QGxYBzMtmwLiEBbqqww6GVpmmXdQ3DPIYgbOYPNDK4v?=
 =?us-ascii?Q?BuNeOZdkKUsW9UWMcuOIQIF3ljZMAAYxObrKFU0yxmgsTQTPRn5Wmhzzbf4q?=
 =?us-ascii?Q?cAoF0gzdwseo6lJDt2d911TXarsagNxNLIJ7eJhh+ao=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b56a337f-3391-40c9-c66b-08d8b9b60f20
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2021 00:31:26.7425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDdZg9O50JFBUSmZznXvvbPdqLkawtPMwt/M8/fBpuybKm+9FJUHuaXdhbA3TftRxqnNMsFvBP8b/1HFMHoqvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4450
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9865 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101160002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9865 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101160002
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As hugetlbfs evolved, state information about hugetlb pages was added.
One 'convenient' way of doing this was to use available fields in tail
pages.  Over time, it has become difficult to know the meaning or contents
of fields simply by looking at a small bit of code.  Sometimes, the
naming is just confusing.  For example: The PagePrivate flag indicates
a huge page reservation was consumed and needs to be restored if an error
is encountered and the page is freed before it is instantiated.  The
page.private field contains the pointer to a subpool if the page is
associated with one.

In an effort to make the code more readable, use page.private to contain
hugetlb specific flags.  A set of hugetlb_*_page_flag() routines are
created for flag manipulation.  More importantly, an enum of flag values
will be created with names that actually reflect their purpose.

In this patch,
- Create infrastructure for hugetlb_*_page_flag functions
- Move subpool pointer to page[1].private to make way for flags
  Create routines with meaningful names to modify subpool field
- Use new HP_Restore_Reserve flag instead of PagePrivate

Conversion of other state information will happen in subsequent patches.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c    | 12 ++------
 include/linux/hugetlb.h | 61 +++++++++++++++++++++++++++++++++++++++++
 mm/hugetlb.c            | 46 +++++++++++++++----------------
 3 files changed, 87 insertions(+), 32 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 740693d7f255..b8a661780c4a 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -955,15 +955,9 @@ static int hugetlbfs_migrate_page(struct address_space *mapping,
 	if (rc != MIGRATEPAGE_SUCCESS)
 		return rc;
 
-	/*
-	 * page_private is subpool pointer in hugetlb pages.  Transfer to
-	 * new page.  PagePrivate is not associated with page_private for
-	 * hugetlb pages and can not be set here as only page_huge_active
-	 * pages can be migrated.
-	 */
-	if (page_private(page)) {
-		set_page_private(newpage, page_private(page));
-		set_page_private(page, 0);
+	if (hugetlb_page_subpool(page)) {
+		hugetlb_set_page_subpool(newpage, hugetlb_page_subpool(page));
+		hugetlb_set_page_subpool(page, NULL);
 	}
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ef5b144b8aac..64f8c7a64186 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -472,6 +472,19 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 					unsigned long flags);
 #endif /* HAVE_ARCH_HUGETLB_UNMAPPED_AREA */
 
+/*
+ * huegtlb page specific state flags.  These flags are located in page.private
+ * of the hugetlb head page.  The hugetlb_*_page_flag() routines should be used
+ * to manipulate these flags.
+ *
+ * HP_Restore_Reserve - Set when a hugetlb page consumes a reservation at
+ *	allocation time.  Cleared when page is fully instantiated.  Free
+ *	routine checks flag to restore a reservation on error paths.
+ */
+enum hugetlb_page_flags {
+	HP_Restore_Reserve = 0,
+};
+
 #ifdef CONFIG_HUGETLB_PAGE
 
 #define HSTATE_NAME_LEN 32
@@ -531,6 +544,38 @@ extern unsigned int default_hstate_idx;
 
 #define default_hstate (hstates[default_hstate_idx])
 
+static inline int hugetlb_test_page_flag(struct page *page,
+					enum hugetlb_page_flags hp_flag)
+{
+	return test_bit(hp_flag, &page->private);
+}
+
+static inline void hugetlb_set_page_flag(struct page *page,
+					enum hugetlb_page_flags hp_flag)
+{
+	return set_bit(hp_flag, &page->private);
+}
+
+static inline void hugetlb_clear_page_flag(struct page *page,
+					enum hugetlb_page_flags hp_flag)
+{
+	return clear_bit(hp_flag, &page->private);
+}
+
+/*
+ * hugetlb page subpool pointer located in hpage[1].private
+ */
+static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
+{
+	return (struct hugepage_subpool *)(hpage+1)->private;
+}
+
+static inline void hugetlb_set_page_subpool(struct page *hpage,
+					struct hugepage_subpool *subpool)
+{
+	set_page_private(hpage+1, (unsigned long)subpool);
+}
+
 static inline struct hstate *hstate_file(struct file *f)
 {
 	return hstate_inode(file_inode(f));
@@ -775,6 +820,22 @@ void set_page_huge_active(struct page *page);
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
+static inline int hugetlb_test_page_flag(struct page *page,
+					enum hugetlb_page_flags hp_flag)
+{
+	return 0;
+}
+
+static inline void hugetlb_set_page_flag(struct page *page,
+					enum hugetlb_page_flags hp_flag)
+{
+}
+
+static inline void hugetlb_clear_page_flag(struct page *page,
+					enum hugetlb_page_flags hp_flag)
+{
+}
+
 static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
 					   unsigned long addr,
 					   int avoid_reserve)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 737b2dce19e6..b01002d8fc2b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1133,7 +1133,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
 	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
 	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
-		SetPagePrivate(page);
+		hugetlb_set_page_flag(page, HP_Restore_Reserve);
 		h->resv_huge_pages--;
 	}
 
@@ -1407,20 +1407,19 @@ static void __free_huge_page(struct page *page)
 	 */
 	struct hstate *h = page_hstate(page);
 	int nid = page_to_nid(page);
-	struct hugepage_subpool *spool =
-		(struct hugepage_subpool *)page_private(page);
+	struct hugepage_subpool *spool = hugetlb_page_subpool(page);
 	bool restore_reserve;
 
 	VM_BUG_ON_PAGE(page_count(page), page);
 	VM_BUG_ON_PAGE(page_mapcount(page), page);
 
-	set_page_private(page, 0);
+	hugetlb_set_page_subpool(page, NULL);
 	page->mapping = NULL;
-	restore_reserve = PagePrivate(page);
-	ClearPagePrivate(page);
+	restore_reserve = hugetlb_test_page_flag(page, HP_Restore_Reserve);
+	hugetlb_clear_page_flag(page, HP_Restore_Reserve);
 
 	/*
-	 * If PagePrivate() was set on page, page allocation consumed a
+	 * If HP_Restore_Reserve was set on page, page allocation consumed a
 	 * reservation.  If the page was associated with a subpool, there
 	 * would have been a page reserved in the subpool before allocation
 	 * via hugepage_subpool_get_pages().  Since we are 'restoring' the
@@ -2254,24 +2253,24 @@ static long vma_add_reservation(struct hstate *h,
  * This routine is called to restore a reservation on error paths.  In the
  * specific error paths, a huge page was allocated (via alloc_huge_page)
  * and is about to be freed.  If a reservation for the page existed,
- * alloc_huge_page would have consumed the reservation and set PagePrivate
- * in the newly allocated page.  When the page is freed via free_huge_page,
- * the global reservation count will be incremented if PagePrivate is set.
- * However, free_huge_page can not adjust the reserve map.  Adjust the
- * reserve map here to be consistent with global reserve count adjustments
- * to be made by free_huge_page.
+ * alloc_huge_page would have consumed the reservation and set
+ * HP_Restore_Reserve in the newly allocated page.  When the page is freed
+ * via free_huge_page, the global reservation count will be incremented if
+ * HP_Restore_Reserve is set.  However, free_huge_page can not adjust the
+ * reserve map.  Adjust the reserve map here to be consistent with global
+ * reserve count adjustments to be made by free_huge_page.
  */
 static void restore_reserve_on_error(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address,
 			struct page *page)
 {
-	if (unlikely(PagePrivate(page))) {
+	if (unlikely(hugetlb_test_page_flag(page, HP_Restore_Reserve))) {
 		long rc = vma_needs_reservation(h, vma, address);
 
 		if (unlikely(rc < 0)) {
 			/*
 			 * Rare out of memory condition in reserve map
-			 * manipulation.  Clear PagePrivate so that
+			 * manipulation.  Clear HP_Restore_Reserve so that
 			 * global reserve count will not be incremented
 			 * by free_huge_page.  This will make it appear
 			 * as though the reservation for this page was
@@ -2280,7 +2279,7 @@ static void restore_reserve_on_error(struct hstate *h,
 			 * is better than inconsistent global huge page
 			 * accounting of reserve counts.
 			 */
-			ClearPagePrivate(page);
+			hugetlb_clear_page_flag(page, HP_Restore_Reserve);
 		} else if (rc) {
 			rc = vma_add_reservation(h, vma, address);
 			if (unlikely(rc < 0))
@@ -2288,7 +2287,8 @@ static void restore_reserve_on_error(struct hstate *h,
 				 * See above comment about rare out of
 				 * memory condition.
 				 */
-				ClearPagePrivate(page);
+				hugetlb_clear_page_flag(page,
+						HP_Restore_Reserve);
 		} else
 			vma_end_reservation(h, vma, address);
 	}
@@ -2369,7 +2369,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 		if (!page)
 			goto out_uncharge_cgroup;
 		if (!avoid_reserve && vma_has_reserves(vma, gbl_chg)) {
-			SetPagePrivate(page);
+			hugetlb_set_page_flag(page, HP_Restore_Reserve);
 			h->resv_huge_pages--;
 		}
 		spin_lock(&hugetlb_lock);
@@ -2387,7 +2387,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 
 	spin_unlock(&hugetlb_lock);
 
-	set_page_private(page, (unsigned long)spool);
+	hugetlb_set_page_subpool(page, spool);
 
 	map_commit = vma_commit_reservation(h, vma, addr);
 	if (unlikely(map_chg > map_commit)) {
@@ -4212,7 +4212,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 	spin_lock(ptl);
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
-		ClearPagePrivate(new_page);
+		hugetlb_clear_page_flag(new_page, HP_Restore_Reserve);
 
 		/* Break COW */
 		huge_ptep_clear_flush(vma, haddr, ptep);
@@ -4279,7 +4279,7 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 
 	if (err)
 		return err;
-	ClearPagePrivate(page);
+	hugetlb_clear_page_flag(page, HP_Restore_Reserve);
 
 	/*
 	 * set page dirty so that it will not be removed from cache/file
@@ -4441,7 +4441,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		goto backout;
 
 	if (anon_rmap) {
-		ClearPagePrivate(page);
+		hugetlb_clear_page_flag(page, HP_Restore_Reserve);
 		hugepage_add_new_anon_rmap(page, vma, haddr);
 	} else
 		page_dup_rmap(page, true);
@@ -4755,7 +4755,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	if (vm_shared) {
 		page_dup_rmap(page, true);
 	} else {
-		ClearPagePrivate(page);
+		hugetlb_clear_page_flag(page, HP_Restore_Reserve);
 		hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
 	}
 
-- 
2.29.2


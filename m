Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725E4300FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbhAVWZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:25:45 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57352 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730605AbhAVTy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 14:54:26 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MJndfM171767;
        Fri, 22 Jan 2021 19:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=h5f/U1VuxRafr9mBGsFQdTJrhqpxcwXxUuFcGTNnNds=;
 b=ub2C7P42OYG0Z6LBdUqzUCoz3P/kRbJcsY0Yqh+rvwXtLBlA47+ohk7MJQ80+vbfvlmt
 CH0x5EzuGYa3WSQsFHjgFx7oJlvUo6DKJU8wyFtL/qRTU5hd4EAtBPh5eQuqBCnLmAtd
 +Bc9Sn6C7AGpH0dCe36pcPFfEZtP+bi7PnBg/DTQvKS6x0noDsNEXmT39RCahl6C2jz6
 KL21yM9tYC9/c6Ppevr/c544edl2kg5KznXyVKSELAuVvLW5W6PrU0Cul00sQ+KthFHk
 WjAXwKH/IkyMmUMDLG4F0mHDQJogP5JZTwo5EDdTkpt8ZpshcndqWqzIYAtvXCRgbnAp Tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3668qanv9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 19:53:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MJoxRd141347;
        Fri, 22 Jan 2021 19:53:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by userp3020.oracle.com with ESMTP id 3668r1h9d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 19:53:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mh2UCMqzjHDMAHMuDWSigvdUxO9R0CwydIitR2yjCOLU4t36hNd+igfhnqj8BKBSx0J4fqZNUT861hFDYvW8HjfEWXNK/bfB59S9F37WaFnvTfphe1wJnxApGji9Fqvl6fq4n6oRa2oDwuitTW9AxvASVC3NI1CyvgQxU5a+dran4MFX/BJESISiOPDHU41gVlE061F9CMNxP8XvAkVzXCVMT548gYK9L2lwUdp4jQ1rsAMHzlCanXZLNbk5ojyOomV2S5nttCQI25uvgOtsozk+DWJZ/FJm2YLlrn9CEE9HI+bDrujGehdN0IhbiInP9ivg+7LcFyEspz7sEdRPmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5f/U1VuxRafr9mBGsFQdTJrhqpxcwXxUuFcGTNnNds=;
 b=l5obcFey/OBtYfqEa59hAUEq86pCtO9+iyXZwBKTHVsa44UWzumhjIBtF355Pib+eVklZTKESHNqE58fzdoi7ciZP7w28ZVRPcIsT11WlOYm/w4UZ2j3X4gcaqGAwwEbNp6Mt6SjIRpi0W+rAeI9AJV79oPNLtbiesrgisUDiHJvPASsTeFRxW40f+0gFDK8/ku6YwAHl6wJVjV3JozNAVuzzpFvJYNTE56HMewwgv2UD2MBYBIInGYA6tg5ZYYK+tawr0MDC1twkStFKjEDWs9w5aBvmJvqPSe76HjOklIAZZbzweeQ0b0aeonsfQg8BSWP0CzBZ0k+LY2qBEvdTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5f/U1VuxRafr9mBGsFQdTJrhqpxcwXxUuFcGTNnNds=;
 b=XqBukEKJSOfYbN8cWfhQ1vKMI2BYzdHIzqSh2iZoGC+4GMiU+BPPA4zA2Jy4SzALXsduy1fC7fQUzGw+i8lWNA65yUIR5MnfQwIdKecbKrT3F+29zW1ELuhi5ET7L15/3kESPMGQmqe6aQ8MPvrV/1rzqd7tBzajqldlCNMTY9k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4723.namprd10.prod.outlook.com (2603:10b6:303:9c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Fri, 22 Jan
 2021 19:53:06 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.015; Fri, 22 Jan 2021
 19:53:06 +0000
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
Subject: [PATCH v3 1/5] hugetlb: use page.private for hugetlb specific page flags
Date:   Fri, 22 Jan 2021 11:52:27 -0800
Message-Id: <20210122195231.324857-2-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR19CA0071.namprd19.prod.outlook.com (2603:10b6:300:94::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15 via Frontend Transport; Fri, 22 Jan 2021 19:53:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44c18e22-1a88-447b-01ea-08d8bf0f55f0
X-MS-TrafficTypeDiagnostic: CO1PR10MB4723:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB472373C1FF0A3DC183F6B7EEE2A09@CO1PR10MB4723.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ogU7icpCxE4F26mZYN90jHR+ago/o47O0aLJuhAPKj88JuLGDqvgum1qxBMUXMK6pOd8/hQRbgPiSDlGBkcVGP020IZg0H2c4iZsAB4GXwJ5rOJXPnXYyU/Tm7VCMAoKsG4KgIwiA0rVi/l4RSKzNafXdVzP8otpiIwpDLMvquhxhLiUCYtAh5nuiXc+N/P5fliL+60gvB5SLrSaBAgn2bcMfY04gSVWd23FjcBzdhvM8UTHscvFl03tI0int7lGffGP7vGsvGPTiXqMNaPCTidd00oSdKxkqlGVmFZUBQB9T/3Qh+8AcS/zLgM4tot2/pO12bICo+ihcY0auPJc0wvG1LyYDXTEe2+fmxVyvY7WPCWdY3YwSNJpdgzMYjlg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(376002)(366004)(346002)(956004)(16526019)(186003)(2906002)(8676002)(2616005)(6486002)(8936002)(36756003)(44832011)(52116002)(478600001)(86362001)(26005)(66946007)(107886003)(7416002)(1076003)(83380400001)(66556008)(66476007)(6666004)(7696005)(30864003)(316002)(5660300002)(54906003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iXJthl1QHzLnKI6xdRuQbEn+Z5/EwElRJb+WOJ/x86G0OowKfVHPynxuVhQR?=
 =?us-ascii?Q?xf8xiBMH9WJWokkfw4bl0rZXWpHZedAU+HPTMpfjZVXGadcUHh/Shjym/Qgz?=
 =?us-ascii?Q?GWvShMrat9ywtcRIUgiCsW54HEXlIRum4mFWL6R9lAx8nZXM3Jr5rlWfulcA?=
 =?us-ascii?Q?QOPNySR9KFNazUtR+cJpmm60WV1k+gB27M8HowgoXY73JkXR4Q1Ezzauz82P?=
 =?us-ascii?Q?49ivh6MheUkeIAJurV5hO/E69Zre8JMyMxjeMu3KEl9vkmxm5Rdj5i+PFrv2?=
 =?us-ascii?Q?OsjYNyY86beVnE1edrNw9x7zqpUlbQlsD1htcknscCB3EkhzUAlbq0C53puL?=
 =?us-ascii?Q?ACW+IvHSGh+apzx/lIGIlgTwzgkSnIxOp/sD1ArIYJglOnz8hCu0GWP+nbAa?=
 =?us-ascii?Q?VsmXy9cpqYCr9RPWFQk492ZY2ccrkxRvG8oARK9HpeDh/fpl/VbcLUMTibtx?=
 =?us-ascii?Q?N1xbpf8hDE08vjcQKhnb1qQ9D0Dxhh+Dl8+0sx30MIJe2CmjVxk9dKbAQP4v?=
 =?us-ascii?Q?oeotlY+JCt6AEDC2SphEcH7hzrTPoeaPaZ8ppITIkLEgnlzFjJHWlvr+fSMI?=
 =?us-ascii?Q?Dw3IuomSwJaqhGKeJLNa7XS2fFj/g4KyKqKE+NM5HO0ktiDgGF63cd+h1fmP?=
 =?us-ascii?Q?1BBiALbGIFELHulK9Kcdbn1dgXtcqJKjcXvahUjTrdRItUQiJr6P69Xo2z+V?=
 =?us-ascii?Q?4Kbv9Nt9j4c+xaT1ZDn8PVinzw77A/BnhmYmPXu/anFJEIIF3TeZxM/Wwd+S?=
 =?us-ascii?Q?fNAR24ho3J1/GqbzKdqkI7TSAwrOisvJnbv45MmgTFbCkEY4dxpiGKEGxLDS?=
 =?us-ascii?Q?/sYoZPraV8AraSaCGFT4KRPnYyCZmU9kaXHsk1BGZgV7JhDpDZRBqhOnSN52?=
 =?us-ascii?Q?vbA5gp9LUx04y7iuSsNm7szgb2+mb4zgQ8vaTLzQh04rCDiSKsw/4A2tx7dH?=
 =?us-ascii?Q?2i3SrnZrzIfEQemzth1CjMqSvyZDmIdagejLV9UlQRHKq8Qa98r13JkBMsqw?=
 =?us-ascii?Q?xX+l3pOBxWwtAizCKDUiliDQyvkrxuPyoLrksKaC1GzvLuSiYUWkgl9tZVa+?=
 =?us-ascii?Q?RqwMHQpA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c18e22-1a88-447b-01ea-08d8bf0f55f0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 19:53:06.2111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +yYZIM15l1MrMDbnb0L+cHrthdWikjdaWyESjk7t3P6dwYB5nM9es74vN81bwcucAeP/ZjDCx2zJvi8bQGOEYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4723
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220101
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220101
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
hugetlb specific page flags.  These flags will have test, set and clear
functions similar to those used for 'normal' page flags.  More importantly,
an enum of flag values will be created with names that actually reflect
their purpose.

In this patch,
- Create infrastructure for hugetlb specific page flag functions
- Move subpool pointer to page[1].private to make way for flags
  Create routines with meaningful names to modify subpool field
- Use new HPageRestoreReserve flag instead of PagePrivate

Conversion of other state information will happen in subsequent patches.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c    | 12 ++------
 include/linux/hugetlb.h | 68 +++++++++++++++++++++++++++++++++++++++++
 mm/hugetlb.c            | 48 +++++++++++++++--------------
 3 files changed, 96 insertions(+), 32 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 21c20fd5f9ee..b00801fd6002 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -966,15 +966,9 @@ static int hugetlbfs_migrate_page(struct address_space *mapping,
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
index b5807f23caf8..a7eb05315c6e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -472,6 +472,60 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 					unsigned long flags);
 #endif /* HAVE_ARCH_HUGETLB_UNMAPPED_AREA */
 
+/*
+ * huegtlb page specific state flags.  These flags are located in page.private
+ * of the hugetlb head page.  Functions created via the below macros should be
+ * used to manipulate these flags.
+ *
+ * HPG_restore_reserve - Set when a hugetlb page consumes a reservation at
+ *	allocation time.  Cleared when page is fully instantiated.  Free
+ *	routine checks flag to restore a reservation on error paths.
+ */
+enum hugetlb_page_flags {
+	HPG_restore_reserve = 0,
+	__NR_HPAGEFLAGS,
+};
+
+/*
+ * Macros to create test, set and clear function definitions for
+ * hugetlb specific page flags.
+ */
+#ifdef CONFIG_HUGETLB_PAGE
+#define TESTHPAGEFLAG(uname, flname)				\
+static inline int HPage##uname(struct page *page)		\
+	{ return test_bit(HPG_##flname, &(page->private)); }
+
+#define SETHPAGEFLAG(uname, flname)				\
+static inline void SetHPage##uname(struct page *page)		\
+	{ set_bit(HPG_##flname, &(page->private)); }
+
+#define CLEARHPAGEFLAG(uname, flname)				\
+static inline void ClearHPage##uname(struct page *page)		\
+	{ clear_bit(HPG_##flname, &(page->private)); }
+#else
+#define TESTHPAGEFLAG(uname, flname)				\
+static inline int HPage##uname(struct page *page)		\
+	{ return 0; }
+
+#define SETHPAGEFLAG(uname, flname)				\
+static inline void SetHPage##uname(struct page *page)		\
+	{ }
+
+#define CLEARHPAGEFLAG(uname, flname)				\
+static inline void ClearHPage##uname(struct page *page)		\
+	{ }
+#endif
+
+#define HPAGEFLAG(uname, flname)				\
+	TESTHPAGEFLAG(uname, flname)				\
+	SETHPAGEFLAG(uname, flname)				\
+	CLEARHPAGEFLAG(uname, flname)				\
+
+/*
+ * Create functions associated with hugetlb page flags
+ */
+HPAGEFLAG(RestoreReserve, restore_reserve)
+
 #ifdef CONFIG_HUGETLB_PAGE
 
 #define HSTATE_NAME_LEN 32
@@ -531,6 +585,20 @@ extern unsigned int default_hstate_idx;
 
 #define default_hstate (hstates[default_hstate_idx])
 
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
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d78111f0fa2c..8ec6138ca81b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1133,7 +1133,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
 	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
 	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
-		SetPagePrivate(page);
+		SetHPageRestoreReserve(page);
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
+	restore_reserve = HPageRestoreReserve(page);
+	ClearHPageRestoreReserve(page);
 
 	/*
-	 * If PagePrivate() was set on page, page allocation consumed a
+	 * If HPageRestoreReserve was set on page, page allocation consumed a
 	 * reservation.  If the page was associated with a subpool, there
 	 * would have been a page reserved in the subpool before allocation
 	 * via hugepage_subpool_get_pages().  Since we are 'restoring' the
@@ -2251,24 +2250,24 @@ static long vma_add_reservation(struct hstate *h,
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
+ * HPageRestoreReserve in the newly allocated page.  When the page is freed
+ * via free_huge_page, the global reservation count will be incremented if
+ * HPageRestoreReserve is set.  However, free_huge_page can not adjust the
+ * reserve map.  Adjust the reserve map here to be consistent with global
+ * reserve count adjustments to be made by free_huge_page.
  */
 static void restore_reserve_on_error(struct hstate *h,
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
+			 * manipulation.  Clear HPageRestoreReserve so that
 			 * global reserve count will not be incremented
 			 * by free_huge_page.  This will make it appear
 			 * as though the reservation for this page was
@@ -2277,7 +2276,7 @@ static void restore_reserve_on_error(struct hstate *h,
 			 * is better than inconsistent global huge page
 			 * accounting of reserve counts.
 			 */
-			ClearPagePrivate(page);
+			ClearHPageRestoreReserve(page);
 		} else if (rc) {
 			rc = vma_add_reservation(h, vma, address);
 			if (unlikely(rc < 0))
@@ -2285,7 +2284,7 @@ static void restore_reserve_on_error(struct hstate *h,
 				 * See above comment about rare out of
 				 * memory condition.
 				 */
-				ClearPagePrivate(page);
+				ClearHPageRestoreReserve(page);
 		} else
 			vma_end_reservation(h, vma, address);
 	}
@@ -2366,7 +2365,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 		if (!page)
 			goto out_uncharge_cgroup;
 		if (!avoid_reserve && vma_has_reserves(vma, gbl_chg)) {
-			SetPagePrivate(page);
+			SetHPageRestoreReserve(page);
 			h->resv_huge_pages--;
 		}
 		spin_lock(&hugetlb_lock);
@@ -2384,7 +2383,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 
 	spin_unlock(&hugetlb_lock);
 
-	set_page_private(page, (unsigned long)spool);
+	hugetlb_set_page_subpool(page, spool);
 
 	map_commit = vma_commit_reservation(h, vma, addr);
 	if (unlikely(map_chg > map_commit)) {
@@ -3156,6 +3155,9 @@ static int __init hugetlb_init(void)
 {
 	int i;
 
+	BUILD_BUG_ON(sizeof_field(struct page, private) * BITS_PER_BYTE <
+			__NR_HPAGEFLAGS);
+
 	if (!hugepages_supported()) {
 		if (hugetlb_max_hstate || default_hstate_max_huge_pages)
 			pr_warn("HugeTLB: huge pages not supported, ignoring associated command-line parameters\n");
@@ -4207,7 +4209,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 	spin_lock(ptl);
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
-		ClearPagePrivate(new_page);
+		ClearHPageRestoreReserve(new_page);
 
 		/* Break COW */
 		huge_ptep_clear_flush(vma, haddr, ptep);
@@ -4274,7 +4276,7 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 
 	if (err)
 		return err;
-	ClearPagePrivate(page);
+	ClearHPageRestoreReserve(page);
 
 	/*
 	 * set page dirty so that it will not be removed from cache/file
@@ -4436,7 +4438,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		goto backout;
 
 	if (anon_rmap) {
-		ClearPagePrivate(page);
+		ClearHPageRestoreReserve(page);
 		hugepage_add_new_anon_rmap(page, vma, haddr);
 	} else
 		page_dup_rmap(page, true);
@@ -4750,7 +4752,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	if (vm_shared) {
 		page_dup_rmap(page, true);
 	} else {
-		ClearPagePrivate(page);
+		ClearHPageRestoreReserve(page);
 		hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
 	}
 
-- 
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF24F2FC6F2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 02:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbhATBky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 20:40:54 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49488 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbhATBcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 20:32:20 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10K1UDQV117216;
        Wed, 20 Jan 2021 01:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=FhV/HeyL8L1JINdhS6sXklpxJlBsiWWrvT5wm8KT1oc=;
 b=QkB509wyHX11bj/yM11gOz7a8Zb9iKTAzkUrZulx2GcTSWDmAasVB01s31w+T69MjVOt
 cQrbWB79Qsc8qwekOl1vJ5BOPuhIM5H9Hb6QE1SCHriJ1TIagYxZuRzcxDR98TwcuF4G
 wR2k4eGVjQaemxo1ptjfoO8x3CyEoxRwGm2vLz/UpJc/EJiNiTelsxIP2C4HleFs3f39
 w4YOg9heZe04nUFaYo2PIQnHdTt45I57i/rEPmUMLmTTYZcqmkEWqLPsbyQXOUW0S2bp
 Kp3gUzYcpmzHaGmz15EL/AmwTJZNineC4KuL1w2V2VrRsKxtLpIPB6cV2MQhp0hSUPRg Xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3668qmracj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 01:31:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10K1UfG4016928;
        Wed, 20 Jan 2021 01:31:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3020.oracle.com with ESMTP id 3668qv5kn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 01:31:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvdIzUV17dlztPjRTbEOmSD9pHbG5/iSQbzMo0sPYFQ5W+9atZnPtH6Q037mXR4672aRZHbmolEJZeibfPSH4EHZ9r0Y4BROmM+fcECDToSaHe9wCkU3E10x7OLAUoHTKYwSWp9t1Fsm1exipxURhCEEBmXwzPJF9FIfSnTHWwoQpoYuCtR/AcK+AhR9EK6fjqHUI0QuK8FDSnoGvR1vcMdvN0p1bJQJwHybco4DTb8kjnfvviEEb3cGbw6Bxw2EA1/YmhE0aK26154Sf44w3o5BoECElOZ0OQWhBXmMU7raAnVrdd6De4IZU109YFI3fI8D5s7m6KZ5A+zE043r/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhV/HeyL8L1JINdhS6sXklpxJlBsiWWrvT5wm8KT1oc=;
 b=J5FHK6wOmImm9Rddi7tMw2kdwqYEwB1XwaOToFQRkTwPHRBKPH8UEEufK/jyQiVDRWJT70vLuFpc1snVVF6Dw81TZq4KlupFx9Sssx39NfQA6MqSygaUPgQcXumpMrspI6oME+xU0P1kcLR3u6rn+93Do6xekTHztoM6nQVerhgpbQNrb4fMfqwu8XrXIG5EdGuE08GE5lV6iYZJ2wje9LINBUxl+kloRVHvmTymWiBOX4dwerHcWGVC7Lh1bhcl9hO4zEzflCCn85xrZmLlRAXCXC1omYNDSjt74ukWOstvh8eNn6xUgVDnL7jl9G42pW7mQzf42tO3wJy4ueK1Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhV/HeyL8L1JINdhS6sXklpxJlBsiWWrvT5wm8KT1oc=;
 b=Oww6JFe7xK536rfF8KkbW8+SwGX/vcyInRttn1H3xWwraiyPNHGRSIy4HxgDHtFOd20V5rEx/W2NGj2+AmKe7BxErk7MqIUVIoQd0rx7gjsyOSNbTjdiL8mjzA2I9gbxLUYT04WBu4e5OSqbeTgePD/GA+Om5+O72c0osJnkHlg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2384.namprd10.prod.outlook.com (2603:10b6:301:2d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 20 Jan
 2021 01:31:12 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 01:31:12 +0000
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
Subject: [PATCH v2 1/5] hugetlb: use page.private for hugetlb specific page flags
Date:   Tue, 19 Jan 2021 17:30:45 -0800
Message-Id: <20210120013049.311822-2-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by CO2PR04CA0178.namprd04.prod.outlook.com (2603:10b6:104:4::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Wed, 20 Jan 2021 01:31:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40d9d0b3-f785-4889-e0a0-08d8bce311f4
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB238489B0416897663CADC75EE2A20@MWHPR1001MB2384.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2d8s9UBIY6cU8mE55MaAOORYFZ12tw/8rAwD1hSt4xv7qzDvlE6MSVOBuEs6p6a7E+xh+0INhYxBbbEWfg5LNQfp7k6XpLEeRK2k6kXxv4FifqVg84foRy1tjwHijg6Qa3pDUUae2L1kCIRJOCR6rC6WO/NfaXWf5lXEQN+/TM1/sK4lGWmOZwWO5/2OzS02uK01cEEIhMi1w33UJa4cocBqC4sfUyyrJxVVGV1iWj/DbPphN8D13jlUJj62kD05nmD3hZxp3US0Mqi1DAAl1hzL24bj0f1uLEo+JBtBcRpyo0AlSqGgn1EYxAameG8bisixVNT4vuBsklbe+T5zfJbdSYksBSSTkhfmE1zIRneyU3/skg2udC8cFq9pXTOniFC/EBrKhmkyF6WfMlX7I8clk45hTFCZwye+fHTbH8jfwKkRBUU3ypbXfKZqGrkna6MRia1p1Otk4k0ZVOQaW/vOZNQbhcxoJ2YkOAu4aLfFuOykpwOdxiju7iJ2n40cEOzsXZTd5MMoi3iFzm0gnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(366004)(136003)(396003)(1076003)(8676002)(186003)(36756003)(107886003)(8936002)(478600001)(16526019)(4326008)(956004)(316002)(86362001)(5660300002)(54906003)(6486002)(2616005)(7696005)(30864003)(66946007)(66476007)(66556008)(83380400001)(44832011)(2906002)(52116002)(6666004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0/8YNTc0IHHp5biU0fknqSIol3XhKVGH0gyHbRbWWoc09NtbCxusBD5sTEf/?=
 =?us-ascii?Q?qwEjzGGB9hngVUoabB8ou2Ih/OalJj+w3vhVGQqe/sVpYbd/V280VVsDoH7s?=
 =?us-ascii?Q?AtgWZ7DZ4ki21ZACsoij0ypfVdAVcknJaC+MIH++KEBCCKwazhJu0Ra+ZPF8?=
 =?us-ascii?Q?L5flAu4FPVTJG5PpHPF/h+3+Cu+FguiShx+3Gqt8Fx1ap0mycgqIldrcxs/O?=
 =?us-ascii?Q?Gtqce/IyXI6l2twn/fsI1om6sUIEnh1Z1a4MWT8wu9yHA1W4G8yGk32xgsKf?=
 =?us-ascii?Q?dxlDBLxbs1hFuivY0ZontVmYnQx/XDtYVwpuEgqCMSx04AkLZZ52q5ri5QbQ?=
 =?us-ascii?Q?+ojzKBtiYfMvbFFG4WgmeEAGodX9hu/s1C0KOnIAy8vrH1/WAUl+hGf88K9L?=
 =?us-ascii?Q?g29Jwdlpbo52voD1eqTQ+xoXjrGM0/TsJ4hpI/p0byKtVdeghoB7dMUrDlR9?=
 =?us-ascii?Q?T5XDXbAqcORYUFFBr0Ai6kDkL+JRc1volVNYBZdL+vnwGhvlGYqsk6n5rlhc?=
 =?us-ascii?Q?sdTLwES8ocMRNX2YolA8HPB3BQ/f21H7fHAidpboE2asEvrxgRVus4D+mMFE?=
 =?us-ascii?Q?nmOUwP3mkIgqvib+gcGx4k0HGfCfD84v87vvJ1lZcwxz+5V+BdWiVf9ihSOF?=
 =?us-ascii?Q?9PTNx6cKNZlS4ZVgnshyxAQzlm6GdwknOGl93P9xWEokvMQ1UnoQ4TKxEe/d?=
 =?us-ascii?Q?8txsQR/i82NYvy6H+Rzlr6R/XJlXzSxcvg8lLv2RFgd6GC8t4fWoQkNR9ckP?=
 =?us-ascii?Q?Ea98yTz5ihw9VEI8Z1bIiRQubQV0gr/pxnAEAVgs3Q9GnZ1Bd3iDWvmjEMPm?=
 =?us-ascii?Q?oUlzrPMe0IL+i6sfiOhpYtw+fF/vKVTtshRAqsIyomcEkEeWk+G2O/9o7T1A?=
 =?us-ascii?Q?MJ0iA0ec3tQw8L769wsp2BNE6O2Lhy3YWoWkoXyQktk09VgjHw8buUs+bg/l?=
 =?us-ascii?Q?GniSA2Q3bpJVUE0rnsMbc/tIhXombIUhQ+XvNdDas5UVT7sp9MKXQSgTbqrH?=
 =?us-ascii?Q?WXi0D3Ip1U9eFB8ad/ICLy2OF3LoEYixBYnoDvewJxt1h7j8YL4XmLynSjT7?=
 =?us-ascii?Q?Zy+wemwL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d9d0b3-f785-4889-e0a0-08d8bce311f4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 01:31:12.0213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mE85Hs0SCrT8iCBS0mxdfsKkJT5MFpCDSuaBDJfEzztPY4Bpogc2qc2aCII8Ig0pU/G4dRU9lMC5jhDFTbUNcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2384
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200005
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200005
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
 fs/hugetlbfs/inode.c    | 12 ++-----
 include/linux/hugetlb.h | 72 +++++++++++++++++++++++++++++++++++++++++
 mm/hugetlb.c            | 45 +++++++++++++-------------
 3 files changed, 97 insertions(+), 32 deletions(-)

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
index ef5b144b8aac..be71a00ee2a0 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -472,6 +472,64 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
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
+	{ BUILD_BUG_ON(sizeof_field(struct page, private) *	\
+			BITS_PER_BYTE < __NR_HPAGEFLAGS);	\
+	return test_bit(HPG_##flname, &(page->private)); }
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
+	{ BUILD_BUG_ON(sizeof_field(struct page, private) *	\
+			BITS_PER_BYTE < __NR_HPAGEFLAGS);	\
+	return 0 }
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
@@ -531,6 +589,20 @@ extern unsigned int default_hstate_idx;
 
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
index 737b2dce19e6..8bed6b5202d2 100644
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
@@ -2280,7 +2279,7 @@ static void restore_reserve_on_error(struct hstate *h,
 			 * is better than inconsistent global huge page
 			 * accounting of reserve counts.
 			 */
-			ClearPagePrivate(page);
+			ClearHPageRestoreReserve(page);
 		} else if (rc) {
 			rc = vma_add_reservation(h, vma, address);
 			if (unlikely(rc < 0))
@@ -2288,7 +2287,7 @@ static void restore_reserve_on_error(struct hstate *h,
 				 * See above comment about rare out of
 				 * memory condition.
 				 */
-				ClearPagePrivate(page);
+				ClearHPageRestoreReserve(page);
 		} else
 			vma_end_reservation(h, vma, address);
 	}
@@ -2369,7 +2368,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 		if (!page)
 			goto out_uncharge_cgroup;
 		if (!avoid_reserve && vma_has_reserves(vma, gbl_chg)) {
-			SetPagePrivate(page);
+			SetHPageRestoreReserve(page);
 			h->resv_huge_pages--;
 		}
 		spin_lock(&hugetlb_lock);
@@ -2387,7 +2386,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 
 	spin_unlock(&hugetlb_lock);
 
-	set_page_private(page, (unsigned long)spool);
+	hugetlb_set_page_subpool(page, spool);
 
 	map_commit = vma_commit_reservation(h, vma, addr);
 	if (unlikely(map_chg > map_commit)) {
@@ -4212,7 +4211,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 	spin_lock(ptl);
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
-		ClearPagePrivate(new_page);
+		ClearHPageRestoreReserve(new_page);
 
 		/* Break COW */
 		huge_ptep_clear_flush(vma, haddr, ptep);
@@ -4279,7 +4278,7 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 
 	if (err)
 		return err;
-	ClearPagePrivate(page);
+	ClearHPageRestoreReserve(page);
 
 	/*
 	 * set page dirty so that it will not be removed from cache/file
@@ -4441,7 +4440,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		goto backout;
 
 	if (anon_rmap) {
-		ClearPagePrivate(page);
+		ClearHPageRestoreReserve(page);
 		hugepage_add_new_anon_rmap(page, vma, haddr);
 	} else
 		page_dup_rmap(page, true);
@@ -4755,7 +4754,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	if (vm_shared) {
 		page_dup_rmap(page, true);
 	} else {
-		ClearPagePrivate(page);
+		ClearHPageRestoreReserve(page);
 		hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
 	}
 
-- 
2.29.2


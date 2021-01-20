Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382EA2FC6F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 02:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbhATBkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 20:40:12 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49584 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbhATBcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 20:32:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10K1UqPG117344;
        Wed, 20 Jan 2021 01:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=T/y0C8KGg6VbaNBVwE5V18yFykdnOaMirXBUIgX4rWM=;
 b=MuOo3R0CaTEz3Q3Bet5rn4y9NfLC5EVfV8jglPj7gBV4rd5UgKw48mf2XnPRhyEX5mxe
 jTTWfdDySUa/z1m0iQgZP2xlw7MNRD5/gauwx0UK0dfA61oo+vJ4KhWGet5tZG5Np1r9
 yNuR6C1CxRAqTHbQWxwQV/gjAtCVbro5O4B9Y+dBbY9kj5lofWHtt8TetTYPqbPYzkS9
 2015jUa2pGaJM300v5jEdWBrUfPN+lgRKA0hT2VXWTFb5a/OwNH5sssAb4L0DxX+9b+Y
 t93LJN1peuKgMX7uhkNre7IkLqwj2fhxS2hYxlMe9S+I1384dYOm/F0PVIOO+kHqIAN9 Hg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3668qmracr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 01:31:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10K1UeBd016838;
        Wed, 20 Jan 2021 01:31:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3020.oracle.com with ESMTP id 3668qv5kr7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 01:31:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Di6goIXyjWjl9ZTbvso7DpcLuBi9Gdk4JRogDJGBZZB3DCvScWztaVE50rgIwaZSkHdKCTD4f6qbxB6pQT/Ku8HuuzYSDfCDfKp043AZ3TTrSnOOaoG0BYlpR8827wpv84/KyPz1OCp2vOijR5h2pZjDDzYsTOFjSo5ubh5bmavgwADw1rkmUL0jd8zXEKFBbObB2+aaYVRmplOiFZl+VY8V+pwi4Sjozn1W2EFykTU/9Dkc85jgafpBE2JVrtM4G/s+47KNIYFPw3zave0NUhwbMbVq/5MaCDfM5zbnLNLMo4MCKFwbi09RqxJ9kMQFpBFxADdR0yl75mp+bsUwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/y0C8KGg6VbaNBVwE5V18yFykdnOaMirXBUIgX4rWM=;
 b=KBZN/4ivv/m/YWb/fxEPjEVdyd9ecB4jiZCouwO8VPClXZ45G4Np8+tlcwvomGZ62j2kKjzGe/IP0WotSPAWD9FIZlBnQtd5tCac2dxKttxjDY6PbqRw2G6/J/FH/EMNHEUN2YGTQurthVFFYMCjVJdOYjlPQCTG76JMPO4zRDs4RfcECKbWZqf16a6lCUfLJIyTx5XmbASN6KAVAR70pVb7HLC3nJjbBE+gAlmGKocWmbPULlTbkT3zUqktmbjhoqduSlltGdGdw0pZCI+RYGis/SWMYJ8B+3rMksHAvmi1ogXk9dEiNtyi4H65xK7osEvzqKXEti45QBol2bBcow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/y0C8KGg6VbaNBVwE5V18yFykdnOaMirXBUIgX4rWM=;
 b=GG+WCqkfkmNf/MfnI5JQKVYxqz6d0gS94o2Ceqg/8GUBCAuH7mzrUm7qEYXEJop8LE7tt5+HQMuobLHjqHgF8kdQoizWg4Nhn/Nhdf/WD5xMEkc9Q4tQulYBRdFUr2a7tZDG3YVeEK9H9VUPcLafVFDQuKJUP+ICxUJKU9kMlhQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2384.namprd10.prod.outlook.com (2603:10b6:301:2d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 20 Jan
 2021 01:31:21 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 01:31:21 +0000
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
Subject: [PATCH v2 4/5] hugetlb: convert PageHugeTemporary() to HPageTemporary flag
Date:   Tue, 19 Jan 2021 17:30:48 -0800
Message-Id: <20210120013049.311822-5-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by CO2PR04CA0178.namprd04.prod.outlook.com (2603:10b6:104:4::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Wed, 20 Jan 2021 01:31:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19a8af24-ad53-4166-158e-08d8bce3174a
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB23848719210C1A02C9E8A6BBE2A20@MWHPR1001MB2384.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LLhNn22uhhJs+6UsGmzRb3rk5UipYyG8K2oA0db7BW5LxoAu7lcCXBSuzME4Se9I4PcPm55N12qi/SZelsvr1qEUlpUOulYQoQf9aDF2eOR1I6yo4w5IR2qQvDSJQ/+SW4GbNfMNu1lsRjpkIlKqKF7lg7C96nAS0QD53uEo22V9SfrK2I4DivRoBm5rpdiHH5zNW9vWqRTbuLiVLvWUEflqFGMjBk1k/+hOmJRVbJ0IwbRiuE0eBg1JOGiyoC69CYRlu/1iTnCSgy9XBGOeSOism1zfEcHSPO56ZytZZ5qeXmY3o18dTJ7O/YAKLXT9Yk0brw7hGUU3l8IWiPM0k+rklpmHwaAPGcSqyMJ+AQc2KTxmjczsWRNBCcElIYjqlkF3Q68oETZLCK2sW/D8S2JQBAz0r+/bkCyubNYzYT2uClPCrhVTnnQ4tiVB/ld6JZDGDi4lj5ZpYSJi83gUycVrwsfi6xsLJtDezRhCUlFG1sJxJ1Amjo/zZ3imXKvvAe+lJEA/ixqjypudgo/6Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(366004)(136003)(396003)(1076003)(8676002)(186003)(36756003)(107886003)(8936002)(478600001)(16526019)(4326008)(956004)(316002)(86362001)(5660300002)(54906003)(6486002)(2616005)(7696005)(66946007)(66476007)(66556008)(83380400001)(44832011)(2906002)(52116002)(6666004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?e92PoP3YqQw89+tYyHMRriUMYrErAa+aojjP1Ah0Tx3xP2WS4RsJYU5yDEFA?=
 =?us-ascii?Q?PUFCoSj3qLFavnmLjTRCH2+GlMNWHpAZZQOQGumHrzQGKxZxFXlqowVj9pgz?=
 =?us-ascii?Q?ohTOPJU8+DUmdCp8W47BPI7RsTiqFWk4Z+/aua+H0z372J4n/JhDCc/WW3cK?=
 =?us-ascii?Q?I5gDudSztG3CluloPt1xbE1di8K5V01P7jv8r36h9OO0Nkk8yk6x6ybIpUbK?=
 =?us-ascii?Q?KMwGh6qpzzKQ2ZCbNmdtNaaDkmOZc3AJzV4BS+PyJpcWL1EgjvVLTVnDbkjr?=
 =?us-ascii?Q?RuPztLMJpLh0flHPIQVzN7Ux+uaWoMTOalOYeeMezQOGbIqDT0gkPEDpR2lc?=
 =?us-ascii?Q?AGiDcNFF3gQHh7k4nTPgWIBacF6H3cswz3oFg4W8PxLYwyO8t8FKyj7HId3u?=
 =?us-ascii?Q?LoENlA+OWzlA1RZcWKVE4Rw7o8a2De50gYo/UxnGh+0OfdYmr8F6IMCdpfSv?=
 =?us-ascii?Q?27MS+jN9qq2jGWxVQdhI0shApYEYFSZbFyjeMrUKF2vquBMPuqRQAd65+x50?=
 =?us-ascii?Q?e1fIabAKk2JfnDazgb53A1/LD+TPMEKrhVcQmd2ya0yLcogDD1N5GG9kJWhi?=
 =?us-ascii?Q?J5CAJQOX1qFQBNxhp0YXcIM3ZznYrM4xCdJ0ZfiB1Jv8vfqh/ZauaufIihyj?=
 =?us-ascii?Q?n8JdTHmTXCC3wruNI0ijv6aLkjQAltTgW4RHb8tBiITYyXizod3b2gKV+fxP?=
 =?us-ascii?Q?jX64U9Odl2pbHDHwLblY9RU8ySZgjHav9BeOeujBNWLFx8k+tKLAJIgdIipB?=
 =?us-ascii?Q?YD845NCYdGD38Exgi4Xtvi83yc3NstIS+SoAwIpdkwfdVlz4cw+lhBqFJHb6?=
 =?us-ascii?Q?rrhh4wJYSLFJYV6UlyudZlB76Pw7g6Oc4SRR5QOAx1UAlnXF7jzV4uDhm/Fr?=
 =?us-ascii?Q?MREITaSfAxAwsIc0uY56pNx581FOcHwi1yrbLWMGrZvfU27CdiDJ9fZqP8ca?=
 =?us-ascii?Q?in5F3bwlGS4H4002lDPphjun/K1da+lEuUQvqZRy/xW9EkLJSLQpC6lSQedo?=
 =?us-ascii?Q?N5VNucSia2dCHc9OxYjLWya64PqzQyQKSySPGSY0MDI+iwuRByqor3mdKMqW?=
 =?us-ascii?Q?Xz9KuYIB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a8af24-ad53-4166-158e-08d8bce3174a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 01:31:20.9403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hRKtlWjv4d3VfVl5ki1iKWyOWhL/9OGCE3+ciYrhIgBOehQ8of4VABIcKOjTw2XsoszuMnPok4wvRC+KvXK4A==
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

Use new hugetlb specific HPageTemporary flag to replace the
PageHugeTemporary() interfaces.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |  6 ++++++
 mm/hugetlb.c            | 36 +++++++-----------------------------
 2 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1e17529c8b81..ec329b9cc0fc 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -483,10 +483,15 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
  * HPG_migratable  - Set after a newly allocated page is added to the page
  *	cache and/or page tables.  Indicates the page is a candidate for
  *	migration.
+ * HPG_temporary - - Set on a page that is temporarily allocated from the buddy
+ *	allocator.  Typically used for migration target pages when no pages
+ *	are available in the pool.  The hugetlb free page path will
+ *	immediately free pages with this flag set to the buddy allocator.
  */
 enum hugetlb_page_flags {
 	HPG_restore_reserve = 0,
 	HPG_migratable,
+	HPG_temporary,
 	__NR_HPAGEFLAGS,
 };
 
@@ -534,6 +539,7 @@ static inline void ClearHPage##uname(struct page *page)		\
  */
 HPAGEFLAG(RestoreReserve, restore_reserve)
 HPAGEFLAG(Migratable, migratable)
+HPAGEFLAG(Temporary, temporary)
 
 #ifdef CONFIG_HUGETLB_PAGE
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6e32751489e8..0d2bfc2b6adc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1353,28 +1353,6 @@ struct hstate *size_to_hstate(unsigned long size)
 	return NULL;
 }
 
-/*
- * Internal hugetlb specific page flag. Do not use outside of the hugetlb
- * code
- */
-static inline bool PageHugeTemporary(struct page *page)
-{
-	if (!PageHuge(page))
-		return false;
-
-	return (unsigned long)page[2].mapping == -1U;
-}
-
-static inline void SetPageHugeTemporary(struct page *page)
-{
-	page[2].mapping = (void *)-1U;
-}
-
-static inline void ClearPageHugeTemporary(struct page *page)
-{
-	page[2].mapping = NULL;
-}
-
 static void __free_huge_page(struct page *page)
 {
 	/*
@@ -1422,9 +1400,9 @@ static void __free_huge_page(struct page *page)
 	if (restore_reserve)
 		h->resv_huge_pages++;
 
-	if (PageHugeTemporary(page)) {
+	if (HPageTemporary(page)) {
 		list_del(&page->lru);
-		ClearPageHugeTemporary(page);
+		ClearHPageTemporary(page);
 		update_and_free_page(h, page);
 	} else if (h->surplus_huge_pages_node[nid]) {
 		/* remove the page from active list */
@@ -1863,7 +1841,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	 * codeflow
 	 */
 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
-		SetPageHugeTemporary(page);
+		SetHPageTemporary(page);
 		spin_unlock(&hugetlb_lock);
 		put_page(page);
 		return NULL;
@@ -1894,7 +1872,7 @@ static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
 	 * We do not account these pages as surplus because they are only
 	 * temporary and will be released properly on the last reference
 	 */
-	SetPageHugeTemporary(page);
+	SetHPageTemporary(page);
 
 	return page;
 }
@@ -5607,12 +5585,12 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 	 * here as well otherwise the global surplus count will not match
 	 * the per-node's.
 	 */
-	if (PageHugeTemporary(newpage)) {
+	if (HPageTemporary(newpage)) {
 		int old_nid = page_to_nid(oldpage);
 		int new_nid = page_to_nid(newpage);
 
-		SetPageHugeTemporary(oldpage);
-		ClearPageHugeTemporary(newpage);
+		SetHPageTemporary(oldpage);
+		ClearHPageTemporary(newpage);
 
 		spin_lock(&hugetlb_lock);
 		if (h->surplus_huge_pages_node[old_nid]) {
-- 
2.29.2


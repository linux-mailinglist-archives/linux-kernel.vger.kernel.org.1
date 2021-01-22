Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2621300FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbhAVWUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:20:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60184 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730219AbhAVT4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 14:56:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MJnetp171797;
        Fri, 22 Jan 2021 19:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=rCjBFxuyQ0KYqoX+uhkyWaw6crnEcGXAt+NWxwcHqv8=;
 b=MopJ/e4UconBx+N8mUHvUwPOaSRBkGdq9P3wL97/2WyN8KOdeQ0l19LGvYZr8/+xgerY
 IZVBVSHdrGkN9+COhOPjroiDR314f4Hw2DuVDoA7j0tKBr99wgx/ps6x9rijHw+a8DL7
 kuwhTk7Q1yyx8TLn7Zj5M2BXvYRERCy+KT9XPZrxHqTSByrL0zvbvll1WOZ8gNJBILyp
 aGixTtyoQeZj1UePvxDlCJFBoP9EemZS0Jnfyeb4/3PtMKtEl7YTGMvD1NtdalL9qPHB
 Yx+3mGjefS9ns0v3E9jiMQx99DToudkSJdc02xch9gaNWFJJ1O8aAPplnQkN1/niyjrR GQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3668qanvg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 19:55:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MJooOK034944;
        Fri, 22 Jan 2021 19:53:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by aserp3030.oracle.com with ESMTP id 3668r0c41e-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 19:53:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doksZS8wsSIGWNgKTJsOmhH6CIxNXXDxaU31BrERkTNQ+pg5EmHBzDSMkH1SYevuZo6etkmVgGGmuWoRdzY/S0fDn+27no+E2GBa0iJMQ5ZNZa6phgJMnl3nggrp+vEddzTcwkt6Osk4H3LjoyTdEO0Tpq+mEiFqLRVEsE7ACX8LCnl9LHDMbeOK/xzSh00Y2E9qNRB/zxl1aqzcq5KJpUsE6m1Pg4x+DM7dN777Vy+Os9qIIyA7aLBrD+J7QBRERpo4kCaTHLqlgwePzq8jKzXZvwlJG1jOBm/20SQvMsIxbMdVmd3HbTttcrmv58+OJASUt7VyPxqx1HPxtD3nVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCjBFxuyQ0KYqoX+uhkyWaw6crnEcGXAt+NWxwcHqv8=;
 b=WOGsjDXw0gKZoGMczgBqrRktUIJ4xfVHcW7UqcSbD32cfIRhubBREbi2h+NXY1VFIf59RkMTNvbs1A3J9oadCNDoa9S+E77hadhWUlr32td8AAolKxfGwkZfDPJdQ0lO3IMZbh3POUsZxMzdA4q3tfWzQssZ+OzQfejdf1z7eXXBxay7hzxFFovAsLo38jJWHH68zWu9zx7rjr0xj/bhbDd0c4Qj3Qf1TpBk8B+bJxrXiZNsMKWUmwqQOcRJUXEckpOAGYzhwzoEDn3hyTGrnQ4QSjc+LIdDBGc986zo0ultP1o6bLvwlhYoCq0pCKr+PrAhD7LunZdSgz+17pJEMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCjBFxuyQ0KYqoX+uhkyWaw6crnEcGXAt+NWxwcHqv8=;
 b=d7r3gpTS7rhbm0I7Rqytj+baQaatE5IsYLTgP5UqlHba+g7iyQR2yCIm0jSqVUjWxNHBH1+rQcnu1x5Pn4AmTtypq67yjGdyNGEB9Ol92m05CKM5FZa2p2PgxSvqpb4m9YdPPMyG94ap4WlHtu7XZ4jNSBpQx0zU+ImELAFj2Co=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4723.namprd10.prod.outlook.com (2603:10b6:303:9c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Fri, 22 Jan
 2021 19:53:13 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.015; Fri, 22 Jan 2021
 19:53:13 +0000
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
Subject: [PATCH v3 4/5] hugetlb: convert PageHugeTemporary() to HPageTemporary flag
Date:   Fri, 22 Jan 2021 11:52:30 -0800
Message-Id: <20210122195231.324857-5-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR19CA0071.namprd19.prod.outlook.com (2603:10b6:300:94::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15 via Frontend Transport; Fri, 22 Jan 2021 19:53:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f3c1814-4065-4b16-a768-08d8bf0f5a46
X-MS-TrafficTypeDiagnostic: CO1PR10MB4723:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4723EA3710DDEEAE05790642E2A09@CO1PR10MB4723.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zAdd/6N0IZweiyKUMuAzVyHejEq1N4TEx5QjM92jzr33H3NKHtxxiohttWjU9EIznWrfLhmKZE1dFc+5lA9EiFpWTbbLusY7qt/MTRxrA0o7scvjzN3fiJ4bKamMZhdgPouJ2GeeFKvG5/MBK7F3AQC0+qJt8KBsKJw2wHSl2OHiAIqz9cER3H/4UdLgKafH3wGpOChZqDRUJX/nOsUJ0kueLDYfa2rM+aPD9TkzEWa8Ny4D57boylpBuFifAXSvjL5XHUu80TAV9/CYNYEFdEUKjqhT37IO06+UdduK9c13zHh99aJN7eH40s+WBM38VhYILyPcSNrKw1PbY05GydPTN2CrP3km7a46IWEeAGRHCe9JYjKuJT562wipMTzJ/zH2nbJKs21YV7mN5JxiIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(376002)(366004)(346002)(956004)(16526019)(186003)(2906002)(8676002)(2616005)(6486002)(8936002)(36756003)(44832011)(52116002)(478600001)(86362001)(26005)(66946007)(107886003)(7416002)(1076003)(83380400001)(66556008)(66476007)(6666004)(7696005)(316002)(5660300002)(54906003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JiRl7mTDw6ze7Je4ky7QKS1szsHMbbPfsWAlPBwVhQdbQ8hkaKyvRIFvLSVc?=
 =?us-ascii?Q?NMmGBb6UQ8gE8cFonNTlJFuGbyRGUmKL2htj3SfpVz4TT0FRK6tUchZNWBDO?=
 =?us-ascii?Q?55KWwEqSPD/8TjYB8eI9VwGiHZKeziz7GqBHlkzaVNbRvRkX8rilN6Inu22J?=
 =?us-ascii?Q?vwZUoDWx3AKfWWoJL91OqUuHRbtlqt9fFfR2/UIUJ5/yTpELf4n0R4TZzKDy?=
 =?us-ascii?Q?z5EPlEGHQGN2r27IpMrgjl7wZw06akVCrFwTGmavvgY/vK6Bn0RlqKVI3XSx?=
 =?us-ascii?Q?Jf3XbYM6wgKsE4J9FNOjVsTvFg09GinNprzNXfe1+Kw+dy/5WoQvgOayccU5?=
 =?us-ascii?Q?z1byIJoQN/dEc5B4yQrHovtSfx3zK/pKW8gevKhUSVJrLBVY923a0jMLysdl?=
 =?us-ascii?Q?kHjA5mvg1dNNmaHl2s9iSrtOzkBlO8E6MW0bykHglWK0gg9L4kH8yBU2D7G0?=
 =?us-ascii?Q?/BUXsB3Ulh2MsaItfTpgCIJ4qlsmVZPfqgALWNr1hHrbXdfM5GXRdrT75i+3?=
 =?us-ascii?Q?euO470akSkgi3zD99q6RfavJE+/XcxyaPdgeLhtxg45YQOxXn3ZJD4XByPwU?=
 =?us-ascii?Q?JKy2g4RWVrvAloum/fMEaxvrtCh/QKl8fM8BMEGyCek1Z0CIwUv9iB237wOm?=
 =?us-ascii?Q?ZnY3KjC3cGwrQCcE2SK4OC50mZtsdV6FJYJ3uhFL4onEiZn5lWaSklgydVIW?=
 =?us-ascii?Q?Q4B2mcvieY5ZwaaXqOlESNSbm971FoG2e4ziuto/8y3QgSxplVScbGT/deeQ?=
 =?us-ascii?Q?jvCcdPb540cP963TJMaqzkixmLOmujSv2lWBJc9poM0zaic5L9G1R4Gfryqr?=
 =?us-ascii?Q?v7BBs683mlmCU/ynNyHAd8tgFn+CoMHjLO6YpHVZv/uPHpZ9dguC8F4o9VBI?=
 =?us-ascii?Q?s/ZTllReJXUthH9wr86DNN1xwlkoSdOPYUZ2U8ZbwkFJZpsL8GyE/txzfcte?=
 =?us-ascii?Q?c1+Fy8yfamTJXUcDRsfGoIwymZ14SMiKmIV4mQjCI3q5vm+XsFu0f5UoF65H?=
 =?us-ascii?Q?x+s/ZuS970DDJw+QHWIB+n7mTL7aIc86SAkBgHuKsyo6SSm0Bzf0/B+YuwS0?=
 =?us-ascii?Q?hoXUMZ/B?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3c1814-4065-4b16-a768-08d8bf0f5a46
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 19:53:13.5168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2F1XStjIu2ZnAma9yFtvsWl0qySGpRLunVPqmmNqNS+ksWiGlHhyn6t0bSRFhfau8W3dcfQ+cnztPhX2JzPQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4723
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
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

Use new hugetlb specific HPageTemporary flag to replace the
PageHugeTemporary() interfaces.  PageHugeTemporary does contain
a PageHuge() check.  However, this interface is only used within
hugetlb code where we know we are dealing with a hugetlb page.
Therefore, the check can be eliminated.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/hugetlb.h |  6 ++++++
 mm/hugetlb.c            | 36 +++++++-----------------------------
 2 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index cd1960541f2a..3c86c3a0e144 100644
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
 
@@ -530,6 +535,7 @@ static inline void ClearHPage##uname(struct page *page)		\
  */
 HPAGEFLAG(RestoreReserve, restore_reserve)
 HPAGEFLAG(Migratable, migratable)
+HPAGEFLAG(Temporary, temporary)
 
 #ifdef CONFIG_HUGETLB_PAGE
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4da1a29ac5e2..70ffa1027988 100644
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
@@ -1860,7 +1838,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	 * codeflow
 	 */
 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
-		SetPageHugeTemporary(page);
+		SetHPageTemporary(page);
 		spin_unlock(&hugetlb_lock);
 		put_page(page);
 		return NULL;
@@ -1891,7 +1869,7 @@ static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
 	 * We do not account these pages as surplus because they are only
 	 * temporary and will be released properly on the last reference
 	 */
-	SetPageHugeTemporary(page);
+	SetHPageTemporary(page);
 
 	return page;
 }
@@ -5612,12 +5590,12 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
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


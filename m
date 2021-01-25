Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749B1302D35
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbhAYVD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:03:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:55942 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732198AbhAYVBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:01:03 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10PKsnVv175388;
        Mon, 25 Jan 2021 21:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=QUtN9ijQd10g1b30SZ6Ui3bEJJlMszFpH4tGaJekeWQ=;
 b=NEm/MulRbysyiQva8vXIZ2LLmcVG9WlT4WAs2NwZMJDXzHOEyCFkWhSRHE1GRAMSkQ2b
 ORlULmxLF3pKbTp9F1UUFTcYi+vvhRBIoRIdYVLxfHTANcB6YrAStN8ght9pTKRd4OMg
 MAeXfI6gUSocGpzcVUjw4iB1a+hZh1lSHj+lewtQT/sE6gG33JpfnSaCl8nbPKLlC8MX
 6cduIE+Uik1etbqWR2/CKplwJOxc1/c+cwD4QafcOuryfsNrKJ3Q8gKteDNMKMtAde7Z
 Dje3nvlglLNGPXk2mfWYXwVjSHbt4nF4M7Tbk8XVNgzLNl1E7lC11Jsx6W+uDZGLKiyD Ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 368brkf9bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 21:00:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10PKuTv3136398;
        Mon, 25 Jan 2021 20:58:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3020.oracle.com with ESMTP id 368wpx4rwn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 20:58:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=im1clGZk1L6I/LAgzInaPPdWqhgUKt/O1hKA7DNesksrkFV62V/GtLqZhixpztDmx9vCKFh6t05qzSCB1tzHiFFtBUUltgeubL5SdQQmyqlX3aLCNkETOky67tqG91lZxmve/r7uZKy+4hiOM5EG1yBXmptMtm6gnjidU4WyXODycaEtuKGAp7IToPQ08u+Y6UJi8pLzSOOmdoAvT44ylTmnkpdUQwpNmBghYzXvDvjz7QVtnCB0OKpKVIcxqBCYmAS2+nJ4uZziOJteiFlewPaZGwXamtKBc66HtM/iji8zt/ElIUyvTRa6udawMpq1YPHqZCax54fa6HQgIb9j4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUtN9ijQd10g1b30SZ6Ui3bEJJlMszFpH4tGaJekeWQ=;
 b=oQk8NKA4weG3Qp7pzr1yo1tUBX1SDrOvgTuDuFYuyliENdTArU822GE/BIT9miQ2ocNujmYjoqsXH2hhv48XFxuxriWPCCjgOEf5eEicB0DZGYuH3hf0qL3SdJ+Vdb0jYnVrxT9I+7uf2A4wghYPNlhzxwmxLfBDEjVR5bUd04Gwzd9MyKlkL7Gi3AGzgEwmDrZl2kUNMYPe44OWu8JBgXx2ele2GfZ/MjCeJ/TMU+Ca4GGEtUgh/uMjuJdKqZBmo4e9CyPMLR+TRunloPeL+OguWl+GVJd0wdXaNcYc/VukOjSf5NCRh61NF6SBHYWn/lzbQ8+4m74j1kOtBxQ1zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUtN9ijQd10g1b30SZ6Ui3bEJJlMszFpH4tGaJekeWQ=;
 b=D1lCnbu/xSKKt4z428Xje+fFC7cihUNNhN8DgOL6L1jpicVbo0rvGBAPP61w9oeqR71MYPftinYYGm5uf8Wrj4dg22ANJTD6NGjZlNHQ7y2tOtkHYLuSko9KYS2fthona+C5ma2h+9bTVjx0uUbpOrSOWo3ou95SGDxt5HXYxtE=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB2776.namprd10.prod.outlook.com (2603:10b6:a03:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Mon, 25 Jan
 2021 20:58:01 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%6]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 20:58:01 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH 1/2] mm/hugetlb: grab head page refcount once per group of subpages
Date:   Mon, 25 Jan 2021 20:57:43 +0000
Message-Id: <20210125205744.10203-2-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210125205744.10203-1-joao.m.martins@oracle.com>
References: <20210125205744.10203-1-joao.m.martins@oracle.com>
Content-Type: text/plain
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0293.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::10) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO4P123CA0293.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:196::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 20:57:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ce13914-9410-4ba9-2cd6-08d8c173e6c6
X-MS-TrafficTypeDiagnostic: BYAPR10MB2776:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2776C1DEDE2737D90FA0D7D0BBBD9@BYAPR10MB2776.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uMMpDidIHlJrv9bwl+QsvIvTnSPCzRzo/bCOjTD0K6OOb5cl0HpnzX9kwUaWLuIUdqZpzxqv2BEeNh0CWYWVH9tWGFRxHhKDgUljqBQlF4UCDyjSObb5OMA48+etMmwEi7ayQTz4uL3yT8Mu86NqzZ0ORC+ZIvmLlmIeG1E8ycppdo+U189ETQd3iY19dRLXGzz/mjd7gdDyLWWvx/yB5IAz3elbI/WUZ3nRElPEq0pXmAnlYkFHjG3Xc7YGGm31lqaUtDKslxxsbMRNyKeeKy5xqo0mJ4aiUEtk5ZugdwMwbHTJRVOIpu/d9WYiyggnydO/xg4JjQjyOqSWrm74YRlTkLlaqnpsSZH+xbbhNBEGFFJ/bkDIpOgBgr1amorWTE02sMANFwqhWU/owtnkeC6wRspPLoK0k1jIJdG+znGCGMWKmiooTTBIAtMHYxhwt80kQh+1bLmfRghxjCAJNs00L8uymKtVf2PJIlshk6X6HMuvRblNQm9w+3bm7HndoZjhAy05augdmHxYItourg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(39860400002)(376002)(136003)(6916009)(478600001)(107886003)(2906002)(1076003)(103116003)(4326008)(52116002)(956004)(83380400001)(6486002)(8676002)(7696005)(316002)(54906003)(86362001)(66946007)(6666004)(186003)(16526019)(66556008)(8936002)(36756003)(66476007)(26005)(5660300002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+vPEEBkclWbkVD2z8L/afr7BeqDjwFgDBDDNDULsUnkU8tsA5n3ZQq/TzVs5?=
 =?us-ascii?Q?Cb3U7c2xp71dCQ9VYFTyRoDcYURHbLJiaYHwBlx6Rw0S8cF88glf4wEXdCba?=
 =?us-ascii?Q?MkJ6tGhDB7HD8ZRwZfWvHZliXatfFIB0glQu/RqAq7nxkQWHxlsBmoT38xHe?=
 =?us-ascii?Q?y5xJXHqNpru5sWgvoJPtX2/pDxus4t+R4QDFh4QgSV6MmgMjvyQHLByVn4Fw?=
 =?us-ascii?Q?586mv58ndhESRmp3iNn4Dr1eGn7bNio2ZrAyNYdTALzGhcTvmkJztHr5sYQk?=
 =?us-ascii?Q?LJBi7xtLYi8KzM/Qrq4QD4nVS8rrxVg0HwIyYcOSm+50wBDM4ivJ1LI1kFgj?=
 =?us-ascii?Q?9ExZIsANiO+vRDftm7YXbhF8jDkDnC5Zdf+zmvfgOMNnojyumTFXvGXa5Rgm?=
 =?us-ascii?Q?unBYy9aeSjY2a71TuewFFaDPFBalxVg7eCeg5TMXmokQnxEgXTR85kPwfGDf?=
 =?us-ascii?Q?ahQmtgLHrI3VB3Mg22RzU1OzixuE90u9rXilvZcbjamyyXhG7yga2jGRH6y3?=
 =?us-ascii?Q?r2bsTxoC0//w/QW86hAvPkdrJiuN0HSFVnG+Wy3H0yuagyW8XMIuco1SMIbg?=
 =?us-ascii?Q?nzoGbIPKzfrBf9958D2T/QSnF/MZzf5L/b18ZESLUouAsX4p0y1EKs2fAKbL?=
 =?us-ascii?Q?dzoo0OpPdDghv0IfdBvDfJDZwzbda774oWjRkxGL9D4TqcOzeiyH1Quh1Urh?=
 =?us-ascii?Q?RR9YQ+UEMiXQS4NJfXH5geVl8Xeu8a02G0Fabo57MFbXZq4A2T5n0YwcEcph?=
 =?us-ascii?Q?mNilHLx8M9XbDKxD6UPPci+jYb9XWAGYyGSDh0fEBTiS1zVgFftaJHqFDOxG?=
 =?us-ascii?Q?EzeEL4NReJy2biHK+9Qsc+QI9FHZUKpa4rmfMp0tGY2uVYBH9FEK/AvTOOC0?=
 =?us-ascii?Q?eLv273ed5QPqD8eoxGbxU5ESw+YAppFi5fxBD5l+kaQQXEph9piBgBor9aBp?=
 =?us-ascii?Q?aHsiqsQeoq5yHdZpmxwVifjvBRnqcYAh2pCDqyQjENmubwP0menfCp29r1yB?=
 =?us-ascii?Q?RCpgliOLPJcPO/cK/A/rAWj2n99L7ej5CpKnPuifvF+4IunwBNIOHTJ98s1b?=
 =?us-ascii?Q?3eJ+7HDx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce13914-9410-4ba9-2cd6-08d8c173e6c6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 20:58:01.1911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mH2wzUK73TUCnGiF4ilqFCSIwXXqVb0dLS3/LKEOzHPh66njCQAd/kfjNWKWn+/F4Zob/nCKTuG62pdg5pt90M+ilRqKFeqO8BGLc1/oAHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2776
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9875 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101250107
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9875 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101250107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

follow_hugetlb_page() once it locks the pmd/pud, it checks all the
subpages in a huge page and grabs a reference for each one,
depending on how many pages we can store or the size of va range.
Similar to gup-fast, have follow_hugetlb_page() grab the head
page refcount only after counting all its subpages that are part
of the just faulted huge page.

Consequently we reduce the number of atomics necessary to pin
said huge page, which improves non-fast gup() considerably:

 - 16G with 1G huge page size
 gup_test -f /mnt/huge/file -m 16384 -r 10 -L -S -n 512 -w

 PIN_LONGTERM_BENCHMARK: ~87.6k us -> ~11k us

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/linux/mm.h |  3 +++
 mm/gup.c           |  5 ++---
 mm/hugetlb.c       | 43 ++++++++++++++++++++++++-------------------
 3 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a5d618d08506..0d793486822b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1182,6 +1182,9 @@ static inline void get_page(struct page *page)
 }
 
 bool __must_check try_grab_page(struct page *page, unsigned int flags);
+__maybe_unused struct page *try_grab_compound_head(struct page *page, int refs,
+						   unsigned int flags);
+
 
 static inline __must_check bool try_get_page(struct page *page)
 {
diff --git a/mm/gup.c b/mm/gup.c
index 3e086b073624..ecadc80934b2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -79,9 +79,8 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
  * considered failure, and furthermore, a likely bug in the caller, so a warning
  * is also emitted.
  */
-static __maybe_unused struct page *try_grab_compound_head(struct page *page,
-							  int refs,
-							  unsigned int flags)
+__maybe_unused struct page *try_grab_compound_head(struct page *page,
+						   int refs, unsigned int flags)
 {
 	if (flags & FOLL_GET)
 		return try_get_compound_head(page, refs);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a6bad1f686c5..016addc8e413 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4798,7 +4798,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	unsigned long vaddr = *position;
 	unsigned long remainder = *nr_pages;
 	struct hstate *h = hstate_vma(vma);
-	int err = -EFAULT;
+	int err = -EFAULT, refs;
 
 	while (vaddr < vma->vm_end && remainder) {
 		pte_t *pte;
@@ -4918,26 +4918,11 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			continue;
 		}
 
+		refs = 0;
+
 same_page:
-		if (pages) {
+		if (pages)
 			pages[i] = mem_map_offset(page, pfn_offset);
-			/*
-			 * try_grab_page() should always succeed here, because:
-			 * a) we hold the ptl lock, and b) we've just checked
-			 * that the huge page is present in the page tables. If
-			 * the huge page is present, then the tail pages must
-			 * also be present. The ptl prevents the head page and
-			 * tail pages from being rearranged in any way. So this
-			 * page must be available at this point, unless the page
-			 * refcount overflowed:
-			 */
-			if (WARN_ON_ONCE(!try_grab_page(pages[i], flags))) {
-				spin_unlock(ptl);
-				remainder = 0;
-				err = -ENOMEM;
-				break;
-			}
-		}
 
 		if (vmas)
 			vmas[i] = vma;
@@ -4946,6 +4931,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		++pfn_offset;
 		--remainder;
 		++i;
+		refs++;
 		if (vaddr < vma->vm_end && remainder &&
 				pfn_offset < pages_per_huge_page(h)) {
 			/*
@@ -4953,6 +4939,25 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			 * of this compound page.
 			 */
 			goto same_page;
+		} else if (pages) {
+			/*
+			 * try_grab_compound_head() should always succeed here,
+			 * because: a) we hold the ptl lock, and b) we've just
+			 * checked that the huge page is present in the page
+			 * tables. If the huge page is present, then the tail
+			 * pages must also be present. The ptl prevents the
+			 * head page and tail pages from being rearranged in
+			 * any way. So this page must be available at this
+			 * point, unless the page refcount overflowed:
+			 */
+			if (WARN_ON_ONCE(!try_grab_compound_head(pages[i-1],
+								 refs,
+								 flags))) {
+				spin_unlock(ptl);
+				remainder = 0;
+				err = -ENOMEM;
+				break;
+			}
 		}
 		spin_unlock(ptl);
 	}
-- 
2.17.1


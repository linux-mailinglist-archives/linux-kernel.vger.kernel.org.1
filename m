Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D10F2F2166
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387621AbhAKVDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:03:12 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46060 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbhAKVDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:03:09 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10BKx1Qs130708;
        Mon, 11 Jan 2021 21:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=M2YP5WljTwbwXwNz3APN86A9BqRoB9DTmuiroLeuoo0=;
 b=HT862PiRwSGAPKuIPtQQdCftNeoEqtVc40jQ600y5au/+q+eT/hGG+R2uwVPDnRLM0IB
 LKY1bH7RYm1tBh4fviiIAImTArqR8+K3WQuQA9oC0yJOBTNe444Lods9juVzkpwHHMsw
 F2VgMpF7H5FAjug6uyf2Q1epQFejuA5SfcgBrtkyAVSja/maN20Q2QeAf3r70zoMDDtS
 rd3+RONCpxxxA59a+u1/FZtCI9KqcrHK6Ox34dj8uuHqVelRS0afoVxWfBgWkj3c8fCs
 81dDmJwv2wgICYtClaKGz8CSrOCr176Ty7rAsjaDB8TVqWBptXlR5VBLfW5uEMvHXq3g mQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 360kvju7w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jan 2021 21:02:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10BKxtc4145947;
        Mon, 11 Jan 2021 21:02:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by aserp3030.oracle.com with ESMTP id 360kewtt5w-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jan 2021 21:02:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VADZFkiWqzhEwUkBccmkxpNZnRcCVaJ3hqS2YDn1aOZhv3LHluWh79umckdDoxvbIwFkR8pkA1t7/KAGaLyk7+UuFrk41+yqKCfbts5MfXXUekNcZAVnMim1X888RIVhY9VAGfd/vwpmA/khw1Hj0JjF24LmAQ/gZE2QfxyqQokXmtlP+NqAZOM4G/yuL+alTVtGhA31i/K/MzGVVlPnZXdlOzapvHdQnMkFRNk134XLRwzFiiMb2F77xW55Z+xHtW73vMNwmi0ZEBiBRStIiuu+J8VnKecv2f17IXlVQkVq36NO4hPGm8Gr7Y4W3NR+tJB+rybkwiCXDXWlxhhWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2YP5WljTwbwXwNz3APN86A9BqRoB9DTmuiroLeuoo0=;
 b=bcRyxMeEztRiwpeOLm+7le9IqiEu/XFs9rG+G/6rULtsARWB9mp1wBCVGvoFk860Nrf/ALjr8UCuo+/ejADU3m1CyOhBSObl9n5vgOKQTPAYPaYIzrwU4nnmhO/dio6U4E/OlY16IMwxQbFoHq93l/gNyuzFuoPrx//9FUySWk3p4ex4orqQyT7EYO5UtPjT214rhgWPfipjI82FsqFteRGvjRwZohQqLiirnWtZSfeXQIwh7USdecTI2u7RzAq72lIi98r8UDDerNpyUpEwWm+MPT+Gdmkv/DONOpFAjJyIc+iGL8/sZPDVMNBubBPiBo4ZV2PBCXi2+ymjLiN5DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2YP5WljTwbwXwNz3APN86A9BqRoB9DTmuiroLeuoo0=;
 b=Mw0tWp6PZX5JFnGLkZa7F+rqCt0H4nvHmQXJj0k3AJ0ex4Lgmt97qVRDLKol9XQ7Yw8Yiec8zSASXOXA1t3Pc6RISDk7m08wwnwQ7OU8Cvl/Taww1ioEM2gVZHGCx/uH8VEzqePVO8RVXs5vWwUVrcbWeWHgAozsyaykMZslnEc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1711.namprd10.prod.outlook.com (2603:10b6:301:a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 21:02:14 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 21:02:14 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 3/3] hugetlb: convert PageHugeTemporary() to HPageTempSurplus
Date:   Mon, 11 Jan 2021 13:01:52 -0800
Message-Id: <20210111210152.118394-4-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR11CA0028.namprd11.prod.outlook.com (2603:10b6:300:115::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 21:02:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b5bd6cb-2ad3-4c4d-cbff-08d8b6742c24
X-MS-TrafficTypeDiagnostic: MWHPR10MB1711:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1711D37413CD2A187EBDDEF2E2AB0@MWHPR10MB1711.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WLsLs3LpNVRLKNmQQCuwAaVa1AThlW1uM4jKSkYUADSx+OwR4WMyERgMqK4bStUkKy3JNJZaZwz5qYw9xbwvcyEdVzkt8wjEIMllFl0lfQsQnaC346fFPPwXMnEd9XdlkCqv9H33hbrjb4y2AW5lzNTIzaGiNnyI8qwGAhcOElnVEKOI1kNj8k+1r4ogDjvFACN2JF2GWEIeHwUJ2siVy0BFD57GxfspFOEs9TVRl7DhbkAb4lczhEWEwJbrrzKUXL7yGpoxuUQiaWb+3PcchwtRdSNS9nYHWDXAQulk1jNkqnPnHNtpJkWZ7fwxAqYtuNYZeeXpsqxFFDLbjLI/66/zAa0qMGbnFEEyRUrk+zvXPpVgpXffAal3jIcHWTZIxKt1pYrvKgvsmk/3EBdjJjuaxwUA9bVUh8Sv87SIro2f/KhbDlwk4Iy0wAQUF7W/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(376002)(39850400004)(396003)(186003)(16526019)(4326008)(1076003)(8676002)(6666004)(2616005)(54906003)(478600001)(107886003)(956004)(26005)(316002)(83380400001)(8936002)(5660300002)(2906002)(6486002)(86362001)(66556008)(52116002)(66946007)(7696005)(36756003)(66476007)(44832011)(145603002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5eoq/hqGhoMeO0BrEVXhswv7hd727iL7AFuFH553Gy6ucKChJuprBwnYHX/S?=
 =?us-ascii?Q?0B9yKEJNJ2zd9+7408UnquTNTrxN029hQFdPlL+cJXPYLxnRMhnG7l/hzpb7?=
 =?us-ascii?Q?/HaQ+jEmaUOScbD2pANPWTO+yR2ykPyQ/EqrR4jYskH9xvBbgWKMnmdNmBlt?=
 =?us-ascii?Q?2UVh0jeTBDl7f8D46T/LxNhIc2ZmWlYMEiTuYhtee8lhFw6Qee+6hHErIbck?=
 =?us-ascii?Q?AUSgnYaQ7KaD2BtUe4I96t1UVJ80WaniqyLFrlsvB6WIe+n/n05x02gOMyPE?=
 =?us-ascii?Q?e2byZDo+3anYMazMyeBUjSfm2rgWBuUf3X3zqTImVbgHJDIqKIYkQ8KnnubA?=
 =?us-ascii?Q?g5FbyiJVJxxw6FA1jh0ufxSA3sAteTWGOAX1Yp0XZ+bS6RYpaZpvYv2LZMnf?=
 =?us-ascii?Q?qHetsxNSqLupjpt3POshL9nYaEptapUX2awz3KR36LrFFeN+m9756GVZ/4Ai?=
 =?us-ascii?Q?w2KnBJwP3OQkqpqA0ooIQ+FnWdMXQBPv3wtS4bzfTAOmFNJfDDuAu8+Wb1YY?=
 =?us-ascii?Q?cXDn1Ca29E8XfQMdacisjVgpk4g85W2p99OTttiCWysPfCBc+e9OGw0x0txH?=
 =?us-ascii?Q?hjfVCcUFVwLCoHUIg3ZQydl1ThL3W69kHnwjWm1SLf6yFtBsRURj6QwAb2u3?=
 =?us-ascii?Q?2PzKKUH5x7MWBz0CShhVJPtnRqpzQR3h0NpXyEbb2udAhWUldBHEA76pfFkk?=
 =?us-ascii?Q?/uuoDkxCho+omf8mJYIO0iB72rORPLEbdMe/I+GB4zjaQezThq/PczSeHyzG?=
 =?us-ascii?Q?NEjDggjWtVyZNMJbJu/zlAf/RU0JljksD8xfsYlRKWcBRpi4kYa1xv99XwwW?=
 =?us-ascii?Q?0cnrkHGayY7VTHUUb5ibNzWBOnwOk6Ktwa7vVftJHmxl0BzyceX75siy3PjM?=
 =?us-ascii?Q?uvaHjO9SS6HIwQNq7iH6Dt/UXsKIIuVgVLTmW4uzwX/KSKCHlRWrWQj23d7E?=
 =?us-ascii?Q?fJuCuTxmRXt/SwOpwrJp2+qwVTqXJKsCqciOdqfwprc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 21:02:14.4866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5bd6cb-2ad3-4c4d-cbff-08d8b6742c24
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8jv8GJujhfkxAHO2KoJh4iogvkL0m0y6Ku/E4XFXJOAa+6fl9e4CfvvLliAT4eXGaNZTQVl8rC49SfOMVvTvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1711
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=893 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101110118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=945 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101110118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new hugetlb specific flag HPageTempSurplus to replace the
PageHugeTemporary() interfaces.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 38 +++++++++-----------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 34ce82f4823c..949e1f987319 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -58,6 +58,7 @@ static unsigned long hugetlb_cma_size __initdata;
 enum htlb_page_flags {
 	HPAGE_RestoreReserve = 0,
 	HPAGE_Migratable,
+	HPAGE_TempSurplus,
 };
 
 /*
@@ -99,6 +100,7 @@ void ClearHPage##flname(struct page *page)	\
 
 HPAGEFLAG(RestoreReserve)
 EXT_HPAGEFLAG(Migratable)
+HPAGEFLAG(TempSurplus)
 
 /*
  * hugetlb page subpool pointer located in hpage[1].private
@@ -1398,28 +1400,6 @@ struct hstate *size_to_hstate(unsigned long size)
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
@@ -1467,9 +1447,9 @@ static void __free_huge_page(struct page *page)
 	if (restore_reserve)
 		h->resv_huge_pages++;
 
-	if (PageHugeTemporary(page)) {
+	if (HPageTempSurplus(page)) {
 		list_del(&page->lru);
-		ClearPageHugeTemporary(page);
+		ClearHPageTempSurplus(page);
 		update_and_free_page(h, page);
 	} else if (h->surplus_huge_pages_node[nid]) {
 		/* remove the page from active list */
@@ -1883,7 +1863,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	 * codeflow
 	 */
 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
-		SetPageHugeTemporary(page);
+		SetHPageTempSurplus(page);
 		spin_unlock(&hugetlb_lock);
 		put_page(page);
 		return NULL;
@@ -1914,7 +1894,7 @@ static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
 	 * We do not account these pages as surplus because they are only
 	 * temporary and will be released properly on the last reference
 	 */
-	SetPageHugeTemporary(page);
+	SetHPageTempSurplus(page);
 
 	return page;
 }
@@ -5612,12 +5592,12 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 	 * here as well otherwise the global surplus count will not match
 	 * the per-node's.
 	 */
-	if (PageHugeTemporary(newpage)) {
+	if (HPageTempSurplus(newpage)) {
 		int old_nid = page_to_nid(oldpage);
 		int new_nid = page_to_nid(newpage);
 
-		SetPageHugeTemporary(oldpage);
-		ClearPageHugeTemporary(newpage);
+		SetHPageTempSurplus(oldpage);
+		ClearHPageTempSurplus(newpage);
 
 		spin_lock(&hugetlb_lock);
 		if (h->surplus_huge_pages_node[old_nid]) {
-- 
2.29.2


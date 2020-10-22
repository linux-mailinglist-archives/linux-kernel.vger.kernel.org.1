Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD58296777
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 00:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373116AbgJVWyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 18:54:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28772 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S373109AbgJVWyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 18:54:13 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09MMnBvj027752
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 15:54:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=jCwwODX7YwrK220gHIqPM0Cu0J/BfkukpANadFRweU0=;
 b=O6OT7p9iIl6c9a4dpB5r0W1paZTT9NnFX/MN2WnY0i9b9xwSSFtBeOGVdupFRJaiVCQA
 0iWfRntwU9X2HyAeo6YfFUAKBJdTtVCb9m5O6G1OKc+bFohoO0nLgEB5gBSyCzgPi4vV
 64/VQWj5r+gBn76OiYB8L2UKDgNhkQnPoF0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34bk3wg1j0-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 15:54:12 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 22 Oct 2020 15:53:18 -0700
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id ED8AD1A3AE4C; Thu, 22 Oct 2020 15:53:12 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Zi Yan <ziy@nvidia.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        <saberlily.xia@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v1 2/2] mm: hugetlb: don't drop hugetlb_lock around cma_release() call
Date:   Thu, 22 Oct 2020 15:53:08 -0700
Message-ID: <20201022225308.2927890-3-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201022225308.2927890-1-guro@fb.com>
References: <20201022225308.2927890-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-22_17:2020-10-20,2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 suspectscore=2 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=620 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220146
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace blocking cma_release() with a non-blocking cma_release_nowait()
call, so there is no more need to temporarily drop hugetlb_lock.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/hugetlb.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fe76f8fd5a73..230e9b6c9a2b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1224,10 +1224,11 @@ static void free_gigantic_page(struct page *page,=
 unsigned int order)
 {
 	/*
 	 * If the page isn't allocated using the cma allocator,
-	 * cma_release() returns false.
+	 * cma_release_nowait() returns false.
 	 */
 #ifdef CONFIG_CMA
-	if (cma_release(hugetlb_cma[page_to_nid(page)], page, 1 << order))
+	if (cma_release_nowait(hugetlb_cma[page_to_nid(page)], page,
+			       1 << order))
 		return;
 #endif
=20
@@ -1312,14 +1313,8 @@ static void update_and_free_page(struct hstate *h,=
 struct page *page)
 	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
 	set_page_refcounted(page);
 	if (hstate_is_gigantic(h)) {
-		/*
-		 * Temporarily drop the hugetlb_lock, because
-		 * we might block in free_gigantic_page().
-		 */
-		spin_unlock(&hugetlb_lock);
 		destroy_compound_gigantic_page(page, huge_page_order(h));
 		free_gigantic_page(page, huge_page_order(h));
-		spin_lock(&hugetlb_lock);
 	} else {
 		__free_pages(page, huge_page_order(h));
 	}
--=20
2.26.2


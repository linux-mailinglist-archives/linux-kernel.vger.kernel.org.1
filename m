Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A926290DE6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 00:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392798AbgJPWxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 18:53:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39940 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392705AbgJPWxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 18:53:07 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09GMr0kx002406
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 15:53:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=facebook;
 bh=9Hm3Dn6iH9NJK0lCAO7l0OFnlRvp1sLOoEnjFN8y4JA=;
 b=IPD/dr+lyA43l+uzbdoxuubFH0+wkfxHbfGIpicglJbcBDKX0ylsSwZR8x6UgnNXYKrG
 RVsVm2C287pyNs7krM/u2woJfqjBVXqbfhcySHplUvOqrsZT8GRh0cAnAa4whYy0vJcC
 +0xrQBJfJ2eaKzns+AaUHZ9w9XTlpW7rAk8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 347gmw18c9-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 15:53:06 -0700
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 16 Oct 2020 15:53:00 -0700
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id 9C48816EFB7A; Fri, 16 Oct 2020 15:52:56 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Zi Yan <ziy@nvidia.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
Subject: [PATCH rfc 2/2] mm: hugetlb: don't drop hugetlb_lock around cma_release() call
Date:   Fri, 16 Oct 2020 15:52:54 -0700
Message-ID: <20201016225254.3853109-3-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201016225254.3853109-1-guro@fb.com>
References: <20201016225254.3853109-1-guro@fb.com>
MIME-Version: 1.0
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-16_12:2020-10-16,2020-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 adultscore=0 suspectscore=2 mlxlogscore=413 phishscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010160162
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cma_release() now is a non-blocking function, so there is no more need
to drop hugetlb_lock to call it.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/hugetlb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fe76f8fd5a73..c8c892b1cabc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1312,14 +1312,8 @@ static void update_and_free_page(struct hstate *h,=
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


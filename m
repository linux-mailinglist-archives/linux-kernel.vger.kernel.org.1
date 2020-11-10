Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237EE2AE05F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbgKJT6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:58:22 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15644 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729630AbgKJT6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:58:21 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AAJiSDr015007
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:58:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=hjOXAiNzgu9fDrCr2B26A5FENiij5QbaOJxXeBfw688=;
 b=K7q3FGwJEI97/0gTF8YYY06a5DzpTJRmQrWfIMTQFsWXUgcP6Pg4WPrLZy6Y4YBtlBqZ
 seL2KYOyP1ORO2qXn0PMBOTRUg59i2pY98PiKRZKvNekXU+2hzzhXxLAea42lmaZj+Yx
 9SS6gqQ71wRSFJJf0gIV7tyw3pdAqDyADQs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 34nqy2ft7w-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:58:20 -0800
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 10 Nov 2020 11:58:08 -0800
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id 31722238DAA4; Tue, 10 Nov 2020 11:57:59 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH 1/2] mm: slub: call account_slab_page() after slab page initialization
Date:   Tue, 10 Nov 2020 11:57:52 -0800
Message-ID: <20201110195753.530157-1-guro@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_07:2020-11-10,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxlogscore=855 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100135
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's convenient to have page->objects initialized before calling
into account_slab_page(). In particular, this information can be
used to pre-alloc the obj_cgroup vector.

Let's call account_slab_page() a bit later, after the initialization
of page->objects.

This commit doesn't bring any functional change, but is required for
further optimizations.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/slub.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 8c9fa24ebbf3..ccdbb62e025d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1622,9 +1622,6 @@ static inline struct page *alloc_slab_page(struct k=
mem_cache *s,
 	else
 		page =3D __alloc_pages_node(node, flags, order);
=20
-	if (page)
-		account_slab_page(page, order, s);
-
 	return page;
 }
=20
@@ -1777,6 +1774,8 @@ static struct page *allocate_slab(struct kmem_cache=
 *s, gfp_t flags, int node)
=20
 	page->objects =3D oo_objects(oo);
=20
+	account_slab_page(page, oo_order(oo), s, flags);
+
 	page->slab_cache =3D s;
 	__SetPageSlab(page);
 	if (page_is_pfmemalloc(page))
--=20
2.26.2


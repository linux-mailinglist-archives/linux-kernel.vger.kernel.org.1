Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A4E2EB8DA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 05:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbhAFEXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 23:23:36 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7312 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbhAFEXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 23:23:36 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1064LKri003974
        for <linux-kernel@vger.kernel.org>; Tue, 5 Jan 2021 20:22:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=hTa7wGlTEvxFN0YmAvxNjAujkmBK3LO29C6uRsljk+I=;
 b=jyzb2UJyiw/Q2zQKh6i9jLI5iZpofVfM3Pz7HvRKxQo2tbhBA1a3VGqZJQPM+nKkhDA9
 Xj8SiQdmUcWJ9YgYIMoeEehkvKi+2P1zouN6dylOhAjbDM2BkZpRyqbs0xUpg1Lty+hH
 VO8cn7iA27XOMAFgOHJcR+rYMjA7yPjvJbI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35vcs8ej1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 20:22:53 -0800
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 5 Jan 2021 20:22:51 -0800
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 1677D2A26DA4; Tue,  5 Jan 2021 20:22:42 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Imran Khan <imran.f.khan@oracle.com>
Subject: [PATCH] mm: memcg/slab: optimize objcg stock draining
Date:   Tue, 5 Jan 2021 20:22:39 -0800
Message-ID: <20210106042239.2860107-1-guro@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_03:2021-01-05,2021-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101060025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Imran Khan reported a regression in hackbench results caused by the
commit f2fe7b09a52b ("mm: memcg/slab: charge individual slab objects
instead of pages"). The regression is noticeable in the case of
a consequent allocation of several relatively large slab objects,
e.g. skb's. As soon as the amount of stocked bytes exceeds PAGE_SIZE,
drain_obj_stock() and __memcg_kmem_uncharge() are called, and it leads
to a number of atomic operations in page_counter_uncharge().

The corresponding call graph is below (provided by Imran Khan):
  |__alloc_skb
  |    |
  |    |__kmalloc_reserve.isra.61
  |    |    |
  |    |    |__kmalloc_node_track_caller
  |    |    |    |
  |    |    |    |slab_pre_alloc_hook.constprop.88
  |    |    |     obj_cgroup_charge
  |    |    |    |    |
  |    |    |    |    |__memcg_kmem_charge
  |    |    |    |    |    |
  |    |    |    |    |    |page_counter_try_charge
  |    |    |    |    |
  |    |    |    |    |refill_obj_stock
  |    |    |    |    |    |
  |    |    |    |    |    |drain_obj_stock.isra.68
  |    |    |    |    |    |    |
  |    |    |    |    |    |    |__memcg_kmem_uncharge
  |    |    |    |    |    |    |    |
  |    |    |    |    |    |    |    |page_counter_uncharge
  |    |    |    |    |    |    |    |    |
  |    |    |    |    |    |    |    |    |page_counter_cancel
  |    |    |    |
  |    |    |    |
  |    |    |    |__slab_alloc
  |    |    |    |    |
  |    |    |    |    |___slab_alloc
  |    |    |    |    |
  |    |    |    |slab_post_alloc_hook

Instead of directly uncharging the accounted kernel memory, it's
possible to refill the generic page-sized per-cpu stock instead.
It's a much faster operation, especially on a default hierarchy.
As a bonus, __memcg_kmem_uncharge_page() will also get faster,
so the freeing of page-sized kernel allocations (e.g. large kmallocs)
will become faster.

A similar change has been done earlier for the socket memory by
the commit 475d0487a2ad ("mm: memcontrol: use per-cpu stocks for
socket memory uncharging").

Signed-off-by: Roman Gushchin <guro@fb.com>
Reported-by: Imran Khan <imran.f.khan@oracle.com>
---
 mm/memcontrol.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0d74b80fa4de..8148c1df3aff 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3122,9 +3122,7 @@ void __memcg_kmem_uncharge(struct mem_cgroup *memcg=
, unsigned int nr_pages)
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		page_counter_uncharge(&memcg->kmem, nr_pages);
=20
-	page_counter_uncharge(&memcg->memory, nr_pages);
-	if (do_memsw_account())
-		page_counter_uncharge(&memcg->memsw, nr_pages);
+	refill_stock(memcg, nr_pages);
 }
=20
 /**
--=20
2.26.2


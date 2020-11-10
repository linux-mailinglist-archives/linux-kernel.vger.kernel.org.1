Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0772ACA04
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 02:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgKJBG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 20:06:29 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:65026 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727311AbgKJBG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 20:06:29 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AA14aAE012328
        for <linux-kernel@vger.kernel.org>; Mon, 9 Nov 2020 17:06:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=bSvYnbTgZjI4OQHvin/etTFcdCw3ZrCSSRl0xalNJqs=;
 b=PrbGHIrpZT3ie1lY+7Gk4RKhljy/GKlcDelvGbRZuL0sYOfHU28cNsFRuNScbdntfmV5
 6rKJUfZdHUUVWQ5ofSfGau/HOPPYSgF5qzerqtAVyCyqfQZczPTNgfm5T5FIdxYMqnV/
 odLVpb6Ge0rFJ7JlU4crBM9glI6NHNa/Q1k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34nt9kjpng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 17:06:28 -0800
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 9 Nov 2020 17:06:26 -0800
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id 23C3323165B1; Mon,  9 Nov 2020 17:06:20 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH] mm: memcg/slab: enable slab memory accounting atomically
Date:   Mon, 9 Nov 2020 17:06:15 -0800
Message-ID: <20201110010615.1273043-1-guro@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_15:2020-11-05,2020-11-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 clxscore=1015 suspectscore=2 impostorscore=0 bulkscore=0 mlxlogscore=416
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many kernel memory accounting paths are guarded by the
memcg_kmem_enabled_key static key. It changes it's state during
the onlining of the first non-root cgroup. However is doesn't
happen atomically: before all call sites will become patched
some charges/uncharges can be skipped, resulting in an unbalanced
charge. The problem is mostly a theoretical issue, unlikely
having a noticeable impact ion the real life.

Before the rework of the slab controller we relied at setting
kmemcg_id after enabling the memcg_kmem_enabled_key static key.
Now we can use the setting of memcg->objcg to enable the slab
memory accounting atomically.

The patch also removes obsolete comments related to already deleted
members of kmem_cache->memcg_params.

Signed-off-by: Roman Gushchin <guro@fb.com>
Fixes: 10befea91b61 ("mm: memcg/slab: use a single set of kmem_caches for=
 all allocations")
---
 include/linux/memcontrol.h | 6 ++----
 mm/memcontrol.c            | 7 ++++---
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 20108e426f84..01099dfa839c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -310,7 +310,6 @@ struct mem_cgroup {
 	int			tcpmem_pressure;
=20
 #ifdef CONFIG_MEMCG_KMEM
-        /* Index in the kmem_cache->memcg_params.memcg_caches array */
 	int kmemcg_id;
 	enum memcg_kmem_state kmem_state;
 	struct obj_cgroup __rcu *objcg;
@@ -1641,9 +1640,8 @@ static inline void memcg_kmem_uncharge_page(struct =
page *page, int order)
 }
=20
 /*
- * helper for accessing a memcg's index. It will be used as an index in =
the
- * child cache array in kmem_cache, and also to derive its name. This fu=
nction
- * will return -1 when this is not a kmem-limited memcg.
+ * A helper for accessing memcg's kmem_id, used for getting
+ * corresponding LRU lists.
  */
 static inline int memcg_cache_id(struct mem_cgroup *memcg)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 69a2893a6455..267cc68fba05 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3675,17 +3675,18 @@ static int memcg_online_kmem(struct mem_cgroup *m=
emcg)
 		memcg_free_cache_id(memcg_id);
 		return -ENOMEM;
 	}
-	objcg->memcg =3D memcg;
-	rcu_assign_pointer(memcg->objcg, objcg);
=20
 	static_branch_enable(&memcg_kmem_enabled_key);
=20
 	/*
 	 * A memory cgroup is considered kmem-online as soon as it gets
-	 * kmemcg_id. Setting the id after enabling static branching will
+	 * objcg. Setting the objcg after enabling static branching will
 	 * guarantee no one starts accounting before all call sites are
 	 * patched.
 	 */
+	objcg->memcg =3D memcg;
+	rcu_assign_pointer(memcg->objcg, objcg);
+
 	memcg->kmemcg_id =3D memcg_id;
 	memcg->kmem_state =3D KMEM_ONLINE;
=20
--=20
2.26.2


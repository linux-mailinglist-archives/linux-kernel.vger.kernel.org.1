Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3EB2AE05E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbgKJT6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:58:08 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4254 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726706AbgKJT6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:58:08 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAJiihQ008036
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:58:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=SDYx2t+dMle8yU1XBf2ct6vuamgyRUmM0G9FpunbHRY=;
 b=SZbOMRLG32g9x0kOKUowEBZXhnKvSUXGf8/H+8SRpG6FBM57Od46NVmjwkcFx/rdxDbB
 Kr6lv3DxH2sisVAhowspNbDUXJqwSiTs3rPG6BEsBkapeu27z5QLqr6rkdoeF/4xqyyJ
 RMyFSCGlwwpc8/Wx9w0OqvwIrEBAbCAWoY8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34pcmjcnd8-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:58:07 -0800
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 10 Nov 2020 11:58:05 -0800
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id 34213238DAA7; Tue, 10 Nov 2020 11:57:59 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH 2/2] mm: memcg/slab: pre-allocate obj_cgroups for slab caches with SLAB_ACCOUNT
Date:   Tue, 10 Nov 2020 11:57:53 -0800
Message-ID: <20201110195753.530157-2-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201110195753.530157-1-guro@fb.com>
References: <20201110195753.530157-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_07:2020-11-10,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 suspectscore=2 clxscore=1015 phishscore=0
 mlxlogscore=927 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011100135
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In general it's unknown in advance if a slab page will contain
accounted objects or not. In order to avoid memory waste, an
obj_cgroup vector is allocated dynamically when a need to account
of a new object arises. Such approach is memory efficient, but
requires an expensive cmpxchg() to set up the memcg/objcgs pointer,
because an allocation can race with a different allocation on another
cpu.

But in some common cases it's known for sure that a slab page will
contain accounted objects: if the page belongs to a slab cache with a
SLAB_ACCOUNT flag set. It includes such popular objects like
vm_area_struct, anon_vma, task_struct, etc.

In such cases we can pre-allocate the objcgs vector and simple assign
it to the page without any atomic operations, because at this early
stage the page is not visible to anyone else.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 14 ++++++++++----
 mm/memcontrol.c            |  4 ++--
 mm/slab.c                  |  2 +-
 mm/slab.h                  | 14 ++++++++++----
 4 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 20108e426f84..8271f11152e6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -485,14 +485,20 @@ static inline struct obj_cgroup **page_objcgs_check=
(struct page *page)
  * set_page_objcgs - associate a page with a object cgroups vector
  * @page: a pointer to the page struct
  * @objcgs: a pointer to the object cgroups vector
+ * @atomic: save the value atomically
  *
  * Atomically associates a page with a vector of object cgroups.
  */
 static inline bool set_page_objcgs(struct page *page,
-					struct obj_cgroup **objcgs)
+				   struct obj_cgroup **objcgs, bool atomic)
 {
-	return !cmpxchg(&page->memcg_data, 0, (unsigned long)objcgs |
-			MEMCG_DATA_OBJCGS);
+	unsigned long memcg_data =3D (unsigned long) objcgs | MEMCG_DATA_OBJCGS=
;
+
+	if (atomic)
+		return !cmpxchg(&page->memcg_data, 0, memcg_data);
+
+	page->memcg_data =3D memcg_data;
+	return true;
 }
 #else
 static inline struct obj_cgroup **page_objcgs(struct page *page)
@@ -506,7 +512,7 @@ static inline struct obj_cgroup **page_objcgs_check(s=
truct page *page)
 }
=20
 static inline bool set_page_objcgs(struct page *page,
-					struct obj_cgroup **objcgs)
+				   struct obj_cgroup **objcgs, bool atomic)
 {
 	return true;
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 69a2893a6455..37bffd336235 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2874,7 +2874,7 @@ static void commit_charge(struct page *page, struct=
 mem_cgroup *memcg)
=20
 #ifdef CONFIG_MEMCG_KMEM
 int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s=
,
-				 gfp_t gfp)
+				 gfp_t gfp, bool atomic)
 {
 	unsigned int objects =3D objs_per_slab_page(s, page);
 	void *vec;
@@ -2884,7 +2884,7 @@ int memcg_alloc_page_obj_cgroups(struct page *page,=
 struct kmem_cache *s,
 	if (!vec)
 		return -ENOMEM;
=20
-	if (!set_page_objcgs(page, vec))
+	if (!set_page_objcgs(page, vec, atomic))
 		kfree(vec);
 	else
 		kmemleak_not_leak(vec);
diff --git a/mm/slab.c b/mm/slab.c
index c0ea4b1c7088..df0299e1d0b9 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1380,7 +1380,7 @@ static struct page *kmem_getpages(struct kmem_cache=
 *cachep, gfp_t flags,
 		return NULL;
 	}
=20
-	account_slab_page(page, cachep->gfporder, cachep);
+	account_slab_page(page, cachep->gfporder, cachep, flags);
 	__SetPageSlab(page);
 	/* Record if ALLOC_NO_WATERMARKS was set when allocating the slab */
 	if (sk_memalloc_socks() && page_is_pfmemalloc(page))
diff --git a/mm/slab.h b/mm/slab.h
index c73050654b8a..f1d6ba09b630 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -240,7 +240,7 @@ static inline bool kmem_cache_debug_flags(struct kmem=
_cache *s, slab_flags_t fla
=20
 #ifdef CONFIG_MEMCG_KMEM
 int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s=
,
-				 gfp_t gfp);
+				 gfp_t gfp, bool atomic);
=20
 static inline void memcg_free_page_obj_cgroups(struct page *page)
 {
@@ -307,7 +307,8 @@ static inline void memcg_slab_post_alloc_hook(struct =
kmem_cache *s,
 			page =3D virt_to_head_page(p[i]);
=20
 			if (!page_objcgs(page) &&
-			    memcg_alloc_page_obj_cgroups(page, s, flags)) {
+			    memcg_alloc_page_obj_cgroups(page, s, flags,
+							 true)) {
 				obj_cgroup_uncharge(objcg, obj_full_size(s));
 				continue;
 			}
@@ -371,7 +372,8 @@ static inline struct mem_cgroup *memcg_from_slab_obj(=
void *ptr)
 }
=20
 static inline int memcg_alloc_page_obj_cgroups(struct page *page,
-					       struct kmem_cache *s, gfp_t gfp)
+					       struct kmem_cache *s, gfp_t gfp,
+					       bool atomic)
 {
 	return 0;
 }
@@ -412,8 +414,12 @@ static inline struct kmem_cache *virt_to_cache(const=
 void *obj)
 }
=20
 static __always_inline void account_slab_page(struct page *page, int ord=
er,
-					      struct kmem_cache *s)
+					      struct kmem_cache *s,
+					      gfp_t gfp)
 {
+	if (memcg_kmem_enabled() && (s->flags & SLAB_ACCOUNT))
+		memcg_alloc_page_obj_cgroups(page, s, gfp, false);
+
 	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
 			    PAGE_SIZE << order);
 }
--=20
2.26.2


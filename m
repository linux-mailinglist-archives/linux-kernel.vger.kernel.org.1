Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB91281927
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388295AbgJBR0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:26:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17738 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388225AbgJBR0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:26:07 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 092HDBbZ032499
        for <linux-kernel@vger.kernel.org>; Fri, 2 Oct 2020 10:26:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=r7f4iW6tcMB9qAKTY9Q++Lm6PGhhi/qqkZgcJrM4HWM=;
 b=UFLsOCsVXFbFGwnK8PylHP+YR1DFP5PqasOYdRCGeFP3gDZH8Wh7vPnk6EA5r0cfI9sq
 MUuBS4BGlxUGmNGwcROIHw1L6lcrECUB/TsDPP3pJGbAaAFM41p+6wcstwddpsKpk7FM
 LjcqnlrI8PQNj260VNYtg+q91SFX1uXiZp8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33x0n22cjn-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 10:26:06 -0700
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 2 Oct 2020 10:26:05 -0700
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id BC3B7F1529F; Fri,  2 Oct 2020 10:26:00 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v5 2/4] mm: memcontrol/slab: use helpers to access slab page's memcg_data
Date:   Fri, 2 Oct 2020 10:25:57 -0700
Message-ID: <20201002172559.4000748-3-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201002172559.4000748-1-guro@fb.com>
References: <20201002172559.4000748-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-02_11:2020-10-02,2020-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxlogscore=826 impostorscore=0 mlxscore=0 phishscore=0 bulkscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010020129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To gather all direct accesses to struct page's memcg_data field
in one place, let's introduce 3 new helpers to use in the slab
accounting code:
  struct obj_cgroup **page_objcgs(struct page *page);
  struct obj_cgroup **page_objcgs_check(struct page *page);
  bool set_page_objcgs(struct page *page, struct obj_cgroup **objcgs);

They are similar to the corresponding API for generic pages, except
that the setter can return false, indicating that the value has been
already set from a different thread.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 64 ++++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c            |  6 ++--
 mm/slab.h                  | 35 +++++----------------
 3 files changed, 75 insertions(+), 30 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f95c1433461c..c7ac0a5b8989 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -416,6 +416,70 @@ static inline struct mem_cgroup *page_memcg_check(st=
ruct page *page)
 	return (struct mem_cgroup *)memcg_data;
 }
=20
+#ifdef CONFIG_MEMCG_KMEM
+/*
+ * page_objcgs - get the object cgroups vector associated with a page
+ * @page: a pointer to the page struct
+ *
+ * Returns a pointer to the object cgroups vector associated with the pa=
ge,
+ * or NULL. This function assumes that the page is known to have an
+ * associated object cgroups vector. It's not safe to call this function
+ * against pages, which might have an associated memory cgroup: e.g.
+ * kernel stack pages.
+ */
+static inline struct obj_cgroup **page_objcgs(struct page *page)
+{
+	return (struct obj_cgroup **)(READ_ONCE(page->memcg_data) & ~0x1UL);
+}
+
+/*
+ * page_objcgs_check - get the object cgroups vector associated with a p=
age
+ * @page: a pointer to the page struct
+ *
+ * Returns a pointer to the object cgroups vector associated with the pa=
ge,
+ * or NULL. This function is safe to use if the page can be directly ass=
ociated
+ * with a memory cgroup.
+ */
+static inline struct obj_cgroup **page_objcgs_check(struct page *page)
+{
+	unsigned long memcg_data =3D READ_ONCE(page->memcg_data);
+
+	if (memcg_data && (memcg_data & 0x1UL))
+		return (struct obj_cgroup **)(memcg_data & ~0x1UL);
+
+	return NULL;
+}
+
+/*
+ * set_page_objcgs - associate a page with a object cgroups vector
+ * @page: a pointer to the page struct
+ * @objcgs: a pointer to the object cgroups vector
+ *
+ * Atomically associates a page with a vector of object cgroups.
+ */
+static inline bool set_page_objcgs(struct page *page,
+					struct obj_cgroup **objcgs)
+{
+	return !cmpxchg(&page->memcg_data, 0, (unsigned long)objcgs | 0x1UL);
+}
+#else
+static inline struct obj_cgroup **page_objcgs(struct page *page)
+{
+	return NULL;
+}
+
+static inline struct obj_cgroup **page_objcgs_check(struct page *page)
+{
+	return NULL;
+}
+
+static inline bool set_page_objcgs(struct page *page,
+					struct obj_cgroup **objcgs)
+{
+	return true;
+}
+#endif
+
 static __always_inline bool memcg_stat_item_in_bytes(int idx)
 {
 	if (idx =3D=3D MEMCG_PERCPU_B)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c2e6c75ed988..a8eb20283dcd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2899,7 +2899,7 @@ int memcg_alloc_page_obj_cgroups(struct page *page,=
 struct kmem_cache *s,
 	if (!vec)
 		return -ENOMEM;
=20
-	if (cmpxchg(&page->memcg_data, 0, (unsigned long)vec | 0x1UL))
+	if (!set_page_objcgs(page, vec))
 		kfree(vec);
 	else
 		kmemleak_not_leak(vec);
@@ -2933,12 +2933,12 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
 	 * Memcg membership data for each individual object is saved in
 	 * the page->obj_cgroups.
 	 */
-	if (page_has_obj_cgroups(page)) {
+	if (page_objcgs_check(page)) {
 		struct obj_cgroup *objcg;
 		unsigned int off;
=20
 		off =3D obj_to_index(page->slab_cache, page, p);
-		objcg =3D page_obj_cgroups(page)[off];
+		objcg =3D page_objcgs(page)[off];
 		if (objcg)
 			return obj_cgroup_memcg(objcg);
=20
diff --git a/mm/slab.h b/mm/slab.h
index 5ac89260f329..9b70d30d21c7 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -239,28 +239,12 @@ static inline bool kmem_cache_debug_flags(struct km=
em_cache *s, slab_flags_t fla
 }
=20
 #ifdef CONFIG_MEMCG_KMEM
-static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
-{
-	/*
-	 * Page's memory cgroup and obj_cgroups vector are sharing the same
-	 * space. To distinguish between them in case we don't know for sure
-	 * that the page is a slab page (e.g. page_cgroup_ino()), let's
-	 * always set the lowest bit of obj_cgroups.
-	 */
-	return (struct obj_cgroup **)(page->memcg_data & ~0x1UL);
-}
-
-static inline bool page_has_obj_cgroups(struct page *page)
-{
-	return page->memcg_data & 0x1UL;
-}
-
 int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s=
,
 				 gfp_t gfp);
=20
 static inline void memcg_free_page_obj_cgroups(struct page *page)
 {
-	kfree(page_obj_cgroups(page));
+	kfree(page_objcgs(page));
 	page->memcg_data =3D 0;
 }
=20
@@ -322,7 +306,7 @@ static inline void memcg_slab_post_alloc_hook(struct =
kmem_cache *s,
 		if (likely(p[i])) {
 			page =3D virt_to_head_page(p[i]);
=20
-			if (!page_has_obj_cgroups(page) &&
+			if (!page_objcgs(page) &&
 			    memcg_alloc_page_obj_cgroups(page, s, flags)) {
 				obj_cgroup_uncharge(objcg, obj_full_size(s));
 				continue;
@@ -330,7 +314,7 @@ static inline void memcg_slab_post_alloc_hook(struct =
kmem_cache *s,
=20
 			off =3D obj_to_index(s, page, p[i]);
 			obj_cgroup_get(objcg);
-			page_obj_cgroups(page)[off] =3D objcg;
+			page_objcgs(page)[off] =3D objcg;
 			mod_objcg_state(objcg, page_pgdat(page),
 					cache_vmstat_idx(s), obj_full_size(s));
 		} else {
@@ -343,18 +327,20 @@ static inline void memcg_slab_post_alloc_hook(struc=
t kmem_cache *s,
 static inline void memcg_slab_free_hook(struct kmem_cache *s, struct pag=
e *page,
 					void *p)
 {
+	struct obj_cgroup **objcgs;
 	struct obj_cgroup *objcg;
 	unsigned int off;
=20
 	if (!memcg_kmem_enabled())
 		return;
=20
-	if (!page_has_obj_cgroups(page))
+	objcgs =3D page_objcgs(page);
+	if (!objcgs)
 		return;
=20
 	off =3D obj_to_index(s, page, p);
-	objcg =3D page_obj_cgroups(page)[off];
-	page_obj_cgroups(page)[off] =3D NULL;
+	objcg =3D objcgs[off];
+	objcgs[off] =3D NULL;
=20
 	if (!objcg)
 		return;
@@ -367,11 +353,6 @@ static inline void memcg_slab_free_hook(struct kmem_=
cache *s, struct page *page,
 }
=20
 #else /* CONFIG_MEMCG_KMEM */
-static inline bool page_has_obj_cgroups(struct page *page)
-{
-	return false;
-}
-
 static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
 {
 	return NULL;
--=20
2.26.2


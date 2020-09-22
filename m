Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329E2274A78
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 22:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgIVU5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 16:57:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35664 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726448AbgIVU5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 16:57:55 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 08MKYnAH016666
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:37:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=AAkdjBcAxBHKbswa8X2vEsUdPUEX0CWuOZMOWVgmND0=;
 b=reYeuHPIrhXu/WR5jdMuv/mJUG/6Ywj8K/QMa7i9KH2Bh9zx0VePL3eUFht4dUk6dBQN
 iLESLzIiKVOEomflUSiXQj1bPOKh3dqs1dMYZnzXdnZBLbzYpASJ261plFnPoHL4QNAv
 3tGtjA1LjE20YoDRpOQQFYaJBCPljYZszyY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 33qn0as92p-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:37:24 -0700
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 22 Sep 2020 13:37:23 -0700
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id CD35C864B5C; Tue, 22 Sep 2020 13:37:21 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v1 2/4] mm: memcontrol/slab: use helpers to access slab page's memcg_data
Date:   Tue, 22 Sep 2020 13:36:58 -0700
Message-ID: <20200922203700.2879671-3-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200922203700.2879671-1-guro@fb.com>
References: <20200922203700.2879671-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-22_18:2020-09-21,2020-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=2 mlxscore=0
 mlxlogscore=810 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220161
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To gather all direct accesses to struct page's memcg_data field
in one place, let's introduce 4 new helper functions to use in
the slab accounting code:
  struct obj_cgroup **page_obj_cgroups(struct page *page);
  struct obj_cgroup **page_obj_cgroups_check(struct page *page);
  bool set_page_obj_cgroups(struct page *page, struct obj_cgroup **objcgs=
);
  void clear_page_obj_cgroups(struct page *page);

They are similar to the corresponding API for generic pages, except
that the setter can return false, indicating that the value has been
already set from a different thread.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h | 80 ++++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c            |  4 +-
 mm/slab.h                  | 27 ++-----------
 3 files changed, 85 insertions(+), 26 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3313e7c21534..ab3ea3e90583 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -409,6 +409,86 @@ static inline void clear_page_mem_cgroup(struct page=
 *page)
 	page->memcg_data =3D 0;
 }
=20
+#ifdef CONFIG_MEMCG_KMEM
+/*
+ * page_obj_cgroups - get the object cgroups vector associated with a pa=
ge
+ * @page: a pointer to the page struct
+ *
+ * Returns a pointer to the object cgroups vector associated with the pa=
ge,
+ * or NULL. This function assumes that the page is known to have an
+ * associated object cgroups vector. It's not safe to call this function
+ * against pages, which might have an associated memory cgroup: e.g.
+ * kernel stack pages.
+ */
+static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
+{
+	return (struct obj_cgroup **)(page->memcg_data & ~0x1UL);
+}
+
+/*
+ * page_obj_cgroups_check - get the object cgroups vector associated wit=
h a page
+ * @page: a pointer to the page struct
+ *
+ * Returns a pointer to the object cgroups vector associated with the pa=
ge,
+ * or NULL. This function is safe to use if the page can be directly ass=
ociated
+ * with a memory cgroup.
+ */
+static inline struct obj_cgroup **page_obj_cgroups_check(struct page *pa=
ge)
+{
+	unsigned long memcg_data =3D page->memcg_data;
+
+	if (memcg_data && (memcg_data & 0x1UL))
+		return (struct obj_cgroup **)memcg_data;
+
+	return NULL;
+}
+
+/*
+ * set_page_obj_cgroups - associate a page with a object cgroups vector
+ * @page: a pointer to the page struct
+ * @objcgs: a pointer to the object cgroups vector
+ *
+ * Atomically associates a page with a vector of object cgroups.
+ */
+static inline bool set_page_obj_cgroups(struct page *page,
+					struct obj_cgroup **objcgs)
+{
+	return !cmpxchg(&page->memcg_data, 0, (unsigned long)objcgs | 0x1UL);
+}
+
+/*
+ * clear_page_obj_cgroups - clear an association of a page with an
+ *                          object cgroups vector
+ * @page: a pointer to the page struct
+ *
+ * Clears an association of a page with an object cgroups vector
+ */
+static inline void clear_page_obj_cgroups(struct page *page)
+{
+	page->memcg_data =3D 0;
+}
+#else
+static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
+{
+	return NULL;
+}
+
+static inline struct obj_cgroup **page_obj_cgroups_check(struct page *pa=
ge)
+{
+	return NULL;
+}
+
+static inline bool set_page_obj_cgroups(struct page *page,
+					struct obj_cgroup **objcgs)
+{
+	return true;
+}
+
+static inline void clear_page_obj_cgroups(struct page *page)
+{
+}
+#endif
+
 static __always_inline bool memcg_stat_item_in_bytes(int idx)
 {
 	if (idx =3D=3D MEMCG_PERCPU_B)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 40220b7bf96d..69e3dbb3d2cf 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2895,7 +2895,7 @@ int memcg_alloc_page_obj_cgroups(struct page *page,=
 struct kmem_cache *s,
 	if (!vec)
 		return -ENOMEM;
=20
-	if (cmpxchg(&page->memcg_data, 0, (unsigned long)vec | 0x1UL))
+	if (!set_page_obj_cgroups(page, vec))
 		kfree(vec);
 	else
 		kmemleak_not_leak(vec);
@@ -2923,7 +2923,7 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
 	 * Memcg membership data for each individual object is saved in
 	 * the page->obj_cgroups.
 	 */
-	if (page_has_obj_cgroups(page)) {
+	if (page_obj_cgroups_check(page)) {
 		struct obj_cgroup *objcg;
 		unsigned int off;
=20
diff --git a/mm/slab.h b/mm/slab.h
index 5ac89260f329..9a46ab76cb61 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -239,29 +239,13 @@ static inline bool kmem_cache_debug_flags(struct km=
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
 	kfree(page_obj_cgroups(page));
-	page->memcg_data =3D 0;
+	clear_page_obj_cgroups(page);
 }
=20
 static inline size_t obj_full_size(struct kmem_cache *s)
@@ -322,7 +306,7 @@ static inline void memcg_slab_post_alloc_hook(struct =
kmem_cache *s,
 		if (likely(p[i])) {
 			page =3D virt_to_head_page(p[i]);
=20
-			if (!page_has_obj_cgroups(page) &&
+			if (!page_obj_cgroups(page) &&
 			    memcg_alloc_page_obj_cgroups(page, s, flags)) {
 				obj_cgroup_uncharge(objcg, obj_full_size(s));
 				continue;
@@ -349,7 +333,7 @@ static inline void memcg_slab_free_hook(struct kmem_c=
ache *s, struct page *page,
 	if (!memcg_kmem_enabled())
 		return;
=20
-	if (!page_has_obj_cgroups(page))
+	if (!page_obj_cgroups(page))
 		return;
=20
 	off =3D obj_to_index(s, page, p);
@@ -367,11 +351,6 @@ static inline void memcg_slab_free_hook(struct kmem_=
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


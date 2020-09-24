Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34B6277944
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 21:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgIXT1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 15:27:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28842 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728733AbgIXT1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 15:27:19 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08OJNwSG008492
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 12:27:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=9gQy5xLBq49UGK+xsI8YY1V9HrN13ZM+A1NA7q3Lcas=;
 b=NvjLJjmsn4+rIsMDynbm4fUncJRswDTxEnncTN+3xMxHvbX5SRQCWQGDOgKizfdkvbc2
 pa7Bsgpqcmdh+r2XyPbBnIoMFKJVvoG3ZY4zQIKU9477KBHgq1eNt7kXAQkQFql7uv/6
 36CwoTtMwfzfc5kaK730iZIOUffyqOPhJDM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33qsp63nuj-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 12:27:18 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 24 Sep 2020 12:27:17 -0700
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id 7B00C99237D; Thu, 24 Sep 2020 12:27:09 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 4/4] mm: convert page kmemcg type to a page memcg flag
Date:   Thu, 24 Sep 2020 12:27:06 -0700
Message-ID: <20200924192706.3075680-5-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200924192706.3075680-1-guro@fb.com>
References: <20200924192706.3075680-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_14:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=981 clxscore=1015 suspectscore=2 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PageKmemcg flag is currently defined as a page type (like buddy,
offline, table and guard). Semantically it means that the page
was accounted as a kernel memory by the page allocator and has
to be uncharged on the release.

As a side effect of defining the flag as a page type, the accounted
page can't be mapped to userspace (look at page_has_type() and
comments above). In particular, this blocks the accounting of
vmalloc-backed memory used by some bpf maps, because these maps
do map the memory to userspace.

One option is to fix it by complicating the access to page->mapcount,
which provides some free bits for page->page_type.

But it's way better to move this flag into page->memcg_data flags.
Indeed, the flag makes no sense without enabled memory cgroups
and memory cgroup pointer set in particular.

This commit replaces PageKmemcg() and __SetPageKmemcg() with
PageMemcgKmem() and SetPageMemcgKmem(). __ClearPageKmemcg()
can be simple deleted because clear_page_mem_cgroup() already
does the job.

As a bonus, on !CONFIG_MEMCG build the PageMemcgKmem() check will
be compiled out.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h | 54 +++++++++++++++++++++++++++++++++++---
 include/linux/page-flags.h | 11 ++------
 mm/memcontrol.c            | 14 +++-------
 mm/page_alloc.c            |  2 +-
 4 files changed, 58 insertions(+), 23 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a498a7368cff..b8dcf4047f05 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -346,6 +346,8 @@ extern struct mem_cgroup *root_mem_cgroup;
 enum page_memcg_flags {
 	/* page->memcg_data is a pointer to an objcgs vector */
 	PG_MEMCG_OBJ_CGROUPS,
+	/* page has been accounted as a non-slab kernel page */
+	PG_MEMCG_KMEM,
 	/* the next bit after the last actual flag */
 	PG_MEMCG_LAST_FLAG,
 };
@@ -363,8 +365,12 @@ enum page_memcg_flags {
  */
 static inline struct mem_cgroup *page_mem_cgroup(struct page *page)
 {
+	unsigned long memcg_data =3D page->memcg_data;
+
 	VM_BUG_ON_PAGE(PageSlab(page), page);
-	return (struct mem_cgroup *)page->memcg_data;
+	VM_BUG_ON_PAGE(test_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data), page);
+
+	return (struct mem_cgroup *)(memcg_data & ~MEMCG_FLAGS_MASK);
 }
=20
 /*
@@ -383,7 +389,7 @@ static inline struct mem_cgroup *page_mem_cgroup_chec=
k(struct page *page)
 	if (test_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data))
 		return NULL;
=20
-	return (struct mem_cgroup *)memcg_data;
+	return (struct mem_cgroup *)(memcg_data & ~MEMCG_FLAGS_MASK);
 }
=20
 /*
@@ -412,6 +418,36 @@ static inline void clear_page_mem_cgroup(struct page=
 *page)
 	page->memcg_data =3D 0;
 }
=20
+/*
+ * PageMemcgKmem - check if the page has MemcgKmem flag set
+ * @page: a pointer to the page struct
+ *
+ * Checks if the page has MemcgKmem flag set. The caller must ensure tha=
t
+ * the page has an associated memory cgroup. It's not safe to call this =
function
+ * against some types of pages, e.g. slab pages.
+ */
+static inline bool PageMemcgKmem(struct page *page)
+{
+	VM_BUG_ON_PAGE(test_bit(PG_MEMCG_OBJ_CGROUPS, &page->memcg_data), page)=
;
+	return test_bit(PG_MEMCG_KMEM, &page->memcg_data);
+}
+
+/*
+ * SetPageMemcgKmem - set the page's MemcgKmem flag
+ * @page: a pointer to the page struct
+ *
+ * Set the page's MemcgKmem flag. The caller must ensure that the page h=
as
+ * an associated memory cgroup. It's not safe to call this function
+ * against some types of pages, e.g. slab pages.
+ */
+static inline void SetPageMemcgKmem(struct page *page)
+{
+	VM_BUG_ON_PAGE(!page->memcg_data, page);
+	VM_BUG_ON_PAGE(test_bit(PG_MEMCG_OBJ_CGROUPS, &page->memcg_data), page)=
;
+	__set_bit(PG_MEMCG_KMEM, &page->memcg_data);
+}
+
+
 #ifdef CONFIG_MEMCG_KMEM
 /*
  * page_obj_cgroups - get the object cgroups vector associated with a pa=
ge
@@ -429,6 +465,7 @@ static inline struct obj_cgroup **page_obj_cgroups(st=
ruct page *page)
=20
 	VM_BUG_ON_PAGE(memcg_data && !test_bit(PG_MEMCG_OBJ_CGROUPS,
 					       &memcg_data), page);
+	VM_BUG_ON_PAGE(test_bit(PG_MEMCG_KMEM, &memcg_data), page);
=20
 	return (struct obj_cgroup **)(memcg_data & ~MEMCG_FLAGS_MASK);
 }
@@ -445,8 +482,10 @@ static inline struct obj_cgroup **page_obj_cgroups_c=
heck(struct page *page)
 {
 	unsigned long memcg_data =3D page->memcg_data;
=20
-	if (memcg_data && test_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data))
+	if (memcg_data && test_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data)) {
+		VM_BUG_ON_PAGE(test_bit(PG_MEMCG_KMEM, &memcg_data), page);
 		return (struct obj_cgroup **)(memcg_data & ~MEMCG_FLAGS_MASK);
+	}
=20
 	return NULL;
 }
@@ -1118,6 +1157,15 @@ static inline void clear_page_mem_cgroup(struct pa=
ge *page)
 {
 }
=20
+static inline bool PageMemcgKmem(struct page *page)
+{
+	return false;
+}
+
+static inline void SetPageMemcgKmem(struct page *page)
+{
+}
+
 static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
 {
 	return true;
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index fbbb841a9346..a7ca01ae78d9 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -712,9 +712,8 @@ PAGEFLAG_FALSE(DoubleMap)
 #define PAGE_MAPCOUNT_RESERVE	-128
 #define PG_buddy	0x00000080
 #define PG_offline	0x00000100
-#define PG_kmemcg	0x00000200
-#define PG_table	0x00000400
-#define PG_guard	0x00000800
+#define PG_table	0x00000200
+#define PG_guard	0x00000400
=20
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) =3D=3D PAGE_TYPE_BASE)
@@ -765,12 +764,6 @@ PAGE_TYPE_OPS(Buddy, buddy)
  */
 PAGE_TYPE_OPS(Offline, offline)
=20
-/*
- * If kmemcg is enabled, the buddy allocator will set PageKmemcg() on
- * pages allocated with __GFP_ACCOUNT. It gets cleared on page free.
- */
-PAGE_TYPE_OPS(Kmemcg, kmemcg)
-
 /*
  * Marks pages in use as page tables.
  */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 69e3dbb3d2cf..1d22fa4c4a88 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3081,7 +3081,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp=
_t gfp, int order)
 		ret =3D __memcg_kmem_charge(memcg, gfp, 1 << order);
 		if (!ret) {
 			set_page_mem_cgroup(page, memcg);
-			__SetPageKmemcg(page);
+			SetPageMemcgKmem(page);
 			return 0;
 		}
 		css_put(&memcg->css);
@@ -3106,10 +3106,6 @@ void __memcg_kmem_uncharge_page(struct page *page,=
 int order)
 	__memcg_kmem_uncharge(memcg, nr_pages);
 	clear_page_mem_cgroup(page);
 	css_put(&memcg->css);
-
-	/* slab pages do not have PageKmemcg flag set */
-	if (PageKmemcg(page))
-		__ClearPageKmemcg(page);
 }
=20
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_=
bytes)
@@ -6890,12 +6886,10 @@ static void uncharge_page(struct page *page, stru=
ct uncharge_gather *ug)
 	nr_pages =3D compound_nr(page);
 	ug->nr_pages +=3D nr_pages;
=20
-	if (!PageKmemcg(page)) {
-		ug->pgpgout++;
-	} else {
+	if (PageMemcgKmem(page))
 		ug->nr_kmem +=3D nr_pages;
-		__ClearPageKmemcg(page);
-	}
+	else
+		ug->pgpgout++;
=20
 	ug->dummy_page =3D page;
 	clear_page_mem_cgroup(page);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d4d181e15e7c..6807e37d78ba 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1197,7 +1197,7 @@ static __always_inline bool free_pages_prepare(stru=
ct page *page,
 	}
 	if (PageMappingFlags(page))
 		page->mapping =3D NULL;
-	if (memcg_kmem_enabled() && PageKmemcg(page))
+	if (memcg_kmem_enabled() && PageMemcgKmem(page))
 		__memcg_kmem_uncharge_page(page, order);
 	if (check_free)
 		bad +=3D check_free_page(page);
--=20
2.26.2


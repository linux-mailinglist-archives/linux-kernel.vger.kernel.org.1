Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD3227DD2A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 01:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgI2X7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 19:59:39 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57538 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728895AbgI2X7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 19:59:36 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TNu15b016952
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 16:59:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=qXGrbEu9kMvvAOHr5S1G+X/Vb7CLaT9fkoL/pfzIqc0=;
 b=fsFGmDN+9zf+yOSUwOITTz/I5gRyQb/w9iuYBfFeUAPmjkoGQnlAeCba3Jsn3/k82cpb
 urgbKsmgN9VHZfZuvZj7VteiugEEvveNedy2LbYQSbg/7Nij2d9+MjBTuoY3KNFYNK81
 T3q17hT+llAkMyJXM6GhTsIJWj1X0LAiFmc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33t35n875y-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 16:59:34 -0700
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 16:59:33 -0700
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id 7594AD62158; Tue, 29 Sep 2020 16:59:21 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v3 4/4] mm: convert page kmemcg type to a page memcg flag
Date:   Tue, 29 Sep 2020 16:59:20 -0700
Message-ID: <20200929235920.537849-5-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200929235920.537849-1-guro@fb.com>
References: <20200929235920.537849-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_14:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=941
 mlxscore=0 lowpriorityscore=0 suspectscore=2 impostorscore=0
 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290203
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
PageMemcgKmem() and __SetPageMemcgKmem(). __ClearPageKmemcg()
can be simple deleted because clear_page_mem_cgroup() already
does the job.

As a bonus, on !CONFIG_MEMCG build the PageMemcgKmem() check will
be compiled out.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 54 +++++++++++++++++++++++++++++++++++---
 include/linux/page-flags.h | 11 ++------
 mm/memcontrol.c            | 14 +++-------
 mm/page_alloc.c            |  2 +-
 4 files changed, 58 insertions(+), 23 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 35f846c6b89b..b20bb63bf2eb 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -346,6 +346,8 @@ extern struct mem_cgroup *root_mem_cgroup;
 enum page_memcg_data_flags {
 	/* page->memcg_data is a pointer to an objcgs vector */
 	MEMCG_DATA_OBJCGS,
+	/* page has been accounted as a non-slab kernel page */
+	MEMCG_DATA_KMEM,
 	/* the next bit after the last actual flag */
 	__NR_MEMCG_DATA_FLAGS,
 };
@@ -369,8 +371,12 @@ enum page_memcg_data_flags {
  */
 static inline struct mem_cgroup *page_memcg(struct page *page)
 {
+	unsigned long memcg_data =3D page->memcg_data;
+
 	VM_BUG_ON_PAGE(PageSlab(page), page);
-	return (struct mem_cgroup *)page->memcg_data;
+	VM_BUG_ON_PAGE(memcg_data & (0x1UL << MEMCG_DATA_OBJCGS), page);
+
+	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
=20
 /*
@@ -416,7 +422,7 @@ static inline struct mem_cgroup *page_memcg_check(str=
uct page *page)
 	if (memcg_data & (0x1UL << MEMCG_DATA_OBJCGS))
 		return NULL;
=20
-	return (struct mem_cgroup *)memcg_data;
+	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
=20
 /*
@@ -449,6 +455,36 @@ static inline void clear_page_memcg(struct page *pag=
e)
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
+	VM_BUG_ON_PAGE(test_bit(MEMCG_DATA_OBJCGS, &page->memcg_data), page);
+	return test_bit(MEMCG_DATA_KMEM, &page->memcg_data);
+}
+
+/*
+ * __SetPageMemcgKmem - set the page's MemcgKmem flag
+ * @page: a pointer to the page struct
+ *
+ * Set the page's MemcgKmem flag. The caller must ensure that the page h=
as
+ * an associated memory cgroup. It's not safe to call this function
+ * against some types of pages, e.g. slab pages.
+ */
+static inline void __SetPageMemcgKmem(struct page *page)
+{
+	VM_BUG_ON_PAGE(!page->memcg_data, page);
+	VM_BUG_ON_PAGE(test_bit(MEMCG_DATA_OBJCGS, &page->memcg_data), page);
+	__set_bit(MEMCG_DATA_KMEM, &page->memcg_data);
+}
+
+
 #ifdef CONFIG_MEMCG_KMEM
 /*
  * page_objcgs - get the object cgroups vector associated with a page
@@ -466,6 +502,7 @@ static inline struct obj_cgroup **page_objcgs(struct =
page *page)
=20
 	VM_BUG_ON_PAGE(memcg_data &&
 		       !(memcg_data & (0x1UL << MEMCG_DATA_OBJCGS)), page);
+	VM_BUG_ON_PAGE(memcg_data & (0x1UL << MEMCG_DATA_KMEM), page);
=20
 	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
@@ -482,9 +519,11 @@ static inline struct obj_cgroup **page_objcgs_check(=
struct page *page)
 {
 	unsigned long memcg_data =3D READ_ONCE(page->memcg_data);
=20
-	if (memcg_data && (memcg_data & (0x1UL << MEMCG_DATA_OBJCGS)))
+	if (memcg_data && (memcg_data & (0x1UL << MEMCG_DATA_OBJCGS))) {
+		VM_BUG_ON_PAGE(memcg_data & (0x1UL << MEMCG_DATA_KMEM), page);
 		return (struct obj_cgroup **)
 			(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+	}
=20
 	return NULL;
 }
@@ -1169,6 +1208,15 @@ static inline void clear_page_memcg(struct page *p=
age)
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
index f32b7f611045..a3c2749a36e9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3087,7 +3087,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp=
_t gfp, int order)
 		ret =3D __memcg_kmem_charge(memcg, gfp, 1 << order);
 		if (!ret) {
 			set_page_memcg(page, memcg);
-			__SetPageKmemcg(page);
+			__SetPageMemcgKmem(page);
 			return 0;
 		}
 		css_put(&memcg->css);
@@ -3112,10 +3112,6 @@ void __memcg_kmem_uncharge_page(struct page *page,=
 int order)
 	__memcg_kmem_uncharge(memcg, nr_pages);
 	clear_page_memcg(page);
 	css_put(&memcg->css);
-
-	/* slab pages do not have PageKmemcg flag set */
-	if (PageKmemcg(page))
-		__ClearPageKmemcg(page);
 }
=20
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_=
bytes)
@@ -6896,12 +6892,10 @@ static void uncharge_page(struct page *page, stru=
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
 	clear_page_memcg(page);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 377d65f25d7d..b70911cb9879 100644
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


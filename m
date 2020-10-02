Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520F828192B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388307AbgJBR0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:26:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32406 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388219AbgJBR0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:26:08 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 092HEW24017232
        for <linux-kernel@vger.kernel.org>; Fri, 2 Oct 2020 10:26:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=l1tkVR7FIxY7yu4rFMtlPopAY7rcxWQQ8dOmIsWQsOY=;
 b=Xj5N3CbUE2jYjk83Fzwic6zPD+AtZCnf0iUDddDtpOppRjlJY3MSZDfKh4wOvaLe4hAW
 pzNalBkkm0ggmookIGmYRPGDW8cZKBx4akspYpoOMbe46vfA4XcL+poEoGt0z0IekKkZ
 VnR+/FxtpHRJ2hBAGQ27Bgm7lHreXX35C6A= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33x6gu8tck-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 10:26:06 -0700
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 2 Oct 2020 10:26:04 -0700
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id C7224F152A3; Fri,  2 Oct 2020 10:26:00 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v5 4/4] mm: convert page kmemcg type to a page memcg flag
Date:   Fri, 2 Oct 2020 10:25:59 -0700
Message-ID: <20201002172559.4000748-5-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201002172559.4000748-1-guro@fb.com>
References: <20201002172559.4000748-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-02_11:2020-10-02,2020-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=884 spamscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 suspectscore=2 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2010020129
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
PageMemcgKmem() and an open-coded OR operation setting the memcg
pointer with the MEMCG_DATA_KMEM bit. __ClearPageKmemcg() can be
simple deleted, as the whole memcg_data is zeroed at once.

As a bonus, on !CONFIG_MEMCG build the PageMemcgKmem() check will
be compiled out.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 cover.txt                  |  4 ++--
 include/linux/memcontrol.h | 37 +++++++++++++++++++++++++++++++++----
 include/linux/page-flags.h | 11 ++---------
 mm/memcontrol.c            | 16 +++++-----------
 mm/page_alloc.c            |  4 ++--
 5 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/cover.txt b/cover.txt
index 32460cd3316e..cf23753cad15 100644
--- a/cover.txt
+++ b/cover.txt
@@ -15,10 +15,10 @@ their memory can't be accounted because of this imple=
mentation detail.
=20
 This patchset removes this limitation by moving the PageKmemcg flag
 into one of the free bits of the page->mem_cgroup pointer. Also it
-formalizes all accesses to the page->mem_cgroup and page->obj_cgroups
+formalizes accesses to the page->mem_cgroup and page->obj_cgroups
 using new helpers, adds several checks and removes a couple of obsolete
 functions. As the result the code became more robust with fewer
-open-coded bits tricks.
+open-coded bit tricks.
=20
 v5:
   - added ~MEMCG_DATA_FLAGS_MASK to page_memcg_rcu(), by Michal
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 99a4841d658b..7c9d43476166 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -346,8 +346,10 @@ extern struct mem_cgroup *root_mem_cgroup;
 enum page_memcg_data_flags {
 	/* page->memcg_data is a pointer to an objcgs vector */
 	MEMCG_DATA_OBJCGS =3D (1UL << 0),
+	/* page has been accounted as a non-slab kernel page */
+	MEMCG_DATA_KMEM =3D (1UL << 1),
 	/* the next bit after the last actual flag */
-	__NR_MEMCG_DATA_FLAGS  =3D (1UL << 1),
+	__NR_MEMCG_DATA_FLAGS  =3D (1UL << 2),
 };
=20
 #define MEMCG_DATA_FLAGS_MASK (__NR_MEMCG_DATA_FLAGS - 1)
@@ -369,8 +371,12 @@ enum page_memcg_data_flags {
  */
 static inline struct mem_cgroup *page_memcg(struct page *page)
 {
+	unsigned long memcg_data =3D page->memcg_data;
+
 	VM_BUG_ON_PAGE(PageSlab(page), page);
-	return (struct mem_cgroup *)page->memcg_data;
+	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
+
+	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
=20
 /*
@@ -387,7 +393,8 @@ static inline struct mem_cgroup *page_memcg_rcu(struc=
t page *page)
 	VM_BUG_ON_PAGE(PageSlab(page), page);
 	WARN_ON_ONCE(!rcu_read_lock_held());
=20
-	return (struct mem_cgroup *)READ_ONCE(page->memcg_data);
+	return (struct mem_cgroup *)(READ_ONCE(page->memcg_data) &
+				     ~MEMCG_DATA_FLAGS_MASK);
 }
=20
 /*
@@ -416,7 +423,21 @@ static inline struct mem_cgroup *page_memcg_check(st=
ruct page *page)
 	if (memcg_data & MEMCG_DATA_OBJCGS)
 		return NULL;
=20
-	return (struct mem_cgroup *)memcg_data;
+	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+}
+
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
+	VM_BUG_ON_PAGE(page->memcg_data & MEMCG_DATA_OBJCGS, page);
+	return page->memcg_data & MEMCG_DATA_KMEM;
 }
=20
 #ifdef CONFIG_MEMCG_KMEM
@@ -435,6 +456,7 @@ static inline struct obj_cgroup **page_objcgs(struct =
page *page)
 	unsigned long memcg_data =3D READ_ONCE(page->memcg_data);
=20
 	VM_BUG_ON_PAGE(memcg_data && !(memcg_data & MEMCG_DATA_OBJCGS), page);
+	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, page);
=20
 	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
@@ -454,6 +476,8 @@ static inline struct obj_cgroup **page_objcgs_check(s=
truct page *page)
 	if (!memcg_data || !(memcg_data & MEMCG_DATA_OBJCGS))
 		return NULL;
=20
+	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, page);
+
 	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
=20
@@ -1109,6 +1133,11 @@ static inline struct mem_cgroup *page_memcg_check(=
struct page *page)
 	return NULL;
 }
=20
+static inline bool PageMemcgKmem(struct page *page)
+{
+	return false;
+}
+
 static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
 {
 	return true;
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4f6ba9379112..fc0e1bd48e73 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -715,9 +715,8 @@ PAGEFLAG_FALSE(DoubleMap)
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
@@ -768,12 +767,6 @@ PAGE_TYPE_OPS(Buddy, buddy)
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
index a8eb20283dcd..e3fc240101ff 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3090,8 +3090,8 @@ int __memcg_kmem_charge_page(struct page *page, gfp=
_t gfp, int order)
 	if (memcg && !mem_cgroup_is_root(memcg)) {
 		ret =3D __memcg_kmem_charge(memcg, gfp, 1 << order);
 		if (!ret) {
-			page->memcg_data =3D (unsigned long)memcg;
-			__SetPageKmemcg(page);
+			page->memcg_data =3D (unsigned long)memcg |
+				MEMCG_DATA_KMEM;
 			return 0;
 		}
 		css_put(&memcg->css);
@@ -3116,10 +3116,6 @@ void __memcg_kmem_uncharge_page(struct page *page,=
 int order)
 	__memcg_kmem_uncharge(memcg, nr_pages);
 	page->memcg_data =3D 0;
 	css_put(&memcg->css);
-
-	/* slab pages do not have PageKmemcg flag set */
-	if (PageKmemcg(page))
-		__ClearPageKmemcg(page);
 }
=20
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_=
bytes)
@@ -6863,12 +6859,10 @@ static void uncharge_page(struct page *page, stru=
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
 	page->memcg_data =3D 0;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e9f0fe4a143e..5ebd50183d93 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1179,7 +1179,7 @@ static __always_inline bool free_pages_prepare(stru=
ct page *page,
 		 * Do not let hwpoison pages hit pcplists/buddy
 		 * Untie memcg state and reset page's owner
 		 */
-		if (memcg_kmem_enabled() && PageKmemcg(page))
+		if (memcg_kmem_enabled() && PageMemcgKmem(page))
 			__memcg_kmem_uncharge_page(page, order);
 		reset_page_owner(page, order);
 		return false;
@@ -1209,7 +1209,7 @@ static __always_inline bool free_pages_prepare(stru=
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


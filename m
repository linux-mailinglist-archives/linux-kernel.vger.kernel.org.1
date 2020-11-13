Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5C32B13B6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 02:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgKMBMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 20:12:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgKMBMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 20:12:41 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3D9E216C4;
        Fri, 13 Nov 2020 01:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605229960;
        bh=o0IqKrqlUm9rsrEKhbQDRYDb/kwkh0twQ4jVI7TjfLc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PWTfj3iqj8Gr8cnGKSFZTMCB+6fY4qsJ8ptSoVbHd1IEw4b/btJMMfWioGdzfg/zv
         WGPaDKECoaB6Zxq0waGoVqN2sDKAp3bEOcPk5ORIvvQ2Jh/mbFSebVoxTRXH2QsgUt
         JIsa5kvHUQbnLCyolERQagFXGta9wHxG9hkN+3G8=
Date:   Thu, 12 Nov 2020 17:12:39 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH 2/2] mm: memcg/slab: pre-allocate obj_cgroups for slab
 caches with SLAB_ACCOUNT
Message-Id: <20201112171239.4f8ef107f741c3462556731f@linux-foundation.org>
In-Reply-To: <20201113001926.GA2934489@carbon.dhcp.thefacebook.com>
References: <20201110195753.530157-1-guro@fb.com>
        <20201110195753.530157-2-guro@fb.com>
        <20201112162303.GB873621@cmpxchg.org>
        <20201113001926.GA2934489@carbon.dhcp.thefacebook.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020 16:19:26 -0800 Roman Gushchin <guro@fb.com> wrote:

> >From 8b28d91475d54c552e503e66f169e1e00475c856 Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <guro@fb.com>
> Date: Wed, 16 Sep 2020 15:43:48 -0700
> Subject: [PATCH v2 2/2] mm: memcg/slab: pre-allocate obj_cgroups for slab
>  caches with SLAB_ACCOUNT
> 
> In general it's unknown in advance if a slab page will contain
> accounted objects or not. In order to avoid memory waste, an
> obj_cgroup vector is allocated dynamically when a need to account
> of a new object arises. Such approach is memory efficient, but
> requires an expensive cmpxchg() to set up the memcg/objcgs pointer,
> because an allocation can race with a different allocation on another
> cpu.
> 
> But in some common cases it's known for sure that a slab page will
> contain accounted objects: if the page belongs to a slab cache with a
> SLAB_ACCOUNT flag set. It includes such popular objects like
> vm_area_struct, anon_vma, task_struct, etc.
> 
> In such cases we can pre-allocate the objcgs vector and simple assign
> it to the page without any atomic operations, because at this early
> stage the page is not visible to anyone else.
> 
> v2: inline set_page_objcgs() and add some comments, by Johannes

Had me confused!  I was looking for the inlined function
set_page_objcgs().  I think "open-code" is a better term here than
"inline".

Here's the -fix:

From: Roman Gushchin <guro@fb.com>
Subject: mm-memcg-slab-pre-allocate-obj_cgroups-for-slab-caches-with-slab_account-v2

open-code set_page_objcgs() and add some comments, by Johannes

Link: https://lkml.kernel.org/r/20201113001926.GA2934489@carbon.dhcp.thefacebook.com
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/memcontrol.h |   25 -------------------------
 mm/memcontrol.c            |   23 +++++++++++++++++++----
 mm/slab.h                  |    8 ++++----
 3 files changed, 23 insertions(+), 33 deletions(-)

--- a/include/linux/memcontrol.h~mm-memcg-slab-pre-allocate-obj_cgroups-for-slab-caches-with-slab_account-v2
+++ a/include/linux/memcontrol.h
@@ -480,25 +480,6 @@ static inline struct obj_cgroup **page_o
 	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
 
-/*
- * set_page_objcgs - associate a page with a object cgroups vector
- * @page: a pointer to the page struct
- * @objcgs: a pointer to the object cgroups vector
- * @atomic: save the value atomically
- *
- * Atomically associates a page with a vector of object cgroups.
- */
-static inline bool set_page_objcgs(struct page *page,
-				   struct obj_cgroup **objcgs, bool atomic)
-{
-	unsigned long memcg_data = (unsigned long) objcgs | MEMCG_DATA_OBJCGS;
-
-	if (atomic)
-		return !cmpxchg(&page->memcg_data, 0, memcg_data);
-
-	page->memcg_data = memcg_data;
-	return true;
-}
 #else
 static inline struct obj_cgroup **page_objcgs(struct page *page)
 {
@@ -509,12 +490,6 @@ static inline struct obj_cgroup **page_o
 {
 	return NULL;
 }
-
-static inline bool set_page_objcgs(struct page *page,
-				   struct obj_cgroup **objcgs, bool atomic)
-{
-	return true;
-}
 #endif
 
 static __always_inline bool memcg_stat_item_in_bytes(int idx)
--- a/mm/memcontrol.c~mm-memcg-slab-pre-allocate-obj_cgroups-for-slab-caches-with-slab_account-v2
+++ a/mm/memcontrol.c
@@ -2879,9 +2879,10 @@ static void commit_charge(struct page *p
 
 #ifdef CONFIG_MEMCG_KMEM
 int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
-				 gfp_t gfp, bool atomic)
+				 gfp_t gfp, bool new_page)
 {
 	unsigned int objects = objs_per_slab_page(s, page);
+	unsigned long memcg_data;
 	void *vec;
 
 	vec = kcalloc_node(objects, sizeof(struct obj_cgroup *), gfp,
@@ -2889,11 +2890,25 @@ int memcg_alloc_page_obj_cgroups(struct
 	if (!vec)
 		return -ENOMEM;
 
-	if (!set_page_objcgs(page, vec, atomic))
+	memcg_data = (unsigned long) vec | MEMCG_DATA_OBJCGS;
+	if (new_page) {
+		/*
+		 * If the slab page is brand new and nobody can yet access
+		 * it's memcg_data, no synchronization is required and
+		 * memcg_data can be simply assigned.
+		 */
+		page->memcg_data = memcg_data;
+	} else if (cmpxchg(&page->memcg_data, 0, memcg_data)) {
+		/*
+		 * If the slab page is already in use, somebody can allocate
+		 * and assign obj_cgroups in parallel. In this case the existing
+		 * objcg vector should be reused.
+		 */
 		kfree(vec);
-	else
-		kmemleak_not_leak(vec);
+		return 0;
+	}
 
+	kmemleak_not_leak(vec);
 	return 0;
 }
 
--- a/mm/slab.h~mm-memcg-slab-pre-allocate-obj_cgroups-for-slab-caches-with-slab_account-v2
+++ a/mm/slab.h
@@ -240,7 +240,7 @@ static inline bool kmem_cache_debug_flag
 
 #ifdef CONFIG_MEMCG_KMEM
 int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
-				 gfp_t gfp, bool atomic);
+				 gfp_t gfp, bool new_page);
 
 static inline void memcg_free_page_obj_cgroups(struct page *page)
 {
@@ -308,7 +308,7 @@ static inline void memcg_slab_post_alloc
 
 			if (!page_objcgs(page) &&
 			    memcg_alloc_page_obj_cgroups(page, s, flags,
-							 true)) {
+							 false)) {
 				obj_cgroup_uncharge(objcg, obj_full_size(s));
 				continue;
 			}
@@ -373,7 +373,7 @@ static inline struct mem_cgroup *memcg_f
 
 static inline int memcg_alloc_page_obj_cgroups(struct page *page,
 					       struct kmem_cache *s, gfp_t gfp,
-					       bool atomic)
+					       bool new_page)
 {
 	return 0;
 }
@@ -418,7 +418,7 @@ static __always_inline void account_slab
 					      gfp_t gfp)
 {
 	if (memcg_kmem_enabled() && (s->flags & SLAB_ACCOUNT))
-		memcg_alloc_page_obj_cgroups(page, s, gfp, false);
+		memcg_alloc_page_obj_cgroups(page, s, gfp, true);
 
 	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
 			    PAGE_SIZE << order);
_


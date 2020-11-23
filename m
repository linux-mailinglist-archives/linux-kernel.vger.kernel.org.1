Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717292C15CB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgKWUIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729407AbgKWUIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:08:32 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3F9C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:08:31 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id ca17so13759735qvb.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=oHPieWHdViYG32GgdeSm81KitfvarR2p95gDiix5nJo=;
        b=CS4//VJhWpsHcGIOw83wje8ok3eG9XkdKpk4aDbMVLmtgbzCuS1stHKlPovRPdR+lK
         9cc4y1wmvaidX6tcwDELTihho29AKSfTpmwagIk/NrC40+YnymDmYu9VIwJL2Lz1BU3S
         5NodhzJcGyu5jCrU7yw5VR5jTrAhZaWV22lQV/NPN8MbTgHgBqKK3XFAqXPT0UBEuC4C
         Q5XJa2GNgojYyCr8hX0mltb8Fh4qiLf6gq2rEVMS1iRZmBGQPCYJ+7ttZ3NhT/TC6Teu
         7NnRzFyJRvlQt7PlweWKYccXtpl0d+xj9GXYnijccd9Syein5DRH+04WzaHKgXu2H1ro
         cTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oHPieWHdViYG32GgdeSm81KitfvarR2p95gDiix5nJo=;
        b=ZmmuQrIEqBBT+kPHNEQlMeA/U1tWbi83Tynjbi6h0h30KiCPAqEf0phqDLFozf6scq
         +A/et4UohMwwU3red6Py9MBTqH/WP+AtplVrCUfjVOOQUOu5HJdjxiFEvuAU+Qn56UUC
         xmRuf9hrUbMgM2/pWz1ZNfSGjOCcidk7qAoWKpoAIjNKhuBBGTswUNJGbfEkHNL/r0ZO
         SScClyj+9Zkm1GNHaHH1UHBncTVhNfAoRCOCx2js7PF9bUc/b/T8M+66exXIkmx8HWwQ
         1JZVoELeQ3qDdJZhRAL/7UoQIaTRjTfO5JdpWtemUoiASI5u6aV/Q98Q9YDvPJ6Bn+Ek
         /Htg==
X-Gm-Message-State: AOAM530Tdvyj6hfFMIwjWr2h8NS9mlPsUqQdVhnfv2EtWFE9RRA5e/2F
        HL+vKi02bgaKURm6z0yaa+io6MN6K4CfMqyf
X-Google-Smtp-Source: ABdhPJxee5o2BXNr9+/cDm0AG3Nnk8qitF6/0hlLvCRwfAwCnr82amtfrl51RHINWE/XVhn4H8GuPgbzR8gskDNl
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:e50a:: with SMTP id
 l10mr1212845qvm.55.1606162111097; Mon, 23 Nov 2020 12:08:31 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:07:29 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <fccdcaa13dc6b2211bf363d6c6d499279a54fe3a.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 05/42] kasan: rename (un)poison_shadow to (un)poison_range
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

The new mode won't be using shadow memory. Rename external annotation
kasan_unpoison_shadow() to kasan_unpoison_range(), and introduce internal
functions (un)poison_range() (without kasan_ prefix).

Co-developed-by: Marco Elver <elver@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
Change-Id: Ia359f32815242c4704e49a5f1639ca2d2f8cba69
---
 include/linux/kasan.h |  6 +++---
 kernel/fork.c         |  4 ++--
 mm/kasan/common.c     | 49 ++++++++++++++++++++++++-------------------
 mm/kasan/generic.c    | 23 ++++++++++----------
 mm/kasan/kasan.h      |  3 ++-
 mm/kasan/tags.c       |  2 +-
 mm/slab_common.c      |  2 +-
 7 files changed, 47 insertions(+), 42 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 26f2ab92e7ca..d237051dca58 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -71,7 +71,7 @@ extern void kasan_enable_current(void);
 /* Disable reporting bugs for current task */
 extern void kasan_disable_current(void);
 
-void kasan_unpoison_shadow(const void *address, size_t size);
+void kasan_unpoison_range(const void *address, size_t size);
 
 void kasan_unpoison_task_stack(struct task_struct *task);
 
@@ -108,7 +108,7 @@ struct kasan_cache {
 size_t __ksize(const void *);
 static inline void kasan_unpoison_slab(const void *ptr)
 {
-	kasan_unpoison_shadow(ptr, __ksize(ptr));
+	kasan_unpoison_range(ptr, __ksize(ptr));
 }
 size_t kasan_metadata_size(struct kmem_cache *cache);
 
@@ -117,7 +117,7 @@ void kasan_restore_multi_shot(bool enabled);
 
 #else /* CONFIG_KASAN */
 
-static inline void kasan_unpoison_shadow(const void *address, size_t size) {}
+static inline void kasan_unpoison_range(const void *address, size_t size) {}
 
 static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
 
diff --git a/kernel/fork.c b/kernel/fork.c
index c2b3828881fb..3ddd78885a5a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -225,8 +225,8 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 		if (!s)
 			continue;
 
-		/* Clear the KASAN shadow of the stack. */
-		kasan_unpoison_shadow(s->addr, THREAD_SIZE);
+		/* Mark stack accessible for KASAN. */
+		kasan_unpoison_range(s->addr, THREAD_SIZE);
 
 		/* Clear stale pointers from reused stack. */
 		memset(s->addr, 0, THREAD_SIZE);
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index f5739be60edc..6adbf5891aff 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -109,7 +109,7 @@ void *memcpy(void *dest, const void *src, size_t len)
  * Poisons the shadow memory for 'size' bytes starting from 'addr'.
  * Memory addresses should be aligned to KASAN_SHADOW_SCALE_SIZE.
  */
-void kasan_poison_shadow(const void *address, size_t size, u8 value)
+void poison_range(const void *address, size_t size, u8 value)
 {
 	void *shadow_start, *shadow_end;
 
@@ -130,7 +130,7 @@ void kasan_poison_shadow(const void *address, size_t size, u8 value)
 	__memset(shadow_start, value, shadow_end - shadow_start);
 }
 
-void kasan_unpoison_shadow(const void *address, size_t size)
+void unpoison_range(const void *address, size_t size)
 {
 	u8 tag = get_tag(address);
 
@@ -149,7 +149,7 @@ void kasan_unpoison_shadow(const void *address, size_t size)
 	if (is_kfence_address(address))
 		return;
 
-	kasan_poison_shadow(address, size, tag);
+	poison_range(address, size, tag);
 
 	if (size & KASAN_SHADOW_MASK) {
 		u8 *shadow = (u8 *)kasan_mem_to_shadow(address + size);
@@ -161,12 +161,17 @@ void kasan_unpoison_shadow(const void *address, size_t size)
 	}
 }
 
+void kasan_unpoison_range(const void *address, size_t size)
+{
+	unpoison_range(address, size);
+}
+
 static void __kasan_unpoison_stack(struct task_struct *task, const void *sp)
 {
 	void *base = task_stack_page(task);
 	size_t size = sp - base;
 
-	kasan_unpoison_shadow(base, size);
+	unpoison_range(base, size);
 }
 
 /* Unpoison the entire stack for a task. */
@@ -185,7 +190,7 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
 	 */
 	void *base = (void *)((unsigned long)watermark & ~(THREAD_SIZE - 1));
 
-	kasan_unpoison_shadow(base, watermark - base);
+	unpoison_range(base, watermark - base);
 }
 
 void kasan_alloc_pages(struct page *page, unsigned int order)
@@ -199,13 +204,13 @@ void kasan_alloc_pages(struct page *page, unsigned int order)
 	tag = random_tag();
 	for (i = 0; i < (1 << order); i++)
 		page_kasan_tag_set(page + i, tag);
-	kasan_unpoison_shadow(page_address(page), PAGE_SIZE << order);
+	unpoison_range(page_address(page), PAGE_SIZE << order);
 }
 
 void kasan_free_pages(struct page *page, unsigned int order)
 {
 	if (likely(!PageHighMem(page)))
-		kasan_poison_shadow(page_address(page),
+		poison_range(page_address(page),
 				PAGE_SIZE << order,
 				KASAN_FREE_PAGE);
 }
@@ -297,18 +302,18 @@ void kasan_poison_slab(struct page *page)
 
 	for (i = 0; i < compound_nr(page); i++)
 		page_kasan_tag_reset(page + i);
-	kasan_poison_shadow(page_address(page), page_size(page),
-			KASAN_KMALLOC_REDZONE);
+	poison_range(page_address(page), page_size(page),
+		     KASAN_KMALLOC_REDZONE);
 }
 
 void kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
 {
-	kasan_unpoison_shadow(object, cache->object_size);
+	unpoison_range(object, cache->object_size);
 }
 
 void kasan_poison_object_data(struct kmem_cache *cache, void *object)
 {
-	kasan_poison_shadow(object,
+	poison_range(object,
 			round_up(cache->object_size, KASAN_SHADOW_SCALE_SIZE),
 			KASAN_KMALLOC_REDZONE);
 }
@@ -424,7 +429,7 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 	}
 
 	rounded_up_size = round_up(cache->object_size, KASAN_SHADOW_SCALE_SIZE);
-	kasan_poison_shadow(object, rounded_up_size, KASAN_KMALLOC_FREE);
+	poison_range(object, rounded_up_size, KASAN_KMALLOC_FREE);
 
 	if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine) ||
 			unlikely(!(cache->flags & SLAB_KASAN)))
@@ -467,9 +472,9 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
 		tag = assign_tag(cache, object, false, keep_tag);
 
 	/* Tag is ignored in set_tag without CONFIG_KASAN_SW_TAGS */
-	kasan_unpoison_shadow(set_tag(object, tag), size);
-	kasan_poison_shadow((void *)redzone_start, redzone_end - redzone_start,
-		KASAN_KMALLOC_REDZONE);
+	unpoison_range(set_tag(object, tag), size);
+	poison_range((void *)redzone_start, redzone_end - redzone_start,
+		     KASAN_KMALLOC_REDZONE);
 
 	if (cache->flags & SLAB_KASAN)
 		kasan_set_track(&get_alloc_info(cache, object)->alloc_track, flags);
@@ -508,9 +513,9 @@ void * __must_check kasan_kmalloc_large(const void *ptr, size_t size,
 				KASAN_SHADOW_SCALE_SIZE);
 	redzone_end = (unsigned long)ptr + page_size(page);
 
-	kasan_unpoison_shadow(ptr, size);
-	kasan_poison_shadow((void *)redzone_start, redzone_end - redzone_start,
-		KASAN_PAGE_REDZONE);
+	unpoison_range(ptr, size);
+	poison_range((void *)redzone_start, redzone_end - redzone_start,
+		     KASAN_PAGE_REDZONE);
 
 	return (void *)ptr;
 }
@@ -542,7 +547,7 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
 			kasan_report_invalid_free(ptr, ip);
 			return;
 		}
-		kasan_poison_shadow(ptr, page_size(page), KASAN_FREE_PAGE);
+		poison_range(ptr, page_size(page), KASAN_FREE_PAGE);
 	} else {
 		__kasan_slab_free(page->slab_cache, ptr, ip, false);
 	}
@@ -728,7 +733,7 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
 	 * // vmalloc() allocates memory
 	 * // let a = area->addr
 	 * // we reach kasan_populate_vmalloc
-	 * // and call kasan_unpoison_shadow:
+	 * // and call unpoison_range:
 	 * STORE shadow(a), unpoison_val
 	 * ...
 	 * STORE shadow(a+99), unpoison_val	x = LOAD p
@@ -763,7 +768,7 @@ void kasan_poison_vmalloc(const void *start, unsigned long size)
 		return;
 
 	size = round_up(size, KASAN_SHADOW_SCALE_SIZE);
-	kasan_poison_shadow(start, size, KASAN_VMALLOC_INVALID);
+	poison_range(start, size, KASAN_VMALLOC_INVALID);
 }
 
 void kasan_unpoison_vmalloc(const void *start, unsigned long size)
@@ -771,7 +776,7 @@ void kasan_unpoison_vmalloc(const void *start, unsigned long size)
 	if (!is_vmalloc_or_module_addr(start))
 		return;
 
-	kasan_unpoison_shadow(start, size);
+	unpoison_range(start, size);
 }
 
 static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index d6a386255007..cdc2d8112f3e 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -203,11 +203,11 @@ static void register_global(struct kasan_global *global)
 {
 	size_t aligned_size = round_up(global->size, KASAN_SHADOW_SCALE_SIZE);
 
-	kasan_unpoison_shadow(global->beg, global->size);
+	unpoison_range(global->beg, global->size);
 
-	kasan_poison_shadow(global->beg + aligned_size,
-		global->size_with_redzone - aligned_size,
-		KASAN_GLOBAL_REDZONE);
+	poison_range(global->beg + aligned_size,
+		     global->size_with_redzone - aligned_size,
+		     KASAN_GLOBAL_REDZONE);
 }
 
 void __asan_register_globals(struct kasan_global *globals, size_t size)
@@ -286,13 +286,12 @@ void __asan_alloca_poison(unsigned long addr, size_t size)
 
 	WARN_ON(!IS_ALIGNED(addr, KASAN_ALLOCA_REDZONE_SIZE));
 
-	kasan_unpoison_shadow((const void *)(addr + rounded_down_size),
-			      size - rounded_down_size);
-	kasan_poison_shadow(left_redzone, KASAN_ALLOCA_REDZONE_SIZE,
-			KASAN_ALLOCA_LEFT);
-	kasan_poison_shadow(right_redzone,
-			padding_size + KASAN_ALLOCA_REDZONE_SIZE,
-			KASAN_ALLOCA_RIGHT);
+	unpoison_range((const void *)(addr + rounded_down_size),
+		       size - rounded_down_size);
+	poison_range(left_redzone, KASAN_ALLOCA_REDZONE_SIZE,
+		     KASAN_ALLOCA_LEFT);
+	poison_range(right_redzone, padding_size + KASAN_ALLOCA_REDZONE_SIZE,
+		     KASAN_ALLOCA_RIGHT);
 }
 EXPORT_SYMBOL(__asan_alloca_poison);
 
@@ -302,7 +301,7 @@ void __asan_allocas_unpoison(const void *stack_top, const void *stack_bottom)
 	if (unlikely(!stack_top || stack_top > stack_bottom))
 		return;
 
-	kasan_unpoison_shadow(stack_top, stack_bottom - stack_top);
+	unpoison_range(stack_top, stack_bottom - stack_top);
 }
 EXPORT_SYMBOL(__asan_allocas_unpoison);
 
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index ac499456740f..42ab02c61331 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -150,7 +150,8 @@ static inline bool addr_has_shadow(const void *addr)
 	return (addr >= kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
 }
 
-void kasan_poison_shadow(const void *address, size_t size, u8 value);
+void poison_range(const void *address, size_t size, u8 value);
+void unpoison_range(const void *address, size_t size);
 
 /**
  * check_memory_region - Check memory region, and report if invalid access.
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 5c8b08a25715..c0b3f327812b 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -153,7 +153,7 @@ EXPORT_SYMBOL(__hwasan_storeN_noabort);
 
 void __hwasan_tag_memory(unsigned long addr, u8 tag, unsigned long size)
 {
-	kasan_poison_shadow((void *)addr, size, tag);
+	poison_range((void *)addr, size, tag);
 }
 EXPORT_SYMBOL(__hwasan_tag_memory);
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 479d17b90155..0b5ae1819a8b 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1179,7 +1179,7 @@ size_t ksize(const void *objp)
 	 * We assume that ksize callers could use whole allocated area,
 	 * so we need to unpoison this area.
 	 */
-	kasan_unpoison_shadow(objp, size);
+	kasan_unpoison_range(objp, size);
 	return size;
 }
 EXPORT_SYMBOL(ksize);
-- 
2.29.2.454.gaff20da3a2-goog


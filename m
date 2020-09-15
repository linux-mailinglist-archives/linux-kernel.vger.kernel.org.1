Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D3C26AFA3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgIOVes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgIOVQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:16:47 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8432DC061352
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:16:40 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id k14so3122551qvw.20
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=m6D7dHkvwjdaFH4BtYThp4DoX0Pg+nOZ+Zx/xU3JNr8=;
        b=IRThtfw2OiVC/m3IJTgy76Tzhg5Mym+zib7RMc7Bs0Hkd8E82Tm/LGu1Kvz8+2qMX3
         5B9BGWWr78IfkImvG5IOUU2TjzMH5to0dZWi0bJ5Q+JTBfCh4lMfPlAGSqi647lkVoRL
         LngBQwbLWdt6lIKo6CHcAWcCwddFh/VqWgI/4zNYBLo49HwbqvREsNDAQ0UhkRLVbO2K
         JdbK8iEAX1Oh7E4Jes8QBeEaYhmU5hCMWq6+U5DZNHyMPL+J6kmIm0la+pM5/TXbu/t9
         e7HX3W15sDklcF0LBPFX1RPndBMuu45LO391X8XKdBb9mZG1f95PUWaihH7fjueOK1sY
         MpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m6D7dHkvwjdaFH4BtYThp4DoX0Pg+nOZ+Zx/xU3JNr8=;
        b=obTikv6+Jz8wc/OjWL8sMGsuYKGWzRJRckUBPYsT7h1DcWxw2NE6Xh9m1BVKcAmtuJ
         6dVwv58/19WRd/eBX1IUzbF+Kt30QFKWWKcASO6o+DUy9intntydxkPpO6HatPPowM+U
         gBOX2kqGUgBCAPDLFVoi+54tsLB8t9nLfVUTU/flYW0VPNM71uyFvE94EzTlfBgeipcD
         x2HBXT1LT1nMzI2eMd6XxDaJzJOcY9lKHDDGUTURxc7MBrw2aat+f9K1gWNY28IgnJjY
         UIhQRd20mUOlPrgO9ICR4LIIw/hCXm9cH3Cs/M9IH6hPfUrvpiILnvePFLFp+n3kCvZy
         b9xQ==
X-Gm-Message-State: AOAM532e9YhdJ6kZnVOWmU4rgNAHqZ30Mt36xztCrXdeS2SyfM8FRvO6
        veP2yxr6eK24vW/YeiqHqXxfKB1MgbiRpvNZ
X-Google-Smtp-Source: ABdhPJwC+Bac8VFkog5L58LOv2hGQgomm6AuwXpqTDU77SgWeP1xZ0tIBdWT4dAbTqMtUMbz8YPno45uXQXdXA6f
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:f6c4:: with SMTP id
 d4mr3785883qvo.41.1600204599606; Tue, 15 Sep 2020 14:16:39 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:15:49 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <88c275dc4eef13c8bcbe74ecec661733dcbc67b8.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 07/37] kasan: split out shadow.c from common.c
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

The new mode won't be using shadow memory. Move all shadow-related code
to shadow.c, which is only enabled for software KASAN modes that use
shadow memory.

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
Change-Id: Ic1c32ce72d4649848e9e6a1f2c8dd269c77673f2
---
 mm/kasan/Makefile |   6 +-
 mm/kasan/common.c | 486 +------------------------------------------
 mm/kasan/shadow.c | 509 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 514 insertions(+), 487 deletions(-)
 create mode 100644 mm/kasan/shadow.c

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index 7cf685bb51bd..7cc1031e1ef8 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -10,6 +10,7 @@ CFLAGS_REMOVE_generic_report.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_init.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_quarantine.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_shadow.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_tags.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_tags_report.o = $(CC_FLAGS_FTRACE)
 
@@ -26,9 +27,10 @@ CFLAGS_generic_report.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_init.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_quarantine.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_report.o := $(CC_FLAGS_KASAN_RUNTIME)
+CFLAGS_shadow.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_tags_report.o := $(CC_FLAGS_KASAN_RUNTIME)
 
 obj-$(CONFIG_KASAN) := common.o report.o
-obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o generic_report.o quarantine.o
-obj-$(CONFIG_KASAN_SW_TAGS) += init.o tags.o tags_report.o
+obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o generic_report.o shadow.o quarantine.o
+obj-$(CONFIG_KASAN_SW_TAGS) += init.o shadow.o tags.o tags_report.o
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index c9daf2c33651..43a927e70067 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * This file contains common generic and tag-based KASAN code.
+ * This file contains common KASAN code.
  *
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  * Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
@@ -18,7 +18,6 @@
 #include <linux/init.h>
 #include <linux/kasan.h>
 #include <linux/kernel.h>
-#include <linux/kmemleak.h>
 #include <linux/linkage.h>
 #include <linux/memblock.h>
 #include <linux/memory.h>
@@ -31,12 +30,8 @@
 #include <linux/stacktrace.h>
 #include <linux/string.h>
 #include <linux/types.h>
-#include <linux/vmalloc.h>
 #include <linux/bug.h>
 
-#include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
-
 #include "kasan.h"
 #include "../slab.h"
 
@@ -66,93 +61,6 @@ void kasan_disable_current(void)
 	current->kasan_depth--;
 }
 
-bool __kasan_check_read(const volatile void *p, unsigned int size)
-{
-	return check_memory_region((unsigned long)p, size, false, _RET_IP_);
-}
-EXPORT_SYMBOL(__kasan_check_read);
-
-bool __kasan_check_write(const volatile void *p, unsigned int size)
-{
-	return check_memory_region((unsigned long)p, size, true, _RET_IP_);
-}
-EXPORT_SYMBOL(__kasan_check_write);
-
-#undef memset
-void *memset(void *addr, int c, size_t len)
-{
-	if (!check_memory_region((unsigned long)addr, len, true, _RET_IP_))
-		return NULL;
-
-	return __memset(addr, c, len);
-}
-
-#ifdef __HAVE_ARCH_MEMMOVE
-#undef memmove
-void *memmove(void *dest, const void *src, size_t len)
-{
-	if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
-	    !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
-		return NULL;
-
-	return __memmove(dest, src, len);
-}
-#endif
-
-#undef memcpy
-void *memcpy(void *dest, const void *src, size_t len)
-{
-	if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
-	    !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
-		return NULL;
-
-	return __memcpy(dest, src, len);
-}
-
-/*
- * Poisons the shadow memory for 'size' bytes starting from 'addr'.
- * Memory addresses should be aligned to KASAN_GRANULE_SIZE.
- */
-void kasan_poison_memory(const void *address, size_t size, u8 value)
-{
-	void *shadow_start, *shadow_end;
-
-	/*
-	 * Perform shadow offset calculation based on untagged address, as
-	 * some of the callers (e.g. kasan_poison_object_data) pass tagged
-	 * addresses to this function.
-	 */
-	address = reset_tag(address);
-
-	shadow_start = kasan_mem_to_shadow(address);
-	shadow_end = kasan_mem_to_shadow(address + size);
-
-	__memset(shadow_start, value, shadow_end - shadow_start);
-}
-
-void kasan_unpoison_memory(const void *address, size_t size)
-{
-	u8 tag = get_tag(address);
-
-	/*
-	 * Perform shadow offset calculation based on untagged address, as
-	 * some of the callers (e.g. kasan_unpoison_object_data) pass tagged
-	 * addresses to this function.
-	 */
-	address = reset_tag(address);
-
-	kasan_poison_memory(address, size, tag);
-
-	if (size & KASAN_GRANULE_MASK) {
-		u8 *shadow = (u8 *)kasan_mem_to_shadow(address + size);
-
-		if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
-			*shadow = tag;
-		else
-			*shadow = size & KASAN_GRANULE_MASK;
-	}
-}
-
 static void __kasan_unpoison_stack(struct task_struct *task, const void *sp)
 {
 	void *base = task_stack_page(task);
@@ -540,395 +448,3 @@ void kasan_kfree_large(void *ptr, unsigned long ip)
 		kasan_report_invalid_free(ptr, ip);
 	/* The object will be poisoned by page_alloc. */
 }
-
-#ifdef CONFIG_MEMORY_HOTPLUG
-static bool shadow_mapped(unsigned long addr)
-{
-	pgd_t *pgd = pgd_offset_k(addr);
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-
-	if (pgd_none(*pgd))
-		return false;
-	p4d = p4d_offset(pgd, addr);
-	if (p4d_none(*p4d))
-		return false;
-	pud = pud_offset(p4d, addr);
-	if (pud_none(*pud))
-		return false;
-
-	/*
-	 * We can't use pud_large() or pud_huge(), the first one is
-	 * arch-specific, the last one depends on HUGETLB_PAGE.  So let's abuse
-	 * pud_bad(), if pud is bad then it's bad because it's huge.
-	 */
-	if (pud_bad(*pud))
-		return true;
-	pmd = pmd_offset(pud, addr);
-	if (pmd_none(*pmd))
-		return false;
-
-	if (pmd_bad(*pmd))
-		return true;
-	pte = pte_offset_kernel(pmd, addr);
-	return !pte_none(*pte);
-}
-
-static int __meminit kasan_mem_notifier(struct notifier_block *nb,
-			unsigned long action, void *data)
-{
-	struct memory_notify *mem_data = data;
-	unsigned long nr_shadow_pages, start_kaddr, shadow_start;
-	unsigned long shadow_end, shadow_size;
-
-	nr_shadow_pages = mem_data->nr_pages >> KASAN_SHADOW_SCALE_SHIFT;
-	start_kaddr = (unsigned long)pfn_to_kaddr(mem_data->start_pfn);
-	shadow_start = (unsigned long)kasan_mem_to_shadow((void *)start_kaddr);
-	shadow_size = nr_shadow_pages << PAGE_SHIFT;
-	shadow_end = shadow_start + shadow_size;
-
-	if (WARN_ON(mem_data->nr_pages % KASAN_GRANULE_SIZE) ||
-		WARN_ON(start_kaddr % (KASAN_GRANULE_SIZE << PAGE_SHIFT)))
-		return NOTIFY_BAD;
-
-	switch (action) {
-	case MEM_GOING_ONLINE: {
-		void *ret;
-
-		/*
-		 * If shadow is mapped already than it must have been mapped
-		 * during the boot. This could happen if we onlining previously
-		 * offlined memory.
-		 */
-		if (shadow_mapped(shadow_start))
-			return NOTIFY_OK;
-
-		ret = __vmalloc_node_range(shadow_size, PAGE_SIZE, shadow_start,
-					shadow_end, GFP_KERNEL,
-					PAGE_KERNEL, VM_NO_GUARD,
-					pfn_to_nid(mem_data->start_pfn),
-					__builtin_return_address(0));
-		if (!ret)
-			return NOTIFY_BAD;
-
-		kmemleak_ignore(ret);
-		return NOTIFY_OK;
-	}
-	case MEM_CANCEL_ONLINE:
-	case MEM_OFFLINE: {
-		struct vm_struct *vm;
-
-		/*
-		 * shadow_start was either mapped during boot by kasan_init()
-		 * or during memory online by __vmalloc_node_range().
-		 * In the latter case we can use vfree() to free shadow.
-		 * Non-NULL result of the find_vm_area() will tell us if
-		 * that was the second case.
-		 *
-		 * Currently it's not possible to free shadow mapped
-		 * during boot by kasan_init(). It's because the code
-		 * to do that hasn't been written yet. So we'll just
-		 * leak the memory.
-		 */
-		vm = find_vm_area((void *)shadow_start);
-		if (vm)
-			vfree((void *)shadow_start);
-	}
-	}
-
-	return NOTIFY_OK;
-}
-
-static int __init kasan_memhotplug_init(void)
-{
-	hotplug_memory_notifier(kasan_mem_notifier, 0);
-
-	return 0;
-}
-
-core_initcall(kasan_memhotplug_init);
-#endif
-
-#ifdef CONFIG_KASAN_VMALLOC
-
-static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
-				      void *unused)
-{
-	unsigned long page;
-	pte_t pte;
-
-	if (likely(!pte_none(*ptep)))
-		return 0;
-
-	page = __get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
-	memset((void *)page, KASAN_VMALLOC_INVALID, PAGE_SIZE);
-	pte = pfn_pte(PFN_DOWN(__pa(page)), PAGE_KERNEL);
-
-	spin_lock(&init_mm.page_table_lock);
-	if (likely(pte_none(*ptep))) {
-		set_pte_at(&init_mm, addr, ptep, pte);
-		page = 0;
-	}
-	spin_unlock(&init_mm.page_table_lock);
-	if (page)
-		free_page(page);
-	return 0;
-}
-
-int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
-{
-	unsigned long shadow_start, shadow_end;
-	int ret;
-
-	if (!is_vmalloc_or_module_addr((void *)addr))
-		return 0;
-
-	shadow_start = (unsigned long)kasan_mem_to_shadow((void *)addr);
-	shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
-	shadow_end = (unsigned long)kasan_mem_to_shadow((void *)addr + size);
-	shadow_end = ALIGN(shadow_end, PAGE_SIZE);
-
-	ret = apply_to_page_range(&init_mm, shadow_start,
-				  shadow_end - shadow_start,
-				  kasan_populate_vmalloc_pte, NULL);
-	if (ret)
-		return ret;
-
-	flush_cache_vmap(shadow_start, shadow_end);
-
-	/*
-	 * We need to be careful about inter-cpu effects here. Consider:
-	 *
-	 *   CPU#0				  CPU#1
-	 * WRITE_ONCE(p, vmalloc(100));		while (x = READ_ONCE(p)) ;
-	 *					p[99] = 1;
-	 *
-	 * With compiler instrumentation, that ends up looking like this:
-	 *
-	 *   CPU#0				  CPU#1
-	 * // vmalloc() allocates memory
-	 * // let a = area->addr
-	 * // we reach kasan_populate_vmalloc
-	 * // and call kasan_unpoison_memory:
-	 * STORE shadow(a), unpoison_val
-	 * ...
-	 * STORE shadow(a+99), unpoison_val	x = LOAD p
-	 * // rest of vmalloc process		<data dependency>
-	 * STORE p, a				LOAD shadow(x+99)
-	 *
-	 * If there is no barrier between the end of unpoisioning the shadow
-	 * and the store of the result to p, the stores could be committed
-	 * in a different order by CPU#0, and CPU#1 could erroneously observe
-	 * poison in the shadow.
-	 *
-	 * We need some sort of barrier between the stores.
-	 *
-	 * In the vmalloc() case, this is provided by a smp_wmb() in
-	 * clear_vm_uninitialized_flag(). In the per-cpu allocator and in
-	 * get_vm_area() and friends, the caller gets shadow allocated but
-	 * doesn't have any pages mapped into the virtual address space that
-	 * has been reserved. Mapping those pages in will involve taking and
-	 * releasing a page-table lock, which will provide the barrier.
-	 */
-
-	return 0;
-}
-
-/*
- * Poison the shadow for a vmalloc region. Called as part of the
- * freeing process at the time the region is freed.
- */
-void kasan_poison_vmalloc(const void *start, unsigned long size)
-{
-	if (!is_vmalloc_or_module_addr(start))
-		return;
-
-	size = round_up(size, KASAN_GRANULE_SIZE);
-	kasan_poison_memory(start, size, KASAN_VMALLOC_INVALID);
-}
-
-void kasan_unpoison_vmalloc(const void *start, unsigned long size)
-{
-	if (!is_vmalloc_or_module_addr(start))
-		return;
-
-	kasan_unpoison_memory(start, size);
-}
-
-static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
-					void *unused)
-{
-	unsigned long page;
-
-	page = (unsigned long)__va(pte_pfn(*ptep) << PAGE_SHIFT);
-
-	spin_lock(&init_mm.page_table_lock);
-
-	if (likely(!pte_none(*ptep))) {
-		pte_clear(&init_mm, addr, ptep);
-		free_page(page);
-	}
-	spin_unlock(&init_mm.page_table_lock);
-
-	return 0;
-}
-
-/*
- * Release the backing for the vmalloc region [start, end), which
- * lies within the free region [free_region_start, free_region_end).
- *
- * This can be run lazily, long after the region was freed. It runs
- * under vmap_area_lock, so it's not safe to interact with the vmalloc/vmap
- * infrastructure.
- *
- * How does this work?
- * -------------------
- *
- * We have a region that is page aligned, labelled as A.
- * That might not map onto the shadow in a way that is page-aligned:
- *
- *                    start                     end
- *                    v                         v
- * |????????|????????|AAAAAAAA|AA....AA|AAAAAAAA|????????| < vmalloc
- *  -------- -------- --------          -------- --------
- *      |        |       |                 |        |
- *      |        |       |         /-------/        |
- *      \-------\|/------/         |/---------------/
- *              |||                ||
- *             |??AAAAAA|AAAAAAAA|AA??????|                < shadow
- *                 (1)      (2)      (3)
- *
- * First we align the start upwards and the end downwards, so that the
- * shadow of the region aligns with shadow page boundaries. In the
- * example, this gives us the shadow page (2). This is the shadow entirely
- * covered by this allocation.
- *
- * Then we have the tricky bits. We want to know if we can free the
- * partially covered shadow pages - (1) and (3) in the example. For this,
- * we are given the start and end of the free region that contains this
- * allocation. Extending our previous example, we could have:
- *
- *  free_region_start                                    free_region_end
- *  |                 start                     end      |
- *  v                 v                         v        v
- * |FFFFFFFF|FFFFFFFF|AAAAAAAA|AA....AA|AAAAAAAA|FFFFFFFF| < vmalloc
- *  -------- -------- --------          -------- --------
- *      |        |       |                 |        |
- *      |        |       |         /-------/        |
- *      \-------\|/------/         |/---------------/
- *              |||                ||
- *             |FFAAAAAA|AAAAAAAA|AAF?????|                < shadow
- *                 (1)      (2)      (3)
- *
- * Once again, we align the start of the free region up, and the end of
- * the free region down so that the shadow is page aligned. So we can free
- * page (1) - we know no allocation currently uses anything in that page,
- * because all of it is in the vmalloc free region. But we cannot free
- * page (3), because we can't be sure that the rest of it is unused.
- *
- * We only consider pages that contain part of the original region for
- * freeing: we don't try to free other pages from the free region or we'd
- * end up trying to free huge chunks of virtual address space.
- *
- * Concurrency
- * -----------
- *
- * How do we know that we're not freeing a page that is simultaneously
- * being used for a fresh allocation in kasan_populate_vmalloc(_pte)?
- *
- * We _can_ have kasan_release_vmalloc and kasan_populate_vmalloc running
- * at the same time. While we run under free_vmap_area_lock, the population
- * code does not.
- *
- * free_vmap_area_lock instead operates to ensure that the larger range
- * [free_region_start, free_region_end) is safe: because __alloc_vmap_area and
- * the per-cpu region-finding algorithm both run under free_vmap_area_lock,
- * no space identified as free will become used while we are running. This
- * means that so long as we are careful with alignment and only free shadow
- * pages entirely covered by the free region, we will not run in to any
- * trouble - any simultaneous allocations will be for disjoint regions.
- */
-void kasan_release_vmalloc(unsigned long start, unsigned long end,
-			   unsigned long free_region_start,
-			   unsigned long free_region_end)
-{
-	void *shadow_start, *shadow_end;
-	unsigned long region_start, region_end;
-	unsigned long size;
-
-	region_start = ALIGN(start, PAGE_SIZE * KASAN_GRANULE_SIZE);
-	region_end = ALIGN_DOWN(end, PAGE_SIZE * KASAN_GRANULE_SIZE);
-
-	free_region_start = ALIGN(free_region_start,
-				  PAGE_SIZE * KASAN_GRANULE_SIZE);
-
-	if (start != region_start &&
-	    free_region_start < region_start)
-		region_start -= PAGE_SIZE * KASAN_GRANULE_SIZE;
-
-	free_region_end = ALIGN_DOWN(free_region_end,
-				     PAGE_SIZE * KASAN_GRANULE_SIZE);
-
-	if (end != region_end &&
-	    free_region_end > region_end)
-		region_end += PAGE_SIZE * KASAN_GRANULE_SIZE;
-
-	shadow_start = kasan_mem_to_shadow((void *)region_start);
-	shadow_end = kasan_mem_to_shadow((void *)region_end);
-
-	if (shadow_end > shadow_start) {
-		size = shadow_end - shadow_start;
-		apply_to_existing_page_range(&init_mm,
-					     (unsigned long)shadow_start,
-					     size, kasan_depopulate_vmalloc_pte,
-					     NULL);
-		flush_tlb_kernel_range((unsigned long)shadow_start,
-				       (unsigned long)shadow_end);
-	}
-}
-
-#else /* CONFIG_KASAN_VMALLOC */
-
-int kasan_module_alloc(void *addr, size_t size)
-{
-	void *ret;
-	size_t scaled_size;
-	size_t shadow_size;
-	unsigned long shadow_start;
-
-	shadow_start = (unsigned long)kasan_mem_to_shadow(addr);
-	scaled_size = (size + KASAN_GRANULE_SIZE - 1) >>
-				KASAN_SHADOW_SCALE_SHIFT;
-	shadow_size = round_up(scaled_size, PAGE_SIZE);
-
-	if (WARN_ON(!PAGE_ALIGNED(shadow_start)))
-		return -EINVAL;
-
-	ret = __vmalloc_node_range(shadow_size, 1, shadow_start,
-			shadow_start + shadow_size,
-			GFP_KERNEL,
-			PAGE_KERNEL, VM_NO_GUARD, NUMA_NO_NODE,
-			__builtin_return_address(0));
-
-	if (ret) {
-		__memset(ret, KASAN_SHADOW_INIT, shadow_size);
-		find_vm_area(addr)->flags |= VM_KASAN;
-		kmemleak_ignore(ret);
-		return 0;
-	}
-
-	return -ENOMEM;
-}
-
-void kasan_free_shadow(const struct vm_struct *vm)
-{
-	if (vm->flags & VM_KASAN)
-		vfree(kasan_mem_to_shadow(vm->addr));
-}
-
-#endif
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
new file mode 100644
index 000000000000..4888084ecdfc
--- /dev/null
+++ b/mm/kasan/shadow.c
@@ -0,0 +1,509 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file contains KASAN shadow runtime code.
+ *
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ * Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
+ *
+ * Some code borrowed from https://github.com/xairy/kasan-prototype by
+ *        Andrey Konovalov <andreyknvl@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/kasan.h>
+#include <linux/kernel.h>
+#include <linux/kmemleak.h>
+#include <linux/memory.h>
+#include <linux/mm.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/vmalloc.h>
+
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
+
+#include "kasan.h"
+
+bool __kasan_check_read(const volatile void *p, unsigned int size)
+{
+	return check_memory_region((unsigned long)p, size, false, _RET_IP_);
+}
+EXPORT_SYMBOL(__kasan_check_read);
+
+bool __kasan_check_write(const volatile void *p, unsigned int size)
+{
+	return check_memory_region((unsigned long)p, size, true, _RET_IP_);
+}
+EXPORT_SYMBOL(__kasan_check_write);
+
+#undef memset
+void *memset(void *addr, int c, size_t len)
+{
+	if (!check_memory_region((unsigned long)addr, len, true, _RET_IP_))
+		return NULL;
+
+	return __memset(addr, c, len);
+}
+
+#ifdef __HAVE_ARCH_MEMMOVE
+#undef memmove
+void *memmove(void *dest, const void *src, size_t len)
+{
+	if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
+	    !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
+		return NULL;
+
+	return __memmove(dest, src, len);
+}
+#endif
+
+#undef memcpy
+void *memcpy(void *dest, const void *src, size_t len)
+{
+	if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
+	    !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
+		return NULL;
+
+	return __memcpy(dest, src, len);
+}
+
+/*
+ * Poisons the shadow memory for 'size' bytes starting from 'addr'.
+ * Memory addresses should be aligned to KASAN_GRANULE_SIZE.
+ */
+void kasan_poison_memory(const void *address, size_t size, u8 value)
+{
+	void *shadow_start, *shadow_end;
+
+	/*
+	 * Perform shadow offset calculation based on untagged address, as
+	 * some of the callers (e.g. kasan_poison_object_data) pass tagged
+	 * addresses to this function.
+	 */
+	address = reset_tag(address);
+
+	shadow_start = kasan_mem_to_shadow(address);
+	shadow_end = kasan_mem_to_shadow(address + size);
+
+	__memset(shadow_start, value, shadow_end - shadow_start);
+}
+
+void kasan_unpoison_memory(const void *address, size_t size)
+{
+	u8 tag = get_tag(address);
+
+	/*
+	 * Perform shadow offset calculation based on untagged address, as
+	 * some of the callers (e.g. kasan_unpoison_object_data) pass tagged
+	 * addresses to this function.
+	 */
+	address = reset_tag(address);
+
+	kasan_poison_memory(address, size, tag);
+
+	if (size & KASAN_GRANULE_MASK) {
+		u8 *shadow = (u8 *)kasan_mem_to_shadow(address + size);
+
+		if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
+			*shadow = tag;
+		else
+			*shadow = size & KASAN_GRANULE_MASK;
+	}
+}
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static bool shadow_mapped(unsigned long addr)
+{
+	pgd_t *pgd = pgd_offset_k(addr);
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	if (pgd_none(*pgd))
+		return false;
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(*p4d))
+		return false;
+	pud = pud_offset(p4d, addr);
+	if (pud_none(*pud))
+		return false;
+
+	/*
+	 * We can't use pud_large() or pud_huge(), the first one is
+	 * arch-specific, the last one depends on HUGETLB_PAGE.  So let's abuse
+	 * pud_bad(), if pud is bad then it's bad because it's huge.
+	 */
+	if (pud_bad(*pud))
+		return true;
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(*pmd))
+		return false;
+
+	if (pmd_bad(*pmd))
+		return true;
+	pte = pte_offset_kernel(pmd, addr);
+	return !pte_none(*pte);
+}
+
+static int __meminit kasan_mem_notifier(struct notifier_block *nb,
+			unsigned long action, void *data)
+{
+	struct memory_notify *mem_data = data;
+	unsigned long nr_shadow_pages, start_kaddr, shadow_start;
+	unsigned long shadow_end, shadow_size;
+
+	nr_shadow_pages = mem_data->nr_pages >> KASAN_SHADOW_SCALE_SHIFT;
+	start_kaddr = (unsigned long)pfn_to_kaddr(mem_data->start_pfn);
+	shadow_start = (unsigned long)kasan_mem_to_shadow((void *)start_kaddr);
+	shadow_size = nr_shadow_pages << PAGE_SHIFT;
+	shadow_end = shadow_start + shadow_size;
+
+	if (WARN_ON(mem_data->nr_pages % KASAN_GRANULE_SIZE) ||
+		WARN_ON(start_kaddr % (KASAN_GRANULE_SIZE << PAGE_SHIFT)))
+		return NOTIFY_BAD;
+
+	switch (action) {
+	case MEM_GOING_ONLINE: {
+		void *ret;
+
+		/*
+		 * If shadow is mapped already than it must have been mapped
+		 * during the boot. This could happen if we onlining previously
+		 * offlined memory.
+		 */
+		if (shadow_mapped(shadow_start))
+			return NOTIFY_OK;
+
+		ret = __vmalloc_node_range(shadow_size, PAGE_SIZE, shadow_start,
+					shadow_end, GFP_KERNEL,
+					PAGE_KERNEL, VM_NO_GUARD,
+					pfn_to_nid(mem_data->start_pfn),
+					__builtin_return_address(0));
+		if (!ret)
+			return NOTIFY_BAD;
+
+		kmemleak_ignore(ret);
+		return NOTIFY_OK;
+	}
+	case MEM_CANCEL_ONLINE:
+	case MEM_OFFLINE: {
+		struct vm_struct *vm;
+
+		/*
+		 * shadow_start was either mapped during boot by kasan_init()
+		 * or during memory online by __vmalloc_node_range().
+		 * In the latter case we can use vfree() to free shadow.
+		 * Non-NULL result of the find_vm_area() will tell us if
+		 * that was the second case.
+		 *
+		 * Currently it's not possible to free shadow mapped
+		 * during boot by kasan_init(). It's because the code
+		 * to do that hasn't been written yet. So we'll just
+		 * leak the memory.
+		 */
+		vm = find_vm_area((void *)shadow_start);
+		if (vm)
+			vfree((void *)shadow_start);
+	}
+	}
+
+	return NOTIFY_OK;
+}
+
+static int __init kasan_memhotplug_init(void)
+{
+	hotplug_memory_notifier(kasan_mem_notifier, 0);
+
+	return 0;
+}
+
+core_initcall(kasan_memhotplug_init);
+#endif
+
+#ifdef CONFIG_KASAN_VMALLOC
+
+static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
+				      void *unused)
+{
+	unsigned long page;
+	pte_t pte;
+
+	if (likely(!pte_none(*ptep)))
+		return 0;
+
+	page = __get_free_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	memset((void *)page, KASAN_VMALLOC_INVALID, PAGE_SIZE);
+	pte = pfn_pte(PFN_DOWN(__pa(page)), PAGE_KERNEL);
+
+	spin_lock(&init_mm.page_table_lock);
+	if (likely(pte_none(*ptep))) {
+		set_pte_at(&init_mm, addr, ptep, pte);
+		page = 0;
+	}
+	spin_unlock(&init_mm.page_table_lock);
+	if (page)
+		free_page(page);
+	return 0;
+}
+
+int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
+{
+	unsigned long shadow_start, shadow_end;
+	int ret;
+
+	if (!is_vmalloc_or_module_addr((void *)addr))
+		return 0;
+
+	shadow_start = (unsigned long)kasan_mem_to_shadow((void *)addr);
+	shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
+	shadow_end = (unsigned long)kasan_mem_to_shadow((void *)addr + size);
+	shadow_end = ALIGN(shadow_end, PAGE_SIZE);
+
+	ret = apply_to_page_range(&init_mm, shadow_start,
+				  shadow_end - shadow_start,
+				  kasan_populate_vmalloc_pte, NULL);
+	if (ret)
+		return ret;
+
+	flush_cache_vmap(shadow_start, shadow_end);
+
+	/*
+	 * We need to be careful about inter-cpu effects here. Consider:
+	 *
+	 *   CPU#0				  CPU#1
+	 * WRITE_ONCE(p, vmalloc(100));		while (x = READ_ONCE(p)) ;
+	 *					p[99] = 1;
+	 *
+	 * With compiler instrumentation, that ends up looking like this:
+	 *
+	 *   CPU#0				  CPU#1
+	 * // vmalloc() allocates memory
+	 * // let a = area->addr
+	 * // we reach kasan_populate_vmalloc
+	 * // and call kasan_unpoison_memory:
+	 * STORE shadow(a), unpoison_val
+	 * ...
+	 * STORE shadow(a+99), unpoison_val	x = LOAD p
+	 * // rest of vmalloc process		<data dependency>
+	 * STORE p, a				LOAD shadow(x+99)
+	 *
+	 * If there is no barrier between the end of unpoisioning the shadow
+	 * and the store of the result to p, the stores could be committed
+	 * in a different order by CPU#0, and CPU#1 could erroneously observe
+	 * poison in the shadow.
+	 *
+	 * We need some sort of barrier between the stores.
+	 *
+	 * In the vmalloc() case, this is provided by a smp_wmb() in
+	 * clear_vm_uninitialized_flag(). In the per-cpu allocator and in
+	 * get_vm_area() and friends, the caller gets shadow allocated but
+	 * doesn't have any pages mapped into the virtual address space that
+	 * has been reserved. Mapping those pages in will involve taking and
+	 * releasing a page-table lock, which will provide the barrier.
+	 */
+
+	return 0;
+}
+
+/*
+ * Poison the shadow for a vmalloc region. Called as part of the
+ * freeing process at the time the region is freed.
+ */
+void kasan_poison_vmalloc(const void *start, unsigned long size)
+{
+	if (!is_vmalloc_or_module_addr(start))
+		return;
+
+	size = round_up(size, KASAN_GRANULE_SIZE);
+	kasan_poison_memory(start, size, KASAN_VMALLOC_INVALID);
+}
+
+void kasan_unpoison_vmalloc(const void *start, unsigned long size)
+{
+	if (!is_vmalloc_or_module_addr(start))
+		return;
+
+	kasan_unpoison_memory(start, size);
+}
+
+static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
+					void *unused)
+{
+	unsigned long page;
+
+	page = (unsigned long)__va(pte_pfn(*ptep) << PAGE_SHIFT);
+
+	spin_lock(&init_mm.page_table_lock);
+
+	if (likely(!pte_none(*ptep))) {
+		pte_clear(&init_mm, addr, ptep);
+		free_page(page);
+	}
+	spin_unlock(&init_mm.page_table_lock);
+
+	return 0;
+}
+
+/*
+ * Release the backing for the vmalloc region [start, end), which
+ * lies within the free region [free_region_start, free_region_end).
+ *
+ * This can be run lazily, long after the region was freed. It runs
+ * under vmap_area_lock, so it's not safe to interact with the vmalloc/vmap
+ * infrastructure.
+ *
+ * How does this work?
+ * -------------------
+ *
+ * We have a region that is page aligned, labelled as A.
+ * That might not map onto the shadow in a way that is page-aligned:
+ *
+ *                    start                     end
+ *                    v                         v
+ * |????????|????????|AAAAAAAA|AA....AA|AAAAAAAA|????????| < vmalloc
+ *  -------- -------- --------          -------- --------
+ *      |        |       |                 |        |
+ *      |        |       |         /-------/        |
+ *      \-------\|/------/         |/---------------/
+ *              |||                ||
+ *             |??AAAAAA|AAAAAAAA|AA??????|                < shadow
+ *                 (1)      (2)      (3)
+ *
+ * First we align the start upwards and the end downwards, so that the
+ * shadow of the region aligns with shadow page boundaries. In the
+ * example, this gives us the shadow page (2). This is the shadow entirely
+ * covered by this allocation.
+ *
+ * Then we have the tricky bits. We want to know if we can free the
+ * partially covered shadow pages - (1) and (3) in the example. For this,
+ * we are given the start and end of the free region that contains this
+ * allocation. Extending our previous example, we could have:
+ *
+ *  free_region_start                                    free_region_end
+ *  |                 start                     end      |
+ *  v                 v                         v        v
+ * |FFFFFFFF|FFFFFFFF|AAAAAAAA|AA....AA|AAAAAAAA|FFFFFFFF| < vmalloc
+ *  -------- -------- --------          -------- --------
+ *      |        |       |                 |        |
+ *      |        |       |         /-------/        |
+ *      \-------\|/------/         |/---------------/
+ *              |||                ||
+ *             |FFAAAAAA|AAAAAAAA|AAF?????|                < shadow
+ *                 (1)      (2)      (3)
+ *
+ * Once again, we align the start of the free region up, and the end of
+ * the free region down so that the shadow is page aligned. So we can free
+ * page (1) - we know no allocation currently uses anything in that page,
+ * because all of it is in the vmalloc free region. But we cannot free
+ * page (3), because we can't be sure that the rest of it is unused.
+ *
+ * We only consider pages that contain part of the original region for
+ * freeing: we don't try to free other pages from the free region or we'd
+ * end up trying to free huge chunks of virtual address space.
+ *
+ * Concurrency
+ * -----------
+ *
+ * How do we know that we're not freeing a page that is simultaneously
+ * being used for a fresh allocation in kasan_populate_vmalloc(_pte)?
+ *
+ * We _can_ have kasan_release_vmalloc and kasan_populate_vmalloc running
+ * at the same time. While we run under free_vmap_area_lock, the population
+ * code does not.
+ *
+ * free_vmap_area_lock instead operates to ensure that the larger range
+ * [free_region_start, free_region_end) is safe: because __alloc_vmap_area and
+ * the per-cpu region-finding algorithm both run under free_vmap_area_lock,
+ * no space identified as free will become used while we are running. This
+ * means that so long as we are careful with alignment and only free shadow
+ * pages entirely covered by the free region, we will not run in to any
+ * trouble - any simultaneous allocations will be for disjoint regions.
+ */
+void kasan_release_vmalloc(unsigned long start, unsigned long end,
+			   unsigned long free_region_start,
+			   unsigned long free_region_end)
+{
+	void *shadow_start, *shadow_end;
+	unsigned long region_start, region_end;
+	unsigned long size;
+
+	region_start = ALIGN(start, PAGE_SIZE * KASAN_GRANULE_SIZE);
+	region_end = ALIGN_DOWN(end, PAGE_SIZE * KASAN_GRANULE_SIZE);
+
+	free_region_start = ALIGN(free_region_start,
+				  PAGE_SIZE * KASAN_GRANULE_SIZE);
+
+	if (start != region_start &&
+	    free_region_start < region_start)
+		region_start -= PAGE_SIZE * KASAN_GRANULE_SIZE;
+
+	free_region_end = ALIGN_DOWN(free_region_end,
+				     PAGE_SIZE * KASAN_GRANULE_SIZE);
+
+	if (end != region_end &&
+	    free_region_end > region_end)
+		region_end += PAGE_SIZE * KASAN_GRANULE_SIZE;
+
+	shadow_start = kasan_mem_to_shadow((void *)region_start);
+	shadow_end = kasan_mem_to_shadow((void *)region_end);
+
+	if (shadow_end > shadow_start) {
+		size = shadow_end - shadow_start;
+		apply_to_existing_page_range(&init_mm,
+					     (unsigned long)shadow_start,
+					     size, kasan_depopulate_vmalloc_pte,
+					     NULL);
+		flush_tlb_kernel_range((unsigned long)shadow_start,
+				       (unsigned long)shadow_end);
+	}
+}
+
+#else /* CONFIG_KASAN_VMALLOC */
+
+int kasan_module_alloc(void *addr, size_t size)
+{
+	void *ret;
+	size_t scaled_size;
+	size_t shadow_size;
+	unsigned long shadow_start;
+
+	shadow_start = (unsigned long)kasan_mem_to_shadow(addr);
+	scaled_size = (size + KASAN_GRANULE_SIZE - 1) >>
+				KASAN_SHADOW_SCALE_SHIFT;
+	shadow_size = round_up(scaled_size, PAGE_SIZE);
+
+	if (WARN_ON(!PAGE_ALIGNED(shadow_start)))
+		return -EINVAL;
+
+	ret = __vmalloc_node_range(shadow_size, 1, shadow_start,
+			shadow_start + shadow_size,
+			GFP_KERNEL,
+			PAGE_KERNEL, VM_NO_GUARD, NUMA_NO_NODE,
+			__builtin_return_address(0));
+
+	if (ret) {
+		__memset(ret, KASAN_SHADOW_INIT, shadow_size);
+		find_vm_area(addr)->flags |= VM_KASAN;
+		kmemleak_ignore(ret);
+		return 0;
+	}
+
+	return -ENOMEM;
+}
+
+void kasan_free_shadow(const struct vm_struct *vm)
+{
+	if (vm->flags & VM_KASAN)
+		vfree(kasan_mem_to_shadow(vm->addr));
+}
+
+#endif
-- 
2.28.0.618.gf4bc123cb7-goog


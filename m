Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF9D2B2898
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgKMWev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgKMWev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:34:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56B6C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:34:50 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605306888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=etArIgtLmm2DY3kbR2YVLpGmQ63b4IJwEkWvDE+qacg=;
        b=x1WARyZRSagvM8rv6/xL4GGdOHLWKyRNMpcPUGbZ4YLOUSfE8QrO8acb3eTYTR2cl+x6ln
        7C3Vs1ow/H+8o7Y071g58uR1qArI+hEahk18dX5uEhbyQwxC3iFy9AHPsLv1vmUXB0JKED
        yj8pByn8Uond5XNZ9Mahz4PHtbTG63CZ27GNA3UUz5qF9ZQn6JW0kXe4U/m265MitS/OSN
        3wGcPpgbpUuixS8pRCgWbB1XJKJ2+EO2cbIACw6CaprHpmCJRVT+M1/kJWYSZnqAQFYhyu
        rBzmK3tRvQ0UFsoTervRq+KaTip8D3iLxrsuBjcZsRgKx2GWFLuJMiwfJ+a0Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605306888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=etArIgtLmm2DY3kbR2YVLpGmQ63b4IJwEkWvDE+qacg=;
        b=WIJDZw+SuRqkQGe5x2cGDLOybWFkzub2K8iqLGG4Qjs5AUhVRxx0//+2q4/dXvAzKRb8F2
        KCBfjCHOsB4mUjBg==
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     "open list\:TENSILICA XTENSA PORT \(xtensa\)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] highmem: fix highmem for xtensa
In-Reply-To: <CAMo8Bf+2kGmg_SvJz8R=qXgPWbYWmf-PSeG71xKe5AB2LeyZ4Q@mail.gmail.com>
References: <20201113122328.22942-1-jcmvbkbc@gmail.com> <87zh3ll6hw.fsf@nanos.tec.linutronix.de> <CAMo8BfKEr-89awEnV072uWR=4fniDRJ0drWmZrtnyvj-mANk0A@mail.gmail.com> <87sg9dl3xk.fsf@nanos.tec.linutronix.de> <CAMo8Bf+2kGmg_SvJz8R=qXgPWbYWmf-PSeG71xKe5AB2LeyZ4Q@mail.gmail.com>
Date:   Fri, 13 Nov 2020 23:34:48 +0100
Message-ID: <87mtzklwc7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Max,

On Fri, Nov 13 2020 at 08:34, Max Filippov wrote:
> On Fri, Nov 13, 2020 at 6:36 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Fri, Nov 13 2020 at 05:50, Max Filippov wrote:
>> > On Fri, Nov 13, 2020 at 5:40 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> >> What's wrong with just doing the obvious and making the fixmap defines
>> >> the other way round?
>> >
>> > It becomes really awkward when we get to support high memory with
>> > aliasing data cache: we must think about the actual virtual addresses
>> > assigned to pages and it feels much simpler when it's done this way.
>>
>> Feeling are not really a technical argument. Is there any functional
>> difference which matters?
>
> arch_kmap_local_map_idx must produce index based on type and
> pfn that will be translated to virtual address with the same color this
> page would've had if it was in the low memory. With positive fixmap
> the formula is: (type * (number of cache colors)) + (color of the pfn).
> With negative fixmap there must be additional +1 and -1 in it.

I agree that the top down mechanics is not really intuitive, but that
does not justify the ifdeffery in the generic code.

xtensa can just use the generic fix_to_virt/virt_to_fix mechanics. All
it needs is to adjust the mapping defines and to adjust the color offset
to

        NR_COLORS - color
        
which is not an unreasonable ask. As a side effect all highmem inflicted
systems which do not have the cache aliasing problem can just use the
generic code as is. See untested patch below.

It builds for some configs, but the smp_lx200_defconfig (which has the
aliasing) it fails to build even without this patch (highmem.o at least
builds).

Toolchain is the one from https://mirrors.edge.kernel.org/pub/tools/crosstool/

Thanks,

        tglx
---
Subject: xtensa/mm/highmem: Make generic kmap_atomic() work correctly
From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 13 Nov 2020 21:25:12 +0100

The conversion to the generic kmap_atomic() implementation missed the fact
that xtensa's fixmap works bottom up while all other implementations work
top down. There is no real reason why xtensa needs to work that way.

Cure it by:

  - Using the generic fix_to_virt()/virt_to_fix() functions which work top
    down
  - Adjusting the mapping defines
  - Using the generic index calculation for the non cache aliasing case
  - Making the cache colour offset reverse so the effective index is correct

While at it, remove the outdated and misleading comment above the fixmap
enum which originates from the initial copy&pasta of this code from i386.

Reported-by: Max Filippov <jcmvbkbc@gmail.com>
Fixes: 629ed3f7dad2 ("xtensa/mm/highmem: Switch to generic kmap atomic")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/xtensa/include/asm/fixmap.h  |   55 ++++----------------------------------
 arch/xtensa/include/asm/highmem.h |   15 ++++++----
 arch/xtensa/mm/highmem.c          |   18 +++++++-----
 arch/xtensa/mm/init.c             |    4 +-
 arch/xtensa/mm/mmu.c              |    3 +-
 5 files changed, 31 insertions(+), 64 deletions(-)

--- a/arch/xtensa/include/asm/fixmap.h
+++ b/arch/xtensa/include/asm/fixmap.h
@@ -17,63 +17,22 @@
 #include <linux/threads.h>
 #include <linux/pgtable.h>
 #include <asm/kmap_size.h>
-#endif
 
-/*
- * Here we define all the compile-time 'special' virtual
- * addresses. The point is to have a constant address at
- * compile time, but to set the physical address only
- * in the boot process. We allocate these special addresses
- * from the start of the consistent memory region upwards.
- * Also this lets us do fail-safe vmalloc(), we
- * can guarantee that these special addresses and
- * vmalloc()-ed addresses never overlap.
- *
- * these 'compile-time allocated' memory buffers are
- * fixed-size 4k pages. (or larger if used with an increment
- * higher than 1) use fixmap_set(idx,phys) to associate
- * physical memory with fixmap indices.
- */
+/* The map slots for temporary mappings via kmap_atomic/local(). */
 enum fixed_addresses {
-#ifdef CONFIG_HIGHMEM
-	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_BEGIN,
 	FIX_KMAP_END = FIX_KMAP_BEGIN +
 		(KM_MAX_IDX * NR_CPUS * DCACHE_N_COLORS) - 1,
-#endif
 	__end_of_fixed_addresses
 };
 
-#define FIXADDR_TOP     (XCHAL_KSEG_CACHED_VADDR - PAGE_SIZE)
+#define FIXADDR_END     (XCHAL_KSEG_CACHED_VADDR - PAGE_SIZE)
 #define FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
-#define FIXADDR_START	((FIXADDR_TOP - FIXADDR_SIZE) & PMD_MASK)
-
-#define __fix_to_virt(x)	(FIXADDR_START + ((x) << PAGE_SHIFT))
-#define __virt_to_fix(x)	(((x) - FIXADDR_START) >> PAGE_SHIFT)
+/* Enforce that FIXADDR_START is PMD aligned to handle cache aliasing */
+#define FIXADDR_START	((FIXADDR_END - FIXADDR_SIZE) & PMD_MASK)
+#define FIXADDR_TOP	(FIXADDR_START + FIXADDR_SIZE - PAGE_SIZE)
 
-#ifndef __ASSEMBLY__
-/*
- * 'index to address' translation. If anyone tries to use the idx
- * directly without translation, we catch the bug with a NULL-deference
- * kernel oops. Illegal ranges of incoming indices are caught too.
- */
-static __always_inline unsigned long fix_to_virt(const unsigned int idx)
-{
-	/* Check if this memory layout is broken because fixmap overlaps page
-	 * table.
-	 */
-	BUILD_BUG_ON(FIXADDR_START <
-		     TLBTEMP_BASE_1 + TLBTEMP_SIZE);
-	BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
-	return __fix_to_virt(idx);
-}
-
-static inline unsigned long virt_to_fix(const unsigned long vaddr)
-{
-	BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
-	return __virt_to_fix(vaddr);
-}
-
-#endif
+#include <asm-generic/fixmap.h>
 
+#endif /* CONFIG_HIGHMEM */
 #endif
--- a/arch/xtensa/include/asm/highmem.h
+++ b/arch/xtensa/include/asm/highmem.h
@@ -12,6 +12,7 @@
 #ifndef _XTENSA_HIGHMEM_H
 #define _XTENSA_HIGHMEM_H
 
+#ifdef CONFIG_HIGHMEM
 #include <linux/wait.h>
 #include <linux/pgtable.h>
 #include <asm/cacheflush.h>
@@ -58,6 +59,13 @@ static inline wait_queue_head_t *get_pkm
 {
 	return pkmap_map_wait_arr + color;
 }
+
+enum fixed_addresses kmap_local_map_idx(int type, unsigned long pfn);
+#define arch_kmap_local_map_idx		kmap_local_map_idx
+
+enum fixed_addresses kmap_local_unmap_idx(int type, unsigned long addr);
+#define arch_kmap_local_unmap_idx	kmap_local_unmap_idx
+
 #endif
 
 extern pte_t *pkmap_page_table;
@@ -67,15 +75,10 @@ static inline void flush_cache_kmaps(voi
 	flush_cache_all();
 }
 
-enum fixed_addresses kmap_local_map_idx(int type, unsigned long pfn);
-#define arch_kmap_local_map_idx		kmap_local_map_idx
-
-enum fixed_addresses kmap_local_unmap_idx(int type, unsigned long addr);
-#define arch_kmap_local_unmap_idx	kmap_local_unmap_idx
-
 #define arch_kmap_local_post_unmap(vaddr)	\
 	local_flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE)
 
 void kmap_init(void);
 
+#endif /* CONFIG_HIGHMEM */
 #endif
--- a/arch/xtensa/mm/highmem.c
+++ b/arch/xtensa/mm/highmem.c
@@ -23,16 +23,16 @@ static void __init kmap_waitqueues_init(
 	for (i = 0; i < ARRAY_SIZE(pkmap_map_wait_arr); ++i)
 		init_waitqueue_head(pkmap_map_wait_arr + i);
 }
-#else
-static inline void kmap_waitqueues_init(void)
-{
-}
-#endif
 
 static inline enum fixed_addresses kmap_idx(int type, unsigned long color)
 {
-	return (type + KM_MAX_IDX * smp_processor_id()) * DCACHE_N_COLORS +
-		color;
+	int idx = (type + KM_MAX_IDX * smp_processor_id()) * DCACHE_N_COLORS;
+
+	/*
+	 * The fixmap operates top down, so the color offset needs to be
+	 * reverse as well.
+	 */
+	return idx + DCACHE_N_COLORS - color;
 }
 
 enum fixed_addresses kmap_local_map_idx(int type, unsigned long pfn)
@@ -45,6 +45,10 @@ enum fixed_addresses kmap_local_unmap_id
 	return kmap_idx(type, DCACHE_ALIAS(addr));
 }
 
+#else
+static inline void kmap_waitqueues_init(void) { }
+#endif
+
 void __init kmap_init(void)
 {
 	/* Check if this memory layout is broken because PKMAP overlaps
--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -147,8 +147,8 @@ void __init mem_init(void)
 #ifdef CONFIG_HIGHMEM
 		PKMAP_BASE, PKMAP_BASE + LAST_PKMAP * PAGE_SIZE,
 		(LAST_PKMAP*PAGE_SIZE) >> 10,
-		FIXADDR_START, FIXADDR_TOP,
-		(FIXADDR_TOP - FIXADDR_START) >> 10,
+		FIXADDR_START, FIXADDR_END,
+		(FIXADDR_END - FIXADDR_START) >> 10,
 #endif
 		PAGE_OFFSET, PAGE_OFFSET +
 		(max_low_pfn - min_low_pfn) * PAGE_SIZE,
--- a/arch/xtensa/mm/mmu.c
+++ b/arch/xtensa/mm/mmu.c
@@ -52,7 +52,8 @@ static void * __init init_pmd(unsigned l
 
 static void __init fixedrange_init(void)
 {
-	init_pmd(__fix_to_virt(0), __end_of_fixed_addresses);
+	BUILD_BUG_ON(FIXADDR_START < TLBTEMP_BASE_1 + TLBTEMP_SIZE);
+	init_pmd(FIXADDR_START, __end_of_fixed_addresses);
 }
 #endif
 







Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F202FE459
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbhAUHtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:49:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbhAUG6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:58:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13FA8239A4;
        Thu, 21 Jan 2021 06:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212221;
        bh=HNNMT9CIDk/vbSkKJSvWDbbApzJApXDkSAirk+ezFUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qHyyzDt4vqi8FLhn4fxS+4mbeEtQC9QH8lXXD37XOIkZZVizpanfNRYBCfGpuTKia
         P+CoWatYd5d3gCGDlkFL8ggOR6rZNpBF9oDLdzAJM3NhN2YGdgFRRwK6dhxKIvGpK0
         WgFu3OAStPo/uVjOE80858DEryC8yLraV+IcfoBlwaZUxOHEKYbHO45Fwk39fvpe25
         Zmb2MCWUWxJWr1BlaOsd62PJs6d584mi0y7i/Jg7CIQ3veB79btULETPWqdJ38YDRa
         PqdK8KQBdi+/t9ec7PtyYrWbV5nw/rx0VREs8r2837U25WiKbklOYPZyDl3nQjKhLU
         eBN2Nl/2IISOw==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 12/29] csky: Fix TLB maintenance synchronization problem
Date:   Thu, 21 Jan 2021 14:53:32 +0800
Message-Id: <20210121065349.3188251-12-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

TLB invalidate didn't contain a barrier operation in csky cpu and
we need to prevent previous PTW response after TLB invalidation
instruction. Of cause, the ASID changing also needs to take care
of the issue.

CPU0                    CPU1
===============         ===============
set_pte
sync_is()        ->     See the previous set_pte for all harts
tlbi.vas         ->     Invalidate all harts TLB entry & flush pipeline

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/abiv1/inc/abi/ckmmu.h     |  3 ++-
 arch/csky/abiv2/inc/abi/ckmmu.h     | 35 ++++++++++++++++++++----
 arch/csky/include/asm/mmu_context.h |  3 +--
 arch/csky/mm/init.c                 |  2 +-
 arch/csky/mm/tlb.c                  | 42 ++++++++++++++++++++++++-----
 5 files changed, 69 insertions(+), 16 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/ckmmu.h b/arch/csky/abiv1/inc/abi/ckmmu.h
index cceb3afb4c91..b4650de43078 100644
--- a/arch/csky/abiv1/inc/abi/ckmmu.h
+++ b/arch/csky/abiv1/inc/abi/ckmmu.h
@@ -89,9 +89,10 @@ static inline void tlb_invalid_indexed(void)
 	cpwcr("cpcr8", 0x02000000);
 }
 
-static inline void setup_pgd(pgd_t *pgd)
+static inline void setup_pgd(pgd_t *pgd, int asid)
 {
 	cpwcr("cpcr29", __pa(pgd) | BIT(0));
+	write_mmu_entryhi(asid);
 }
 
 static inline pgd_t *get_pgd(void)
diff --git a/arch/csky/abiv2/inc/abi/ckmmu.h b/arch/csky/abiv2/inc/abi/ckmmu.h
index c39b13810550..530d2c7edc85 100644
--- a/arch/csky/abiv2/inc/abi/ckmmu.h
+++ b/arch/csky/abiv2/inc/abi/ckmmu.h
@@ -78,8 +78,13 @@ static inline void tlb_read(void)
 static inline void tlb_invalid_all(void)
 {
 #ifdef CONFIG_CPU_HAS_TLBI
-	asm volatile("tlbi.alls\n":::"memory");
 	sync_is();
+	asm volatile(
+		"tlbi.alls	\n"
+		"sync.i		\n"
+		:
+		:
+		: "memory");
 #else
 	mtcr("cr<8, 15>", 0x04000000);
 #endif
@@ -88,8 +93,13 @@ static inline void tlb_invalid_all(void)
 static inline void local_tlb_invalid_all(void)
 {
 #ifdef CONFIG_CPU_HAS_TLBI
-	asm volatile("tlbi.all\n":::"memory");
 	sync_is();
+	asm volatile(
+		"tlbi.all	\n"
+		"sync.i		\n"
+		:
+		:
+		: "memory");
 #else
 	tlb_invalid_all();
 #endif
@@ -100,12 +110,27 @@ static inline void tlb_invalid_indexed(void)
 	mtcr("cr<8, 15>", 0x02000000);
 }
 
-static inline void setup_pgd(pgd_t *pgd)
+#define NOP32 ".long 0x4820c400\n"
+
+static inline void setup_pgd(pgd_t *pgd, int asid)
 {
 #ifdef CONFIG_CPU_HAS_TLBI
-	mtcr("cr<28, 15>", __pa(pgd) | BIT(0));
+	sync_is();
+#else
+	mb();
+#endif
+	asm volatile(
+#ifdef CONFIG_CPU_HAS_TLBI
+		"mtcr %1, cr<28, 15>	\n"
 #endif
-	mtcr("cr<29, 15>", __pa(pgd) | BIT(0));
+		"mtcr %1, cr<29, 15>	\n"
+		"mtcr %0, cr< 4, 15>	\n"
+		".rept 64		\n"
+		NOP32
+		".endr			\n"
+		:
+		:"r"(asid), "r"(__pa(pgd) | BIT(0))
+		:"memory");
 }
 
 static inline pgd_t *get_pgd(void)
diff --git a/arch/csky/include/asm/mmu_context.h b/arch/csky/include/asm/mmu_context.h
index 3767dbffd02f..594167bbdc63 100644
--- a/arch/csky/include/asm/mmu_context.h
+++ b/arch/csky/include/asm/mmu_context.h
@@ -30,8 +30,7 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	if (prev != next)
 		check_and_switch_context(next, cpu);
 
-	setup_pgd(next->pgd);
-	write_mmu_entryhi(next->context.asid.counter);
+	setup_pgd(next->pgd, next->context.asid.counter);
 
 	flush_icache_deferred(next);
 }
diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
index 8170d7ce116b..bc05a3be9d57 100644
--- a/arch/csky/mm/init.c
+++ b/arch/csky/mm/init.c
@@ -164,7 +164,7 @@ void __init mmu_init(unsigned long min_pfn, unsigned long max_pfn)
 	/* Setup page mask to 4k */
 	write_mmu_pagemask(0);
 
-	setup_pgd(swapper_pg_dir);
+	setup_pgd(swapper_pg_dir, 0);
 }
 
 void __init fixrange_init(unsigned long start, unsigned long end,
diff --git a/arch/csky/mm/tlb.c b/arch/csky/mm/tlb.c
index ed1512381112..9234c5e5ceaf 100644
--- a/arch/csky/mm/tlb.c
+++ b/arch/csky/mm/tlb.c
@@ -24,7 +24,13 @@ void flush_tlb_all(void)
 void flush_tlb_mm(struct mm_struct *mm)
 {
 #ifdef CONFIG_CPU_HAS_TLBI
-	asm volatile("tlbi.asids %0"::"r"(cpu_asid(mm)));
+	sync_is();
+	asm volatile(
+		"tlbi.asids %0	\n"
+		"sync.i		\n"
+		:
+		: "r" (cpu_asid(mm))
+		: "memory");
 #else
 	tlb_invalid_all();
 #endif
@@ -53,11 +59,17 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 	end   &= TLB_ENTRY_SIZE_MASK;
 
 #ifdef CONFIG_CPU_HAS_TLBI
+	sync_is();
 	while (start < end) {
-		asm volatile("tlbi.vas %0"::"r"(start | newpid));
+		asm volatile(
+			"tlbi.vas %0	\n"
+			:
+			: "r" (start | newpid)
+			: "memory");
+
 		start += 2*PAGE_SIZE;
 	}
-	sync_is();
+	asm volatile("sync.i\n");
 #else
 	{
 	unsigned long flags, oldpid;
@@ -87,11 +99,17 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 	end   &= TLB_ENTRY_SIZE_MASK;
 
 #ifdef CONFIG_CPU_HAS_TLBI
+	sync_is();
 	while (start < end) {
-		asm volatile("tlbi.vaas %0"::"r"(start));
+		asm volatile(
+			"tlbi.vaas %0	\n"
+			:
+			: "r" (start)
+			: "memory");
+
 		start += 2*PAGE_SIZE;
 	}
-	sync_is();
+	asm volatile("sync.i\n");
 #else
 	{
 	unsigned long flags, oldpid;
@@ -121,8 +139,13 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 	addr &= TLB_ENTRY_SIZE_MASK;
 
 #ifdef CONFIG_CPU_HAS_TLBI
-	asm volatile("tlbi.vas %0"::"r"(addr | newpid));
 	sync_is();
+	asm volatile(
+		"tlbi.vas %0	\n"
+		"sync.i		\n"
+		:
+		: "r" (addr | newpid)
+		: "memory");
 #else
 	{
 	int oldpid, idx;
@@ -147,8 +170,13 @@ void flush_tlb_one(unsigned long addr)
 	addr &= TLB_ENTRY_SIZE_MASK;
 
 #ifdef CONFIG_CPU_HAS_TLBI
-	asm volatile("tlbi.vaas %0"::"r"(addr));
 	sync_is();
+	asm volatile(
+		"tlbi.vaas %0	\n"
+		"sync.i		\n"
+		:
+		: "r" (addr)
+		: "memory");
 #else
 	{
 	int oldpid, idx;
-- 
2.17.1


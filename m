Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03ABC2BFE2C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 03:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgKWC3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 21:29:21 -0500
Received: from foss.arm.com ([217.140.110.172]:51980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgKWC3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 21:29:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7D1E1042;
        Sun, 22 Nov 2020 18:29:20 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.82.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1B8D23F70D;
        Sun, 22 Nov 2020 18:29:16 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC 2/3] arm64/mm: Define arch_get_addressable_range()
Date:   Mon, 23 Nov 2020 07:58:48 +0530
Message-Id: <1606098529-7907-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606098529-7907-1-git-send-email-anshuman.khandual@arm.com>
References: <1606098529-7907-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This overrides arch_get_addressable_range() on arm64 platform which will be
used with recently added generic framework. It drops inside_linear_region()
and subsequent check in arch_add_memory() which are no longer required.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/memory.h |  3 +++
 arch/arm64/mm/mmu.c             | 19 +++++++++++--------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index cd61239bae8c..0ef7948eb58c 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -328,6 +328,9 @@ static inline void *phys_to_virt(phys_addr_t x)
 })
 
 void dump_mem_limit(void);
+
+#define arch_get_addressable_range arch_get_addressable_range
+struct range arch_get_addressable_range(bool need_mapping);
 #endif /* !ASSEMBLY */
 
 /*
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ca692a815731..a6433caf337f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1444,16 +1444,24 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
 	free_empty_tables(start, end, PAGE_OFFSET, PAGE_END);
 }
 
-static bool inside_linear_region(u64 start, u64 size)
+struct range arch_get_addressable_range(bool need_mapping)
 {
+	struct range memhp_range;
+
 	/*
 	 * Linear mapping region is the range [PAGE_OFFSET..(PAGE_END - 1)]
 	 * accommodating both its ends but excluding PAGE_END. Max physical
 	 * range which can be mapped inside this linear mapping range, must
 	 * also be derived from its end points.
 	 */
-	return start >= __pa(_PAGE_OFFSET(vabits_actual)) &&
-	       (start + size - 1) <= __pa(PAGE_END - 1);
+	if (need_mapping) {
+		memhp_range.start = __pa(_PAGE_OFFSET(vabits_actual));
+		memhp_range.end =  __pa(PAGE_END - 1);
+	} else {
+		memhp_range.start = 0;
+		memhp_range.end = (1ULL << (MAX_PHYSMEM_BITS + 1)) - 1;
+	}
+	return memhp_range;
 }
 
 int arch_add_memory(int nid, u64 start, u64 size,
@@ -1461,11 +1469,6 @@ int arch_add_memory(int nid, u64 start, u64 size,
 {
 	int ret, flags = 0;
 
-	if (!inside_linear_region(start, size)) {
-		pr_err("[%llx %llx] is outside linear mapping region\n", start, start + size);
-		return -EINVAL;
-	}
-
 	if (rodata_full || debug_pagealloc_enabled())
 		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
-- 
2.20.1


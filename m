Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94AB2B1483
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 04:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgKMDDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 22:03:24 -0500
Received: from foss.arm.com ([217.140.110.172]:60202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgKMDDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 22:03:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEF0C1042;
        Thu, 12 Nov 2020 19:03:22 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.79.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DFE223F6CF;
        Thu, 12 Nov 2020 19:03:18 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64/mm: Validate hotplug range before creating linear mapping
Date:   Fri, 13 Nov 2020 08:32:54 +0530
Message-Id: <1605236574-14636-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During memory hotplug process, the linear mapping should not be created for
a given memory range if that would fall outside the maximum allowed linear
range. Else it might cause memory corruption in the kernel virtual space.

Maximum linear mapping region is [PAGE_OFFSET..(PAGE_END -1)] accommodating
both its ends but excluding PAGE_END. Max physical range that can be mapped
inside this linear mapping range, must also be derived from its end points.

When CONFIG_ARM64_VA_BITS_52 is enabled, PAGE_OFFSET is computed with the
assumption of 52 bits virtual address space. However, if the CPU does not
support 52 bits, then it falls back using 48 bits instead and the PAGE_END
is updated to reflect this using the vabits_actual. As for PAGE_OFFSET,
bits [51..48] are ignored by the MMU and remain unchanged, even though the
effective start address of linear map is now slightly different. Hence, to
reliably check the physical address range mapped by the linear map, the
start address should be calculated using vabits_actual. This ensures that
arch_add_memory() validates memory hot add range for its potential linear
mapping requirement, before creating it with __create_pgd_mapping().

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Steven Price <steven.price@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Fixes: 4ab215061554 ("arm64: Add memory hotplug support")
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on 5.10-rc3

Changes in V2:

- Replaced (start + size) with (start + size - 1) in the comparison per Ard
- Dropped parenthesis brackets in the comparison per Ard

Changes in V1: (https://lore.kernel.org/linux-arm-kernel/1600332402-30123-1-git-send-email-anshuman.khandual@arm.com/)

 arch/arm64/mm/mmu.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 1c0f3e02f731..2dfbf46702cb 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1444,11 +1444,38 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
 	free_empty_tables(start, end, PAGE_OFFSET, PAGE_END);
 }
 
+static bool inside_linear_region(u64 start, u64 size)
+{
+	/*
+	 * Linear mapping region is the range [PAGE_OFFSET..(PAGE_END - 1)]
+	 * accommodating both its ends but excluding PAGE_END. Max physical
+	 * range which can be mapped inside this linear mapping range, must
+	 * also be derived from its end points.
+	 *
+	 * With CONFIG_ARM64_VA_BITS_52 enabled, PAGE_OFFSET is defined with
+	 * the assumption of 52 bits virtual address space. However, if the
+	 * CPU does not support 52 bits, it falls back using 48 bits and the
+	 * PAGE_END is updated to reflect this using the vabits_actual. As
+	 * for PAGE_OFFSET, bits [51..48] are ignored by the MMU and remain
+	 * unchanged, even though the effective start address of linear map
+	 * is now slightly different. Hence, to reliably check the physical
+	 * address range mapped by the linear map, the start address should
+	 * be calculated using vabits_actual.
+	 */
+	return (start >= __pa(_PAGE_OFFSET(vabits_actual)))
+			&& ((start + size - 1) <= __pa(PAGE_END - 1));
+}
+
 int arch_add_memory(int nid, u64 start, u64 size,
 		    struct mhp_params *params)
 {
 	int ret, flags = 0;
 
+	if (!inside_linear_region(start, size)) {
+		pr_err("[%llx %llx] is outside linear mapping region\n", start, start + size);
+		return -EINVAL;
+	}
+
 	if (rodata_full || debug_pagealloc_enabled())
 		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
-- 
2.20.1


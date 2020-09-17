Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FEA26D733
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgIQIzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:55:22 -0400
Received: from foss.arm.com ([217.140.110.172]:42712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbgIQIzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:55:18 -0400
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 04:55:17 EDT
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 034DC1FB;
        Thu, 17 Sep 2020 01:47:37 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.73.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 837433F718;
        Thu, 17 Sep 2020 01:47:33 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     will@kernel.org, catalin.marinas@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Validate hotplug range before creating linear mapping
Date:   Thu, 17 Sep 2020 14:16:42 +0530
Message-Id: <1600332402-30123-1-git-send-email-anshuman.khandual@arm.com>
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
 arch/arm64/mm/mmu.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 75df62fea1b6..d59ffabb9c84 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1433,11 +1433,38 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
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
+	return ((start >= __pa(_PAGE_OFFSET(vabits_actual)))
+			&& ((start + size) <= __pa(PAGE_END - 1)));
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB2D2C7D65
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgK3Daz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:30:55 -0500
Received: from foss.arm.com ([217.140.110.172]:48696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728316AbgK3Day (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:30:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C96F211FB;
        Sun, 29 Nov 2020 19:30:08 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.84.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6EE8C3F23F;
        Sun, 29 Nov 2020 19:30:05 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC V2 2/3] arm64/mm: Define arch_get_mappable_range()
Date:   Mon, 30 Nov 2020 08:59:51 +0530
Message-Id: <1606706992-26656-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606706992-26656-1-git-send-email-anshuman.khandual@arm.com>
References: <1606706992-26656-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This overrides arch_get_mappable_range() on arm64 platform which will be
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
 arch/arm64/mm/mmu.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ca692a815731..49ec8f2838f2 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1444,16 +1444,19 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
 	free_empty_tables(start, end, PAGE_OFFSET, PAGE_END);
 }
 
-static bool inside_linear_region(u64 start, u64 size)
+struct range arch_get_mappable_range(void)
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
+	memhp_range.start = __pa(_PAGE_OFFSET(vabits_actual));
+	memhp_range.end =  __pa(PAGE_END - 1);
+	return memhp_range;
 }
 
 int arch_add_memory(int nid, u64 start, u64 size,
@@ -1461,11 +1464,6 @@ int arch_add_memory(int nid, u64 start, u64 size,
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


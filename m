Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3452F1FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403981AbhAKTlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:41:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbhAKTlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:41:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F243022CA1;
        Mon, 11 Jan 2021 19:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610394032;
        bh=WE6SmDSLNbXYicMy6sA/x0SSQuVJJT63v1hLhctMFKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oMDXWWscG+8NNaI7+yGP/QMgY03rJlLXTX44ViO4vx+QanZ6ry+D443Vj/9A/8knb
         zvHTtHySdvgO3hoFj122f+QvthsfICBHF27jlhM/z/Rn0sQOzWFH3Wuh7Ehn9EwZY3
         GH8s2uszGSYxNH5tU+9fXdLtviQZZZFxugeFqZxYtd917k0uzd71xdpEgkk/MOhgZm
         LoVxzUd73D+qKgKVuxacDajKRBLDvJq4Faspq3LDprCzmIWSkbngBCsiY8CaG6Ejxx
         xvRM1I+6BRHDLwW/ldnjE+3ufFx+DubYl+fuS7X3abgJ33cB8Ddftm8Wtj8Q7IjC0e
         2zTXYV2ES0kzQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: [PATCH v3 1/2] x86/setup: don't remove E820_TYPE_RAM for pfn 0
Date:   Mon, 11 Jan 2021 21:40:16 +0200
Message-Id: <20210111194017.22696-2-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210111194017.22696-1-rppt@kernel.org>
References: <20210111194017.22696-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The first 4Kb of memory is a BIOS owned area and to avoid its allocation
for the kernel it was not listed in e820 tables as memory. As the result,
pfn 0 was never recognised by the generic memory management and it is not a
part of neither node 0 nor ZONE_DMA.

If set_pfnblock_flags_mask() would be ever called for the pageblock
corresponding to the first 2Mbytes of memory, having pfn 0 outside of
ZONE_DMA would trigger

	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);

Along with reserving the first 4Kb in e820 tables, several first pages are
reserved with memblock in several places during setup_arch(). These
reservations are enough to ensure the kernel does not touch the BIOS area
and it is not necessary to remove E820_TYPE_RAM for pfn 0.

Remove the update of e820 table that changes the type of pfn 0 and move the
comment describing why it was done to trim_low_memory_range() that reserves
the beginning of the memory.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/kernel/setup.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 740f3bdb3f61..3412c4595efd 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -660,17 +660,6 @@ static void __init trim_platform_memory_ranges(void)
 
 static void __init trim_bios_range(void)
 {
-	/*
-	 * A special case is the first 4Kb of memory;
-	 * This is a BIOS owned area, not kernel ram, but generally
-	 * not listed as such in the E820 table.
-	 *
-	 * This typically reserves additional memory (64KiB by default)
-	 * since some BIOSes are known to corrupt low memory.  See the
-	 * Kconfig help text for X86_RESERVE_LOW.
-	 */
-	e820__range_update(0, PAGE_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
-
 	/*
 	 * special case: Some BIOSes report the PC BIOS
 	 * area (640Kb -> 1Mb) as RAM even though it is not.
@@ -728,6 +717,15 @@ early_param("reservelow", parse_reservelow);
 
 static void __init trim_low_memory_range(void)
 {
+	/*
+	 * A special case is the first 4Kb of memory;
+	 * This is a BIOS owned area, not kernel ram, but generally
+	 * not listed as such in the E820 table.
+	 *
+	 * This typically reserves additional memory (64KiB by default)
+	 * since some BIOSes are known to corrupt low memory.  See the
+	 * Kconfig help text for X86_RESERVE_LOW.
+	 */
 	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
 }
 	
-- 
2.28.0


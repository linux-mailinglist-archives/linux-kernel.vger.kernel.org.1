Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766F12E06A5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 08:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgLVHNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 02:13:18 -0500
Received: from foss.arm.com ([217.140.110.172]:60760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgLVHNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 02:13:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEEDD11D4;
        Mon, 21 Dec 2020 23:12:31 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.86.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 63B1B3F718;
        Mon, 21 Dec 2020 23:12:28 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: [RFC 2/2] arm64/mm: Reorganize pfn_valid()
Date:   Tue, 22 Dec 2020 12:42:24 +0530
Message-Id: <1608621144-4001-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608621144-4001-1-git-send-email-anshuman.khandual@arm.com>
References: <1608621144-4001-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are multiple instances of pfn_to_section_nr() and __pfn_to_section()
when CONFIG_SPARSEMEM is enabled. This can be just optimized if the memory
section is fetched earlier. Hence bifurcate pfn_valid() into two different
definitions depending on whether CONFIG_SPARSEMEM is enabled. Also replace
the open coded pfn <--> addr conversion with __[pfn|phys]_to_[phys|pfn]().
This does not cause any functional change.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/init.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ee23bda00c28..c3387798a3be 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -212,18 +212,25 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 	free_area_init(max_zone_pfns);
 }
 
+#ifdef CONFIG_SPARSEMEM
 int pfn_valid(unsigned long pfn)
 {
-	phys_addr_t addr = pfn << PAGE_SHIFT;
+	struct mem_section *ms = __pfn_to_section(pfn);
+	phys_addr_t addr = __pfn_to_phys(pfn);
 
-	if ((addr >> PAGE_SHIFT) != pfn)
+	/*
+	 * Ensure the upper PAGE_SHIFT bits are clear in the
+	 * pfn. Else it might lead to false positives when
+	 * some of the upper bits are set, but the lower bits
+	 * match a valid pfn.
+	 */
+	if (__phys_to_pfn(addr) != pfn)
 		return 0;
 
-#ifdef CONFIG_SPARSEMEM
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
 
-	if (!valid_section(__pfn_to_section(pfn)))
+	if (!valid_section(ms))
 		return 0;
 
 	/*
@@ -235,11 +242,28 @@ int pfn_valid(unsigned long pfn)
 	 * memory sections covering all of hotplug memory including
 	 * both normal and ZONE_DEVIE based.
 	 */
-	if (!early_section(__pfn_to_section(pfn)))
+	if (!early_section(ms))
 		return 1;
-#endif
+
 	return memblock_is_map_memory(addr);
 }
+#else
+int pfn_valid(unsigned long pfn)
+{
+	phys_addr_t addr = __pfn_to_phys(pfn);
+
+	/*
+	 * Ensure the upper PAGE_SHIFT bits are clear in the
+	 * pfn. Else it might lead to false positives when
+	 * some of the upper bits are set, but the lower bits
+	 * match a valid pfn.
+	 */
+	if (__phys_to_pfn(addr) != pfn)
+		return 0;
+
+	return memblock_is_map_memory(addr);
+}
+#endif
 EXPORT_SYMBOL(pfn_valid);
 
 static phys_addr_t memory_limit = PHYS_ADDR_MAX;
-- 
2.20.1


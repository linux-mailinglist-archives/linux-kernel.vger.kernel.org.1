Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337AD2EA9C6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 12:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbhAELZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 06:25:03 -0500
Received: from foss.arm.com ([217.140.110.172]:53030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbhAELZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 06:25:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 401541FB;
        Tue,  5 Jan 2021 03:24:17 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.89.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 405893F70D;
        Tue,  5 Jan 2021 03:24:15 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Add warning for outside range requests in vmemmap_populate()
Date:   Tue,  5 Jan 2021 16:54:11 +0530
Message-Id: <1609845851-25064-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmemmap_populate() does not validate the requested vmemmap address range to
be inside the platform assigned space i.e [VMEMMAP_START..VMEMMAP_END] for
vmemmap. Instead it would just go ahead and create the mapping which might
then overlap with other sections in the kernel virtual address space.

Just adding an warning here for range overrun which would help detect the
problem earlier on, before a potential struct page corruption. This also
makes vmemmap_populate() symmetrical with vmemmap_free() which already has
a similar warning.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.11-rc2

 arch/arm64/mm/mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ae0c3d023824..f938e8020523 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1094,6 +1094,7 @@ static void free_empty_tables(unsigned long addr, unsigned long end,
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap)
 {
+	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
 	return vmemmap_populate_basepages(start, end, node, altmap);
 }
 #else	/* !ARM64_SWAPPER_USES_SECTION_MAPS */
@@ -1107,6 +1108,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	pud_t *pudp;
 	pmd_t *pmdp;
 
+	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
 	do {
 		next = pmd_addr_end(addr, end);
 
-- 
2.20.1


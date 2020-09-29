Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC1627D004
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbgI2Nzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:55:46 -0400
Received: from foss.arm.com ([217.140.110.172]:45226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbgI2Nzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:55:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C13BE31B;
        Tue, 29 Sep 2020 06:55:44 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 48E243F6CF;
        Tue, 29 Sep 2020 06:55:40 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, gshan@redhat.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V4 3/3] arm64/mm/hotplug: Ensure early memory sections are all online
Date:   Tue, 29 Sep 2020 19:24:47 +0530
Message-Id: <1601387687-6077-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601387687-6077-1-git-send-email-anshuman.khandual@arm.com>
References: <1601387687-6077-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a validation function that scans the entire boot memory and makes
sure that all early memory sections are online. This check is essential for
the memory notifier to work properly, as it cannot prevent any boot memory
from offlining, if all sections are not online to begin with. The notifier
registration is skipped, if this validation does not go through. Although
the boot section scanning is selectively enabled with DEBUG_VM.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/mmu.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 90a30f5ebfc0..b67a657ea1ad 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1522,6 +1522,62 @@ static struct notifier_block prevent_bootmem_remove_nb = {
 	.notifier_call = prevent_bootmem_remove_notifier,
 };
 
+/*
+ * This ensures that boot memory sections on the plaltform are online
+ * during early boot. They could not be prevented from being offlined
+ * if for some reason they are not brought online to begin with. This
+ * help validate the basic assumption on which the above memory event
+ * notifier works to prevent boot memory offlining and it's possible
+ * removal.
+ */
+static bool validate_bootmem_online(void)
+{
+	struct memblock_region *mblk;
+	struct mem_section *ms;
+	unsigned long pfn, end_pfn, start, end;
+	bool all_online = true;
+
+	/*
+	 * Scanning across all memblock might be expensive
+	 * on some big memory systems. Hence enable this
+	 * validation only with DEBUG_VM.
+	 */
+	if (!IS_ENABLED(CONFIG_DEBUG_VM))
+		return all_online;
+
+	for_each_memblock(memory, mblk) {
+		pfn = PHYS_PFN(mblk->base);
+		end_pfn = PHYS_PFN(mblk->base + mblk->size);
+
+		for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
+			ms = __pfn_to_section(pfn);
+
+			/*
+			 * All memory ranges in the system at this point
+			 * should have been marked early sections.
+			 */
+			WARN_ON(!early_section(ms));
+
+			/*
+			 * Memory notifier mechanism here to prevent boot
+			 * memory offlining depends on the fact that each
+			 * early section memory on the system is intially
+			 * online. Otherwise a given memory section which
+			 * is already offline will be overlooked and can
+			 * be removed completely. Call out such sections.
+			 */
+			if (!online_section(ms)) {
+				start = PFN_PHYS(pfn);
+				end = start + (1UL << PA_SECTION_SHIFT);
+				pr_err("Memory range [%lx %lx] is offline\n", start, end);
+				pr_err("Memory range [%lx %lx] can be removed\n", start, end);
+				all_online = false;
+			}
+		}
+	}
+	return all_online;
+}
+
 static int __init prevent_bootmem_remove_init(void)
 {
 	int ret = 0;
@@ -1529,6 +1585,9 @@ static int __init prevent_bootmem_remove_init(void)
 	if (!IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
 		return ret;
 
+	if (!validate_bootmem_online())
+		return -EINVAL;
+
 	ret = register_memory_notifier(&prevent_bootmem_remove_nb);
 	if (ret)
 		pr_err("%s: Notifier registration failed %d\n", __func__, ret);
-- 
2.20.1


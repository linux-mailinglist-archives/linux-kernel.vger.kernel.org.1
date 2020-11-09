Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798DA2AB02D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 05:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgKIE30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 23:29:26 -0500
Received: from foss.arm.com ([217.140.110.172]:33930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728038AbgKIE30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 23:29:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FE9D106F;
        Sun,  8 Nov 2020 20:29:25 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.78.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C6A843F6CF;
        Sun,  8 Nov 2020 20:29:21 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     gshan@redhat.com, Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V5 3/3] arm64/mm/hotplug: Ensure early memory sections are all online
Date:   Mon,  9 Nov 2020 09:58:57 +0530
Message-Id: <1604896137-16644-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604896137-16644-1-git-send-email-anshuman.khandual@arm.com>
References: <1604896137-16644-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a validation function that scans the entire boot memory and makes
sure that all early memory sections are online. This check is essential for
the memory notifier to work properly, as it cannot prevent any boot memory
from offlining, if all sections are not online to begin with. Although the
boot section scanning is selectively enabled with DEBUG_VM.

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
 arch/arm64/mm/mmu.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ca6d4952b733..f293f2222f50 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1538,6 +1538,53 @@ static struct notifier_block prevent_bootmem_remove_nb = {
 	.notifier_call = prevent_bootmem_remove_notifier,
 };
 
+/*
+ * This ensures that boot memory sections on the platform are online
+ * from early boot. Memory sections could not be prevented from being
+ * offlined, unless for some reason they are not online to begin with.
+ * This helps validate the basic assumption on which the above memory
+ * event notifier works to prevent boot memory section offlining and
+ * its possible removal.
+ */
+static void validate_bootmem_online(void)
+{
+	phys_addr_t start, end, addr;
+	struct mem_section *ms;
+	u64 i;
+
+	/*
+	 * Scanning across all memblock might be expensive
+	 * on some big memory systems. Hence enable this
+	 * validation only with DEBUG_VM.
+	 */
+	if (!IS_ENABLED(CONFIG_DEBUG_VM))
+		return;
+
+	for_each_mem_range(i, &start, &end) {
+		for (addr = start; addr < end; addr += (1UL << PA_SECTION_SHIFT)) {
+			ms = __pfn_to_section(PHYS_PFN(addr));
+
+			/*
+			 * All memory ranges in the system at this point
+			 * should have been marked as early sections.
+			 */
+			WARN_ON(!early_section(ms));
+
+			/*
+			 * Memory notifier mechanism here to prevent boot
+			 * memory offlining depends on the fact that each
+			 * early section memory on the system is initially
+			 * online. Otherwise a given memory section which
+			 * is already offline will be overlooked and can
+			 * be removed completely. Call out such sections.
+			 */
+			if (!online_section(ms))
+				pr_err("Boot memory [%llx %llx] is offline, can be removed\n",
+					addr, addr + (1UL << PA_SECTION_SHIFT));
+		}
+	}
+}
+
 static int __init prevent_bootmem_remove_init(void)
 {
 	int ret = 0;
@@ -1545,6 +1592,7 @@ static int __init prevent_bootmem_remove_init(void)
 	if (!IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
 		return ret;
 
+	validate_bootmem_online();
 	ret = register_memory_notifier(&prevent_bootmem_remove_nb);
 	if (ret)
 		pr_err("%s: Notifier registration failed %d\n", __func__, ret);
-- 
2.20.1


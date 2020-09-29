Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E732027D003
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbgI2Nzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:55:42 -0400
Received: from foss.arm.com ([217.140.110.172]:45210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbgI2Nzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:55:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0F7E31B;
        Tue, 29 Sep 2020 06:55:40 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 174353F6CF;
        Tue, 29 Sep 2020 06:55:36 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, gshan@redhat.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/3] arm64/mm/hotplug: Enable MEM_OFFLINE event handling
Date:   Tue, 29 Sep 2020 19:24:46 +0530
Message-Id: <1601387687-6077-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601387687-6077-1-git-send-email-anshuman.khandual@arm.com>
References: <1601387687-6077-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables MEM_OFFLINE memory event handling. It will help intercept any
possible error condition such as if boot memory some how still got offlined
even after an explicit notifier failure, potentially by a future change in
generic hot plug framework. This would help detect such scenarios and help
debug further. While here, also call out the first section being attempted
for offline or got offlined.

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
 arch/arm64/mm/mmu.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 4e70f4fea06c..90a30f5ebfc0 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1482,13 +1482,38 @@ static int prevent_bootmem_remove_notifier(struct notifier_block *nb,
 	unsigned long end_pfn = arg->start_pfn + arg->nr_pages;
 	unsigned long pfn = arg->start_pfn;
 
-	if (action != MEM_GOING_OFFLINE)
+	if ((action != MEM_GOING_OFFLINE) && (action != MEM_OFFLINE))
 		return NOTIFY_OK;
 
 	for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
+		unsigned long start = PFN_PHYS(pfn);
+		unsigned long end = start + (1UL << PA_SECTION_SHIFT);
+
 		ms = __pfn_to_section(pfn);
-		if (early_section(ms))
+		if (!early_section(ms))
+			continue;
+
+		if (action == MEM_GOING_OFFLINE) {
+			pr_warn("Boot memory [%lx %lx] offlining attempted\n", start, end);
 			return NOTIFY_BAD;
+		} else if (action == MEM_OFFLINE) {
+			/*
+			 * This should have never happened. Boot memory
+			 * offlining should have been prevented by this
+			 * very notifier. Probably some memory removal
+			 * procedure might have changed which would then
+			 * require further debug.
+			 */
+			pr_err("Boot memory [%lx %lx] offlined\n", start, end);
+
+			/*
+			 * Core memory hotplug does not process a return
+			 * code from the notifier for MEM_OFFLINE event.
+			 * Error condition has been reported. Report as
+			 * ignored.
+			 */
+			return NOTIFY_DONE;
+		}
 	}
 	return NOTIFY_OK;
 }
-- 
2.20.1


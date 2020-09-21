Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14FC272356
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgIUMGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:06:08 -0400
Received: from foss.arm.com ([217.140.110.172]:42038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbgIUMGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:06:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7E6AD6E;
        Mon, 21 Sep 2020 05:06:06 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.75.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F19A23F73B;
        Mon, 21 Sep 2020 05:06:02 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/3] arm64/mm/hotplug: Enable MEM_OFFLINE event handling
Date:   Mon, 21 Sep 2020 17:35:07 +0530
Message-Id: <1600689908-28213-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600689908-28213-1-git-send-email-anshuman.khandual@arm.com>
References: <1600689908-28213-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables MEM_OFFLINE memory event handling. It will help intercept any
possible error condition such as if boot memory some how still got offlined
even after an explicit notifier failure, potentially by a future change in
generic hot plug framework. This would help detect such scenarios and help
debug further.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/mmu.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index df3b7415b128..6b171bd88bcf 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1482,13 +1482,40 @@ static int prevent_bootmem_remove_notifier(struct notifier_block *nb,
 	unsigned long end_pfn = arg->start_pfn + arg->nr_pages;
 	unsigned long pfn = arg->start_pfn;
 
-	if (action != MEM_GOING_OFFLINE)
+	if ((action != MEM_GOING_OFFLINE) && (action != MEM_OFFLINE))
 		return NOTIFY_OK;
 
-	for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
-		ms = __pfn_to_section(pfn);
-		if (early_section(ms))
-			return NOTIFY_BAD;
+	if (action == MEM_GOING_OFFLINE) {
+		for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
+			ms = __pfn_to_section(pfn);
+			if (early_section(ms)) {
+				pr_warn("Boot memory offlining attempted\n");
+				return NOTIFY_BAD;
+			}
+		}
+	} else if (action == MEM_OFFLINE) {
+		for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
+			ms = __pfn_to_section(pfn);
+			if (early_section(ms)) {
+
+				/*
+				 * This should have never happened. Boot memory
+				 * offlining should have been prevented by this
+				 * very notifier. Probably some memory removal
+				 * procedure might have changed which would then
+				 * require further debug.
+				 */
+				pr_err("Boot memory offlined\n");
+
+				/*
+				 * Core memory hotplug does not process a return
+				 * code from the notifier for MEM_OFFLINE event.
+				 * Error condition has been reported. Report as
+				 * ignored.
+				 */
+				return NOTIFY_DONE;
+			}
+		}
 	}
 	return NOTIFY_OK;
 }
-- 
2.20.1


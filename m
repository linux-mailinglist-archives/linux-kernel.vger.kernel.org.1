Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4151A935F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 08:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634937AbgDOGkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 02:40:35 -0400
Received: from foss.arm.com ([217.140.110.172]:38190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634919AbgDOGkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 02:40:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FC971042;
        Tue, 14 Apr 2020 23:40:31 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 14A233F73D;
        Tue, 14 Apr 2020 23:44:37 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        will@kernel.com, mark.rutland@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64/hotplug: Process MEM_OFFLINE and MEM_CANCEL_OFFLINE
Date:   Wed, 15 Apr 2020 12:09:44 +0530
Message-Id: <1586932784-16315-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586932784-16315-1-git-send-email-anshuman.khandual@arm.com>
References: <1586932784-16315-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Process MEM_OFFLINE and MEM_CANCEL_OFFLINE memory events to intercept any
possible error conditions during memory offline operation. This includes if
boot memory still got offlined even after an expilicit notifier failure or
if non-boot memory got declined for an offline request. This help improve
memory notifier robustness while also enhancing debug capabilities during
various potential memory offlining error conditions.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Steve Capper <steve.capper@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/mmu.c | 52 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a374e4f51a62..48c71d8a29b2 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1422,13 +1422,55 @@ static int prevent_bootmem_remove_notifier(struct notifier_block *nb,
 	unsigned long end_pfn = arg->start_pfn + arg->nr_pages;
 	unsigned long pfn = arg->start_pfn;
 
-	if (action != MEM_GOING_OFFLINE)
+	if ((action != MEM_GOING_OFFLINE) && (action != MEM_OFFLINE) &&
+		(action != MEM_CANCEL_OFFLINE))
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
+				return NOTIFY_BAD;
+			}
+		}
+	} else if (action == MEM_CANCEL_OFFLINE) {
+		enum offline_failure_reason reason = *(int *)arg->data;
+
+		if (reason != OFFLINE_FAILURE_NOTIFIER)
+			return NOTIFY_OK;
+
+		for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
+			ms = __pfn_to_section(pfn);
+			if (early_section(ms))
+				return NOTIFY_OK;
+		}
+
+		/*
+		 * This should have never happened. Non boot memory
+		 * offlining should never have been prevented from
+		 * this notifier. Probably some memory hot removal
+		 * procedure might have changed which would then
+		 * require further debug.
+		 */
+		pr_err("Notifier declined non boot memory offlining\n");
+		return NOTIFY_BAD;
 	}
 	return NOTIFY_OK;
 }
-- 
2.20.1


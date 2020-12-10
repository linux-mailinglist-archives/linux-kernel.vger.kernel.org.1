Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417B22D5A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 13:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732630AbgLJMNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 07:13:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:57116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387506AbgLJMMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:12:38 -0500
From:   Will Deacon <will@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mohamed Alzayat <alzayat@mpi-sws.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org
Subject: [PATCH v2 6/6] x86/ldt: Use tlb_gather_mmu_fullmm() when freeing LDT page-tables
Date:   Thu, 10 Dec 2020 12:11:10 +0000
Message-Id: <20201210121110.10094-7-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201210121110.10094-1-will@kernel.org>
References: <20201210121110.10094-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_ldt_pgtables() uses the MMU gather API for batching TLB flushes
over the call to free_pgd_range(). However, tlb_gather_mmu() expects
to operate on user addresses and so passing LDT_{BASE,END}_ADDR will
confuse the range setting logic in __tlb_adjust_range(), causing the
gather to identify a range starting at TASK_SIZE. Such a large range
will be converted into a 'fullmm' flush by the low-level invalidation
code, so change the caller to invoke tlb_gather_mmu_fullmm() directly.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/x86/kernel/ldt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 7ad9834e0d95..aa15132228da 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -398,7 +398,13 @@ static void free_ldt_pgtables(struct mm_struct *mm)
 	if (!boot_cpu_has(X86_FEATURE_PTI))
 		return;
 
-	tlb_gather_mmu(&tlb, mm);
+	/*
+	 * Although free_pgd_range() is intended for freeing user
+	 * page-tables, it also works out for kernel mappings on x86.
+	 * We use tlb_gather_mmu_fullmm() to avoid confusing the
+	 * range-tracking logic in __tlb_adjust_range().
+	 */
+	tlb_gather_mmu_fullmm(&tlb, mm);
 	free_pgd_range(&tlb, start, end, start, end);
 	tlb_finish_mmu(&tlb);
 #endif
-- 
2.29.2.576.ga3fc446d84-goog


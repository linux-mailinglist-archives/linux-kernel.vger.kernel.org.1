Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A242D5A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 13:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbgLJMNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 07:13:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727921AbgLJMMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Subject: [PATCH v2 5/6] tlb: arch: Remove empty __tlb_remove_tlb_entry() stubs
Date:   Thu, 10 Dec 2020 12:11:09 +0000
Message-Id: <20201210121110.10094-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201210121110.10094-1-will@kernel.org>
References: <20201210121110.10094-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If __tlb_remove_tlb_entry() is not defined by the architecture then
we provide an empty definition in asm-generic/tlb.h.

Remove the redundant empty definitions for sparc64 and x86.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/sparc/include/asm/tlb_64.h | 1 -
 arch/x86/include/asm/tlb.h      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/sparc/include/asm/tlb_64.h b/arch/sparc/include/asm/tlb_64.h
index e841cae544c2..779a5a0f0608 100644
--- a/arch/sparc/include/asm/tlb_64.h
+++ b/arch/sparc/include/asm/tlb_64.h
@@ -24,7 +24,6 @@ void flush_tlb_pending(void);
 
 #define tlb_start_vma(tlb, vma) do { } while (0)
 #define tlb_end_vma(tlb, vma)	do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 #define tlb_flush(tlb)	flush_tlb_pending()
 
 /*
diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 820082bd6880..1bfe979bb9bc 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -4,7 +4,6 @@
 
 #define tlb_start_vma(tlb, vma) do { } while (0)
 #define tlb_end_vma(tlb, vma) do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 
 #define tlb_flush tlb_flush
 static inline void tlb_flush(struct mmu_gather *tlb);
-- 
2.29.2.576.ga3fc446d84-goog


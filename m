Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA1327E954
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbgI3NTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:19:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728232AbgI3NTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:19:05 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90E5920738;
        Wed, 30 Sep 2020 13:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601471944;
        bh=xXwgvQQAurB3YdZNJN7j/uIxum5KBO2WKM4ORDoKOH8=;
        h=From:To:Cc:Subject:Date:From;
        b=qaPfLAq4Afl+manZ9XW892TGoZlYxg3LtgOBHjyaMD0w0Cl1LTu7Gby3TzzcKc0V5
         iNQhesAir4EcUWZAG8NvbXvw4eg5EnA3XWnEC8SDLme9k9u1yymXbr14hnyQUwHfH9
         sVNIp1H54JA5KdDfFe7wlmFTOoHm46GVEqzXv9ro=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH] arm64: mm: Make flush_tlb_fix_spurious_fault() a no-op
Date:   Wed, 30 Sep 2020 14:18:59 +0100
Message-Id: <20200930131859.16989-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our use of broadcast TLB maintenance means that spurious page-faults
that have been handled already by another CPU do not require additional
TLB maintenance.

Make flush_tlb_fix_spurious_fault() a no-op and rely on the existing TLB
invalidation instead. Add an explicit flush_tlb_page() when making a page
dirty, as the TLB is permitted to cache the old read-only entry.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20200728092220.GA21800@willie-the-truck
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 8 ++++++++
 arch/arm64/mm/fault.c            | 4 +++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index bc68da9f5706..02ad3105c14c 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -50,6 +50,14 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
 	__flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+/*
+ * Outside of a few very special situations (e.g. hibernation), we always
+ * use broadcast TLB invalidation instructions, therefore a spurious page
+ * fault on one CPU which has been handled concurrently by another CPU
+ * does not need to perform additional invalidation.
+ */
+#define flush_tlb_fix_spurious_fault(vma, address) do { } while (0)
+
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index f07333e86c2f..a696a7921da4 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -218,7 +218,9 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 		pteval = cmpxchg_relaxed(&pte_val(*ptep), old_pteval, pteval);
 	} while (pteval != old_pteval);
 
-	flush_tlb_fix_spurious_fault(vma, address);
+	/* Invalidate a stale read-only entry */
+	if (dirty)
+		flush_tlb_page(vma, address);
 	return 1;
 }
 
-- 
2.28.0.709.gb0816b6eb0-goog


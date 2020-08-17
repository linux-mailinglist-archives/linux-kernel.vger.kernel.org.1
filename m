Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2701246322
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 11:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgHQJUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 05:20:40 -0400
Received: from foss.arm.com ([217.140.110.172]:51636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbgHQJUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:20:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 551021045;
        Mon, 17 Aug 2020 02:20:34 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.65.199])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 464803F6CF;
        Mon, 17 Aug 2020 02:20:31 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64/mm: Change THP helpers to comply with generic MM semantics
Date:   Mon, 17 Aug 2020 14:49:43 +0530
Message-Id: <1597655984-15428-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597655984-15428-1-git-send-email-anshuman.khandual@arm.com>
References: <1597655984-15428-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pmd_present() and pmd_trans_huge() are expected to behave in the following
manner during various phases of a given PMD. It is derived from a previous
detailed discussion on this topic [1] and present THP documentation [2].

pmd_present(pmd):

- Returns true if pmd refers to system RAM with a valid pmd_page(pmd)
- Returns false if pmd does not refer to system RAM - Invalid pmd_page(pmd)

pmd_trans_huge(pmd):

- Returns true if pmd refers to system RAM and is a trans huge mapping

-------------------------------------------------------------------------
|	PMD states	|	pmd_present	|	pmd_trans_huge	|
-------------------------------------------------------------------------
|	Mapped		|	Yes		|	Yes		|
-------------------------------------------------------------------------
|	Splitting	|	Yes		|	Yes		|
-------------------------------------------------------------------------
|	Migration/Swap	|	No		|	No		|
-------------------------------------------------------------------------

The problem:

PMD is first invalidated with pmdp_invalidate() before it's splitting. This
invalidation clears PMD_SECT_VALID as below.

PMD Split -> pmdp_invalidate() -> pmd_mkinvalid -> Clears PMD_SECT_VALID

Once PMD_SECT_VALID gets cleared, it results in pmd_present() return false
on the PMD entry. It will need another bit apart from PMD_SECT_VALID to re-
affirm pmd_present() as true during the THP split process. To comply with
above mentioned semantics, pmd_trans_huge() should also check pmd_present()
first before testing presence of an actual transparent huge mapping.

The solution:

Ideally PMD_TYPE_SECT should have been used here instead. But it shares the
bit position with PMD_SECT_VALID which is used for THP invalidation. Hence
it will not be there for pmd_present() check after pmdp_invalidate().

A new software defined PMD_PRESENT_INVALID (bit 59) can be set on the PMD
entry during invalidation which can help pmd_present() return true and in
recognizing the fact that it still points to memory.

This bit is transient. During the split process it will be overridden by a
page table page representing normal pages in place of erstwhile huge page.
Other pmdp_invalidate() callers always write a fresh PMD value on the entry
overriding this transient PMD_PRESENT_INVALID bit, which makes it safe.

[1]: https://lkml.org/lkml/2018/10/17/231
[2]: https://www.kernel.org/doc/Documentation/vm/transhuge.txt

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable-prot.h |  7 ++++++
 arch/arm64/include/asm/pgtable.h      | 34 ++++++++++++++++++++++++---
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 4d867c6446c4..28792fdd9627 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -19,6 +19,13 @@
 #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
 #define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
 
+/*
+ * This help indicate that the entry is present i.e pmd_page()
+ * still points to a valid huge page in memory even if the pmd
+ * has been invalidated.
+ */
+#define PMD_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PMD_SECT_VALID */
+
 #ifndef __ASSEMBLY__
 
 #include <asm/cpufeature.h>
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index d5d3fbe73953..7aa69cace784 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -145,6 +145,18 @@ static inline pte_t set_pte_bit(pte_t pte, pgprot_t prot)
 	return pte;
 }
 
+static inline pmd_t clr_pmd_bit(pmd_t pmd, pgprot_t prot)
+{
+	pmd_val(pmd) &= ~pgprot_val(prot);
+	return pmd;
+}
+
+static inline pmd_t set_pmd_bit(pmd_t pmd, pgprot_t prot)
+{
+	pmd_val(pmd) |= pgprot_val(prot);
+	return pmd;
+}
+
 static inline pte_t pte_wrprotect(pte_t pte)
 {
 	pte = clear_pte_bit(pte, __pgprot(PTE_WRITE));
@@ -363,15 +375,24 @@ static inline int pmd_protnone(pmd_t pmd)
 }
 #endif
 
+#define pmd_present_invalid(pmd)     (!!(pmd_val(pmd) & PMD_PRESENT_INVALID))
+
+static inline int pmd_present(pmd_t pmd)
+{
+	return pte_present(pmd_pte(pmd)) || pmd_present_invalid(pmd);
+}
+
 /*
  * THP definitions.
  */
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define pmd_trans_huge(pmd)	(pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
+static inline int pmd_trans_huge(pmd_t pmd)
+{
+	return pmd_val(pmd) && pmd_present(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-#define pmd_present(pmd)	pte_present(pmd_pte(pmd))
 #define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
 #define pmd_young(pmd)		pte_young(pmd_pte(pmd))
 #define pmd_valid(pmd)		pte_valid(pmd_pte(pmd))
@@ -381,7 +402,14 @@ static inline int pmd_protnone(pmd_t pmd)
 #define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
-#define pmd_mkinvalid(pmd)	(__pmd(pmd_val(pmd) & ~PMD_SECT_VALID))
+
+static inline pmd_t pmd_mkinvalid(pmd_t pmd)
+{
+	pmd = set_pmd_bit(pmd, __pgprot(PMD_PRESENT_INVALID));
+	pmd = clr_pmd_bit(pmd, __pgprot(PMD_SECT_VALID));
+
+	return pmd;
+}
 
 #define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
 
-- 
2.20.1


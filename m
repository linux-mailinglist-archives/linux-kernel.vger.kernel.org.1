Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609831F9775
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 14:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbgFOM6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 08:58:08 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:14441 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730129AbgFOM6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:58:01 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49lrwQ0wthz9v1fl;
        Mon, 15 Jun 2020 14:57:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id aXFx7kJdYhJB; Mon, 15 Jun 2020 14:57:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49lrwQ06Xvz9v1fM;
        Mon, 15 Jun 2020 14:57:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 77D768B796;
        Mon, 15 Jun 2020 14:57:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 25kJTR5Pyx86; Mon, 15 Jun 2020 14:57:58 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3308A8B75F;
        Mon, 15 Jun 2020 14:57:58 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2DB5265B0E; Mon, 15 Jun 2020 12:57:58 +0000 (UTC)
Message-Id: <087fa12b6e920e32315136b998aa834f99242695.1592225558.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1592225557.git.christophe.leroy@csgroup.eu>
References: <cover.1592225557.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 2/3] mm: Allow arches to provide ptep_get()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Date:   Mon, 15 Jun 2020 12:57:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 2ab3a0a02905 ("READ_ONCE: Enforce atomicity for
{READ,WRITE}_ONCE() memory accesses"), it is not possible anymore
to use READ_ONCE() to access complex page table entries like
the one defined for powerpc 8xx with 16k size pages.

Define a ptep_get() helper that architectures can override instead
of performing a READ_ONCE() on the page table entry pointer.

Fixes: 2ab3a0a02905 ("READ_ONCE: Enforce atomicity for {READ,WRITE}_ONCE() memory accesses")
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/asm-generic/hugetlb.h | 2 +-
 include/linux/pgtable.h       | 7 +++++++
 mm/gup.c                      | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 40f85decc2ee..8e1e6244a89d 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -122,7 +122,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 #ifndef __HAVE_ARCH_HUGE_PTEP_GET
 static inline pte_t huge_ptep_get(pte_t *ptep)
 {
-	return READ_ONCE(*ptep);
+	return ptep_get(ptep);
 }
 #endif
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 32b6c52d41b9..56c1e8eb7bb0 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -249,6 +249,13 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 }
 #endif
 
+#ifndef __HAVE_ARCH_PTEP_GET
+static inline pte_t ptep_get(pte_t *ptep)
+{
+	return READ_ONCE(*ptep);
+}
+#endif
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #ifndef __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
diff --git a/mm/gup.c b/mm/gup.c
index 761df4944ef5..6f47697f8fb0 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2196,7 +2196,7 @@ static inline pte_t gup_get_pte(pte_t *ptep)
  */
 static inline pte_t gup_get_pte(pte_t *ptep)
 {
-	return READ_ONCE(*ptep);
+	return ptep_get(ptep);
 }
 #endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
 
-- 
2.25.0


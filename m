Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9CF1C7716
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 18:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgEFQsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 12:48:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:2642 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730430AbgEFQsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:48:19 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49HMwc1lg8z9v4kL;
        Wed,  6 May 2020 18:48:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id jtASpwUJimnB; Wed,  6 May 2020 18:48:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49HMwc0szKz9v4kF;
        Wed,  6 May 2020 18:48:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D32498B7C5;
        Wed,  6 May 2020 18:48:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kaieKq_lwJck; Wed,  6 May 2020 18:48:17 +0200 (CEST)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 878DD8B7C3;
        Wed,  6 May 2020 18:48:17 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 564C465911; Wed,  6 May 2020 16:48:17 +0000 (UTC)
Message-Id: <6dec030615efb66f937d05496afe5626549d2cdf.1588783498.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1588783498.git.christophe.leroy@csgroup.eu>
References: <cover.1588783498.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 12/45] powerpc/ptdump: Properly handle non standard page
 size
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  6 May 2020 16:48:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to properly display information regardless of the page size,
it is necessary to take into account real page size.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Fixes: cabe8138b23c ("powerpc: dump as a single line areas mapping a single physical page.")
Cc: stable@vger.kernel.org
---
 arch/powerpc/mm/ptdump/ptdump.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index 1f97668853e3..64434b66f240 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -60,6 +60,7 @@ struct pg_state {
 	unsigned long start_address;
 	unsigned long start_pa;
 	unsigned long last_pa;
+	unsigned long page_size;
 	unsigned int level;
 	u64 current_flags;
 	bool check_wx;
@@ -168,9 +169,9 @@ static void dump_addr(struct pg_state *st, unsigned long addr)
 #endif
 
 	pt_dump_seq_printf(st->seq, REG "-" REG " ", st->start_address, addr - 1);
-	if (st->start_pa == st->last_pa && st->start_address + PAGE_SIZE != addr) {
+	if (st->start_pa == st->last_pa && st->start_address + st->page_size != addr) {
 		pt_dump_seq_printf(st->seq, "[" REG "]", st->start_pa);
-		delta = PAGE_SIZE >> 10;
+		delta = st->page_size >> 10;
 	} else {
 		pt_dump_seq_printf(st->seq, " " REG " ", st->start_pa);
 		delta = (addr - st->start_address) >> 10;
@@ -195,10 +196,11 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
 }
 
 static void note_page(struct pg_state *st, unsigned long addr,
-	       unsigned int level, u64 val)
+	       unsigned int level, u64 val, int shift)
 {
 	u64 flag = val & pg_level[level].mask;
 	u64 pa = val & PTE_RPN_MASK;
+	unsigned long page_size = 1 << shift;
 
 	/* At first no level is set */
 	if (!st->level) {
@@ -207,6 +209,7 @@ static void note_page(struct pg_state *st, unsigned long addr,
 		st->start_address = addr;
 		st->start_pa = pa;
 		st->last_pa = pa;
+		st->page_size = page_size;
 		pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
 	/*
 	 * Dump the section of virtual memory when:
@@ -218,7 +221,7 @@ static void note_page(struct pg_state *st, unsigned long addr,
 	 */
 	} else if (flag != st->current_flags || level != st->level ||
 		   addr >= st->marker[1].start_address ||
-		   (pa != st->last_pa + PAGE_SIZE &&
+		   (pa != st->last_pa + st->page_size &&
 		    (pa != st->start_pa || st->start_pa != st->last_pa))) {
 
 		/* Check the PTE flags */
@@ -246,6 +249,7 @@ static void note_page(struct pg_state *st, unsigned long addr,
 		st->start_address = addr;
 		st->start_pa = pa;
 		st->last_pa = pa;
+		st->page_size = page_size;
 		st->current_flags = flag;
 		st->level = level;
 	} else {
@@ -261,7 +265,7 @@ static void walk_pte(struct pg_state *st, pmd_t *pmd, unsigned long start)
 
 	for (i = 0; i < PTRS_PER_PTE; i++, pte++) {
 		addr = start + i * PAGE_SIZE;
-		note_page(st, addr, 4, pte_val(*pte));
+		note_page(st, addr, 4, pte_val(*pte), PAGE_SHIFT);
 
 	}
 }
@@ -278,7 +282,7 @@ static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
 			/* pmd exists */
 			walk_pte(st, pmd, addr);
 		else
-			note_page(st, addr, 3, pmd_val(*pmd));
+			note_page(st, addr, 3, pmd_val(*pmd), PTE_SHIFT);
 	}
 }
 
@@ -294,7 +298,7 @@ static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
 			/* pud exists */
 			walk_pmd(st, pud, addr);
 		else
-			note_page(st, addr, 2, pud_val(*pud));
+			note_page(st, addr, 2, pud_val(*pud), PMD_SHIFT);
 	}
 }
 
@@ -313,7 +317,7 @@ static void walk_pagetables(struct pg_state *st)
 			/* pgd exists */
 			walk_pud(st, pgd, addr);
 		else
-			note_page(st, addr, 1, pgd_val(*pgd));
+			note_page(st, addr, 1, pgd_val(*pgd), PUD_SHIFT);
 	}
 }
 
@@ -368,7 +372,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 
 	/* Traverse kernel page tables */
 	walk_pagetables(&st);
-	note_page(&st, 0, 0, 0);
+	note_page(&st, 0, 0, 0, 0);
 	return 0;
 }
 
-- 
2.25.0


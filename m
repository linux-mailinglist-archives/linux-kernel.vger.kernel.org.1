Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609D12C835E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387422AbgK3Ljt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbgK3Ljs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:39:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDE4C061A47
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 03:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=xH6cVi24iSh0Z6RI2Sd+J27ye9DAHC3TEE3Mr7hJfxo=; b=sNy3qGAiEjXLyHzpUioeA1iNVj
        kxI/wm2ONT9/EW9Zy5jZI/BdH6tiIDmN86xxtJv+KEpCwA3EtMI2Pq2kGJ/UClCZMFOPPU+/KQ+Qq
        9VmH/LYfiWgUoyzrDHdHK9+Xq9Bllz0/IpZrZn4arQDnBBU+Xxv2GVPTz7vwkpXDR7k7M071B8Ewt
        4AmGRWfggI2KBA2GifsgP2Um2Qtrf7x2OmeO6LWeHiCjDonbzYVM4SJURDcziUVKVMjxXvqkLmeir
        vCzPO2buys+Ka7Bh3R4k5iWhnZrhihoTQK+btdTaHWvEtwLsCp62RKwSMV7tfFaIY69bR81HrgbHl
        Zuxwguyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjhVc-0007Qp-6R; Mon, 30 Nov 2020 11:38:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 37E6D3077E1;
        Mon, 30 Nov 2020 12:38:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 006072B84F9CB; Mon, 30 Nov 2020 12:38:17 +0100 (CET)
Message-ID: <20201130113603.324154533@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 30 Nov 2020 12:27:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, peterz@infradead.org
Subject: [RFC][PATCH 9/9] x86/mm/pae: Be consistent with pXXp_get_and_clear()
References: <20201130112705.900705277@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given that ptep_get_and_clear() uses cmpxchg8b, and that should be by
far the most common case, there's no point in having an optimized
variant for pmd/pud.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/pgtable-3level.h |   34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -108,14 +108,13 @@ static inline pte_t native_ptep_get_and_
 #ifdef CONFIG_SMP
 static inline pmd_t native_pmdp_get_and_clear(pmd_t *pmdp)
 {
-	pmd_t res;
+	pmd_t old;
 
-	/* xchg acts as a barrier before setting of the high bits */
-	res.pmd_low = xchg(&pmdp->pmd_low, 0);
-	res.pmd_high = READ_ONCE(pmdp->pmd_high);
-	WRITE_ONCE(pmdp->pmd_high, 0);
+	do {
+		old = *pmdp;
+	} while (cmpxchg64(&pmdp->pmd, old.pmd, 0ULL) != old.pmd);
 
-	return res;
+	return old;
 }
 #else
 #define native_pmdp_get_and_clear(xp) native_local_pmdp_get_and_clear(xp)
@@ -151,28 +150,15 @@ static inline pmd_t pmdp_establish(struc
 #endif
 
 #ifdef CONFIG_SMP
-union split_pud {
-	struct {
-		u32 pud_low;
-		u32 pud_high;
-	};
-	pud_t pud;
-};
-
 static inline pud_t native_pudp_get_and_clear(pud_t *pudp)
 {
-	union split_pud res, *orig = (union split_pud *)pudp;
+	pud_t old;
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-	pti_set_user_pgtbl(&pudp->p4d.pgd, __pgd(0));
-#endif
-
-	/* xchg acts as a barrier before setting of the high bits */
-	res.pud_low = xchg(&orig->pud_low, 0);
-	res.pud_high = orig->pud_high;
-	orig->pud_high = 0;
+	do {
+		old = *pudp;
+	} while (cmpxchg64(&pudp->pud, old.pud, 0ULL) != old.pud);
 
-	return res.pud;
+	return old;
 }
 #else
 #define native_pudp_get_and_clear(xp) native_local_pudp_get_and_clear(xp)



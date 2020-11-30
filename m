Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2C22C835C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgK3LjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbgK3LjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:39:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4743CC0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 03:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=f4g92HolWEIcUN5sHQre4J13ebXNQzotEK5t5/pJgYg=; b=nVErVX4kx+o9OjH/bg2ppeww7q
        wtGoAs11AZd7qKjpkmAcJ3C4Ay0JfPzveCcIRguanHrKAAJM+oiSfvTwmS46L6fh70lCf4g27qUy/
        PN5zperMQcjygmWj2pRcD91mVsCuOhq/Q0vWeMCxFipB+m4kXm2qzmiT+/SoUn7oU0pLHGQA1qx2j
        UF7W0KA9QvPnznSF6TvhEgq6gAZXa6xPqcC7GYdNbiJDy+DSHMzvBfnZJlrYIkiCQxLD3eI11sBe0
        AydvPyfKm50jvfvJtGL8aWLNz6yXsNv1nytu7gf0ocWanej63lgwXkNL+tYUAsnggi/ArjsB0U/oP
        PV8CLKeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjhVa-0007Qd-Rm; Mon, 30 Nov 2020 11:38:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E68FC30477A;
        Mon, 30 Nov 2020 12:38:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D4FE02B84F9C4; Mon, 30 Nov 2020 12:38:17 +0100 (CET)
Message-ID: <20201130113602.900215647@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 30 Nov 2020 12:27:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, peterz@infradead.org
Subject: [RFC][PATCH 2/9] x86/mm/pae: Make pmd_t similar to pte_t
References: <20201130112705.900705277@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of mucking about with at least 2 different ways of fudging
it, do the same thing we do for pte_t.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/pgtable-3level.h       |   42 +++++++++-------------------
 arch/x86/include/asm/pgtable-3level_types.h |    7 ++++
 arch/x86/include/asm/pgtable_64_types.h     |    1 
 arch/x86/include/asm/pgtable_types.h        |    4 --
 4 files changed, 23 insertions(+), 31 deletions(-)

--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -87,7 +87,7 @@ static inline pmd_t pmd_read_atomic(pmd_
 		ret |= ((pmdval_t)*(tmp + 1)) << 32;
 	}
 
-	return (pmd_t) { ret };
+	return (pmd_t) { .pmd = ret };
 }
 
 static inline void native_set_pte_atomic(pte_t *ptep, pte_t pte)
@@ -121,12 +121,11 @@ static inline void native_pte_clear(stru
 	ptep->pte_high = 0;
 }
 
-static inline void native_pmd_clear(pmd_t *pmd)
+static inline void native_pmd_clear(pmd_t *pmdp)
 {
-	u32 *tmp = (u32 *)pmd;
-	*tmp = 0;
+	pmdp->pmd_low = 0;
 	smp_wmb();
-	*(tmp + 1) = 0;
+	pmdp->pmd_high = 0;
 }
 
 static inline void native_pud_clear(pud_t *pudp)
@@ -162,25 +161,17 @@ static inline pte_t native_ptep_get_and_
 #define native_ptep_get_and_clear(xp) native_local_ptep_get_and_clear(xp)
 #endif
 
-union split_pmd {
-	struct {
-		u32 pmd_low;
-		u32 pmd_high;
-	};
-	pmd_t pmd;
-};
-
 #ifdef CONFIG_SMP
 static inline pmd_t native_pmdp_get_and_clear(pmd_t *pmdp)
 {
-	union split_pmd res, *orig = (union split_pmd *)pmdp;
+	pmd_t res;
 
 	/* xchg acts as a barrier before setting of the high bits */
-	res.pmd_low = xchg(&orig->pmd_low, 0);
-	res.pmd_high = orig->pmd_high;
-	orig->pmd_high = 0;
+	res.pmd_low = xchg(&pmdp->pmd_low, 0);
+	res.pmd_high = READ_ONCE(pmdp->pmd_high);
+	WRITE_ONCE(pmdp->pmd_high, 0);
 
-	return res.pmd;
+	return res;
 }
 #else
 #define native_pmdp_get_and_clear(xp) native_local_pmdp_get_and_clear(xp)
@@ -199,17 +190,12 @@ static inline pmd_t pmdp_establish(struc
 	 * anybody.
 	 */
 	if (!(pmd_val(pmd) & _PAGE_PRESENT)) {
-		union split_pmd old, new, *ptr;
-
-		ptr = (union split_pmd *)pmdp;
-
-		new.pmd = pmd;
-
 		/* xchg acts as a barrier before setting of the high bits */
-		old.pmd_low = xchg(&ptr->pmd_low, new.pmd_low);
-		old.pmd_high = ptr->pmd_high;
-		ptr->pmd_high = new.pmd_high;
-		return old.pmd;
+		old.pmd_low = xchg(&pmdp->pmd_low, pmd.pmd_low);
+		old.pmd_high = READ_ONCE(pmdp->pmd_high);
+		WRITE_ONCE(pmdp->pmd_high, pmd.pmd_high);
+
+		return old;
 	}
 
 	do {
--- a/arch/x86/include/asm/pgtable-3level_types.h
+++ b/arch/x86/include/asm/pgtable-3level_types.h
@@ -18,6 +18,13 @@ typedef union {
 	};
 	pteval_t pte;
 } pte_t;
+
+typedef union {
+	struct {
+		unsigned long pmd_low, pmd_high;
+	};
+	pmdval_t pmd;
+} pmd_t;
 #endif	/* !__ASSEMBLY__ */
 
 #define SHARED_KERNEL_PMD	(!static_cpu_has(X86_FEATURE_PTI))
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -19,6 +19,7 @@ typedef unsigned long	pgdval_t;
 typedef unsigned long	pgprotval_t;
 
 typedef struct { pteval_t pte; } pte_t;
+typedef struct { pmdval_t pmd; } pmd_t;
 
 #ifdef CONFIG_X86_5LEVEL
 extern unsigned int __pgtable_l5_enabled;
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -381,11 +381,9 @@ static inline pudval_t native_pud_val(pu
 #endif
 
 #if CONFIG_PGTABLE_LEVELS > 2
-typedef struct { pmdval_t pmd; } pmd_t;
-
 static inline pmd_t native_make_pmd(pmdval_t val)
 {
-	return (pmd_t) { val };
+	return (pmd_t) { .pmd = val };
 }
 
 static inline pmdval_t native_pmd_val(pmd_t pmd)



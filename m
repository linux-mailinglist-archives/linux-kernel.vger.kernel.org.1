Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE30E2C8361
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgK3Ljv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbgK3Ljs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:39:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7355CC061A48
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 03:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=V9QjUriZDqhHtbmhIGOJQ2OP24LyJ0914LVzwONP/5E=; b=IntvTR+I8tJ7fMvRMnYS9SHGv2
        5QTX0u3Exk+2zImll++TftJj9uAShEAa0kGy23ztNLIE5FLk3maTTHXVEimUEglqS6mDzKC4xcGQp
        bhUOhy38oOdmsupqMBaKTZOsq6SQus4an4hbMDGS4mcZ2MRchReKPNvL/OqZm6aCcXOIFQUCPcYvt
        +Xtg7s+lMOa9IUwAZVpr9edcR+8VvE87kj3Ijt9X3qXUF/KlZZWMbHV80nym1hF4ijCzh86CdAjNg
        0Vj0nMh5mt0b1zl/vabbQkoq1YMdppfUKs0uuqW9LosNXePQ9LuRYm0OR+S7MTNj8X7cLLD4p19/7
        lpI2/QUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjhVc-0007Qq-5B; Mon, 30 Nov 2020 11:38:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 37EB430785A;
        Mon, 30 Nov 2020 12:38:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EF3D92B84F9CA; Mon, 30 Nov 2020 12:38:17 +0100 (CET)
Message-ID: <20201130113603.264918968@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 30 Nov 2020 12:27:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, peterz@infradead.org
Subject: [RFC][PATCH 8/9] x86/mm/pae: Use WRITE_ONCE()
References: <20201130112705.900705277@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/pgtable-3level.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -27,9 +27,9 @@
  */
 static inline void native_set_pte(pte_t *ptep, pte_t pte)
 {
-	ptep->pte_high = pte.pte_high;
+	WRITE_ONCE(ptep->pte_high, pte.pte_high);
 	smp_wmb();
-	ptep->pte_low = pte.pte_low;
+	WRITE_ONCE(ptep->pte_low, pte.pte_low);
 }
 
 static inline void native_set_pte_atomic(pte_t *ptep, pte_t pte)
@@ -58,14 +58,14 @@ static inline void native_set_pud(pud_t
 static inline void native_pte_clear(struct mm_struct *mm, unsigned long addr,
 				    pte_t *ptep)
 {
-	ptep->pte_low = 0;
+	WRITE_ONCE(ptep->pte_low, 0);
 	smp_wmb();
-	ptep->pte_high = 0;
+	WRITE_ONCE(ptep->pte_high, 0);
 }
 
 static inline void native_pmd_clear(pmd_t *pmdp)
 {
-	pmdp->pmd_low = 0;
+	WRITE_ONCE(pmdp->pmd_low, 0);
 	smp_wmb();
 	pmdp->pmd_high = 0;
 }



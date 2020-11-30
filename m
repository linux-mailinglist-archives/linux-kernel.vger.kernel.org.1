Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF582C835A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgK3LjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgK3LjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:39:08 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA20C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 03:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=p4owENHTSGpOxSLxjnv01cC/b4aSY2KNSrKXKhQFpp0=; b=2/ThSzwGx8iKGWVBXcvf+IhJ95
        tu7jvyTICS7JwwwSKX20c35Lpo6UlFWfAqTGCKkGGcO7izqEDpnTa3kioX8M1La2C2NwzGmtXHVnA
        bDptqOsODjFjZKrt4I/NY0vtaY8OZwAffyjLnPMKywcT5wJCwM5YhBkBgpx3tO8DHoAIEUTeE5xnx
        Jb9WaHWZYpt00qnD7JQMbSOPypOIXGgUd3NivAB4VHk3LuCH1venb1emG+bYDo2tPvmyuYjYrrVsy
        m5HLED4lbjB+Uq+TUbbkVr5jCVPTPxtStatP2fMSkYgDVIxzshiZSUq+vCHbGeIToei25DPYkYccD
        qoAKEj2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjhVc-0006CV-Gb; Mon, 30 Nov 2020 11:38:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E3C19302753;
        Mon, 30 Nov 2020 12:38:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D10902B84F9AE; Mon, 30 Nov 2020 12:38:17 +0100 (CET)
Message-ID: <20201130113602.841001656@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 30 Nov 2020 12:27:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, peterz@infradead.org
Subject: [RFC][PATCH 1/9] mm: Update ptep_get_lockless()s comment
References: <20201130112705.900705277@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the comment and add a lockdep assertion because nobody reads
comments.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/pgtable.h |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -260,15 +260,12 @@ static inline pte_t ptep_get(pte_t *ptep
 
 #ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
 /*
- * WARNING: only to be used in the get_user_pages_fast() implementation.
- *
- * With get_user_pages_fast(), we walk down the pagetables without taking any
- * locks.  For this we would like to load the pointers atomically, but sometimes
- * that is not possible (e.g. without expensive cmpxchg8b on x86_32 PAE).  What
- * we do have is the guarantee that a PTE will only either go from not present
- * to present, or present to not present or both -- it will not switch to a
- * completely different present page without a TLB flush in between; something
- * that we are blocking by holding interrupts off.
+ * For walking the pagetables without holding any locks.  Some architectures
+ * (eg x86-32 PAE) cannot load the entries atomically without using expensive
+ * instructions.  We are guaranteed that a PTE will only either go from not
+ * present to present, or present to not present -- it will not switch to a
+ * completely different present page without a TLB flush inbetween; which we
+ * are blocking by holding interrupts off.
  *
  * Setting ptes from not present to present goes:
  *
@@ -294,6 +291,8 @@ static inline pte_t ptep_get_lockless(pt
 {
 	pte_t pte;
 
+	lockdep_assert_irqs_disabled();
+
 	do {
 		pte.pte_low = ptep->pte_low;
 		smp_rmb();



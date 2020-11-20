Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B31E2BADC0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgKTPJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbgKTPJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:09:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C68C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SvuJ0Yggw//XkE7jbGBD/osU1sxNXLlG/4aodz1frU0=; b=i5O7Fp/EzeqJzhjLWGIElPmQE/
        lX22PPAxwrgL7qVXXRChT3Wzz6uMgwRJf1wrw6hPIPPwWgUGomuSA5LXlzWXyO0eD72K6Bu7LBWAH
        vWieSG3s+8IDY+sP+yM152D9xUq/6stV2+kOtdnlRHc31APiS21EGTKMzJ0t/Cy7GdVjKg3qncgUL
        uG3xzJtcxMCrg0ZanzTbKZaokfCguuXV0KOD55UzzhG0e/BwFkHF3XSAlNb0u4sMT9vOn1mofe17S
        LdjVM/3IpRTNx/Tcc9hCD69lAZa4dWrh1ynzGAfFW98MdufJvI9sL255Xf5NpiG0s2E8I3M0p13gA
        i42K6Q2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg82V-00018B-N2; Fri, 20 Nov 2020 15:09:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E133B300B22;
        Fri, 20 Nov 2020 16:09:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CCE04201B4C48; Fri, 20 Nov 2020 16:09:30 +0100 (CET)
Date:   Fri, 20 Nov 2020 16:09:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] mm: proc: Invalidate TLB after clearing soft-dirty
 page state
Message-ID: <20201120150930.GC3092@hirez.programming.kicks-ass.net>
References: <20201120143557.6715-1-will@kernel.org>
 <20201120143557.6715-5-will@kernel.org>
 <20201120150023.GH3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120150023.GH3040@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 04:00:23PM +0100, Peter Zijlstra wrote:

> If you look at __tlb_remove_tlb_entry()

... you'll also find we can probably do this ... :-)

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

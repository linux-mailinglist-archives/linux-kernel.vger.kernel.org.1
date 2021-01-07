Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EADD2ECDAD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbhAGKTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbhAGKTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:19:01 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD52C0612F6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 02:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Yj23qabr6dDcCDmE/NapfputR+pGYNOjt0nOFO5sR9g=; b=I9IBYk/3y/pNo66bsxGlm/JJ+i
        DYAwEIDNCM4XgJLxyrzxZM42jEiZMrWmkoXM1JndTXyNXr/IlY1QiIS83+5nZcoixE8CQvTsNog0Q
        azo/beOPAr5V5oQF+l2F7Y/ke6+pW7VnLwx6G8XKhWYPdLptXfMd5rzOSkUkwb52C24KnI3+MZbSR
        CCmAFwUFbwBb4hMxRuO8u4OcOEp9LYYynYq5yDqEdt6eSK4nIB+o3M2BFE+5OF5MTncJr9nWylFRh
        mnl0XqnF1ddgLnSM+qVHBMZQoECXEzK8szD9Hsxlb8QRFeR6j+HNlRsrCQwfHBy8SlUohTHGtiUlJ
        fr9DGZcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxSMr-0000t7-3x; Thu, 07 Jan 2021 10:18:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 601963003E5;
        Thu,  7 Jan 2021 11:18:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DD078203D1B58; Thu,  7 Jan 2021 11:18:06 +0100 (CET)
Date:   Thu, 7 Jan 2021 11:18:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        sfr@canb.auug.org.au, tony.luck@intel.com
Subject: [PATCH 7/6] x86: __always_inline __{rd,wr}msr()
Message-ID: <X/bf3gV+BW7kGEsB@hirez.programming.kicks-ass.net>
References: <20210106143619.479313782@infradead.org>
 <20210106144017.532902065@infradead.org>
 <dc6e7e19-881a-c778-22df-15176db4aeb9@infradead.org>
 <X/bWK1tNB6mtm0Bu@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/bWK1tNB6mtm0Bu@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 10:36:43AM +0100, Peter Zijlstra wrote:
> On Wed, Jan 06, 2021 at 09:59:17AM -0800, Randy Dunlap wrote:
> > On 1/6/21 6:36 AM, Peter Zijlstra wrote:
> > > When the compiler fails to inline; we violate nonisntr:
> > > 
> > >   vmlinux.o: warning: objtool: __sev_es_nmi_complete()+0xc7: call to sev_es_wr_ghcb_msr() leaves .noinstr.text section
> > 
> > I am still seeing (a variant of) this one:
> > 
> > vmlinux.o: warning: objtool: __sev_es_nmi_complete()+0xce: call to __wrmsr.constprop.14() leaves .noinstr.text section
> 
> Gah, sorry, I managed to mess up my .config :/ /me goes try again.

OK, restored your original .config and that did indeed reproduce, the
below cures it.

---

Subject: x86: __always_inline __{rd,wr}msr()
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Jan  7 11:14:25 CET 2021

When the compiler choses to not inline the trivial MSR helpers:

  vmlinux.o: warning: objtool: __sev_es_nmi_complete()+0xce: call to __wrmsr.constprop.14() leaves .noinstr.text section

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/msr.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -86,7 +86,7 @@ static inline void do_trace_rdpmc(unsign
  * think of extending them - you will be slapped with a stinking trout or a frozen
  * shark will reach you, wherever you are! You've been warned.
  */
-static inline unsigned long long notrace __rdmsr(unsigned int msr)
+static __always_inline unsigned long long __rdmsr(unsigned int msr)
 {
 	DECLARE_ARGS(val, low, high);
 
@@ -98,7 +98,7 @@ static inline unsigned long long notrace
 	return EAX_EDX_VAL(val, low, high);
 }
 
-static inline void notrace __wrmsr(unsigned int msr, u32 low, u32 high)
+static __always_inline void __wrmsr(unsigned int msr, u32 low, u32 high)
 {
 	asm volatile("1: wrmsr\n"
 		     "2:\n"

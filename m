Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35AA27BFAF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgI2Ih2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbgI2Ih2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:37:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99E6C061755;
        Tue, 29 Sep 2020 01:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v5vnDoRc4ZKtko7VMYgaivypIuJCC2NRDarrflWRAvg=; b=wWOWiQjkvkGZA1s8deLmbxrNC8
        pTcycx1AeIheWo8YKmtblar3DRLp4W61abEUjEJyP6RQBpMuYfWiHkySwLN/XA6JkCQXmj8t5s5H/
        oFAZHBivV6j7ACxy+E4raYd9VO8ksiOruct0gnGWydfhvRUM+VdKBDXOamN5yEIv4NLtIiPcVUyMf
        Lb0luWbwFDoxRIZ9VHp2TQDv7OMm2pYTdkcd9xZcVQn+IPU3jabWtekFvK3qKFJfpyUWhIOP/bGYN
        spFFSPleU3snhac//usQJYmy4VJla5oUw7Oer4n+RZNQ5R+j5pcykZc+j4KpAHiH0jqHzccHH7L3D
        gdzi9qwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNB8J-00031e-Pr; Tue, 29 Sep 2020 08:37:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 60639303F45;
        Tue, 29 Sep 2020 10:37:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42614211CC1CA; Tue, 29 Sep 2020 10:37:09 +0200 (CEST)
Date:   Tue, 29 Sep 2020 10:37:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Balbir Singh <sblbir@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech
Subject: Re: [PATCH -next for tip:x86/pti] x86/tlb: drop unneeded local vars
 in enable_l1d_flush_for_task()
Message-ID: <20200929083709.GC2651@hirez.programming.kicks-ass.net>
References: <20200928124457.27289-1-lukas.bulwahn@gmail.com>
 <20200929071211.GJ2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929071211.GJ2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 09:12:11AM +0200, Peter Zijlstra wrote:
> On Mon, Sep 28, 2020 at 02:44:57PM +0200, Lukas Bulwahn wrote:
> > diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> > index 6b0f4c88b07c..90515c04d90a 100644
> > --- a/arch/x86/mm/tlb.c
> > +++ b/arch/x86/mm/tlb.c
> > @@ -316,7 +316,7 @@ EXPORT_SYMBOL_GPL(leave_mm);
> >  
> >  int enable_l1d_flush_for_task(struct task_struct *tsk)
> >  {
> > -	int cpu, ret = 0, i;
> > +	int i;
> >  
> >  	/*
> >  	 * Do not enable L1D_FLUSH_OUT if
> > @@ -329,7 +329,7 @@ int enable_l1d_flush_for_task(struct task_struct *tsk)
> >  			!static_cpu_has(X86_FEATURE_FLUSH_L1D))
> >  		return -EINVAL;
> >  
> > -	cpu = get_cpu();
> > +	get_cpu();
> >  
> >  	for_each_cpu(i, &tsk->cpus_mask) {
> >  		if (cpu_data(i).smt_active == true) {
> > @@ -340,7 +340,7 @@ int enable_l1d_flush_for_task(struct task_struct *tsk)
> >  
> >  	set_ti_thread_flag(&tsk->thread_info, TIF_SPEC_L1D_FLUSH);
> >  	put_cpu();
> > -	return ret;
> > +	return 0;
> >  }
> 
> If you don't use the return value of get_cpu(), then change it over to
> preempt_{dis,en}able(), but this got me looking at the function, wtf is
> that garbage supposed to do in the first place
> 
> What do we need to disable preemption for?
> 
> Please explain the desired semantics against sched_setaffinity().

Here, I fixed it..

---
 arch/x86/mm/tlb.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 6b0f4c88b07c..f02a2f1909da 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -316,31 +316,13 @@ EXPORT_SYMBOL_GPL(leave_mm);
 
 int enable_l1d_flush_for_task(struct task_struct *tsk)
 {
-	int cpu, ret = 0, i;
-
-	/*
-	 * Do not enable L1D_FLUSH_OUT if
-	 * b. The CPU is not affected by the L1TF bug
-	 * c. The CPU does not have L1D FLUSH feature support
-	 * c. The task's affinity is on cores with SMT on.
-	 */
-
 	if (!boot_cpu_has_bug(X86_BUG_L1TF) ||
-			!static_cpu_has(X86_FEATURE_FLUSH_L1D))
+	    !boot_cpu_has(X86_FEATURE_FLUSH_L1D) ||
+	    sched_smt_active());
 		return -EINVAL;
 
-	cpu = get_cpu();
-
-	for_each_cpu(i, &tsk->cpus_mask) {
-		if (cpu_data(i).smt_active == true) {
-			put_cpu();
-			return -EINVAL;
-		}
-	}
-
 	set_ti_thread_flag(&tsk->thread_info, TIF_SPEC_L1D_FLUSH);
-	put_cpu();
-	return ret;
+	return 0;
 }
 
 int disable_l1d_flush_for_task(struct task_struct *tsk)

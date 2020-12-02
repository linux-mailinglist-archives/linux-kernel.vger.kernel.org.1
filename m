Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDED2CB8A5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbgLBJWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729120AbgLBJWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:22:07 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB61C0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 01:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2rFcSRuZVvEch9aYPi7pOkDWiBpD4eppOVgEsD2/az4=; b=Jt+ZX7bbz7Oowba4Sts2LEHA6B
        ZD2RVUwVFtstKpb5TesHgPli/NAm3UrxUQBYBIP5gn8HOWLH+UxezCx/Q1pDf6CXpZSbCBieXX1Zl
        OL7w3aMhwaogf5bz/oRL7gv1xvAJRV8nuorEZ4DMUX3buaqVJh75dWBNO0GoMS3z10X863xD2Tkgf
        6ou2VYSAJtKx7loJuGoyre/qMbgc9/ODcOT3veg+txZfnqVtoSAq1H0u6WCln9Bdp5yEQNJzCFGBG
        RzP8M15AheNn2bNNXmrsULDSiiMRMm2kzrk1yinKUKXKkmY89tsCXwy5LJBC59WVvzCXWJQ5LedQU
        GjINtmBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkOK8-00022E-7u; Wed, 02 Dec 2020 09:21:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 947A03059DD;
        Wed,  2 Dec 2020 10:21:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 803E12C87A73E; Wed,  2 Dec 2020 10:21:16 +0100 (CET)
Date:   Wed, 2 Dec 2020 10:21:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
Message-ID: <20201202092116.GA3040@hirez.programming.kicks-ass.net>
References: <CAHk-=whSdxfCW3YpoZafPaCD_DQsuxFWMKLyYFsdGWL2wu9haQ@mail.gmail.com>
 <dcdb13e3-36a0-031d-6ec3-3ab5ee4a69cb@de.ibm.com>
 <20201201080734.GQ2414@hirez.programming.kicks-ass.net>
 <20201201110724.GL3092@hirez.programming.kicks-ass.net>
 <20201201144644.GF1437@paulmck-ThinkPad-P72>
 <20201201145519.GY2414@hirez.programming.kicks-ass.net>
 <20201201181506.GM3092@hirez.programming.kicks-ass.net>
 <20201201185737.GA93208@C02TD0UTHF1T.local>
 <20201201191441.GW3040@hirez.programming.kicks-ass.net>
 <20201201191856.GD8316@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201191856.GD8316@osiris>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 08:18:56PM +0100, Heiko Carstens wrote:

> Is there a reason why this should be considered broken?

AFAICT this is good.

> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> index 26bb0603c5a1..92beb1444644 100644
> --- a/arch/s390/kernel/entry.S
> +++ b/arch/s390/kernel/entry.S
> @@ -763,12 +763,7 @@ ENTRY(io_int_handler)
>  	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
>  	TSTMSK	__LC_CPU_FLAGS,_CIF_IGNORE_IRQ
>  	jo	.Lio_restore
> -#if IS_ENABLED(CONFIG_TRACE_IRQFLAGS)
> -	tmhh	%r8,0x300
> -	jz	1f
>  	TRACE_IRQS_OFF
> -1:
> -#endif
>  	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
>  .Lio_loop:
>  	lgr	%r2,%r11		# pass pointer to pt_regs
> @@ -791,12 +786,7 @@ ENTRY(io_int_handler)
>  	TSTMSK	__LC_CPU_FLAGS,_CIF_WORK
>  	jnz	.Lio_work
>  .Lio_restore:
> -#if IS_ENABLED(CONFIG_TRACE_IRQFLAGS)
> -	tm	__PT_PSW(%r11),3
> -	jno	0f
>  	TRACE_IRQS_ON
> -0:
> -#endif
>  	mvc	__LC_RETURN_PSW(16),__PT_PSW(%r11)
>  	tm	__PT_PSW+1(%r11),0x01	# returning to user ?
>  	jno	.Lio_exit_kernel
> @@ -976,12 +966,7 @@ ENTRY(ext_int_handler)
>  	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
>  	TSTMSK	__LC_CPU_FLAGS,_CIF_IGNORE_IRQ
>  	jo	.Lio_restore
> -#if IS_ENABLED(CONFIG_TRACE_IRQFLAGS)
> -	tmhh	%r8,0x300
> -	jz	1f
>  	TRACE_IRQS_OFF
> -1:
> -#endif
>  	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
>  	lgr	%r2,%r11		# pass pointer to pt_regs
>  	lghi	%r3,EXT_INTERRUPT

OK, so with a little help from s390/PoO and Sven, the code removed skips
the TRACE_IRQS_OFF when IRQs were enabled in the old PSW (the previous
context).

That sounds entirely the right thing. Irrespective of what the previous
IRQ state was, the current state is off.

> diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
> index 2b85096964f8..5bd8c1044d09 100644
> --- a/arch/s390/kernel/idle.c
> +++ b/arch/s390/kernel/idle.c
> @@ -123,7 +123,6 @@ void arch_cpu_idle_enter(void)
>  void arch_cpu_idle(void)
>  {
>  	enabled_wait();
> -	raw_local_irq_enable();
>  }

Currently arch_cpu_idle() is defined as to return with IRQs enabled,
however, the very first thing we do when we return is
raw_local_irq_disable(), so this change is harmless.

It is also the direction I've been arguing for elsewhere in this thread.
So I'm certainly not complaining.


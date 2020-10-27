Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B028C29A659
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894515AbgJ0IQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:16:33 -0400
Received: from casper.infradead.org ([90.155.50.34]:34334 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395394AbgJ0IQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/XSGJSszBAu9aJyHiBSKxP/faTdqnmxLUZDOyavfUMg=; b=G0DJKiyDWc9Uj2URstInjG+S81
        NZTnxMY62qkTkejxfZtF5FfZ13o6BeLTIPc9xJhXbn+uWH9kBQD0kYRmRxD36vwr/5fvpy8Pfb5zv
        c+Rwr8rHTsQSSF3TI7Bhnfy3g2/+fdy37DWzoXait02sVtKlHwpvyVfoKgw+E0lzOWpCsnP4m/RTa
        6T2T9o2m6Fkna5kgSSX52aOAtsigkay9VW015mW4C5jVkVIiqaMS/HTvSksIbsfKCStMwV0nMfKtm
        FVTjYecy8TxGY2oXRpJAqqheCLLaA+ySh1RD7WrcNofQB3gLNPuCTHT0OTPBx/Vfd8v6GQOVBgBtX
        C1+TocNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXK9A-0001EV-Qx; Tue, 27 Oct 2020 08:16:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E019A3060F2;
        Tue, 27 Oct 2020 09:15:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CBAAF2127D318; Tue, 27 Oct 2020 09:15:59 +0100 (CET)
Date:   Tue, 27 Oct 2020 09:15:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kyle Huey <me@kylehuey.com>,
        open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Robert O'Callahan <rocallahan@gmail.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [REGRESSION] x86/debug: After PTRACE_SINGLESTEP DR_STEP is no
 longer reported in dr6
Message-ID: <20201027081559.GI2628@hirez.programming.kicks-ass.net>
References: <CAP045Ar5CtqknH66i5ti6xOvo9cC9ib5v-5+3fFKcp_DW91hYw@mail.gmail.com>
 <20201026155521.GQ2594@hirez.programming.kicks-ass.net>
 <20201026160513.GC2651@hirez.programming.kicks-ass.net>
 <CAP045ApB_9h5Pp=a0L+taA6qFURrR6Se+W77Vb7A_VOWJNKfng@mail.gmail.com>
 <20201026163100.GR2594@hirez.programming.kicks-ass.net>
 <20201026165519.GD2651@hirez.programming.kicks-ass.net>
 <CALCETrVwzcpk88jWeNb+iCGBFsyzgbZ0E9_x330A2P-CMzSr4g@mail.gmail.com>
 <CALCETrXwS0CtPuX7AgUorrPDis7Czd_ngO1=FG0=VqGS8Ru+JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXwS0CtPuX7AgUorrPDis7Czd_ngO1=FG0=VqGS8Ru+JA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 04:45:18PM -0700, Andy Lutomirski wrote:

> PeterZ, this new scheme of having handlers clear bits in dr6 to
> consume them and set bits in virtual_dr6 to send signals is
> incomprehensible -- there is no possible way to read traps.c and tell
> what the code does :(

IIRC, it was you who suggested it. Also the old code was equally
incomprehensible. Now it has actual semantics.

> I attached a test case.  I'll make a real patch out of this in a bit.
> This passes on 5.8, and I haven't tested it yet on 5.10-rc1.  The real
> patch will also test ICEBP, and I'm sure we'll be quite unhappy with
> the result of that.

> diff --git a/tools/testing/selftests/x86/single_step_syscall.c b/tools/testing/selftests/x86/single_step_syscall.c
> index 5a4c6e06872e..f6abefd4066e 100644
> --- a/tools/testing/selftests/x86/single_step_syscall.c
> +++ b/tools/testing/selftests/x86/single_step_syscall.c
> @@ -72,7 +72,6 @@ static unsigned char altstack_data[SIGSTKSZ];
>  static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
>  {
>  	ucontext_t *ctx = (ucontext_t*)ctx_void;
> -	unsigned long dr6 = info->si_code;
>  
>  	if (get_eflags() & X86_EFLAGS_TF) {
>  		set_eflags(get_eflags() & ~X86_EFLAGS_TF);
> @@ -89,7 +88,10 @@ static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
>  		       (unsigned long)ctx->uc_mcontext.gregs[REG_IP]);
>  	}
>  
> -	printf("DR6 = 0x%lx\n", dr6);
> +	if (info->si_code != TRAP_TRACE) {
> +		printf("[FAIL]\tsi_code was 0x%lx; should have been TRAP_TRACE (0x%lx)\n", (unsigned long)info->si_code, (unsigned long)TRAP_TRACE);
> +		_exit(1);
> +	}
>  }

That actually works (tested). Nothing here cares about the virtual_dr6 value.

Think of virtual_dr6 as the value used by ptrace_{get,set}_debugreg(6).
It (should) only contain bits that results from other ptrace() actions.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9254A1FD0C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 17:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgFQPT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 11:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgFQPT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 11:19:59 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499FAC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 08:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9xgWNrz/EjgA9082VEmXpJMV85vsTTWYygZBrxi4Mgg=; b=eOiyRfktcbd7m8heLEaqnQxZWe
        ZvGIuBrWN6bL9I+RWtsFHpmsMTH0r/L8xuLwvz/pstcX/6q+WwZOLJiNU2QmBTbP8bO0tvExGMvH/
        8zwpfwve/mBAmpMmvinNHLW33N7Tc9iCOt8XWeNVv8Jr18wCSJMRrCi3lfWuQMdGXvfHoThZPAo9f
        +1HTAiYV4wT/v9gwqanDuH35MFPNPAeVpEhMjqpGkBCKtYyyuA1sA2Wdqo0cnbVIbh/2efmdWGSim
        sRiIb7C+4DoDSxbkj0e+yi9rqMqgPxJKe3a3gY/EMINztbFcOnvhshvy7pw3zNBufLKljSXzaEfuH
        b/jyx2YQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlZqd-0007cZ-05; Wed, 17 Jun 2020 15:19:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 42D57301DFC;
        Wed, 17 Jun 2020 17:19:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2DDD220C227A8; Wed, 17 Jun 2020 17:19:28 +0200 (CEST)
Date:   Wed, 17 Jun 2020 17:19:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, ndesaulniers@google.com
Subject: Re: [PATCH -tip v3 1/2] kcov: Make runtime functions
 noinstr-compatible
Message-ID: <20200617151928.GA577403@hirez.programming.kicks-ass.net>
References: <CACT4Y+aKVKEp1yoBYSH0ebJxeqKj8TPR9MVtHC1Mh=jgX0ZvLw@mail.gmail.com>
 <20200612114900.GA187027@google.com>
 <CACT4Y+bBtCbEk2tg60gn5bgfBjARQFBgtqkQg8VnLLg5JwyL5g@mail.gmail.com>
 <CANpmjNM+Tcn40MsfFKvKxNTtev-TXDsosN+z9ATL8hVJdK1yug@mail.gmail.com>
 <20200615142949.GT2531@hirez.programming.kicks-ass.net>
 <20200615145336.GA220132@google.com>
 <20200615150327.GW2531@hirez.programming.kicks-ass.net>
 <20200615152056.GF2554@hirez.programming.kicks-ass.net>
 <20200617143208.GA56208@elver.google.com>
 <20200617144949.GA576905@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617144949.GA576905@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 04:49:49PM +0200, Peter Zijlstra wrote:

> I had the below, except of course that yields another objtool
> complaint, and I was still looking at that.

This cures it.

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5fbb90a80d239..fe0d6f1b28d7c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2746,7 +2746,7 @@ int check(const char *_objname, bool orc)
 
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
-	file.c_file = find_section_by_name(file.elf, ".comment");
+	file.c_file = !vmlinux && find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;


> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index af75109485c26..a7d1570905727 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -690,13 +690,13 @@ struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
>  		(struct bad_iret_stack *)__this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
>  
>  	/* Copy the IRET target to the temporary storage. */
> -	memcpy(&tmp.regs.ip, (void *)s->regs.sp, 5*8);
> +	__memcpy(&tmp.regs.ip, (void *)s->regs.sp, 5*8);
>  
>  	/* Copy the remainder of the stack from the current stack. */
> -	memcpy(&tmp, s, offsetof(struct bad_iret_stack, regs.ip));
> +	__memcpy(&tmp, s, offsetof(struct bad_iret_stack, regs.ip));
>  
>  	/* Update the entry stack */
> -	memcpy(new_stack, &tmp, sizeof(tmp));
> +	__memcpy(new_stack, &tmp, sizeof(tmp));
>  
>  	BUG_ON(!user_mode(&new_stack->regs));
>  	return new_stack;
> diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
> index 56b243b14c3a2..bbcc05bcefadb 100644
> --- a/arch/x86/lib/memcpy_64.S
> +++ b/arch/x86/lib/memcpy_64.S
> @@ -8,6 +8,8 @@
>  #include <asm/alternative-asm.h>
>  #include <asm/export.h>
>  
> +.pushsection .noinstr.text, "ax"
> +
>  /*
>   * We build a jump to memcpy_orig by default which gets NOPped out on
>   * the majority of x86 CPUs which set REP_GOOD. In addition, CPUs which
> @@ -184,6 +186,8 @@ SYM_FUNC_START_LOCAL(memcpy_orig)
>  	retq
>  SYM_FUNC_END(memcpy_orig)
>  
> +.popsection
> +
>  #ifndef CONFIG_UML
>  
>  MCSAFE_TEST_CTL

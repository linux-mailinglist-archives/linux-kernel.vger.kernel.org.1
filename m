Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A673429C119
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1818703AbgJ0RWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:22:51 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:46251 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1811816AbgJ0RWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:22:48 -0400
Received: by mail-ej1-f66.google.com with SMTP id t25so3330722ejd.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 10:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2/9Hit5668ey8vyUaaKLnC7mcM4OnkN5mepGXepYuc=;
        b=i9YMhQXS6mpLeHIjUr6MJln8eCraOodhXeykTEkJPevVHjU/Ps46wH/1SjHPDX8HZ9
         I4iz6MLgNAiZC1HJSEqvcXYGPvm6chRqamv45o0yDLZLS5CBsMs3xPtKVRClH2NA+5LV
         TS3GkOIEqghaV9L7Io9X1qlXm2tysuSSkTQwMWWGhthx5mk8PA54i9w1ZWqe+2vIcHkX
         /u5A4oAD5VLk4PzcMLCdl+Nfmwqvbw4rA2KlZCNmzV/HMhZvI43rw/PQ7xhTOe/LLRx/
         N/13WvQSPI42px8YdPiFbMHs1xQHFZdT1RTUZKZB4pkly/02LiWON5Dr+TE7YeM1sZYx
         Ybag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2/9Hit5668ey8vyUaaKLnC7mcM4OnkN5mepGXepYuc=;
        b=h/05lJ/IopQaCHWaMvVVDO6qPEJ89ZbmUUuxo8+m3TU/pniZnIP2OGuJ79XTBmqWGI
         QGYRukfk8vs0HAaa4YoOHxNOSiTPcsbjQ78pdyAg9Np31xn7BIDTSmvM2mVSzJ44a8+C
         AyCONmYM8xba6PMuSNdkDpGkFEYwdJrkofANNzarN1OoXvYMtKjvzOJavfpuqOvg0zvl
         xX/PjGyUJrMbVOJNAha5Ku3K2DxwDmnEc5ZgoTIhoLGqbVgfl/bOKjA6birup92lCxEi
         Twu2G6fHRRqyfxxhV1YLpRYOcqB1d3XUjkdD22wGV31kwmsxbRW/YZGUtVGj2cHTUC2a
         wNzQ==
X-Gm-Message-State: AOAM530s/eMPVNphtv5mGo0EcTfzP5qjQzck256GhTxWgEnjTzqtWYPq
        6lSm3Ku0ta3z5LOKhqmY+vFmzEwCF1/cC+Dzpg3oVw==
X-Google-Smtp-Source: ABdhPJxXsw0aqDjJjGsy3gPpf7wxX9gqb2vH2wafnudQlNMZx+NlPA7ys416hi6JymPriAOSXbEBqXEw2lV1LU8/pV8=
X-Received: by 2002:a17:906:b285:: with SMTP id q5mr3570859ejz.135.1603819365979;
 Tue, 27 Oct 2020 10:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201027091504.712183781@infradead.org> <20201027093608.096535386@infradead.org>
In-Reply-To: <20201027093608.096535386@infradead.org>
From:   Kyle Huey <me@kylehuey.com>
Date:   Tue, 27 Oct 2020 10:22:34 -0700
Message-ID: <CAP045AqWZQ93+cpXTDpNws-Rv15t=tAJMx3WsuRvL4-63oPw0w@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/debug: Fix PTRACE_{BLOCK,SINGLE}STEP vs ptrace_get_debugreg(6)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
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
        Daniel Thompson <daniel.thompson@linaro.org>,
        julliard@winehq.org, pgofman@codeweavers.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 2:44 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Commit d53d9bc0cf78 ("x86/debug: Change thread.debugreg6 to
> thread.virtual_dr6") changed the semantics of the variable from random
> collection of bits, to exactly only those bits that ptrace() needs.
>
> Unfortunately we lost DR_STEP for PTRACE_{BLOCK,SINGLE}STEP.
>
> Fixes: d53d9bc0cf78 ("x86/debug: Change thread.debugreg6 to thread.virtual_dr6")
> Reported-by: Kyle Huey <me@kylehuey.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/ptrace.h |    2 ++
>  arch/x86/kernel/step.c        |    9 +++++++++
>  arch/x86/kernel/traps.c       |    2 +-
>  3 files changed, 12 insertions(+), 1 deletion(-)
>
> --- a/arch/x86/include/asm/ptrace.h
> +++ b/arch/x86/include/asm/ptrace.h
> @@ -355,6 +355,8 @@ static inline unsigned long regs_get_ker
>  #define arch_has_block_step()  (boot_cpu_data.x86 >= 6)
>  #endif
>
> +extern unsigned long user_dr_step(unsigned long dr6);
> +
>  #define ARCH_HAS_USER_SINGLE_STEP_REPORT
>
>  struct user_desc;
> --- a/arch/x86/kernel/step.c
> +++ b/arch/x86/kernel/step.c
> @@ -235,3 +235,12 @@ void user_disable_single_step(struct tas
>         if (test_and_clear_tsk_thread_flag(child, TIF_FORCED_TF))
>                 task_pt_regs(child)->flags &= ~X86_EFLAGS_TF;
>  }
> +
> +unsigned long user_dr_step(unsigned long dr6)
> +{
> +       if (test_thread_flag(TIF_BLOCKSTEP) ||
> +           test_thread_flag(TIF_SINGLESTEP))
> +               return dr6 & DR_STEP;
> +
> +       return 0;
> +}
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -940,7 +940,7 @@ static __always_inline void exc_debug_us
>          * Clear the virtual DR6 value, ptrace() routines will set bits here
>          * for things it wants signals for.
>          */
> -       current->thread.virtual_dr6 = 0;
> +       current->thread.virtual_dr6 = user_dr_step(dr6);
>
>         /*
>          * The SDM says "The processor clears the BTF flag when it
>
>

Tested-by: Kyle Huey <me@kylehuey.com>

Confirmed that this patch series fixes rr when applied on top of the
v5.10-rc1 tag.

- Kyle

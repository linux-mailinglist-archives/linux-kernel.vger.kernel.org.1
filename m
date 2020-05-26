Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5311A4DC8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Apr 2020 06:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgDKERq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Apr 2020 00:17:46 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43301 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgDKERq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 00:17:46 -0400
Received: by mail-oi1-f193.google.com with SMTP id j16so3038921oih.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 21:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nj9UeTtJnuO8AzPYr6OlZsExOtwRfKxlTeW/uh4yw00=;
        b=O/5wq52ltW1J6xXKbEEzHD4WZK/cwdfU6bkyBI3wcgiPTP+uqntaOB2g8kYvm97FUQ
         XJ1R1RIKQo99XlWuuXNe2TEkj0L0Q993ZtQ5mzpom5JQhAACoSsWI4DY+VyypTQ626Bb
         GhhrEd2pTfsfxjSJcFYIe4aLikkdaraW7u04ymLpF2AaPIBoMmupebSbVQWvinMpt7bi
         dV2bDHCUGtZPYkNx/beI91/JSytFa0yPv2VV8/exZD7TTsmNEp1RpXYMOkTSrluYeu8T
         nogXYc2lMNYznfx0KnL7eI7vmzoToIO8DwBWqr+6l2M5n/mBt9H+goGe/GLN5N4HqHJU
         1EsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nj9UeTtJnuO8AzPYr6OlZsExOtwRfKxlTeW/uh4yw00=;
        b=XXjyvZjnzjlgefNZo37xOnY2oNseM2Yr5Ap0UwO2gmrY4aHmKOK6mMxi9VCAE3oWkO
         9nMysg0UwI2jsX/WKH10/4zO7sIn8m+cQMt/p3yWtMfi1DNfmBbORrrj1m+AVSn9SOJO
         YVBe4Dmr7cSFPq+22EVKYaJ1XJsEHPApAKIBOL+lFS1rOX+PsHscln4nxKEwGuAehVC8
         WA6fZznxZa69KXvUWB/2W5JOaweLn3Fn97kupYBHVa3L1mjADQaSdN3nwFiBcIaxGBQU
         U8N5NHNXQWPLcD2O71XY6didfQvXVKzIkNsTXOHQyFLByegke6ddlwVd6tfSKnGcOHaC
         PPVg==
X-Gm-Message-State: AGi0PuYuS8XZkzXtS3Dqgj/Ve01/Ars4GDfK6cHOJusmlouT7FU4kVtE
        OdO5hr8YaObd1CzFydTS44zC4EvJdiYo+UcF8FWmZw==
X-Google-Smtp-Source: APiQypLsmTgvlvZJ3D08FY+P7bqhhzYmV2B8aheUaglU8iA8xCdY2IzNWriGQToxtxVSemd+k1Rzaqlvo57iAkfv+3A=
X-Received: by 2002:aca:5651:: with SMTP id k78mr5362760oib.32.1586578665281;
 Fri, 10 Apr 2020 21:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200410032634.57511-1-zong.li@sifive.com> <CAJF2gTSAe_=0Eg12O-Sjc6897EOqwZOQFPc5utKWQ32gn6BFEA@mail.gmail.com>
In-Reply-To: <CAJF2gTSAe_=0Eg12O-Sjc6897EOqwZOQFPc5utKWQ32gn6BFEA@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Sat, 11 Apr 2020 12:17:34 +0800
Message-ID: <CANXhq0rPxoKfwL302ehihr=TR64mN1_T8qBH9vbDbrpdfzR1tg@mail.gmail.com>
Subject: Re: [PATCH] riscv: remove the assert of lock for cpu_running
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 11, 2020 at 11:44 AM Guo Ren <guoren@kernel.org> wrote:
>
> Acked-by: Guo Ren <guoren@kernel.org>
>
> Haha, are you working on lockdep ? Me too, here is my patch, not finished.

No, I just went to add a lock assert at somewhere, so enabled lockdep
to test it on incomplete lockdep support, then I found this error. If
you are working on lockdep, it might be better to fix this problem on
your side instead of here.

>
> It's still warning at begin, I've no time to debug, and it's similar to csky's:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/csky?id=000591f1ca3312d9a29e15a9e3fe5c4171f75586
>
> If you are working on LOCKDEP, I'll wait your patch :)
>
> commit 096d7a4b26d21aa7c71c86f200241144569e697a (riscv-lockdep)
> Author: Guo Ren <guoren@linux.alibaba.com>
> Date:   Fri Apr 10 16:38:37 2020 +0800
>
>     riscv: Enable LOCKDEP_SUPPORT
>
>     Lockdep is needed by proving the spinlocks and rwlocks.
>
>     Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 8672e77a5b7a..bfe76c76a107 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -163,6 +163,9 @@ config PGTABLE_LEVELS
>         default 3 if 64BIT
>         default 2
>
> +config LOCKDEP_SUPPORT
> +       def_bool y
> +
>  source "arch/riscv/Kconfig.socs"
>
>  menu "Platform type"
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 208702d8c18e..41588ee74cb2 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -175,6 +175,24 @@ ENTRY(handle_exception)
>  .option pop
>
>         la ra, ret_from_exception
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +       call trace_hardirqs_off
> +       la ra, ret_from_exception
> +       REG_L s0, PT_SP(sp)
> +       REG_L s1, PT_STATUS(sp)
> +       REG_L s2, PT_EPC(sp)
> +       REG_L s3, PT_BADADDR(sp)
> +       REG_L s4, PT_CAUSE(sp)
> +       REG_L s5, PT_TP(sp)
> +       REG_L a0, PT_A0(sp)
> +       REG_L a1, PT_A1(sp)
> +       REG_L a2, PT_A2(sp)
> +       REG_L a3, PT_A3(sp)
> +       REG_L a4, PT_A4(sp)
> +       REG_L a5, PT_A5(sp)
> +       REG_L a6, PT_A6(sp)
> +       REG_L a7, PT_A7(sp)
> +#endif
>         /*
>          * MSB of cause differentiates between
>          * interrupts and exceptions
> @@ -191,6 +209,24 @@ ENTRY(handle_exception)
>          */
>         andi t0, s1, SR_PIE
>         beqz t0, 1f
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +       call trace_hardirqs_on
> +       la ra, ret_from_exception
> +       REG_L s0, PT_SP(sp)
> +       REG_L s1, PT_STATUS(sp)
> +       REG_L s2, PT_EPC(sp)
> +       REG_L s3, PT_BADADDR(sp)
> +       REG_L s4, PT_CAUSE(sp)
> +       REG_L s5, PT_TP(sp)
> +       REG_L a0, PT_A0(sp)
> +       REG_L a1, PT_A1(sp)
> +       REG_L a2, PT_A2(sp)
> +       REG_L a3, PT_A3(sp)
> +       REG_L a4, PT_A4(sp)
> +       REG_L a5, PT_A5(sp)
> +       REG_L a6, PT_A6(sp)
> +       REG_L a7, PT_A7(sp)
> +#endif
>         csrs CSR_STATUS, SR_IE
>
>  1:
> @@ -291,6 +327,31 @@ resume_userspace:
>         csrw CSR_SCRATCH, tp
>
>  restore_all:
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +       REG_L s1, PT_STATUS(sp)
> +       andi t0, s1, SR_PIE
> +       beqz t0, 1f
> +       call trace_hardirqs_on
> +       j 2f
> +1:
> +       call trace_hardirqs_off
> +2:
> +       la ra, ret_from_exception
> +       REG_L s0, PT_SP(sp)
> +       REG_L s1, PT_STATUS(sp)
> +       REG_L s2, PT_EPC(sp)
> +       REG_L s3, PT_BADADDR(sp)
> +       REG_L s4, PT_CAUSE(sp)
> +       REG_L s5, PT_TP(sp)
> +       REG_L a0, PT_A0(sp)
> +       REG_L a1, PT_A1(sp)
> +       REG_L a2, PT_A2(sp)
> +       REG_L a3, PT_A3(sp)
> +       REG_L a4, PT_A4(sp)
> +       REG_L a5, PT_A5(sp)
> +       REG_L a6, PT_A6(sp)
> +       REG_L a7, PT_A7(sp)
> +#endif
>         RESTORE_ALL
>  #ifdef CONFIG_RISCV_M_MODE
>         mret
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 8bc01f0ca73b..54fd70eb50bd 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -115,7 +115,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>                   task_stack_page(tidle) + THREAD_SIZE);
>         WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
>
> -       lockdep_assert_held(&cpu_running);
> +//     lockdep_assert_held(&cpu_running);
>         wait_for_completion_timeout(&cpu_running,
>                                             msecs_to_jiffies(1000));
>
> On Fri, Apr 10, 2020 at 11:26 AM Zong Li <zong.li@sifive.com> wrote:
> >
> > The cpu_running is not a lock-class, it lacks the dep_map member in
> > completion. It causes the error as follow:
> >
> > arch/riscv/kernel/smpboot.c: In function '__cpu_up':
> > ./include/linux/lockdep.h:364:52: error: 'struct completion' has no member named 'dep_map'
> >   364 | #define lockdep_is_held(lock)  lock_is_held(&(lock)->dep_map)
> >       |                                                    ^~
> > ./include/asm-generic/bug.h:113:25: note: in definition of macro 'WARN_ON'
> >   113 |  int __ret_warn_on = !!(condition);    \
> >       |                         ^~~~~~~~~
> > ./include/linux/lockdep.h:390:27: note: in expansion of macro 'lockdep_is_held'
> >   390 |   WARN_ON(debug_locks && !lockdep_is_held(l)); \
> >       |                           ^~~~~~~~~~~~~~~
> > arch/riscv/kernel/smpboot.c:118:2: note: in expansion of macro 'lockdep_assert_held'
> >   118 |  lockdep_assert_held(&cpu_running);
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  arch/riscv/kernel/smpboot.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > index 8bc01f0ca73b..bbc1baa2d90c 100644
> > --- a/arch/riscv/kernel/smpboot.c
> > +++ b/arch/riscv/kernel/smpboot.c
> > @@ -115,7 +115,6 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
> >                   task_stack_page(tidle) + THREAD_SIZE);
> >         WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
> >
> > -       lockdep_assert_held(&cpu_running);
> >         wait_for_completion_timeout(&cpu_running,
> >                                             msecs_to_jiffies(1000));
> >
> > --
> > 2.26.0
> >
> >
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/

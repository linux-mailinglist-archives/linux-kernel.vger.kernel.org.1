Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1A92951AB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 19:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503670AbgJURmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 13:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503364AbgJURmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 13:42:15 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B636CC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 10:42:13 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a17so1529181pju.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 10:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=215/ymy+uvftzLr1t80NNKG87+/NQw0X6pRjkxN1Tp0=;
        b=L1OKuBHV+BBkBNrKbPhmgmqYgykKnT0+FERP1DWY2Gje3PJfaREB3N3jED10ItpnNa
         3vTnxl3mpgFZ2pPzm+XH9cxpAQEVzHfgg/hQP6cqjb/v7DqQKcdh9rQA4Oz+gj4y2GIh
         sGyc3JLA02C/HZEOW+Y+Jycn8NZZAwewL4KTQKzntsN0kcpdjajOkaUpc6i1blndJlcr
         ImaMKnaZwV/4FtHUjsIrSN3laM9q/HqCSkMB8cY4WDdp/CUEwXmdcEfGzdvjsG789kVC
         hX0Y2cRDAyZHSE/3NNQeHlde3dZMRb1fs41mK6Utm+seEmN9zjMGHSWac9St7srw2Cm5
         rgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=215/ymy+uvftzLr1t80NNKG87+/NQw0X6pRjkxN1Tp0=;
        b=al5Rsh3+U1SA0keVQdPrrFxjdghL97inCPeETnLpOcFifQey5IDYr9hJknI8/abxV/
         JwBjRt7DWIq6oeZ4HYyORoW4P/kX41F7vEOyBBqk00KBd6K33NfSYmMBSzISdoO3Ykt3
         abJIf1ky+cFhm/M73GulpuHA+gEaeAlNoxVcLCTNq7WZJSMpRCVXmaf9o2BXjbjoew9d
         hFfdVTyS2GA6ortXg6bgOQCeOnQZOJ14TDGiTXKKzazvD3sPwJlUSa3ofpmJOjfSL7qF
         uwj61008jw04UN4DCQ8tWc039qoQUgNqCDBOBonmDK7+XONkcwf6d07StkYUM3jp5vTd
         QMAQ==
X-Gm-Message-State: AOAM5321XtGEOpDTU+9b7L8+HVW6UvZHUzKEiSmTbp6HuHjHY8IV8v65
        AOHfbFhEEN60J8kkouEgTP/ol8hHtC4gTamMczGbuw==
X-Google-Smtp-Source: ABdhPJw3zTfB2YLDuZ12pSPaoOATFnI3x1HXMpCimFsFKUkCJgyCB+Df5YVr0ynmFdpFb0IFwLZWwF/UUKJbs3IL6DI=
X-Received: by 2002:a17:902:c40b:b029:d3:def2:d90f with SMTP id
 k11-20020a170902c40bb02900d3def2d90fmr4661882plk.29.1603302132985; Wed, 21
 Oct 2020 10:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200629003127.GB5535@shao2-debian> <20200630124628.GV4817@hirez.programming.kicks-ass.net>
 <20200630144905.GX4817@hirez.programming.kicks-ass.net> <58ff47cc-dc55-e383-7a5b-37008d145aba@gmail.com>
 <20201021080031.GY2628@hirez.programming.kicks-ass.net> <20201021131806.GA2176@tucnak>
 <20201021134436.GJ2628@hirez.programming.kicks-ass.net>
In-Reply-To: <20201021134436.GJ2628@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 21 Oct 2020 10:42:01 -0700
Message-ID: <CAKwvOd=qi63We=6rLapb565giCVe-8a6d=-=3VZL6RWzhwAeZg@mail.gmail.com>
Subject: Re: GCC section alignment, and GCC-4.9 being a weird one
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKP <lkp@lists.01.org>, Kees Cook <keescook@chromium.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-toolchains@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 6:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Ah, thanks!
>
> In that case something like the below ought to make it good.
>
> I'll go feed it to the robots, see if anything falls over.
>
> ---
>  kernel/sched/deadline.c  | 4 +++-
>  kernel/sched/fair.c      | 4 +++-
>  kernel/sched/idle.c      | 4 +++-
>  kernel/sched/rt.c        | 4 +++-
>  kernel/sched/sched.h     | 3 +--
>  kernel/sched/stop_task.c | 3 ++-
>  6 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 6d93f4518734..f4855203143d 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2504,7 +2504,9 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
>  }
>
>  const struct sched_class dl_sched_class
> -       __attribute__((section("__dl_sched_class"))) = {
> +       __attribute__((section("__dl_sched_class")))
> +       __attribute__((aligned(__alignof__(struct sched_class)))) = {

If you used some of the macros from
include/linux/compiler_attributes.h like __section and __aligned, I
would prefer it.  Please consider spelling out __attribute__(()) an
antipattern.

> +
>         .enqueue_task           = enqueue_task_dl,
>         .dequeue_task           = dequeue_task_dl,
>         .yield_task             = yield_task_dl,
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index aa4c6227cd6d..9bfa9f545b9a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11159,7 +11159,9 @@ static unsigned int get_rr_interval_fair(struct rq *rq, struct task_struct *task
>   * All the scheduling class methods:
>   */
>  const struct sched_class fair_sched_class
> -       __attribute__((section("__fair_sched_class"))) = {
> +       __attribute__((section("__fair_sched_class")))
> +       __attribute__((aligned(__alignof__(struct sched_class)))) = {
> +
>         .enqueue_task           = enqueue_task_fair,
>         .dequeue_task           = dequeue_task_fair,
>         .yield_task             = yield_task_fair,
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index f324dc36fc43..c74ded2cabd2 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -458,7 +458,9 @@ static void update_curr_idle(struct rq *rq)
>   * Simple, special scheduling class for the per-CPU idle tasks:
>   */
>  const struct sched_class idle_sched_class
> -       __attribute__((section("__idle_sched_class"))) = {
> +       __attribute__((section("__idle_sched_class")))
> +       __attribute__((aligned(__alignof__(struct sched_class)))) = {
> +
>         /* no enqueue/yield_task for idle tasks */
>
>         /* dequeue is not valid, we print a debug message there: */
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index f215eea6a966..002cdbfa5308 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2430,7 +2430,9 @@ static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)
>  }
>
>  const struct sched_class rt_sched_class
> -       __attribute__((section("__rt_sched_class"))) = {
> +       __attribute__((section("__rt_sched_class")))
> +       __attribute__((aligned(__alignof__(struct sched_class)))) = {
> +
>         .enqueue_task           = enqueue_task_rt,
>         .dequeue_task           = dequeue_task_rt,
>         .yield_task             = yield_task_rt,
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 28709f6b0975..42cf1e0cbf16 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -67,7 +67,6 @@
>  #include <linux/tsacct_kern.h>
>
>  #include <asm/tlb.h>
> -#include <asm-generic/vmlinux.lds.h>
>
>  #ifdef CONFIG_PARAVIRT
>  # include <asm/paravirt.h>
> @@ -1826,7 +1825,7 @@ struct sched_class {
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>         void (*task_change_group)(struct task_struct *p, int type);
>  #endif
> -} __aligned(STRUCT_ALIGNMENT); /* STRUCT_ALIGN(), vmlinux.lds.h */
> +};
>
>  static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
>  {
> diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
> index 394bc8126a1e..7bac6e0a9212 100644
> --- a/kernel/sched/stop_task.c
> +++ b/kernel/sched/stop_task.c
> @@ -110,7 +110,8 @@ static void update_curr_stop(struct rq *rq)
>   * Simple, special scheduling class for the per-CPU stop tasks:
>   */
>  const struct sched_class stop_sched_class
> -       __attribute__((section("__stop_sched_class"))) = {
> +       __attribute__((section("__stop_sched_class")))
> +       __attribute__((aligned(__alignof__(struct sched_class)))) = {
>
>         .enqueue_task           = enqueue_task_stop,
>         .dequeue_task           = dequeue_task_stop,



-- 
Thanks,
~Nick Desaulniers

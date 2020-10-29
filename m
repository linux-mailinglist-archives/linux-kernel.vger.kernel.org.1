Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85FA29DC45
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388511AbgJ2AXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbgJ2AXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:23:34 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B408C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:23:33 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id p7so1511427ioo.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zfVg08Uc1hC8f5CCWXhD5WUVWQOtF+tlYpqLGgYJlJg=;
        b=PakSw0bSI6/UzuR/TWGr7DSLJmVrNTd4PoFRcMGzWGZqkE4bNxtMsMAU1X3bpk8tyT
         bhwhOrdT9bfaQ82++0/7h3bDAjaXFF14cOPr5WTvV9IvQc5MFnEVtobrIdxf9JYiR8pH
         nGPNLwv9AhQj9mZ/2GWNEEuILt+lVmkw6xLiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zfVg08Uc1hC8f5CCWXhD5WUVWQOtF+tlYpqLGgYJlJg=;
        b=janGXPHvBI+6IGxJfWJe18bgNwQfK+NSSlN58d/h75k6Kof0blb3ccC8oAeTmqsgXg
         ABGfuuhS7h1sB9SlZtQXGP7NtWva5dDMXdO96C30gsBPn+Z2x0StMrk2QBB7Dl8/3Odb
         cedknvOV0x4REWiOTifqpuF/OQhJaq9XwL5EucVgX0GCBAf8IhIZb9fceiVjoqskRbv5
         jYvGSeG8U3+NeM+oWWrZGWGLlH0L6qF4R/WbRGKUwv0REFpBLkQQLmNleXPK0NZL2GRJ
         u6zG29oC5YAwYE3h9m8/wO2+ZK3h/ZQVxIX1wZGPTKGhBpnsPqTQG21J7uUTU/i7whHu
         sD3g==
X-Gm-Message-State: AOAM532sMy1Zdh/R1qGCMNGnXIPnS6i7X6iILS4StNaR5FvDmvkj9Phc
        Aku++4gHFwYa2sjNOGsC478RXb+SEZ7Qt5QGc3p5
X-Google-Smtp-Source: ABdhPJy+TYyPXXkUhZ7lWkqjZZrLysTNxJ2f/nv8P4+2Vjceq0I5ufnLiH+oPZjoeR90sc+P+n91lrNxgDordUiaVMk=
X-Received: by 2002:a05:6638:f81:: with SMTP id h1mr1524839jal.115.1603931012567;
 Wed, 28 Oct 2020 17:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201021073839.43935-1-zong.li@sifive.com> <CAJF2gTTnGSYAc3AZKCPvhNJsPm_TchPjPrtqc_WzaK7K5eNt+w@mail.gmail.com>
In-Reply-To: <CAJF2gTTnGSYAc3AZKCPvhNJsPm_TchPjPrtqc_WzaK7K5eNt+w@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 28 Oct 2020 17:23:21 -0700
Message-ID: <CAOnJCULN8h0Jk3H-vskgbaXhgBTgTTAT5Dji0qHi6yHoXGePvg@mail.gmail.com>
Subject: Re: [PATCH] stop_machine: Mark functions as notrace
To:     Guo Ren <guoren@kernel.org>
Cc:     Zong Li <zong.li@sifive.com>, Paul McKenney <paulmck@kernel.org>,
        josh@joshtriplett.org, Steven Rostedt <rostedt@goodmis.org>,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, vincent.whitchurch@axis.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Colin Ian King <colin.king@canonical.com>,
        rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 8:44 AM Guo Ren <guoren@kernel.org> wrote:
>
> Hi Zong & Atish,
>
> In our 2 harts c910 chip, we found:
>
> echo function > /sys/kernel/debug/tracing/current_tracer
> echo function_graph > /sys/kernel/debug/tracing/current_tracer
> echo function > /sys/kernel/debug/tracing/current_tracer
> echo function_graph > /sys/kernel/debug/tracing/current_tracer
>
> Then one core halted at stop_machine_yield:
> arch_cpu_idle () at arch/riscv/kernel/process.c:39
> 39              local_irq_enable();
> (gdb) i th
>   Id   Target Id         Frame
> * 1    Thread 1 (CPU#0)  arch_cpu_idle () at arch/riscv/kernel/process.c:39
>   2    Thread 2 (CPU#1)  stop_machine_yield
> (cpumask=0xffffffe001371fa8 <__cpu_online_mask>) at
> ./arch/riscv/include/asm/vdso/processor.h:12
> (gdb) thread 2
> [Switching to thread 2 (Thread 2)]
> #0  stop_machine_yield (cpumask=0xffffffe001371fa8
> <__cpu_online_mask>) at ./arch/riscv/include/asm/vdso/processor.h:12
> 12              __asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
>
> With your patch, it's solved. For this patch, I'll give:
> Tested by: Guo Ren <guoren@kernel.org>
>
> But that's not enough, we still need:
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 226ccce..12b8808 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -376,7 +376,7 @@ EXPORT_SYMBOL(sbi_send_ipi);
>   *
>   * Return: None
>   */
> -void sbi_remote_fence_i(const unsigned long *hart_mask)
> +void notrace sbi_remote_fence_i(const unsigned long *hart_mask)
>  {
>         __sbi_rfence(SBI_EXT_RFENCE_REMOTE_FENCE_I,
>                      hart_mask, 0, 0, 0, 0);
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 400b945d..9467d987 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -9,12 +9,12 @@
>
>  #include <asm/sbi.h>
>
> -static void ipi_remote_fence_i(void *info)
> +static void notrace ipi_remote_fence_i(void *info)
>  {
>         return local_flush_icache_all();
>  }
>
> -void flush_icache_all(void)
> +void notrace flush_icache_all(void)
>  {
>         if (IS_ENABLED(CONFIG_RISCV_SBI))
>                 sbi_remote_fence_i(NULL);
>

Did you see any issue if these functions are not marked as notrace ?

As per Zong's explanation, the issue was that the other harts already
fetched the next 2 nops and
executed 1 while kernel patching replaced other with one of the auipc
+ jalr pair.

@Zong can correct me if I am wrong.

These functions are too far ahead. Can it cause such issues ? If yes,
then we need to mark each and every function
that can be invoked from patch_text_nosync and are not inlined.

That includes copy_to_kernel_nofault, __sbi_rfence_v02,
__sbi_rfence_v02_call, sbi_ecall.

Few of these functions may be inlined by compiler. Can we depend on that ?

> Because:
> (gdb) bt
> #0  flush_icache_all () at arch/riscv/mm/cacheflush.c:20
> #1  0xffffffe00020473a in patch_text_nosync (addr=<optimized out>, insns=
>     <optimized out>, len=<optimized out>) at arch/riscv/kernel/patch.c:96
> #2  0xffffffe000206792 in ftrace_make_call (rec=<optimized out>,
> addr=<optimized out>) at arch/riscv/kernel/ftrace.c:109
> #3  0xffffffe0002c9be4 in __ftrace_replace_code (rec=0xffffffe01ae40020, e
>     nable=true) at kernel/trace/ftrace.c:2503
> #4  0xffffffe0002ca092 in ftrace_replace_code (mod_flags=<optimized
>     out>) at kernel/trace/ftrace.c:2530
> #5  0xffffffe0002ca24a in ftrace_modify_all_code (command=9) at kernel
>    /trace/ftrace.c:2677
> #6  0xffffffe0002ca2ee in __ftrace_modify_code (data=<optimized out>) at
>    kernel/trace/ftrace.c:2703
> #7  0xffffffe0002c1390 in multi_cpu_stop (data=0x0) at kernel/stop_machin
>    e.c:224
> #8  0xffffffe0002c0fbe in cpu_stopper_thread (cpu=<optimized out>) at kern
>    el/stop_machine.c:491
> #9  0xffffffe0002343be in smpboot_thread_fn (data=0x0) at kernel/smpboot.
>    c:165
> #10 0xffffffe00022f894 in kthread (_create=0xffffffe01af13040) at kern
>    el/kthread.c:292
> #11 0xffffffe000201fac in handle_exception () at arch/riscv/kernel/entry.S:236
>
> On Wed, Oct 21, 2020 at 3:38 PM Zong Li <zong.li@sifive.com> wrote:
> >
> > Like the commit cb9d7fd51d9f ("watchdog: Mark watchdog touch functions
> > as notrace"), some architectures assume that the stopped CPUs don't make
> > function calls to traceable functions when they are in the stopped
> > state. For example, it causes unexpected kernel crashed when switching
> > tracer on RISC-V.
> >
> > The following patches added calls to these two functions, fix it by
> > adding the notrace annotations.
> >
> > Fixes: 4ecf0a43e729 ("processor: get rid of cpu_relax_yield")
> > Fixes: 366237e7b083 ("stop_machine: Provide RCU quiescent state in
> > multi_cpu_stop()")
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  kernel/rcu/tree.c     | 2 +-
> >  kernel/stop_machine.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 06895ef85d69..2a52f42f64b6 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -409,7 +409,7 @@ bool rcu_eqs_special_set(int cpu)
> >   *
> >   * The caller must have disabled interrupts and must not be idle.
> >   */
> > -void rcu_momentary_dyntick_idle(void)
> > +notrace void rcu_momentary_dyntick_idle(void)
> >  {
> >         int special;
> >
> > diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> > index 865bb0228ab6..890b79cf0e7c 100644
> > --- a/kernel/stop_machine.c
> > +++ b/kernel/stop_machine.c
> > @@ -178,7 +178,7 @@ static void ack_state(struct multi_stop_data *msdata)
> >                 set_state(msdata, msdata->state + 1);
> >  }
> >
> > -void __weak stop_machine_yield(const struct cpumask *cpumask)
> > +notrace void __weak stop_machine_yield(const struct cpumask *cpumask)
> >  {
> >         cpu_relax();
> >  }
> > --
> > 2.28.0
> >
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/



-- 
Regards,
Atish

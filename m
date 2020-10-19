Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B643E29278A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 14:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgJSMmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 08:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgJSMmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 08:42:32 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778BCC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 05:42:31 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y16so11749744ljk.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 05:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nxAqBvO3Vwt7/t1MxUSUcVqaHrxsmyioZaMSTSevmQs=;
        b=i92K3Xt9iH3oDzAtnidGpiw/bSiuIenCsyr4KV0K86qhxyrN6HsTYRXl41kOjVqoyd
         UmRAu5A7VmnqLaDTXNk9Pkv3g84AzYqyF/1IrulxK8C7/UY5NMzVOOyE8RMqoMGYqLHH
         Wf10BWcO4bBFs5ouKDOdCkJwobSfFjTPksekEpC2c7o1oG2mrIwy0pd8YHgjjzZv5IuI
         B7NHfNJKeeM+LVhnTXtdslomNHVQgGNP04V58BSWuQdGVIbuDFLAUUNkp/tvWr57rqfH
         wIhUGwPnSNMqNfl30V8rTfmZgPgzZ7T5Cq9deVnmJ/TlRGoOBOJ7cE+A50YT3FTNuhSy
         ewSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nxAqBvO3Vwt7/t1MxUSUcVqaHrxsmyioZaMSTSevmQs=;
        b=j/McwIdOzS6IO50T0R66lUUoreTHnnNg7YA90Sckb/1vkPS+EDUkEUSeKCyGmrj467
         6rr19fxLN1TRUvY7T8xC+gdhlziqG1/DVyXfeGvkE8N+yzlkiDYPItsEUXL0lOKc4KFo
         uTk4V4cyoXObgPX6hHDsacTMSJ9xzdNP4VqZU3qol2Af+PbltdybAkxUQMLYWKI37FLR
         l+ndJR/LpwAOYbmRan9jj43lDEnW7zyzgulqAWS4fvq6w0APmagxfoREWEhnE5GZDzM7
         fDZ/yFh9ubuAxNIFlLrzLa+kOiACtvfTI2Lut5fng0H5O2HvXkYEIWUSsBQ3gyeMcYsq
         +t2w==
X-Gm-Message-State: AOAM533yVylH7wTeAO4ye86vzQ21ngRCKm2sDR+k1ierHO162G1F3aOp
        SpXVD3EpmAE7V1PAS92b8iOVe+MvoET6GGPshS946w==
X-Google-Smtp-Source: ABdhPJz4pEHbh3UGnpGQLdNSs9CTBwiO1ZcdgwPKufl2dMYkxqZBh4UbxcsKlOrBT+cMsl2wJ/wFc0ZOLcoXE1VtNls=
X-Received: by 2002:a2e:7803:: with SMTP id t3mr5892700ljc.156.1603111349858;
 Mon, 19 Oct 2020 05:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200901144324.1071694-1-maz@kernel.org> <20200901144324.1071694-4-maz@kernel.org>
In-Reply-To: <20200901144324.1071694-4-maz@kernel.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 19 Oct 2020 14:42:18 +0200
Message-ID: <CAKfTPtDjPpri5Gt6kLeFp_B_zJUZ5DYXEqtJ+0VKohU-y9bFEQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] arm64: Allow IPIs to be handled as normal interrupts
To:     Marc Zyngier <maz@kernel.org>
Cc:     LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Saravana Kannan <saravanak@google.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Tue, 1 Sep 2020 at 16:44, Marc Zyngier <maz@kernel.org> wrote:
>
> In order to deal with IPIs as normal interrupts, let's add
> a new way to register them with the architecture code.
>
> set_smp_ipi_range() takes a range of interrupts, and allows
> the arch code to request them as if the were normal interrupts.
> A standard handler is then called by the core IRQ code to deal
> with the IPI.
>
> This means that we don't need to call irq_enter/irq_exit, and
> that we don't need to deal with set_irq_regs either. So let's
> move the dispatcher into its own function, and leave handle_IPI()
> as a compatibility function.
>
> On the sending side, let's make use of ipi_send_mask, which
> already exists for this purpose.
>
> One of the major difference is that we end up, in some cases
> (such as when performing IRQ time accounting on the scheduler
> IPI), end up with nested irq_enter()/irq_exit() pairs.
> Other than the (relatively small) overhead, there should be
> no consequences to it (these pairs are designed to nest
> correctly, and the accounting shouldn't be off).

While rebasing on mainline, I have faced a performance regression for
the benchmark:
perf bench sched pipe
on my arm64 dual quad core (hikey) and my 2 nodes x 112 CPUS (thx2)

The regression comes from:
commit: d3afc7f12987 ("arm64: Allow IPIs to be handled as normal interrupts")

          v5.9              + this patch
hikey :   48818(+/- 0.31)   37503(+/- 0.15%)  -23.2%
thx2  :  132410(+/- 1.72)  122646(+/- 1.92%)   -7.4%

By + this patch,  I mean merging branch from this patch. Whereas
merging the previous:
commit: 83cfac95c018 ("genirq: Allow interrupts to be excluded from
/proc/interrupts")
 It doesn't show any regression

Vincent

>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/Kconfig           |  1 +
>  arch/arm64/include/asm/smp.h |  5 ++
>  arch/arm64/kernel/smp.c      | 93 +++++++++++++++++++++++++++++++-----
>  3 files changed, 87 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6d232837cbee..d0fdbe5fb32f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -106,6 +106,7 @@ config ARM64
>         select GENERIC_CPU_VULNERABILITIES
>         select GENERIC_EARLY_IOREMAP
>         select GENERIC_IDLE_POLL_SETUP
> +       select GENERIC_IRQ_IPI
>         select GENERIC_IRQ_MULTI_HANDLER
>         select GENERIC_IRQ_PROBE
>         select GENERIC_IRQ_SHOW
> diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
> index 0eadbf933e35..57c5db15f6b7 100644
> --- a/arch/arm64/include/asm/smp.h
> +++ b/arch/arm64/include/asm/smp.h
> @@ -78,6 +78,11 @@ extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));
>
>  extern void (*__smp_cross_call)(const struct cpumask *, unsigned int);
>
> +/*
> + * Register IPI interrupts with the arch SMP code
> + */
> +extern void set_smp_ipi_range(int ipi_base, int nr_ipi);
> +
>  /*
>   * Called from the secondary holding pen, this is the secondary CPU entry point.
>   */
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 355ee9eed4dd..00c9db1b61b5 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -75,6 +75,13 @@ enum ipi_msg_type {
>         IPI_WAKEUP
>  };
>
> +static int ipi_irq_base __read_mostly;
> +static int nr_ipi __read_mostly = NR_IPI;
> +static struct irq_desc *ipi_desc[NR_IPI] __read_mostly;
> +
> +static void ipi_setup(int cpu);
> +static void ipi_teardown(int cpu);
> +
>  #ifdef CONFIG_HOTPLUG_CPU
>  static int op_cpu_kill(unsigned int cpu);
>  #else
> @@ -237,6 +244,8 @@ asmlinkage notrace void secondary_start_kernel(void)
>          */
>         notify_cpu_starting(cpu);
>
> +       ipi_setup(cpu);
> +
>         store_cpu_topology(cpu);
>         numa_add_cpu(cpu);
>
> @@ -302,6 +311,7 @@ int __cpu_disable(void)
>          * and we must not schedule until we're ready to give up the cpu.
>          */
>         set_cpu_online(cpu, false);
> +       ipi_teardown(cpu);
>
>         /*
>          * OK - migrate IRQs away from this CPU
> @@ -890,10 +900,9 @@ static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
>  /*
>   * Main handler for inter-processor interrupts
>   */
> -void handle_IPI(int ipinr, struct pt_regs *regs)
> +static void do_handle_IPI(int ipinr)
>  {
>         unsigned int cpu = smp_processor_id();
> -       struct pt_regs *old_regs = set_irq_regs(regs);
>
>         if ((unsigned)ipinr < NR_IPI) {
>                 trace_ipi_entry_rcuidle(ipi_types[ipinr]);
> @@ -906,21 +915,16 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>                 break;
>
>         case IPI_CALL_FUNC:
> -               irq_enter();
>                 generic_smp_call_function_interrupt();
> -               irq_exit();
>                 break;
>
>         case IPI_CPU_STOP:
> -               irq_enter();
>                 local_cpu_stop();
> -               irq_exit();
>                 break;
>
>         case IPI_CPU_CRASH_STOP:
>                 if (IS_ENABLED(CONFIG_KEXEC_CORE)) {
> -                       irq_enter();
> -                       ipi_cpu_crash_stop(cpu, regs);
> +                       ipi_cpu_crash_stop(cpu, get_irq_regs());
>
>                         unreachable();
>                 }
> @@ -928,17 +932,13 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>
>  #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
>         case IPI_TIMER:
> -               irq_enter();
>                 tick_receive_broadcast();
> -               irq_exit();
>                 break;
>  #endif
>
>  #ifdef CONFIG_IRQ_WORK
>         case IPI_IRQ_WORK:
> -               irq_enter();
>                 irq_work_run();
> -               irq_exit();
>                 break;
>  #endif
>
> @@ -957,9 +957,78 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>
>         if ((unsigned)ipinr < NR_IPI)
>                 trace_ipi_exit_rcuidle(ipi_types[ipinr]);
> +}
> +
> +/* Legacy version, should go away once all irqchips have been converted */
> +void handle_IPI(int ipinr, struct pt_regs *regs)
> +{
> +       struct pt_regs *old_regs = set_irq_regs(regs);
> +
> +       irq_enter();
> +       do_handle_IPI(ipinr);
> +       irq_exit();
> +
>         set_irq_regs(old_regs);
>  }
>
> +static irqreturn_t ipi_handler(int irq, void *data)
> +{
> +       do_handle_IPI(irq - ipi_irq_base);
> +       return IRQ_HANDLED;
> +}
> +
> +static void ipi_send(const struct cpumask *target, unsigned int ipi)
> +{
> +       __ipi_send_mask(ipi_desc[ipi], target);
> +}
> +
> +static void ipi_setup(int cpu)
> +{
> +       int i;
> +
> +       if (!ipi_irq_base)
> +               return;
> +
> +       for (i = 0; i < nr_ipi; i++)
> +               enable_percpu_irq(ipi_irq_base + i, 0);
> +}
> +
> +static void ipi_teardown(int cpu)
> +{
> +       int i;
> +
> +       if (!ipi_irq_base)
> +               return;
> +
> +       for (i = 0; i < nr_ipi; i++)
> +               disable_percpu_irq(ipi_irq_base + i);
> +}
> +
> +void __init set_smp_ipi_range(int ipi_base, int n)
> +{
> +       int i;
> +
> +       WARN_ON(n < NR_IPI);
> +       nr_ipi = min(n, NR_IPI);
> +
> +       for (i = 0; i < nr_ipi; i++) {
> +               int err;
> +
> +               err = request_percpu_irq(ipi_base + i, ipi_handler,
> +                                        "IPI", &irq_stat);
> +               WARN_ON(err);
> +
> +               ipi_desc[i] = irq_to_desc(ipi_base + i);
> +               irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
> +       }
> +
> +       ipi_irq_base = ipi_base;
> +       __smp_cross_call = ipi_send;
> +
> +       /* Setup the boot CPU immediately */
> +       ipi_setup(smp_processor_id());
> +}
> +
>  void smp_send_reschedule(int cpu)
>  {
>         smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
> --
> 2.27.0
>

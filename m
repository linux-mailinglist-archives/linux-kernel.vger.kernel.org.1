Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7222EA8DF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 11:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbhAEKeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 05:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729205AbhAEKdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:33:07 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFE8C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 02:32:26 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o13so71465605lfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 02:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BF/W0F7I0sQl/2SjY2Big80fEVdnu8HJD7TNcu3Hrw8=;
        b=WcsCZMAW0WfLlax593niHcETCLihQaZabjx461xA4Ti/O0MiDUpIdz5hPMQTq2lTHg
         RAlthd26x6VA2Lnk0DJI64jA+OPsQBFcDyldG8Mx+FHR5UrXjfCfizVgLPZcdZAgNpoJ
         VKbV7aP53+6J1/BpVv8SF5+hLWKUIGw+Els+fY6EKjsiGgyWj/q7Y2sK/3v2RpopaR5J
         q18bS/jYyDwlO6Zn6KYDDQa/vbN3bzUtqTsdWlDVDxFcyt0XkisCmfQZ2sy/UUiZrNiE
         5I2taT7kfpLmnvD9z67zcyk+/0T1LWexOvRaSj6nIl305NxVerxlt37GUW/GUcFF0Hgs
         J6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BF/W0F7I0sQl/2SjY2Big80fEVdnu8HJD7TNcu3Hrw8=;
        b=czR1kwXXRyMQPWrMESPDGfvAMqZyhxCVd0kYenqovGqJaysDhIEIujiSmYXb/TqsVW
         wv6tU4stWLOWcwmUheoxw5sUDrTRCPjq6oa8e/Wn96VCGjRUuhXvVH7EZFSoXF4jUVk/
         e7J9gGT10uO9EpNIqHTQRY6VzxEBxoqMotzdGIXXXFfgjJbMN+nWEVr4sisGewHX1J73
         7kDla/iDxKidd4VWztSFcvKvpNm/Y/GfVdCLSQjnX1PxJdZnjCoHXwdjxW58Wj8UpAnL
         7j+FRq2BgYuFbNVX+PfTD5sH43ZoV8aq3KjkqUbsABk/UGXVBrP3zOFOv5xr4mf4SclB
         X0DA==
X-Gm-Message-State: AOAM533xkyL3/H1gHKwhCQdib3mbt7wu1EREd6ODaip36ArGpeOcrctR
        lo7S0/OHMMqw1eSH9IeQHT5nJKQv4xrMT3KAalaZsQ==
X-Google-Smtp-Source: ABdhPJyB5nU8iG4ZiM1XgoAnMghgoieL6fH8RQ+kD7uMBYLEis/7X5njWUiXGyOyS4niD7D/ME/DrHT1/gKca48QMaE=
X-Received: by 2002:a05:651c:1192:: with SMTP id w18mr35852534ljo.40.1609842745386;
 Tue, 05 Jan 2021 02:32:25 -0800 (PST)
MIME-Version: 1.0
References: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org> <1604317487-14543-5-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1604317487-14543-5-git-send-email-sumit.garg@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 5 Jan 2021 16:02:14 +0530
Message-ID: <CAFA6WYNKmo6GgD1BDXGqF2b+2SdJ48=62J00agt67BKJq2an4Q@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] nmi: backtrace: Allow runtime arch specific override
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        mingo@redhat.com, mpe@ellerman.id.au,
        Thomas Gleixner <tglx@linutronix.de>, bp@alien8.de,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, tsbogend@alpha.franken.de
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "David S. Miller" <davem@davemloft.net>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        julien.thierry.kdev@gmail.com,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arch maintainers,

On Mon, 2 Nov 2020 at 17:16, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Add a boolean return to arch_trigger_cpumask_backtrace() to support a
> use-case where a particular architecture detects at runtime if it supports
> NMI backtrace or it would like to fallback to default implementation using
> SMP cross-calls.
>
> Currently such an architecture example is arm64 supporting pseudo NMIs
> feature which is only available on platforms which have support for GICv3
> or later version.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  arch/arm/include/asm/irq.h       |  2 +-
>  arch/arm/kernel/smp.c            |  3 ++-
>  arch/mips/include/asm/irq.h      |  2 +-
>  arch/mips/kernel/process.c       |  3 ++-
>  arch/powerpc/include/asm/nmi.h   |  2 +-
>  arch/powerpc/kernel/stacktrace.c |  3 ++-
>  arch/sparc/include/asm/irq_64.h  |  2 +-
>  arch/sparc/kernel/process_64.c   |  4 +++-
>  arch/x86/include/asm/irq.h       |  2 +-
>  arch/x86/kernel/apic/hw_nmi.c    |  3 ++-
>  include/linux/nmi.h              | 12 ++++--------
>  11 files changed, 20 insertions(+), 18 deletions(-)

Do you have any comments here? It would be nice to have your ack here.

-Sumit

>
> diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
> index 46d4114..54b0180 100644
> --- a/arch/arm/include/asm/irq.h
> +++ b/arch/arm/include/asm/irq.h
> @@ -31,7 +31,7 @@ void handle_IRQ(unsigned int, struct pt_regs *);
>  void init_IRQ(void);
>
>  #ifdef CONFIG_SMP
> -extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
> +extern bool arch_trigger_cpumask_backtrace(const cpumask_t *mask,
>                                            bool exclude_self);
>  #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
>  #endif
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 48099c6e..bb20a43 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -856,7 +856,8 @@ static void raise_nmi(cpumask_t *mask)
>         __ipi_send_mask(ipi_desc[IPI_CPU_BACKTRACE], mask);
>  }
>
> -void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
> +bool arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
>  {
>         nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_nmi);
> +       return true;
>  }
> diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
> index c5d3517..34f3b42 100644
> --- a/arch/mips/include/asm/irq.h
> +++ b/arch/mips/include/asm/irq.h
> @@ -78,7 +78,7 @@ extern int cp0_fdc_irq;
>
>  extern int get_c0_fdc_int(void);
>
> -void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
> +bool arch_trigger_cpumask_backtrace(const struct cpumask *mask,
>                                     bool exclude_self);
>  #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
>
> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> index 75ebd8d..d19e672 100644
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -735,9 +735,10 @@ static void raise_backtrace(cpumask_t *mask)
>         }
>  }
>
> -void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
> +bool arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
>  {
>         nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_backtrace);
> +       return true;
>  }
>
>  int mips_get_process_fp_mode(struct task_struct *task)
> diff --git a/arch/powerpc/include/asm/nmi.h b/arch/powerpc/include/asm/nmi.h
> index 84b4cfe..a5eb3e2 100644
> --- a/arch/powerpc/include/asm/nmi.h
> +++ b/arch/powerpc/include/asm/nmi.h
> @@ -9,7 +9,7 @@ static inline void arch_touch_nmi_watchdog(void) {}
>  #endif
>
>  #if defined(CONFIG_NMI_IPI) && defined(CONFIG_STACKTRACE)
> -extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
> +extern bool arch_trigger_cpumask_backtrace(const cpumask_t *mask,
>                                            bool exclude_self);
>  #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
>  #endif
> diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
> index b644065..22b112a 100644
> --- a/arch/powerpc/kernel/stacktrace.c
> +++ b/arch/powerpc/kernel/stacktrace.c
> @@ -264,8 +264,9 @@ static void raise_backtrace_ipi(cpumask_t *mask)
>         }
>  }
>
> -void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
> +bool arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
>  {
>         nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_backtrace_ipi);
> +       return true;
>  }
>  #endif /* defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_NMI_IPI) */
> diff --git a/arch/sparc/include/asm/irq_64.h b/arch/sparc/include/asm/irq_64.h
> index 4d748e9..35c01ff 100644
> --- a/arch/sparc/include/asm/irq_64.h
> +++ b/arch/sparc/include/asm/irq_64.h
> @@ -87,7 +87,7 @@ static inline unsigned long get_softint(void)
>         return retval;
>  }
>
> -void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
> +bool arch_trigger_cpumask_backtrace(const struct cpumask *mask,
>                                     bool exclude_self);
>  #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
>
> diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
> index a75093b..9182001 100644
> --- a/arch/sparc/kernel/process_64.c
> +++ b/arch/sparc/kernel/process_64.c
> @@ -248,7 +248,7 @@ static void __global_reg_poll(struct global_reg_snapshot *gp)
>         }
>  }
>
> -void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
> +bool arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
>  {
>         struct thread_info *tp = current_thread_info();
>         struct pt_regs *regs = get_irq_regs();
> @@ -303,6 +303,8 @@ void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
>         memset(global_cpu_snapshot, 0, sizeof(global_cpu_snapshot));
>
>         spin_unlock_irqrestore(&global_cpu_snapshot_lock, flags);
> +
> +       return true;
>  }
>
>  #ifdef CONFIG_MAGIC_SYSRQ
> diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
> index 528c8a7..b7668e0 100644
> --- a/arch/x86/include/asm/irq.h
> +++ b/arch/x86/include/asm/irq.h
> @@ -47,7 +47,7 @@ extern void init_ISA_irqs(void);
>  extern void __init init_IRQ(void);
>
>  #ifdef CONFIG_X86_LOCAL_APIC
> -void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
> +bool arch_trigger_cpumask_backtrace(const struct cpumask *mask,
>                                     bool exclude_self);
>
>  #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
> diff --git a/arch/x86/kernel/apic/hw_nmi.c b/arch/x86/kernel/apic/hw_nmi.c
> index 34a992e..e7dcd28 100644
> --- a/arch/x86/kernel/apic/hw_nmi.c
> +++ b/arch/x86/kernel/apic/hw_nmi.c
> @@ -34,10 +34,11 @@ static void nmi_raise_cpu_backtrace(cpumask_t *mask)
>         apic->send_IPI_mask(mask, NMI_VECTOR);
>  }
>
> -void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
> +bool arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
>  {
>         nmi_trigger_cpumask_backtrace(mask, exclude_self,
>                                       nmi_raise_cpu_backtrace);
> +       return true;
>  }
>
>  static int nmi_cpu_backtrace_handler(unsigned int cmd, struct pt_regs *regs)
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index 750c7f3..cedbfc1 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -143,26 +143,22 @@ static inline void touch_nmi_watchdog(void)
>  #ifdef arch_trigger_cpumask_backtrace
>  static inline bool trigger_all_cpu_backtrace(void)
>  {
> -       arch_trigger_cpumask_backtrace(cpu_online_mask, false);
> -       return true;
> +       return arch_trigger_cpumask_backtrace(cpu_online_mask, false);
>  }
>
>  static inline bool trigger_allbutself_cpu_backtrace(void)
>  {
> -       arch_trigger_cpumask_backtrace(cpu_online_mask, true);
> -       return true;
> +       return arch_trigger_cpumask_backtrace(cpu_online_mask, true);
>  }
>
>  static inline bool trigger_cpumask_backtrace(struct cpumask *mask)
>  {
> -       arch_trigger_cpumask_backtrace(mask, false);
> -       return true;
> +       return arch_trigger_cpumask_backtrace(mask, false);
>  }
>
>  static inline bool trigger_single_cpu_backtrace(int cpu)
>  {
> -       arch_trigger_cpumask_backtrace(cpumask_of(cpu), false);
> -       return true;
> +       return arch_trigger_cpumask_backtrace(cpumask_of(cpu), false);
>  }
>
>  /* generic implementation */
> --
> 2.7.4
>

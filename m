Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EDC29270D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 14:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgJSMPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 08:15:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbgJSMPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 08:15:50 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A74D222268;
        Mon, 19 Oct 2020 12:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603109749;
        bh=RYQpI+PlsEdpivnE+YOvprJVaqwBNAEJkR9tx1GcJa4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=clVAWMr3IFUpwbSGLYMFnhoyCjXo84OlYKfpqaNOO+RlNVrhG0ePOhZMv7ThU0Grk
         HN5gRo4gYu4Zgzc5851pH/KlhbP1JUrPDjWrVDMDFBnJZugMi/n1aGYdz/JiF9c+w0
         AYzxWQwRXEJq2Lly7B2Q5NN72fAI5MuLdmxYOYq0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kUU4p-002PeW-Im; Mon, 19 Oct 2020 13:15:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 19 Oct 2020 13:15:47 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, mark.rutland@arm.com,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        msys.mizuma@gmail.com, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] arm64: kgdb: Round up cpus using IPI as NMI
In-Reply-To: <1602673931-28782-5-git-send-email-sumit.garg@linaro.org>
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
 <1602673931-28782-5-git-send-email-sumit.garg@linaro.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <0899dcad304ac8bf0ea7d5308ec2e263@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sumit.garg@linaro.org, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, jason@lakedaemon.net, mark.rutland@arm.com, julien.thierry.kdev@gmail.com, dianders@chromium.org, daniel.thompson@linaro.org, jason.wessel@windriver.com, msys.mizuma@gmail.com, ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-14 12:12, Sumit Garg wrote:
> arm64 platforms with GICv3 or later supports pseudo NMIs which can be
> leveraged to round up CPUs which are stuck in hard lockup state with
> interrupts disabled that wouldn't be possible with a normal IPI.
> 
> So instead switch to round up CPUs using IPI turned as NMI. And in
> case a particular arm64 platform doesn't supports pseudo NMIs,
> this IPI will act as a normal IPI which maintains existing kgdb
> functionality.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  arch/arm64/include/asm/kgdb.h |  8 ++++++++
>  arch/arm64/kernel/ipi_nmi.c   |  5 ++++-
>  arch/arm64/kernel/kgdb.c      | 21 +++++++++++++++++++++
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kgdb.h 
> b/arch/arm64/include/asm/kgdb.h
> index 21fc85e..6f3d3af 100644
> --- a/arch/arm64/include/asm/kgdb.h
> +++ b/arch/arm64/include/asm/kgdb.h
> @@ -24,6 +24,14 @@ static inline void arch_kgdb_breakpoint(void)
>  extern void kgdb_handle_bus_error(void);
>  extern int kgdb_fault_expected;
> 
> +#ifdef CONFIG_KGDB
> +extern void ipi_kgdb_nmicallback(int cpu, void *regs);
> +#else
> +static inline void ipi_kgdb_nmicallback(int cpu, void *regs)
> +{
> +}
> +#endif
> +
>  #endif /* !__ASSEMBLY__ */
> 
>  /*
> diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
> index a959256..e0a9e03 100644
> --- a/arch/arm64/kernel/ipi_nmi.c
> +++ b/arch/arm64/kernel/ipi_nmi.c
> @@ -8,6 +8,7 @@
> 
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/kgdb.h>
>  #include <linux/smp.h>
> 
>  #include <asm/nmi.h>
> @@ -26,7 +27,9 @@ void arch_send_call_nmi_func_ipi_mask(cpumask_t 
> *mask)
> 
>  static irqreturn_t ipi_nmi_handler(int irq, void *data)
>  {
> -	/* nop, NMI handlers for special features can be added here. */
> +	unsigned int cpu = smp_processor_id();
> +
> +	ipi_kgdb_nmicallback(cpu, get_irq_regs());

Please add a return value to ipi_kgdb_nmicallback(), and check it
before returning IRQ_HANDLED.

Thinking a bit more about the whole thing, you should have a way to
avoid requesting the NMI if there is no user for it (there is nothing
worse than an enabled interrupt without handlers...).

> 
>  	return IRQ_HANDLED;
>  }
> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> index 1a157ca3..0991275 100644
> --- a/arch/arm64/kernel/kgdb.c
> +++ b/arch/arm64/kernel/kgdb.c
> @@ -17,6 +17,7 @@
> 
>  #include <asm/debug-monitors.h>
>  #include <asm/insn.h>
> +#include <asm/nmi.h>
>  #include <asm/traps.h>
> 
>  struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
> @@ -353,3 +354,23 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt 
> *bpt)
>  	return aarch64_insn_write((void *)bpt->bpt_addr,
>  			*(u32 *)bpt->saved_instr);
>  }
> +
> +void ipi_kgdb_nmicallback(int cpu, void *regs)
> +{
> +	if (atomic_read(&kgdb_active) != -1)
> +		kgdb_nmicallback(cpu, regs);
> +}
> +
> +#ifdef CONFIG_SMP

There is no such thing as an arm64 UP kernel.

> +void kgdb_roundup_cpus(void)
> +{
> +	struct cpumask mask;
> +
> +	cpumask_copy(&mask, cpu_online_mask);
> +	cpumask_clear_cpu(raw_smp_processor_id(), &mask);
> +	if (cpumask_empty(&mask))
> +		return;
> +
> +	arch_send_call_nmi_func_ipi_mask(&mask);

Surely you can come up with a less convoluted name for this function.
arm64_send_nmi() would be plenty in my opinion.

> +}
> +#endif

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

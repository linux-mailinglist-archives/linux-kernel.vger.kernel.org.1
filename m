Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4A429271E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 14:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgJSMUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 08:20:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgJSMUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 08:20:44 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B826522268;
        Mon, 19 Oct 2020 12:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603110043;
        bh=KudzWihYn7TsHFILrc3bbZ/Ot13PpKP3HdWaA7pXYFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UdOZNQz6NTdrIOdjekI0yw+JYVbCpVdC6VkLuZWQnl4Kt+aZXZN4cWYEe4GOPUHG/
         dvb9NauKrTxyxEZNPwV9uHlvXgYVVxNk59AyjXRIIlOhLBK2M9oP8RoD6VGTH9rrYM
         C9oG6OEUesu5t0D3oI+sQ4ZDEE1NnNfetHm34Nlk=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kUU9Z-002PiH-Gw; Mon, 19 Oct 2020 13:20:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 19 Oct 2020 13:20:41 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, mark.rutland@arm.com,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        msys.mizuma@gmail.com, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] arm64: ipi_nmi: Add support for NMI backtrace
In-Reply-To: <1602673931-28782-6-git-send-email-sumit.garg@linaro.org>
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
 <1602673931-28782-6-git-send-email-sumit.garg@linaro.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <d4a4a37b93f34da79b87519181bffb97@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sumit.garg@linaro.org, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, jason@lakedaemon.net, mark.rutland@arm.com, julien.thierry.kdev@gmail.com, dianders@chromium.org, daniel.thompson@linaro.org, jason.wessel@windriver.com, msys.mizuma@gmail.com, ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-14 12:12, Sumit Garg wrote:
> Enable NMI backtrace support on arm64 using IPI turned as an NMI
> leveraging pseudo NMIs support. It is now possible for users to get a
> backtrace of a CPU stuck in hard-lockup using magic SYSRQ.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  arch/arm64/include/asm/irq.h |  6 ++++++
>  arch/arm64/kernel/ipi_nmi.c  | 12 +++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/irq.h 
> b/arch/arm64/include/asm/irq.h
> index b2b0c64..e840bf1 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -6,6 +6,12 @@
> 
>  #include <asm-generic/irq.h>
> 
> +#ifdef CONFIG_SMP
> +extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
> +					   bool exclude_self);
> +#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
> +#endif
> +
>  struct pt_regs;
> 
>  static inline int nr_legacy_irqs(void)
> diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
> index e0a9e03..e1dc19d 100644
> --- a/arch/arm64/kernel/ipi_nmi.c
> +++ b/arch/arm64/kernel/ipi_nmi.c
> @@ -9,6 +9,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/kgdb.h>
> +#include <linux/nmi.h>
>  #include <linux/smp.h>
> 
>  #include <asm/nmi.h>
> @@ -25,12 +26,21 @@ void arch_send_call_nmi_func_ipi_mask(cpumask_t 
> *mask)
>  	__ipi_send_mask(ipi_desc, mask);
>  }
> 
> +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool 
> exclude_self)
> +{
> +	nmi_trigger_cpumask_backtrace(mask, exclude_self,
> +				      arch_send_call_nmi_func_ipi_mask);
> +}
> +
>  static irqreturn_t ipi_nmi_handler(int irq, void *data)
>  {
>  	unsigned int cpu = smp_processor_id();
> 
> -	ipi_kgdb_nmicallback(cpu, get_irq_regs());
> +	if (nmi_cpu_backtrace(get_irq_regs()))
> +		goto out;
> 
> +	ipi_kgdb_nmicallback(cpu, get_irq_regs());
> +out:
>  	return IRQ_HANDLED;
>  }

Can't you have *both* a request for a backtrace and a KGDB call?
It really shouldn't be either/or. It also outlines how well shared
interrupts work with edge triggered signalling...

         M.
-- 
Jazz is not dead. It just smells funny...

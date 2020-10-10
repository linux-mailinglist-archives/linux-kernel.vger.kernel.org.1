Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB38289D67
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 04:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbgJJCPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 22:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729849AbgJJB7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 21:59:04 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A25C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 18:58:58 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id g3so9566137qtq.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 18:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0puSsum/qABpfyTdyTDsS4fG67aid0BMWid+flFv+eg=;
        b=fQXTg+XZLmgQxJVK3nn/P82NsmMwZYM36l9N6OoupGMOPze7IhVxYtM1f3QLhDG9B5
         t/lcRTJ47AQ363Pd2VYfqn6HrqkfEf9Kpd5BTrrq6bW7Fo7RotcV2FhYzvJZf+XfN0p9
         8FVInVcA6pCh1RV49gm5qonfv3zNOLuWfUTri/W9ahqVey20l5mfLM7g4XMvKkPljvL4
         JnaGLWOnf33Lnvxdy8wM1YriPx3Cf6NM/MT6aVrnKan1UaOASdh0VeBrJ06l+ibdBSDZ
         JVnbNm1Tir+cu/3mf3EUsfivWdpy2x36wbIZv7554ELrAk1zB2zSPamc15h37ZzvT5af
         0xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0puSsum/qABpfyTdyTDsS4fG67aid0BMWid+flFv+eg=;
        b=BgLKmVsprPJio9otSsoMT6YW6f2BZdRFRTooge3Y4DFQguPSpXwFuLHMLZqBEcVz6C
         QG6UEn+7R4W3UNV7/zCTcTBhUXEpdcK77Hg7ElHfugF8vPDxUwQzWipBsh5czuoxRVU7
         GsDXZ+FM2l/wlbMBS3f8/pvPn3WvADSEqysGQxDI6AI+JG1IvyZeJ/kxmDcomsvtbhmA
         XJU7t0p/inCZyNXl2TEywraE4wm+J1R2AJMxTxyWL9DRAtDaeXZve0TMN0LSIdDkHr8D
         9seR7Lysa92DVA6I4XUWQMTlo06ykRTzhj9/sfc5WBv6+5b0EJYr6/xuxnluSGTqMT7g
         ch3g==
X-Gm-Message-State: AOAM530J7bMrg//0Us4JqKF6gZEbzwoEQZhqKuJSRODcWP6m0lvtK1VX
        W/qt6AOwuc7B+WEtYXPDJA==
X-Google-Smtp-Source: ABdhPJyOvRKWaRUpU8gTeLnfa2A+iOKvO661uUQJENQDBBEpn4QmSbzmaKlZ/d2GsF6VpyT/QDM78w==
X-Received: by 2002:ac8:295c:: with SMTP id z28mr846071qtz.37.1602295137887;
        Fri, 09 Oct 2020 18:58:57 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id o4sm7532382qkk.75.2020.10.09.18.58.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Oct 2020 18:58:57 -0700 (PDT)
Date:   Fri, 9 Oct 2020 21:58:55 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        mark.rutland@arm.com, daniel.thompson@linaro.org,
        jason@lakedaemon.net, kgdb-bugreport@lists.sourceforge.net,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jason.wessel@windriver.com,
        tglx@linutronix.de, julien.thierry.kdev@gmail.com
Subject: Re: [PATCH v4 1/5] arm64: Add framework to turn IPI as NMI
Message-ID: <20201010015855.vksetnj4luft5enc@gabell>
References: <1599830924-13990-1-git-send-email-sumit.garg@linaro.org>
 <1599830924-13990-2-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599830924-13990-2-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On Fri, Sep 11, 2020 at 06:58:40PM +0530, Sumit Garg wrote:
> Introduce framework to turn an IPI as NMI using pseudo NMIs. In case a
> particular platform doesn't support pseudo NMIs, then request IPI as a
> regular IRQ.
> 
> The main motivation for this feature is to have an IPI that can be
> leveraged to invoke NMI functions on other CPUs. And current prospective
> users are NMI backtrace and KGDB CPUs round-up whose support is added
> via future patches.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  arch/arm64/include/asm/nmi.h | 16 +++++++++
>  arch/arm64/kernel/Makefile   |  2 +-
>  arch/arm64/kernel/ipi_nmi.c  | 80 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 97 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/nmi.h
>  create mode 100644 arch/arm64/kernel/ipi_nmi.c
> 
> diff --git a/arch/arm64/include/asm/nmi.h b/arch/arm64/include/asm/nmi.h
> new file mode 100644
> index 0000000..3433c55
> --- /dev/null
> +++ b/arch/arm64/include/asm/nmi.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_NMI_H
> +#define __ASM_NMI_H
> +
> +#ifndef __ASSEMBLER__
> +
> +#include <linux/cpumask.h>
> +
> +extern void arch_send_call_nmi_func_ipi_mask(cpumask_t *mask);
> +
> +void set_smp_ipi_nmi(int ipi);
> +void ipi_nmi_setup(int cpu);
> +void ipi_nmi_teardown(int cpu);
> +
> +#endif /* !__ASSEMBLER__ */
> +#endif
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index a561cbb..022c26b 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -19,7 +19,7 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
>  			   return_address.o cpuinfo.o cpu_errata.o		\
>  			   cpufeature.o alternative.o cacheinfo.o		\
>  			   smp.o smp_spin_table.o topology.o smccc-call.o	\
> -			   syscall.o
> +			   syscall.o ipi_nmi.o
>  
>  targets			+= efi-entry.o
>  
> diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
> new file mode 100644
> index 0000000..355ef92
> --- /dev/null
> +++ b/arch/arm64/kernel/ipi_nmi.c
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * NMI support for IPIs
> + *
> + * Copyright (C) 2020 Linaro Limited
> + * Author: Sumit Garg <sumit.garg@linaro.org>
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/smp.h>
> +
> +#include <asm/nmi.h>
> +
> +static struct irq_desc *ipi_desc __read_mostly;
> +static int ipi_id __read_mostly;
> +static bool is_nmi __read_mostly;
> +
> +void arch_send_call_nmi_func_ipi_mask(cpumask_t *mask)
> +{
> +	if (WARN_ON_ONCE(!ipi_desc))
> +		return;
> +
> +	__ipi_send_mask(ipi_desc, mask);
> +}
> +
> +static irqreturn_t ipi_nmi_handler(int irq, void *data)
> +{
> +	/* nop, NMI handlers for special features can be added here. */
> +
> +	return IRQ_HANDLED;
> +}
> +
> +void ipi_nmi_setup(int cpu)
> +{
> +	if (!ipi_desc)
> +		return;

ipi_nmi_setup() may be called twice for CPU0:

  set_smp_ipi_range => set_smp_ipi_nmi => ipi_nmi_setup
                    => ipi_setup => ipi_nmi_setup

Actually, I got the following error message via the second ipi_nmi_setup():

  GICv3: Pseudo-NMIs enabled using relaxed ICC_PMR_EL1 synchronisation
  GICv3: Cannot set NMI property of enabled IRQ 8
  genirq: Failed to setup NMI delivery: irq 8

Why don't we have a check to prevent that? Like as:

       if (cpumask_test_cpu(cpu, ipi_desc->percpu_enabled))
               return;

> +
> +	if (is_nmi) {
> +		if (!prepare_percpu_nmi(ipi_id))
> +			enable_percpu_nmi(ipi_id, 0);

It would be better to use IRQ_TYPE_NONE instead of 0.

			enable_percpu_nmi(ipi_id, IRQ_TYPE_NONE);

> +	} else {
> +		enable_percpu_irq(ipi_id, 0);

Same as here:
		enable_percpu_irq(ipi_id, IRQ_TYPE_NONE);

Thanks,
Masa

> +	}
> +}
> +
> +void ipi_nmi_teardown(int cpu)
> +{
> +	if (!ipi_desc)
> +		return;
> +
> +	if (is_nmi) {
> +		disable_percpu_nmi(ipi_id);
> +		teardown_percpu_nmi(ipi_id);
> +	} else {
> +		disable_percpu_irq(ipi_id);
> +	}
> +}
> +
> +void __init set_smp_ipi_nmi(int ipi)
> +{
> +	int err;
> +
> +	err = request_percpu_nmi(ipi, ipi_nmi_handler, "IPI", &cpu_number);
> +	if (err) {
> +		err = request_percpu_irq(ipi, ipi_nmi_handler, "IPI",
> +					 &cpu_number);
> +		WARN_ON(err);
> +		is_nmi = false;
> +	} else {
> +		is_nmi = true;
> +	}
> +
> +	ipi_desc = irq_to_desc(ipi);
> +	irq_set_status_flags(ipi, IRQ_HIDDEN);
> +	ipi_id = ipi;
> +
> +	/* Setup the boot CPU immediately */
> +	ipi_nmi_setup(smp_processor_id());
> +}
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

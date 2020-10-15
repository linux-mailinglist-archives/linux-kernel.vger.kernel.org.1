Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDAC28E9F5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388639AbgJOBZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732052AbgJOBYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:24:38 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF6DC045706
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 18:15:20 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id y16so2213130ila.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 18:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V2cA815NsTarbXE0So8lMwyw3woqxWcfe6evJUcU51k=;
        b=TVE03/vu6ub7sYfPR008WACjyftKWZ/1pnircAiw+rK83dl7rUxoiSGJ00r16y5oW4
         bJNXaJNzpGcUVxT3/SmJeC9tH2pnuSrtr+wm5IGGmalnCjVTnhUliixx2dw6N39012Ii
         zgbs9BAc8u8rognBxRl4/rd680qo+toXPfMGsTBiwgaIlnQiJ2MlCl2DlQCQ/0bOCaZX
         WiypgQkBgG5tRbONn7akFMFy7C4KvgDBXdKGCi5JoxeK23nQ9dQPaJ+tSg7lq1PmyyJC
         E1Rz7EHRfmuadtmdrJLwdd2vDE7fvcegGsmKmt9mp4bT4mEwlr82MRyLIHuq6dU2Zlep
         Cqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V2cA815NsTarbXE0So8lMwyw3woqxWcfe6evJUcU51k=;
        b=K2Ug7SpWp2Esp6AZ8h7xdj5OhUH9IeVgNeCb3a5DGNxXKkSIZ/Z7q+p+od/9Hw3tew
         Va+1no7vDVxJZT6qYsdVea9rjJOKbm5zjmuxjmiD00uyAGNK8xA0wMfPEJBgStV3P+A1
         hqaFVJpG5TQcGVzBaQMdhgrWeeUpz4NFQrCw7ekIQl95MDo9SYOMDgNOpaOWJ2pqkno9
         I0l7UAfV+TLR5vCL5385eBb/6IbaA2EkYTh8t4XFa29796Mecsx4Mjp4T7ZPa5w4OWPN
         AIp02LJblV1wzl3yL3gDSprAMlBTb2P5kgb3J4NlC82PJheg+JS3vNqO+VFYFZAaWLbM
         +4ZA==
X-Gm-Message-State: AOAM532i/Xy3lDr9iVzYFBb5hpjpEfs7B+6HDdelw0ek/RG1yoZMGDEX
        myIqxkIDbvDPsVRwUxBE7Q==
X-Google-Smtp-Source: ABdhPJwuuLHuywYV+PzlX1kFDLVRVogDrB9cucCfEEzDFBWRNjOWrUKc+3G244zounjp075lUDJewg==
X-Received: by 2002:a92:cd05:: with SMTP id z5mr1300524iln.15.1602724519540;
        Wed, 14 Oct 2020 18:15:19 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id r5sm1107496ioj.51.2020.10.14.18.15.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Oct 2020 18:15:18 -0700 (PDT)
Date:   Wed, 14 Oct 2020 21:15:15 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, mark.rutland@arm.com,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] arm64: Add framework to turn IPI as NMI
Message-ID: <20201015011515.dhwgxki5eyewcgyv@gabell>
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
 <1602673931-28782-2-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602673931-28782-2-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 04:42:07PM +0530, Sumit Garg wrote:
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
>  arch/arm64/kernel/ipi_nmi.c  | 77 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 94 insertions(+), 1 deletion(-)
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
> index bbaf0bc..525a1e0 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -17,7 +17,7 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
>  			   return_address.o cpuinfo.o cpu_errata.o		\
>  			   cpufeature.o alternative.o cacheinfo.o		\
>  			   smp.o smp_spin_table.o topology.o smccc-call.o	\
> -			   syscall.o proton-pack.o
> +			   syscall.o proton-pack.o ipi_nmi.o
>  
>  targets			+= efi-entry.o
>  
> diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
> new file mode 100644
> index 0000000..a959256
> --- /dev/null
> +++ b/arch/arm64/kernel/ipi_nmi.c
> @@ -0,0 +1,77 @@
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
> +
> +	if (is_nmi) {
> +		if (!prepare_percpu_nmi(ipi_id))
> +			enable_percpu_nmi(ipi_id, IRQ_TYPE_NONE);
> +	} else {
> +		enable_percpu_irq(ipi_id, IRQ_TYPE_NONE);
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
> +}
> -- 

Looks good to me. Please feel free to add:

	Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Thanks!
Masa

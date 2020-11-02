Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C572A2E64
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 16:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgKBPd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 10:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBPd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 10:33:56 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5841C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 07:33:54 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id b18so11774113qkc.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 07:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jkd5WRUAKaIIbJUIfCjcR2xQVAOUb4rIGq3LFrUWxsE=;
        b=BZ0SsxESF8rSskfH+stShhCnOd6JGOyfEi8XtbgOg8OATjoZrTZ7s45AsVU0BC82xz
         ddLpAsGN9vZxHp6av72FDoi/Wrhyj/Kui0p71PX6TrCN2aQIVnlraNYCpd5TQ+3F6sdN
         86KHo45OCukF/pRhU4Vk/I7J2Ek1KUauw4cm/KVDK0TVgFlp8BYZwQfR+PL1GlGB2Qh5
         7TOR252d9wf/hQY1aa2GtEKgXWWg2tFSQTH7mXi0P3hgg73QciG8eqTk8aINdog0jBfD
         KD54aS7LUXZ6cML9vt4HGOjSuXDxve0E98pCurySYOto0Iza9iq/jVDun/BoycL0suWA
         pDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jkd5WRUAKaIIbJUIfCjcR2xQVAOUb4rIGq3LFrUWxsE=;
        b=np9bIEjPfEZ9xsRy+wC1fNzN93iL3iOG4ExsGJ06HSIF2SbwShfkJx9cGJjlduMAXk
         ZdYMUcWZpOiv+G0ZFNa3UlcrgB0vtw4nQ2sQJQFRfhnLKtCTsoattcMZXZ9Cieb/7cNK
         gibMLyZ8v4i2BxoTAxVDaqrIG6wwMe8I6Qj8ZqgwClgrMfvUylJnnbbQRFTqJg9SCE0e
         yoN1pp7M90+hy1ZtpNojSAFxW2n6JfCGlgnzXPvp7aCE4CmNq04Nx54QgWITVKpb/SOl
         PgGU3F4R0m+7Jdn15YwkvRs0wkAvg4o1cVrY9UDdcBmgcr30lZ6Wk8805GCqyHcFmZBL
         AOIA==
X-Gm-Message-State: AOAM530L2PT93KmWqKedcpdoAF8bt+s2S/UMYMWCl/yDOaylvgJewLV2
        KhCFZjEVFaKhuI6j4kovKA==
X-Google-Smtp-Source: ABdhPJxxfArhbX9SYy8Rmm26gib6WG8GrpJLzA/QMpD5c6xMFrlMZ2qveL6OMlPTG8NeDaTBLSSq4A==
X-Received: by 2002:a37:8cc1:: with SMTP id o184mr15679047qkd.205.1604331234080;
        Mon, 02 Nov 2020 07:33:54 -0800 (PST)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id y82sm7507470qkb.129.2020.11.02.07.33.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Nov 2020 07:33:52 -0800 (PST)
Date:   Mon, 2 Nov 2020 10:33:49 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        daniel.thompson@linaro.org, linux-arm-kernel@lists.infradead.org,
        tglx@linutronix.de, jason@lakedaemon.net, linux@armlinux.org.uk,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au, davem@davemloft.net,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        mark.rutland@arm.com, julien.thierry.kdev@gmail.com,
        dianders@chromium.org, jason.wessel@windriver.com,
        ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/7] arm64: Add framework to turn IPI as NMI
Message-ID: <20201102153349.fay4f5iam76gfapu@gabell>
References: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
 <1604317487-14543-2-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604317487-14543-2-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 05:14:41PM +0530, Sumit Garg wrote:
> Introduce framework to turn an IPI as NMI using pseudo NMIs. The main
> motivation for this feature is to have an IPI that can be leveraged to
> invoke NMI functions on other CPUs.
> 
> And current prospective users are NMI backtrace and KGDB CPUs round-up
> whose support is added via future patches.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  arch/arm64/include/asm/nmi.h | 17 ++++++++++++
>  arch/arm64/kernel/Makefile   |  2 +-
>  arch/arm64/kernel/ipi_nmi.c  | 65 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/nmi.h
>  create mode 100644 arch/arm64/kernel/ipi_nmi.c
> 
> diff --git a/arch/arm64/include/asm/nmi.h b/arch/arm64/include/asm/nmi.h
> new file mode 100644
> index 0000000..4cd14b6
> --- /dev/null
> +++ b/arch/arm64/include/asm/nmi.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_NMI_H
> +#define __ASM_NMI_H
> +
> +#ifndef __ASSEMBLER__
> +
> +#include <linux/cpumask.h>
> +
> +extern bool arm64_supports_nmi(void);
> +extern void arm64_send_nmi(cpumask_t *mask);
> +
> +void set_smp_dynamic_ipi(int ipi);
> +void dynamic_ipi_setup(int cpu);
> +void dynamic_ipi_teardown(int cpu);
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
> index 0000000..a945dcf
> --- /dev/null
> +++ b/arch/arm64/kernel/ipi_nmi.c
> @@ -0,0 +1,65 @@
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
> +static struct irq_desc *ipi_nmi_desc __read_mostly;
> +static int ipi_nmi_id __read_mostly;
> +
> +bool arm64_supports_nmi(void)
> +{
> +	if (ipi_nmi_desc)
> +		return true;
> +
> +	return false;
> +}
> +
> +void arm64_send_nmi(cpumask_t *mask)
> +{
> +	if (WARN_ON_ONCE(!ipi_nmi_desc))
> +		return;
> +
> +	__ipi_send_mask(ipi_nmi_desc, mask);
> +}
> +
> +static irqreturn_t ipi_nmi_handler(int irq, void *data)
> +{
> +	/* nop, NMI handlers for special features can be added here. */
> +
> +	return IRQ_NONE;
> +}
> +

> +void dynamic_ipi_setup(int cpu)

cpu isn't used here, so void is better?

void dynamic_ipi_setup(void)

> +{
> +	if (!ipi_nmi_desc)
> +		return;
> +
> +	if (!prepare_percpu_nmi(ipi_nmi_id))
> +		enable_percpu_nmi(ipi_nmi_id, IRQ_TYPE_NONE);
> +}
> +

> +void dynamic_ipi_teardown(int cpu)

Same as here:
void dynamic_ipi_teardown(void)

> +{
> +	if (!ipi_nmi_desc)
> +		return;
> +
> +	disable_percpu_nmi(ipi_nmi_id);
> +	teardown_percpu_nmi(ipi_nmi_id);
> +}
> +
> +void __init set_smp_dynamic_ipi(int ipi)
> +{
> +	if (!request_percpu_nmi(ipi, ipi_nmi_handler, "IPI", &cpu_number)) {
> +		ipi_nmi_desc = irq_to_desc(ipi);
> +		ipi_nmi_id = ipi;
> +	}
> +}
> -- 

Otherwise, looks good to me. Please feel free to add:

	Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Thanks,
Masa

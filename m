Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75DA2926DE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 13:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgJSL7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 07:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgJSL7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 07:59:45 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDD8322268;
        Mon, 19 Oct 2020 11:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603108785;
        bh=xXDbAKNUCfLYB41p8lNKI+uLH9Q6GhC1oI5JuyCZbq0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MBdvLMQwLD8e4lGKoUJzoW64XIc/c33jJ34K8Irt502/bAAsXzmonvcLzSvkJcw4g
         xfZsagWWyCuPTIfjqzkUvgH1mV8iUZ96yHr0OQjcxEEv4wIX/a+Pps5gv6VnjMzhfN
         DuUCq2T7Vn+sAH9HkuXnwmv7yakAUsh1j3oVOQgc=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kUTpH-002PRY-0I; Mon, 19 Oct 2020 12:59:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 19 Oct 2020 12:59:42 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, mark.rutland@arm.com,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        msys.mizuma@gmail.com, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] arm64: smp: Allocate and setup IPI as NMI
In-Reply-To: <1602673931-28782-4-git-send-email-sumit.garg@linaro.org>
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
 <1602673931-28782-4-git-send-email-sumit.garg@linaro.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <1c68b74251dc72b0cd74706280ea96f7@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sumit.garg@linaro.org, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, jason@lakedaemon.net, mark.rutland@arm.com, julien.thierry.kdev@gmail.com, dianders@chromium.org, daniel.thompson@linaro.org, jason.wessel@windriver.com, msys.mizuma@gmail.com, ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-14 12:12, Sumit Garg wrote:
> Allocate an unused IPI that can be turned as NMI using ipi_nmi 
> framework.

This doesn't do any allocation, as far as I can see. It relies on
the initial grant from the interrupt controller to be larger than
what the kernel currently uses.

> Also, invoke corresponding NMI setup/teardown APIs.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  arch/arm64/kernel/smp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 82e75fc..129ebfb 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -43,6 +43,7 @@
>  #include <asm/daifflags.h>
>  #include <asm/kvm_mmu.h>
>  #include <asm/mmu_context.h>
> +#include <asm/nmi.h>
>  #include <asm/numa.h>
>  #include <asm/processor.h>
>  #include <asm/smp_plat.h>
> @@ -962,6 +963,8 @@ static void ipi_setup(int cpu)
> 
>  	for (i = 0; i < nr_ipi; i++)
>  		enable_percpu_irq(ipi_irq_base + i, 0);
> +
> +	ipi_nmi_setup(cpu);
>  }
> 
>  #ifdef CONFIG_HOTPLUG_CPU
> @@ -974,6 +977,8 @@ static void ipi_teardown(int cpu)
> 
>  	for (i = 0; i < nr_ipi; i++)
>  		disable_percpu_irq(ipi_irq_base + i);
> +
> +	ipi_nmi_teardown(cpu);
>  }
>  #endif
> 
> @@ -995,6 +1000,9 @@ void __init set_smp_ipi_range(int ipi_base, int n)
>  		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
>  	}
> 
> +	if (n > nr_ipi)
> +		set_smp_ipi_nmi(ipi_base + nr_ipi);
> +
>  	ipi_irq_base = ipi_base;
> 
>  	/* Setup the boot CPU immediately */

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

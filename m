Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17F02D5F56
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389955AbgLJPRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:17:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391371AbgLJPQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:16:41 -0500
Date:   Thu, 10 Dec 2020 15:15:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607613360;
        bh=kHNS8N1Y1yxm0DyC7/WLIFewRb1Wj0ozzwMLOaPUVUQ=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=dC7k2aLpmUOreTjvbYcnBBIQmHfNZv+HAQstLkyreKoO9vMMN58oVM8U7CuRxFaFq
         wwGXIUCRx9oMS72bZGZ17wOwuul00XvKA8qJ1qTjVmD3Evjay2/8E9EDI/ABecu8Np
         Uqh4Qbgge2BQubbk2q2X9EcD0YcaL5EhKQIBKmNAeqrGTbM/jmYgj5qwVjq8QjOXz7
         0V5HXTPCa+DGH4UNLJvUsvrKu+rghn5aLGg7WzK1VRZB1y7qp6BE19kvrHmcamVaLm
         DgdbpyXWVPFpEY3S4hZ6PtwN31AQA81jfr0n29k+eex0Y3VsPyG9mXT1M19rwrqb/5
         kGwG09YCrwdkw==
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 3/6] arm64: Mark the recheduling IPI as raw interrupt
Message-ID: <20201210151555.GB10381@willie-the-truck>
References: <20201124141449.572446-1-maz@kernel.org>
 <20201124141449.572446-4-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124141449.572446-4-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:14:46PM +0000, Marc Zyngier wrote:
> Flag the rescheduling IPI as 'raw', making sure such interrupt
> skips both tick management  and irqtime accounting.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/Kconfig      | 1 +
>  arch/arm64/kernel/smp.c | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1515f6f153a0..d18c2c15848d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -108,6 +108,7 @@ config ARM64
>  	select GENERIC_EARLY_IOREMAP
>  	select GENERIC_IDLE_POLL_SETUP
>  	select GENERIC_IRQ_IPI
> +	select ARCH_WANTS_IRQ_RAW
>  	select GENERIC_IRQ_MULTI_HANDLER
>  	select GENERIC_IRQ_PROBE
>  	select GENERIC_IRQ_SHOW
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 18e9727d3f64..bad51f7f7ffe 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -995,6 +995,10 @@ void __init set_smp_ipi_range(int ipi_base, int n)
>  
>  		ipi_desc[i] = irq_to_desc(ipi_base + i);
>  		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
> +
> +		/* The recheduling IPI is special... */
> +		if (i == IPI_RESCHEDULE)
> +			__irq_modify_status(ipi_base + i, 0, IRQ_RAW, ~0);

Acked-by: Will Deacon <will@kernel.org>

Although this part isn't the controversial bit :)

Will

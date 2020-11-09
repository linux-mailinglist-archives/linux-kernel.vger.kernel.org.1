Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FBD2AB77D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbgKILsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:48:35 -0500
Received: from foss.arm.com ([217.140.110.172]:38444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729599AbgKILse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:48:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35A66106F;
        Mon,  9 Nov 2020 03:48:34 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.58.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A77F93F718;
        Mon,  9 Nov 2020 03:48:32 -0800 (PST)
Date:   Mon, 9 Nov 2020 11:48:25 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/smp: Drop the macro S(x,s)
Message-ID: <20201109114825.GA64518@C02TD0UTHF1T.local>
References: <1604921916-23368-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604921916-23368-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 05:08:36PM +0530, Anshuman Khandual wrote:
> Mapping between IPI type index and its string is direct without requiring
> an additional offset. Hence the existing macro S(x, s) is now redundant
> and can just be dropped. This also makes the code clean and simple.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Nice cleanup!

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/smp.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 09c96f57818c..65d18a618abe 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -786,14 +786,13 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  }
>  
>  static const char *ipi_types[NR_IPI] __tracepoint_string = {
> -#define S(x,s)	[x] = s
> -	S(IPI_RESCHEDULE, "Rescheduling interrupts"),
> -	S(IPI_CALL_FUNC, "Function call interrupts"),
> -	S(IPI_CPU_STOP, "CPU stop interrupts"),
> -	S(IPI_CPU_CRASH_STOP, "CPU stop (for crash dump) interrupts"),
> -	S(IPI_TIMER, "Timer broadcast interrupts"),
> -	S(IPI_IRQ_WORK, "IRQ work interrupts"),
> -	S(IPI_WAKEUP, "CPU wake-up interrupts"),
> +	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
> +	[IPI_CALL_FUNC]		= "Function call interrupts",
> +	[IPI_CPU_STOP]		= "CPU stop interrupts",
> +	[IPI_CPU_CRASH_STOP]	= "CPU stop (for crash dump) interrupts",
> +	[IPI_TIMER]		= "Timer broadcast interrupts",
> +	[IPI_IRQ_WORK]		= "IRQ work interrupts",
> +	[IPI_WAKEUP]		= "CPU wake-up interrupts",
>  };
>  
>  static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
> -- 
> 2.20.1
> 

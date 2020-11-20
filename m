Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC512BA073
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 03:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgKTCc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 21:32:26 -0500
Received: from foss.arm.com ([217.140.110.172]:42218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbgKTCcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 21:32:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2F701478;
        Thu, 19 Nov 2020 18:32:24 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63A093F70D;
        Thu, 19 Nov 2020 18:32:23 -0800 (PST)
Subject: Re: [PATCH] arm/smp: Drop the macro S(x,s)
To:     linux-arm-kernel@lists.infradead.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
References: <1604922432-25825-1-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <eb106e52-10be-0361-25b8-8a94ebccab64@arm.com>
Date:   Fri, 20 Nov 2020 08:02:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1604922432-25825-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/20 5:17 PM, Anshuman Khandual wrote:
> Mapping between IPI type index and its string is direct without requiring
> an additional offset. Hence the existing macro S(x, s) is now redundant
> and can just be dropped. This also makes the code clean and simple.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Only build tested.

Hello Russel,

Any updates on this ? Considering the patch being just a simple
cleanup, wondering if it can now be submitted in the arm patch
tracking system. Thank you.

- Anshuman
 
> 
>  arch/arm/kernel/smp.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 48099c6e1e4a..6ab2b0ad5f40 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -524,14 +524,13 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  }
>  
>  static const char *ipi_types[NR_IPI] __tracepoint_string = {
> -#define S(x,s)	[x] = s
> -	S(IPI_WAKEUP, "CPU wakeup interrupts"),
> -	S(IPI_TIMER, "Timer broadcast interrupts"),
> -	S(IPI_RESCHEDULE, "Rescheduling interrupts"),
> -	S(IPI_CALL_FUNC, "Function call interrupts"),
> -	S(IPI_CPU_STOP, "CPU stop interrupts"),
> -	S(IPI_IRQ_WORK, "IRQ work interrupts"),
> -	S(IPI_COMPLETION, "completion interrupts"),
> +	[IPI_WAKEUP]		= "CPU wakeup interrupts",
> +	[IPI_TIMER]		= "Timer broadcast interrupts",
> +	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
> +	[IPI_CALL_FUNC]		= "Function call interrupts",
> +	[IPI_CPU_STOP]		= "CPU stop interrupts",
> +	[IPI_IRQ_WORK]		= "IRQ work interrupts",
> +	[IPI_COMPLETION]	= "completion interrupts",
>  };
>  
>  static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
> 

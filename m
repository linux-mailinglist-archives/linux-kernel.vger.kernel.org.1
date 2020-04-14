Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EB91A7906
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 13:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438873AbgDNK7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 06:59:42 -0400
Received: from foss.arm.com ([217.140.110.172]:53102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438846AbgDNK7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:59:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71FBB1FB;
        Tue, 14 Apr 2020 03:59:38 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.30.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 413B03F6C4;
        Tue, 14 Apr 2020 03:59:36 -0700 (PDT)
Date:   Tue, 14 Apr 2020 11:59:23 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Xie XiuQi <xiexiuqi@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        james.morse@arm.com, tanxiaofei@huawei.com,
        wangxiongfeng2@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: panic on synchronous external abort in kernel
 context
Message-ID: <20200414105923.GA2486@C02TD0UTHF1T.local>
References: <20200410015245.23230-1-xiexiuqi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410015245.23230-1-xiexiuqi@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 09:52:45AM +0800, Xie XiuQi wrote:
> We should panic even panic_on_oops is not set, when we can't recover
> from synchronous external abort in kernel context.
> 
> Othervise, there are two issues:
> 1) fallback to do_exit() in exception context, cause this core hung up.
>    do_sea()
>    -> arm64_notify_die
>       -> die
>          -> do_exit
> 2) errors may propagated.
> 
> Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
> Cc: Xiaofei Tan <tanxiaofei@huawei.com>
> ---
>  arch/arm64/include/asm/esr.h | 12 ++++++++++++
>  arch/arm64/kernel/traps.c    |  2 ++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> index cb29253ae86b..acfc71c6d148 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/arch/arm64/include/asm/esr.h
> @@ -326,6 +326,18 @@ static inline bool esr_is_data_abort(u32 esr)
>  	return ec == ESR_ELx_EC_DABT_LOW || ec == ESR_ELx_EC_DABT_CUR;
>  }
>  
> +static inline bool esr_is_inst_abort(u32 esr)
> +{
> +	const u32 ec = ESR_ELx_EC(esr);
> +
> +	return ec == ESR_ELx_EC_IABT_LOW || ec == ESR_ELx_EC_IABT_CUR;
> +}
> +
> +static inline bool esr_is_ext_abort(u32 esr)
> +{
> +	return esr_is_data_abort(esr) || esr_is_inst_abort(esr);
> +}

A data abort or an intstruction abort are not necessarily synchronus
external aborts, so this isn't right.

What exactly are you trying to catch here? If you are seeing a problem
in practice, can you please share your log from a crash?

Thanks,
Mark.

> +
>  const char *esr_get_class_string(u32 esr);
>  #endif /* __ASSEMBLY */
>  
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index cf402be5c573..08f7f7688d5b 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -202,6 +202,8 @@ void die(const char *str, struct pt_regs *regs, int err)
>  		panic("Fatal exception in interrupt");
>  	if (panic_on_oops)
>  		panic("Fatal exception");
> +	if (esr_is_ext_abort(err))
> +		panic("Synchronous external abort in kernel context");
>  
>  	raw_spin_unlock_irqrestore(&die_lock, flags);
>  
> -- 
> 2.20.1
> 

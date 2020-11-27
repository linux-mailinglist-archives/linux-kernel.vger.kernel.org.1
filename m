Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524A02C6B92
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 19:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgK0S1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 13:27:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgK0S1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 13:27:12 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DDE121534;
        Fri, 27 Nov 2020 18:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606501631;
        bh=Lu84xRTk7cx2H7+emSh0+FVhYJQrZ8oQSXubGcw8RA4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FmJvBhHrSkTmADhmrlMCa8Zvvpo3z0Pfws8fPyf4dY8H4Y4SCaso+jZJTrGpL7jg9
         3pEBem/Uk4xGgwdJQ/tuw+KOAswEdYapkHiNgrfPhksfp6HQix1o/rlIbbbB0g0OTx
         o0NWifoGHWaVX9BLAi2xo8k1ChlBz7AsETYTlkrY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kiiSb-00E8P8-1u; Fri, 27 Nov 2020 18:27:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 Nov 2020 18:27:08 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Hanks Chen <hanks.chen@mediatek.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        CC Hwang <cc.hwang@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Subject: Re: [PATCH v1 3/3] arm64: disable irq on cpu shutdown flow
In-Reply-To: <1606486531-25719-4-git-send-email-hanks.chen@mediatek.com>
References: <1606486531-25719-1-git-send-email-hanks.chen@mediatek.com>
 <1606486531-25719-4-git-send-email-hanks.chen@mediatek.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <e0fb8fade871b08295ed2be488406ff3@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: hanks.chen@mediatek.com, tglx@linutronix.de, matthias.bgg@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, cc.hwang@mediatek.com, kuohong.wang@mediatek.com, loda.chou@mediatek.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-27 14:15, Hanks Chen wrote:
> Disable irq on cpu shutdown flow to ensure interrupts
> did not bother this cpu after status as offline.
> 
> To avoid suspicious RCU usage
> (0)[0:swapper/0]RCU used illegally from offline CPU! ...
> (0)[0:swapper/0]lockdep: [name:lockdep&]cpu_id = 0, cpu_is_offline = 1

This needs to be explained *a lot* more .

My hunch is that because a CPU going offline can still receive 
interrupts
thanks to your interrupt broadcast hack, you break some the core 
expectations,
and RCU shouts at you.

If that's indeed the case, I don't think the architecture code needs 
fixing
(or at least, not for that).

> 
> Signed-off-by: Hanks Chen <hanks.chen@mediatek.com>
> ---
>  arch/arm64/kernel/smp.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 82e75fc2c903..27a6553fa86f 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -308,6 +308,12 @@ int __cpu_disable(void)
>  	remove_cpu_topology(cpu);
>  	numa_remove_cpu(cpu);
> 
> +	/*
> +	 * we disable irq here to ensure interrupts
> +	 * did not bother this cpu after status as offline.
> +	 */
> +	local_irq_disable();
> +
>  	/*
>  	 * Take this CPU offline.  Once we clear this, we can't return,
>  	 * and we must not schedule until we're ready to give up the cpu.

Conveniently, the code that takes care of migrating the interrupts is
just below this comment.  Which strongly suggests that the interrupt
migration is broken by your earlier patch.

> @@ -842,9 +848,10 @@ void arch_irq_work_raise(void)
> 
>  static void local_cpu_stop(void)
>  {
> +	local_daif_mask();
> +
>  	set_cpu_online(smp_processor_id(), false);
> 
> -	local_daif_mask();
>  	sdei_mask_local_cpu();
>  	cpu_park_loop();
>  }

What problem are you addressing here?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

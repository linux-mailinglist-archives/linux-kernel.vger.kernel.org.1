Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479F92768F4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 08:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgIXGcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 02:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIXGcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:32:03 -0400
Received: from localhost (unknown [84.241.198.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 237B8235F7;
        Thu, 24 Sep 2020 06:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600929122;
        bh=q3dGRMsXisP3Hey4o5wbHrOOiaTRw37tCAYXV2aqPGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ht5JQHIIhw1yuQoYY5ldsPaqlp63FgdGU7OIu+uNfU7lrHwksOOXC2Tcmt1ho9T+q
         6NZ54jEJDe5q5dhOFUNp917dJWO93BG6J0L43E9VQAPZsLQeYfg9cSKBHJ5VrCajuf
         3Ygs0FcvlWPwrpU63dk6ljchiweRoAIxDd6rejaY=
Date:   Thu, 24 Sep 2020 08:31:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prasad Sodagudi <psodagud@codeaurora.org>
Cc:     rostedt@goodmis.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, tkjos@google.com
Subject: Re: [PATCH 1/2] genirq/cpuhotplug: Reduce logging level for couple
 of prints
Message-ID: <20200924063152.GA592892@kroah.com>
References: <1600906112-126722-1-git-send-email-psodagud@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600906112-126722-1-git-send-email-psodagud@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 05:08:31PM -0700, Prasad Sodagudi wrote:
> During the cpu hot plug stress testing, couple of messages
> continuous flooding on to the console is causing timers
> migration delay. Delayed time migrations from hot plugging
> core is causing device instability with watchdog. So reduce
> log level for couple of prints in cpu hot plug flow.
> 
> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> ---
>  arch/arm64/kernel/smp.c | 2 +-
>  kernel/irq/cpuhotplug.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 355ee9e..08da6e3 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -338,7 +338,7 @@ void __cpu_die(unsigned int cpu)
>  		pr_crit("CPU%u: cpu didn't die\n", cpu);
>  		return;
>  	}
> -	pr_notice("CPU%u: shutdown\n", cpu);
> +	pr_info("CPU%u: shutdown\n", cpu);
>  
>  	/*
>  	 * Now that the dying CPU is beyond the point of no return w.r.t.
> diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
> index 02236b1..82802e0 100644
> --- a/kernel/irq/cpuhotplug.c
> +++ b/kernel/irq/cpuhotplug.c
> @@ -42,7 +42,7 @@ static inline bool irq_needs_fixup(struct irq_data *d)
>  		 * If this happens then there was a missed IRQ fixup at some
>  		 * point. Warn about it and enforce fixup.
>  		 */
> -		pr_warn("Eff. affinity %*pbl of IRQ %u contains only offline CPUs after offlining CPU %u\n",
> +		pr_info("Eff. affinity %*pbl of IRQ %u contains only offline CPUs after offlining CPU %u\n",
>  			cpumask_pr_args(m), d->irq, cpu);
>  		return true;
>  	}
> @@ -166,7 +166,7 @@ void irq_migrate_all_off_this_cpu(void)
>  		raw_spin_unlock(&desc->lock);
>  
>  		if (affinity_broken) {
> -			pr_warn_ratelimited("IRQ %u: no longer affine to CPU%u\n",
> +			pr_info_ratelimited("IRQ %u: no longer affine to CPU%u\n",
>  					    irq, smp_processor_id());
>  		}
>  	}
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

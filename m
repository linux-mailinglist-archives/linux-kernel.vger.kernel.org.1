Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E09C2A947C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgKFKiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:38:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbgKFKiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:38:02 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73ECD20702;
        Fri,  6 Nov 2020 10:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604659082;
        bh=96sVWS8VO/ONFzQ6FJE2fVYD3WeXWxXGoalF8Bg6h0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wyh+J6qlrauKrR/bERnNw4Y+vAInAXAPR/KcIYirYfG3g+VypK3ZSInJI+i2fM8cT
         qhlM59AfksNVPWlt3cZDeYImQWV8NDsVnFm/YK7XtWNar0toedXmM9YVi1rZok7Alq
         Gz4XqBMmVMAI4ilfaN8TJfxKsASoHHU6RhepPiVE=
Date:   Fri, 6 Nov 2020 10:37:56 +0000
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <cai@redhat.com>
Cc:     paulmck@kernel.org, catalin.marinas@arm.com,
        kernel-team@android.com, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/smp: Move rcu_cpu_starting() earlier
Message-ID: <20201106103755.GA9729@willie-the-truck>
References: <20201028182614.13655-1-cai@redhat.com>
 <160404559895.1777248.8248643695413627642.b4-ty@kernel.org>
 <20201105222242.GA8842@willie-the-truck>
 <3b4c324abdabd12d7bd5346c18411e667afe6a55.camel@redhat.com>
 <20201105232813.GR3249@paulmck-ThinkPad-P72>
 <ec2de23c04e400266fcf98dfd282da0b173a68c3.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec2de23c04e400266fcf98dfd282da0b173a68c3.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 09:15:24PM -0500, Qian Cai wrote:
> On Thu, 2020-11-05 at 15:28 -0800, Paul E. McKenney wrote:
> > On Thu, Nov 05, 2020 at 06:02:49PM -0500, Qian Cai wrote:
> > > On Thu, 2020-11-05 at 22:22 +0000, Will Deacon wrote:
> > > > Hmm, this patch has caused a regression in the case that we fail to
> > > > online a CPU because it has incompatible CPU features and so we park it
> > > > in cpu_die_early(). We now get an endless spew of RCU stalls because the
> > > > core will never come online, but is being tracked by RCU. So I'm tempted
> > > > to revert this and live with the lockdep warning while we figure out a
> > > > proper fix.
> > > > 
> > > > What's the correct say to undo rcu_cpu_starting(), given that we cannot
> > > > invoke the full hotplug machinery here? Is it correct to call
> > > > rcutree_dying_cpu() on the bad CPU and then rcutree_dead_cpu() from the
> > > > CPU doing cpu_up(), or should we do something else?
> > > It looks to me that rcu_report_dead() does the opposite of
> > > rcu_cpu_starting(),
> > > so lift rcu_report_dead() out of CONFIG_HOTPLUG_CPU and use it there to
> > > rewind,
> > > Paul?
> > 
> > Yes, rcu_report_dead() should do the trick.  Presumably the earlier
> > online-time CPU-hotplug notifiers are also unwound?
> I don't think that is an issue here. cpu_die_early() set CPU_STUCK_IN_KERNEL,
> and then __cpu_up() will see a timeout waiting for the AP online and then deal
> with CPU_STUCK_IN_KERNEL according. Thus, something like this? I don't see
> anything in rcu_report_dead() depends on CONFIG_HOTPLUG_CPU=y.

Cheers both for suggesting rcu_report_dead().

> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 09c96f57818c..10729d2d6084 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -421,6 +421,8 @@ void cpu_die_early(void)
>  
>  	update_cpu_boot_status(CPU_STUCK_IN_KERNEL);
>  
> +	rcu_report_dead(cpu);

I think this is in the wrong place, see:

https://lore.kernel.org/r/20201106103602.9849-1-will@kernel.org

which seems to fix the problem for me.

Will

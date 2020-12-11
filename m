Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C652D6CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 01:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387702AbgLKAsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 19:48:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:53468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394608AbgLKArT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 19:47:19 -0500
Date:   Thu, 10 Dec 2020 16:46:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607647598;
        bh=zSD6AlytTTCGnjh6kob/TyxvUexBv5DIkhcmJdWVlPk=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Bo5GphLDYM4NpaGDx8HbMpgM+QN3V3kuWMj15JShYWieQvFFbPwXo9sVN94gc1TDx
         c3E+yy17kuhXs6BH4/X1q+NGq1ksx1c2TY/i8hTehHkTbsUSjsfHUQcB/YggDxMYV7
         SM8zQBAdl33vtMs4bQRYRJZ7tXwdJ+Bjn7LRHtrqLM0b5zombOoXnsxvRqrnXVVt9i
         0ifD3pRPmb+6kzYWsOnAgdGyT04m8L3Knxdydv+AEnVvvimrKtIQArDR0ZkF8biJdF
         cpjapVy5mCP8RGEQzK1wFqSge/0aAeNINBQ6quBXZ/s9kgvxznqz6xQkKrEVq4WB4F
         P6gEmF6XVq8Rg==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: NOHZ tick-stop error: Non-RCU local softirq work is pending
Message-ID: <20201211004638.GB2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201118175218.GA16039@paulmck-ThinkPad-P72>
 <20201210145637.GA164661@lothringen>
 <20201210211756.GZ2657@paulmck-ThinkPad-P72>
 <20201211001515.GA580714@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211001515.GA580714@lothringen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 01:15:15AM +0100, Frederic Weisbecker wrote:
> On Thu, Dec 10, 2020 at 01:17:56PM -0800, Paul E. McKenney wrote:
> > And please see attached.  Lots of output, in fact, enough that it
> > was still dumping when the second instance happened.
> 
> Thanks!
> 
> So the issue is that ksoftirqd is parked on CPU down with vectors
> still pending. Either:
> 
> 1) Ksoftirqd has exited because it has too many to process and it has
>    exceeded the time limit, but then it parks, leaving the rest unhandled.
> 
> 2) Ksoftirqd has completed its work but something has raised a softirq
>    after it got parked.
> 
> Can you run the following (on top of the previous patch and boot options)
> so that we see if (and what) it still triggers (in which case we should be in 2)  ).

Thank you!  I have started it up.

> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 09229ad82209..7d558cb7a037 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -650,7 +650,9 @@ static void run_ksoftirqd(unsigned int cpu)
>  		 * We can safely run softirq on inline stack, as we are not deep
>  		 * in the task stack here.
>  		 */
> -		__do_softirq();
> +		do {
> +			__do_softirq();
> +		} while (kthread_should_park() && local_softirq_pending());
>  		local_irq_enable();
>  		cond_resched();
>  		return;

Huh.  I guess that self-propagating timers, RCU callbacks, and the
like are non-problems because they cannot retrigger while interrupts
are disabled?  But can these things reappear just after the
local_irq_enable()?

In the case of RCU, softirq would need to run on this CPU, which it won't,
so we are good in that case.  (Any stranded callbacks will be requeued
onto some other CPU later in the CPU-hotplug offline processing.)

							Thanx, Paul

> Thanks!

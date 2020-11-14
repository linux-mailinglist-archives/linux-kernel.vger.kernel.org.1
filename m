Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8322B2A4A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 02:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgKNBF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 20:05:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgKNBF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 20:05:27 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C84722254;
        Sat, 14 Nov 2020 01:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605315927;
        bh=5BRehqGCIW37q7CJxlrU4tpYj4qTMNmGVk02dDV9BTU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bmYpa0INCekjo+dT1vJVv9Hgo40Fs3kQXVK4wmWmz5r4vh5OHjZnQWKskcdLE1mh/
         Qt3y3upnkHpFYZk+ACP2TxlKrV3WBQfcag4MWb/YqzwjmgqFnmhPxmYI87N3jDExMC
         iis6PlQBKe9IRf9i5xRqygyZRYDBoSh9wO/sgudg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EAAD53522774; Fri, 13 Nov 2020 17:05:26 -0800 (PST)
Date:   Fri, 13 Nov 2020 17:05:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, eupm90@gmail.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: #PF from NMI
Message-ID: <20201114010526.GK3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201113125332.GA2611@hirez.programming.kicks-ass.net>
 <87ima8luix.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ima8luix.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 12:13:58AM +0100, Thomas Gleixner wrote:
> On Fri, Nov 13 2020 at 13:53, Peter Zijlstra wrote:
> > [  139.226724] WARNING: CPU: 9 PID: 2290 at kernel/rcu/tree.c:932 __rcu_irq_enter_check_tick+0x84/0xd0
> > [  139.226753]  irqentry_enter+0x25/0x40
> > [  139.226753]  exc_page_fault+0x38/0x4c0
> > [  139.226753]  asm_exc_page_fault+0x1e/0x30
> 
> ...
> 
> > [  139.226757]  perf_callchain_user+0xf4/0x280
> >
> > Which is a #PF from NMI context, which is perfectly fine. However
> > __rcu_irq_enter_check_tick() is triggering WARN.
> >
> > AFAICT the right thing is to simply remove the warn like so.
> >
> > ---
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 430ba58d8bfe..9bda92d8b914 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -928,8 +928,8 @@ void __rcu_irq_enter_check_tick(void)
> >  {
> >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> >  
> > -	 // Enabling the tick is unsafe in NMI handlers.
> > -	if (WARN_ON_ONCE(in_nmi()))
> > +	// if we're here from NMI, there's nothing to do.
> > +	if (in_nmi())
> >  		return;
> >  
> >  	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
> 
> Yes. That's right.
> 
> To answer Pauls question:
> 
> > But is a corresponding change required on return-from-NMI side?
> > Looks OK to me at first glance, but I could be missing something.
> 
> No. The corresponding issue is not return from NMI. The corresponding
> problem is the return from the page fault handler, but there is nothing
> to worry about. That part is NMI safe already.

In that case:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Or let me know (and get me a Signed-off-by) if you want me to take it.

							Thanx, Paul

> And Luto's as well:
> 
> > with the following caveat that has nothing to do with NMI: the rest of
> > irqentry_enter() has tracing calls in it. Does anything prevent
> > infinite recursion if one of those tracing calls causes a page fault?
> 
> nmi:
>   ...
>   trace_hardirqs_off_finish() {
>     if (!this_cpu_read(tracing_irq_cpu)) {
>            this_cpu_write(tracing_irq_cpu, 1);
>            ...
>   }
>   ...
>   perf()
> 
> #PF
>   save_cr2()
>   
>   irqentry_enter()
>      trace_hardirqs_off_finish()
>         if (!this_cpu_read(tracing_irq_cpu)) {
> 
> So yes, it is recursion protected unless I'm missing something.
> 
> Thanks,
> 
>         tglx

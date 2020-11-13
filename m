Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0CE2B2902
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 00:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgKMXOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 18:14:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55774 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgKMXOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 18:14:01 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605309238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iKqXe5KVWLjxj8EzAXXfk8w19Y/zv4hRF8h7LIql2gA=;
        b=ulloTv1hjaB0C6l8FshKcHV1PhPoCB0QJSok4CKpArlOhf5mdXhXtIPdzGEU3PF47TfvYO
        rGG+tblEvNBIIV07VZvO4aApo+vlnTqXQ4sVCKNUhJbqlTqKxSxpYM7x7ArIeHwaoBoumH
        fNA2xaitU8lu+fj+OMY3tnU22yphKxxyrr+ogBcqpuBE19A9NFBh8Fj7rXGgq9Vx6YwXa5
        zUevTm6eoMSFdkudzxXDTAv2LqOODtKkvVZwXW6vcEgNCU3Cie+43uUCYUsH4idFBvDx+J
        uykwT6QQW3bWjbKfwR5uInkO3ZuR0GiGy5QrlGnvTZgHvpBnJO329uyQL210xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605309238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iKqXe5KVWLjxj8EzAXXfk8w19Y/zv4hRF8h7LIql2gA=;
        b=Rw3wraymAzXyjT3f/ziMqeC8C4hACzYRehAtvbcsmQ48UJzn20excfSyV+trPqS3dnyi5T
        wQq7yVfvpR1bcuAA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>, eupm90@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: #PF from NMI
In-Reply-To: <20201113125332.GA2611@hirez.programming.kicks-ass.net>
References: <20201113125332.GA2611@hirez.programming.kicks-ass.net>
Date:   Sat, 14 Nov 2020 00:13:58 +0100
Message-ID: <87ima8luix.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13 2020 at 13:53, Peter Zijlstra wrote:
> [  139.226724] WARNING: CPU: 9 PID: 2290 at kernel/rcu/tree.c:932 __rcu_irq_enter_check_tick+0x84/0xd0
> [  139.226753]  irqentry_enter+0x25/0x40
> [  139.226753]  exc_page_fault+0x38/0x4c0
> [  139.226753]  asm_exc_page_fault+0x1e/0x30

...

> [  139.226757]  perf_callchain_user+0xf4/0x280
>
> Which is a #PF from NMI context, which is perfectly fine. However
> __rcu_irq_enter_check_tick() is triggering WARN.
>
> AFAICT the right thing is to simply remove the warn like so.
>
> ---
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 430ba58d8bfe..9bda92d8b914 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -928,8 +928,8 @@ void __rcu_irq_enter_check_tick(void)
>  {
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  
> -	 // Enabling the tick is unsafe in NMI handlers.
> -	if (WARN_ON_ONCE(in_nmi()))
> +	// if we're here from NMI, there's nothing to do.
> +	if (in_nmi())
>  		return;
>  
>  	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),

Yes. That's right.

To answer Pauls question:

> But is a corresponding change required on return-from-NMI side?
> Looks OK to me at first glance, but I could be missing something.

No. The corresponding issue is not return from NMI. The corresponding
problem is the return from the page fault handler, but there is nothing
to worry about. That part is NMI safe already.

And Luto's as well:

> with the following caveat that has nothing to do with NMI: the rest of
> irqentry_enter() has tracing calls in it. Does anything prevent
> infinite recursion if one of those tracing calls causes a page fault?

nmi:
  ...
  trace_hardirqs_off_finish() {
    if (!this_cpu_read(tracing_irq_cpu)) {
           this_cpu_write(tracing_irq_cpu, 1);
           ...
  }
  ...
  perf()

#PF
  save_cr2()
  
  irqentry_enter()
     trace_hardirqs_off_finish()
        if (!this_cpu_read(tracing_irq_cpu)) {

So yes, it is recursion protected unless I'm missing something.

Thanks,

        tglx

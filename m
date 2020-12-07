Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840092D0ED5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgLGLSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:18:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:59696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgLGLSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:18:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607339857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zYgXVMguU9IGzh55RdgeN4vcKUk8bf3s7Y3chc005ks=;
        b=obbY5TMMBYDA7vyDL3isR7wXHhCSrlsinIEbwqN+kcKamBojxnOu/m2BogAelVlBbqAl73
        sglZpJBq4VNYQdKWM0MqCe5x3ph3o5q2QDmgKe/E2EuHt+7i4QpwP1JT3/cpwd/qi2KaZK
        YGhuZr/oV2rImPQ/m2UFgj7GNNjKIs4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DABF8AC90;
        Mon,  7 Dec 2020 11:17:36 +0000 (UTC)
Date:   Mon, 7 Dec 2020 12:17:36 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: recursion handling: Re: [PATCH next v2 3/3] printk: remove
 logbuf_lock, add syslog_lock
Message-ID: <X84PUEXF8dwuMCRM@alley>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-4-john.ogness@linutronix.de>
 <X8pfX/qPBuY360k/@alley>
 <87sg8imwx5.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sg8imwx5.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2020-12-06 22:50:54, John Ogness wrote:
> On 2020-12-04, Petr Mladek <pmladek@suse.com> wrote:
> > On Tue 2020-12-01 21:59:41, John Ogness wrote:
> >> Since the ringbuffer is lockless, there is no need for it to be
> >> protected by @logbuf_lock. Remove @logbuf_lock.
> >> 
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> > What is the exact reason to disable interrupts around the entire
> > vprintk_store(), please? It should get documented.
> 
> It simplifies the context tracking. Also, in mainline interrupts are
> already disabled for all of vprintk_store(). AFAIK latencies due to
> logbuf_lock contention were not an issue.
> 
> I really don't want to touch task_struct. IMHO the usefulness of that
> struct is limited, considering that printk can be called from scheduling
> and interrupting contexts.

Fair enough. I am fine with the per-CPU variables and the disabled
interrupts around vprintk_store().

Note: We should also prevent calling console_trylock() for recursive
messages to avoid infinite loop or even deadlock in this part of the code.

> >> +
> >> +struct printk_recursion {
> >> +	char	count[NUM_RECURSION_CTX];
> >> +};
> >>
> >> +static DEFINE_PER_CPU(struct printk_recursion, percpu_printk_recursion);
> >> +static char printk_recursion_count[NUM_RECURSION_CTX];
> >
> > This is pretty confusing. The array is hidden in a struct when per-cpu
> > variables are used. And a naked array is used for early boot.
> >
> > Is the structure really needed? What about?
> >
> > static DEFINE_PER_CPU(char [PRINTK_CTX_NUM], printk_count);
> > static char printk_count_early[NUM_RECURSION_CTX];
> 
> OK.
> 
> >> +
> >> +static char *get_printk_count(void)
> >> +{
> >> +	struct printk_recursion *rec;
> >> +	char *count;
> >> +
> >> +	if (!printk_percpu_data_ready()) {
> >> +		count = &printk_recursion_count[0];
> >
> > I see why you avoided per-cpu variables for early boot. I am just
> > curious how printk_context variable works these days. It is used by
> > any printk(), including early code, see vprintk_func().
> 
> IMO printk_context is serving a different purpose. With the existance of
> logbuf_lock, printk_context exists for the sole purpose of making sure
> logbuf_lock is not taken recursively or that the CPU does not spin on it
> in NMI context. printk_context is simply gating calls to the safe
> buffers.

Well, both printk_count and printk_context are able to count recursion
in different context. They both are used to decide how printk() will
behave...

Anyway, it is not necessary to fight over words. You write below that
the plan is to remove printk_safe, including printk_context. It will
solve my problem.

I am fine with having both of them for some transition period. I guess
that it will make our life easier, from the coding and review point
of view.

> >> +static bool printk_enter(unsigned long *flags)
> >> +{
> >> +	char *count;
> >> +
> >> +	local_irq_save(*flags);
> >> +	count = get_printk_count();
> >> +	/* Only 1 level of recursion allowed. */
> >
> > We should allow at least some level of recursion. Otherwise, we would
> > not see warnings printed from vsprintf code.
> 
> With 1 level, you will see warnings from vsprintf code. I'm not sure it
> makes sense to allow more than 1 level. It causes exponential logging.

Shame on me. I have missed that 1 level was actually enabled.

Anyway, I would like to allow 2 level recursion at least. However, for
example, 5 level recursion, would be even better.

We need to know when there is problem to store the recursive/nested
message. And I would rather see the same message repeated 3 times than
to do not see it at all.

Note that the risk of infinite recursion is pretty low. We have most of
the code called from vprintk_emit() under control. There are many
pr_once() or WARN_ONCE(). The error messages have rather simple
and commonly used formatting, so the risk of recursive errors in
vsprintf() code is low.

> > Or is there any plan to remove printk_safe and printk_context?

I am feeling relief to read this.

Do not take me wrong. printk_safe() was really great idea and served
well its purpose. But it is yet another tricky lockless code. There
is another complexity with flushing the temporary buffers and handling
panic(). It is nice that we could remove some of this complexity.

Best Regards,
Petr

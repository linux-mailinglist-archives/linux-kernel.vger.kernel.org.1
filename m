Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1CC294EBE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 16:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443573AbgJUOeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 10:34:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443566AbgJUOeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 10:34:36 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6171422249;
        Wed, 21 Oct 2020 14:34:35 +0000 (UTC)
Date:   Wed, 21 Oct 2020 10:34:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     syzbot <syzbot+53f8ce8bbc07924b6417@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: using __this_cpu_read() in preemptible code in
 trace_hardirqs_on
Message-ID: <20201021103433.38fed220@gandalf.local.home>
In-Reply-To: <20201021131733.GH2628@hirez.programming.kicks-ass.net>
References: <000000000000e921b305b18ba0a7@google.com>
        <20201013091743.12c371a8@gandalf.local.home>
        <20201021131733.GH2628@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Oct 2020 15:17:33 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > And I'm also guessing that we can call this with interrupts enabled (based
> > on the comment).
> > 
> > And we have this:
> > 
> >    local_irq_enable()
> >       trace_hardirqs_on()
> >          lockdep_hardirqs_on()
> >              __this_cpu_read()  
> 
> Moo, two threads..
> 
> 20201019183355.GS2611@hirez.programming.kicks-ass.net

But this one's much older ;-)

> 
> ---
> 
> On Tue, Oct 20, 2020 at 12:55:46AM +0800, kernel test robot wrote:
> > [   92.898145] BUG: using __this_cpu_read() in preemptible [00000000] code: trinity-c6/526  
> 
> > [   92.903305] Call Trace:
> > [   92.905182]  __this_cpu_preempt_check+0xf/0x11
> > [   92.905968]  lockdep_hardirqs_on_prepare+0x2c/0x18f
> > [   92.906853]  trace_hardirqs_on+0x49/0x53
> > [   92.907578]  __bad_area_nosemaphore+0x3a/0x134  
> 
> Hurph, that's a spurious local_irq_enable(). I suppose this'll fix it.
> 
> ---
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 3e99dfef8408..9f818145ef7d 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -4057,9 +4057,6 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
>  	if (unlikely(in_nmi()))
>  		return;
>  
> -	if (unlikely(__this_cpu_read(lockdep_recursion)))
> -		return;
> -
>  	if (unlikely(lockdep_hardirqs_enabled())) {

Hmm, would moving the recursion check below the check of the
lockdep_hardirqs_enable() cause a large skew in the spurious enable stats?
May not be an issue, but something we should check to make sure that
there's not a path that constantly hits this.

-- Steve

>  		/*
>  		 * Neither irq nor preemption are disabled here
> @@ -4070,6 +4067,9 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
>  		return;
>  	}
>  
> +	if (unlikely(__this_cpu_read(lockdep_recursion)))
> +		return;
> +

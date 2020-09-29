Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3415E27D10B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgI2O1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:27:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:41766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727543AbgI2O1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:27:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601389672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cmghqqosv6TC+EEk46m5qn+kgDZqcMz3XHHlxEb5k7E=;
        b=WswOj2YCAeSn4D+OcezhC8ARfAUfxI+Jifu5PcvKgjgcyorjPIkOcdFs5ZYUTpo7B4g4UN
        +aO7xj1VuQ6CUpzcf1RVFOv5PBxkACN2awTasaa+AYhJ+TLwC0onzmCyYg0w+Q61TpHWST
        r87iUgH+gZmdW9Jb/CvRMqSFfjPVxQY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 38ED2B03D;
        Tue, 29 Sep 2020 14:27:52 +0000 (UTC)
Date:   Tue, 29 Sep 2020 16:27:51 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, songmuchun@bytedance.com,
        john.ogness@linutronix.de
Subject: Re: [External] Re: [PATCH 2/2] sched: mark
 PRINTK_DEFERRED_CONTEXT_MASK in __schedule()
Message-ID: <20200929142750.GT6442@alley>
References: <20200927161130.33172-1-zhouchengming@bytedance.com>
 <20200927161130.33172-2-zhouchengming@bytedance.com>
 <20200928073202.GA2611@hirez.programming.kicks-ass.net>
 <40ab934e-5b8b-735b-da65-3043efab9fdc@bytedance.com>
 <20200928090143.GA2628@hirez.programming.kicks-ass.net>
 <688eadd7-4ca3-3e32-3520-25977ff059a6@bytedance.com>
 <20200928102559.GF2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200928102559.GF2611@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-09-28 12:25:59, Peter Zijlstra wrote:
> On Mon, Sep 28, 2020 at 06:04:23PM +0800, Chengming Zhou wrote:
> 
> > Well, you are lucky. So it's a problem in our printk implementation.
> 
> Not lucky; I just kicked it in the groin really hard:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git debug/experimental
> 
> > The deadlock path is:
> > 
> > printk
> >   vprintk_emit
> >     console_unlock
> >       vt_console_print
> >         hide_cursor
> >           bit_cursor
> >             soft_cursor
> >               queue_work_on
> >                 __queue_work
> >                   try_to_wake_up
> >                     _raw_spin_lock
> >                       native_queued_spin_lock_slowpath
> > 
> > Looks like it's introduced by this commit:
> > 
> > eaa434defaca1781fb2932c685289b610aeb8b4b
> > 
> > "drm/fb-helper: Add fb_deferred_io support"
> 
> Oh gawd, yeah, all the !serial consoles are utter batshit.
> 
> Please look at John's last printk rewrite, IIRC it farms all that off to
> a kernel thread instead of doing it from the printk() caller's context.
> 
> I'm not sure where he hides his latests patches, but I'm sure he'll be
> more than happy to tell you.

AFAIK, John is just working on updating the patchset so that it will
be based on the lockless ringbuffer that is finally in the queue
for-5.10.

Upstreaming the console handling will be the next big step. I am sure
that there will be long discussion about it. But there might be
few things that would help removing printk_deferred().

1. Messages will be printed on consoles by dedicated kthreads. It will
   be safe context. No deadlocks.

2. The registration and unregistration of consoles should not longer
   be handled by console_lock (semaphore). It should be possible to
   call most consoles without a sleeping lock. It should remove all
   these deadlocks between printk() and scheduler().

   There might be problems with some consoles. For example, tty would
   most likely still need a sleeping lock because it is using the console
   semaphore also internally.


3. We will try harder to get the messages out immediately during
   panic().


It would take some time until the above reaches upstream. But it seems
to be the right way to go.


About printk_deferred():

It is a whack a mole game. It is easy to miss printk() that might
eventually cause the deadlock.

printk deferred context is more safe. But it is still a what a mole
game. The kthreads will do the same job for sure.

Finally, the deadlock happens "only" when someone is waiting on
console_lock() in parallel. Otherwise, the waitqueue for the semaphore
is empty and scheduler is not called.

It means that there is quite a big change to see the WARN(). It might
be even bigger than with printk_deferred() because WARN() in scheduler
means that the scheduler is big troubles. Nobody guarantees that
the deferred messages will get handled later.

Best Regards,
Petr

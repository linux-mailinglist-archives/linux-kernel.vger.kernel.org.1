Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675AA2B9FC8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 02:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgKTBeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 20:34:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37300 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbgKTBeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 20:34:01 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605836039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7uVXnrJ9FAHgnGZVOERteDJIBOwguyPNBYIyccpfRao=;
        b=NAMeNEtibzZCn6hDuW13u0nNgnZbAGdYUadbXSfXJ0ejcSxinYzIKbQY/P1IpwrIxSolDO
        rb4gtDfC8Nx3wegNgQB5xyMdEvSkspebzNdd97Le/YpAHCp0SWi8dabyZF4rAF7ZZ0NjMz
        d2rJavDGJXKOvkXAKlnCXcWNr7X/30XYlMoTrOke4uXSm4H44kZUnxyq4/hWt9TFMSMhds
        I2RF7TdU2VsWyuKaVpcRuiC+qkMFKVYJ7I6jfokGa5zhPRDBHRHw3JyFrme4C9toAt9cg3
        qO8V23fljRGzJxr3gtn1NzOwABh2wV9nk6e0J+8D5/lpGH4JIW/L1poK/YdalA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605836039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7uVXnrJ9FAHgnGZVOERteDJIBOwguyPNBYIyccpfRao=;
        b=GqiCV9WE4RMEEngiPAHJwiWdyRGOC53LmO3t4JbfwinMQGX7dhTJffqL6hU3+HseoFu0jo
        ooj9V8+xI59X2HCQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mel Gorman <mgorman@suse.de>, LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch V4 4/8] sched: Make migrate_disable/enable() independent of RT
In-Reply-To: <20201119182843.GA2414@hirez.programming.kicks-ass.net>
References: <20201118194838.753436396@linutronix.de> <20201118204007.269943012@linutronix.de> <20201119093834.GH3306@suse.de> <20201119111411.GL3121378@hirez.programming.kicks-ass.net> <CAHk-=wire3dzhHx=KiL_f5Rj0=1u9ustsa33QoR-F9-v-NU9Ng@mail.gmail.com> <20201119182843.GA2414@hirez.programming.kicks-ass.net>
Date:   Fri, 20 Nov 2020 02:33:58 +0100
Message-ID: <87tutkolq1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19 2020 at 19:28, Peter Zijlstra wrote:
> On Thu, Nov 19, 2020 at 09:23:47AM -0800, Linus Torvalds wrote:
>> Because this is certainly not the only time migration limiting has
>> come up, and no, it has absolutely nothing to do with per-cpu page
>> tables being completely unacceptable.
>
> It is for this instance; but sure, it's come up before in other
> contexts.

Indeed. And one of the really bad outcomes of this is that people are
forced to use preempt_disable() to prevent migration which entails a
slew of consequences:

     - Using spinlocks where it wouldn't be needed otherwise
     - Spinwaiting instead of sleeping
     - The whole crazyness of doing copy_to/from_user_in_atomic() along
       with the necessary out of line error handling.
     - ....

The introduction of per-cpu storage happened almost 20 years ago (2002)
and still the only answer we have is preempt_disable().

I know the scheduling theory folks still try to wrap their heads around
the introduction of SMP which dates back to 1962 IIRC...

>> The scheduler people need to get used to this. Really. Because ASMP is
>> just going to be a fact.
>
> ASMP is different in that it is a hardware constraint, you're just not
> going to be able to run more of X than there's X capable hardware units
> on (be if FPUs, Vector units, 32bit or whatever)

ASMP is as old as SMP. The first SMP systems were in fact ASMP.  The
reasons for ASMP 60 years ago were not that different from the reasons
for ASMP today. Just the scale and the effectivness are different.

>> There are few things more futile than railing against reality, Peter.
>
> But, but, my windmills! :-)

At least you have windmills where you live so you can pull off the real
Don Quixote while other people have to find substitutes :)

Thanks,

        tglx

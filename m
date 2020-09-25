Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55292784EE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 12:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgIYKUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 06:20:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:44556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgIYKUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 06:20:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601029249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2iHiA02kRF2jByQlmf9+sx+BoO5AFDD2KF6kzRLN874=;
        b=iFeurb0w4RCQsf1DQAezYpjuyguBfQqyTsFdhu1bF0Wz+/egLbx+G47ZGlVsU7tX2Kn5o9
        Vyl5HEQWuN2fh+7oRCw+cKHchpMFTu1AAW5csZ3q76yLlb39eU7lRqp/E0moPcbEJpbkel
        mXC+WW2T1Q14zNqjcMa1CQ5GmkGrBmI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E4BB4ACBA;
        Fri, 25 Sep 2020 10:20:48 +0000 (UTC)
Date:   Fri, 25 Sep 2020 12:20:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prarit Bhargava <prarit@redhat.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Changki Kim <changki.kim@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] printk: Add more information about the printk caller
Message-ID: <20200925102047.GO29288@alley>
References: <20200923135617.27149-1-pmladek@suse.com>
 <20200923135617.27149-3-pmladek@suse.com>
 <20200924042414.GA6039@lx-t490>
 <20200924125259.GC29288@alley>
 <20200924133850.GF29288@alley>
 <20200925005400.GD541@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925005400.GD541@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-09-25 09:54:00, Sergey Senozhatsky wrote:
> On (20/09/24 15:38), Petr Mladek wrote:
> [..]
> >
> > Grrrr, I wonder why I thought that in_irq() covered also the situation
> > when IRQ was disabled. It was likely my wish because disabled
> > interrupts are problem for printk() because the console might
> > cause a softlockup.
> 
> preempt_disable() can also trigger softlockup.
> 
> > in_irq() actually behaves like in_serving_softirq().
> >
> > I am confused and puzzled now. I wonder what contexts are actually
> > interesting for developers.  It goes back to the ideas from Sergey
> > about preemption disabled, ...
> 
> Are we talking about context tracking for LOG_CONT or context on
> the serial console and /dev/kmsg?

OK, it is clear that LOG_CONT need to know when a different code
is called suddenly. I mean task code vs. an interrupt handler.

But it was actually also the original purpose of the caller_id.
AFAIK, people wanted to sort related messages when they were mixed
with ones from other CPUs.


> If the latter, then my 5 cents, is that something like preemptible(),
> which checks
> 
> 	(preempt_count() == 0 && !irqs_disabled())
> 
> does not look completely unreasonable.
> 
> We had a rather OK context tracking in printk() before, but for a
> completely different purpose:
> 
>        console_may_schedule = !oops_in_progress &&
>                        preemptible() &&
>                        !rcu_preempt_depth();
> 
> We know that printk() can cause RCU stalls [0]. Tracking this part
> of the context state is sort of meaningful.
> 
> Let's look at this from this POV - why do we add in_irq()/etc tracking
> info? Perhaps because we want to connect the dots between printk() caller
> state and watchdog reports. Do we cover all watchdogs? No, I don't think
> so. RCU stalls, local_irq_disable(), preempt_disable() are not covered.

I agree that it would be handy to see this context as well. It might
make it easier when hunting down various lockups and stall. But
I have some concerns.

First, the information is not always reliable (PREEMPT_NONE). I wonder
if it might cause more harm than good. People might get confused
or they might want to fix it by some crazy printk code.

Second, the information might not be detailed enough. Many lockups
depends on the fact that a particular lock is held. Backtraces
are likely more important. Or people would need to distinguish
many contexts. It would require another complex code.


I am not sure that this is woth it. After all, it might be enough
to distinguish the 4 basic contexts just to allow sorting mixed
messages.

Best Regards,
Petr

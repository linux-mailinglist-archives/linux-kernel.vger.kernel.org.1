Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3100728323A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgJEIig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:38:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:50392 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbgJEIic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:38:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601887110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5xo6Xa1W7ONWSL2XGLeIExaC4CCmZ5F3gMyPo8v1BHo=;
        b=Luk9DWsf1G+5BOsvllVIrtazh36xpVqdIyI6HG/fEaUO2Jb3w4E6F2AyIzyqjfcbzYn6pT
        udqLfkeWncMlu4wdqM4wbfCJd0UD6AtQgQTFDPYuMc8SWPAy6H7eZVHisG/9xf56MxzPUi
        LoH7hnWmtNwp29As8JGDtRqkZamvEwg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D2815AF34;
        Mon,  5 Oct 2020 08:38:30 +0000 (UTC)
Date:   Mon, 5 Oct 2020 10:38:29 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        tj@kernel.org, akpm@linux-foundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Zqiang <qiang.zhang@windriver.com>
Subject: Re: [RFC PATCH] kthread: do not modify running work
Message-ID: <20201005083829.GA3673@alley>
References: <20200926040426.11936-1-hdanton@sina.com>
 <20201001095151.5640-1-hdanton@sina.com>
 <20201002023412.2276-1-hdanton@sina.com>
 <20201004021213.14572-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201004021213.14572-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2020-10-04 10:12:13, Hillf Danton wrote:
> 
> On Fri, 02 Oct 2020 10:32:32 Thomas Gleixner wrote:
> > On Fri, Oct 02 2020 at 10:34, Hillf Danton wrote:
> > > On Thu, 01 Oct 2020 15:59:38 +0200 Thomas Gleixner wrote:
> > >> On Thu, Oct 01 2020 at 17:51, Hillf Danton wrote:
> > >> Aside of that it's pretty irrelevant whether there is a user at the
> > >> moment which reschedules work from the callback or not.
> > >> 
> > >> It's something which needs to work because its possible from regular
> > >> work queues as well and makes a lot of sense.
> > >
> > > https://lore.kernel.org/lkml/87eemheay8.fsf@nanos.tec.linutronix.de/
> > 
> > That's a completely different thing, really. This adds new functionality
> > without users and exports it.
> > 
> > kthread work is modeled after workqueue to address specific
> > needs.

Exactly.

> > delayed work can be rescheduled from the callback and all
> > variants of timers support rearming the timer from the callback as well.

This might be a bit confusing here. The timer callback just moves
the work to the list of works that are going to be proceed by the
kthread. It neither runs the work nor rearms the timer.

But the timer can be set again by any parallel
kthread_queue_delayed_work() or kthread_mod_delayed_work() call
even the the timer callback is still running. Module that some code
is serialized by the lock.


> What is the difference of invoking kthread_queue_delayed_work() from the
> callback from kthread_mod_delayed_work()?

kthread_queue_delayed_work() does nothing when the work is already
queued. kthread_mod_delayed_work() removes the work from the queue
if it is there and queue it again with the newly requested delay.


> > So having a consistent behaviour accross all these facilities makes
> > absolutely sense and I don't agree with your sentiment in the changelog
> > at all.
> > 
> > Just because it does not make sense to you is not a justification for
> > making stuff inconsistent. You still have not provided a technical
> > reason why this change is needed.
> 
> Given the queue method, it is no win to modify delayed work from callback
> in any case because "we are not adding interfaces just because we can."

What about ipmi_kthread_worker_func()? It is delayed work that
queues itself.


> Nor does it help much in regard of a running work that is delayed two
> minutes because for instance it is not clear that it is a one-off work
> with resources released in the callback.

This is up to the other API user to use the API the right way.

As it has already been mentioned, kthread_worker() API should behave
the same as work_queue API. It is needed for kthreads that have special
needs, for example, real time priority. It should be easy to migrate
between the two APIs. Different behavior would be just a call for
problems.

The dream is that all custom kthreads are converted into either
the classic work_queues or kthread_worker API. People are really
creative when doing the main loop and it is easy to do it wrong.
It causes then problems, for example, with suspend/resume,
livepatching.

What is the motivation for this patch, please?
Does it solve some real problem?

Best Regards,
Petr

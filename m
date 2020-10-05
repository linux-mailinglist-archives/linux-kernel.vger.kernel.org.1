Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D332835BF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgJEMU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:20:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:48456 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgJEMU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:20:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601900457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JHLYvBq08Dp/5b5Rah0VPUXLe/Yja1yVhx2g0QpEwYw=;
        b=qG8L3zmUKXWbYbuY10SJtxMq0LOa5H2EQmlHvd/pR8kTjSF/TddFICAHXufkjCiklChQFl
        /OX/1S616yMFJUCHumNO0HIDqI+3DYSfaE1Bv20le2c58gd1e3uWXITk2nXNFFOtTVel/B
        g1/M1ArmXIR6+EkE/SgpzyNFBo2DbTI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07D9FAC26;
        Mon,  5 Oct 2020 12:20:57 +0000 (UTC)
Date:   Mon, 5 Oct 2020 14:20:56 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        tj@kernel.org, akpm@linux-foundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Zqiang <qiang.zhang@windriver.com>
Subject: Re: [RFC PATCH] kthread: do not modify running work
Message-ID: <20201005122056.GE3673@alley>
References: <20200926040426.11936-1-hdanton@sina.com>
 <20201001095151.5640-1-hdanton@sina.com>
 <20201002023412.2276-1-hdanton@sina.com>
 <20201004021213.14572-1-hdanton@sina.com>
 <20201005102105.18272-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005102105.18272-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-10-05 18:21:05, Hillf Danton wrote:
> On Mon, 5 Oct 2020 10:38:29 Petr Mladek wrote:
> > On Sun 2020-10-04 10:12:13, Hillf Danton wrote:
> > > What is the difference of invoking kthread_queue_delayed_work() from the
> > > callback from kthread_mod_delayed_work()?
> > 
> > kthread_queue_delayed_work() does nothing when the work is already
> > queued. kthread_mod_delayed_work() removes the work from the queue
> > if it is there and queue it again with the newly requested delay.
> 
> Can you let us know the reasons why we need to remove the work from
> queue in callback?

Each work could get queued only once at the same time. It can be either
in work_list or in delayed_work_list. But it must never be in both at
the same time.

Canceling the work solves race with the timer callback. We must be
sure that is not running in parallel and will not try to shuffle
the worker lists.

Note that there is a difference between queued work and running work.
Queued work is either in worker->work_list or in
worker->delayed_work_list. While worker->current_work points
to the currently running work.

Now, the work can be running and queued at the same time be design.
It is quite common usecase.

> > > Given the queue method, it is no win to modify delayed work from callback
> > > in any case because "we are not adding interfaces just because we can."
> > 
> > What about ipmi_kthread_worker_func()? It is delayed work that
> > queues itself.
> 
> Can you shed some light on where I can find ipmi_kthread_worker_func()
> in the mainline?

Ah, the right name is mv88e6xxx_irq_poll().

> > What is the motivation for this patch, please?
> 
> See the subject line.
> 
> > Does it solve some real problem?
> 
> Once more
> 1) avoid running a delayed work more than once if it is one-ff.
>
> 2) cut the risk of modifying a running one-off delayed work with
> resources released in the callback.

Do you have any real bug where this happen, please?

The API works this way be design. It makes it generic and usable
for different use-cases. It is up to the caller to use it the correct
way:

   + queue the work only once when the work should be done only once
   + make sure that the work is not queued when the service is being
     stopped

Note that it is not only about queuing the work from its own
callback. It is also about races between queuing and running.

There is no guarantee when the work will be running. It happens
when the worker thread gets scheduled and the work is the first
on the list. It is up to the API user to make sure that the work
will get queued when needed and vice versa.

It is possible that some other behavior might be more practical
in some scenarios but it would complicate situation in others.


If you need more details, please google the discussion when the API was
developed.

Best Regards,
Petr

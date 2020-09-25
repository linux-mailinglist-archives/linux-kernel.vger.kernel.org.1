Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588B927899B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 15:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgIYNdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 09:33:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:55516 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbgIYNdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:33:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601039773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I1F+lzoce7AIvICwwgz2l3R+TRcauc4ERd9VgGGJYqo=;
        b=QrzYMwtM+pV2zQIKRnYJlgClgKlHAAd8IpZWYMfCfxti3UFIovl3G+OlE0SHFy/hdnP3UM
        Eh9VDtjLn0n+YyJxTh1TFXiN7fmaySeB56e/PPByDSF8w4YMzH7a7eNBhnH9b84K6qwabA
        HbVBJcDikG6hXjvR0KmASyWd1FCYRe0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A3535AC61;
        Fri, 25 Sep 2020 13:16:13 +0000 (UTC)
Date:   Fri, 25 Sep 2020 15:16:11 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     qiang.zhang@windriver.com, tj@kernel.org,
        akpm@linux-foundation.org, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel/kthread.c: kthread_worker: add work status
 check in timer_fn
Message-ID: <20200925131610.GP29288@alley>
References: <20200925050759.20805-1-qiang.zhang@windriver.com>
 <20200925123821.18556-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925123821.18556-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-09-25 20:38:21, Hillf Danton wrote:
> 
> On Fri, 25 Sep 2020 11:30:46 +0200 Petr Mladek wrote:
> > 
> > On Fri 2020-09-25 13:07:59, qiang.zhang@windriver.com wrote:
> > > From: Zqiang <qiang.zhang@windriver.com>
> > > 
> > > When queue delayed work to worker, at some point after that the timer_fn
> > > will be call, add work to worker's work_list, at this time, the work may
> > > be cancel, so add "work->canceling" check current work status.
> > 
> > Great catch!
> > 
> > I was able to understand the problem from the description. Though I
> > would still try to improve it a bit. I suggest:
> > 
> > <new_text>
> > Subject: kthread_worker: Prevent queuing delayed work from timer_fn when it is being canceled
> > 
> > There is a small race window when a delayed work is being canceled and
> > the work still might be queued from the timer_fn:
> > 
> > CPU0					CPU1
> > 
> > kthread_cancel_delayed_work_sync()
> >   __kthread_cancel_work_sync()
> >     __kthread_cancel_work()
> > 	work->canceling++;
> > 
> > 					kthread_delayed_work_timer_fn()
> > 					  kthread_insert_work();
> > 
> > BUG: kthread_insert_work() should not get called when work->canceling
> > is set.
> 
> Seems like the diagram above can't cover the case that the timer fired
> and started acquiring the lock half a tick before here came the cancel
> that took the lock then set the canceling mark.
> Nor is it a bug given that cancel is always flushing the current work.

This is the same as:

CPU0					CPU1

					kthread_delayed_work_timer_fn()
					  kthread_insert_work();

kthread_cancel_delayed_work_sync()


It just shows that kthread_cancel_delayed_work_sync() can't stop work
that is already being proceed. In this case, it has to wait until it
finishes.

By other words, this patch can't fix any real problem with timing.
kthread_cancel_delayed_work_sync() only guarantees that the work
in neither queued nor running when it finishes.


But I still think that the patch makes sense. work->lock synchronizes
manipulation of the work state. And it is wrong to queue the work
when canceling flag is set.

By other words. The bug was harmless. But it still was a bug.

Best Regards,
Petr

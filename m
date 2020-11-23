Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD9F2C0A34
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388869AbgKWNRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 08:17:35 -0500
Received: from lgeamrelo13.lge.com ([156.147.23.53]:38160 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387542AbgKWNRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 08:17:30 -0500
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.53 with ESMTP; 23 Nov 2020 22:17:27 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.121 with ESMTP; 23 Nov 2020 22:17:27 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Mon, 23 Nov 2020 22:15:53 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, torvalds@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        alexander.levin@microsoft.com, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        david@fromorbit.com, amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com
Subject: Re: [RFC] Are you good with Lockdep?
Message-ID: <20201123131553.GA21320@X58A-UD3R>
References: <20201111050559.GA24438@X58A-UD3R>
 <20201111105441.GA78848@gmail.com>
 <20201111093609.1bd2b637@gandalf.local.home>
 <87d00jo55p.fsf@nanos.tec.linutronix.de>
 <20201112081030.GB14554@X58A-UD3R>
 <20201112092612.00a19239@gandalf.local.home>
 <20201112145251.GB17076@casper.infradead.org>
 <20201116085757.GB26078@X58A-UD3R>
 <20201116153729.GC29991@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116153729.GC29991@casper.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 03:37:29PM +0000, Matthew Wilcox wrote:
> > > Something I believe lockdep is missing is a way to annotate "This lock
> > > will be released by a softirq".  If we had lockdep for lock_page(), this
> > > would be a great case to show off.  The filesystem locks the page, then
> > > submits it to a device driver.  On completion, the filesystem's bio
> > > completion handler will be called in softirq context and unlock the page.
> > > 
> > > So if the filesystem has another lock which is acquired by the completion
> > > handler. we could get an ABBA deadlock that lockdep would be unable to see.
> > > 
> > > There are other similar things; if you look at the remaining semaphore
> > > users in the kernel, you'll see the general pattern is that they're
> > > acquired in process context and then released in interrupt context.
> > > If we had a way to transfer ownership of the semaphore to a generic
> > > "interrupt context", they could become mutexes and lockdep could check
> > > that nothing else will cause a deadlock.
> > 
> > Yes. Those are exactly what Cross-release feature solves. Those problems
> > can be achieved with Cross-release. But even with Cross-release, we
> > still cannot solve the problem of (1) readlock handling (2) and false
> > positives preventing further reporting.
> 
> It's not just about lockdep for semaphores.  Mutexes will spin if the
> current owner is still running, so to convert an interrupt-released
> semaphore to a mutex, we need a way to mark the mutex as being released
> by the new owner.
> 
> I really don't think you want to report subsequent lockdep splats.

Don't you think it would be ok if the # of splats is not too many?

Or is it still a problem even if not?

We shouldn't do that if it clearly makes a big problem. Otherwise, it
should be because any deadlock detection tool cannot be enhanced to be
stonger which inevitably produces false positives until proper keys are
assigned to all classes in the kernel, unless multiple reports are
allowed.

Could you explain why? It would be appreciated.

Thanks,
Byungchul

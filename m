Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8249D2B498D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbgKPPhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730415AbgKPPht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:37:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E094C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 07:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZvJKDfOtqFnHfu8dG1Qx2vAP9wnn1FoMYrFjYwCAmxY=; b=jT8VyzPPTRzr4VD2Qzzzsx262p
        YdZtMp7j6mrObT0JnAnIjbPSQMh5PIoh3wDtYudi3l8roCVLpO9s+y8XXwZ1SJ+ghsdynMv85XZpD
        R8bWESd6RhTIo6ACf6qIawQVMrm57kCjqS165rQy3CjPqsk+RgapdhVZIE6YXBC1pIdGHAjhYQQ3b
        xeEXrqjt4WJQw2iMEIfttIUqHBa6yoCjsTuZeRFWE//PG9HfeVuAScl48+4ZtktlUkvYBc+GCZEAq
        Ci9eub6KQ5hxf0KZN+OEVxG6Z3zbQCuNfN8bPPKqQN8+3jo8GR84fVxuD+XBJc7hIEsIUYwXzL5tp
        cJnHMvfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kegZN-0000iW-CT; Mon, 16 Nov 2020 15:37:29 +0000
Date:   Mon, 16 Nov 2020 15:37:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Byungchul Park <byungchul.park@lge.com>
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
Message-ID: <20201116153729.GC29991@casper.infradead.org>
References: <20201111050559.GA24438@X58A-UD3R>
 <20201111105441.GA78848@gmail.com>
 <20201111093609.1bd2b637@gandalf.local.home>
 <87d00jo55p.fsf@nanos.tec.linutronix.de>
 <20201112081030.GB14554@X58A-UD3R>
 <20201112092612.00a19239@gandalf.local.home>
 <20201112145251.GB17076@casper.infradead.org>
 <20201116085757.GB26078@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116085757.GB26078@X58A-UD3R>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 05:57:57PM +0900, Byungchul Park wrote:
> On Thu, Nov 12, 2020 at 02:52:51PM +0000, Matthew Wilcox wrote:
> > On Thu, Nov 12, 2020 at 09:26:12AM -0500, Steven Rostedt wrote:
> > > > FYI, roughly Lockdep is doing:
> > > > 
> > > >    1. Dependency check
> > > >    2. Lock usage correctness check (including RCU)
> > > >    3. IRQ related usage correctness check with IRQFLAGS
> > > > 
> > > > 2 and 3 should be there forever which is subtle and have gotten matured.
> > > > But 1 is not. I've been talking about 1. But again, it's not about
> > > > replacing it right away but having both for a while. I'm gonna try my
> > > > best to make it better.
> > > 
> > > And I believe lockdep does handle 1. Perhaps show some tangible use case
> > > that you want to cover that you do not believe that lockdep can handle. If
> > > lockdep cannot handle it, it will show us where lockdep is lacking. If it
> > > can handle it, it will educate you on other ways that lockdep can be
> > > helpful in your development ;-)
> > 
> > Something I believe lockdep is missing is a way to annotate "This lock
> > will be released by a softirq".  If we had lockdep for lock_page(), this
> > would be a great case to show off.  The filesystem locks the page, then
> > submits it to a device driver.  On completion, the filesystem's bio
> > completion handler will be called in softirq context and unlock the page.
> > 
> > So if the filesystem has another lock which is acquired by the completion
> > handler. we could get an ABBA deadlock that lockdep would be unable to see.
> > 
> > There are other similar things; if you look at the remaining semaphore
> > users in the kernel, you'll see the general pattern is that they're
> > acquired in process context and then released in interrupt context.
> > If we had a way to transfer ownership of the semaphore to a generic
> > "interrupt context", they could become mutexes and lockdep could check
> > that nothing else will cause a deadlock.
> 
> Yes. Those are exactly what Cross-release feature solves. Those problems
> can be achieved with Cross-release. But even with Cross-release, we
> still cannot solve the problem of (1) readlock handling (2) and false
> positives preventing further reporting.

It's not just about lockdep for semaphores.  Mutexes will spin if the
current owner is still running, so to convert an interrupt-released
semaphore to a mutex, we need a way to mark the mutex as being released
by the new owner.

I really don't think you want to report subsequent lockdep splats.

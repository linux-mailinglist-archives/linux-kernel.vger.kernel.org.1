Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954402AFF8E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 07:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgKLGQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 01:16:58 -0500
Received: from lgeamrelo13.lge.com ([156.147.23.53]:60291 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725290AbgKLGQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 01:16:57 -0500
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.53 with ESMTP; 12 Nov 2020 15:16:53 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.125 with ESMTP; 12 Nov 2020 15:16:53 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Thu, 12 Nov 2020 15:15:32 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        alexander.levin@microsoft.com, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com
Subject: Re: [RFC] Are you good with Lockdep?
Message-ID: <20201112061532.GA14554@X58A-UD3R>
References: <20201111050559.GA24438@X58A-UD3R>
 <20201111105441.GA78848@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111105441.GA78848@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 11:54:41AM +0100, Ingo Molnar wrote:
> > We cannot get reported other than the first one.
> 
> Correct. Experience has shown that the overwhelming majority of 
> lockdep reports are single-cause and single-report.
> 
> This is an optimal approach, because after a decade of exorcising 
> locking bugs from the kernel, lockdep is currently, most of the time, 

I also think Lockdep has been doing great job exorcising almost all
locking bugs so far. Respect it.

> in 'steady-state', with there being no reports for the overwhelming 
> majority of testcases, so the statistical probability of there being 
> just one new report is by far the highest.

This is true if Lockdep is only for checking if maintainers' tree are
ok and if we totally ignore how a tool could help folks in the middle of
development esp. when developing something complicated wrt.
synchronization.

But I don't agree if a tool could help while developing something that
could introduce many dependency issues.

> If on the other hand there's some bug in lockdep itself that causes 
> excessive false positives, it's better to limit the number of reports 
> to one per bootup, so that it's not seen as a nuisance debugging 
> facility.
> 
> Or if lockdep gets extended that causes multiple previously unreported 
> (but very much real) bugs to be reported, it's *still* better to 
> handle them one by one: because lockdep doesn't know whether it's real 

Why do you think we cannot handle them one by one with multi-reporting?
We can handle them with the first one as we do with single-reporting.
And also that's how we work, for example, when building the kernel or
somethinig.

> >    So the one who has introduced the first one should fix it as soon 
> >    as possible so that the other problems can be reported and fixed. 
> >    It will get even worse if it's a false positive because it's 
> >    worth nothing but only preventing reporting real ones.
> 
> Since kernel development is highly distributed, and 90%+ of new 
> commits get created in dozens of bigger and hundreds of smaller 
> maintainer topic trees, the chance of getting two independent locking 
> bugs in the same tree without the first bug being found & fixed is 
> actually pretty low.

Again, this is true if Lockdep is for checking maintainers' tree only.

> linux-next offers several weeks/months advance integration testing to 
> see whether the combination of maintainer trees causes 
> problems/warnings.

Good for us.

> >    That's why kernel developers are so sensitive to Lockdep's false
> >    positive reporting - I would, too. But precisely speaking, it's a
> >    problem of how Lockdep was designed and implemented, not false
> >    positive itself. Annoying false positives - as WARN()'s messages are
> >    annoying - should be fixed but we don't have to be as sensitive as we
> >    are now if the tool keeps normally working even after reporting.
> 
> I disagree, and even for WARN()s we are seeing a steady movement 
> towards WARN_ON_ONCE(): exactly because developers are usually 
> interested in the first warning primarily.
> 
> Followup warnings are even marked 'tainted' by the kernel - if a bug 
> happened we cannot trust the state of the kernel anymore, even if it 
> seems otherwise functional. This is doubly true for lockdep, where 

I definitely think so. Already tainted kernel is not the kernel we can
trust anymore. Again, IMO, a tool should help us not only for checking
almost final trees but also in developing something. No?

> But for lockdep there's another concern: we do occasionally report 
> bugs in locking facilities themselves. In that case it's imperative 
> for all lockdep activity to cease & desist, so that we are able to get 
> a log entry out before the kernel goes down potentially.

Sure. Makes sense.

> I.e. there's a "race to log the bug as quickly as possible", which is 
> the other reason we shut down lockdep immediately. But once shut down, 

Not sure I understand this part.

> all the lockdep data structures are hopelessly out of sync and it 
> cannot be restarted reasonably.

Is it about tracking IRQ and IRQ-enabled state? That's exactly what I'd
like to point out. Or is there something else?

> Not sure I understand the "problem 2)" outlined here, but I'm looking 
> forward to your patchset!

Thank you for the response.

Thanks,
Byungchul

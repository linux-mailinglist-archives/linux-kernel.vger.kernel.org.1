Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAF12B00E7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 09:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgKLILy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 03:11:54 -0500
Received: from lgeamrelo13.lge.com ([156.147.23.53]:54916 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725884AbgKLILy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 03:11:54 -0500
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.53 with ESMTP; 12 Nov 2020 17:11:52 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.127 with ESMTP; 12 Nov 2020 17:11:52 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Thu, 12 Nov 2020 17:10:30 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, torvalds@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        alexander.levin@microsoft.com, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com
Subject: Re: [RFC] Are you good with Lockdep?
Message-ID: <20201112081030.GB14554@X58A-UD3R>
References: <20201111050559.GA24438@X58A-UD3R>
 <20201111105441.GA78848@gmail.com>
 <20201111093609.1bd2b637@gandalf.local.home>
 <87d00jo55p.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d00jo55p.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 12:16:50AM +0100, Thomas Gleixner wrote:
> Wrappers which make things simpler are always useful, but the lack of
> wrappers does not justify a wholesale replacement.

Totally right. Lack of wrappers doesn't matter at all. That could be
achieved easily by modifying the original e.i. Lockdep. That's why I
didn't mention wrapper things in the description. (Sorry if I misled
you so it looked like I mentioned just wrappers. I should've explained
it in more detail.)

xxx_wait(), xxx_event() and xxx_event_context_start() are much more than
wrappers. It was about what deadlock detection tool should work based on.

> We all know that lockdep has limitations but I yet have to see a proper
> argument why this can't be solved incrementaly on top of the existing
> infrastructure.

This is exactly what I'd like to address. As you can see in the first
mail, the reasons why this can't be solved incrementaly are:

1. Lockdep's design and implementation are too complicated to be
   generalized so as to allow multi-reporting. Quite big change onto
   Lockdep would be required.

   I think allowing multi-reporting is very important for tools like
   Lockdep. As long as false positive in the single-reporting manner
   bothers folks, tools like Lockdep cannot be enhanced so as to have
   stronger capability.

2. Does Lockdep do what a deadlock detection tool should do? From
   internal engine to APIs, all the internal data structure and
   algotithm of Lockdep is only looking at lock(?) acquisition order.
   Fundamentally Lockdep cannot work correctly with all general cases,
   for example, read/write/trylock and any wait/event.

   This can be done by re-introducing cross-release but still partially.
   A deadlock detector tool should thoroughly focus on *waits* and
   *events* to be more perfect at detecting deadlock because the fact is
   *waits* and their *events* that never reach cause deadlock.

   With the philosophy of Lockdep, we can only handle partial cases
   fundamently. We have no choice but to do various work-around or adopt
   tricky ways to cover more cases if we keep using Lockdep.

> That said, I'm not at all interested in a wholesale replacement of
> lockdep which will take exactly the same amount of time to stabilize and
> weed out the shortcomings again.

I don't want to bother ones who don't want to be bothered from the tool.
But I think some day we need a new tool doing exactly what it should do
for deadlock detection for sure.

I'm willing to make it matured on my own, or with ones who need a
stronger tool or willing to make it matured together - I wish tho.
That's why I suggest to make both there until the new tool gets
considered stable.

FYI, roughly Lockdep is doing:

   1. Dependency check
   2. Lock usage correctness check (including RCU)
   3. IRQ related usage correctness check with IRQFLAGS

2 and 3 should be there forever which is subtle and have gotten matured.
But 1 is not. I've been talking about 1. But again, it's not about
replacing it right away but having both for a while. I'm gonna try my
best to make it better.

Thanks,
Byungchul

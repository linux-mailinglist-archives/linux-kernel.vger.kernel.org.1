Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B382B0160
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 09:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgKLIwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 03:52:38 -0500
Received: from lgeamrelo13.lge.com ([156.147.23.53]:34154 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725902AbgKLIwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 03:52:38 -0500
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.53 with ESMTP; 12 Nov 2020 17:52:35 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.125 with ESMTP; 12 Nov 2020 17:52:35 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Thu, 12 Nov 2020 17:51:14 +0900
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
Message-ID: <20201112085114.GC14554@X58A-UD3R>
References: <20201111050559.GA24438@X58A-UD3R>
 <20201111105441.GA78848@gmail.com>
 <20201112061532.GA14554@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112061532.GA14554@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 03:15:32PM +0900, Byungchul Park wrote:
> > If on the other hand there's some bug in lockdep itself that causes 
> > excessive false positives, it's better to limit the number of reports 
> > to one per bootup, so that it's not seen as a nuisance debugging 
> > facility.
> > 
> > Or if lockdep gets extended that causes multiple previously unreported 
> > (but very much real) bugs to be reported, it's *still* better to 
> > handle them one by one: because lockdep doesn't know whether it's real 
> 
> Why do you think we cannot handle them one by one with multi-reporting?
> We can handle them with the first one as we do with single-reporting.
> And also that's how we work, for example, when building the kernel or
> somethinig.

Let me add a little bit more. I just said the fact that we are able to
handle the bugs one by one as if we do with single-reporting.

But the thing is multi-reporting could be more useful in some cases.
More precisely speaking, bugs not caused by IRQ state will be reported
without annoying nuisance. I bet you have experienced a ton of nuisances
when multi-reporting Lockdep detected a deadlock by IRQ state.

For some cases, multi-reporting is as useful as single-reporting, while
for the other cases, multi-reporting is more useful. Then I think we
have to go with mutil-reporting if there's no technical issue.

Thanks,
Byungchul

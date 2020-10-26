Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DC8299813
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 21:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388545AbgJZUgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 16:36:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:43850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388529AbgJZUgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:36:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7C04CAC7D;
        Mon, 26 Oct 2020 20:36:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0055ADA6E2; Mon, 26 Oct 2020 21:35:01 +0100 (CET)
Date:   Mon, 26 Oct 2020 21:35:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Filipe Manana <fdmanana@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        David Sterba <dsterba@suse.com>
Subject: Re: possible lockdep regression introduced by 4d004099a668
 ("lockdep: Fix lockdep recursion")
Message-ID: <20201026203501.GU6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Peter Zijlstra <peterz@infradead.org>,
        Filipe Manana <fdmanana@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        David Sterba <dsterba@suse.com>
References: <a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com>
 <20201026114009.GN2594@hirez.programming.kicks-ass.net>
 <0c0d815c-bd5a-ff2d-1417-28a41173f2b4@suse.com>
 <20201026125524.GP2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026125524.GP2594@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 01:55:24PM +0100, Peter Zijlstra wrote:
> On Mon, Oct 26, 2020 at 11:56:03AM +0000, Filipe Manana wrote:
> > > That smells like the same issue reported here:
> > > 
> > >   https://lkml.kernel.org/r/20201022111700.GZ2651@hirez.programming.kicks-ass.net
> > > 
> > > Make sure you have commit:
> > > 
> > >   f8e48a3dca06 ("lockdep: Fix preemption WARN for spurious IRQ-enable")
> > > 
> > > (in Linus' tree by now) and do you have CONFIG_DEBUG_PREEMPT enabled?
> > 
> > Yes, CONFIG_DEBUG_PREEMPT is enabled.
> 
> Bummer :/

My builds don't have that enabled (CONFIG_PREEMPT_NONE=y) but I still
see the warning (same scenario as for Filipe). That is with today's
master branch + your fix from locking/urgent.

> > I'll try with that commit and let you know, however it's gonna take a
> > few hours to build a kernel and run all fstests (on that test box it
> > takes over 3 hours) to confirm that fixes the issue.
> 
> *ouch*, 3 hours is painful. How long to make it sick with the current
> kernel? quicker I would hope?
> 
> > Thanks for the quick reply!
> 
> Anyway, I don't think that commit can actually explain the issue :/
> 
> The false positive on lockdep_assert_held() happens when the recursion
> count is !0, however we _should_ be having IRQs disabled when
> lockdep_recursion > 0, so that should never be observable.
> 
> My hope was that DEBUG_PREEMPT would trigger on one of the
> __this_cpu_{inc,dec}(lockdep_recursion) instance, because that would
> then be a clear violation.

I can start another round (in my case it's more than 4 hours to
reproduce it) with DEBUG_PREEMPT, unless you have something else to
test.

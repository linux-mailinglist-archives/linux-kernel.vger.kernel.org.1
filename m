Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F432A416E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgKCKPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:15:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:32784 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgKCKPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:15:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 93DCAAC1F;
        Tue,  3 Nov 2020 10:15:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3B33D1E12FB; Tue,  3 Nov 2020 11:15:43 +0100 (CET)
Date:   Tue, 3 Nov 2020 11:15:43 +0100
From:   Jan Kara <jack@suse.cz>
To:     Filipe Manana <fdmanana@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        David Sterba <dsterba@suse.com>, matorola@gmail.com,
        mingo@kernel.org
Subject: Re: possible lockdep regression introduced by 4d004099a668
 ("lockdep: Fix lockdep recursion")
Message-ID: <20201103101543.GC3440@quack2.suse.cz>
References: <a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com>
 <20201026114009.GN2594@hirez.programming.kicks-ass.net>
 <0c0d815c-bd5a-ff2d-1417-28a41173f2b4@suse.com>
 <20201026125524.GP2594@hirez.programming.kicks-ass.net>
 <20201026152256.GB2651@hirez.programming.kicks-ass.net>
 <968c6023-612c-342b-aa69-ec9e1e428eb0@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <968c6023-612c-342b-aa69-ec9e1e428eb0@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02-11-20 17:58:54, Filipe Manana wrote:
> 
> 
> On 26/10/20 15:22, Peter Zijlstra wrote:
> > On Mon, Oct 26, 2020 at 01:55:24PM +0100, Peter Zijlstra wrote:
> >> On Mon, Oct 26, 2020 at 11:56:03AM +0000, Filipe Manana wrote:
> >>>> That smells like the same issue reported here:
> >>>>
> >>>>   https://lkml.kernel.org/r/20201022111700.GZ2651@hirez.programming.kicks-ass.net
> >>>>
> >>>> Make sure you have commit:
> >>>>
> >>>>   f8e48a3dca06 ("lockdep: Fix preemption WARN for spurious IRQ-enable")
> >>>>
> >>>> (in Linus' tree by now) and do you have CONFIG_DEBUG_PREEMPT enabled?
> >>>
> >>> Yes, CONFIG_DEBUG_PREEMPT is enabled.
> >>
> >> Bummer :/
> >>
> >>> I'll try with that commit and let you know, however it's gonna take a
> >>> few hours to build a kernel and run all fstests (on that test box it
> >>> takes over 3 hours) to confirm that fixes the issue.
> >>
> >> *ouch*, 3 hours is painful. How long to make it sick with the current
> >> kernel? quicker I would hope?
> >>
> >>> Thanks for the quick reply!
> >>
> >> Anyway, I don't think that commit can actually explain the issue :/
> >>
> >> The false positive on lockdep_assert_held() happens when the recursion
> >> count is !0, however we _should_ be having IRQs disabled when
> >> lockdep_recursion > 0, so that should never be observable.
> >>
> >> My hope was that DEBUG_PREEMPT would trigger on one of the
> >> __this_cpu_{inc,dec}(lockdep_recursion) instance, because that would
> >> then be a clear violation.
> >>
> >> And you're seeing this on x86, right?
> >>
> >> Let me puzzle moar..
> > 
> > So I might have an explanation for the Sparc64 fail, but that can't
> > explain x86 :/
> > 
> > I initially thought raw_cpu_read() was OK, since if it is !0 we have
> > IRQs disabled and can't get migrated, so if we get migrated both CPUs
> > must have 0 and it doesn't matter which 0 we read.
> > 
> > And while that is true; it isn't the whole store, on pretty much all
> > architectures (except x86) this can result in computing the address for
> > one CPU, getting migrated, the old CPU continuing execution with another
> > task (possibly setting recursion) and then the new CPU reading the value
> > of the old CPU, which is no longer 0.
> > 
> > I already fixed a bunch of that in:
> > 
> >   baffd723e44d ("lockdep: Revert "lockdep: Use raw_cpu_*() for per-cpu variables"")
> > 
> > but clearly this one got crossed.
> > 
> > Still, that leaves me puzzled over you seeing this on x86 :/
> 
> Hi Peter,
> 
> I still get the same issue with 5.10-rc2.
> Is there any non-merged patch I should try, or anything I can help with?

BTW, I've just hit the same deadlock issue with ext4 on generic/390 so I
confirm this isn't btrfs specific issue (as we already knew from the
analysis but still it's good to have that confirmed).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

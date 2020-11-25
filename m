Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2AA2C3B37
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 09:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgKYIi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 03:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgKYIi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 03:38:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D11C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 00:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EuQE+wUsMtcRRFtSJMYZWTjybtItL4YpTQutF+/qMGE=; b=fgcR/X295tTiQjdTocCPKeDm6I
        VZexbF2JoLKDX3c9Aqp6cQR1ws48+cG6m08bYYhi0FqF9V3XdqtUAdQMn5OhbuoDiQ/5uAfDxKkXy
        vFpc+EfqwrxtQVrecOTFmeygU9S025Ch106/pQMJdQNoBs3jayTJXk5ohfV0J/Y8vjGTGEsJ0ZLHM
        EDEdRpWni1QObUOw870N4rBZEqZo7sMAeoaO4sTq9pfj7Gckx2lzMHba/+rSsEDZg4wvkIr57cE9b
        I4bJXN4suRgXayZMinrkepKAXIoUmTVBdmrkCK2I7/60Pusuu/nR5RsGHidtGHmlRzI02KjL0qnQT
        R6+HVhPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khqIl-00067Q-7p; Wed, 25 Nov 2020 08:37:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 83D71301124;
        Wed, 25 Nov 2020 09:37:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5FC472009B1B4; Wed, 25 Nov 2020 09:37:17 +0100 (CET)
Date:   Wed, 25 Nov 2020 09:37:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 12/32] sched: Simplify the core pick loop for
 optimized case
Message-ID: <20201125083717.GM2414@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-13-joel@joelfernandes.org>
 <20201124120438.GY3021@hirez.programming.kicks-ass.net>
 <20201124170430.GC1021337@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124170430.GC1021337@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 12:04:30PM -0500, Joel Fernandes wrote:
> Hi Peter,
> 
> On Tue, Nov 24, 2020 at 01:04:38PM +0100, Peter Zijlstra wrote:
> > On Tue, Nov 17, 2020 at 06:19:42PM -0500, Joel Fernandes (Google) wrote:
> > > +	/*
> > > +	 * Optimize for common case where this CPU has no cookies
> > > +	 * and there are no cookied tasks running on siblings.
> > > +	 */
> > > +	if (!need_sync) {
> > > +		for_each_class(class) {
> > > +			next = class->pick_task(rq);
> > > +			if (next)
> > > +				break;
> > > +		}
> > > +
> > > +		if (!next->core_cookie) {
> > > +			rq->core_pick = NULL;
> > > +			goto done;
> > > +		}
> > >  		need_sync = true;
> > >  	}
> > 
> > This isn't what I send you here:
> > 
> >   https://lkml.kernel.org/r/20201026093131.GF2628@hirez.programming.kicks-ass.net
> 
> I had replied to it here with concerns about the effects of newly idle
> balancing not being reverseable, it was only a theoretical concern:
> http://lore.kernel.org/r/20201105185019.GA2771003@google.com

Gah, missed that. I don't think that matters much see:
put_prev_task_balance() calling balance_fair().

> > Specifically, you've lost the whole cfs-cgroup optimization.
> 
> Are you referring to this optimization in pick_next_task_fair() ?
> 
> /*
>  * Since we haven't yet done put_prev_entity and if the
>  * selected task
>  * is a different task than we started out with, try
>  * and touch the
>  * least amount of cfs_rqs.
>  */

Yep, that. The giant FAIR_GROUP_SCHED hunk. The thing that makes
all of pick_next_task() more complicated than it really wants to be.

> You are right, we wouldn't get that with just calling pick_task_fair(). We
> did not have this in v8 series either though.
> 
> Also, if the task is a cookied task, then I think you are doing more work
> with your patch due to the extra put_prev_task().

Yes, but only if you mix cookie tasks with non-cookie tasks and schedule
two non-cookie tasks back-to-back. I don't think we care overly much
about that.

I think it makes more sense to ensure that if you have core-sched
enabled on your machine and have a (core-aligned) parition with
non-cookie tasks, scheduling has works as 'normal' as possible.

> > What was wrong/not working with the below?
> 
> Other than the new idle balancing, IIRC it was also causing instability.
> Maybe we can considering this optimization in the future if that's Ok with
> you?

Hurmph.. you don't happen to remember what went splat?

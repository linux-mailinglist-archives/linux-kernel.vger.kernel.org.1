Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68E42C507F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 09:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388893AbgKZIaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 03:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgKZIaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 03:30:16 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A653C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 00:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fDlu5J9M+Xdp0HOAKxmY6WP3yf0ej07B8LChxfpJT5A=; b=3HfQBIMKZLxJjn4pRg2PO2R1jU
        wEkDFC4MFR3nFwXrubpqJaNBB4Pt25gsq4UgMzK6QW7bAvMFmZKLeoAe0veVbFdm2LhnQP1fIdmD9
        tDPndmQYPrItovxELLijTVIa/fOr2O3WHIeYwJamDnxTSiSRkGYwvqZQzfnw0e4excqpMot5Hh5Lg
        bNP/iZBQjALRyIYbbFcEirMlVKh5/5GDb7gziIJxPiElP4GQlUq3WddRCVQ4ZRUQDqkn9Z6rjuu6s
        3sDS8knnyBctBzYvX/0cdNJjLvyvt4Y/1zkPffcmyQCR81iUECM/MT0/jixzysBtDTUMOn3UMGcRJ
        TNozZo2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiCeS-0000dY-8Y; Thu, 26 Nov 2020 08:29:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4CC6B3012DF;
        Thu, 26 Nov 2020 09:29:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 30F3920D6FE65; Thu, 26 Nov 2020 09:29:14 +0100 (CET)
Date:   Thu, 26 Nov 2020 09:29:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
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
Subject: Re: [PATCH -tip 10/32] sched: Fix priority inversion of cookied task
 with sibling
Message-ID: <20201126082914.GE2414@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-11-joel@joelfernandes.org>
 <20201122224123.GE110669@balbir-desktop>
 <20201124183038.GG1021337@google.com>
 <20201125230519.GC163610@balbir-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125230519.GC163610@balbir-desktop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 10:05:19AM +1100, Balbir Singh wrote:
> > @@ -5259,7 +5254,20 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >  			 * Optimize the 'normal' case where there aren't any
> >  			 * cookies and we don't need to sync up.
> >  			 */
> > -			if (i == cpu && !need_sync && !p->core_cookie) {
> > +			if (i == cpu && !need_sync) {
> > +				if (p->core_cookie) {
> > +					/*
> > +					 * This optimization is only valid as
> > +					 * long as there are no cookies
> 
> This is not entirely true, need_sync is a function of core cookies, so I
> think this needs more clarification, it sounds like we enter this when
> the core has no cookies, but the task has a core_cookie? The term cookie
> is quite overloaded when used in the context of core vs task.

Nah, its the same. So each task gets a cookie to identify the 'group' of
tasks (possibly just itself) it is allowed to share a core with.

When we to core task selection, the core gets assigned the cookie of the
group it will run, same thing.

> Effectively from what I understand this means that p wants to be
> coscheduled, but the core itself is not coscheduling anything at the
> moment, so we need to see if we should do a sync and that sync might
> cause p to get kicked out and a higher priority class to come in?

This whole patch is about eliding code-wide task selection when it is
not required. IOW an optimization.

When there wasn't a core cookie (IOW, the previous task selection wasn't
core wide and limited) and the task we just selected for our own CPU
also didn't have a cookie (IOW it doesn't have to be core-wide) we can
skip the core wide task selection and schedule just this CPU and call it
a day.

The logic was subtly wrong, this patch fixes it. A next patch completely
rewrites it again to make it far simpler again. Don't spend time trying
to understand this patch (unless you're _that_ kind of person ;-) but
instead apply the whole thing and look at the resulting pick_next_task()
function.

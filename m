Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378E82C505A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 09:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388942AbgKZIZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 03:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgKZIZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 03:25:08 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAD7C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 00:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IcJI4s2tyDuR2QNmEP2cRAFZXWjnnUTNEyMuql9UvDk=; b=LgI8jC0u0YYh1eUgHj33jG5HWW
        FDfIGo9a0d+4+Wja3/cxx46AaM1ZZdybX4A1fP4dXPZUQpa+ACjPgWV3p7yvThF5/BP6G7w9rj3U2
        4jyi30uGXUU4Nj/DJAS1f4YvYxBHs303Yvudsurv36sHI28t0TEaWCJmK7kQubHlQq0K8nIaikjpx
        eu5aMCBPf06C6rBDcoTno88CvBgilsbuLC+L6+6yabjw/lbCfPCm3/+LVqcLld7qz55aP9Zmv4mJb
        F/yMSsUi9jZO1t0R/SgVO1uDNUU+4Dgo9BrKZXacLy0IPaSVRQiEfkEv9y3NRZo3dPTmQFnS7Dj1R
        Jk757HsA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiCZL-0008Gw-4M; Thu, 26 Nov 2020 08:23:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7AFB73003D8;
        Thu, 26 Nov 2020 09:23:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5BAEB200DF1C2; Thu, 26 Nov 2020 09:23:52 +0100 (CET)
Date:   Thu, 26 Nov 2020 09:23:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
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
Subject: Re: [PATCH -tip 09/32] sched/fair: Snapshot the min_vruntime of CPUs
 on force idle
Message-ID: <20201126082352.GD2414@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-10-joel@joelfernandes.org>
 <20201122114442.GD110669@balbir-desktop>
 <2cb42831-5074-e0a9-9e2a-f2a880504026@linux.microsoft.com>
 <20201123233149.GB8893@balbir-desktop>
 <20201124090955.GV3021@hirez.programming.kicks-ass.net>
 <20201125231715.GD163610@balbir-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125231715.GD163610@balbir-desktop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 10:17:15AM +1100, Balbir Singh wrote:
> On Tue, Nov 24, 2020 at 10:09:55AM +0100, Peter Zijlstra wrote:

> > The basic observation the current approach relies on is that al that
> > faffery basically boils down to the fact that vruntime only means
> > something when there is contention. And that only the progression is
> > important not the actual value. That is, this is all fundamentally a
> > differential equation and our integration constant is meaningless (also
> > embodied in (7)).
> >
> 
> I'll reread (6) and (7), I am trying to understand forced idle and
> contention together, from what I understand of the patches, there is 

When we force-idle there is contention by definition; there's a task
that wanted to run, but couldn't.

> 1. two tasks that are core scheduled, in that case vruntime works as
> expected on each CPU, but we need to compare their combined vrtuntime
> against other tasks on each CPU respectively for them to be
> selected/chosen?

We need to compare across CPUs when the cookies don't match. This is
required to avoid starving one or the other.

> 2. When one of the tasks selected is a part of the core scheduling group
> and the other CPU does not select a core scheduled tasks, we need to ask
> ourselves if that CPU should force idle and that's where this logic
> comes into play?

When one CPU selects a cookie task, and the other CPU cannot find a
matching task, it must go idle (as idle matches everyone). This is the
basic core-scheduling constraint.

So suppose you have two tasks, A and B, both with a cookie, but not
matching.

Normal scheduling would run A and B concurrent on the two siblings. Core
scheduling obviously cannot do this. When we pick A, the other CPU is
not allowed to run B and thus will have to be forced idle and
vice-versa.

The next problem is avoiding starvation. Assuming equal weight between
the tasks, we'd want to end up running A and B in alternating cycles.

This means having to compare runtimes between A and B, but when they're
on different runqueues the actual vruntime values can be wildly
divergent and cannot be reasily compared (the integration constant is
meaningless but really annoying ;-).

We also cannot use min_vruntime (which is the same as the task vruntime
when there is only a single task), because then you cannot observe
progress. The difference between min_vruntime and the task runtime is
always 0, so you can't tell who just ran and who got starved.

This is where our snapshots come in play, we snapshot vruntime after
task selection (before running), such that at the next pick we can tell
who made progress and who got starved.

By marking the vruntime of both runqueues at the same point in time we
basically normalize away that integration constant. You effectively
reset the vruntime to 0 (through (7), but without iterating all the
tasks and adjusting it).

Does that make sense?

Once you get this, read that second email linked.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8502C22F1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbgKXK2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgKXK2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:28:45 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C935C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sVZQg3f+H2ITDjvlnKTguk7GALp7qDu3IpnpV1tFdEg=; b=Xu8CN1ouCtzTaU1ix7xlnqX3R4
        tBAv/vR0vhxTpNPpEarikmEtI20E7lOkSkghk5O05MTuFSG5cxqErMLb23jhP1HGojQmatiu2jC93
        3bh47C0998+gxT/aCMwekc1IGWSdFqctw1h0qlw/Uc2JnbGB8xlHis3tFJ7UrE1SgvXgZ1JAZpRC5
        wjH+Cg3cVh7pt6xDTilzGiDtJf3/kz23xdIQ4QVoUyMHwz6aWRuVguq1Bi8KgDJlT6Ao17X243gcc
        jeOyPC8Eh66nimwzdK185BxhwwAJu77I/L4MVpSOBcFbGo/a7goZaB3AtBb/AcddgEgbdKkiNJDba
        uWwBV3Kg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khVY2-0007xS-VJ; Tue, 24 Nov 2020 10:27:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F2050300DAE;
        Tue, 24 Nov 2020 11:27:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C8C1F20298C91; Tue, 24 Nov 2020 11:27:41 +0100 (CET)
Date:   Tue, 24 Nov 2020 11:27:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
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
Subject: Re: [PATCH -tip 15/32] sched: Improve snapshotting of min_vruntime
 for CGroups
Message-ID: <20201124102741.GW3021@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-16-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117232003.3580179-16-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:19:45PM -0500, Joel Fernandes (Google) wrote:
> A previous patch improved cross-cpu vruntime comparison opertations in
> pick_next_task(). Improve it further for tasks in CGroups.
> 
> In particular, for cross-CPU comparisons, we were previously going to
> the root-level se(s) for both the task being compared. That was strange.
> This patch instead finds the se(s) for both tasks that have the same
> parent (which may be different from root).
> 
> A note about the min_vruntime snapshot and force idling:
> Abbreviations: fi: force-idled now? ; fib: force-idled before?
> During selection:
> When we're not fi, we need to update snapshot.
> when we're fi and we were not fi, we must update snapshot.
> When we're fi and we were already fi, we must not update snapshot.
> 
> Which gives:
>         fib     fi      update?
>         0       0       1
>         0       1       1
>         1       0       1
>         1       1       0
> So the min_vruntime snapshot needs to be updated when: !(fib && fi).
> 
> Also, the cfs_prio_less() function needs to be aware of whether the core
> is in force idle or not, since it will be use this information to know
> whether to advance a cfs_rq's min_vruntime_fi in the hierarchy. So pass
> this information along via pick_task() -> prio_less().

Hurmph.. so I'm tempted to smash a bunch of patches together.

 2 <- 3 (already done - bisection crashes are daft)
 6 <- 11
 7 <- {10, 12}
 9 <- 15

I'm thinking that would result in an easier to read series, or do we
want to preserve this history?

(fwiw, I pulled 15 before 13,14, as I think that makes more sense
anyway).

Hmm?

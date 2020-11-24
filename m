Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9642C2011
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbgKXIdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbgKXIdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:33:07 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC047C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 00:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1z5cl4E+1Kt5ZTJVS7bSlXS5dAz5x84o0QFQGPW0MwI=; b=TUOxQiajN4MT/SrV3n5T0XJHNs
        ibPQSsgjFWHHfNC5igX2BOc3Z0l0Kei3PjbMXAmYx3v7QUjbfibKH6sDzGfuA6mGdwMS8JHCsa6Sy
        eo4Z/QwO9HQ/sTWR5yaiO48WyVmW4lUuNC1UrY1ktB8SD9Y2+Q51Dsq4+9RCmORBP1x0fpYacjlxa
        FRPbkkmzGadNf4GcflgnxN8nfwaubGPgr34iUUgY64tKaxZEsMhOsbJpkLs8YRZ1jt6eftqrsqqoF
        ZuSYfI65olro/Hxc5qrl/4EcXYrAd1ymfTsVjEWdWSylSSsCUMru6dUpuZ0Qgsb3HBrrQdpNFvqRx
        LdRQFF0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khTjz-0003zd-Pz; Tue, 24 Nov 2020 08:32:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EBE563012DF;
        Tue, 24 Nov 2020 09:31:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A103024C2AFD3; Tue, 24 Nov 2020 09:31:56 +0100 (CET)
Date:   Tue, 24 Nov 2020 09:31:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Singh, Balbir" <bsingharora@gmail.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
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
Subject: Re: [PATCH -tip 03/32] sched/fair: Fix pick_task_fair crashes due to
 empty rbtree
Message-ID: <20201124083156.GU3021@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-4-joel@joelfernandes.org>
 <cab6918c-7b52-923c-4274-f92e9f0a5cd2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cab6918c-7b52-923c-4274-f92e9f0a5cd2@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 09:15:28PM +1100, Singh, Balbir wrote:
> On 18/11/20 10:19 am, Joel Fernandes (Google) wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > pick_next_entity() is passed curr == NULL during core-scheduling. Due to
> > this, if the rbtree is empty, the 'left' variable is set to NULL within
> > the function. This can cause crashes within the function.
> > 
> > This is not an issue if put_prev_task() is invoked on the currently
> > running task before calling pick_next_entity(). However, in core
> > scheduling, it is possible that a sibling CPU picks for another RQ in
> > the core, via pick_task_fair(). This remote sibling would not get any
> > opportunities to do a put_prev_task().
> > 
> > Fix it by refactoring pick_task_fair() such that pick_next_entity() is
> > called with the cfs_rq->curr. This will prevent pick_next_entity() from
> > crashing if its rbtree is empty.
> > 
> > Also this fixes another possible bug where update_curr() would not be
> > called on the cfs_rq hierarchy if the rbtree is empty. This could effect
> > cross-cpu comparison of vruntime.
> > 
> 
> It is not clear from the changelog as to what does put_prev_task() do to prevent
> the crash from occuring? Why did we pass NULL as curr in the first place to
> pick_next_entity?
> 
> The patch looks functionally correct as in, it passes curr as the reference
> to pick_next_entity() for left and entity_before comparisons.

This patch should not exist; it should be smashed into the previous
patch. There is no point in preserving a crash.

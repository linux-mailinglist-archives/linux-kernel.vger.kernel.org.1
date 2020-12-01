Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A8A2CABCD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbgLATWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgLATWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:22:34 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F983C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7JLyHZJtRdTTbCdr1AWpBIMP6N5KB46ClouAigDfKUM=; b=Zi0+mLPZRtmx6Nr/4ObCeXRnwl
        y1bv6dKyo7ObW5HiWKUIfQpK2UtTP5vww1zNY9ah095pZZKchDqdjtYIM4HBu8NJL9qfTzORE+xDm
        VKevGhyLJSwikXmpSornfpNjZ0RBKgxefODTrOK9TrnzV3vw9OeBeGojrCUIgTH+/xzfZ8n+2tlLX
        t14IVJfgnR/9U9EQET1LknHKYts+BdgJGUfSDd6dNprynsEmcuGppBhYiyyd4xn1RPiZTe2RR7fGa
        Z9RZanDBctLqnyBsXpqNarcEUYqXhsjf42lmDYBa2xWtl50U3/Fxoa74ZFSh+s6iXi5/tO87RDb34
        T3Y2YGcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkBCn-0003j8-V0; Tue, 01 Dec 2020 19:20:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4ED29305C22;
        Tue,  1 Dec 2020 20:20:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 39A4C2BF19AAE; Tue,  1 Dec 2020 20:20:50 +0100 (CET)
Date:   Tue, 1 Dec 2020 20:20:50 +0100
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
Subject: Re: [PATCH -tip 22/32] sched: Split the cookie and setup per-task
 cookie on fork
Message-ID: <20201201192050.GX3040@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-23-joel@joelfernandes.org>
 <20201125111541.GU2414@hirez.programming.kicks-ass.net>
 <20201201191133.GA221478@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201191133.GA221478@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 02:11:33PM -0500, Joel Fernandes wrote:
> On Wed, Nov 25, 2020 at 12:15:41PM +0100, Peter Zijlstra wrote:
> > On Tue, Nov 17, 2020 at 06:19:52PM -0500, Joel Fernandes (Google) wrote:
> > 
> > > +/*
> > > + * Ensure that the task has been requeued. The stopper ensures that the task cannot
> > > + * be migrated to a different CPU while its core scheduler queue state is being updated.
> > > + * It also makes sure to requeue a task if it was running actively on another CPU.
> > > + */
> > > +static int sched_core_task_join_stopper(void *data)
> > > +{
> > > +	struct sched_core_task_write_tag *tag = (struct sched_core_task_write_tag *)data;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < 2; i++)
> > > +		sched_core_tag_requeue(tag->tasks[i], tag->cookies[i], false /* !group */);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2)
> > > +{
> > 
> > > +	stop_machine(sched_core_task_join_stopper, (void *)&wr, NULL);
> > 
> > > +}
> > 
> > This is *REALLY* terrible...
> 
> I pulled this bit from your original patch. Are you concerned about the
> stop_machine? Sharing a core is a slow path for our usecases (and as far as I
> know, for everyone else's). We can probably do something different if that
> requirement changes.
> 

Yeah.. so I can (and was planning on) remove stop_machine() from
sched_core_{dis,en}able() before merging it.

(there's two options, one uses stop_cpus() with the SMT mask, the other
RCU)

This though is exposing stop_machine() to joe user. Everybody is allowed
to prctl() it's own task and set a cookie on himself. This means you
just made giant unpriv DoS vector.

stop_machine is bad, really bad.

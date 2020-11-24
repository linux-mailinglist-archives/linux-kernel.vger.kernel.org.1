Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0632E2C20EC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbgKXJLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbgKXJLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:11:07 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB86FC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 01:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LsUhmU0WT++YLBi6HGUiMcQOnFMwJPHN5wB9uqRalGU=; b=ypY8JjN0GujQRr8F4buCXJ1DQf
        8bStYBvXuR36JeMYxvWVtis+wFA/xsrH0rwHCcrP1O5l525rUsix/WSKr5PlE7x5iyIn5Ag2w0jMV
        Jtsmw3rIfKe4PgsT61wC/VRimCmsane3jx5V0zgY83lzGxV5J5hE0uz5SudSj5oYCSDhX2sNVrH6Z
        qU51iT2wsi7FgiyZ0lK0QTuSc+iKnHCxdZYYY8C71sPbFB61S8heFUemthBHoyfciKEDdVzDH7H86
        4EUmz+/2uU9EfmjuAtfA5yx833bu/llKWrojszrd/U8NKGQsqY5sAw18+215gYj2sygQyw7QvNLdL
        tVgea+Sw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khUKn-0001wj-4N; Tue, 24 Nov 2020 09:10:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A26C7306DD8;
        Tue, 24 Nov 2020 10:09:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B7A520298C8F; Tue, 24 Nov 2020 10:09:55 +0100 (CET)
Date:   Tue, 24 Nov 2020 10:09:55 +0100
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
Message-ID: <20201124090955.GV3021@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-10-joel@joelfernandes.org>
 <20201122114442.GD110669@balbir-desktop>
 <2cb42831-5074-e0a9-9e2a-f2a880504026@linux.microsoft.com>
 <20201123233149.GB8893@balbir-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123233149.GB8893@balbir-desktop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 10:31:49AM +1100, Balbir Singh wrote:
> On Mon, Nov 23, 2020 at 07:31:31AM -0500, Vineeth Pillai wrote:
> > Hi Balbir,
> > 
> > On 11/22/20 6:44 AM, Balbir Singh wrote:
> > > 
> > > This seems cumbersome, is there no way to track the min_vruntime via
> > > rq->core->min_vruntime?
> > Do you mean to have a core wide min_vruntime? We had a
> > similar approach from v3 to v7 and it had major issues which
> > broke the assumptions of cfs. There were some lengthy
> > discussions and Peter explained in-depth about the issues:
> > 
> > https://lwn.net/ml/linux-kernel/20200506143506.GH5298@hirez.programming.kicks-ass.net/
> > https://lwn.net/ml/linux-kernel/20200515103844.GG2978@hirez.programming.kicks-ass.net/
> >
> 
> One of the equations in the link is
> 
> ">From which immediately follows that:
> 
>           T_k + T_l
>   S_k+l = ---------                                       (13)
>           W_k + W_l
> 
> On which we can define a combined lag:
> 
>   lag_k+l(i) := S_k+l - s_i                               (14)
> 
> And that gives us the tools to compare tasks across a combined runqueue.
> "
> 
> S_k+l reads like rq->core->vruntime, but it sounds like the equivalent
> of rq->core->vruntime is updated when we enter forced idle as opposed to
> all the time.

Yes, but actually computing and maintaining it is hella hard. Try it
with the very first example in that email (the infeasible weight
scenario) and tell me how it works for you ;-)

Also note that the text below (6) mentions dynamic, then look up the
EEVDF paper which describes some of the dynamics -- the paper is
incomplete and contains a bug, I forget if it ever got updated or if
there's another paper that completes it (the BQF I/O scheduler started
from that and fixed it).

I'm not saying it cannot be done, I'm just saying it is really rather
involved and probably not worth it.

The basic observation the current approach relies on is that al that
faffery basically boils down to the fact that vruntime only means
something when there is contention. And that only the progression is
important not the actual value. That is, this is all fundamentally a
differential equation and our integration constant is meaningless (also
embodied in (7)).

Also, I think the code as proposed here relies on SMT2 and is buggered
for SMT3+. Now, that second link above describes means of making SMT3+
work, but we're not there yet.

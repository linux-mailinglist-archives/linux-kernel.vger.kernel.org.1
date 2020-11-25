Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6697A2C4B61
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 00:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgKYXRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 18:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729729AbgKYXRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 18:17:20 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F071DC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 15:17:19 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id j19so72298pgg.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 15:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fPBiGbxZNVp4Ewr892Wb2GxDmA9Rasrltq1wrpJkpxk=;
        b=T4+aIkFguFj7jpu+w3emceF+mJyXUzjk3wCn6Kfr785/a9cTvfuK6WNcmwRWsbHPF0
         EDLSIv8TqK+JSvfOLYe51zZMiYdvUzeAWHKMHoz0x3nUw/0MXqasAKqgX24EYB+N+wVA
         RgFW9CdBHvWFbWzca1AAmerxPhMSOLL2gMOF7Gi39BWQWejMCOoio2lFwrir0bgb8JDn
         aMjHX1Z+a1PdftFUx+cfXgGUjB+EgI0ANs7C0Dlh0U8wQviWE0cZEMbbI8v5QznticKI
         EM6fHK2uF1+TzQo6b5xD4bo176H3PGKXPfuyEFY4x3uha0PZXn/axQ2eBD2RNYEmnKkq
         3FYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fPBiGbxZNVp4Ewr892Wb2GxDmA9Rasrltq1wrpJkpxk=;
        b=lsgc9GiipIo2Pkn/kQoICGPsYUSkqPnstt8KFuAKc0KT3GpOS/ap5iyw/kWvcVItiv
         wwwvPb0Xz5CitZOu2SHn53aNLz9w+j/+wJt3s+AOx0OZVo6c8+U6tba+sAWHcbPS6sqi
         +46w6j6AazCBKBFCcSiT/szZnIsdUNC34mcIQ7d0cE5niSkqlDGPQuqvHLkP0lNpL/aw
         7BXTTjaZg0umSrUOHmEVrcafINldrXKxz5PY6erxCzxVWW8igaOpq9QNCx8hwYPBR3Kj
         bxAnP4J0DzI8rtP5+L1sHZiK6XAOdIdOpRgPfDKVb+ml5C8bfyqbTDQflfPsUHsKDu+8
         5e8g==
X-Gm-Message-State: AOAM532zFXHY32JME9M7/RZ7MeJrWM2CjsTzwB1HPtrvSLB4hSstv5td
        UmDrhnoJrYsp9ckjMP6OJK4=
X-Google-Smtp-Source: ABdhPJwa3tY8WnV+vQjTaGCYCeGq3paIF9CExBOiksGviXtoekVwNEsKD1qBl5UOKF/TX1W1DXXhgQ==
X-Received: by 2002:a17:90a:8402:: with SMTP id j2mr128334pjn.120.1606346239197;
        Wed, 25 Nov 2020 15:17:19 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id r3sm3981272pjl.23.2020.11.25.15.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 15:17:17 -0800 (PST)
Date:   Thu, 26 Nov 2020 10:17:15 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20201125231715.GD163610@balbir-desktop>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-10-joel@joelfernandes.org>
 <20201122114442.GD110669@balbir-desktop>
 <2cb42831-5074-e0a9-9e2a-f2a880504026@linux.microsoft.com>
 <20201123233149.GB8893@balbir-desktop>
 <20201124090955.GV3021@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124090955.GV3021@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 10:09:55AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 24, 2020 at 10:31:49AM +1100, Balbir Singh wrote:
> > On Mon, Nov 23, 2020 at 07:31:31AM -0500, Vineeth Pillai wrote:
> > > Hi Balbir,
> > > 
> > > On 11/22/20 6:44 AM, Balbir Singh wrote:
> > > > 
> > > > This seems cumbersome, is there no way to track the min_vruntime via
> > > > rq->core->min_vruntime?
> > > Do you mean to have a core wide min_vruntime? We had a
> > > similar approach from v3 to v7 and it had major issues which
> > > broke the assumptions of cfs. There were some lengthy
> > > discussions and Peter explained in-depth about the issues:
> > > 
> > > https://lwn.net/ml/linux-kernel/20200506143506.GH5298@hirez.programming.kicks-ass.net/
> > > https://lwn.net/ml/linux-kernel/20200515103844.GG2978@hirez.programming.kicks-ass.net/
> > >
> > 
> > One of the equations in the link is
> > 
> > ">From which immediately follows that:
> > 
> >           T_k + T_l
> >   S_k+l = ---------                                       (13)
> >           W_k + W_l
> > 
> > On which we can define a combined lag:
> > 
> >   lag_k+l(i) := S_k+l - s_i                               (14)
> > 
> > And that gives us the tools to compare tasks across a combined runqueue.
> > "
> > 
> > S_k+l reads like rq->core->vruntime, but it sounds like the equivalent
> > of rq->core->vruntime is updated when we enter forced idle as opposed to
> > all the time.
> 
> Yes, but actually computing and maintaining it is hella hard. Try it
> with the very first example in that email (the infeasible weight
> scenario) and tell me how it works for you ;-)
>

OK, I was hoping it could be done in the new RBTree's enqueue/dequeue,
but yes I've not implemented it and I should go back and take a look at
the first example again.

> Also note that the text below (6) mentions dynamic, then look up the
> EEVDF paper which describes some of the dynamics -- the paper is
> incomplete and contains a bug, I forget if it ever got updated or if
> there's another paper that completes it (the BQF I/O scheduler started
> from that and fixed it).

I see, I am yet to read the EEVDF paper, but now I am out on a tangent
:)

> 
> I'm not saying it cannot be done, I'm just saying it is really rather
> involved and probably not worth it.
>

Fair enough

> The basic observation the current approach relies on is that al that
> faffery basically boils down to the fact that vruntime only means
> something when there is contention. And that only the progression is
> important not the actual value. That is, this is all fundamentally a
> differential equation and our integration constant is meaningless (also
> embodied in (7)).
>

I'll reread (6) and (7), I am trying to understand forced idle and
contention together, from what I understand of the patches, there is 

1. two tasks that are core scheduled, in that case vruntime works as
expected on each CPU, but we need to compare their combined vrtuntime
against other tasks on each CPU respectively for them to be
selected/chosen?
2. When one of the tasks selected is a part of the core scheduling group
and the other CPU does not select a core scheduled tasks, we need to ask
ourselves if that CPU should force idle and that's where this logic
comes into play?

> Also, I think the code as proposed here relies on SMT2 and is buggered
> for SMT3+. Now, that second link above describes means of making SMT3+
> work, but we're not there yet.

Thanks,
Balbir Singh.

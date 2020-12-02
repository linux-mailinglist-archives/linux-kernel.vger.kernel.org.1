Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456B32CB602
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 08:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgLBH4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 02:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLBH4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:56:38 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815EAC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 23:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H2WKhUPCiAxV/zU7tZhzPn1+a6z3ubuLC4c5dn/7IRU=; b=vs1BP9UTQMUUZlKTDWcpx5f2bM
        pduXMgG84yVwYMuR441VDta3T/GqywmDq0DamKT1KzE4+9L/BBjk6L2XyxcpOhPoqnGiiiMM6OoHJ
        7sYo3gjx4QfrojS1v5bnqjmtmoNc52HMkm3utbb/UPP//WKeZlfdq0Wm5liHJyEJvkWac2MYnOZoE
        bAvFH0dwW6lq1viGg1fR76SjZ/1vh8xgo+cy9PjlM4A60eyULasexKz18F/DPX4btWHKW5fYHitsN
        Fbt3bqq2g9YuXL+gzs2XtxzY03V6sTTSowkdhFNM6w/cBmBoumbwyOoHF7q8/Uojz45JCfNyr0J2y
        7Dti8I3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkMyX-0001eI-2S; Wed, 02 Dec 2020 07:54:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BED23305C10;
        Wed,  2 Dec 2020 08:54:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 956A02C83017B; Wed,  2 Dec 2020 08:54:47 +0100 (CET)
Date:   Wed, 2 Dec 2020 08:54:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>, chris.hyser@oracle.com,
        Ben Segall <bsegall@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Oleg Rombakh <olegrom@google.com>
Subject: Re: [PATCH -tip 22/32] sched: Split the cookie and setup per-task
 cookie on fork
Message-ID: <20201202075447.GC3021@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-23-joel@joelfernandes.org>
 <20201125111014.GS2414@hirez.programming.kicks-ass.net>
 <20201201192028.GA222419@google.com>
 <20201201193451.GY3040@hirez.programming.kicks-ass.net>
 <CABk29NvoymPokXpoLkFZPDXDM0DoCVOJNTy9qVVQsaTgcBcJNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29NvoymPokXpoLkFZPDXDM0DoCVOJNTy9qVVQsaTgcBcJNg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 10:36:18PM -0800, Josh Don wrote:
> On Tue, Dec 1, 2020 at 11:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > So I don't think that later patch is right... That is, it works, but
> > afaict it's massive overkill.
> >
> >         COOKIE_CMP_RETURN(task_cookie);
> >         COOKIE_CMP_RETURN(group_cookie);
> >         COOKIE_CMP_RETURN(color);
> >
> > So if task_cookie matches, we consider group_cookie, if that matches we
> > consider color.
> >
> > Now, afaict that's semantically exactly the same as just using the
> > narrowest cookie. That is, use the task cookie if there is, and then,
> > walking the cgroup hierarchy (up) pick the first cgroup cookie.
> >
> > (I don't understand the color thing, but lets have that discussion in
> > that subthread)
> >
> > Which means you only need a single active cookie field.
> >
> > IOW, you're just making things complicated and expensive.
> >
> 
> For the per-task interface, I believe we still want to prevent two
> tasks that share a task cookie from sharing an overall cookie if they
> are in two separately tagged groups (Joel please correct me if I'm
> mistaken there). That's why in Joel's older patch, the overall cookie
> was a combination of the task and group cookies.  My concern about
> that was the potential cookie collision.

Then disallow sharing a task cookie when the tasks are in different
cgroups or disallow cgroup movement when they share a cookie.

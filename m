Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CEA2C5DCD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 23:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391849AbgKZW1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 17:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbgKZW1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 17:27:53 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959E1C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 14:27:53 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id s21so2722611pfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 14:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ooswFgMeNsythX+/qBR9OI9wHD8VXSogRNh49IYd+vE=;
        b=pQweySULAkeJLGSir1/275kvZSu1n+bS9J7mr4dXXQZr+0SXSl+xzuDJJNkNwBVRUw
         VNdVErJhVC65dbS+DIDMfIoDNtPl2PZQVTE6N91w16ym8CFwkcn4MY0sd0wirStuu1Zz
         b4Dh8rYVCByftLYA19jlcsFgIwPV7OKPd+/YIus4IkWnZyYXzYi9qtVmRsj+mnGNb1pK
         Ne4+ZDh0RanhamRMAtT1tKHeJcH7d9ix4DJDaJTGNY5VgvMLSUf3sQckvwYUo6EMg9nI
         HorhxvlGkQCZh8gnXqYT1mkmzD3PcAAs9lnItplL5zrmZp2zORsVVqtAKij7zsyNy202
         BS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ooswFgMeNsythX+/qBR9OI9wHD8VXSogRNh49IYd+vE=;
        b=hPUDzCX3nh2LcBWPIGIH0MSt+B7K4oNLg0WQN1l27Um9UiQUhUBPSywwZO5b5cV+zo
         c8ktMRVVrUzezp5g5nFn9GlRER40QdikpusgW0yvjgXvnoeNY1NYwYmjOrFucq5JDhb5
         26uIF8/YkuToNfDQ6SMpMb8T9OwlXpKTwqGp2qvgNfknekVVTmqAkjUtQwl4VtU2oL6N
         UCGpjuIHc4jxg/AQyjhfk30AJgK0FyqrYFXZKVT9xnTVOnbtc5HRQOUqqNm3BYn0PR4B
         GGadVfNNwCwSIBWotPJ2o4VOBa+/4SRfFoR89TMPAx1y6TI+Z3LNwP3ctFOw1yFdypNf
         nhnw==
X-Gm-Message-State: AOAM532OhpS5DQ8a0Q8mgcH1pkKCOwglNTg6y/JOwWQUuVYRw3qM0ZSP
        M+6kf6Id3aWlCRccwq1R1qU=
X-Google-Smtp-Source: ABdhPJx+0w/r2ANa+MyhWxUwMSefLxlFOlxg8tuoxRyPq12IKJg2uIu3nMgzjUWqFu5c69BDJ5JMNA==
X-Received: by 2002:aa7:8a87:0:b029:19a:8ccd:895 with SMTP id a7-20020aa78a870000b029019a8ccd0895mr4296277pfc.61.1606429672885;
        Thu, 26 Nov 2020 14:27:52 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id 16sm7171088pjf.36.2020.11.26.14.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 14:27:50 -0800 (PST)
Date:   Fri, 27 Nov 2020 09:27:47 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20201126222710.GJ163610@balbir-desktop>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-11-joel@joelfernandes.org>
 <20201122224123.GE110669@balbir-desktop>
 <20201124183038.GG1021337@google.com>
 <20201125230519.GC163610@balbir-desktop>
 <20201126082914.GE2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126082914.GE2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 09:29:14AM +0100, Peter Zijlstra wrote:
> On Thu, Nov 26, 2020 at 10:05:19AM +1100, Balbir Singh wrote:
> > > @@ -5259,7 +5254,20 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> > >  			 * Optimize the 'normal' case where there aren't any
> > >  			 * cookies and we don't need to sync up.
> > >  			 */
> > > -			if (i == cpu && !need_sync && !p->core_cookie) {
> > > +			if (i == cpu && !need_sync) {
> > > +				if (p->core_cookie) {
> > > +					/*
> > > +					 * This optimization is only valid as
> > > +					 * long as there are no cookies
> > 
> > This is not entirely true, need_sync is a function of core cookies, so I
> > think this needs more clarification, it sounds like we enter this when
> > the core has no cookies, but the task has a core_cookie? The term cookie
> > is quite overloaded when used in the context of core vs task.
> 
> Nah, its the same. So each task gets a cookie to identify the 'group' of
> tasks (possibly just itself) it is allowed to share a core with.
> 
> When we to core task selection, the core gets assigned the cookie of the
> group it will run, same thing.
> 
> > Effectively from what I understand this means that p wants to be
> > coscheduled, but the core itself is not coscheduling anything at the
> > moment, so we need to see if we should do a sync and that sync might
> > cause p to get kicked out and a higher priority class to come in?
> 
> This whole patch is about eliding code-wide task selection when it is
> not required. IOW an optimization.
> 
> When there wasn't a core cookie (IOW, the previous task selection wasn't
> core wide and limited) and the task we just selected for our own CPU
> also didn't have a cookie (IOW it doesn't have to be core-wide) we can
> skip the core wide task selection and schedule just this CPU and call it
> a day.
> 
> The logic was subtly wrong, this patch fixes it. A next patch completely
> rewrites it again to make it far simpler again. Don't spend time trying
> to understand this patch (unless you're _that_ kind of person ;-) but
> instead apply the whole thing and look at the resulting pick_next_task()
> function.

Thanks, I'll look at the git tree and see what the final outcome looks like.

Balbir Singh.

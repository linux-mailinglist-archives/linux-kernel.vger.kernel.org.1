Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FC42D0667
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 18:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgLFRuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 12:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgLFRuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 12:50:02 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CB4C0613D1
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 09:49:22 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id l7so78178qvt.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 09:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gzJEJ2dEDTrldVi59CiJKB5cjSGxuxrAJTrBTsWJ8L4=;
        b=xhRjVvrx+ML/hOjj4pqL3dvycyWq23E/cwFwypDKFEO6EisazRfTprUqynuZOi/5+P
         3vJapBTW2QUs1F+AzwvlQK8O/99OZEc8qIsUtKcYsOP7IghXkB5gJqKYMmIER1r/Rsmi
         YYvQvXGoN+FhrC6595APtSPtMnKO0uZ6qCDJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gzJEJ2dEDTrldVi59CiJKB5cjSGxuxrAJTrBTsWJ8L4=;
        b=iWnCNozZSRXxoastJzWNTWH0+VQJ0OSK4FyWz7SyB7dLj7FHfOyP6fafe6XhX1HH2p
         s0ubj2LQyCIEhG3NYKWxUzHO0Q9Gb4Fx8yYb1fHMBxiz8zjH4KEZwSVPKhlIph9SVWMC
         Grfeb1VSp6ANKsrLkByndTkBU5gzaejvq8LfHS+DBx+GrFPlcrRdLU4Ev4hHDjU1N6fI
         EQoGKvGewbD7yilyMfOZfJibrqLLqG3wzTa9f9nQ21HvYfrXMbYkYeyIedP8kAz+Yh1u
         /bYE+kHsdLJ/WsY9ccp8G8USbzsgYDkPDeIdsoyQGvkrb3l9b5DP6sClG1gUYJvzYuLY
         WH2Q==
X-Gm-Message-State: AOAM532dm1dDV+A+ICLNys5CUtJTyFn9tuJZGj21bAvXJGoZ/iLg4osV
        NO2cSllf6NwQEKPVIJdQcJOcPQ==
X-Google-Smtp-Source: ABdhPJw/qI6mI0IwIgY1ry4MTHKhqVsrq0WMHy9GSrTbnTHGwKWd8klYefdT5Mxp9E/1acKp0FATGA==
X-Received: by 2002:a0c:8d47:: with SMTP id s7mr17087856qvb.17.1607276961265;
        Sun, 06 Dec 2020 09:49:21 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id 6sm85621qko.3.2020.12.06.09.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 09:49:20 -0800 (PST)
Date:   Sun, 6 Dec 2020 12:49:19 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20201206174919.GD201514@google.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-23-joel@joelfernandes.org>
 <20201125111014.GS2414@hirez.programming.kicks-ass.net>
 <20201201192028.GA222419@google.com>
 <20201201193451.GY3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201193451.GY3040@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Dec 01, 2020 at 08:34:51PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 01, 2020 at 02:20:28PM -0500, Joel Fernandes wrote:
> > On Wed, Nov 25, 2020 at 12:10:14PM +0100, Peter Zijlstra wrote:
> > > On Tue, Nov 17, 2020 at 06:19:52PM -0500, Joel Fernandes (Google) wrote:
> > > > +void sched_core_tag_requeue(struct task_struct *p, unsigned long cookie, bool group)
> > > > +{
> > > > +	if (!p)
> > > > +		return;
> > > > +
> > > > +	if (group)
> > > > +		p->core_group_cookie = cookie;
> > > > +	else
> > > > +		p->core_task_cookie = cookie;
> > > > +
> > > > +	/* Use up half of the cookie's bits for task cookie and remaining for group cookie. */
> > > > +	p->core_cookie = (p->core_task_cookie <<
> > > > +				(sizeof(unsigned long) * 4)) + p->core_group_cookie;
> > > 
> > > This seems dangerous; afaict there is nothing that prevents cookie
> > > collision.
> > 
> > This is fixed in a later patch by Josh "sched: Refactor core cookie into
> > struct" where we are having independent fields for each type of cookie.
> 
> So I don't think that later patch is right... That is, it works, but
> afaict it's massive overkill.
> 
> 	COOKIE_CMP_RETURN(task_cookie);
> 	COOKIE_CMP_RETURN(group_cookie);
> 	COOKIE_CMP_RETURN(color);
> 
> So if task_cookie matches, we consider group_cookie, if that matches we
> consider color.

Yes, the cookie is a compound one. A cookie structure is created here which
has all 3 components. The final cookie value is a pointer to this compound
structure.

> 
> Now, afaict that's semantically exactly the same as just using the
> narrowest cookie. That is, use the task cookie if there is, and then,
> walking the cgroup hierarchy (up) pick the first cgroup cookie.
[..]
> Which means you only need a single active cookie field.

Its not the same. The "compounded" cookie is needed to enforce the CGroup
delegation model. This is exactly how both uclamp and cpusets work. For
uclamp, if we take uclamp.min as an example, if the CGroup sets the
uclamp.min of a group to 0, then even if you use the per-task interface
(sched_setattr) for setting the task's clamp - the "effective uclamp.min" of
the task as seen in /proc/pid/sched will still be 0.

Similar thing here, if 2 tasks belong to 2 different CGroups and each group is
tagged with its own tag, then if you use the per-task interface to make the 2
tasks share a core, the "effective" sharing is still such that the tasks will
not share a core -- because the CGroup decided to make it so.

I would like to really maintain this model. Doing it any other way is
confusing - we have already discussed doing it this way before. With that way
you end up failing one interface if another one was already used.  Been
there, done that. It sucks a lot.

> IOW, you're just making things complicated and expensive.

The cost of the additional comparisons you mentioned is only in the slow path
(i.e. when someone joins or leaves a group). Once the task_struct's cookie
field is set, the cost is not any more than what it was before.

Any other thoughts?

thanks,

 - Joel


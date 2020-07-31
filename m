Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F66233CC3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 03:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbgGaBIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 21:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgGaBIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 21:08:18 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BD4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 18:08:17 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g26so27499243qka.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 18:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3NSWs9fH3ytbI2URqAjwjgMkPSY0dsXW9CcGF1uVSTI=;
        b=DCUEZCahWBQ5se4Wb6FtpTcpX+5HPU2uiktMcETLlzHbgFhchKEKxGoLDkatpBUQLA
         XtBq8yUxSEf71uywH1azt0L+QvPF9+WfyY+Ja/MCLUrvVXeCoaOu90v0vfWzLGrprQYi
         pLXeamdNC/tLaB7Bx+uSqdMCrWIdTAO7aXBMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3NSWs9fH3ytbI2URqAjwjgMkPSY0dsXW9CcGF1uVSTI=;
        b=lLVCFsCYlmIw/Xyn1liVyxGnCVd92uG/9QjqBHmWoxuyNC9gmtiBrviGYIDuPUPap1
         ROi0KF9t3XUlOgSa3ECo3TAjAJc23tkgl6Qeol9Ly2wBz3ByB3QMTNJHKF2YBSH8iIgJ
         xiaRkHSLDIusXVnnbN7o/AkPUDVRyKbgFUJ7yNIcMi0Bj5TFZQ3gWAzWtyUxOl4oZ6Ex
         VPloWZ298D2pp9wLJUKVn5cenIyvG/O+fGqAvXxbcvFCccGJVwb7Bp4JMAt9G4/L9zGq
         s+ZyzmsphzleoKonufDGqJo6T/azMlOrZXqVhNBQ9w0QrF94tHNJQKcc9LlJ/Yun/0aT
         rh/Q==
X-Gm-Message-State: AOAM531ZKbNAsy2nXIDDALNl3mPZJAkrp09omXq1vlA91jJVVjTGN2F9
        1QWRU2wsdARNXJlEblFdTyyoYg==
X-Google-Smtp-Source: ABdhPJyI0U9a+U+KQLY9JC7zCCP5+BKjTz7MSwV6GQuNCL70d4kspvRYMyOcL0oSfnx2+5yiLh5iCw==
X-Received: by 2002:a37:8905:: with SMTP id l5mr1817785qkd.302.1596157697129;
        Thu, 30 Jul 2020 18:08:17 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id n68sm6179466qkd.89.2020.07.30.18.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 18:08:16 -0700 (PDT)
Date:   Thu, 30 Jul 2020 21:08:16 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/2] rcu/tree: Add a warning if CPU being onlined did not
 report QS already
Message-ID: <20200731010816.GB2336096@google.com>
References: <20200730030221.705255-1-joel@joelfernandes.org>
 <20200730162159.GZ9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730162159.GZ9247@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 09:21:59AM -0700, Paul E. McKenney wrote:
> On Wed, Jul 29, 2020 at 11:02:20PM -0400, Joel Fernandes (Google) wrote:
> > Add a warning if CPU being onlined did not report QS already. This is to
> > simplify the code in the CPU onlining path and also to make clear about
> > where QS is reported. The act of QS reporting in CPU onlining path is
> > is likely unnecessary as shown by code reading and testing with
> > rcutorture's TREE03 and hotplug parameters.
> 
> How about something like this for the commit log?
> 
> ------------------------------------------------------------------------
> 
> Currently, rcu_cpu_starting() checks to see if the RCU core expects a
> quiescent state from the incoming CPU.  However, the current interaction
> between RCU quiescent-state reporting and CPU-hotplug operations should
> mean that the incoming CPU never needs to report a quiescent state.
> First, the outgoing CPU reports a quiescent state if needed.  Second,
> the race where the CPU is leaving just as RCU is initializing a new
> grace period is handled by an explicit check for this condition.  Third,
> the CPU's leaf rcu_node structure's ->lock serializes these checks.
> 
> This means that if rcu_cpu_starting() ever feels the need to report
> a quiescent state, then there is a bug somewhere in the CPU hotplug
> code or the RCU grace-period handling code.  This commit therefore
> adds a WARN_ON_ONCE() to bring that bug to everyone's attention.

Wow, this is so well written. I certainly need to up my writing game a bitt.
But yes, this is flawless explanation and really will help people reading it
in the future.

I will make the change to my tree for the next revision.

thanks,

 - Joel


> ------------------------------------------------------------------------
> 
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > ---
> >  kernel/rcu/tree.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 65e1b5e92319..1e51962b565b 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3996,7 +3996,19 @@ void rcu_cpu_starting(unsigned int cpu)
> >  	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
> >  	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
> >  	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
> > -	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
> > +
> > +	/*
> > +	 * Delete QS reporting from here, by June 2021, if warning does not
> > +	 * fire. Let us make the rules for reporting QS for an offline CPUs
> > +	 * more explicit. The CPU onlining path does not need to report QS for
> > +	 * an offline CPU. Either the QS should have reported during CPU
> > +	 * offlining, or during rcu_gp_init() if it detected a race with either
> > +	 * CPU offlining or task unblocking on previously offlined CPUs. Note
> > +	 * that the FQS loop also does not report QS for an offline CPU any
> > +	 * longer (unless it splats due to an offline CPU blocking the GP for
> > +	 * too long).
> > +	 */
> 
> Let's leave at least the WARN_ON_ONCE() indefinitely.  If you don't
> believe me, remove this code in your local tree, have someone give you
> several branches, some with bugs injected, and then try to figure out
> which have the bugs and then try to find those bugs.
> 
> This is not a fastpath, so the overhead of the check is not a concern.
> Believe me, the difficulty of bug location without this check is a very
> real concern!  ;-)
> 
> On the other hand, I fully agree with the benefits of documenting the
> design rules.  But is this really the best place to do that from the
> viewpoint of someone who is trying to figure out how RCU works?
> 
> 							Thanx, Paul
> 
> > +	if (WARN_ON_ONCE(rnp->qsmask & mask)) { /* RCU waiting on incoming CPU? */
> >  		rcu_disable_urgency_upon_qs(rdp);
> >  		/* Report QS -after- changing ->qsmaskinitnext! */
> >  		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
> > -- 
> > 2.28.0.rc0.142.g3c755180ce-goog
> > 

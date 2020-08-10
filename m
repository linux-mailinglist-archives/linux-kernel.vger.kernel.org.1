Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F93240C29
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 19:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgHJRjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 13:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgHJRjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 13:39:33 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC9CC061787
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 10:39:33 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 77so9129507qkm.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 10:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=odtbjLOyfHsipZbsXpYCdAhx77Tu3DM5hEyhcqjQE8Q=;
        b=jZ1WNwl50OjaPAZEG0DC+3AM6MPFVxZfSNNpfZLUBAnXqHCSMLVyM3mA6DQK3/simx
         I1xHJpmrN3EqyRapLOr6VeMJ6WEMqMCncQhx67RrODWuwhf3t7fGup0nuLO1nkozGGOh
         6zQoZzaDq0t9b//lPHDb4ZQ7hxXg9msIxfq0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=odtbjLOyfHsipZbsXpYCdAhx77Tu3DM5hEyhcqjQE8Q=;
        b=O4R3XEexvZ1sorUXVvpvdpo6Ak/mAN7A9xWm170Jq4l+QWElUFDWcOIxKiYknKxMR1
         vc7FanDaaTahlcQPR+P9qBbG5IDLXb09PqfbJwTPoR49dSfooYqn1ip+CJ+fyKaWLvkB
         BgjpV6+7k77YIPGBzLjB1g2szCZAj8YWxTNKroRbwip8O1Uvi8sRAtLlQr5xUhPVTsOX
         BktjaAsWrM/n++ugZbuhrIe/bqFC7plATW4xh/owsP7r44h2lcjtG32DcSr7P2UFzh+U
         d7HcnjHl+zxVRKSffPps9zXqTImg2VLqH7G35gsB7vntcMAuqqs7zO56v7oloqamZMrO
         4s3Q==
X-Gm-Message-State: AOAM533psq/nCTSBtRTU+2bd7G9DRYMgX7sH79ctW+Hb5AWefdHtMyts
        NwB2GcsQWrDkwOqEVHN5+dWmig==
X-Google-Smtp-Source: ABdhPJxrGroOudNMfCH9xLr6CUl1e3ELqJa69irLSH2bf2vvLg02LYHUUhMC3RxjjyKekDNuNt2B3g==
X-Received: by 2002:a05:620a:11b4:: with SMTP id c20mr26595434qkk.233.1597081172546;
        Mon, 10 Aug 2020 10:39:32 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id l29sm4693457qtu.88.2020.08.10.10.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 10:39:31 -0700 (PDT)
Date:   Mon, 10 Aug 2020 13:39:31 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        peterz@infradead.org, Randy Dunlap <rdunlap@infradead.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de, vineethrp@gmail.com
Subject: Re: [PATCH v4 1/5] rcu/tree: Add a warning if CPU being onlined did
 not report QS already
Message-ID: <20200810173931.GB2253395@google.com>
References: <20200807170722.2897328-1-joel@joelfernandes.org>
 <20200807170722.2897328-2-joel@joelfernandes.org>
 <20200810154654.GJ4295@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810154654.GJ4295@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 08:46:54AM -0700, Paul E. McKenney wrote:
> On Fri, Aug 07, 2020 at 01:07:18PM -0400, Joel Fernandes (Google) wrote:
> > Currently, rcu_cpu_starting() checks to see if the RCU core expects a
> > quiescent state from the incoming CPU.  However, the current interaction
> > between RCU quiescent-state reporting and CPU-hotplug operations should
> > mean that the incoming CPU never needs to report a quiescent state.
> > First, the outgoing CPU reports a quiescent state if needed.  Second,
> > the race where the CPU is leaving just as RCU is initializing a new
> > grace period is handled by an explicit check for this condition.  Third,
> > the CPU's leaf rcu_node structure's ->lock serializes these checks.
> > 
> > This means that if rcu_cpu_starting() ever feels the need to report
> > a quiescent state, then there is a bug somewhere in the CPU hotplug
> > code or the RCU grace-period handling code.  This commit therefore
> > adds a WARN_ON_ONCE() to bring that bug to everyone's attention.
> > 
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 65e1b5e92319..a49fa3b60faa 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3996,7 +3996,14 @@ void rcu_cpu_starting(unsigned int cpu)
> >  	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
> >  	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
> >  	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
> > -	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
> > +
> > +	/*
> > +	 * XXX: The following rcu_report_qs_rnp() is redundant. If the below
> > +	 * warning does not fire, consider replacing it with the "else" block,
> > +	 * by June 2021 or so (while keeping the warning). Refer to RCU's
> > +	 * Requirements documentation for the rationale.
> 
> Let's suppose that this change is made, and further that in a year or
> two the "if" statement below is replaced with its "else" block.
> 
> Now let's suppose that (some years after that) a hard-to-trigger bug
> makes its way into RCU's CPU-hotplug code that would have resulted in
> the WARN_ON_ONCE() triggering, but that this bug turns out to be not so
> hard to trigger in certain large production environments.
> 
> Let's suppose further that you have moved on to where you are responsible
> for one of these large production environments.  How would this
> hypothetical RCU/CPU-hotplug bug manifest?

It could manifest as an RCU stall (after the warning triggers) since RCU
would wait forever.

Were you thinking it is not worth doing this? I thought we wanted to remove
the reundant rcu_report_qs_rnp here to solidify everyone's understanding of
the code and fail early if there's something misunderstood (since such
misunderstanding could mean there are other hidden bugs somewhere). The
counter-argument to that being, making the code robust is more important for
the large production failure scenario where failures are costly.

thanks,

 - Joel


> 							Thanx, Paul
> 
> > +	 */
> > +	if (WARN_ON_ONCE(rnp->qsmask & mask)) { /* RCU waiting on incoming CPU? */
> >  		rcu_disable_urgency_upon_qs(rdp);
> >  		/* Report QS -after- changing ->qsmaskinitnext! */
> >  		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
> > -- 
> > 2.28.0.236.gb10cc79966-goog
> > 

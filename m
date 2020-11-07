Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF3E2AA1C6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 01:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgKGA0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 19:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgKGA0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 19:26:06 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78236C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 16:26:06 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id l2so2841482qkf.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 16:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KFCIKOtr8D20sOqDg+VtqMdBmuE8IZF7YxjxZvbO66w=;
        b=wXIYaB5JyJigBToTrk98QDXEreKm1YQNF4z1vvaZ9Pn7oLWmVqoiIIv2NXNNEK/vQ8
         oRkZJF7/bBYDbqGiS6+8qr9gEYnYaJzQyOc1biqlp21w504HrMaVbsQwuu/NIT6t+nb9
         FNgBvkSQr3O09VEMu9WvKxdEwwxPqowuxsrkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KFCIKOtr8D20sOqDg+VtqMdBmuE8IZF7YxjxZvbO66w=;
        b=jdO/cpsW4K20oRM4YuYf813CQ3kk5IcUVGjA3PBIBA0k0kgSLrbEcG1b8cPMpGz6ef
         PpElJJc5ug9GIzg4X75kZ+xcxPcJGcvCIL05677COvyhrzERzYxp8UEU722G4kvyazyC
         Bwp/Uh00qqqcWb+fktQaSXVaBQ5kkwKHitY+C536Sonrr8zJq2hbQlaBJM/HAkBFll4x
         9goPTjOMShrAelNKQvrBmDQUt2A/v/kJLenFibdAiRAqhLgrXUbLwmxobRh2dhOfEtqj
         eXED/i0evAGaKLqrXXJ8UnbKY2txS3BCYHKFHeGL+WGYMsT8sHjNjpFSFjrobA6KVe4I
         MOnA==
X-Gm-Message-State: AOAM530CX6psDkKhUk96EET8XET8yfya/WZDzBvwzaUQM9KYKJXEAcvr
        15eDA6xMFYjD2Btm8o7FID8/FmP1w4xCrA==
X-Google-Smtp-Source: ABdhPJyum+mcyXtTNBUZ8+Q8jvp4zJe7+aynEnSfGy66hxWa7tp7Wq3eaKUJWHBuUe1UVVUlHhlnuQ==
X-Received: by 2002:a05:620a:951:: with SMTP id w17mr4470185qkw.224.1604708765505;
        Fri, 06 Nov 2020 16:26:05 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id x7sm1534652qtw.76.2020.11.06.16.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 16:26:04 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:26:04 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v9 6/7] rcu/tree: segcblist: Remove redundant smp_mb()s
Message-ID: <20201107002604.GA3144506@google.com>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-7-joel@joelfernandes.org>
 <20201105035713.GL3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105035713.GL3249@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 07:57:13PM -0800, Paul E. McKenney wrote:
> On Tue, Nov 03, 2020 at 09:26:02AM -0500, Joel Fernandes (Google) wrote:
> > This memory barrier is not needed as rcu_segcblist_add_len() already
> > includes a memory barrier *before* and *after* the length of the list is
> > updated.
> > 
> > Same reasoning for rcu_segcblist_enqueue().
> 
> I suggest a commit log like the following:
> 
> ------------------------------------------------------------------------
> 
> The full memory barriers in rcu_segcblist_enqueue() and in rcu_do_batch()
> are not needed because rcu_segcblist_add_len(), and thus also
> rcu_segcblist_inc_len(), already includes a memory barrier *before*
> and *after* the length of the list is updated.
> 
> This commit therefore removes these redundant smp_mb() invocations.
> 
> ------------------------------------------------------------------------
> 
> Other than that, looks good!  I could hand-apply it, but that
> would just cause more churn with the addition of the call to
> rcu_segcblist_inc_seglen().  So could you please update the commit log
> when you repost, whether to the mailing list or from your git tree?

Done, I updated it in my tree. I will share the link to tree on IRC.

thanks,

 - Joel

> 
> 							Thanx, Paul
> 
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/rcu_segcblist.c | 1 -
> >  kernel/rcu/tree.c          | 1 -
> >  2 files changed, 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > index e9e72d72f7a6..d96272e8d604 100644
> > --- a/kernel/rcu/rcu_segcblist.c
> > +++ b/kernel/rcu/rcu_segcblist.c
> > @@ -268,7 +268,6 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
> >  			   struct rcu_head *rhp)
> >  {
> >  	rcu_segcblist_inc_len(rsclp);
> > -	smp_mb(); /* Ensure counts are updated before callback is enqueued. */
> >  	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
> >  	rhp->next = NULL;
> >  	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index f6c6653b3ec2..fb2a5ac4a59c 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2525,7 +2525,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
> >  
> >  	/* Update counts and requeue any remaining callbacks. */
> >  	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
> > -	smp_mb(); /* List handling before counting for rcu_barrier(). */
> >  	rcu_segcblist_add_len(&rdp->cblist, -count);
> >  
> >  	/* Reinstate batch limit if we have worked down the excess. */
> > -- 
> > 2.29.1.341.ge80a0c044ae-goog
> > 

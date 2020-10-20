Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE2B28E340
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389338AbgJNPZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389296AbgJNPZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:25:32 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E032C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:25:32 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id 67so5582193iob.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lj23fkBrWgQQV2uv5dmUJCoeuFPxGhWb4VA8o7QSou0=;
        b=tiCzEqAV4OuHULVTPIE9RRFa/BgHeTIhILEan/i1ZZjsUY/WslzmhrfgQ41yoAiD9i
         I8yu/HoB3I8stunY9tC623Zb8My08veqDS9/t9h72PCIpP27sfoMveDH86/LWPSQseiI
         FIPB75avpOlUrdX0K5pPj67DSBdqBDesB4E/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lj23fkBrWgQQV2uv5dmUJCoeuFPxGhWb4VA8o7QSou0=;
        b=LZ0dgKNJfxmO0d/6UcQSxsiwPVACXZRSeNqtO18kfZjIHOUavROh6cDCt6n5uefinK
         YAdKz7hcrFk4zVJK5LbHLdwsSU/WctHC+5TAhUGmqEKKFiUmxvOqbpIrpFByFxoXndsI
         L3cSpKhEe2l45quLa0i72iZt3zK6JkwYQSQ2Y31unUxBPryIghyVb1czHi8DJ2x/gmcE
         AG2NBnS6hCs+bkQ+3sB11eoFYh0P/RUsqZA6pqjj7OXnN960qW7E0bHZ+AwmdqX9j80W
         DzUvMpPzCPyifFxt+Da2QC02jYNCHbRYWS7mIiLB+ttDmf20HDssMBQKfJhzU7uiOnmF
         HwmQ==
X-Gm-Message-State: AOAM533l6CeV8RD0lIoXnJvzJBDtwpn5OzhX6kbyErY2Huz0SGwEDbvL
        2oMSNZsvv7GvnnwwawqceX1kfg==
X-Google-Smtp-Source: ABdhPJzvE7Gxg95F7TFRNx44E4P8RZ595W+1Q98IX0/aAw6/6pdhjqlsXwW5j35o5wiWU3++rrRCRg==
X-Received: by 2002:a02:9508:: with SMTP id y8mr3486911jah.15.1602689131368;
        Wed, 14 Oct 2020 08:25:31 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id r5sm2833582ioj.51.2020.10.14.08.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 08:25:30 -0700 (PDT)
Date:   Wed, 14 Oct 2020 11:25:30 -0400
From:   joel@joelfernandes.org
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH v6 2/4] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20201014152530.GB4021500@google.com>
References: <20200923152211.2403352-1-joel@joelfernandes.org>
 <20200923152211.2403352-3-joel@joelfernandes.org>
 <20201012232008.GA47577@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012232008.GA47577@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 01:20:08AM +0200, Frederic Weisbecker wrote:
> On Wed, Sep 23, 2020 at 11:22:09AM -0400, Joel Fernandes (Google) wrote:
> > +/* Return number of callbacks in a segment of the segmented callback list. */
> > +static void rcu_segcblist_add_seglen(struct rcu_segcblist *rsclp, int seg, long v)
> > +{
> > +#ifdef CONFIG_RCU_NOCB_CPU
> > +	smp_mb__before_atomic(); /* Up to the caller! */
> > +	atomic_long_add(v, &rsclp->seglen[seg]);
> > +	smp_mb__after_atomic(); /* Up to the caller! */
> > +#else
> > +	smp_mb(); /* Up to the caller! */
> > +	WRITE_ONCE(rsclp->seglen[seg], rsclp->seglen[seg] + v);
> > +	smp_mb(); /* Up to the caller! */
> > +#endif
> > +}
> 
> I know that these "Up to the caller" comments come from the existing len
> functions but perhaps we should explain a bit more against what it is ordering
> and what it pairs to.
> 
> Also why do we need one before _and_ after?
> 
> And finally do we have the same ordering requirements than the unsegmented len
> field?

Hi Paul and Neeraj,
Would be nice to discuss this on the call. I actually borrowed the memory
barriers from add_len() just to be safe, but I think Frederic's points are
valid. Would be nice if we can go over all the usecases and discuss which
memory barriers are needed. Thanks for your help!

Another thought: inc_len() calls add_len() which already has smp_mb(), so
callers of inc_len also do not need memory barriers I think.

thanks,

 - Joel


> > +
> > +/* Move from's segment length to to's segment. */
> > +static void rcu_segcblist_move_seglen(struct rcu_segcblist *rsclp, int from, int to)
> > +{
> > +	long len;
> > +
> > +	if (from == to)
> > +		return;
> > +
> > +	len = rcu_segcblist_get_seglen(rsclp, from);
> > +	if (!len)
> > +		return;
> > +
> > +	rcu_segcblist_add_seglen(rsclp, to, len);
> > +	rcu_segcblist_set_seglen(rsclp, from, 0);
> > +}
> > +
> [...]
> > @@ -245,6 +283,7 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
> >  			   struct rcu_head *rhp)
> >  {
> >  	rcu_segcblist_inc_len(rsclp);
> > +	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
> >  	smp_mb(); /* Ensure counts are updated before callback is enqueued. */
> 
> Since inc_len and even now inc_seglen have two full barriers embracing the add up,
> we can probably spare the above smp_mb()?
> 
> >  	rhp->next = NULL;
> >  	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
> > @@ -274,27 +313,13 @@ bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
> >  	for (i = RCU_NEXT_TAIL; i > RCU_DONE_TAIL; i--)
> >  		if (rsclp->tails[i] != rsclp->tails[i - 1])
> >  			break;
> > +	rcu_segcblist_inc_seglen(rsclp, i);
> >  	WRITE_ONCE(*rsclp->tails[i], rhp);
> >  	for (; i <= RCU_NEXT_TAIL; i++)
> >  		WRITE_ONCE(rsclp->tails[i], &rhp->next);
> >  	return true;
> >  }
> >  
> > @@ -403,6 +437,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
> >  		if (ULONG_CMP_LT(seq, rsclp->gp_seq[i]))
> >  			break;
> >  		WRITE_ONCE(rsclp->tails[RCU_DONE_TAIL], rsclp->tails[i]);
> > +		rcu_segcblist_move_seglen(rsclp, i, RCU_DONE_TAIL);
> 
> Do we still need the same amount of full barriers contained in add() called by move() here?
> It's called in the reverse order (write queue then len) than usual. If I trust the comment
> in rcu_segcblist_enqueue(), the point of the barrier is to make the length visible before
> the new callback for rcu_barrier() (although that concerns len and not seglen). But here
> above, the unsegmented length doesn't change. I could understand a write barrier between
> add_seglen(x, i) and set_seglen(0, RCU_DONE_TAIL) but I couldn't find a paired couple either.
> 
> >  	}
> >  
> >  	/* If no callbacks moved, nothing more need be done. */
> > @@ -423,6 +458,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
> >  		if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL])
> >  			break;  /* No more callbacks. */
> >  		WRITE_ONCE(rsclp->tails[j], rsclp->tails[i]);
> > +		rcu_segcblist_move_seglen(rsclp, i, j);
> 
> Same question here (feel free to reply "same answer" :o)
> 
> Thanks!

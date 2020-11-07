Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E38A2AA1A4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 01:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgKGAFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 19:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbgKGAFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 19:05:35 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F618C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 16:05:35 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id n63so2080754qte.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 16:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JorTLQYfJmqKUvOKFo8KKJVtVEGA/9Yc7a4QfxtP1Lo=;
        b=o+89ZlxTW1nJ5BQd7qa2XH1DGDfxbEDia6wyJzH083Qv2aSev2juVUV88JQp5hkd5I
         EJilrpTPdgGPgJ+ByU5CNt7P78xCKqnEWstoF0y7W0eGRELTdxNHvxVm1fPpNR9Ux2k+
         2E9oUQTZwIxifM1LVM0C0nyUfsrucm9L9m1jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JorTLQYfJmqKUvOKFo8KKJVtVEGA/9Yc7a4QfxtP1Lo=;
        b=dFLEkgzI3ZEDnFxo5teosVJRQsd2JpFOTOTIPohLqdoRu5tNtFGxIbyZbuKrH7A/KE
         wcfSYU0wOjIihraAyNzJQ5HM8D2Zlv3qgh/itY+zSOc1/cK8Eb8B4B7YtzbI0Hhoxpok
         y/9j0s+b4Kyn1E5zcOdxPYM+smaHeBoJ2HhbEleWiOa+UyJUQlxuaz6fA6zJGkneVXpe
         4Y96Hkr+QP2cf80GbX5HhOsOUfU2pXz5Bz7RMWE1B2zqIrgE6PXMLMWlZ8awoP/ZWYo5
         APydDgIsXBkSsG3kMhjq7x8pu5budF/2Ch9zbUAwxpiwnqJacAiBqEDb2cx/XNAu7Yrx
         BvLA==
X-Gm-Message-State: AOAM530uCUPKEd4ljXMvGyNohR0prxf7GWrTpsWd0PfoVQT1WiwT0wMa
        6HkrcqLGvaGzPA+tBdGhT/huxw==
X-Google-Smtp-Source: ABdhPJxPCQLg9SA4ml8yJIvefMevgu24JnPmsyw88DCcDEU7GoWFoQkcYXpNISvIb0uW4UfPpYx1iw==
X-Received: by 2002:aed:22bc:: with SMTP id p57mr4087920qtc.242.1604707534667;
        Fri, 06 Nov 2020 16:05:34 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d48sm1682236qta.26.2020.11.06.16.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 16:05:33 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:05:33 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v9 4/7] rcu/trace: Add tracing for how segcb list changes
Message-ID: <20201107000533.GC1397669@google.com>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-5-joel@joelfernandes.org>
 <20201103151731.GB432431@lothringen>
 <20201104140807.GG3249@paulmck-ThinkPad-P72>
 <20201104143314.GC467220@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104143314.GC467220@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 03:33:14PM +0100, Frederic Weisbecker wrote:
> On Wed, Nov 04, 2020 at 06:08:07AM -0800, Paul E. McKenney wrote:
> > On Tue, Nov 03, 2020 at 04:17:31PM +0100, Frederic Weisbecker wrote:
> > > On Tue, Nov 03, 2020 at 09:26:00AM -0500, Joel Fernandes (Google) wrote:
> > > > +/*
> > > > + * Return how many CBs each segment along with their gp_seq values.
> > > > + *
> > > > + * This function is O(N) where N is the number of segments. Only used from
> > > > + * tracing code which is usually disabled in production.
> > > > + */
> > > > +#ifdef CONFIG_RCU_TRACE
> > > > +static void rcu_segcblist_countseq(struct rcu_segcblist *rsclp,
> > > > +			 int cbcount[RCU_CBLIST_NSEGS],
> > > > +			 unsigned long gpseq[RCU_CBLIST_NSEGS])
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
> > > > +		cbcount[i] = rcu_segcblist_get_seglen(rsclp, i);
> > > > +		gpseq[i] = rsclp->gp_seq[i];
> > > > +	}
> > > > +}
> > > > +
> > > > +void __trace_rcu_segcb_stats(struct rcu_segcblist *rsclp, const char *context)
> > > > +{
> > > > +	int cbs[RCU_CBLIST_NSEGS];
> > > > +	unsigned long gps[RCU_CBLIST_NSEGS];
> > > > +
> > > > +	if (!trace_rcu_segcb_stats_enabled())
> > > > +		return;
> > > 
> > > Yes, very good!
> > > 
> > > Paul just told me that RCU_TRACE can be used in production so that confirms that we
> > > wanted to avoid this loop of 8 iterations when tracing is disabled.
> > 
> > RCU's "don't try this in production" Kconfig option is PROVE_RCU.
> > 
> > I would be looking for checks that the sum of the segment lengths
> > match the overall ->len or checks that all of the segment lengths
> > are zero when ->cblist is empty to be guarded by something like
> > IS_ENABLED(CONFIG_PROVE_RCU).  Of course, checks of this sort need to
> > be confined to those portions of rcu_do_batch() that are excluding other
> > accesses to ->cblist.
> 
> Right.
> 
> > 
> > But if rcu_segcblist_countseq() is invoked only when a specific trace
> > event is enabled, it should be OK to have it guarded only by RCU_TRACE.
> 
> Indeed, so I think we are good.

Thanks, so the only changes are to patches 2/7 and 4/7 which I will work on.
1/7 was already taken by Paul. For 7/7, it sounds like I did not understand
Paul's reworks on the comments and we're still discussing it; but some
comments are better than none, so I am Ok with Pauls version of it.

thanks,

 - Joel


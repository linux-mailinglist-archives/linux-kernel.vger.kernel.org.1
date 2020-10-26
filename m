Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B257298C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 12:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773795AbgJZL3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 07:29:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1771749AbgJZL3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 07:29:00 -0400
Received: from localhost (unknown [176.177.109.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1EB722263;
        Mon, 26 Oct 2020 11:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603711740;
        bh=zJ7XyYSVCAPouO33DFnMP7X1CmubkeNekzhvy9XpCqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IQVWFd9RJxCAJzfkVoE8YaP+S0n6bMz2uho1yvgl4cExEqKwu5MXwFiI4vkyoxRm8
         q6Gz4n3IEfvsuzeqCceeJwH7EEHlzro8cpalFjRTK3u3V0L98QL95b0/mI8PG2ZfkE
         RuRN1KL6K2l/2XFC0p4MXQ3+K2qmoTYG52r7Lp6A=
Date:   Mon, 26 Oct 2020 12:28:57 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v8 2/6] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20201026112857.GD104441@lothringen>
References: <20201021190813.3005054-1-joel@joelfernandes.org>
 <20201021190813.3005054-3-joel@joelfernandes.org>
 <20201026005058.GB104441@lothringen>
 <20201026054557.GB4192074@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026054557.GB4192074@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 01:45:57AM -0400, Joel Fernandes wrote:
> On Mon, Oct 26, 2020 at 01:50:58AM +0100, Frederic Weisbecker wrote:
> > On Wed, Oct 21, 2020 at 03:08:09PM -0400, Joel Fernandes (Google) wrote:
> > >  bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
> > >  {
> > > -	int i;
> > > +	int i, j;
> > >  
> > >  	WARN_ON_ONCE(!rcu_segcblist_is_enabled(rsclp));
> > >  	if (rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL))
> > > @@ -487,6 +508,10 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
> > >  	if (rcu_segcblist_restempty(rsclp, i) || ++i >= RCU_NEXT_TAIL)
> > >  		return false;
> > >  
> > > +	/* Accounting: everything below i is about to get merged into i. */
> > > +	for (j = i + 1; j <= RCU_NEXT_TAIL; j++)
> > > +		rcu_segcblist_move_seglen(rsclp, j, i);
> > > +
> > 
> > Can you perhaps reuse the below loop to move the seglen?
> 
> Not easily, because we will need to store 'i' into another variable then, which
> does not change.
> 
> Besides IMHO, the code is more readable with the loops separated.

Works for me.

Thanks!

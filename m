Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D752275BDD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIWPbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:31:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWPbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:31:35 -0400
Received: from localhost (lfbn-ncy-1-588-162.w81-51.abo.wanadoo.fr [81.51.203.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F7AA2137B;
        Wed, 23 Sep 2020 15:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600875094;
        bh=kogvChBA6ucpox5ZjU7zawms+7A4iz7F99P2hBr4zPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kjj6ScOJa6KIF62QuWU1nJ8sEjbQbPU7nPW3jt3/SIVz22BQkpXkwHZkjTOGx8ZXn
         /1LOcQUmc2qMa+DHvSvRJJr3yn1K2qWT+H7PCV+4hRpNXWZJh7P39SbuFnfJUkZ9V6
         XXWo2adFlv/VM1aOYXLrYQxu+5jKQTxaatxWvYWE=
Date:   Wed, 23 Sep 2020 17:31:32 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC PATCH 05/12] rcu: De-offloading GP kthread
Message-ID: <20200923153131.GD31465@lenoir>
References: <20200921124351.24035-1-frederic@kernel.org>
 <20200921124351.24035-6-frederic@kernel.org>
 <20200922001015.GO29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922001015.GO29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 05:10:15PM -0700, Paul E. McKenney wrote:
> On Mon, Sep 21, 2020 at 02:43:44PM +0200, Frederic Weisbecker wrote:
> > @@ -2292,6 +2340,7 @@ void __init rcu_init_nohz(void)
> >  			rcu_segcblist_init(&rdp->cblist);
> >  		rcu_segcblist_offload(&rdp->cblist, true);
> >  		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_CB);
> > +		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_GP);
> 
> OK, I will bite at this nit...
> 
> Why not "SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP"?

That spared a broken line :o)

But you're right, I'll do that.

> 
> 							Thanx, Paul
> 
> >  	}
> >  	rcu_organize_nocb_kthreads();
> >  }
> > -- 
> > 2.28.0
> > 

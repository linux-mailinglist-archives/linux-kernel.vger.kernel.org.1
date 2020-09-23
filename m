Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39CB275C5D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgIWPsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:48:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgIWPsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:48:22 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 146B32223E;
        Wed, 23 Sep 2020 15:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600876102;
        bh=t5k+CrtHEuTdc9KT64dhlTTK7alfZ3rk49pn7rAHNFE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KarXA3jlUcFQGZIkymzn6b3Kz863fo0JiM7FC6/QJe6ObldEWRTax3D1oe7eTaGdd
         IGiExWTRiKrmOnh9K58cA0HjYwN2HWGa+1fl788pkrBbQCHO9X8XmjDahp48cqJOmr
         jSfqrUv8nz9bz3hVnlkLZjswDucexniGmO+/Qedw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DB62D35226CB; Wed, 23 Sep 2020 08:48:21 -0700 (PDT)
Date:   Wed, 23 Sep 2020 08:48:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC PATCH 05/12] rcu: De-offloading GP kthread
Message-ID: <20200923154821.GR29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200921124351.24035-1-frederic@kernel.org>
 <20200921124351.24035-6-frederic@kernel.org>
 <20200922001015.GO29330@paulmck-ThinkPad-P72>
 <20200923153131.GD31465@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923153131.GD31465@lenoir>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 05:31:32PM +0200, Frederic Weisbecker wrote:
> On Mon, Sep 21, 2020 at 05:10:15PM -0700, Paul E. McKenney wrote:
> > On Mon, Sep 21, 2020 at 02:43:44PM +0200, Frederic Weisbecker wrote:
> > > @@ -2292,6 +2340,7 @@ void __init rcu_init_nohz(void)
> > >  			rcu_segcblist_init(&rdp->cblist);
> > >  		rcu_segcblist_offload(&rdp->cblist, true);
> > >  		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_CB);
> > > +		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_GP);
> > 
> > OK, I will bite at this nit...
> > 
> > Why not "SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP"?
> 
> That spared a broken line :o)
> 
> But you're right, I'll do that.

Either way is fine, just curious.  Your choice!

							Thanx, Paul

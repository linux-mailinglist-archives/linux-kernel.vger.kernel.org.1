Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED461EE516
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 15:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgFDNOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 09:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgFDNOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:14:11 -0400
Received: from localhost (lfbn-ncy-1-324-171.w83-196.abo.wanadoo.fr [83.196.159.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BB2E206C3;
        Thu,  4 Jun 2020 13:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591276451;
        bh=wQgVns7AYqWR4w7SQT/eBFlehH8s1tQ6Y1+38K2sstQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gF3vCuB1NL9722USg+0cpVofl1MvmbqORPkJ1wEBNE06D+iefH4BwIXz7/sX8MF/n
         aXB9/h62EaMkRG/aZ2PuIxBzYtTtAkHGMPa6qkXB3Q/OVabQWmnMMUbVJlxXTnwHni
         fYA9tWXeSWHBlS9gFaOYfE3etMALS3jd9ySS40Ps=
Date:   Thu, 4 Jun 2020 15:14:09 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 08/10] rcu: Allow to deactivate nocb on a CPU
Message-ID: <20200604131409.GB27571@lenoir>
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-9-frederic@kernel.org>
 <20200526212017.GE76276@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526212017.GE76276@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 05:20:17PM -0400, Joel Fernandes wrote:
> On Wed, May 13, 2020 at 06:47:12PM +0200, Frederic Weisbecker wrote:
> > Allow a CPU's rdp to quit the callback offlined mode.
> 
> nit: s/offlined/offloaded/ ?

Oh, looks like I did that everywhere :)

> 
> > The switch happens on the target with IRQs disabled and rdp->nocb_lock
> > held to avoid races between local callbacks handling and kthread
> > offloaded callbacks handling.
> > nocb_cb kthread is first parked to avoid any future race with
> > concurrent rcu_do_batch() executions. Then the cblist is set to offloaded
> > so that the nocb_gp kthread ignores this rdp.
> 
> nit: you mean cblist is set to non-offloaded mode right?

Ah right!

> > +static void __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
> > +{
> > +	unsigned long flags;
> > +	struct rcu_node *rnp = rdp->mynode;
> > +
> > +	printk("De-offloading %d\n", rdp->cpu);
> 
> nit: s/printk/pr_debug/ ?

Ok.

Thanks!

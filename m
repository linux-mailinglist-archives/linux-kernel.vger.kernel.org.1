Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F095244C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 17:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgHNP0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 11:26:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgHNP0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 11:26:24 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02285207DA;
        Fri, 14 Aug 2020 15:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597418784;
        bh=BuFd0GUohYMykV0bEdLt1waKCKM21ZGzCtbhCO68IFc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IIINUl+lN73fm93kQbcZAXjSlQanUn+3mjuNuD3Nidj6TRiHH1x8JytdH4XNdcU58
         9vtGYsGEm0hgOvf4QSYePNsgOTrf5uahsMt09h8BEg99lleRxbDlvyFEdc/ZArMpHw
         ShSpemX1MWdH1Tp9ugrVarn7gsSnCw5beyosMS8U=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CDEEE3522A0E; Fri, 14 Aug 2020 08:26:23 -0700 (PDT)
Date:   Fri, 14 Aug 2020 08:26:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200814152623.GN4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813182618.GX2674@hirez.programming.kicks-ass.net>
 <20200813185257.GF4295@paulmck-ThinkPad-P72>
 <20200813220619.GA2674@hirez.programming.kicks-ass.net>
 <875z9m3xo7.fsf@nanos.tec.linutronix.de>
 <20200814083037.GD3982@worktop.programming.kicks-ass.net>
 <20200814102306.GK35926@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814102306.GK35926@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 12:23:06PM +0200, peterz@infradead.org wrote:
> On Fri, Aug 14, 2020 at 10:30:37AM +0200, Peter Zijlstra wrote:
> > > > 1.	Prohibit invoking allocators from raw atomic context, such
> > > >	as when holding a raw spinlock.
> > > 
> > >   Clearly the simplest solution but not Pauls favourite and
> > >   unfortunately he has a good reason.
> > 
> > Which isn't actually stated anywhere I suppose ?
> 
> Introduce raw_kfree_rcu() that doesn't do the allocation, and fix the
> few wonky callsites.

The problem with that is common code along with the tendency of people
to just use the one that "works everywhere".

							Thanx, Paul

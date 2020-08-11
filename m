Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC50E241DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 18:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgHKQCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 12:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbgHKQCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:02:41 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AE43206B5;
        Tue, 11 Aug 2020 16:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597161760;
        bh=qYjAEv7PFjicCivlNg27thPuwsPSl2pW3y8n1g52xbo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YMO9U9SrhWMqJ6Y4HH/o0t7jAj1v65S7N2JlARf6q5vk+yTw10TcbKsWrFi0sbozy
         O6j38JkiSunsI5C87fE57P9EHHElsQnmLANlxkeb5HDe0ihvKhM4kg+XB1Z+LjlQrE
         +uQkxPr4g1nS0SCJtW87TfgCEwh+w9ku1x7Ykdt0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5BC5D352308E; Tue, 11 Aug 2020 09:02:40 -0700 (PDT)
Date:   Tue, 11 Aug 2020 09:02:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michal Hocko <mhocko@suse.com>,
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
Message-ID: <20200811160240.GX4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200809204354.20137-1-urezki@gmail.com>
 <20200809204354.20137-2-urezki@gmail.com>
 <20200810123141.GF4773@dhcp22.suse.cz>
 <20200810160739.GA29884@pc636>
 <20200810192525.GG4773@dhcp22.suse.cz>
 <87pn7x6y4a.fsf@nanos.tec.linutronix.de>
 <20200811153327.GW4295@paulmck-ThinkPad-P72>
 <87h7t96ve3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7t96ve3.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 05:43:16PM +0200, Thomas Gleixner wrote:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> > On Tue, Aug 11, 2020 at 04:44:21PM +0200, Thomas Gleixner wrote:
> >> Now RCU creates a new thing which enforces to make page allocation in
> >> atomic context possible on RT. What for?
> >> 
> >> What's the actual use case in truly atomic context for this new thing on
> >> an RT kernel?
> >
> > It is not just RT kernels.  CONFIG_PROVE_RAW_LOCK_NESTING=y propagates
> > this constraint to all configurations, and a patch in your new favorite
> > subsystem really did trigger this lockdep check in a non-RT kernel.
> >
> >> The actual RCU code disabling interrupts is an implementation detail
> >> which can easily be mitigated with a local lock.
> >
> > In this case, we are in raw-spinlock context on entry to kfree_rcu().
> 
> Where?

Some BPF code that needs to process and free a list.  As noted above,
this is a patch rather than something that is already in mainline.
Not surprising, though, given call_rcu() invocations in similar contexts.

Yes, we can perhaps rework all current and future callers to avoid
invoking both call_rcu() and kfree_rcu() from raw atomic context, but
the required change to permit this is quite a bit simpler.

							Thanx, Paul

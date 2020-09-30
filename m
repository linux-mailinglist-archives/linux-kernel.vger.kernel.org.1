Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A69627E8BE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgI3MoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:44:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:49692 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgI3MoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:44:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601469853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ua5GAxIwg4VuIAgWqlzBE5mMAJGN8QYCNlhi6+jB07I=;
        b=VZ+48TXP34SnwePm3NIE9dkLCd9xjRcOcr8NJqcyoTSAEj4AQkBL1EUGt0bSwrpeZZb7dB
        rFc5a3wxIqgPjT9iV6+wJyMaQK7jrf9xq+un3/4/B6ouWYz6N7AVPgDTTkcC8ec9UKM2pj
        tAgDxSlTD+Yp0J9ADZjmEtXuMwvj/HY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 808FBAC3C;
        Wed, 30 Sep 2020 12:44:13 +0000 (UTC)
Date:   Wed, 30 Sep 2020 14:44:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200930124413.GU2277@dhcp22.suse.cz>
References: <20200923103706.GJ3179@techsingularity.net>
 <20200923154105.GO29330@paulmck-ThinkPad-P72>
 <20200923232251.GK3179@techsingularity.net>
 <20200924081614.GA14819@pc636>
 <20200925080503.GC3389@dhcp22.suse.cz>
 <20200925153129.GB25350@pc636>
 <20200925154741.GI3389@dhcp22.suse.cz>
 <20200929162514.GA8768@pc636>
 <20200930092732.GP2277@dhcp22.suse.cz>
 <20200930123535.GB18005@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930123535.GB18005@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30-09-20 14:35:35, Uladzislau Rezki wrote:
> On Wed, Sep 30, 2020 at 11:27:32AM +0200, Michal Hocko wrote:
> > On Tue 29-09-20 18:25:14, Uladzislau Rezki wrote:
> > > > > I look at it in scope of GFP_ATOMIC/GFP_NOWAIT issues, i.e. inability
> > > > > to provide a memory service for contexts which are not allowed to
> > > > > sleep, RCU is part of them. Both flags used to provide such ability
> > > > > before but not anymore.
> > > > > 
> > > > > Do you agree with it?
> > > > 
> > > > Yes this sucks. But this is something that we likely really want to live
> > > > with. We have to explicitly _document_ that really atomic contexts in RT
> > > > cannot use the allocator. From the past discussions we've had this is
> > > > likely the most reasonable way forward because we do not really want to
> > > > encourage anybody to do something like that and there should be ways
> > > > around that. The same is btw. true also for !RT. The allocator is not
> > > > NMI safe and while we should be able to make it compatible I am not
> > > > convinced we really want to.
> > > > 
> > > > Would something like this be helpful wrt documentation?
> > > > 
> > > > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > > > index 67a0774e080b..9fcd47606493 100644
> > > > --- a/include/linux/gfp.h
> > > > +++ b/include/linux/gfp.h
> > > > @@ -238,7 +238,9 @@ struct vm_area_struct;
> > > >   * %__GFP_FOO flags as necessary.
> > > >   *
> > > >   * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
> > > > - * watermark is applied to allow access to "atomic reserves"
> > > > + * watermark is applied to allow access to "atomic reserves".
> > > > + * The current implementation doesn't support NMI and other non-preemptive context
> > > > + * (e.g. raw_spin_lock).
> > > >   *
> > > >   * %GFP_KERNEL is typical for kernel-internal allocations. The caller requires
> > > >   * %ZONE_NORMAL or a lower zone for direct access but can direct reclaim.
> > > > 
> > > To me it is clear. But also above conflicting statement:
> > > 
> > > <snip>
> > > %GFP_ATOMIC users can not sleep and need the allocation to succeed. A %lower
> > > <snip>
> > > 
> > > should be rephrased, IMHO.
> > 
> > Any suggestions? Or more specifics about which part is conflicting? It
> > tries to say that there is a higher demand to succeed even though the
> > context cannot sleep to take active measures to achieve that. So the
> > only way to achieve that is to break the watermakrs to a certain degree
> > which is making them more "higher class" than other allocations.
> > 
> Michal, i had only one concern about it. It says that %GFP_ATOMIC users
> can not sleep, i.e. callers know that they are in atomic, thus no any
> sleeping, but the chose they make will force them to sleep.

I am not sure I follow you here. Do you mean they will be forced to
sleep with PREEMPT_RT?

-- 
Michal Hocko
SUSE Labs

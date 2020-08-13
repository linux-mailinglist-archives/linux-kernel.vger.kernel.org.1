Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F94243D2B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 18:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgHMQW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 12:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHMQWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:22:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE74C061757;
        Thu, 13 Aug 2020 09:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uge1vPFGXscfZ/qc5fb5XqznesX3qbjU5Q1+WLFPWig=; b=I3jdR/6m8TYHe8dmMP0L0nc4lj
        /NUtxpk7Yboaz/PTUx/W4se9MHupHCKaQkYKHLqSIgEw0GmWzLoTi9CTYHcw6rflzqHFX0R6wc3UF
        vVeZPJjPfz+49X102s/h2Aqj011+lBpekQWG63Crx5QqQB6d4jRUyR+eAk+F1Wmb3Dm+e+IORqC3n
        k6IZb/xVGjUbCtysUUAINjJHIoyrxcz4BHvBa5HB/QPkVx/VleAhIPbmxA+kOMSR6/L4IE5v0IecF
        Ojy/kRH+P4KWDUfSBX1Vux1ffEEVGR6AYiIXzE7G1WTTeb/k8zVQ1LfWtWsYvcG97c1CDV2IBt7yZ
        YNOaQXkA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6FzZ-0002a2-9s; Thu, 13 Aug 2020 16:22:13 +0000
Date:   Thu, 13 Aug 2020 17:22:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200813162213.GK17456@casper.infradead.org>
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72>
 <874kp87mca.fsf@nanos.tec.linutronix.de>
 <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
 <20200813111505.GG9477@dhcp22.suse.cz>
 <871rkallqk.fsf@nanos.tec.linutronix.de>
 <20200813143221.GI17456@casper.infradead.org>
 <87pn7uttef.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn7uttef.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 06:14:32PM +0200, Thomas Gleixner wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> > On Thu, Aug 13, 2020 at 03:27:15PM +0200, Thomas Gleixner wrote:
> >> And guarding it with RT is not working either because then you are back
> >> to square one with the problem which triggered the discussion in the
> >> first place:
> >> 
> >> raw_spin_lock()
> >>   alloc()
> >>     if (RT && !preemptible())  <- False because RT == false
> >>     	goto bail;
> >> 
> >>     spin_lock(&zone->lock)  --> LOCKDEP complains
> >> 
> >> So either you convince Paul not to do that or you need to do something
> >> like I suggested in my other reply.
> >
> > I'd like to throw in the possibility that we do something like:
> >
> >   raw_spin_lock()
> >     alloc()
> >       if (!spin_trylock(&zone->lock))
> >         if (RT && !preemptible())
> >           goto bail;
> >         spin_lock(&zone->lock);
> >
> > would that make us feel more comfortable about converting zone->lock to
> > a raw spinlock?
> 
> Even if that could cure that particular problem of allocations in deep
> atomic context, making zone->lock raw brings back the problem of
> zone->lock being held/contended for hundreds of microseconds with
> interrupts disabled which is causing RT tasks to miss their deadlines by
> big margins.

Ah, I see.  Yeah, that doesn't work.  Never mind.

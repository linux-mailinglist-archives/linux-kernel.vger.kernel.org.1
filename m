Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EC2244EE1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 21:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgHNTdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 15:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgHNTdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 15:33:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1FFC061385;
        Fri, 14 Aug 2020 12:33:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597433627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pL+B8OyjhLBSkxUefg7i783iQfZZ1Nuc+PYJfkfMVFU=;
        b=yQDheluV3/try5pfwSxsqW1/f0KvC6bxVcqiD4v5fJJ4mz6V5ILbuenhNZ43A9eJeBDdjl
        am8Rzg3DqPJJjzWEGqsnkIeF62JNgb43D5v7e+zp3PLwEOC14vANCVdzLcs/8HJKd0Uu/I
        X+G9yjhDqh5jwIUXiXLnl52lxlE+Kd95QjIdZpNEiIfNEOb54m0eJMmaMRLkqJWC7rOPxU
        M3F39oCHzYUrD72Ypn65xVWWwg9OgkexuJH+bkWyzYQfUZqC99wrsbL1zH4CCKNF5kcO5m
        wUVPK8G1TubCUxSm8HREZzTN7RVilxZMVrn/5pz7QRihf3HQlw+RQ9Vocf2y6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597433627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pL+B8OyjhLBSkxUefg7i783iQfZZ1Nuc+PYJfkfMVFU=;
        b=TUe5+Mzif0ZKrAD73mHhOpVJtNOHVlmw13luhlgxevkyGMV+dt3IpjwaCw8/6NyMkWJqm6
        tuh92+A62Ch0mKBA==
To:     paulmck@kernel.org, Peter Zijlstra <peterz@infradead.org>
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
In-Reply-To: <20200814180224.GQ4295@paulmck-ThinkPad-P72>
References: <20200813133308.GK9477@dhcp22.suse.cz> <87sgcqty0e.fsf@nanos.tec.linutronix.de> <20200813182618.GX2674@hirez.programming.kicks-ass.net> <20200813185257.GF4295@paulmck-ThinkPad-P72> <20200813220619.GA2674@hirez.programming.kicks-ass.net> <875z9m3xo7.fsf@nanos.tec.linutronix.de> <20200814083037.GD3982@worktop.programming.kicks-ass.net> <20200814141425.GM4295@paulmck-ThinkPad-P72> <20200814161106.GA13853@paulmck-ThinkPad-P72> <20200814174924.GI3982@worktop.programming.kicks-ass.net> <20200814180224.GQ4295@paulmck-ThinkPad-P72>
Date:   Fri, 14 Aug 2020 21:33:47 +0200
Message-ID: <875z9lkoo4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14 2020 at 11:02, Paul E. McKenney wrote:
> On Fri, Aug 14, 2020 at 07:49:24PM +0200, Peter Zijlstra wrote:
>> On Fri, Aug 14, 2020 at 09:11:06AM -0700, Paul E. McKenney wrote:
>> > Just to make sure we are talking about the same thing, please see below
>> > for an untested patch that illustrates how I was interpreting your words.
>> > Was this what you had in mind?
>> 
>> No, definitely not.
>> 
>> Also, since we used to be able to use call_rcu() _everywhere_, including
>> under zone->lock, how's that working with you calling the
>> page-allocating from it?
>
> Indeed, that is exactly the problem we are trying to solve.

Wait a moment. Why are we discussing RT induced raw non raw lock
ordering at all?

Whatever kernel you variant you look at this is not working:

  lock(zone)  call_rcu() lock(zone)

It's a simple recursive dead lock, nothing else.

And that enforces the GFP_NOLOCK allocation mode or some other solution
unless you make a new rule that calling call_rcu() is forbidden while
holding zone lock or any other lock which might be nested inside the
GFP_NOWAIT zone::lock held region.

Thanks,

        tglx





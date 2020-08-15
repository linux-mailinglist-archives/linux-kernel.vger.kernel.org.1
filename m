Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1115524541C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 00:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbgHOWMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 18:12:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbgHOWK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:28 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6409D23120;
        Sat, 15 Aug 2020 13:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597496585;
        bh=TCd3RnIh+m/AFQpcO3QO6DTwGhG5pB3KRXQioDsmqOI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eNWPl1w+a9I0vCW47TFX0zI7f8aUPQdkPp8EYt2FoKGvxt8ILV1tkOX9mIethOQvz
         CdKhN50oWLVwJisuvGGPuZuRb1o9BDW27haWLVSYVCwMYcAMmf8Fs4Zuvw47fB+etZ
         SVRB2QprPHpSNIdOxDDHtQobDH0H+fiMzl1NxB2k=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 42C7635226F6; Sat, 15 Aug 2020 06:03:05 -0700 (PDT)
Date:   Sat, 15 Aug 2020 06:03:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20200815130305.GY4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200814180141.GP4295@paulmck-ThinkPad-P72>
 <87tux4kefm.fsf@nanos.tec.linutronix.de>
 <20200815082754.GM3982@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815082754.GM3982@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 10:27:54AM +0200, Peter Zijlstra wrote:
> On Sat, Aug 15, 2020 at 01:14:53AM +0200, Thomas Gleixner wrote:
> > 
> > As a matter of fact I assume^Wdeclare that removing struct rcu_head which
> > provides a fallback is not an option at all. I know that you want to,
> > but it wont work ever. Dream on, but as we agreed on recently there is
> > this thing called reality which ruins everything.
> 
> It never was going to work, freeing memory can never hard rely on the
> success of allocating memory.

In neither case does the freeing of memory rely hard-rely on the success
of allocating memory.  This is because there is a fallback in both cases
should allocation fail.

Given an rcu_head structure, we use that, and accept the extra cache
misses at callback-invocation time.  Otherwise, without an rcu_head
structure, the allocation parameters are carefully chosen to avoid
indefinite sleeping, meaning that the allocation attempt either succeeds
or fails within a reasonable amount of time.  And upon failure we invoke
synchronize_rcu(), then immediately free.  Which is slow, but then again
life is like that under OOM conditions.

And yes, this means that the price of leaving the rcu_head structure out
of the structure to be freed is that you must call kvfree_free() from
a sleepable context.  If you don't like being restricted to sleepable
context, you can always supply the rcu_head structure.

							Thanx, Paul

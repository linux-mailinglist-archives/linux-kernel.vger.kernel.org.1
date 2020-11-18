Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57F12B7F49
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgKROUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 09:20:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgKROUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:20:05 -0500
Received: from localhost (unknown [176.167.30.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92235246AB;
        Wed, 18 Nov 2020 14:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605709205;
        bh=H5KKQtwlN0sy6P8e1QTjLOv0qUVl5k/EwvoDhEaR5gY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=atrIZSxjTu0GeX9wgo5I5qj6oAdptTVNNuhrL5a3qcOatG/EGCkDFnXj3KCGQo7jT
         dRdnq1qLkNlvnr0kO3jNXcVVKP8qfgIm73z2+vleLYWXpg5X62cwmbsGrpkJJcfINd
         Q/a3I/5pOHe6kgvkjtXyN4b7gszl/3piPspTPI4g=
Date:   Wed, 18 Nov 2020 15:20:02 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 0/5] context_tracking: Flatter archs not using
 exception_enter/exit() v3
Message-ID: <20201118142002.GB279436@lothringen>
References: <20201117151637.259084-1-frederic@kernel.org>
 <20201118073947.GQ3121392@hirez.programming.kicks-ass.net>
 <20201118134826.GA279436@lothringen>
 <20201118140503.GU3121392@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118140503.GU3121392@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 03:05:03PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 18, 2020 at 02:48:26PM +0100, Frederic Weisbecker wrote:
> > On Wed, Nov 18, 2020 at 08:39:47AM +0100, Peter Zijlstra wrote:
> > > On Tue, Nov 17, 2020 at 04:16:32PM +0100, Frederic Weisbecker wrote:
> > > > Frederic Weisbecker (5):
> > > >       context_tracking: Introduce HAVE_CONTEXT_TRACKING_OFFSTACK
> > > >       context_tracking:  Don't implement exception_enter/exit() on CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK
> > > >       sched: Detect call to schedule from critical entry code
> > > >       context_tracking: Only define schedule_user() on !HAVE_CONTEXT_TRACKING_OFFSTACK archs
> > > >       x86: Support HAVE_CONTEXT_TRACKING_OFFSTACK
> > > 
> > > Thanks!
> > > 
> > > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > Thanks! Probably this should go through your branches?
> 
> Fair enough; these are now headed for tip/core/entry.

Thanks a lot! :)

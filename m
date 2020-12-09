Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554A82D4257
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 13:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbgLIMnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 07:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731814AbgLIMnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 07:43:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618D2C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 04:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eqqG504uqCWv3ZOtuq3290D6SjNzk9TOZEyi4K7z2YU=; b=Zjjhz+BPDfJz6v3N9wwREdlkS0
        OaT+plRtONOsnZWkGF8RqBSg8N8GTFW+1+pzVjUVpsHIbgV3AUF5UUoedbxHTvkLFb1EF73rrQIvD
        e6hBGraPzPpZ8j1ajPH46tgh/fx7MGg9z8HJRhx+rJsIEArfCLa658p5hxTHL3MfI/SsnH0oDkHdw
        hqOhFAAJYsHjhvpLqnwUVHIsK0O4NqwD1haMuGmPlKmbMBclPQfZc5mLK69KkC+mFDxu35Uj+8SZg
        0hSssw4gbVEze0loHCJCh1/5YqWAywO7LK+HC3jrseUcoXQ76P8K7+KEBm1Gj9F+lOk64srY41ju3
        5a7DoPCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmyni-0004v3-Kr; Wed, 09 Dec 2020 12:42:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 111813011F0;
        Wed,  9 Dec 2020 13:42:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF57D209B20CB; Wed,  9 Dec 2020 13:42:33 +0100 (CET)
Date:   Wed, 9 Dec 2020 13:42:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [patch V2 4/9] softirq: Make softirq control and processing RT
 aware
Message-ID: <20201209124233.GM2414@hirez.programming.kicks-ass.net>
References: <20201204170151.960336698@linutronix.de>
 <20201204170805.114951971@linutronix.de>
 <20201209101102.GJ2414@hirez.programming.kicks-ass.net>
 <878sa717h5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878sa717h5.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 01:36:54PM +0100, Thomas Gleixner wrote:
> On Wed, Dec 09 2020 at 11:11, Peter Zijlstra wrote:
> > On Fri, Dec 04, 2020 at 06:01:55PM +0100, Thomas Gleixner wrote:
> >> From: Thomas Gleixner <tglx@linutronix.de>
> >> +	/* First entry of a task into a BH disabled section? */
> >> +	if (!current->softirq_disable_cnt) {
> >> +		if (preemptible()) {
> >> +			local_lock(&softirq_ctrl.lock);
> >
> > AFAICT this significantly changes the locking rules.
> >
> > Where previously we could do:
> >
> > 	spin_lock(&ponies)
> > 	spin_lock_bh(&foo);
> >
> > vs
> >
> > 	spin_lock_bh(&bar);
> > 	spin_lock(&ponies)
> >
> > provided the rest of the code observed: bar -> ponies -> foo
> > and never takes ponies from in-softirq.
> >
> > This is now a genuine deadlock on RT.
> 
> I know, but making this work is trying to square the circle.

:-)

> Any approach we tried before going this way had worse problems than
> this particular limitation.

OK, but that would've been very good Changelog material methinks.

Also, then we should probably make sure PREEMPT_RT=n builds start
suffering the same problem by adding the local_lock unconditionally,
otherwise this keeps being a PREEMPT_RT special and we'll keep having to
fix it up.



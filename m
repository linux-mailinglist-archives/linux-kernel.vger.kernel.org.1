Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134162EC09D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 16:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbhAFPpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 10:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbhAFPpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 10:45:08 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58231C061357
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 07:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gtC4c3Ej8bBFZ9FcoprvJDs27X+S4qSFCKOgvJeaiHM=; b=VLYD91MY/OSoQtdL9IqCVn5DlF
        XFRILKWh6jpGCxrycvhxLiQxbYYgN4zeSMSkYsa/2mcx4b+kuqZ+XCQ6sMBEJh0AfhPkoXH+e81N/
        6yUxRmU0VnsmtL4Dqf1jUBSvFiR+NatVuEkPvfLWyJC1DFknjET/KtlLkDncIG3kzGCIii92aB9Vi
        WnHlh4eblDRL9uXglZ+D/+MCyseodVhJirB81YNVZYJOfBobzqRpB+Fvvgm2spI3+DYHkEoEmnMmO
        f9n8P5VI+xf27h1hJE2IiqvlJGIvHpZJP+Y4JKKh1qJcstnCSdxj3DS8mrsvB6TLHwjCnkreLX+ub
        rfiuxm0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxAz1-0002U2-CA; Wed, 06 Jan 2021 15:44:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DDA69305C10;
        Wed,  6 Jan 2021 16:44:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A41A42029C723; Wed,  6 Jan 2021 16:44:21 +0100 (CET)
Date:   Wed, 6 Jan 2021 16:44:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, bristot@redhat.com, frederic@kernel.org
Subject: Re: lockdep splat in v5.11-rc1 involving console_sem and rq locks
Message-ID: <X/Xa1fwplnZIOm+U@hirez.programming.kicks-ass.net>
References: <20210105220115.GA27357@paulmck-ThinkPad-P72>
 <X/WITr5JuNvuMH+p@hirez.programming.kicks-ass.net>
 <20210106144621.GJ17086@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106144621.GJ17086@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 06:46:21AM -0800, Paul E. McKenney wrote:
> Huh.  The WARN does not always generate the lockdep complaint.  But
> fair enough.

Any printk()/WARN/BUG with rq lock held ought to generate that splat,
sometimes we die before we splat. The printk rewrite should eventually
fix that.

> >   https://lkml.kernel.org/r/20201226025117.2770-1-jiangshanlai@gmail.com
> 
> Thomas pointed me at this one a couple of weeks ago.  Here is an
> additional fix for rcutorture: f67e04bb0695 ("torture: Break affinity
> of kthreads last running on outgoing CPU").  I am still getting WARNs
> and lockdep splats with both applied.

That patch looks racy, what avoids the task being shuffled right back
before the CPU goes offline?

> What would break if I made the code dump out a few entries in the
> runqueue if the warning triggered?

There was a patch around that did that, Valentin might remember where
that was.

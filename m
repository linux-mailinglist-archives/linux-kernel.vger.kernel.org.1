Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CF927F247
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 21:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbgI3TCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 15:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbgI3TCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:02:45 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A5DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 12:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tY2dQ+bDPBila3vv/T4/RYgLtz2foLuXryJAx7SCMDU=; b=xCBJcH6iFcC9HmMNErCe5ChKS8
        wd9Sahi8mVuNf3r4HUEFiMYBDcwhShuReMXf17UEa9GXBVYkf4QA/nvgv9ki8DN4IF2ZPpw1GTs1F
        XOzmcT93sDI0LsZb+o2CJV+il+0gF1fBsndOlGIpZ2FX8S4A849DXL5PEdLw7IMCiTNm9GCwo0z4n
        xDJPeBedAql/lcZHq2CHy28Z21gxKtXYv7e857eMZ1+J95vsBBHXH77igUBCo+5gajHpi+ujShqFu
        TU0Uan8GE6IzbN7haV39bMWdijMhaQhlqiiKMCpf7OzMjNEEM7Stx1ySmpUyW0aVEEOKb6KOvU7vV
        V0CSJR7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNhN1-0002Gx-HQ; Wed, 30 Sep 2020 19:02:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1A05C30705A;
        Wed, 30 Sep 2020 21:02:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 03A9620244EC3; Wed, 30 Sep 2020 21:02:28 +0200 (CEST)
Date:   Wed, 30 Sep 2020 21:02:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     g@hirez.programming.kicks-ass.net, Qian Cai <cai@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: lockdep null-ptr-deref
Message-ID: <20200930190228.GL2611@hirez.programming.kicks-ass.net>
References: <5fd046115645daa00f8841f5467da4c4d960ca92.camel@redhat.com>
 <20200929230823.GC17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200930091610.GV2628@hirez.programming.kicks-ass.net>
 <20200930094937.GE2651@hirez.programming.kicks-ass.net>
 <20200930121818.GD17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930121818.GD17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 08:18:18PM +0800, Boqun Feng wrote:

> For one thing, I do think that LOCK_READ_USED trace is helpful for
> better reporting, because if there is a read lock in the dependency path
> which causes the deadlock, it's better to have the LOCK_READ_USED trace
> to know at least the initial READ usage. For example, if we have
> 
> 	void f1(...)
> 	{
> 		write_lock(&A);
> 		spin_lock(&C);
> 		// A -> C
> 		...
> 	}
> 
> 	void g(...)
> 	{
> 		read_lock(&A);
> 		...
> 	}
> 	void f2(...)
> 	{
> 		spin_lock(&B);
> 		g(...);
> 		// B -> A
> 	}
> 
> 	void f3(...) {
> 		spin_lock(&C);
> 		spin_lock(&B);
> 		// C -> B, trigger lockdep splat
> 	}
> 
> when lockdep reports the deadlock (at the time f3() is called), it will
> be useful if we have a trace like:
> 
> 	INITIAL READ usage at:
> 	g+0x.../0x...
> 	f2+0x.../0x...
> 
> Thoughts?

Wouldn't that also be in LOCK_ENABLED_*_READ ?

That is, with PROVE_LOCKING on, the initial usage is bound to set more
states, except for !check||trylock usage, and those aren't really all
that interesting.

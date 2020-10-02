Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF542813C1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 15:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbgJBNJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 09:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBNJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 09:09:39 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE12C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 06:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gYBz8hgJM9a/ElpuLODQCLZ/ySa4mH5edDicIkLqmH4=; b=XCLlEzn6J/ST+ZabwA11x1YyBw
        KyrWlPeyyuoeVvQZ3pPLS5rX30ZE0LvfZvQUBaOX1t904eWT3ZfDy3ARcxOaSN+FWm8xRVamkArAh
        +pLiNs+A6ISfbdxn0CGUS9EYFavUrzJoTTJoHzpx53IGSf5PjpTTd/v66C6zVmy1GSQySJJclA/iY
        zgIhRB5MafUinCXiaOmmpAZhXns88Ktc8mM0t4IobYsNr0BpkZQq/L+HTPja9OUZ92AhzyfRgDrhI
        RDmNhyz+nHKICRzfXm8YZKcRNa/iJWKBkbNaVvu+qh1O9WoY3zQzqAF6bF0B2rxAtjD8K1NZtgDBW
        4f8imgSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOKoX-0000gd-7b; Fri, 02 Oct 2020 13:09:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC9FB3011F0;
        Fri,  2 Oct 2020 15:09:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FF54203A8F62; Fri,  2 Oct 2020 15:09:29 +0200 (CEST)
Date:   Fri, 2 Oct 2020 15:09:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     g@hirez.programming.kicks-ass.net, Qian Cai <cai@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: lockdep null-ptr-deref
Message-ID: <20201002130929.GW2628@hirez.programming.kicks-ass.net>
References: <5fd046115645daa00f8841f5467da4c4d960ca92.camel@redhat.com>
 <20200929230823.GC17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200930091610.GV2628@hirez.programming.kicks-ass.net>
 <20200930094937.GE2651@hirez.programming.kicks-ass.net>
 <20200930121818.GD17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200930190228.GL2611@hirez.programming.kicks-ass.net>
 <20201002123602.GE17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002123602.GE17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 08:36:02PM +0800, Boqun Feng wrote:

> But what if f2() is called with interrupt disabled? Or f2() disables
> interrupt inside the function, like:
> 
> 	void f2(...)
> 	{
> 		local_irq_disable();
> 		spin_lock(&B);
> 		g(...);
> 		...
> 		local_irq_enable();
> 	}
> 
> In this case, there wouldn't be any LOCK_ENABLED_*_READ usage for
> rwlock_t A. As a result, we won't see it in the lockdep splat.

Hurm, fair enough. So just to make sure, you're arguing for:

-#define LOCK_TRACE_STATES              (XXX_LOCK_USAGE_STATES*4 + 1)
+#define LOCK_TRACE_STATES              (XXX_LOCK_USAGE_STATES*4 + 2)

On top of my earlier patch, right?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6960A2ABE7C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbgKIOU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbgKIOU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:20:26 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A903C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 06:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ifTPoe6YK4JOieCL61op/fn3W2iVxY1lQd2pBgg8rZo=; b=bO/oWgDYiBTIrBWklsM0YNltIH
        gWiIyxPpAoOnLa/2CJQN4lTdylN7CnRGSkYV5zdkXQ7FW2l03RggJuRg8AbiiGUn3GzBMcZGeODW0
        zQ9z/ZY79kDiCp5u/fAgXIKUSU5jIr4MZIc22pDkno7xt+NwzDtmP5wjlZ3f56R8A/ECfYt4O3Puy
        THiAu9Z6RQbdToGuMbmuDJJvbaXZGqiyT+GIVfFOLjxQk8+VhHIzCyPyXZh7U8t4BCjQR8hGl+eQI
        wERjVBEFPzIdUO76juiILCTwvmSGoalz9IzKtiL/fIPaQpX5VvFdwbk6z0ngx5IHAedr5jM9aw32P
        5O2+wBIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kc81q-00041U-8l; Mon, 09 Nov 2020 14:20:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 773D4300455;
        Mon,  9 Nov 2020 15:20:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6AF4C2BDD057E; Mon,  9 Nov 2020 15:20:16 +0100 (CET)
Date:   Mon, 9 Nov 2020 15:20:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "neilb@suse.de" <neilb@suse.de>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
Subject: Re: [PATCH rfc] workqueue: honour cond_resched() more effectively.
Message-ID: <20201109142016.GK2611@hirez.programming.kicks-ass.net>
References: <87v9efp7cs.fsf@notabene.neil.brown.name>
 <20201109080038.GY2594@hirez.programming.kicks-ass.net>
 <aec65c71c09e803285688d5974193a98b4422428.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec65c71c09e803285688d5974193a98b4422428.camel@hammerspace.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 01:50:40PM +0000, Trond Myklebust wrote:
> On Mon, 2020-11-09 at 09:00 +0100, Peter Zijlstra wrote:

> > I'm thinking the real problem is that you're abusing workqueues. Just
> > don't stuff so much work into it that this becomes a problem. Or
> > rather,
> > if you do, don't lie to it about it.
> 
> If we can't use workqueues to call iput_final() on an inode, then what
> is the point of having them at all?

Running short stuff, apparently.

> Neil's use case is simply a file that has managed to accumulate a
> seriously large page cache, and is therefore taking a long time to
> complete the call to truncate_inode_pages_final(). Are you saying we
> have to allocate a dedicated thread for every case where this happens?

I'm not saying anything, but you're trying to wreck the scheduler
because of a workqueue 'feature'. The 'new' workqueues limit concurrency
by design, if you're then relying on concurrency for things, you're
using it wrong.

I really don't know what the right answer is here, but I thoroughly hate
the one proposed.

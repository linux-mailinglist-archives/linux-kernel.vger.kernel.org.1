Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64A025A8CD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 11:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgIBJnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 05:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgIBJnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:43:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1F1C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 02:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UK4gV5D2UF94h69yibSjGWGYN5fDF010k0ZXghIQNHk=; b=Ul2GePtGrgMOKaBQvR/XY7bkA7
        sLKWfXkyu1At+vI9PgXeGfrfDIgacvqKAtL5dX9F59nsSDqDENcQ18b6JQRRdpaIP+jqR3PWN6MZC
        gVQZr2ugDJuaApQaHqYtcRJ1VKW5z5gvLzQnfdxbg/7i/PQFD/F2WVYO9V8sFbjFhtXaw3ayufZm+
        6XS55eOVgBpAbKfWzJJ7dCbG6KTnXZa0raea1y0NYhnrNYSfp1mvybfbCvVqpClO9WXfk9fSPQU3j
        DKphakxynHlwlKE/PS5xYvZthE9rQAucUtz6vr+oh+YbHnfFzCz5Gf7DSKYy940joByjgw74w/+BB
        TWk9V6sQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDPIq-00079q-4E; Wed, 02 Sep 2020 09:43:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9DEA0300F7A;
        Wed,  2 Sep 2020 11:43:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67F2A235DB8C1; Wed,  2 Sep 2020 11:43:39 +0200 (CEST)
Date:   Wed, 2 Sep 2020 11:43:39 +0200
From:   peterz@infradead.org
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Subject: Re: [PATCH] sched/deadline: Fix stale throttling on de-/boosted tasks
Message-ID: <20200902094339.GZ1362448@hirez.programming.kicks-ass.net>
References: <20200831110719.2126930-1-l.stach@pengutronix.de>
 <20200902060024.GK16601@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902060024.GK16601@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 08:00:24AM +0200, Juri Lelli wrote:
> On 31/08/20 13:07, Lucas Stach wrote:
> > When a boosted task gets throttled, what normally happens is that it's
> > immediately enqueued again with ENQUEUE_REPLENISH, which replenishes the
> > runtime and clears the dl_throttled flag. There is a special case however:
> > if the throttling happened on sched-out and the task has been deboosted in
> > the meantime, the replenish is skipped as the task will return to its
> > normal scheduling class. This leaves the task with the dl_throttled flag
> > set.
> > 
> > Now if the task gets boosted up to the deadline scheduling class again
> > while it is sleeping, it's still in the throttled state. The normal wakeup
> > however will enqueue the task with ENQUEUE_REPLENISH not set, so we don't
> > actually place it on the rq. Thus we end up with a task that is runnable,
> > but not actually on the rq and neither a immediate replenishment happens,
> > nor is the replenishment timer set up, so the task is stuck in
> > forever-throttled limbo.
> > 
> > Clear the dl_throttled flag before dropping back to the normal scheduling
> > class to fix this issue.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

> Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!

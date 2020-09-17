Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E6726DED5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgIQO43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgIQOtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:49:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC9CC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 07:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YRPc1F4C4W05keQyBfNj9KrYWTBjG9YBky5PhZVaKzw=; b=Dj0cQmyr71m25p6pPb5uhBbGXn
        QfXGAy0lnjf+eQLxZnhTo/iN4OPcPZCaAxX8CfzvWwsgr+qbggxxcXIlyvkpGUQCXMkh/xMwWDyKU
        wx6WY1mIH7CV9MRMbyV7uSxexHTgzvi2gGqgYFqeJ2ZVda94iEpHa9KmnKLwtcm4T2j/REPFUrWSn
        HVxXnAOWVGP4P7C5y5jgB9SsP3URdcT40txMA2kHFFpjG7Nlfntwxa3JxkBtXvspb4CHEZOvhjXon
        9HuxqQXrWFVKU+ifAWhdfQZcn6RpU7wQeIpA1ByLj8b8j1irZ1zc9lKQp83wrxt7gkgvn04A/oFaR
        UOpKiOOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIvEA-0008Gr-OZ; Thu, 17 Sep 2020 14:49:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D517E3011FE;
        Thu, 17 Sep 2020 16:49:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 944832BC4475D; Thu, 17 Sep 2020 16:49:37 +0200 (CEST)
Date:   Thu, 17 Sep 2020 16:49:37 +0200
From:   peterz@infradead.org
To:     Sebastian Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Scott Wood <swood@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: Re: [patch 09/10] sched/core: Add migrate_disable/enable()
Message-ID: <20200917144937.GI1362448@hirez.programming.kicks-ass.net>
References: <20200917094202.301694311@linutronix.de>
 <20200917101624.813835219@linutronix.de>
 <20200917142438.GH1362448@hirez.programming.kicks-ass.net>
 <20200917143850.25akkvr32ojtwohy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917143850.25akkvr32ojtwohy@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 04:38:50PM +0200, Sebastian Siewior wrote:
> On 2020-09-17 16:24:38 [+0200], peterz@infradead.org wrote:
> > And if I'm not mistaken, the above migrate_enable() *does* require being
> > able to schedule, and our favourite piece of futex:
> > 
> > 	raw_spin_lock_irq(&q.pi_state->pi_mutex.wait_lock);
> > 	spin_unlock(q.lock_ptr);
> > 
> > is broken. Consider that spin_unlock() doing migrate_enable() with a
> > pending sched_setaffinity().
> 
> There are two instances of the above and only in the futex code and we
> have sort of duct tape for that by manually balancing the migrate
> counter so that it does not come to this.
> But yes, not having to do the manual balance is a plus.

I'm aware of the duct-tape :-) But I was under the impression that we
didn't want the duct-tape, and that there was lots of issues with the
FPU code, or was that another issue?


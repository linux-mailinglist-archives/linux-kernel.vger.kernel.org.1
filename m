Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978482F3358
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388800AbhALOzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbhALOzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:55:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3011EC061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yv6h4x95BGX9qXVY6Rcns5ygh15DQfWsBdxGTGyt8YE=; b=ZS3hDJrYdrTDPVhbly7EKu/Qp+
        1EtEpOKWYtEIYzWWOMznUNVXSccdaQc0SaDGv0cPE39fg8iXMqCzvTDgnD3teOspzrYmccN2Y/Qbv
        uTQjSLrHy1WrbUsXw9MxqRDzb4XersMk6Aawva3e3QmzZbLt0KPB7PRJuOpLXfEAysgecUJpIrkNd
        0b3a4GhSucn7StrPFrjoQcgJeejxXaGSDCdlv6gAeWyhV0S0rF09YrNc9SStdvK5nibsIKVvGsYNZ
        YcSuWwtDjb1bBeeeuJ/9jG3h+ejeOzGRhnqCJyzJZqxczVSXVA/TCXTMLbyYa3ukwFIcJb0CPIx0i
        WtnPE9Rg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kzL35-004vBG-Dv; Tue, 12 Jan 2021 14:53:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1AEAF301324;
        Tue, 12 Jan 2021 15:53:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2ACE20C228D5; Tue, 12 Jan 2021 15:53:30 +0100 (CET)
Date:   Tue, 12 Jan 2021 15:53:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Paul McKenney <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH -tip V3 0/8] workqueue: break affinity initiatively
Message-ID: <X/236obyM0nqL5+X@hirez.programming.kicks-ass.net>
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
 <X/hGHNGB9fltElWB@hirez.programming.kicks-ass.net>
 <87o8hv7pnd.fsf@nanos.tec.linutronix.de>
 <X/wv7+PP8ywNYmIS@hirez.programming.kicks-ass.net>
 <X/yH9+MGa1JCNZ8x@hirez.programming.kicks-ass.net>
 <jhj7doj1dr1.mognet@arm.com>
 <X/yzrJw4UbQsK3KB@hirez.programming.kicks-ass.net>
 <CAJhGHyA0rfR92W7T7RnhPrmLMkmV4Mb7fUSeG2VEHhsH-pSxsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyA0rfR92W7T7RnhPrmLMkmV4Mb7fUSeG2VEHhsH-pSxsw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 12:33:03PM +0800, Lai Jiangshan wrote:
> > Well yes, but afaict the workqueue stuff hasn't been settled yet, and
> > the rcutorture patch Paul did was just plain racy and who knows what
> > other daft kthread users are out there. That and we're at -rc3.
> 
> I just send the V4 patchset for the workqueue.  Please take a look.

Yes, I've seen it. But I think this approach is smaller and simpler.

By distinguishing between geniuine per-cpu kthreads and kthreads that
happen to have a single CPU affinity, things become much simpler and
robust.

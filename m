Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7BC27E5C8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgI3J5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgI3J5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:57:33 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED77C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 02:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=acJeaY+em+yFqmsg4ixfWjsNenQl9pdpGLeTKGEFnig=; b=T770lPaYdepLLCOCbKo3F2YMMM
        lJLY0pM4wvC8u4okwISJuIVxdl/Y9XKXl94T9R84ekexWYbdU9ZNgBAuArHXWWCzLv3yGz+8LYlEG
        XWJixZ+sxXoAt9JxeRz0w9Q2iLwJ8mY3l6oS20tPeLkKssjK4eqjId2PBtjq5izQNeR8/nOQphbyM
        3L+tbuQxoziidkCgw5Jq/bkEzcIOy/N9CexfCTQyI2/zkmzhj0V2m5ZA8foRSwpzQL/2xvi115RQp
        vz/FDii8IpSqUEFCdUlWKdC4Naz5pdBejvOok1PhIzI92vvDDtBqY2IqIM1rNph2FPl05Ep+idbbD
        G4CmJjlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNYrR-0002L7-JR; Wed, 30 Sep 2020 09:57:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1BB1A3062BA;
        Wed, 30 Sep 2020 11:57:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF29E202A4087; Wed, 30 Sep 2020 11:57:19 +0200 (CEST)
Date:   Wed, 30 Sep 2020 11:57:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jun qian <qianjun.kernel@gmail.com>
Cc:     mingo@redhat.com, Vincent Guittot <vincent.guittot@linaro.org>,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH 1/1] sched/fair: Fix the wrong sched_stat_wait time
Message-ID: <20200930095719.GW2628@hirez.programming.kicks-ass.net>
References: <20200930024712.88258-1-qianjun.kernel@gmail.com>
 <20200930081953.GU2628@hirez.programming.kicks-ass.net>
 <CAKc596Jc6H5qFxrzSp_fGhqTZt-5ORLoP=E4bwG-QzkpRiL2bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKc596Jc6H5qFxrzSp_fGhqTZt-5ORLoP=E4bwG-QzkpRiL2bA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 05:16:29PM +0800, jun qian wrote:
> Peter Zijlstra <peterz@infradead.org> 于2020年9月30日周三 下午4:20写道：
> >
> > On Wed, Sep 30, 2020 at 10:47:12AM +0800, qianjun.kernel@gmail.com wrote:
> > > From: jun qian <qianjun.kernel@gmail.com>
> > >
> > > When the sched_schedstat changes from 0 to 1, some sched se maybe
> > > already in the runqueue, the se->statistics.wait_start will be 0.
> > > So it will let the (rq_of(cfs_rq)) - se->statistics.wait_start)
> > > wrong. We need to avoid this scenario.
> >
> > Is this really the only problem there? Did you do a full audit of that
> > schedstat nonsense?
> >
> 
> Did you mean that the sched_stat_xxx's xxx_start(sched_stat_sleep
> sched_stat_iowait sched_stat_blocked
> sched_stat_runtime) may be also depend the schedstat_enabled?

Yeah, this runtime schedstat_enabled thing is fairly recent, it used to
be an always on/off kinda thing.

At the time we figured inconsistencies from dynamically
enabling/disabling it were okay, it's just stats after all.

But if you now want to 'fix' that, then a full audit might be nice.

> I have searched the codes, and found that these sched_stat_xxx's
> xxx_start don't depend the schedstat_enabled
> except the wait_start.

OK, so you did the audit and only found this one issue? That's good
Changelog material :-)

Thanks!

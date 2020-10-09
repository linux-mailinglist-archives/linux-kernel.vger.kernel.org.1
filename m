Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF507288650
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 11:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733236AbgJIJrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 05:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgJIJrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 05:47:49 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3E4C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 02:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=omMwUi1pb0JZYEzX9WrMwNVM/9noWra8skwW352I5FM=; b=qHI4TdYNEzWyfUfPt9MFUcGLDU
        ExiZiIRnUVS7ww5mj2B/4N/e4qtqL+eNIg32SPlGFQyoLEC981bFX4PbPBYjSfRnldTbCDFNUXIOI
        8RYGYjAb8Kf+izUxecbZF6RF6gWuwFystKL69nyQ+Uc8a0BJX7C+F1CNMQyZ59ZnXoNRJf4tDCpXq
        48GS9UeguOGZsw5fF6Kq4moA2qgpT6vTTZM2fHJublakBNyst+1SguQ58MQ/aNlXxrkbm5T5pxG6d
        PpLJnS4Zc4Wf5aoaBIUPDuNd7EOsKcySlTMTSLwnq4J+lGCYkwZUQVNmHlv8VlhFpUH5rQ80EIFK3
        IIw5ArRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQp03-0004ws-Mf; Fri, 09 Oct 2020 09:47:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3A6A33019CE;
        Fri,  9 Oct 2020 11:47:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D4F2320DB441C; Fri,  9 Oct 2020 11:47:41 +0200 (CEST)
Date:   Fri, 9 Oct 2020 11:47:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH] kernel: allow to configure PREEMPT_NONE,
 PREEMPT_VOLUNTARY on kernel command line
Message-ID: <20201009094741.GH2628@hirez.programming.kicks-ass.net>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201007122144.GF2628@hirez.programming.kicks-ass.net>
 <20201007123553.GK29020@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007123553.GK29020@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 02:35:53PM +0200, Michal Hocko wrote:
> On Wed 07-10-20 14:21:44, Peter Zijlstra wrote:
> > On Wed, Oct 07, 2020 at 02:04:01PM +0200, Michal Hocko wrote:
> > > I wanted to make sure that the idea is sound for maintainers first. The
> > > next step would be extending the command line to support full preemption
> > > as well but there is much more work in that area. Frederic has promissed
> > > to look into that.
> > 
> > The sanest way there is to static_call() __preempt_schedule() I think.
> 
> Yes, I have checked the code and identified few other places like
> irqentry_exit_cond_resched. We also need unconditional
> CONFIG_PREEMPT_COUNT IIUC and there are quite some places guarded by
> CONFIG_PREEMPTION that would need to be examined. Some of them are
> likely pretending to be more clever than they really are/should be -
> e.g. mm/slub.c. So there is likely a lot of leg work.

The easiest way might be to introduce PREEMPT_DYNAMIC that
depends/selects PREEMPT. That way you're basically running a PREEMPT=y
kernel.

Then have PREEMPT_DYNAMIC allow disabling the __preempt_schedule /
preempt_schedule_irq() callsites using static_call/static_branch
respectively.

That is, work backwards (from PREEMPT back to VOLUNTARY) instead of the
other way around.

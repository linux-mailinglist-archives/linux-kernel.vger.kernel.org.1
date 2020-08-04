Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EDF23BAB1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 14:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgHDMs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 08:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgHDMsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 08:48:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54551C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 05:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vNu8jH7CfZCZghBH6Gb2x7F+2wKxDLAxRVOeoOs8VzY=; b=F8aZlF4L14jsBmodix7PwQGYqd
        V8/Xc9+OQR02QITvEpu+fYBjVFraifoNbS+FzDA2NNQuKy4emxGJLedIiZsESfiw/9laGnblINPhi
        fqXETQbpDJ2HAfdVQ7Z2DdtjubNTxnQLS5r4cPW34Q9wiFectjrncTdwTtDzNsCfjgo4nMcblkhNQ
        E3blt2fMkaCaqUpO/BrD8GLeuQVjCJ7Z0p9ClnLwWOGV2r06zj+xmn4rj7mTVFF+dBnEdHbUYiHvZ
        puSUzdXHYpfx4+ZBqTfYewnKWu6d4nQxpjIIpQ5AmLnIAgPnt+sRe494n84oRgs6Sm0L/AKd9DcUH
        FdlIUyzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2wMH-0000WT-Ry; Tue, 04 Aug 2020 12:47:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DBC9D301E02;
        Tue,  4 Aug 2020 14:47:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A66B9235CDBD2; Tue,  4 Aug 2020 14:47:55 +0200 (CEST)
Date:   Tue, 4 Aug 2020 14:47:55 +0200
From:   peterz@infradead.org
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
Subject: Re: [PATCH 1/2] sched/topology: Allow archs to override cpu_smt_mask
Message-ID: <20200804124755.GJ2674@hirez.programming.kicks-ass.net>
References: <20200804033307.76111-1-srikar@linux.vnet.ibm.com>
 <20200804104520.GB2657@hirez.programming.kicks-ass.net>
 <20200804121007.GJ24375@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804121007.GJ24375@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 05:40:07PM +0530, Srikar Dronamraju wrote:
> * peterz@infradead.org <peterz@infradead.org> [2020-08-04 12:45:20]:
> 
> > On Tue, Aug 04, 2020 at 09:03:06AM +0530, Srikar Dronamraju wrote:
> > > cpu_smt_mask tracks topology_sibling_cpumask. This would be good for
> > > most architectures. One of the users of cpu_smt_mask(), would be to
> > > identify idle-cores. On Power9, a pair of cores can be presented by the
> > > firmware as a big-core for backward compatibility reasons.
> > > 
> > > In order to maintain userspace backward compatibility with previous
> > > versions of processor, (since Power8 had SMT8 cores), Power9 onwards there
> > > is option to the firmware to advertise a pair of SMT4 cores as a fused
> > > cores (referred to as the big_core mode in the Linux Kernel). On Power9
> > > this pair shares the L2 cache as well. However, from the scheduler's point
> > > of view, a core should be determined by SMT4. The load-balancer already
> > > does this. Hence allow PowerPc architecture to override the default
> > > cpu_smt_mask() to point to the SMT4 cores in a big_core mode.
> > 
> > I'm utterly confused.
> > 
> > Why can't you set your regular siblings mask to the smt4 thing? Who
> > cares about the compat stuff, I thought that was an LPAR/AIX thing.
> 
> There are no technical challenges to set the sibling mask to SMT4.
> This is for Linux running on PowerVM. When these Power9 boxes are sold /
> marketed as X core boxes (where X stand for SMT8 cores).  Since on PowerVM
> world, everything is in SMT8 mode, the device tree properties still mark
> the system to be running on 8 thread core. There are a number of utilities
> like ppc64_cpu that directly read from device-tree. They would get core
> count and thread count which is SMT8 based.
> 
> If the sibling_mask is set to small core, then same user when looking at

FWIW, I find the small/big core naming utterly confusing vs the
big/little naming from ARM. When you say small, I'm thinking of
asymmetric cores, not SMT4/SMT8.

> output from lscpu and other utilities that look at sysfs will start seeing
> 2x number of cores to what he had provisioned and what the utilities from
> the device-tree show. This can gets users confused.

One will report SMT8 and the other SMT4, right? So only users that
cannot read will be confused, but if you can't read, confusion is
guaranteed anyway.

Also, by exposing the true (SMT4) topology to userspace, userspace
applications could behave better -- for those few that actually parse
the topology information.

> So to keep the device-tree properties, utilities depending on device-tree,
> sysfs and utilities depending on sysfs on the same page, userspace are only
> exposed as SMT8.

I'm not convinced it makes sense to lie to userspace just to accomodate
a few users that cannot read.

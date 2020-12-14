Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6202D9556
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 10:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbgLNJdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 04:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgLNJc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 04:32:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A73CC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 01:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YUoipkrrpYhnigWXpgpKxtM4aoanwWNczHgeVzWov4I=; b=HZPzONIdrjODcOlP/tE5pkCK+D
        UzcL1hrOa9yeBRpou0ey8eMYH2AfpNVHgk50HNm3VyM++4M2zYPtaSW0B3DdEC2kmzNGDyT16+cgM
        8ViyrOpZNnJY8WHvgcP9LSTGeWwD7u0Mm30NDgJRB908oJh2FAjdNTf+rxaFNID3crCiPzRi37L0/
        KGv6ctfhLYucXLd33gwcYrHlzfRO10Ri4k2LDwqUXPKvoVftD+RCoW8KgOxmIGtvcuhM77lPhxbUL
        YuyzTGQGcqoI65W1CUVZJjLhEJ1KSxTXeC9FH7bvQpPG4hMo5cWmWAX1PsEbf2HFNdSZFOUe6WjzL
        okq87/ag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kokDA-0005i3-IN; Mon, 14 Dec 2020 09:32:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E5C7D3059C6;
        Mon, 14 Dec 2020 10:32:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D74802BA1531B; Mon, 14 Dec 2020 10:32:07 +0100 (CET)
Date:   Mon, 14 Dec 2020 10:32:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v7] sched/fair: select idle cpu from idle cpumask for
 task wakeup
Message-ID: <20201214093207.GY3040@hirez.programming.kicks-ass.net>
References: <20201209062404.175565-1-aubrey.li@linux.intel.com>
 <20201209143510.GO3371@techsingularity.net>
 <3802e27a-56ed-9495-21b9-7c4277065155@linux.intel.com>
 <20201210113441.GS3371@techsingularity.net>
 <31308700-aa28-b1f7-398e-ee76772b6b87@linux.intel.com>
 <20201210125833.GT3371@techsingularity.net>
 <20201211174442.GU3040@hirez.programming.kicks-ass.net>
 <20201211204337.GX3371@techsingularity.net>
 <20201211221905.GV3040@hirez.programming.kicks-ass.net>
 <20201211225002.GY3371@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211225002.GY3371@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 10:50:02PM +0000, Mel Gorman wrote:

> > > The third potential downside is that the SMT sibling is not guaranteed to
> > > be checked due to SIS_PROP throttling but in the old code, that would have
> > > been checked by select_idle_smt(). That might result in premature stacking
> > > of runnable tasks on the same CPU. Similarly, as __select_idle_core may
> > > find multiple idle candidates, it will not pick the targets SMT sibling
> > > if it is idle like select_idle_smt would have.
> > > 
> > > That said, I am skeptical that select_idle_smt() matters all that often.
> > 
> > This, I didn't really believe in it either.
> > 
> 
> Good because I think any benefit from select_idle_smt is so marginal
> that it should be ignored if the full scan is simpler overall.

Perhaps we should start out with a simple patch removing that pass..
That should show, what, if anything, the effect of it is.

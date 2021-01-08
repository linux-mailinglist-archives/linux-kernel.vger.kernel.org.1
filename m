Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED382EF865
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 20:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbhAHTuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 14:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbhAHTuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 14:50:50 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC110C061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 11:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qGT6ITD948+X3O7N9PZkCxcWPjEhw3d7HZbLs1mJhIY=; b=N2XSu3XcfBvkwMqILWi8ee02XA
        lPHgG0nqqDqhy/RUGzSZFLYah/McTK5lgY6bCENRaZzFPvstaoxC6Qj08YV5ss8f2VdAd3O1OaAC5
        t5343BTxRxm2W1WDn1TobVJ2P09gjTDxUiw5OTFQu4ryujmPtIP6acpOti4MJW1hctIF4MGw6Ni0e
        Ap40m7rYxRw1jZ6wrKHJerRn0rtxp2KjVifO2AAqaOCE+8n4Krg/hJEtEJmYALDowiYv5qxG12u0I
        KXMvQN9DSMOEaFm+vv5h9PkWte1RXWuv6N3CU1Ca1dGpEb9E/J+nfesHwmeAB4Idew08OD6Tx3WQU
        /E2LFKkQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxxlQ-0007r0-2L; Fri, 08 Jan 2021 19:49:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 93C933003D8;
        Fri,  8 Jan 2021 20:49:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 82B842C48C575; Fri,  8 Jan 2021 20:49:33 +0100 (CET)
Date:   Fri, 8 Jan 2021 20:49:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC][PATCH 1/5] sched/fair: Fix select_idle_cpu()s cost
 accounting
Message-ID: <X/i3TbRRS9chYb3l@hirez.programming.kicks-ass.net>
References: <20201214164822.402812729@infradead.org>
 <20201214170017.877557652@infradead.org>
 <c4e31235-e1fb-52ac-99a8-ae943ee0de54@linux.intel.com>
 <20201215075911.GA3040@hirez.programming.kicks-ass.net>
 <20210108102738.GB3592@techsingularity.net>
 <CAKfTPtD5R1S=rwp9C-jyMg8bAB-37FCe3qrqad9KEeyR7mOmkw@mail.gmail.com>
 <20210108144058.GD3592@techsingularity.net>
 <CAKfTPtCGCmCv0yXSUmYUh6=8uzd0n9xFPqC0cW4sm-FqDvjvCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCGCmCv0yXSUmYUh6=8uzd0n9xFPqC0cW4sm-FqDvjvCQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 04:10:51PM +0100, Vincent Guittot wrote:
> Another thing that worries me, is that we use the avg_idle of the
> local cpu, which is obviously not idle otherwise it would have been
> selected, to decide how much time we should spend on looking for
> another idle CPU. I'm not sure that's the right metrics to use
> especially with a possibly stalled value.

The thinking was that if this CPU has little idle time, this CPU should
not spend a lot of time searching...

That is; if we spend more time looking for places to run, than we have
idle time, we're loosing cycles we could've ran (supposedly useful) work.

The only counter argument is tail latency.

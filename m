Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04E82D1527
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgLGPvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLGPvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:51:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63546C061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 07:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UnWPrNoLWKvPAmCHfPyClMh9ynYuiJYOE5oeNaEW6xI=; b=vsnNMFPwWdqfIntBNJRFz1GA3t
        qdMjgzLak0Fj9SvB2vf5Yz6eDhgw1PMpcQfkFHSdv9uIjIkLJe9U2ajQIbKUQRF7YWNN5RNnfF0sX
        3ar68P+iyLkLHQPGWjGF5PJ9//b6xMd7ABeXbYBW6eYLHm8BtGf37x7SK9LcqGYUTWrZh1pZe/N1P
        9kdEjoBloZo2A10KdZUnJIaVMETpT1J+KPU0tUCLfGoaBFinthY/+I7Q/45VXy7zl0oIfg+sg+7OH
        6Vvx+PE3Y4MgsU2l/FCJd+NBzzUxVSUGumjDiS5OXy0jvDHWuNXUVF7ak8GFNhi+s7vCRGKq1r00t
        al2t5A/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmImG-0007wv-T7; Mon, 07 Dec 2020 15:50:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A93D3304D28;
        Mon,  7 Dec 2020 16:50:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9AA3620815F6C; Mon,  7 Dec 2020 16:50:15 +0100 (CET)
Date:   Mon, 7 Dec 2020 16:50:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aubrey Li <aubrey.li@linux.intel.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mgorman@techsingularity.net,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v5] sched/fair: select idle cpu from idle cpumask for
 task wakeup
Message-ID: <20201207155015.GQ3040@hirez.programming.kicks-ass.net>
References: <20201118043113.53128-1-aubrey.li@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118043113.53128-1-aubrey.li@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 12:31:13PM +0800, Aubrey Li wrote:
> Add idle cpumask to track idle cpus in sched domain. When a CPU
> enters idle, if the idle driver indicates to stop tick, this CPU
> is set in the idle cpumask to be a wakeup target. And if the CPU
> is not in idle, the CPU is cleared in idle cpumask during scheduler
> tick to ratelimit idle cpumask update.

So this will only have SIS consider CPUs that have the tick stopped?
That might affect the facebook tail-latency workloads quite a bit.


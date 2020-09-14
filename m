Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1748E268A16
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 13:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgINLbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 07:31:13 -0400
Received: from foss.arm.com ([217.140.110.172]:34790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgINL1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 07:27:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2DF5106F;
        Mon, 14 Sep 2020 04:27:39 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 381223F68F;
        Mon, 14 Sep 2020 04:27:38 -0700 (PDT)
Date:   Mon, 14 Sep 2020 12:27:35 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     peterz@infradead.org
Cc:     qianjun.kernel@gmail.com, tglx@linutronix.de, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        laoar.shao@gmail.com, urezki@gmail.com,
        John Dias <joaodias@google.com>, Wei Wang <wvw@google.com>,
        Quentin Perret <qperret@google.com>
Subject: Re: [PATCH V6 1/1] Softirq:avoid large sched delay from the pending
 softirqs
Message-ID: <20200914112735.6ivyy2iqlyqatzn7@e107158-lin.cambridge.arm.com>
References: <20200909090931.8836-1-qianjun.kernel@gmail.com>
 <20200911164644.eqjqjucvqfvrmr67@e107158-lin.cambridge.arm.com>
 <20200911182832.GL1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200911182832.GL1362448@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/20 20:28, peterz@infradead.org wrote:
> On Fri, Sep 11, 2020 at 05:46:45PM +0100, Qais Yousef wrote:
> > On 09/09/20 17:09, qianjun.kernel@gmail.com wrote:
> > > From: jun qian <qianjun.kernel@gmail.com>
> > > 
> > > When get the pending softirqs, it need to process all the pending
> > > softirqs in the while loop. If the processing time of each pending
> > > softirq is need more than 2 msec in this loop, or one of the softirq
> > > will running a long time, according to the original code logic, it
> > > will process all the pending softirqs without wakeuping ksoftirqd,
> > > which will cause a relatively large scheduling delay on the
> > > corresponding CPU, which we do not wish to see. The patch will check
> > > the total time to process pending softirq, if the time exceeds 2 ms
> > > we need to wakeup the ksofirqd to aviod large sched delay.
> > > 
> > > Signed-off-by: jun qian <qianjun.kernel@gmail.com>
> > 
> > In Android there's a patch that tries to avoid schedling an RT task on a cpu
> > that is running softirqs. I wonder if this patch helps with this case.
> > 
> > https://android.googlesource.com/kernel/msm/+/5c3f54c34acf4d9ed01530288d4a98acff815d79%5E%21/#F0
> > 
> > John, Wei, is this something of interest to you?
> 
> Urgh.. that's pretty gross. I think the sane approach is indeed getting
> softirqs to react to need_resched() better.

What does PREEMPT_RT do to deal with softirqs delays?

I have tried playing with enabling threadirqs, which AFAIU should make softirqs
preemptible, right?

I realize this patch is still missing from mainline at least:

	https://gitlab.com/kalilinux/packages/linux/blob/a17bad0db9da44cd73f594794a58cc5646393b13/debian/patches-rt/softirq-Add-preemptible-softirq.patch

Would this be a heavy handed approach to make available for non PREEMPT_RT
kernels?

I only worry about potential NET_RX throughput issues. Which by the way is
protected with preempt_disable currently in mainline. See netif_rx_ni().

I am guessing here, but I suspect this NET_RX softirq is one source of big
delays when network activity is high.

Thanks

--
Qais Yousef

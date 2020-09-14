Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7EB268FE3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgINP2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:28:49 -0400
Received: from foss.arm.com ([217.140.110.172]:40324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgINP2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:28:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B9091FB;
        Mon, 14 Sep 2020 08:28:15 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBCCE3F718;
        Mon, 14 Sep 2020 08:28:13 -0700 (PDT)
Date:   Mon, 14 Sep 2020 16:28:11 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     peterz@infradead.org
Cc:     qianjun.kernel@gmail.com, tglx@linutronix.de, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        laoar.shao@gmail.com, urezki@gmail.com,
        John Dias <joaodias@google.com>, Wei Wang <wvw@google.com>,
        Quentin Perret <qperret@google.com>
Subject: Re: [PATCH V6 1/1] Softirq:avoid large sched delay from the pending
 softirqs
Message-ID: <20200914152811.m7kzmsdr7dxm2c6o@e107158-lin.cambridge.arm.com>
References: <20200909090931.8836-1-qianjun.kernel@gmail.com>
 <20200911164644.eqjqjucvqfvrmr67@e107158-lin.cambridge.arm.com>
 <20200911182832.GL1362448@hirez.programming.kicks-ass.net>
 <20200914112735.6ivyy2iqlyqatzn7@e107158-lin.cambridge.arm.com>
 <20200914141437.GR1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200914141437.GR1362448@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14/20 16:14, peterz@infradead.org wrote:
> On Mon, Sep 14, 2020 at 12:27:35PM +0100, Qais Yousef wrote:
> > What does PREEMPT_RT do to deal with softirqs delays?
> 
> Makes the lot preemptible, you found the patch below.
> 
> > I have tried playing with enabling threadirqs, which AFAIU should make softirqs
> > preemptible, right?
> 
> Not yet,..
> 
> > I realize this patch is still missing from mainline at least:
> > 
> > 	https://gitlab.com/kalilinux/packages/linux/blob/a17bad0db9da44cd73f594794a58cc5646393b13/debian/patches-rt/softirq-Add-preemptible-softirq.patch
> > 
> > Would this be a heavy handed approach to make available for non PREEMPT_RT
> > kernels?
> 
> Not sure, I suspect it relies on migrate_disable(), which is
> preempt_disable() on !RT and then we're back to square one.

I think it will depend on local_bh_disable(). I didn't dig into the patch
above, but I believe it's doing that for RT.

Or maybe there's another aspect I am not aware of that relies on
migrate_disable() too..

> 
> > I only worry about potential NET_RX throughput issues. Which by the way is
> > protected with preempt_disable currently in mainline. See netif_rx_ni().
> 
> So preempt_disable() isn't necessairily a problem, you just want it to

Yes. But high network traffic will make this a busy softirq. And it won't work
with the patch above. But I assume the above will have to fix that with it.

	https://lore.kernel.org/netdev/20170616172400.10809-1-bigeasy@linutronix.de/

For the time being, it's just another potential path that could introduce
latencies.

I can't follow the whole thing too, but if 5G modems ends up there; I can see
this a big source of noise when the user is downloading a big file. Assuming 5g
lives up to its reputation of 400+ Mbps in practice.

So there might be a tangible trade off between better softirqs latencies vs
better network throughput.

> terminate soonish after need_resched() becomes true. Also, I'm having a
> wee problem getting from net_rx_action() to netif_rx_ni()

I can investigate this direction :)

> 
> > I am guessing here, but I suspect this NET_RX softirq is one source of big
> > delays when network activity is high.
> 
> Well, one approach is to more agressively limit how long softirq
> processing can run. Current measures are very soft in that regard.

Which is this patch. Although it doesn't take into account a single softirq
exceeding the quota IIUC. But the need_resched() bit above should address that.

Thanks

--
Qais Yousef

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89856268D20
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgINOPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgINOOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:14:47 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEA9C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 07:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7YHEHnv2yDXChhaSTnQgDzaWIGN7mSRwMmbzysKKdjE=; b=g4Qm5KjPn8fJaCIJqbtMNMW8y3
        tNrhh4oZZWI3x5hS1Yiohns4YH8g0FC10RGD+xoHD/aJybnLoPz61Fl24YjJqfcKiEEEdOJqUqlVB
        fDefsKEdQiOlvzyjyHUqF3d46dmVJnSgrpuWe43pW99MdjMn10DNHZ+U8rqDg51hvNc4ieTHIW+Hy
        ZLN2yhYasvpRe1/NTzK1fL9h9EiLIlmh0Sx0Gl4oE+bvJ6X8pUnTM+j5XgiKdkkDZuLVX+iCZK1Q0
        5OXpvTGiCcyBtkgpHZ5fwX14AWS9UVNEUPVEaYOHcyU5zMNYibU8w86gpurPe4ibJ1LsGn48KgvWh
        mhCqll7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHpFg-0007An-Ui; Mon, 14 Sep 2020 14:14:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C3D833003D8;
        Mon, 14 Sep 2020 16:14:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89C4021F922D5; Mon, 14 Sep 2020 16:14:37 +0200 (CEST)
Date:   Mon, 14 Sep 2020 16:14:37 +0200
From:   peterz@infradead.org
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     qianjun.kernel@gmail.com, tglx@linutronix.de, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        laoar.shao@gmail.com, urezki@gmail.com,
        John Dias <joaodias@google.com>, Wei Wang <wvw@google.com>,
        Quentin Perret <qperret@google.com>
Subject: Re: [PATCH V6 1/1] Softirq:avoid large sched delay from the pending
 softirqs
Message-ID: <20200914141437.GR1362448@hirez.programming.kicks-ass.net>
References: <20200909090931.8836-1-qianjun.kernel@gmail.com>
 <20200911164644.eqjqjucvqfvrmr67@e107158-lin.cambridge.arm.com>
 <20200911182832.GL1362448@hirez.programming.kicks-ass.net>
 <20200914112735.6ivyy2iqlyqatzn7@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914112735.6ivyy2iqlyqatzn7@e107158-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 12:27:35PM +0100, Qais Yousef wrote:
> What does PREEMPT_RT do to deal with softirqs delays?

Makes the lot preemptible, you found the patch below.

> I have tried playing with enabling threadirqs, which AFAIU should make softirqs
> preemptible, right?

Not yet,..

> I realize this patch is still missing from mainline at least:
> 
> 	https://gitlab.com/kalilinux/packages/linux/blob/a17bad0db9da44cd73f594794a58cc5646393b13/debian/patches-rt/softirq-Add-preemptible-softirq.patch
> 
> Would this be a heavy handed approach to make available for non PREEMPT_RT
> kernels?

Not sure, I suspect it relies on migrate_disable(), which is
preempt_disable() on !RT and then we're back to square one.

> I only worry about potential NET_RX throughput issues. Which by the way is
> protected with preempt_disable currently in mainline. See netif_rx_ni().

So preempt_disable() isn't necessairily a problem, you just want it to
terminate soonish after need_resched() becomes true. Also, I'm having a
wee problem getting from net_rx_action() to netif_rx_ni()

> I am guessing here, but I suspect this NET_RX softirq is one source of big
> delays when network activity is high.

Well, one approach is to more agressively limit how long softirq
processing can run. Current measures are very soft in that regard.

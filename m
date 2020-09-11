Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8EB266840
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 20:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgIKS2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 14:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgIKS2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 14:28:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433FDC061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 11:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9b//SbxpPqFF4Y5HV5jq/8+/ryTiwgIhxqTHNYXPSYU=; b=rWaYaDdilNlFsYaTHRsNv3imMn
        fk8N1Y0Hce/LK3QdsN1moa+bCC4b+8gs1FDecF6PAxH7I4sR1YfgZto8UwmSfvXnEr71GFUd3mKT4
        3BjiL39XQX8osveDxsZKK4oFvQqLDS//3Lw86cQynvL3Mit0BH1Vxe13BEQYNSUx/LutgD8pB/GP9
        g3qKgyrpEFh9R6FmNcGXH7n74Omj7HqpF04pwViDYjov/gqrZnaNJDS42d2T7mZKCDP/PJKdBxLwv
        J/FNxdRLrj+wC1dhuNHc2ABYBQhTf3Kwh58HvCSCrbR4OPtnRubSdBtjrxsGVE4/QCwSWhDs30AsS
        n0yrA2Sg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGnml-0004AD-M2; Fri, 11 Sep 2020 18:28:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 58AE33012DC;
        Fri, 11 Sep 2020 20:28:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42F4E2BA9CF95; Fri, 11 Sep 2020 20:28:32 +0200 (CEST)
Date:   Fri, 11 Sep 2020 20:28:32 +0200
From:   peterz@infradead.org
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     qianjun.kernel@gmail.com, tglx@linutronix.de, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        laoar.shao@gmail.com, urezki@gmail.com,
        John Dias <joaodias@google.com>, Wei Wang <wvw@google.com>,
        Quentin Perret <qperret@google.com>
Subject: Re: [PATCH V6 1/1] Softirq:avoid large sched delay from the pending
 softirqs
Message-ID: <20200911182832.GL1362448@hirez.programming.kicks-ass.net>
References: <20200909090931.8836-1-qianjun.kernel@gmail.com>
 <20200911164644.eqjqjucvqfvrmr67@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911164644.eqjqjucvqfvrmr67@e107158-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 05:46:45PM +0100, Qais Yousef wrote:
> On 09/09/20 17:09, qianjun.kernel@gmail.com wrote:
> > From: jun qian <qianjun.kernel@gmail.com>
> > 
> > When get the pending softirqs, it need to process all the pending
> > softirqs in the while loop. If the processing time of each pending
> > softirq is need more than 2 msec in this loop, or one of the softirq
> > will running a long time, according to the original code logic, it
> > will process all the pending softirqs without wakeuping ksoftirqd,
> > which will cause a relatively large scheduling delay on the
> > corresponding CPU, which we do not wish to see. The patch will check
> > the total time to process pending softirq, if the time exceeds 2 ms
> > we need to wakeup the ksofirqd to aviod large sched delay.
> > 
> > Signed-off-by: jun qian <qianjun.kernel@gmail.com>
> 
> In Android there's a patch that tries to avoid schedling an RT task on a cpu
> that is running softirqs. I wonder if this patch helps with this case.
> 
> https://android.googlesource.com/kernel/msm/+/5c3f54c34acf4d9ed01530288d4a98acff815d79%5E%21/#F0
> 
> John, Wei, is this something of interest to you?

Urgh.. that's pretty gross. I think the sane approach is indeed getting
softirqs to react to need_resched() better.

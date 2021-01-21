Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C42F2FECD6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbhAUOYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730799AbhAUOT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:19:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946EBC061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 06:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JCEj/R0ZdDJX+DcNhq/DBdxACThz4GEv/C7PS3b5hzU=; b=M/NOwSQwkMcs3qR7DosE09Kiqa
        Eit+27pAw+6IE+r34LiyodTZhKcj5iYTdvJhxQ00jRb56gc1sJitNwHwyHER6fxTtLUHNIlmuYZDu
        9Eyb0bAYjsrYy3wG7hsXri0QE0MVmdeelmnFIROJAdoion0/iG3eK+Ibx9322h/4gpgEkVvBvW41M
        /Z2VZFp4CZrIHPcx9igLNNBKgYxo/0akJJ4DaPMYLN6yuKyVpicgtwkPkXbfmscOMxr7HUGC0EaNQ
        GJmphDQNvkVo+fy6phklAJVxSgRNd+nXZCkh3+03mozcN9R5MKtTJ/jLf8VxrHvZI1oIRo1JM/OGE
        9Z7CX63w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2amp-00H8jb-90; Thu, 21 Jan 2021 14:18:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 846CD304E03;
        Thu, 21 Jan 2021 15:18:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4CF212028D521; Thu, 21 Jan 2021 15:18:10 +0100 (CET)
Date:   Thu, 21 Jan 2021 15:18:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jiangshanlai@gmail.com, cai@redhat.com, vincent.donnefort@arm.com,
        decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org
Subject: Re: [PATCH -v3 8/9] sched: Fix CPU hotplug / tighten
 is_per_cpu_kthread()
Message-ID: <YAmNIsyaiO6teljH@hirez.programming.kicks-ass.net>
References: <20210121101702.402798862@infradead.org>
 <20210121103507.102416009@infradead.org>
 <jhjeeiemlsw.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjeeiemlsw.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 02:01:03PM +0000, Valentin Schneider wrote:
> On 21/01/21 11:17, Peter Zijlstra wrote:
> > @@ -7504,6 +7525,9 @@ int sched_cpu_deactivate(unsigned int cp
> >        * preempt-disabled and RCU users of this state to go away such that
> >        * all new such users will observe it.
> >        *
> > +	 * Specifically, we rely on ttwu to no longer target this CPU, see
> > +	 * ttwu_queue_cond() and is_cpu_allowed().
> > +	 *
> 
> So the last time ttwu_queue_wakelist() can append a task onto a dying
> CPU's wakelist is before sched_cpu_deactivate()'s synchronize_rcu()
> returns. 
> 
> As discussed on IRC, paranoia would have us issue a
> 
>   flush_smp_call_function_from_idle()
> 
> upon returning from said sync, but this will require further surgery.

Right, specifically RCU needs a little more help there.

> Do we want something like the below in the meantime? Ideally we'd warn on
> setting rq->ttwu_pending when !cpu_active(), but as per the above this is
> allowed before the synchronize_rcu() returns.

I'm not sure I'm brave enough to add that just now :/

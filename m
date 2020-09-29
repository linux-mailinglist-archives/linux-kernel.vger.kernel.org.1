Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F59027D231
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 17:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbgI2PKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 11:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730042AbgI2PKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 11:10:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD66C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 08:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KeZOCAo/R/OdLryxm25aXe9nhhSa9seaaI8oOsIn/fg=; b=HfJr+OY78WcdzhEKy3gim4954p
        tpsBm1f6ASoADm/JnXsYQuR7iaHENc3m8edfMdC3/HIgsEfqbViIhFJRsnFwmjs+5Ra/dQNFg8snn
        ua+FuaTL5JFjJpxJ1f6zoRGulpZd4kuis+n2YhQwKEXSZqqKPr6ktN0u/cp4UdOMp6cqC9U4g/ZBg
        gIHAQV7ae0Wv8oVMEgPlHMfcg+Ssff/O7gaUoVk4wzpnGOFVPnd78mD5kTtGao14uRdIGlhXmBCog
        TaUZ7rJzh42i/6LzdOJhBMi253VeSqUIg30gAUbObm92jZJRfGymyflWDV/fd9L78LlRTJUNSlmJE
        Jf2apDzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNHG3-0008BQ-44; Tue, 29 Sep 2020 15:09:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 90F2B300F7A;
        Tue, 29 Sep 2020 17:09:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 73A6F210E84D0; Tue, 29 Sep 2020 17:09:33 +0200 (CEST)
Date:   Tue, 29 Sep 2020 17:09:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, songmuchun@bytedance.com,
        john.ogness@linutronix.de
Subject: Re: [External] Re: [PATCH 2/2] sched: mark
 PRINTK_DEFERRED_CONTEXT_MASK in __schedule()
Message-ID: <20200929150933.GR2628@hirez.programming.kicks-ass.net>
References: <20200927161130.33172-1-zhouchengming@bytedance.com>
 <20200927161130.33172-2-zhouchengming@bytedance.com>
 <20200928073202.GA2611@hirez.programming.kicks-ass.net>
 <40ab934e-5b8b-735b-da65-3043efab9fdc@bytedance.com>
 <20200928090143.GA2628@hirez.programming.kicks-ass.net>
 <688eadd7-4ca3-3e32-3520-25977ff059a6@bytedance.com>
 <20200928102559.GF2611@hirez.programming.kicks-ass.net>
 <20200929142750.GT6442@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929142750.GT6442@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 04:27:51PM +0200, Petr Mladek wrote:

> Upstreaming the console handling will be the next big step. I am sure
> that there will be long discussion about it. But there might be
> few things that would help removing printk_deferred().
> 
> 1. Messages will be printed on consoles by dedicated kthreads. It will
>    be safe context. No deadlocks.

This, that's what I remember. With sane consoles having a
->write_atomic() callback which is called in-line.

Current -RT has a single kthread that's flushing the consoles.

> 2. The registration and unregistration of consoles should not longer
>    be handled by console_lock (semaphore). It should be possible to
>    call most consoles without a sleeping lock. It should remove all
>    these deadlocks between printk() and scheduler().

I'm confused, who cares about registation? That only happens once at
boot, right?

>    There might be problems with some consoles. For example, tty would
>    most likely still need a sleeping lock because it is using the console
>    semaphore also internally.

But per 1) above, that's done from a kthread, so nobody cares.

> 3. We will try harder to get the messages out immediately during
>    panic().

As long as you guarantee to first write everything to consoles with
->write_atomic() before attempting to flush others that should be fine.

> It would take some time until the above reaches upstream. But it seems
> to be the right way to go.

Yep.

> Finally, the deadlock happens "only" when someone is waiting on
> console_lock() in parallel. Otherwise, the waitqueue for the semaphore
> is empty and scheduler is not called.

There's more deadlocks. In fact the one described earlier in this
thread isn't the one you mention.

> It means that there is quite a big change to see the WARN(). It might
> be even bigger than with printk_deferred() because WARN() in scheduler
> means that the scheduler is big troubles. Nobody guarantees that
> the deferred messages will get handled later.

I only care about ->write_atomic() :-) Anything else is a
best-effort-loss anyway.


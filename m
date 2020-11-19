Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320B12B9440
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbgKSOLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgKSOLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:11:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D848C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 06:11:31 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605795090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uhs1v+FGHP0Fk0CbPEbBoHILu6wTDFiRJv7qaHmYl50=;
        b=He5XyzoQTO/Xh20kx+DVSDBYR0cGe2ComZqW9UZvfCQYdMmtx9Bdb/CqAH1I0sfZ9gX6nB
        N2qvplPFYUjnNb/qRSD5qzaxUwujDV9XiWJzt5cMX60ubnv7mVq4ahSF8aDz/iIoOTvcEY
        ZDYQe1WWwzKvZ77lUrve7mDU4qJZuilKjtdoc2GL8i1hxAjKMzeSOkLDB8c4raQLvUqBnm
        TDiKSjESuehYho8WewnZczee+HFL8hMS34KuFzmLRC1gyhw+9ScvBGMWC5NpVMdv3WSK8V
        3+00PunezSQ4vxniM3eJypAjRHEg9Y/OQ0UfwREyHo0hhHRqCIO39O1Sb0L1lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605795090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uhs1v+FGHP0Fk0CbPEbBoHILu6wTDFiRJv7qaHmYl50=;
        b=foHsmKRXAO41l4pBQlYW8ZS+f/8qx+Ut2oiAD6BFmALBs1qHcBZ2KIUd4uNXEsBZwkadmc
        3bPNomdBQTOuPVBA==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch V4 5/8] sched: highmem: Store local kmaps in task struct
In-Reply-To: <20201119121200.GG3121429@hirez.programming.kicks-ass.net>
References: <20201118194838.753436396@linutronix.de> <20201118204007.372935758@linutronix.de> <20201119115132.GN3121378@hirez.programming.kicks-ass.net> <20201119121200.GG3121429@hirez.programming.kicks-ass.net>
Date:   Thu, 19 Nov 2020 15:11:29 +0100
Message-ID: <87tutlphbi.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19 2020 at 13:12, Peter Zijlstra wrote:
> On Thu, Nov 19, 2020 at 12:51:32PM +0100, Peter Zijlstra wrote:
>> > +void __kmap_local_sched_in(void)
>> > +{
>> > +	struct task_struct *tsk = current;
>> > +	pte_t *kmap_pte = kmap_get_pte();
>> > +	int i;
>> > +
>> > +	/* Restore kmaps */
>> > +	for (i = 0; i < tsk->kmap_ctrl.idx; i++) {
>> > +	}
>> > +}
>> 
>> So even in the optimal case, this adds an unconditional load of
>> tsk->kmap_ctrl.idx to schedule() (2 misses, one pre and one post).
>> 
>> Munging preempt-notifiers behind a static_branch, which in that same
>> optimal case, avoided touching curr->preempt_notifier, resulted in a
>> measurable performance improvement. See commit:
>> 
>>   1cde2930e154 ("sched/preempt: Add static_key() to preempt_notifiers")
>> 
>> Can we fudge some state in a cacheline we're already touching to avoid
>> this?
>
> The only state we seem to consistently look at after schedule() is
> need_resched()'s TIF_NEED_RESCHED.
>
> But adding a TIF_flag to all archs and setting/clearing it from
> kmap_local might be a bit daft.. :/

Yes, and we all agreed that pushing the burden on CONFIG_HIGHMEM is
fine. It's slow, so making it a tad slower is not the end of the
world. Remember we want to get rid of it :)

Thanks,

        tglx

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948582EF195
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbhAHLrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbhAHLri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:47:38 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3150AC0612F4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 03:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yLAqPIM0zGFnApY9dGBlUnodOsvbrHBdXkQ8n3+DH2g=; b=pQQG+ZoeRSC1mdNkxArJfxqDLo
        qy6Zg/+FE/1jOMcE1a1I9Ye3mVLrnxg+pVwJVNnyDgRwUpRzXyvyBKO85ZPyLbvDQav9pTxW2k8/R
        7mPfrWARestd+Q8QJnC8KadQWWnplQg4Lb+4enZ8rj49xXKjqijUz1Wq1gc6dC9noiD5khII5VhA5
        55ESF5gjIv9jXqebC5QBs32ScNxhw01bf2KYeLRB2VA91ScR7rZqPTfaPZZB1zPPxVDkR4+0pwlxE
        PLsDxPmwqJWWNfpAEk/gSdc1ePNIPR4+dMR7GnnuqWIlTIDwUnoHSCGzmNXhXZT1v0aBecJCl0Mla
        tU9Pnj/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxqE7-0007a2-9c; Fri, 08 Jan 2021 11:46:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 03D193003D8;
        Fri,  8 Jan 2021 12:46:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC4FC200E972D; Fri,  8 Jan 2021 12:46:36 +0100 (CET)
Date:   Fri, 8 Jan 2021 12:46:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Paul McKenney <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -tip V3 0/8] workqueue: break affinity initiatively
Message-ID: <X/hGHNGB9fltElWB@hirez.programming.kicks-ass.net>
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201226025117.2770-1-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 26, 2020 at 10:51:08AM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> 06249738a41a ("workqueue: Manually break affinity on hotplug")
> said that scheduler will not force break affinity for us.

So I've been looking at this the past day or so, and the more I look,
the more I think commit:

  1cf12e08bc4d ("sched/hotplug: Consolidate task migration on CPU unplug")

is a real problem and we need to revert it (at least for now).

Let me attempt a brain dump:

 - the assumption that per-cpu kernel threads are 'well behaved' on
   hot-plug has, I think, been proven incorrect, it's far worse than
   just bounded workqueue. Therefore, it makes sense to provide the old
   semantics.

 - making the current code provide the old semantics (forcing affinity
   on per-cpu kernel threads) is tricky, but could probably be done:

    * we need to disallow new per-cpu kthreads while going down
    * we need to force push more agressive; basically when
      rcuwait_active(rq->hotplug_wait) push everything except that task,
      irrespective of is_per_cpu_kthread()
    * we need to disallow wakeups of anything not the hotplug thread or
      stop-machine from happening from the rcuwait_wait_event()

   and I have patches for most of that... except they're adding more
   complexity than 1cf12e08bc4d ever deleted.

However, even with all that, there's a further problem...

Fundamentally, waiting for !rq_has_pinned_tasks() so late in
hot-un-plug, is wrong I think. It means that migrate_disable() code
might encounter a mostly torn down CPU. This is OK-ish for per-cpu
kernel threads [*], but is now exposed to any random odd kernel code
that does migrate_disable().

[*] arguably running 'work' this late is similarly problematic.

Let me go do lunch and ponder this further..

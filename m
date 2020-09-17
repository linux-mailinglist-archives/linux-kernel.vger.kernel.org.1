Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFFB26DE7D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgIQOl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbgIQOkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:40:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFDBC0612F2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 07:39:56 -0700 (PDT)
Date:   Thu, 17 Sep 2020 16:38:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600353531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IsjaeOzKr9oow++4iThZuJ2UeMp6oJKMxaZTXN3CO5Q=;
        b=SEu1J5fEwah4ZH4cIHAp+/6ZDYvKlLpFAEfgEv+mNXFQYi/s9z0cgPVfIrt/qA2M88earO
        sPHfuS44oioiBhqwiFFt8wOpGgBzv55sCZXUvdDMUY4eI5nQdYRadVNKRtHZ+F0uRB5+0a
        S5COCwR4QCnbKO6SKtWed92nNZGac4NFXVx1pZnDRmO57Xr6+67BtoV8Tgyx5KjQnU7je/
        G4naNsraAH1sixXGPfpIAHp4CAfr/G/hwXddCR/1nrr6Ld3dCek51luASq1Uit5++tr7hl
        tc5ZQ3U7zoc4fCsA/PL0U5B+7I9SkfIszvKslFv/ee0rMyGlbTEGpgh5tYxTgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600353531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IsjaeOzKr9oow++4iThZuJ2UeMp6oJKMxaZTXN3CO5Q=;
        b=yhbOPpNiKfVPtlecpO1boF/C9OBpsVg/ivsU8TyilnWN9yzvJzh3g+COBSkhqWY42NdHKA
        lo70Ckyjlnj522DA==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     peterz@infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Scott Wood <swood@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: Re: [patch 09/10] sched/core: Add migrate_disable/enable()
Message-ID: <20200917143850.25akkvr32ojtwohy@linutronix.de>
References: <20200917094202.301694311@linutronix.de>
 <20200917101624.813835219@linutronix.de>
 <20200917142438.GH1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917142438.GH1362448@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-17 16:24:38 [+0200], peterz@infradead.org wrote:
> And if I'm not mistaken, the above migrate_enable() *does* require being
> able to schedule, and our favourite piece of futex:
> 
> 	raw_spin_lock_irq(&q.pi_state->pi_mutex.wait_lock);
> 	spin_unlock(q.lock_ptr);
> 
> is broken. Consider that spin_unlock() doing migrate_enable() with a
> pending sched_setaffinity().

There are two instances of the above and only in the futex code and we
have sort of duct tape for that by manually balancing the migrate
counter so that it does not come to this.
But yes, not having to do the manual balance is a plus.

Sebastian

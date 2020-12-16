Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2695A2DBE62
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 11:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgLPKKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 05:10:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38730 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgLPKKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 05:10:55 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608113413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/DpnWG2VZiw1n/B+lrW0oIhS8lbEl9jOP8otn08LVYo=;
        b=jqHXoCbIPJ064ZTStJP8Y63JgOyPyTchpeMy2rILmyzmeFW4Bhaoqw+g1e6+9sRlkTrRWq
        pl+2uDX3pJfQ7hqFPDeUL7jiUQU6p6hPV0d+3dGkuSGY+y5QUUxxAkJ74hmMUxvqp6YuOv
        kwDrs6dnRdDVrVnK7LSNUqdTX3GogMndyG+Na9yHXVIAKw2DF6AvSZonOjplqqqNx2TDKw
        L9Vr0//AoUOJ0BzmjlzUk3VpbivdIs2PRrjWWyFzEkolrGsfIxgueWAdiYZXzgsWVwF+br
        Lhfu0KBGcK+5c10yvxB0jiVSFcaISMS3u6GYRtTYe7B34HwZbqQ7ZsWla4G2eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608113413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/DpnWG2VZiw1n/B+lrW0oIhS8lbEl9jOP8otn08LVYo=;
        b=kMvDAoh2HG6BGW/U9DzwYN+N6ux2FUz1x6p/PPMsN0AssxV7JJw6S9RtpWVjcvaWvXPBmN
        2X4yYbOuoAWmFQAw==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] sched: Prevent raising SCHED_SOFTIRQ when CPU is !active
In-Reply-To: <20201216081904.GK3040@hirez.programming.kicks-ass.net>
References: <20201215104400.9435-1-anna-maria@linutronix.de> <20201215111806.GF3040@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.2012151449260.1448@somnus> <20201215093415.5b2898ef@gandalf.local.home> <20201215150529.GI3040@hirez.programming.kicks-ass.net> <87mtyft0r2.fsf@nanos.tec.linutronix.de> <20201216081904.GK3040@hirez.programming.kicks-ass.net>
Date:   Wed, 16 Dec 2020 11:10:12 +0100
Message-ID: <87zh2erri3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16 2020 at 09:19, Peter Zijlstra wrote:
> On Tue, Dec 15, 2020 at 06:52:49PM +0100, Thomas Gleixner wrote:
>> I might be missing something, but how is the CPU which runs the pinned
>> kernel thread, i.e. the hotplug thread, supposed to go idle between the
>> two calls?
>
> Take a mutex or something other daft. My disabling preemption around it
> we basically assert the two functions are non-blocking and none of that
> cruft matters.

That'd be really daft, but yes we can do that for paranoia sake.

Thanks,

        tglx

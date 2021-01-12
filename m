Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CCE2F37B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392260AbhALRxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:53:39 -0500
Received: from foss.arm.com ([217.140.110.172]:50476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390631AbhALRxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:53:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CBB91042;
        Tue, 12 Jan 2021 09:52:53 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 049213F66E;
        Tue, 12 Jan 2021 09:52:51 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Paul McKenney <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH -tip V3 0/8] workqueue: break affinity initiatively
In-Reply-To: <CAJhGHyA0rfR92W7T7RnhPrmLMkmV4Mb7fUSeG2VEHhsH-pSxsw@mail.gmail.com>
References: <20201226025117.2770-1-jiangshanlai@gmail.com> <X/hGHNGB9fltElWB@hirez.programming.kicks-ass.net> <87o8hv7pnd.fsf@nanos.tec.linutronix.de> <X/wv7+PP8ywNYmIS@hirez.programming.kicks-ass.net> <X/yH9+MGa1JCNZ8x@hirez.programming.kicks-ass.net> <jhj7doj1dr1.mognet@arm.com> <X/yzrJw4UbQsK3KB@hirez.programming.kicks-ass.net> <CAJhGHyA0rfR92W7T7RnhPrmLMkmV4Mb7fUSeG2VEHhsH-pSxsw@mail.gmail.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Tue, 12 Jan 2021 17:52:46 +0000
Message-ID: <jhjzh1eyrdd.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/21 12:33, Lai Jiangshan wrote:
>> I thought only pcpu pools would get the POOL_DISASSOCIATED flag on
>> offline, but it seems unbound pools also get it at init time. Did I get
>> that right?
>
> You are right.
>
> The POOL_DISASSOCIATED flag indicates whether the pool is concurrency
> management or not (negative way, POOL_DISASSOCIATED means "not concurrency
> management"). So it should be applied for all unbound pools.
>
> When !POOL_DISASSOCIATED means it is a percpu pool, and the pool->cpu
> is online and the offline callback has not been called yet even the pool->cpu
> is going to be offline.  So !POOL_DISASSOCIATED is used a lot in the code.

Thanks!

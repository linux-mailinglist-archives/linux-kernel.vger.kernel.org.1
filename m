Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9C82D17BD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgLGRp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:45:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38000 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgLGRp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:45:28 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607363086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1QUndeheCuNlov7jkNGxkSugjzDYPAV/QAtYJEVlMGg=;
        b=C9+xbwFql+APDD1YZq7/d2stuP1bjVimKp0efMSS7EYEf4mfxoZMP0Qm2mRQpTZwjzI6vu
        bhIUYVX2zwSkfL0B+pm+B9EbkhUi+t+++UbHL3wKmVBUX94UkYGy4rnvS5QDN1ewWX5M3v
        RhgJ8polMJPr6Cw+vDftdGFkLymWZYgYykUuA44O+6LzRig3CRk9ATSElWxwOLrrNiV3wA
        0w0IQaZUVJPGiN0kfW13N9Cec3qDGhLGwA8DyTzOFw0WcNSVga89kvrPig+G9SfdIpaSJR
        kFGiKZVWsm2RuYp1Tsy2vbskgEuUV+ds7V13wPCa0hdp7tWSIdI2gb2ORhv+iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607363086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1QUndeheCuNlov7jkNGxkSugjzDYPAV/QAtYJEVlMGg=;
        b=f3NkeE7MPmTwjy9im/Z/sOUSYpCeI8OpMoGQMy+KE9uq400FeM2UGFkkt363hZRAXszVAL
        YFGX9xhRtR7Ps/Bw==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Will Deacon <will@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [patch 1/3] tick: Remove pointless cpu valid check in hotplug code
In-Reply-To: <20201207115953.GR3021@hirez.programming.kicks-ass.net>
References: <20201206211253.919834182@linutronix.de> <20201206212002.582579516@linutronix.de> <20201207115953.GR3021@hirez.programming.kicks-ass.net>
Date:   Mon, 07 Dec 2020 18:44:46 +0100
Message-ID: <871rg15x4h.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07 2020 at 12:59, Peter Zijlstra wrote:
> On Sun, Dec 06, 2020 at 10:12:54PM +0100, Thomas Gleixner wrote:
>
>>  void tick_handover_do_timer(void)
>>  {
>> +	if (tick_do_timer_cpu == smp_processor_id())
>> +		tick_do_timer_cpu = cpumask_first(cpu_online_mask);
>
> For the paranoid amongst us, would it make sense to add something like:
>
> 	/*
> 	 * There must always be at least one online CPU.
> 	 */
> 	WARN_ON_ONCE(tick_do_timer_cpu >= nr_cpu_ids);

And add that to all places which look at online mask during hotplug.

If we really care we can add it somewhere central in the hotplug
code. If that ever triggers then the wreckaged tick duty is just
uninteresting.

Thanks,

        tglx

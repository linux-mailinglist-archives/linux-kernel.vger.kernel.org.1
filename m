Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF33D2DC84A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 22:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgLPVYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 16:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgLPVYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 16:24:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406DCC06179C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 13:23:59 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608153837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CD16dqcpUQKgPHdjRPxV49zv42Pzi+VzliQWGRIcOig=;
        b=Ub79IKit15RTidyWUv8Baw+gzGr16YVFpOAJYNYJYpcP31+3cDwOqhsw2K627j1h9eB4GR
        AijKH7ZN66d2Zzx8uV9BadaibM/uFX7h3nuF+HgQJsnF1iD7OjDEbHlIK+uRpYlSdAPzBX
        uC6A2CTZqgNASCcsi/+yeANejrFr0M41QNqile2Ic/UTkSlCGHVro15P7pUnujEikTznmj
        b1UhWNffTZSZOTPtOOhdmFeZUr4OHbGmcHpRA5dxaq2m3jJ/6Jhd0VWpFek0jGwpyNvi/U
        7wEfnRWgeV9H93Iz8COTQN/WTZY165A8nA8MAwnZUQJvzF1+y9UoI394lDK4Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608153837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CD16dqcpUQKgPHdjRPxV49zv42Pzi+VzliQWGRIcOig=;
        b=CkPhA/jVIBdYmM5JCZCqTEyofHJZe/vHpvWQqgv/pPq7LCxUf6w9v42sFICL2cEcoKJJTW
        kjpWYIgfWRuhqrDA==
To:     paulmck@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Will Deacon <will@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        syzbot+23a256029191772c2f02@syzkaller.appspotmail.com,
        syzbot+56078ac0b9071335a745@syzkaller.appspotmail.com,
        syzbot+867130cb240c41f15164@syzkaller.appspotmail.com
Subject: Re: [patch 3/3] tick: Annotate tick_do_timer_cpu data races
In-Reply-To: <20201216211931.GL2657@paulmck-ThinkPad-P72>
References: <20201206211253.919834182@linutronix.de> <20201206212002.876987748@linutronix.de> <20201207120943.GS3021@hirez.programming.kicks-ass.net> <87y2i94igo.fsf@nanos.tec.linutronix.de> <CANpmjNNQiTbnkkj+ZHS5xxQuQfnWN_JGwSnN-_xqfa=raVrXHQ@mail.gmail.com> <20201207194406.GK2657@paulmck-ThinkPad-P72> <20201208081129.GQ2414@hirez.programming.kicks-ass.net> <20201208150309.GP2657@paulmck-ThinkPad-P72> <873606tx1c.fsf@nanos.tec.linutronix.de> <20201216211931.GL2657@paulmck-ThinkPad-P72>
Date:   Wed, 16 Dec 2020 22:23:57 +0100
Message-ID: <87czz9savm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16 2020 at 13:19, Paul E. McKenney wrote:
> On Wed, Dec 16, 2020 at 01:27:43AM +0100, Thomas Gleixner wrote:
>> So my intent was to document that this code does not care about anything
>> else than what I'd consider to be plain compiler bugs.
>> 
>> My conclusion might be wrong as usual :)
>
> Given that there is no optimization potential, then the main reason to use
> data_race() instead of *_ONCE() is to prevent KCSAN from considering the
> accesses when looking for data races.  But that is mostly for debugging
> accesses, in cases when these accesses are not really part of the
> concurrent algorithm.
>
> So if I understand the situation correctly, I would be using *ONCE().

Could this be spelled out somewhere in Documentation/ please?

Thanks,

        tglx

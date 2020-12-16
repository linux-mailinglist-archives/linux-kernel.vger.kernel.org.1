Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C082DB7CA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 01:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgLPA21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 19:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgLPA2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 19:28:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77881C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 16:27:45 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608078463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9oM6XJd59woVYfiyCB+uESYOvCyhYxaqi5O1krN5wgo=;
        b=v7rJUlwY4m0n0Vbhn6TAQAHlty9gsG6bryBhjGqOnxsTvKe7StHa9KJ8mXKH8irj9gsZph
        7v4YugnH4H9EVR4s/yBeOfEAV5qu2owOUcuT7sW/Rxq8QN95u7m/osCMOvzvBtI9UJAbnn
        ANJ7MHlNrBSCWiu1ofwR8QDoDhSq1NJ0mFNlSZ9cgDGlITfnhTUaQteDBpP61DWiVD/3cI
        JY62weSHJ4sLEAb0UauwVlwmdJdHGL0z/n9ROTCLoOYtzmQtM3I2SVzwPmZBXTPRZYJQHP
        5vmPbIosMPAm7SJJRR5wHDIlP8fGzQ/cs5qlHExUkbtb9mByfNkbo8FjZc/j3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608078463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9oM6XJd59woVYfiyCB+uESYOvCyhYxaqi5O1krN5wgo=;
        b=ccIALfQ05CQjLixNenK1GYtU+/2cMyW4jv3ajGXGKWvk3xHzRQ4H2yGhfjidzb0+nliMQP
        nH2Lw7tx1Ic3BnCw==
To:     paulmck@kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>,
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
In-Reply-To: <20201208150309.GP2657@paulmck-ThinkPad-P72>
References: <20201206211253.919834182@linutronix.de> <20201206212002.876987748@linutronix.de> <20201207120943.GS3021@hirez.programming.kicks-ass.net> <87y2i94igo.fsf@nanos.tec.linutronix.de> <CANpmjNNQiTbnkkj+ZHS5xxQuQfnWN_JGwSnN-_xqfa=raVrXHQ@mail.gmail.com> <20201207194406.GK2657@paulmck-ThinkPad-P72> <20201208081129.GQ2414@hirez.programming.kicks-ass.net> <20201208150309.GP2657@paulmck-ThinkPad-P72>
Date:   Wed, 16 Dec 2020 01:27:43 +0100
Message-ID: <873606tx1c.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08 2020 at 07:03, Paul E. McKenney wrote:

> On Tue, Dec 08, 2020 at 09:11:29AM +0100, Peter Zijlstra wrote:
>> On Mon, Dec 07, 2020 at 11:44:06AM -0800, Paul E. McKenney wrote:
>> 
>> > Also, in this particular case, why data_race() rather than READ_ONCE()?
>> > Do we really expect the compiler to be able to optimize this case
>> > significantly without READ_ONCE()?

There is probably not much optimization potential for the compiler if
data_race() is used vs. READ/WRITE_ONCE() in this code.

>> It's about intent and how the code reads. READ_ONCE() is something
>> completely different from data_race(). data_race() is correct here.
>
> Why?

Lemme answer that to the extent why _I_ chose data_race() - aside of my
likely confusion over our IRC conversation.

The code does not really care about the compiler trying to be clever or
not as it is designed to be tolerant of all sorts of concurrency
including competing writes. It does not care about multiple reloads
either.  It neither cares about invented stores as long as these
invented stores are not storing phantasy values.

The only thing it cares about is store/load tearing, but there is no
'clever' way to use that because of the only valid transitions of
'cpunr' which comes from smp_processor_id() to TICK_DO_TIMER_NONE which
is the only constant involved or the other way round (which is
intentionally subject to competing stores).

If the compiler is free to store the 32bit value as 4 seperate bytes or
does invented stores with phantasy values, then there is surely a reason
to switch to READ/WRITE_ONCE(), but that'd be a really daft reason.

So my intent was to document that this code does not care about anything
else than what I'd consider to be plain compiler bugs.

My conclusion might be wrong as usual :)

Thanks,

        tglx





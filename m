Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381A52D19EC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 20:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgLGToE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 14:44:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38484 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgLGToD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:44:03 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607370201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I334otsRnjsdPvZNHbr6PY/AxaoibaWvPiqif0DnRJQ=;
        b=JZByJyfFmV0EhRPwqzzi+wmjs2CjVeN5+RRB0rc76BuIQQpNTBqr+mZN8qvu5Gmcsn9b2f
        jWg5sSC4b7/l50RmsuVuDQsYZf7YnUg7sXKrxB2tAppho6b5BJcCAxkJpwx8wUOcx1Ao3o
        Z5ybNdP7LJS8XNdfyqUpOjGXvMo/EnY5wNwcTENI/G9iYpC+J1bTK52P04DuSFE0OgMpDV
        XfHO9VrKs54LAq23igdAJtS24Lkq7KtIpl5nJ93NGzifTFNHHHSwqDLpttqTVvap6ClZzS
        cV0GGL/eNiAMTNgRKrn5IjjpcOO+oYI4Mm8GkTGsaihOPXUNqb+TW7ZCVOqbHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607370201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I334otsRnjsdPvZNHbr6PY/AxaoibaWvPiqif0DnRJQ=;
        b=iWz5rZ60m9F4yyaFdHSTlDi1PJXZWUurgulnQya5jua2xiG9HSIYpZLxgOsJ6NJoFVoCQk
        t1/nYwc2w4hqhCDw==
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Will Deacon <will@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        syzbot+23a256029191772c2f02@syzkaller.appspotmail.com,
        syzbot+56078ac0b9071335a745@syzkaller.appspotmail.com,
        syzbot+867130cb240c41f15164@syzkaller.appspotmail.com
Subject: Re: [patch 3/3] tick: Annotate tick_do_timer_cpu data races
In-Reply-To: <CANpmjNNQiTbnkkj+ZHS5xxQuQfnWN_JGwSnN-_xqfa=raVrXHQ@mail.gmail.com>
References: <20201206211253.919834182@linutronix.de> <20201206212002.876987748@linutronix.de> <20201207120943.GS3021@hirez.programming.kicks-ass.net> <87y2i94igo.fsf@nanos.tec.linutronix.de> <CANpmjNNQiTbnkkj+ZHS5xxQuQfnWN_JGwSnN-_xqfa=raVrXHQ@mail.gmail.com>
Date:   Mon, 07 Dec 2020 20:43:21 +0100
Message-ID: <87eek14d2e.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07 2020 at 19:19, Marco Elver wrote:
> On Mon, 7 Dec 2020 at 18:46, Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Mon, Dec 07 2020 at 13:09, Peter Zijlstra wrote:
>> > I prefer the form:
>> >
>> >       if (data_race(tick_do_timer_cpu == TICK_DO_TIMER_BOOT)) {
>> >
>> > But there doesn't yet seem to be sufficient data_race() usage in the
>> > kernel to see which of the forms is preferred. Do we want to bike-shed
>> > this now and document the outcome somewhere?
>>
>> Yes please before we get a gazillion of patches changing half of them
>> half a year from now.
>
> That rule should be as simple as possible. The simplest would be:
> "Only enclose the smallest required expression in data_race(); keep
> the number of required data_race() expressions to a minimum." (=> want
> least amount of code inside data_race() with the least number of
> data_race()s).
>
> In the case here, that'd be the "if (data_race(tick_do_timer_cpu) ==
> ..." variant.
>
> Otherwise there's the possibility that we'll end up with accesses
> inside data_race() that we hadn't planned for. For example, somebody
> refactors some code replacing constants with variables.
>
> I currently don't know what the rule for Peter's preferred variant
> would be, without running the risk of some accidentally data_race()'d
> accesses.

I agree. Lets keep it simple and have the data_race() only covering the
actual access to the racy variable, struct member.

The worst case we could end up with would be

    if (data_race(A) == data_race(B))

which would still be clearly isolated. The racy part is not the
comparison, it's the accesses which can cause random results for the
comparison.

Thanks,

        tglx



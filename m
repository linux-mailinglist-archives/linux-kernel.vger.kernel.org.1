Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFE92D186B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgLGSUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 13:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLGSUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:20:44 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD120C061794
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 10:20:03 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id b62so13375979otc.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 10:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/cDWtNYa74vRqhGITCqKQSyTcWEEsS+Eii6uHXqsS8E=;
        b=AL3RDltqpqgmduIWDHjvNYyzEa+ZPRYadSyB0h4WdZo3xluwhakDvp1cQmCT48hkub
         yBkbrzlKWD6ejXvNg6L4lm4h3B2h7Mf66PqmJQenszMaZ06XRi+ulpNZSd+dTJwdTBZc
         hbU4fqB4z6UxnGzOWeEJMRaCrOUvhyxXcjjKjARndpNKrHg6oKy89IIBevbkdVeAxHcU
         gW+/lUx5PKDqj57v2Si3YaTpQf5GU634VgW8RCtdum4plJTkCAl+jMU/0Eh3jtASqxJV
         afhrT3rJzF3n3jVJmLB9VQ+KOS1E4T1aFvFyUp2v7VEhdSAp0n4oVuUX0CKy5J9Euenu
         dY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/cDWtNYa74vRqhGITCqKQSyTcWEEsS+Eii6uHXqsS8E=;
        b=njUUcjBh0/1y12VLzmWKhC/C2trT7DWrXpr26NGGa0qJlTpssE6AoPrYGppFLArXwH
         p6U1HNnOZ+Fc4WxYuMLJiJgTFhyS2Ydq2Yeh4NHSdOJ54UzIO0MzDyJK+xxf7clOykvc
         Ht4orWtM3BtJ4p3FocQp1WpxZc98v6ZOcDBZm6u5wiFT0st+Hq+uda1ln8ScSxvVs5wb
         fxEOQk1xwuORGhr8kxkL/iDDi4LZz6SwHPU2IDkOh1/M+PlIBrj7wMCF7jy7ntadGC5O
         hsnNRmCwt11uJFQ9LNLheeMv9O2d6PIVIaOKUvA/Xv4IeXnDeyatrYW1x9tozW5xP2Av
         smEg==
X-Gm-Message-State: AOAM530XdDiHaLgcEAH0phbXxTai96YRj8CarQru/FuRSZTTQXDvpR8m
        fxXo3XFUhqpkmH7FQz2tA6hNjZHGPBL4X72BxCleYA==
X-Google-Smtp-Source: ABdhPJxkeJ9ro+SBXKNHnoK6fnFijdJY9IFYH7p4npTa3Z7QdF4q+/uAiAqFaGOZKMug1TrYiXm0e3rE+/Z8cZ2/hiM=
X-Received: by 2002:a9d:7cc8:: with SMTP id r8mr14105256otn.233.1607365203049;
 Mon, 07 Dec 2020 10:20:03 -0800 (PST)
MIME-Version: 1.0
References: <20201206211253.919834182@linutronix.de> <20201206212002.876987748@linutronix.de>
 <20201207120943.GS3021@hirez.programming.kicks-ass.net> <87y2i94igo.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87y2i94igo.fsf@nanos.tec.linutronix.de>
From:   Marco Elver <elver@google.com>
Date:   Mon, 7 Dec 2020 19:19:51 +0100
Message-ID: <CANpmjNNQiTbnkkj+ZHS5xxQuQfnWN_JGwSnN-_xqfa=raVrXHQ@mail.gmail.com>
Subject: Re: [patch 3/3] tick: Annotate tick_do_timer_cpu data races
To:     Thomas Gleixner <tglx@linutronix.de>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Dec 2020 at 18:46, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, Dec 07 2020 at 13:09, Peter Zijlstra wrote:
> > On Sun, Dec 06, 2020 at 10:12:56PM +0100, Thomas Gleixner wrote:
> >> +            if (data_race(tick_do_timer_cpu) == TICK_DO_TIMER_BOOT) {
> >
> > I prefer the form:
> >
> >       if (data_race(tick_do_timer_cpu == TICK_DO_TIMER_BOOT)) {
> >
> > But there doesn't yet seem to be sufficient data_race() usage in the
> > kernel to see which of the forms is preferred. Do we want to bike-shed
> > this now and document the outcome somewhere?
>
> Yes please before we get a gazillion of patches changing half of them
> half a year from now.

That rule should be as simple as possible. The simplest would be:
"Only enclose the smallest required expression in data_race(); keep
the number of required data_race() expressions to a minimum." (=> want
least amount of code inside data_race() with the least number of
data_race()s).

In the case here, that'd be the "if (data_race(tick_do_timer_cpu) ==
..." variant.

Otherwise there's the possibility that we'll end up with accesses
inside data_race() that we hadn't planned for. For example, somebody
refactors some code replacing constants with variables.

I currently don't know what the rule for Peter's preferred variant
would be, without running the risk of some accidentally data_race()'d
accesses.

Thoughts?

Thanks,
-- Marco

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACC02C8C19
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387939AbgK3SFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387933AbgK3SFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:05:34 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27195C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:04:48 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id z1so19351139ljn.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9JuVKWRtZEgKpwFbHP3K2SoaXzCRmKF5M5FbK+j5HJ8=;
        b=M57ZRtiqbxbjwJNhj18+/nizGqp5PJ9YQYutq26hu7gjlHrxXrY5bPRF1nL1lp+f3m
         WT5SMjItB4Kqnyu+A8+8sb1TEo6/QtxbK2qkxvg0hA0iMMcPyG3Lmf8Mv/NVLobqXju9
         YPy/+XF74KBQ6KNp/PnFtUcs8+U7bI0wDaAU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9JuVKWRtZEgKpwFbHP3K2SoaXzCRmKF5M5FbK+j5HJ8=;
        b=ZIY2oTeUWu9klbAh5vfZI2EF+oJyTicVdxdbLnAXpkkXOVMXiBEXrnCWSPAkxrB4/4
         OI5dBX3KKGkZGLm31KwKlfRUdHlsbkWKMoSjEYtwdSntOYKdwEM46wct2iG4+i+tGV++
         T55aDISJqqh1GTSpVYMhMctEOh3ans7Ooy9mJldOPMKuP6T+3ni2IXqCt02wBAezEwyP
         WxY3ZDXUOgdOkay7Kbe5fvvyNo8dBV0WtnFPkS0f1eMnbLZvBZPxo7jv7NWiUuDTXEcF
         udzWpCmd8cpAOpJBH4FbYTLOV9Yk+h7P7RCFEENeuEWWQDVk8zYIezYy5P2vNe99zQYa
         iieQ==
X-Gm-Message-State: AOAM5318R40PSvA23pdjk2b4pktS4aLLMJTQPhLi1/7iHJVd4swkqN5c
        R2jVTX376rYmY3LAG2mzVXPbowH0h7Q4WA==
X-Google-Smtp-Source: ABdhPJyOH9tKFaGC3CutaOrIL6VO/1rfQQCegVVEndeHFiec9Jr7i72I7cmXvpt+uPtMjcxJUMTJiw==
X-Received: by 2002:a2e:a404:: with SMTP id p4mr10342006ljn.420.1606759486072;
        Mon, 30 Nov 2020 10:04:46 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id n130sm2492032lfd.213.2020.11.30.10.04.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 10:04:45 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id z21so23334214lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:04:44 -0800 (PST)
X-Received: by 2002:a19:ed0f:: with SMTP id y15mr9299477lfy.352.1606759484151;
 Mon, 30 Nov 2020 10:04:44 -0800 (PST)
MIME-Version: 1.0
References: <160665707945.2808.5384034634184489471.tglx@nanos>
 <160665708065.2808.15317906761841446715.tglx@nanos> <CAHk-=wi3o-wwFVbAXb7YZZViDBsZ_yMVqyOAEZsx5qcskLsOcg@mail.gmail.com>
 <20201130075651.GJ2414@hirez.programming.kicks-ass.net> <yt9dh7p78d8l.fsf@linux.ibm.com>
 <yt9dpn3v3u1m.fsf@linux.ibm.com> <20201130125211.GN2414@hirez.programming.kicks-ass.net>
 <20201130130315.GJ3092@hirez.programming.kicks-ass.net>
In-Reply-To: <20201130130315.GJ3092@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Nov 2020 10:04:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=whSdxfCW3YpoZafPaCD_DQsuxFWMKLyYFsdGWL2wu9haQ@mail.gmail.com>
Message-ID: <CAHk-=whSdxfCW3YpoZafPaCD_DQsuxFWMKLyYFsdGWL2wu9haQ@mail.gmail.com>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 5:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > But but but...
> >
> >   do_idle()                   # IRQs on
> >     local_irq_disable();      # IRQs off
> >     defaul_idle_call()        # IRQs off
>         lockdep_hardirqs_on();  # IRQs off, but lockdep things they're on
> >       arch_cpu_idle()         # IRQs off
> >         enabled_wait()        # IRQs off
> >         raw_local_save()      # still off
> >         psw_idle()            # very much off
> >           ext_int_handler     # get an interrupt ?!?!
>               rcu_irq_enter()   # lockdep thinks IRQs are on <- FAIL
>
> I can't much read s390 assembler, but ext_int_handler() has a
> TRACE_IRQS_OFF, which would be sufficient to re-align the lockdep state
> with the actual state, but there's some condition before it, what's that
> test and is that right?

I think that "psw_idle()" enables interrupts, exactly like x86 does.
See my previous email.

But no, I can't read s390 asm either. IBM is notorious for making up
odd IBM-only incomprehensible names. When "oi" means "or immediate", I
personally start suspecting that there were some "happy drugs"
involved.

To make matters worse, some of the assembly code in psw_idle isn't
even assembly code, it's machine code, with "BPON" being an
alternative instruction definition with just the hex encoding for the
machine code instruction rather than any actual human-legible
instruction encoding.

Of course, when the "human-legible" instructions are "oi", I guess hex
codes aren't all that much less legible..

s390 programmers must be some super-human breed. Or, alternatively,
they are munching happy pills by the truck-load to get over the pain
;)

           Linus

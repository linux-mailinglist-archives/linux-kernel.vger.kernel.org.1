Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEAD2CF52F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 20:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388147AbgLDTy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 14:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbgLDTy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 14:54:29 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A12AC061A51
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 11:53:49 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id f11so7457801oij.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 11:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uovmCUxUV2XC7RFIwwrup7x/dcZweDNtrR8W3IZoNxo=;
        b=nA2GNzWPBT3QyDRifKe5iezCOKMjXHINbZrXYH7F1JT5LBsslp4/pGusqnMe7oEpao
         5UFhjPUH2RIO2SeyIXjFopGsJkd0EAVycdDQsmenMCodb6lO9U5IS3oZ8YjlGynGZZuK
         sw76IRSK3ZWOu33q0ScLHKC9GfbmA3GflBSR3LKA1BQQM5Qz0fHtguzu+tVLup5NlzTi
         Bn5oge5x6GU2ysLt4yHaa8gv1JP1P8cZrFnE20dhbyIAX7ENw+cuy+wHrJ6tPN4DZWbY
         f4FaF5UqNkyy6VKNhtu9Csp4JU4L8L8ZUYVRdHQ6oqE0D3sQ3fx796CzPo7jEazIF7S8
         3OCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uovmCUxUV2XC7RFIwwrup7x/dcZweDNtrR8W3IZoNxo=;
        b=ZQkPvEH62U7gdbq5SV+u+ItqtJyoKbnyE2B4h0lIlQXS5VBO2i/+X9fYqd5tomjv0P
         ReQJf2VGxPaLpTHeBrukUr9ZPC3DScTJuQ4kVEMU77h3zO0qhK7siuAebLTo5+Skz93H
         44kulvL5bHTuEQRG1e4rVuuMMahID0FcEOOvUDcZsLfJNFwmQxodIQiUwVv7PRdZ5XWO
         U75Gfflep+Ov2ND0WfsrxQOgxUn8JpJ+yJ34OHCApow5L95ZpVquDCQdDROfHVep5tRi
         PmXlP/Ztj6/RttA8YrHCOSWEQ1D9SLISHW+GrFdchl10Prc6+89y3pedba5k7YKSuuBp
         /2tw==
X-Gm-Message-State: AOAM530waKHUwdRaSDvE4PtHAJzcoCPrVqPTgTVbJU0gR+Lby0WW4aBT
        YS1U31cDwBNvuBt2WxJ31kCKdFyhi+2NyIT4dAy/Cw==
X-Google-Smtp-Source: ABdhPJxq86hrkdIyQHPvAu6M847wDbq10D41IpbgkVRN42F8ZK4o3jO2CXx/PsNsA7WK33Y3suogILK1DqrytjqcwZY=
X-Received: by 2002:aca:448b:: with SMTP id r133mr2307367oia.121.1607111628147;
 Fri, 04 Dec 2020 11:53:48 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsHo-9tmxCKGticDowF8e3d1RkcLamapOgMQqeP6OdEEg@mail.gmail.com>
In-Reply-To: <CA+G9fYsHo-9tmxCKGticDowF8e3d1RkcLamapOgMQqeP6OdEEg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 4 Dec 2020 20:53:36 +0100
Message-ID: <CANpmjNPpOym1eHYQBK4TyGgsDA=WujRJeR3aMpZPa6Y7ahtgKA@mail.gmail.com>
Subject: Re: BUG: KCSAN: data-race in tick_nohz_next_event / tick_nohz_stop_tick
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, rcu@vger.kernel.org,
        lkft-triage@lists.linaro.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, fweisbec@gmail.com,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 at 20:04, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> LKFT started testing KCSAN enabled kernel from the linux next tree.
> Here we have found BUG: KCSAN: data-race in tick_nohz_next_event /
> tick_nohz_stop_tick

Thank you for looking into KCSAN. Would it be possible to collect
these reports in a moderation queue for now?

I'm currently trying to work out a strategy on how to best proceed
with all the data races in the kernel. We do know there are plenty. On
syzbot's internal moderation queue, we're currently looking at >300 of
them (some here:
https://syzkaller.appspot.com/upstream?manager=ci2-upstream-kcsan-gce).
Part of this strategy involves prioritizing certain concurrency bug
classes. Let's define the following buckets for concurrency bugs:

A. Data race, where failure due to current compilers is unlikely
(supposedly "benign"); merely marking the accesses
appropriately is sufficient. Finding a crash for these will
require a miscompilation, but otherwise look "benign" at the
C-language level.

B. Race-condition bugs where the bug manifests as a data race,
too -- simply marking things doesn't fix the problem. These
are the types of bugs where a data race would point out a
more severe issue.

C. Race-condition bugs where the bug never manifests as a data
race. An example of these might be 2 threads that acquire the
necessary locks, yet some interleaving of them still results
in a bug (e.g. because the logic inside the critical sections
is buggy). These are harder to detect with KCSAN as-is, and
require using ASSERT_EXCLUSIVE_ACCESS() or
ASSERT_EXCLUSIVE_WRITER() in the right place. See
https://lwn.net/Articles/816854/.

One problem currently is that the kernel has quite a lot type-(A)
reports if we run KCSAN, which makes it harder to identify bugs of type
(B) and (C). My wish for the future is that we can get to a place, where
the kernel has almost no unintentional (A) issues, so that we primarily
find (B) and (C) bugs.

The report below looks to be of type (A). Generally, the best strategy
for resolving these is to send a patch, and not a report. However, be
aware that sometimes it is really quite difficult to say if we're
looking at a type (A) or (B) issue, in which case it may still be fair
to send a report and briefly describe what you think is happening
(because that'll increase the likelihood of getting a response). I
recommend also reading "Developer/Maintainer data-race strategies" in
https://lwn.net/Articles/816854/ -- specifically note "[...] you
should not respond to KCSAN reports by mindlessly adding READ_ONCE(),
data_race(), and WRITE_ONCE(). Instead, a patch addressing a KCSAN
report must clearly identify the fix's approach and why that approach
is appropriate."

I recommend reading https://lwn.net/Articles/816850/ for more details.

> This report is from an x86_64 machine clang-11 linux next 20201201.
> Since we are running for the first time we do not call this regression.
>
> [   47.811425] BUG: KCSAN: data-race in tick_nohz_next_event /
> tick_nohz_stop_tick
> [   47.818738]
> [   47.820239] write to 0xffffffffa4cbe920 of 4 bytes by task 0 on cpu 2:
> [   47.826766]  tick_nohz_stop_tick+0x8b/0x310
> [   47.830951]  tick_nohz_idle_stop_tick+0xcb/0x170
> [   47.835571]  do_idle+0x193/0x250
> [   47.838804]  cpu_startup_entry+0x25/0x30
> [   47.842728]  start_secondary+0xa0/0xb0
> [   47.846482]  secondary_startup_64_no_verify+0xc2/0xcb
> [   47.851531]
> [   47.853034] read to 0xffffffffa4cbe920 of 4 bytes by task 0 on cpu 3:
> [   47.859473]  tick_nohz_next_event+0x165/0x1e0
> [   47.863831]  tick_nohz_get_sleep_length+0x94/0xd0
> [   47.868539]  menu_select+0x250/0xac0
> [   47.872116]  cpuidle_select+0x47/0x50
> [   47.875781]  do_idle+0x17c/0x250
> [   47.879015]  cpu_startup_entry+0x25/0x30
> [   47.882942]  start_secondary+0xa0/0xb0
> [   47.886694]  secondary_startup_64_no_verify+0xc2/0xcb
> [   47.891743]
> [   47.893234] Reported by Kernel Concurrency Sanitizer on:
> [   47.898541] CPU: 3 PID: 0 Comm: swapper/3 Not tainted
> 5.10.0-rc6-next-20201201 #2
> [   47.906017] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.2 05/23/2018

This report should have line numbers, otherwise it's impossible to say
which accesses are racing.

[ For those curious, this is the same report on syzbot's moderation
queue, with line numbers:
https://syzkaller.appspot.com/bug?id=d835c53d1a5e27922fcd1fbefc926a74790156cb
]

Thanks,
-- Marco

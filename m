Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C15274DE9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 02:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgIWAjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 20:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgIWAjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 20:39:40 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01302C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 17:39:40 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id y190so11429584vsy.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 17:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jj1r9tLged97F5AbFgeeEBaFajSrumltaZKPQuPBlrg=;
        b=WoHKoq4PalUO9za9IB9gMlTq/dUFtDx4cBTHI3h6Gyqx+JnCI926JwDUp3cQEOmNZx
         lKtFZ2bEhoLvGGOehwF9wqUiXu2lPuKw1bKF+K0s2FnHrG9hEtXbx7JuLQ3Kh8BbVq1k
         tipIwm2aVCrxqsxW6mig7D2vPB7jXM2bwPkAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jj1r9tLged97F5AbFgeeEBaFajSrumltaZKPQuPBlrg=;
        b=YbgBsa5SG9ZtPAXhFQ2jdzKdTl+BpKn5zoUN4fLSMTC9XlYeSmc7/kfPgQosMC2Zeg
         6bGRSLahGwEuqJfjsajm+XbXmIA1hbOmz1P1OFi9m/xR1MVIb1fMJDrmj6Q5+kIDnFf+
         q6eWG3DZlkLlLkdMHiJfYIQlhWkqj1X0nQqbbGY+Bk5NPPtn1w4clxk4H7VwjZfJwquu
         TBPeBMyxOpWJe4RvuKXTMkEC8POXEgAqfvSzPYrfZDksph6BtE370+atgokk1VLOvJZY
         8sGNE71N1E3ksV3F1OYySYp/kwSfH3r9z14jnFyJ/4IuNYSV+dGN9aGOUZCdPAZlLGfu
         klSA==
X-Gm-Message-State: AOAM532BglDohNp0lkdImZtqI8QyFgYy9ljZqY9yn7z+4JyxyifabKng
        8YY5sVki8GLlJXwpCjcFEY8NxHhmvG6vlg==
X-Google-Smtp-Source: ABdhPJxZaKTaklU9a9HHZkhx4aqYA0BCNZcCAHzjHhC8y3wSXXlw6qu+uHLhYJLWM4gSIvr45ilClA==
X-Received: by 2002:a67:fe57:: with SMTP id m23mr5555993vsr.56.1600821578794;
        Tue, 22 Sep 2020 17:39:38 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id d5sm2495009vkf.39.2020.09.22.17.39.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 17:39:37 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id q13so4754493vkd.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 17:39:37 -0700 (PDT)
X-Received: by 2002:a1f:a905:: with SMTP id s5mr5490786vke.9.1600821576719;
 Tue, 22 Sep 2020 17:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200921172603.1.Id9450c1d3deef17718bd5368580a3c44895209ee@changeid>
 <CAMj1kXH4XUS7g8FMZ1noboyZB28B08MTzjEGKpUVLZPAbq1wQA@mail.gmail.com>
In-Reply-To: <CAMj1kXH4XUS7g8FMZ1noboyZB28B08MTzjEGKpUVLZPAbq1wQA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Sep 2020 17:39:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V1by2=VpbRKzcuRaW6+jj8yL4MwLZf06Nn6oq=GXrOOQ@mail.gmail.com>
Message-ID: <CAD=FV=V1by2=VpbRKzcuRaW6+jj8yL4MwLZf06Nn6oq=GXrOOQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: crypto: Add an option to assume NEON XOR is the fastest
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 11:25 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 22 Sep 2020 at 02:27, Douglas Anderson <dianders@chromium.org> wrote:
> >
> > On every boot time we see messages like this:
> >
> > [    0.025360] calling  calibrate_xor_blocks+0x0/0x134 @ 1
> > [    0.025363] xor: measuring software checksum speed
> > [    0.035351]    8regs     :  3952.000 MB/sec
> > [    0.045384]    32regs    :  4860.000 MB/sec
> > [    0.055418]    arm64_neon:  5900.000 MB/sec
> > [    0.055423] xor: using function: arm64_neon (5900.000 MB/sec)
> > [    0.055433] initcall calibrate_xor_blocks+0x0/0x134 returned 0 after 29296 usecs
> >
> > As you can see, we spend 30 ms on every boot re-confirming that, yet
> > again, the arm64_neon implementation is the fastest way to do XOR.
> > ...and the above is on a system with HZ=1000.  Due to the way the
> > testing happens, if we have HZ defined to something slower it'll take
> > much longer.  HZ=100 means we spend 300 ms on every boot re-confirming
> > a fact that will be the same for every bootup.
> >
> > Trying to super-optimize the xor operation makes a lot of sense if
> > you're using software RAID, but the above is probably not worth it for
> > most Linux users because:
> > 1. Quite a few arm64 kernels are built for embedded systems where
> >    software raid isn't common.  That means we're spending lots of time
> >    on every boot trying to optimize something we don't use.
> > 2. Presumably, if we have neon, it's faster than alternatives.  If
> >    it's not, it's not expected to be tons slower.
> > 3. Quite a lot of arm64 systems are big.LITTLE.  This means that the
> >    existing test is somewhat misguided because it's assuming that test
> >    results on the boot CPU apply to the other CPUs in the system.
> >    This is not necessarily the case.
> >
> > Let's add a new config option that allows us to just use the neon
> > functions (if present) without benchmarking.
> >
> > NOTE: One small side effect is that on an arm64 system _without_ neon
> > we'll end up testing the xor_block_8regs_p and xor_block_32regs_p
> > versions of the function.  That's presumably OK since we already test
> > all those when KERNEL_MODE_NEON is disabled.
> >
> > ALSO NOTE: presumably the way to do better than this is to add some
> > sort of per-CPU-core lookup table and jump to a per-CPU-core-specific
> > XOR function each time xor is called.  Without seeing evidence that
> > this would really help someone, though, that doesn't seem worth it.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> On the two arm64 machines that I happen to have running right now, I get
>
> SynQuacer (Cortex-A53)
>
>     8regs     :  1917.000 MB/sec
>     32regs    :  2270.000 MB/sec
>     arm64_neon:  2053.000 MB/sec
>
> ThunderX2
>
>     8regs     : 10170.000 MB/sec
>     32regs    : 12051.000 MB/sec
>     arm64_neon: 10948.000 MB/sec
>
> so your assertion is not entirely valid.

OK, good to know.


> If the system does not need XOR, it is free not to load the module, so
> there is no reason it has to affect the boot time.

The fact that it was run super early somehow made me just assume that
this couldn't be a module, but of course you're right that it can be a
module.  That works for me and saves me my precious boot time.  ;-)

That being said, this'll still bite anyone who wants to build this in
for whatever reason.  I'll respond to your other email with more...

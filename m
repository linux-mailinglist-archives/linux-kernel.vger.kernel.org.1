Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC67B2EB4D8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 22:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbhAEVZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 16:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbhAEVZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 16:25:13 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F199EC061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 13:24:32 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id k47so411799uad.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 13:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JlHdVAEq7Trq7lzVuprUaKPVl5tyDahbq+Zljdt999s=;
        b=Wkg3F1HqJV5eGtZ3rPc5ialZqpQsHHe1XLq/n9HDr7x/jdt5jPVTr53BZLNSJqTZ+R
         AxbCnphkMZbuMG1n3gc+vZxpeIT9YZSD4fdEAx0Rt57m3SSiCyOz96lemHxjcLS/88vl
         9MiVA2piYryMbbk+UZldwyQcazgeGQW8ZYHqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JlHdVAEq7Trq7lzVuprUaKPVl5tyDahbq+Zljdt999s=;
        b=SS9+eQXsdcaWJ9/HKUZ9+I/zh2sqhAjsybOJhoC09g9VltrG96+hwEALC/RrWCUOCW
         ecajx3K0GO1GYFGhBahGE47fPNJrsmDS0/2nIdcL0ii8xxA6/PC8+1v874mwItDGgGGk
         jPqtBpP2ExWA5yPGXfVW/rAYTh/zS6A5xpqTsCLqq3S8MYzvDthojJeheDBM8wadiPkb
         JCQ3+YOFZVBB9qn615G/XuwSE/Fz0/AphUgSPmX7UMBC7ip8fham45Up5Gii4//07oBa
         RY/+el8M/aMnYshMPkpju12tVsmPteChd+Q8g9oEUQwxofZOcJ0xCa3DohVuUT9PxkXU
         3epg==
X-Gm-Message-State: AOAM5318dBOOECyJ1u8xwtGMRAuwJbDqWFyRIFwn6NvISuvT10CQMnQ0
        pBFHQhEcD5XZi4Th4sl/s7/oD29D3VyTBA==
X-Google-Smtp-Source: ABdhPJyZYEkYOjS+YvN0BM+G4/2jdEToYT4psfEsw/0iamcaHqm5m3BHLexNH9Hc5unUGsASRdH2WQ==
X-Received: by 2002:ab0:184c:: with SMTP id j12mr1321392uag.29.1609881871626;
        Tue, 05 Jan 2021 13:24:31 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id s128sm100492vkg.25.2021.01.05.13.24.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 13:24:30 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id r24so704087vsg.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 13:24:30 -0800 (PST)
X-Received: by 2002:a05:6102:2361:: with SMTP id o1mr1080609vsa.34.1609881870106;
 Tue, 05 Jan 2021 13:24:30 -0800 (PST)
MIME-Version: 1.0
References: <160933061716.928967.463919628731790218.stgit@localhost.localdomain>
 <CAMj1kXHTzafF5ZZR5Ornusjt6cd0K-Lczb0Z0FK54jBTv9cKsA@mail.gmail.com> <30381b78-8721-5b4e-e075-300c5af3f9fa@virtuozzo.com>
In-Reply-To: <30381b78-8721-5b4e-e075-300c5af3f9fa@virtuozzo.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Jan 2021 13:24:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Uq5TWpObFLhHBp7T4esuT_qaaMuYGaEz7xy1_MD5w_Gw@mail.gmail.com>
Message-ID: <CAD=FV=Uq5TWpObFLhHBp7T4esuT_qaaMuYGaEz7xy1_MD5w_Gw@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: Fix divide error in do_xor_speed()
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 30, 2020 at 1:34 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> crypto: Fix divide error in do_xor_speed()
>
> From: Kirill Tkhai <ktkhai@virtuozzo.com>
>
> Latest (but not only latest) linux-next panics with divide
> error on my QEMU setup.
>
> The patch at the bottom of this message fixes the problem.
>
> xor: measuring software checksum speed
> divide error: 0000 [#1] PREEMPT SMP KASAN
> PREEMPT SMP KASAN
> CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.10.0-next-20201223+ #2177
> RIP: 0010:do_xor_speed+0xbb/0xf3
> Code: 41 ff cc 75 b5 bf 01 00 00 00 e8 3d 23 8b fe 65 8b 05 f6 49 83 7d 85 c0 75 05 e8
>  84 70 81 fe b8 00 00 50 c3 31 d2 48 8d 7b 10 <f7> f5 41 89 c4 e8 58 07 a2 fe 44 89 63 10 48 8d 7b 08
>  e8 cb 07 a2
> RSP: 0000:ffff888100137dc8 EFLAGS: 00010246
> RAX: 00000000c3500000 RBX: ffffffff823f0160 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000808 RDI: ffffffff823f0170
> RBP: 0000000000000000 R08: ffffffff8109c50f R09: ffffffff824bb6f7
> R10: fffffbfff04976de R11: 0000000000000001 R12: 0000000000000000
> R13: ffff888101997000 R14: ffff888101994000 R15: ffffffff823f0178
> FS:  0000000000000000(0000) GS:ffff8881f7780000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 000000000220e000 CR4: 00000000000006a0
> Call Trace:
>  calibrate_xor_blocks+0x13c/0x1c4
>  ? do_xor_speed+0xf3/0xf3
>  do_one_initcall+0xc1/0x1b7
>  ? start_kernel+0x373/0x373
>  ? unpoison_range+0x3a/0x60
>  kernel_init_freeable+0x1dd/0x238
>  ? rest_init+0xc6/0xc6
>  kernel_init+0x8/0x10a
>  ret_from_fork+0x1f/0x30
> ---[ end trace 5bd3c1d0b77772da ]---
>
> Fixes: c055e3eae0f1 ("crypto: xor - use ktime for template benchmarking")
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>
> v2: New Year resend :) Added fixes tag.
>  crypto/xor.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/crypto/xor.c b/crypto/xor.c
> index eacbf4f93990..8f899f898ec9 100644
> --- a/crypto/xor.c
> +++ b/crypto/xor.c
> @@ -107,6 +107,8 @@ do_xor_speed(struct xor_block_template *tmpl, void *b1, void *b2)
>         preempt_enable();
>
>         // bytes/ns == GB/s, multiply by 1000 to get MB/s [not MiB/s]
> +       if (!min)
> +               min = 1;

I guess this is if you just have a ktime backend that is not granular
enough for this measurement?  So if ktime is backed by a 32kHz clock
then ktime might increment in ~30us increments and maybe we ran in
less time than that?

...so while I think your fix will avoid the crash and could land as a
stopgap, it's a sign that we need to run more repetitions on your
particular setup to get accurate timings.  Your patch will probably
cause it to just randomly pick one of the implementations.

Presumably the right thing to do would be to look at
ktime_get_resolution_ns().  If "diff" is ever less than
"ktime_get_resolution_ns() * 10" then we should ramp up the number of
repetitions and try again.  The extra "* 10" is to make sure that we'd
be able to tell the difference between faster and slower algorithms.
Perhaps it should actually be more like * 50 or * 100.

-Doug

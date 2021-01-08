Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72452EF83F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 20:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbhAHTfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 14:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbhAHTfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 14:35:08 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE4BC061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 11:34:28 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o19so25642920lfo.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 11:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t+MJWRxDTU36V8xE19m5WjjSjbefnbmENuppDaMSAKg=;
        b=WhBZKnikJ7D+9OF0OeU9baHQ4dnixiMFFXPibHM5X49KiX9Ewm7jxNN5GWUiTkR5xU
         /Ai8HlPNgCtZp7Y6PHdYR0cKx3eNJ6hyPyLd/NXT/eNP/2htauiFUzovR6ePM0cZ32sN
         zrEq5XGLLpxSteRwMBBZP5CMTtHvGKLevDWuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t+MJWRxDTU36V8xE19m5WjjSjbefnbmENuppDaMSAKg=;
        b=DIUNnDI+t2hWGYAWwSH8Teo5nPGAFwsJDNaMSW/7eUbkAgWN5401Fx8T2uwIQ09snz
         0tBFI2blEj4CIau0cDPx2+eGzRvCuMk9c34L42gqT5S0v6v3Uhrxu/R5OiomMWXCasAR
         FotlTA0rai86pdF76hQzTLU0drcb/zLTbDsmL7Eq7ugcrQd2wdwueryFKnrtogHfIV92
         GnFNBmz9Aca1jGnTI4AD4ip0l4dn5YmVD941X/PuadCMidndhbNriSM88uu4ZQhHVW8m
         Yvcb/LZEJoyNQ3MZdDo/QhuHGtGME5L+bfZPo76meKzEgGJu/rhT4rHYWXwIlBzOBVZL
         IRYw==
X-Gm-Message-State: AOAM530VSexTcOxTRHSifShvC86od0ldVkpV+z2884q9D5pbygtDIG3H
        D//NB93hjh1doGf7zTPuFdzJSTiGRcXm7Q==
X-Google-Smtp-Source: ABdhPJyaQ802QOAVNhUl3GjKlf+KELw+KFiKI5WUsZD9dpWE2CP9TdlEAK4RGGRvICdzRFSdnquzMw==
X-Received: by 2002:a05:6512:3e7:: with SMTP id n7mr2122766lfq.585.1610134466154;
        Fri, 08 Jan 2021 11:34:26 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id h23sm2306807ljh.115.2021.01.08.11.34.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 11:34:25 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id m12so25590848lfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 11:34:25 -0800 (PST)
X-Received: by 2002:a2e:9ad7:: with SMTP id p23mr2022603ljj.465.1610134464854;
 Fri, 08 Jan 2021 11:34:24 -0800 (PST)
MIME-Version: 1.0
References: <20210108171517.5290-1-will@kernel.org>
In-Reply-To: <20210108171517.5290-1-will@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Jan 2021 11:34:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg3UkUdiTbqWFx3zBLXv9VJHuNZAa5QyDvXiSmD4gX94A@mail.gmail.com>
Message-ID: <CAHk-=wg3UkUdiTbqWFx3zBLXv9VJHuNZAa5QyDvXiSmD4gX94A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Create 'old' ptes for faultaround mappings on
 arm64 with hardware access flag
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 9:15 AM Will Deacon <will@kernel.org> wrote:
>
> The big difference in this version is that I have reworked it based on
> Kirill's patch which he posted as a follow-up to the original. However,
> I can't tell where we've landed on that -- Linus seemed to like it, but
> Hugh was less enthusiastic.

Yeah, I like it, but I have to admit that it had a disturbingly high
number of small details wrong for several versions. I hope you picked
up the final version of the code.

At the same time, I do think that the "disturbingly high number of
issues" was primarily exactly _because_ the old code was so
incomprehensible, and I think the end result is much cleaner, so I
still like it.

>I think that my subsequent patches are an
> awful lot cleaner after the rework

Yeah, I think that's a side effect of "now the code really makes a lot
more sense". Your subsequent patches 2-3 certainly are much simpler
now, although I'd be inclined to add an argument to "do_set_pte()"
that has the "write" and "pretault" bits in it, instead of having to
modify the 'vmf' structure.

I still dislike how we basically randomly modify the information in
that 'vmf' thing.

That said, now it's just a small detail - not really objectionable,
just a "this could be cleaner, I think".

I think it was Kirill who pointed out that we sadly cannot make 'vmf'
read-only anyway, because it does also contain those pre-allocation
details etc (vmf->pte etc) that are very much about what the current
"state" of the fault is. So while I would hope it could be more
read-only than it is, my wish that it could _actually_ be 'const' is
clearly just an irrelevant dream.

                   Linus

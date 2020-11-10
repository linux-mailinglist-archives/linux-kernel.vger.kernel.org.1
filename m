Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB662AD8B4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbgKJOZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730897AbgKJOZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:25:26 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FABC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:25:26 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id h15so11501512qkl.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AHqYsPMnh39efaowbWE1u8lOHSCxjgXUEGEjdD/sQII=;
        b=gsorfyCVgVAhThPqbOTMm18Al8rSfjTDwDQe/aeZtJ7Z+CKqle6LGo2qGHTda39sH+
         x0NXYAQkAKaNB/DHQE1bTRZst2psyCFV4KWjzvaYY4rOxG96vutagdnuPQgwYOehVX2u
         hZTdOSYfj64lXo8ugQ8z0KVEzG8WTe63npkttogXLUaJrdNTKTqR0fNw3bDJxT6HoWEz
         OCqu0Wurgtb6JsInPRU2hGZIdJEbDeh6gNGs0a64Oo+cOM/HG8KSWNRgtJ9CU7E2cEow
         z+gdkOytzKX/mK//eod+ycIkPZx6wTTXpsjCxtI4yL6CkXmRjd/E+rX8Re12h4X4jrbE
         GjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AHqYsPMnh39efaowbWE1u8lOHSCxjgXUEGEjdD/sQII=;
        b=tlC7EfnGHUobn4qAThf/bdz1kdod+GdvxcedIQHHmfK66Roxo1VA+gpxdHczHWqKSW
         6m5C5Kfwd1PSnsiTgN+nl3iMooVN7MDDefAfN33+TxFXGLDrPGAeG8YG+hwIGvhdmRfF
         FRgisYhsyOjN8cFzPBNyWTZMdb0upCnALiN5CzPrIEc2+KOhj1FMMx/sFqr67doqHXsK
         /J4MCDxCj1eStaoVpfFuWVB7usmJ4ZN496OzjK0dPm+55+8UA1BWGnVAE81D0/UHoeBL
         B5Yf7wbmgj2/n2NA65nPCs5AsRVxSg/WrXalVtEaNBSWoflX6tS/C1e4T5n+RWbXMs35
         0VdQ==
X-Gm-Message-State: AOAM532rjccUUwsp4Gm/E8otLxcx1tKbOhhVB47ZWjlBUd8lgyT9FhTJ
        ulxAKFQ50zNRL05d/zgqT4GmFWc+/YCJRmakS3BMnA==
X-Google-Smtp-Source: ABdhPJyibywoziBRvE+Zhy1U4WMtxvGQqvGE8BBxY6Qw9MUCSvIkSsbgobK4/c9L5p5M/ffy/qJvLuVitkStkaHf+Ww=
X-Received: by 2002:a37:7b44:: with SMTP id w65mr20049707qkc.350.1605018325472;
 Tue, 10 Nov 2020 06:25:25 -0800 (PST)
MIME-Version: 1.0
References: <20201110135320.3309507-1-elver@google.com>
In-Reply-To: <20201110135320.3309507-1-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 10 Nov 2020 15:25:13 +0100
Message-ID: <CACT4Y+Y_QarAf_cCNPgRZiSEKty0eSusA1ZMuY61LoGP1RaVtg@mail.gmail.com>
Subject: Re: [PATCH] kfence: Avoid stalling work queue task without allocations
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 2:53 PM Marco Elver <elver@google.com> wrote:
>
> To toggle the allocation gates, we set up a delayed work that calls
> toggle_allocation_gate(). Here we use wait_event() to await an
> allocation and subsequently disable the static branch again. However, if
> the kernel has stopped doing allocations entirely, we'd wait
> indefinitely, and stall the worker task. This may also result in the
> appropriate warnings if CONFIG_DETECT_HUNG_TASK=y.
>
> Therefore, introduce a 1 second timeout and use wait_event_timeout(). If
> the timeout is reached, the static branch is disabled and a new delayed
> work is scheduled to try setting up an allocation at a later time.
>
> Note that, this scenario is very unlikely during normal workloads once
> the kernel has booted and user space tasks are running. It can, however,
> happen during early boot after KFENCE has been enabled, when e.g.
> running tests that do not result in any allocations.
>
> Link: https://lkml.kernel.org/r/CADYN=9J0DQhizAGB0-jz4HOBBh+05kMBXb4c0cXMS7Qi5NAJiw@mail.gmail.com
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  mm/kfence/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 9358f42a9a9e..933b197b8634 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -592,7 +592,11 @@ static void toggle_allocation_gate(struct work_struct *work)
>         /* Enable static key, and await allocation to happen. */
>         atomic_set(&allocation_gate, 0);
>         static_branch_enable(&kfence_allocation_key);
> -       wait_event(allocation_wait, atomic_read(&allocation_gate) != 0);
> +       /*
> +        * Await an allocation. Timeout after 1 second, in case the kernel stops
> +        * doing allocations, to avoid stalling this worker task for too long.
> +        */
> +       wait_event_timeout(allocation_wait, atomic_read(&allocation_gate) != 0, HZ);

I wonder what happens if we get an allocation right when the timeout fires.
Consider, another task already went to the slow path and is about to
wake this task. This task wakes on timeout and subsequently enables
static branch again. Now we can have 2 tasks on the slow path that
both will wake this task. How will it be handled? Can it lead to some
warnings or something?

>         /* Disable static key and reset timer. */
>         static_branch_disable(&kfence_allocation_key);
> --
> 2.29.2.222.g5d2a92d10f8-goog

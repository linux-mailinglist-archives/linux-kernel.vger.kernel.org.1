Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77ADB303B0D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404954AbhAZLFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbhAZEgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 23:36:25 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9ECC061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 20:35:45 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id p21so15952266lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 20:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7bQPTwU7mjRvSNfreXWALEkTbnKEYe8Pe6OmRswGPXw=;
        b=YUZQVBJeKxvnuLtxOrOwLd01dCsSsMJQezuCVvyKmfx4Z8piYM29DlP1ovbsgc/o8F
         GdiFMD3VkfNlZg0CzalpyK7h0RC5DPTaMjBw1T7rkPs7IY5FP3RYj9VjOEQdVK9unGGC
         w0U+rqLXnObaOlIUQHqZ5751Z7R/uqnPUuU5kQ8iawfxXV5nqQdMRHDLB4TPOhBW0U8/
         GVpxiCMot54CSi3w95f6LyPoK38lSz+kyMoJoepo/UJE8XXuQWVfkhudqw+OSSgqKC6X
         n4ZS8tyMlspY5Qc+ZtqzX2MNIJSI1DxTT1MSpTbfstln7FAEupQdI0LCdYoSOpdOWNAU
         6ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7bQPTwU7mjRvSNfreXWALEkTbnKEYe8Pe6OmRswGPXw=;
        b=dOth84rEVvW2esXBObrB79iVnQ+BtYejSI19fcl9cnYdo4xV+uPVZWf7mGHqHy7l79
         E+ZGcU5K9ajphfxpSmwKwWBwxIUFHO1ibl173GV/+6oYyZQKWLzFf7gcrsxdjVVUmTbU
         5Bq/gl+rXFKlkurPWiOp59h86u1YCczDEp25Gb9q72dmC7q+6Duka/ifhGNY8+6OXoB1
         xx50juwlVZoaSSmVWnGL1lAGwEDWjl97bRo6paUe5xNqL/VKw8q8FyYFYfTIer8pwmqz
         EXFII/UVqP7/h7oruYR+KyxR66cIYzi1YHuD5y0ncJiXpmrjA9R/g9lM2T7Ghtvq172I
         CNvA==
X-Gm-Message-State: AOAM531LpPtBOcpfqtS9MjFL0QZFdj4gevvreghjz0H6v/rRj76SYSp4
        L+CDdPWqApnaK4ar2Qfbplxvbu6WYL+wAZNHT/rQEg==
X-Google-Smtp-Source: ABdhPJwAnwu7dJ1teuGPpX98AK2jMau5r2V+GCC9sAtUKHtR78MQ5CRh9uQ0/06DLTyh64Zs1oj9otrgSGo2xjDjjB8=
X-Received: by 2002:a19:8789:: with SMTP id j131mr1727163lfd.382.1611635743458;
 Mon, 25 Jan 2021 20:35:43 -0800 (PST)
MIME-Version: 1.0
References: <20210113160557.1801480-1-elver@google.com>
In-Reply-To: <20210113160557.1801480-1-elver@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 26 Jan 2021 12:35:31 +0800
Message-ID: <CABVgOSnHh8-s+AYifkDjCDKCkkFcm=WiGSuuf2JFiMvjAU1Kew@mail.gmail.com>
Subject: Re: [PATCH 1/2] kcsan: Make test follow KUnit style recommendations
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, boqun.feng@gmail.com,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 12:06 AM Marco Elver <elver@google.com> wrote:
>
> Per recently added KUnit style recommendations at
> Documentation/dev-tools/kunit/style.rst, make the following changes to
> the KCSAN test:
>
>         1. Rename 'kcsan-test.c' to 'kcsan_test.c'.
>
>         2. Rename suite name 'kcsan-test' to 'kcsan'.
>
>         3. Rename CONFIG_KCSAN_TEST to CONFIG_KCSAN_KUNIT_TEST and
>            default to KUNIT_ALL_TESTS.
>
> Cc: David Gow <davidgow@google.com>
> Signed-off-by: Marco Elver <elver@google.com>

Thanks very much -- it's great to see the naming guidelines starting
to be picked up. I also tested the KUNIT_ALL_TESTS config option w/
KCSAN enabled, and it worked a treat.

My only note is that we've had some problems[1] with mm-related
changes which rename files getting corrupted at some point before
reaching Linus, so it's probably worth keeping a close eye on this
change to make sure nothing goes wrong.

Reviewed-by: David Gow <davidgow@google.com>

-- David

[1]: https://www.spinics.net/lists/linux-mm/msg239149.html

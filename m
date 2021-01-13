Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692F22F5027
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbhAMQkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbhAMQkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:40:39 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC03C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:39:59 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id x13so2460464oto.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=718zcsFUzGW3JK8wqJnAiFUqkREV/jlMJotq/sE7w4Q=;
        b=SWJj7egFZVpu8ndMonBOTArDLXjWaJchbV+rLUhaDy2UGjwFeMbseW2RdF2u5VX3ot
         4PjB8nCMCzbm1O7fPIL/TEYKJvzrWNz68rPznMB5x5Y2cH/OytCVm02lpRZeShfb2h+6
         AWkineT2SquX0tiBdz7mZp2FXaeJ5MZb7CxuJ6YyoWNphnIqWYaLAOid7vtMnXndNpve
         JulNlvO2oixZDx+utacP0e+Qgw2DiuPVYjUbo5yg3zGhjLdC23GrETsoN4pwMEoYY2kz
         pzf/2C7U0xcN46NqR9bqXyHbyGWWUtwXNj7YzOZgcsTogRwoNCQNNJp1jhX2CveJfkwx
         6Gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=718zcsFUzGW3JK8wqJnAiFUqkREV/jlMJotq/sE7w4Q=;
        b=Hy9egrZ0fv0lKDCy2g1IXwIcAfreAHHMbRKRSeOw2ccAOs1AX3isMoNTpjgrHzv1EH
         81djnDyKnTnJBA0HNgJmM2vjS6UOkCq+DQrXlJSdbTPqW7UmbAEdCbnFr9NDR663dley
         rCmVjDYnbsiw7joYSIXZbfgebim6uWXhT+j52gAEAOjFRZEB1BG91gAazj6JEoe/Fktq
         VQ7aTKmdcLQv8RtVePwFenYMl9YeCyHlQxmkU6D7Wyh40IJ/pHqrkDGHzx21FrfOWEmv
         5qUkovNlAMKPEk4peircEER+lePyT0ZB4WYHytp3lZmlWwnh0lKM90jmv0wbEWLJVi39
         6N6w==
X-Gm-Message-State: AOAM530Hhm6/po2elsQCffNIjaTxznfm1PnRxXgMa9o/64OxRfMg5QX0
        M1hagTwttkhEeIi6BsZX0MIIP6pR7+ZjYyaWvDTWTQ==
X-Google-Smtp-Source: ABdhPJz8omtz8YajrsBZ21cuSoyPdhfQl1j/+zYoWJGvqIou6ClU5xryuWosQGprK+fdTCwKqC2UVLTAZoYuKcKcIuE=
X-Received: by 2002:a05:6830:2413:: with SMTP id j19mr1862383ots.251.1610555998526;
 Wed, 13 Jan 2021 08:39:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com> <654bdeedde54e9e8d5d6250469966b0bdf288010.1610554432.git.andreyknvl@google.com>
In-Reply-To: <654bdeedde54e9e8d5d6250469966b0bdf288010.1610554432.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 13 Jan 2021 17:39:47 +0100
Message-ID: <CANpmjNPOtohFy800icx1LU_hzuQZNMQqqTBUSDXZ_9wWO_vHWw@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] kasan: don't run tests when KASAN is not enabled
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 at 17:22, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Don't run KASAN tests when it's disabled with kasan.mode=off to avoid
> corrupting kernel memory.
>
> Link: https://linux-review.googlesource.com/id/I6447af436a69a94bfc35477f6bf4e2122948355e
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  lib/test_kasan.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index d9f9a93922d5..0c8279d9907e 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -47,6 +47,9 @@ static bool multishot;
>   */
>  static int kasan_test_init(struct kunit *test)
>  {
> +       if (!kasan_enabled())
> +               return -1;

This should WARN_ON() or pr_err(). Otherwise it's impossible to say
why the test couldn't initialize.

>         multishot = kasan_save_enable_multi_shot();
>         hw_set_tagging_report_once(false);
>         return 0;
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>

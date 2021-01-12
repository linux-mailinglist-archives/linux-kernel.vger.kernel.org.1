Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F243A2F2945
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 08:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392063AbhALHyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 02:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729397AbhALHyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 02:54:16 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4DBC061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 23:53:35 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id v126so1112556qkd.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 23:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mGCAtyq15j5iLbAyhIjgwA3t0EKUEm8gTtrvCf4O7jE=;
        b=VcB+5Bvj/ofJcXzkKhp77cob5rnsxkzexfwEJOngzvRnRecyLQUXAIbrwPwzj506Be
         y3L1S5y5m44HWw8JN3cmOpeJ8O+2+Wd0NLUmfAWCKak27ouvHG3G+AIUKAUtTrN0fppm
         +EtfI4ldLLfUQr2GU/G1KNEfw7qHhyuReFqwhzHU42ClLbGKQDpAQRWTbf7IxHfK2BZf
         GrTgZFqhs/xLCwOhvMeVU1NWhTQgMBMEl8jIzt4s4GWWZNnRW39B7RKu5G+7ivhHaOze
         MFxAoVdjzH4XQbx76qPwKDkemgIYI60UdlzBjKnVCyE73yLsZ9t6wKsH0aHil5eNfnul
         aviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mGCAtyq15j5iLbAyhIjgwA3t0EKUEm8gTtrvCf4O7jE=;
        b=q1dDyPee4fg5q8PabNPHvUdzKWUrBW0+oMPxCtqOuHn+aaypDog2zuhNPnCZF/ne4f
         +gChMUxorNM/eyfen0trmuleOcVUilFiNNYz5UXVqhG1bNw2HSxeIaZMuunZH5oecR7f
         9+ZOFFHGd6aPlVxg1/JFmYlk3gbIAT8DYJTJlum5kNrETAi0bmnLCxfrZGFBs+QRUZZ2
         aLgaN0CN5Eurmc1FUYa9fmi65XK6OkrbTN+cgnjUkxy7wSfHum5H5GI4BIYAxUo3E7z5
         7/AmYT0Lk8np5yyPburqPmfW95gCbf1hOIJdu0kCRNyax0IkSqNdU8gc8bSAEmH9R1fx
         CImA==
X-Gm-Message-State: AOAM531GPbEkcCJ6REzW5+34Mik/YjNkBS+nMCWaEQdB/ONfWDuMGB0R
        NgKpVUT0qlP/0D+DxVo7IXMJd3obCQlT56462Qvhlg==
X-Google-Smtp-Source: ABdhPJxKeO3yf8gX2ix6pPQZam2M1Q3zyFWoMsaCr5u8zLo/CrTR7MPDM49aEmBX/1ACLC6VwPF8L+gKK62yeZUuWHQ=
X-Received: by 2002:a37:a747:: with SMTP id q68mr3233844qke.352.1610438014849;
 Mon, 11 Jan 2021 23:53:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com> <cb4e610c6584251aa2397b56c46e278da0050a25.1609871239.git.andreyknvl@google.com>
In-Reply-To: <cb4e610c6584251aa2397b56c46e278da0050a25.1609871239.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 12 Jan 2021 08:53:22 +0100
Message-ID: <CAG_fn=VDPR2bkHA_CeDP-m8vwr3rTH+3-qwMNHNUQA2g6VghKA@mail.gmail.com>
Subject: Re: [PATCH 03/11] kasan: clean up comments in tests
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

On Tue, Jan 5, 2021 at 7:28 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Clarify and update comments and info messages in KASAN tests.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I6c816c51fa1e0eb7aa3dead6bda1f339d2af46c8


>  void *kasan_ptr_result;
>  int kasan_int_result;
Shouldn't these two variables be static, by the way?
>
> @@ -39,14 +38,13 @@ static struct kunit_resource resource;
>  static struct kunit_kasan_expectation fail_data;
>  static bool multishot;
>
> +/*
> + * Temporarily enable multi-shot mode. Otherwise, KASAN would only report the
> + * first detected bug and panic the kernel if panic_on_warn is enabled.
> + */

YMMV, but I think this comment was at its place already.

>  static int kasan_test_init(struct kunit *test)
>  {
> -       /*
> -        * Temporarily enable multi-shot mode and set panic_on_warn=0.
> -        * Otherwise, we'd only get a report for the first case.
> -        */
>         multishot = kasan_save_enable_multi_shot();

Unrelated to this change, but have you considered storing
test-specific data in test->priv instead of globals?

>         if (!IS_ENABLED(CONFIG_SLUB)) {
> -               kunit_info(test, "CONFIG_SLUB is not enabled.");
> +               kunit_info(test, "skipping, CONFIG_SLUB required");
>                 return;
>         }

You may want to introduce a macro that takes a config name and prints
the warning/returns if it's not enabled.

Alex

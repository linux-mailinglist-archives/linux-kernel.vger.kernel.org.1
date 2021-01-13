Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138D02F4FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbhAMQ3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbhAMQ3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:29:32 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA96BC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:28:52 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id q205so2662261oig.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dtGuPSqxThBxFFND3TAs3eyezmIFF8iGuQhEPWlxFw4=;
        b=sI9xRXQ7bmuA7TJRkjDPjXW3Ct3TrbkRYINplcqCriT13wqmazifZhtY86WTBfwKH7
         Qnm3ZuZ0BSgVgVCCqgqYeq5LKetbMAelGxJtIjxrFWGYmLPmnLOion0np3ee7rcJWKsy
         4HzkMR3p38leCj5/TqSUAJG6Qtt9DoOsCjLD4eI5M0hLzMJ9lEYnS7yeXxbI2Rr2k7IL
         2RDBQPzCtb+RV/q9vvIDtJQhBzyBrpJ5lQuZEsnrM39dRv4np8it98qsVfldq3tIIZ0T
         fGKih1JACcHtcIaockL+Q1Zuma3IuY9KxJJeJnM+Cd9Qc4Tr5H9Vz7wbbcJtP0yzvDdB
         R28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dtGuPSqxThBxFFND3TAs3eyezmIFF8iGuQhEPWlxFw4=;
        b=QOtN0VuIViXwmtGE2EjJMVLZuqt4aNKG+6NXrIohJp13xLMeMPQYogtJ4OqIUQ5YgU
         5pEH+uDUaVHp5pydB/Oxre/cZBi2d5xsZSW+rKon32cSW2KFb4SzglNtjW7HvQSW+cSt
         7Uvhqp+cfggLI4sbcLT999NCpOwSPwgdzSPy3Qt0V63msv7l84AKWb2usTT8NENpJJ6T
         CyvCFZkxDg3aerbnRPMwBKIAozUHeODWkj2h5C5kBYqg8bCn+2a3eLHD6eDonXuoWpQQ
         ZeVnibBVe+9nhHGpiov8OpMnn++TCiSHRdoe0/2N9fnxlMBOHPq4ZF7DLKFWQQTmHLei
         wCJA==
X-Gm-Message-State: AOAM531AnfgfOOJzvC1In3e7UJw4uvDeWlROmVineoispSCtqgTb/XNY
        cDs9EVQIhqJZLZAYUexE8kUwetBgjMT+oE+TRHTm5A==
X-Google-Smtp-Source: ABdhPJwjAqoLrcLjVn73P0G0ScKT22CiHCZFlltMrKpWnEEY7dhsvs+jpP4CxMAsDdiNDcHys/8s8d1eZAiLWUF0MBg=
X-Received: by 2002:aca:58d6:: with SMTP id m205mr23481oib.121.1610555331853;
 Wed, 13 Jan 2021 08:28:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com> <e75010281350ff3a4380006218f81e1233fa4e6b.1610554432.git.andreyknvl@google.com>
In-Reply-To: <e75010281350ff3a4380006218f81e1233fa4e6b.1610554432.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 13 Jan 2021 17:28:40 +0100
Message-ID: <CANpmjNPYKzY+xPAddAjsry1RC2Y84pSCFZ0VuVMMEu+LN3A0EQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] kasan: add compiler barriers to KUNIT_EXPECT_KASAN_FAIL
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
> It might not be obvious to the compiler that the expression must be
> executed between writing and reading to fail_data. In this case, the
> compiler might reorder or optimize away some of the accesses, and
> the tests will fail.
>
> Add compiler barriers around the expression in KUNIT_EXPECT_KASAN_FAIL
> and use READ/WRITE_ONCE() for accessing fail_data fields.
>
> Link: https://linux-review.googlesource.com/id/I046079f48641a1d36fe627fc8827a9249102fd50
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  lib/test_kasan.c  | 17 ++++++++++++-----
>  mm/kasan/report.c |  2 +-
>  2 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 5c8aa3a5ce93..283feda9882a 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -68,23 +68,30 @@ static void kasan_test_exit(struct kunit *test)
>   * normally auto-disabled. When this happens, this test handler reenables
>   * tag checking. As tag checking can be only disabled or enabled per CPU, this
>   * handler disables migration (preemption).
> + *
> + * Since the compiler doesn't see that the expression can change the fail_data
> + * fields, it can reorder or optimize away the accesses to those fields.
> + * Use READ/WRITE_ONCE() for the accesses and compiler barriers around the
> + * expression to prevent that.
>   */
>  #define KUNIT_EXPECT_KASAN_FAIL(test, expression) do {         \
>         if (IS_ENABLED(CONFIG_KASAN_HW_TAGS))                   \
>                 migrate_disable();                              \
> -       fail_data.report_expected = true;                       \
> -       fail_data.report_found = false;                         \
> +       WRITE_ONCE(fail_data.report_expected, true);            \
> +       WRITE_ONCE(fail_data.report_found, false);              \
>         kunit_add_named_resource(test,                          \
>                                 NULL,                           \
>                                 NULL,                           \
>                                 &resource,                      \
>                                 "kasan_data", &fail_data);      \
> +       barrier();                                              \
>         expression;                                             \
> +       barrier();                                              \
>         KUNIT_EXPECT_EQ(test,                                   \
> -                       fail_data.report_expected,              \
> -                       fail_data.report_found);                \
> +                       READ_ONCE(fail_data.report_expected),   \
> +                       READ_ONCE(fail_data.report_found));     \
>         if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {                 \
> -               if (fail_data.report_found)                     \
> +               if (READ_ONCE(fail_data.report_found))          \
>                         hw_enable_tagging();                    \
>                 migrate_enable();                               \
>         }                                                       \
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index e93d7973792e..234f35a84f19 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -331,7 +331,7 @@ static void kasan_update_kunit_status(struct kunit *cur_test)
>         }
>
>         kasan_data = (struct kunit_kasan_expectation *)resource->data;
> -       kasan_data->report_found = true;
> +       WRITE_ONCE(kasan_data->report_found, true);
>         kunit_put_resource(resource);
>  }
>  #endif /* IS_ENABLED(CONFIG_KUNIT) */
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>

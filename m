Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EC62FF223
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388077AbhAURj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388747AbhAURhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:37:13 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636C7C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:36:32 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m25so3643681lfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3SEf/V9yt14A7uM1ShvJd/4xdflgWn5dGZUA33xKMms=;
        b=XsmwIVO/V6h9mFWHl2r06aivASYcATaOgZwv77wC9xKZ/MN82fjm8u7omAINuA1Scw
         c1VmYF+ubgVCmTpUmTsElehCOCVMnmpf0n6fq4jybmEfTRTfcbOTcVdHviLHNHx2JH5v
         QzrzTEgw1sPErL/gsZ+W3dS1Lr8wULt9K585p0yvce9SeZ7IesBVjoqerfQtQrUPD6JQ
         pY1P5zMFMLUKsAWY7VF04g6klEW5AV7iU25tyr+CtaTfJuwZD1cGVSZaUyGXUxOsWHgE
         bvGURQHtbTrxXDwbLeVAC8rAjogHb/IyI+i9Hlv8vY2O5dQN0XplvmtERPVRetjtuxX4
         2P+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3SEf/V9yt14A7uM1ShvJd/4xdflgWn5dGZUA33xKMms=;
        b=rWqGQEwmalRW3LOkXlBqDLW4PpUOJFz55Pu4KTv6mNgexhGC1oJQGU0Ue2j3KmsHkY
         eEd0jmaU2Kk3Jw9gllrHsoVdj3XF2rVe8jnn3/DRMpVyXXFkLqqVj1CRmNI7HV8Ndrqu
         iXZzgecign3CP4sjV2Ju8nlfTZrAxWkVAb7wm72dTvf2RqnuVBKbjg5OI0rg2dZjmAcz
         pTvMjk3XY0o7yxIY5o8G3twW0YFblF0hHmLC8ublx1FSJr1VAcsxgb8fCPV5f7/7IuR0
         hQO4IceTobQ1ojV3RRRkiYZstZqQaRPHLVU39WjmqChxcF3LI3J+2Lt+7rjqzyPavSQY
         v/lw==
X-Gm-Message-State: AOAM5329kOcv+Ji84GH3l3pUY5LcV+ivLFkyDn9Vf+9EA1ubiarEBees
        60b7iuvnLA9GRMZz7sbjqiSmaD1LQUNPmxD0yYXKbg==
X-Google-Smtp-Source: ABdhPJyU3qGpfN5OW/ZoN3v4IosoHPldFT+rj5yOhl+7TTN/cxJTIMmsdJaPlTiqZfdUPbh64yjywinHu1g+7RUxlYo=
X-Received: by 2002:a19:4191:: with SMTP id o139mr154189lfa.224.1611250590545;
 Thu, 21 Jan 2021 09:36:30 -0800 (PST)
MIME-Version: 1.0
References: <20210121163943.9889-1-vincenzo.frascino@arm.com> <20210121163943.9889-4-vincenzo.frascino@arm.com>
In-Reply-To: <20210121163943.9889-4-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 21 Jan 2021 18:36:19 +0100
Message-ID: <CAAeHK+wS-HCrayJrWkD=HSS2xLzVfsgTFcAAQZL8DSZ2o3tCrA@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] kasan: Add report for async mode
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 5:39 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> KASAN provides an asynchronous mode of execution.
>
> Add reporting functionality for this mode.
>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  include/linux/kasan.h |  2 ++
>  mm/kasan/report.c     | 11 +++++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index bb862d1f0e15..b0a1d9dfa85c 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -351,6 +351,8 @@ static inline void *kasan_reset_tag(const void *addr)
>  bool kasan_report(unsigned long addr, size_t size,
>                 bool is_write, unsigned long ip);
>
> +void kasan_report_async(void);
> +
>  #else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
>
>  static inline void *kasan_reset_tag(const void *addr)
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 234f35a84f19..2fd6845a95e9 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -358,6 +358,17 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
>         end_report(&flags);
>  }
>
> +void kasan_report_async(void)
> +{
> +       unsigned long flags;
> +
> +       start_report(&flags);
> +       pr_err("BUG: KASAN: invalid-access\n");
> +       pr_err("Asynchronous mode enabled: no access details available\n");
> +       dump_stack();
> +       end_report(&flags);
> +}
> +
>  static void __kasan_report(unsigned long addr, size_t size, bool is_write,
>                                 unsigned long ip)
>  {
> --
> 2.30.0
>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

FTR: this will conflict with the Alex's patch:

https://lore.kernel.org/linux-api/20210121131915.1331302-1-glider@google.com/T/#m8872c56af85babfc08784e2b2fcd5cc1c0c73859

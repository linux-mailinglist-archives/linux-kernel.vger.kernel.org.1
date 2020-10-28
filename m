Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21C029D57E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgJ1WDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729653AbgJ1WDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:03:10 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAF6C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:03:10 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id a23so441775qkg.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AG7fb7d0C8MAPzIXBnKbPS8VY0VZhAzE0h3g8JJD9l8=;
        b=C3K8jt2EESSq9VBTNlezdB5lhUxguZOUeT8DjBvyG9TszljClDzOfG9DwkqrQSgiD7
         TdYSZRXFVXdRK/2xcEgpMnOCr8pKQySnqXpr+6yWakTPSBKVaIyOgjz63BpmBDc1l6n/
         oc3RCyWLuwsp8oo7N1h4IgYsKQRuTOUkgfdMjmVTJZeMDRNN8phA44WY8oAON1PE1cMP
         BAbHBlLZM5jUcM1Ao2QLQJTOwhNnrr/gyHpiRepcpk0VVVUcmlKrh7FE8sh4SrEjgKJz
         +ysNTbhkEbg/e6PDlHO25ydv/+rlaEHf2lCQqiXu7NSafJ/zd2YFqCLEUxXtZHd6J/3w
         wuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AG7fb7d0C8MAPzIXBnKbPS8VY0VZhAzE0h3g8JJD9l8=;
        b=QM0DTTNnsaRQN9Maua4LcZykVlPaVOjADTuIlkJ+2u3RUASckWEdTChNri18SbEyK/
         Q8+IxR+WW/8EJMj98MVsrAwZBvGAlTAfvolWQhFxQBSO1o3ZgSTfNrurWBbUecT0wHSc
         mGQdPo16xNXjtXGEcflC30XvDqcyPkGQwUqM0dVftAMNbJPwciTSbKjvwaBH2MCqwaHJ
         jxegUfzoTgLtMLYVVVT4+4XDz0FSUyLdp9J5m2sMZGQ4QrBg+FNlmZ3RZMBg+Gveyos3
         dc/eBTfmNlRJeQs8gz7gbDx46ghNX/yWpsFbRg8jnplGMKssuorngYM2HsHkb4RVwFfN
         CyPQ==
X-Gm-Message-State: AOAM530G9MPHtgfSBrNXG5kmRwIWVxcRDoQC5uPtgsYDdInNm6k0xbT+
        fL3IoaCyGsh4HjQJdEQZHF3cZDtHCtmS54VdHsFUeK0XeaEKKw==
X-Google-Smtp-Source: ABdhPJz1pGv64k+Jss9JKkY2ROsSjCftXLL5fqnH7sCV0rYWTeW7P4EWOFLz8h+PPFPgRTWwgCdIeRM/Iw+SD1q3zig=
X-Received: by 2002:ac8:44ae:: with SMTP id a14mr8224570qto.67.1603904668207;
 Wed, 28 Oct 2020 10:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <6ed65cca58736301a1cacb539a6e672aecd7859d.1603372719.git.andreyknvl@google.com>
In-Reply-To: <6ed65cca58736301a1cacb539a6e672aecd7859d.1603372719.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 28 Oct 2020 18:04:16 +0100
Message-ID: <CACT4Y+YHvfccvAYgkO5TrB=uy_htvNi4qshfLOqvci3RGzfR1Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2 21/21] kasan: clarify comment in __kasan_kfree_large
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 3:20 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Currently it says that the memory gets poisoned by page_alloc code.
> Clarify this by mentioning the specific callback that poisons the
> memory.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I1334dffb69b87d7986fab88a1a039cc3ea764725

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  mm/kasan/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 3cd56861eb11..54af79aa8d3f 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -445,5 +445,5 @@ void __kasan_kfree_large(void *ptr, unsigned long ip)
>  {
>         if (ptr != page_address(virt_to_head_page(ptr)))
>                 kasan_report_invalid_free(ptr, ip);
> -       /* The object will be poisoned by page_alloc. */
> +       /* The object will be poisoned by kasan_free_pages(). */
>  }
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>

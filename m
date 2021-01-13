Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFE72F5010
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbhAMQdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbhAMQdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:33:49 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB33DC061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:33:08 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 19so2446275qkm.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yukq8DLGoUwetcyUpU1xVWQNvOKdjhm4xJiehIsqbBA=;
        b=YGT1jcFIluAWJW2FDHcPmAosrpToO/jK0CvjYfbSOS+Tqmlfv5EjHK1Da1q5FGX8zs
         jhXMkLMMa/VuTzv/tvzAI+KNlQrjWnhu9GfvG1EHWoiQstkQMpUwmtSAlZa00LJdsdqY
         UxbpZFG0JlKscgGRIYZe3VPVnIggyHtm0uUPbFBIemWWvXVCBWQj17+Mv9EvMaYPrwIM
         A7PiTJj0rRZHVIrE0cgBVNWDyhHCuwTSVeyhJ56K4vCD1o/ZOvRxY0yXjtRBUFqg50I6
         1WqqNEpdgzmJJ1Dr4pl0P4kjqSNgwXnwkzhgUXzkGhChB6iasZweauR5Zyg3KdmT5mGn
         XUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yukq8DLGoUwetcyUpU1xVWQNvOKdjhm4xJiehIsqbBA=;
        b=L8BYzluMUJIY0vxEVIiRT/gUykpXeCoKU4mFtMFSFG1vZwFIdlewLR/8PtBt0Sffpr
         Sv9KVy6IfeL3vcDSxxCXPq0N9+78yQgWCwBTkvN/MJn0pyCuCoff+7ChZK9/gck7MUYZ
         EKRA1gjEIBQgubr+5+zq398vhWUsAh4gPEooa/efN98RUjMkst898YWY0XLtKP+GtQlk
         ZCZb3mDDtB16JAIcU7PQfyawrrXDBKCv8UXbkzqoRX/rShoxLl8K5f7GIaqG+O8wHKk3
         /SsAmd0Rkwnz85M9MmdX4WEK/dXUiV1v+hdrlD3wYPizdaROVRy0dX6lH3CcLfgsqRFY
         KqMw==
X-Gm-Message-State: AOAM530DtjtCl9FC7rK0rKqgwZGWAWBi2za01T7vPsgqzOpv9OhMBFpA
        PLPRQrlxWgKyZxdWhhe4s7sJFrpZaGAayn9KRYYUGA==
X-Google-Smtp-Source: ABdhPJx7f/7Y7/PbylHk8TCYLor6Xb5GsG6LVEIjHX5o6sAkN9BT82botUdw7znicMa4tS6YdlAkVgj3T+jDibV/OBw=
X-Received: by 2002:a37:a747:: with SMTP id q68mr2927473qke.352.1610555587689;
 Wed, 13 Jan 2021 08:33:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com> <1b884616c85091d6d173f7c1a8647d25424f1e7e.1610554432.git.andreyknvl@google.com>
In-Reply-To: <1b884616c85091d6d173f7c1a8647d25424f1e7e.1610554432.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 13 Jan 2021 17:32:55 +0100
Message-ID: <CAG_fn=X+wtO3tABhJD-Bigx1QHmLu_21_VaEkS9Qsp=EsGS0FQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] kasan: adapt kmalloc_uaf2 test to HW_TAGS mode
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 5:22 PM 'Andrey Konovalov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> In the kmalloc_uaf2() test, the pointers to the two allocated memory
> blocks might happen to be the same, and the test will fail. With the
> software tag-based mode, the probability of the that is 1/254, so it's
> hard to observe the failure. For the hardware tag-based mode though,
> the probablity is 1/14, which is quite noticable.
>
> Allow up to 16 attempts at generating different tags for the tag-based
> modes.
>
> Link: https://linux-review.googlesource.com/id/Ibfa458ef2804ff465d8eb0743=
4a300bf36388d55
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
>  lib/test_kasan.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 283feda9882a..a1a35d75ee1e 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -382,7 +382,9 @@ static void kmalloc_uaf2(struct kunit *test)
>  {
>         char *ptr1, *ptr2;
>         size_t size =3D 43;
> +       int counter =3D 0;
>
> +again:
>         ptr1 =3D kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
>
> @@ -391,6 +393,15 @@ static void kmalloc_uaf2(struct kunit *test)
>         ptr2 =3D kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
>
> +       /*
> +        * For tag-based KASAN ptr1 and ptr2 tags might happen to be the =
same.
> +        * Allow up to 16 attempts at generating different tags.
> +        */
> +       if (!IS_ENABLED(CONFIG_KASAN_GENERIC) && ptr1 =3D=3D ptr2 && coun=
ter++ < 16) {
> +               kfree(ptr2);
> +               goto again;
> +       }
> +
>         KUNIT_EXPECT_KASAN_FAIL(test, ptr1[40] =3D 'x');
>         KUNIT_EXPECT_PTR_NE(test, ptr1, ptr2);
>
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/1b884616c85091d6d173f7c1a8647d25424f1e7e.1610554432.git.andreyk=
nvl%40google.com.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

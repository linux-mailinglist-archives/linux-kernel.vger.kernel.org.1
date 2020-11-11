Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A2E2AF5ED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgKKQNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgKKQNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:13:24 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188E7C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:13:24 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id t191so2160177qka.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y9knGGnUVAWh7DTdx+ZTxdFDVkNgQfbAnELeGfW+RdY=;
        b=JbnLgZIzp99PfnaQOyPQZjGUobB7Rr/9NzAapw7cRdngjihh7MgB5IwK+mfbuoolGv
         PIiGOimz71rAEOA9RvIobUBf3Hx3uApSFk/rjizTF0oyDSZ15v2KiXIxd1XxemH2zEJW
         wUnHodJwMqHKERAGCaSWXHOiSlTHoAS6hWpjKo2hnozWK4LqENakmRsM96dIy/vP+JZN
         MDzuX5DrvJl8L2PeNNOfrT7xcXYQoQtNZ/R/W3gvYE68JNQ71H/aS5oEOjN3Dsu7RoGX
         CWbmqJxBy4Gvr6EWN355aQG67bYlTqjkaLnoVoTJOkjJBS3kdl0TCagmKBzOKqNphkoS
         HfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y9knGGnUVAWh7DTdx+ZTxdFDVkNgQfbAnELeGfW+RdY=;
        b=T/m6qur/4pVEZjKCKbvelJ4kx66kUEaEXO1KTjLmFUx2FISr/CiZM6OeZwWrWtHi6P
         R75bGNex17TbCUNoTaessQ4WLb5pMDfeowpW/BLhEfzrj9xhECJNUxZQurqTDVCXg18i
         yRJRxqDIWwXVQbKpz/wOpMo0yW5WmrNR8hl1HhGeQBhdSQkAbwKNk0HFAW62CTBliZb6
         R6awOiLNAKwj5xrDVN5ZLQz1EKwnGgRFH6aAKj2XRYG3sglt6DJw9sgI2Mn3ypXn3d0m
         tZ6ROqg9XvNf9JxCFqNcmBpGehXZ/C7/XYeFhnV/tFWEgvUjXTGGSl2JSIEbUHw9XkXw
         Ihqg==
X-Gm-Message-State: AOAM533pwBkvPVVc/7Mn1L4hD+zcvNcV7GjZXjETPEugXXhEfDlzoOH2
        uTlBxVvwd5Qpp7iqBy3xCi0n0dwT2wWZyXKWDIG/OA==
X-Google-Smtp-Source: ABdhPJwg1ZqsNa6m+QM8H9U4H7g0FrnS1I967V9k9LzoBXnW04IP01Czg+LMPbvguL00DEn2GMKtOD81ARN3XZDZUzo=
X-Received: by 2002:a05:620a:211b:: with SMTP id l27mr2667134qkl.352.1605111203127;
 Wed, 11 Nov 2020 08:13:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <71fcf23cd66d690afce1d80dc2f4659b2342152c.1605046192.git.andreyknvl@google.com>
In-Reply-To: <71fcf23cd66d690afce1d80dc2f4659b2342152c.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 17:13:11 +0100
Message-ID: <CAG_fn=WS2vA=j-j=uXLpmLh9Fcaj2WO7ahEwQfpPG9H51RFC4g@mail.gmail.com>
Subject: Re: [PATCH v9 36/44] kasan: define KASAN_GRANULE_SIZE for HW_TAGS
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:12 PM Andrey Konovalov <andreyknvl@google.com> w=
rote:
>
> Hardware tag-based KASAN has granules of MTE_GRANULE_SIZE. Define
> KASAN_GRANULE_SIZE to MTE_GRANULE_SIZE for CONFIG_KASAN_HW_TAGS.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: I5d1117e6a991cbca00d2cfb4ba66e8ae2d8f513a
> ---
>  mm/kasan/kasan.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index ae7def3b725b..d745a78745dd 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -5,7 +5,13 @@
>  #include <linux/kasan.h>
>  #include <linux/stackdepot.h>
>
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  #define KASAN_GRANULE_SIZE     (1UL << KASAN_SHADOW_SCALE_SHIFT)
> +#else
> +#include <asm/mte-kasan.h>
> +#define KASAN_GRANULE_SIZE     MTE_GRANULE_SIZE
> +#endif
> +
>  #define KASAN_GRANULE_MASK     (KASAN_GRANULE_SIZE - 1)
>  #define KASAN_GRANULE_PAGE     (KASAN_GRANULE_SIZE << PAGE_SHIFT)
>
> --
> 2.29.2.222.g5d2a92d10f8-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

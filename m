Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291DD2B817F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgKRQIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgKRQIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:08:00 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB072C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 08:07:58 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id y11so1244998qvu.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 08:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ikA7PYEQ/L2cKfevJds4p4NjydPxn3K6IT3FVnbYGLo=;
        b=Ga/ygbCVw0SJLI6Sg1BiEo9a8aJcvDsfyOV6zv//+nmL8wUHPjIgTaZ/XXtUrQ9+Vi
         0ffXudpc5ulLW+lwF+Jmkk/Gx3u73hALEFcCPRqp+P81LRFZD9lH19U6aqkMKKHfLGBk
         KeiSiz3xMTfElx0KVlj1tKlk5d1nYhc1IsGwQIymI7lRn1R5BA6fXQiMNA+rl1OOsSol
         JoeD/ieNbCmL2i1jbpj0rRQlqEh1laM4/OWKSrTcx1ptdhFEkcHqFefSH2c4YkTJHu+5
         A8KfLpOi3FjwQwz5DKUNOum4/mkUkKH2PTRIE5TOk1xJHkp6MVCBvs9+RI+lyMMvwMbB
         xe4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ikA7PYEQ/L2cKfevJds4p4NjydPxn3K6IT3FVnbYGLo=;
        b=bRgVDq1qSwn8R5Nr2oHTiM8vFrruwn3WPsfbgPc5qMGZqGpQCzV50F52GgoqGdmufV
         zjegu1fN5WU00DLAmdahK4wQVP26pvuhsPloJ13WCENQNLaomCQc+ijqUwMaWCLTwGQv
         MgRg2KEEEeIr3ciyq7KE10K6obg6AOuGLYjNZ1Jv++CJlqa+WQZuD+qiI0fkIGg1TyTV
         DCtQR2FgbN7TOqNBWaxB0boqVDCP9nuEgB/YgKZExhVu3Ir+PPXnZCvl0JbJKfV2CilA
         G7q2gjEjR/zZ760qOy6t2/McTEng81qZgONUQBcKbrUuPCbdlxRQONI9k5s7Trqy1jdq
         8h8g==
X-Gm-Message-State: AOAM531qQrsWwyWEhxwqDEdB3q+6YX2SHipCGyb52M5IwscYbu2wnKXV
        Eb353cpDygJbd9nPraIhpDVIHY2jORcHIfibDNjjYg==
X-Google-Smtp-Source: ABdhPJxtPz7dsC8P6DpwOkE46r+tPF2sdUMjx4umzCMfj/BErLsoh6ihlvSNw5ny9XLN+fyz+HOqFNic9Cpv573jq6g=
X-Received: by 2002:a0c:9e53:: with SMTP id z19mr5497551qve.23.1605715677182;
 Wed, 18 Nov 2020 08:07:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com> <b167fd21b86e7d728ba3a8e20be4f7e8373bc22c.1605305705.git.andreyknvl@google.com>
In-Reply-To: <b167fd21b86e7d728ba3a8e20be4f7e8373bc22c.1605305705.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 18 Nov 2020 17:07:45 +0100
Message-ID: <CAG_fn=Xc_OOtqE5Q-fFejBBCfLGtc_kOmZAuE1wdTsjCOmpQ4Q@mail.gmail.com>
Subject: Re: [PATCH mm v10 31/42] kasan, mm: untag page address in free_reserved_area
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
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

On Fri, Nov 13, 2020 at 11:17 PM Andrey Konovalov <andreyknvl@google.com> w=
rote:
>
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> free_reserved_area() memsets the pages belonging to a given memory area.
> As that memory hasn't been allocated via page_alloc, the KASAN tags that
> those pages have are 0x00. As the result the memset might result in a tag
> mismatch.
>
> Untag the address to avoid spurious faults.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: If12b4944383575b8bbd7d971decbd7f04be6748b
> ---
>  mm/page_alloc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 855627e52f81..4a69fef13ac7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7653,6 +7653,11 @@ unsigned long free_reserved_area(void *start, void=
 *end, int poison, const char
>                  * alias for the memset().
>                  */
>                 direct_map_addr =3D page_address(page);
> +               /*
> +                * Perform a kasan-unchecked memset() since this memory
> +                * has not been initialized.
> +                */
> +               direct_map_addr =3D kasan_reset_tag(direct_map_addr);
>                 if ((unsigned int)poison <=3D 0xFF)
>                         memset(direct_map_addr, poison, PAGE_SIZE);
>
> --
> 2.29.2.299.gdc1121823c-goog
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

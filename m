Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2DC2AF46B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgKKPHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbgKKPHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:07:16 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5123DC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:07:16 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id l2so1947486qkf.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O5pvpxuaPFHh8IqCLJNTeWU2Zvn2pUlMlw4POTGBASw=;
        b=hqeRokbo7sPY3P1/uwmI8InkTxMKbd3lPThkpSrdaecxnnxeylVyPEgZjswZNULOOB
         /KM8kYn7Diy+Pfc4nLfhVsrWDSUQO8i4aYMLw0bscYl241tKbeEfvPUeQK9jn1P2Zn6T
         Ldesog2g26mUj58ztmXe6CgFz5zyJm23w5oFHQpiYLD6Gc/5dp/Rb+s+3tBszM9Rxrpw
         1fvjHNEP3cH9Bgtwf+Div8lOHqD/+X7+EoWWzL88NHF7D5tSXkkGDtHl7qjP9jmslWut
         FrBFVldwZ6OcTn3128O01I370GXt8N9H3Axog5W9be2OhmbeJdJlE1D0vvA5sNyvHipz
         QL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O5pvpxuaPFHh8IqCLJNTeWU2Zvn2pUlMlw4POTGBASw=;
        b=Fu9QzhIq/Ui2IFRR01R5TwGwykeleUaolLYQmlwiTQsHhe+/xXxsWxuYhnprkcXs/Z
         IZ369uupvGRF706s4gHo8sM/nau1zydxZqlTqRY+t4MPl9NYjU/fMBnVxSVyFfBXlUt2
         1YlnmbOSzhOmbyLm6uifN58V7iZ8pWeqGJCKOQCfvhmF8azjzU4bTrQaxc34SVIYKcjG
         2QnnR3owAXecBnAqD+93T4R73FXwRJ+PsleZHNZhRPMWTV8VDACZFQWEU0I9pdXxNaC/
         jwLAt2KgxSjowUoq26lzA53RebbVdqi4DYpUjvvnDioxwvppEahxL4WHKBkdWWgN49A3
         yv4g==
X-Gm-Message-State: AOAM5314W5uLO+h8MUEoI57/1HYrieLj4finQDad+uSP1ATJRyvULQ8S
        eTWzSdrd0B1AQhB6CMA1AJiHBbY9W27DP1i1MNEIaw==
X-Google-Smtp-Source: ABdhPJw+mQrX8gWbQl25CCzTZuP5dydceNRRhAx+AnWkx854Rh3hUI+viNi+wHubXntXriZd2B8OMJJf2JvEmv6AdT4=
X-Received: by 2002:a37:bf04:: with SMTP id p4mr26492170qkf.326.1605107235287;
 Wed, 11 Nov 2020 07:07:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <47785f5259ba9ed493d2ac94ec7c2492fa5c1f14.1605046192.git.andreyknvl@google.com>
In-Reply-To: <47785f5259ba9ed493d2ac94ec7c2492fa5c1f14.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 16:07:03 +0100
Message-ID: <CAG_fn=Wn+SaB3c1Xqqr20yS--CB_HRhiPaLfHV1jhF_F0vD_vA@mail.gmail.com>
Subject: Re: [PATCH v9 20/44] kasan: rename print_shadow_for_address to print_memory_metadata
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

On Tue, Nov 10, 2020 at 11:11 PM Andrey Konovalov <andreyknvl@google.com> w=
rote:
>
> This is a preparatory commit for the upcoming addition of a new hardware
> tag-based (MTE-based) KASAN mode.
>
> Hardware tag-based KASAN won't be using shadow memory, but will reuse
> this function. Rename "shadow" to implementation-neutral "metadata".
>
> No functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
> ---
> Change-Id: I18397dddbed6bc6d365ddcaf063a83948e1150a5
> ---
>  mm/kasan/report.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 2990ca34abaf..5d5733831ad7 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -252,7 +252,7 @@ static int shadow_pointer_offset(const void *row, con=
st void *shadow)
>                 (shadow - row) / SHADOW_BYTES_PER_BLOCK + 1;
>  }
>
> -static void print_shadow_for_address(const void *addr)
> +static void print_memory_metadata(const void *addr)
>  {
>         int i;
>         const void *shadow =3D kasan_mem_to_shadow(addr);
> @@ -338,7 +338,7 @@ void kasan_report_invalid_free(void *object, unsigned=
 long ip)
>         pr_err("\n");
>         print_address_description(object, tag);
>         pr_err("\n");
> -       print_shadow_for_address(object);
> +       print_memory_metadata(object);
>         end_report(&flags);
>  }
>
> @@ -379,7 +379,7 @@ static void __kasan_report(unsigned long addr, size_t=
 size, bool is_write,
>         if (addr_has_metadata(untagged_addr)) {
>                 print_address_description(untagged_addr, get_tag(tagged_a=
ddr));
>                 pr_err("\n");
> -               print_shadow_for_address(info.first_bad_addr);
> +               print_memory_metadata(info.first_bad_addr);
>         } else {
>                 dump_stack();
>         }
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

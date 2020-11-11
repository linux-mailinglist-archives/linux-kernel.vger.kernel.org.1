Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0825E2AF1E6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgKKNTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgKKNTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:19:21 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F699C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:19:20 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id n132so1579059qke.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3ogrn6Kw5lJiQVWMvQTcQ5thm+MqBh+iV3abSct+RxI=;
        b=iZREhgvaz7ISKclEY1+1WqsLpRopzwY5mQd9aQ8mp8xBYvTP3rT4Inryfw/lsUZXcX
         hTqUCip6ocvyvHvFSaEcgw+oOy4lmibSKz8DMO31u/2IuYEYrPeifRJAunc6tPTiMtpY
         pWp1Hqbi2Ia2+GPTC2+PE7IWgbT133M25IEeuWK0VYBvEhCXpBJggBFGAWBQSYsTyf7b
         sVpgbeMaM3PvTgquZuNZVvVqs4RT3gDRG5q6JosjTzWA520xCutHy4y8VwIR9EBXErYN
         lLvysneW1n86EY+lh5E1OwZcNYutxSoMHHk1Cc3PICclsKDq3Ix/grYkOCgr8v5lOSu1
         AogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3ogrn6Kw5lJiQVWMvQTcQ5thm+MqBh+iV3abSct+RxI=;
        b=dhQ44dWrP/S35JiDK6aItTTom2ScUehmUObHK4VwX8X7rAzKm5Z/CKT41hQMMg2K+6
         dK9/cKH+aC+OXo0PDeRpApGPKCQvVP2KtuB9ETEbl2GeuqrMnRlTcj1rjQzO8NKV7PzM
         HhcdngfW5h0tYlUiLFBBJ8K8i9o+V25Kqx6I6TB/c/Nr7qTxqR60b+2n1wToLr9PnOHW
         WLHoDTYOw7iaDXwerF5muqz5tT7FrhjwIxzKXIWrr8gCWp0aXac12gZKTLfQKwtX9wFX
         Ft873qhfAENDQlcXmMDZyyrqGbpkc44Qqr11Sb7+h3ZYC2H5mK1m2hmlTYOHaO7dbNae
         7BPg==
X-Gm-Message-State: AOAM5327IYieRZa5vooxh+m5cltROcK5SPBqzmorvAB23atwsnZ79SCp
        Ojo3iQdG4NSnXzYQdQzYQMkqFRnxnlfEyacd68dxtQ==
X-Google-Smtp-Source: ABdhPJxo/YfGs93Lo8RWBR4GBqJ/+6Is+qWyxTHWCTmnYx+Umh/z8lCP3WfNaAU3Vw4M7yLmQxeW4zFbzY+A60XZWqQ=
X-Received: by 2002:a05:620a:211b:: with SMTP id l27mr1788572qkl.352.1605100759422;
 Wed, 11 Nov 2020 05:19:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <24a25ef0fcfa07a94129e2ae5ec72f829c57ac42.1605046192.git.andreyknvl@google.com>
In-Reply-To: <24a25ef0fcfa07a94129e2ae5ec72f829c57ac42.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 14:19:08 +0100
Message-ID: <CAG_fn=Xg5J0JABbpiHDXMty6=BSHohnaqG3kv9xkPoXEHbMk7g@mail.gmail.com>
Subject: Re: [PATCH v9 02/44] kasan: KASAN_VMALLOC depends on KASAN_GENERIC
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
> Currently only generic KASAN mode supports vmalloc, reflect that
> in the config.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: I1889e5b3bed28cc5d607802fb6ae43ba461c0dc1
> ---
>  lib/Kconfig.kasan | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 542a9c18398e..8f0742a0f23e 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -155,7 +155,7 @@ config KASAN_SW_TAGS_IDENTIFY
>
>  config KASAN_VMALLOC
>         bool "Back mappings in vmalloc space with real shadow memory"
> -       depends on HAVE_ARCH_KASAN_VMALLOC
> +       depends on KASAN_GENERIC && HAVE_ARCH_KASAN_VMALLOC
>         help
>           By default, the shadow region for vmalloc space is the read-onl=
y
>           zero page. This means that KASAN cannot detect errors involving
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

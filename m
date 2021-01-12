Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3262F2911
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 08:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbhALHlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 02:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730190AbhALHlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 02:41:35 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F48BC06179F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 23:40:55 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id p14so1122676qke.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 23:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BKnokxRD1I6llLoX7662tW98pzgHQdpcOb6fgDSpfGE=;
        b=CPW6waRy7HCf0fFBnkmtF16rAs1YeatzlNS9Mu/UB63AttABUkS4rlk6uf4jJmN+q6
         dz25S1JgoXSJay6ZrrjWmMGqzWvw/TUAEaXHG1ryK07eG1LkS1LD39n9IQWw8fs83xP3
         ccvrva9Dz165V0PkkR4iYoziBND5Vpjdf85cZebSD3K+djperjQG8ZFlBKSENHGpGIJu
         CDVe2xNORIwrfV/vitXk35/Vx3R9IudeY7lAN+1ScgJJaCNTJ7V6hHY83mfSAM2d2LAW
         f+9TFSStJzkornSFgs+GbXH9Gv23BePE9KkwI0EjtpouvGqm5TUL4bOR9U5wLfzvp+xO
         0iWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BKnokxRD1I6llLoX7662tW98pzgHQdpcOb6fgDSpfGE=;
        b=lCTT9zGXRDnL+eeOWrNt2iabXIPb8PyxoMt8EJPUH8TrCSX9ywnRiMioW69VjXcvdU
         AvKRvAKEDa2oOjtZCxzM9cUEeWXmv0DTi8Tm3oF6YAwl28l1EUYjpLF6b2JpPD5WU3hA
         3L4HKaWwg4nmricIcUS+94WqcZbUXEDscllIbKQI7dB4SSz2AZZ8jH0S525HC/sEBb4v
         jOE+c7vGpW3FNqh2Mu6+VtSDO6BVUjpgyQevK44QPUVpIODq7ZBXW2HEl/SLlbEdKb7W
         D27pd3ecafce/vL/Lko1scg2S3BWWK3IOD2VX1v9RhRE+cwp9ySlrZZNcvUFk/qZsNK3
         UoJQ==
X-Gm-Message-State: AOAM533EZIpEoMg0DDsF2xwukfTFR0vDYRarkn+8xS829z8Zuo/LU4V7
        TC59ZDost/5XGGcqdMRmfEvRP/sW9wUZIsV/aFdnhw==
X-Google-Smtp-Source: ABdhPJwnDenEpJQwgyHM2/JdCNJ81bm+LlTg1WMoKkD9MoAviJRmD3yhcTCqZGcs+L8RB+N7HB8UrwbsnQ/9yS147cE=
X-Received: by 2002:a37:a747:: with SMTP id q68mr3196410qke.352.1610437254475;
 Mon, 11 Jan 2021 23:40:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com> <a5dfc703ddd7eacda0ee0da083c7afad44afff8c.1609871239.git.andreyknvl@google.com>
In-Reply-To: <a5dfc703ddd7eacda0ee0da083c7afad44afff8c.1609871239.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 12 Jan 2021 08:40:41 +0100
Message-ID: <CAG_fn=WOSsVPOKVS8GF8h-hHavgcqMEdbjy4Puy=bajTmW7sbg@mail.gmail.com>
Subject: Re: [PATCH 02/11] kasan: clarify HW_TAGS impact on TBI
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 7:28 PM Andrey Konovalov <andreyknvl@google.com> wro=
te:
>
> Mention in the documentation that enabling CONFIG_KASAN_HW_TAGS
> always results in in-kernel TBI (Top Byte Ignore) being enabled.
>
> Also do a few minor documentation cleanups.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Iba2a6697e3c6304cb53f89ec6=
1dedc77fa29e3ae
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
>  Documentation/dev-tools/kasan.rst | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/=
kasan.rst
> index 0fc3fb1860c4..26c99852a852 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -147,15 +147,14 @@ negative values to distinguish between different ki=
nds of inaccessible memory
>  like redzones or freed memory (see mm/kasan/kasan.h).
>
>  In the report above the arrows point to the shadow byte 03, which means =
that
> -the accessed address is partially accessible.
> -
> -For tag-based KASAN this last report section shows the memory tags aroun=
d the
> -accessed address (see `Implementation details`_ section).
> +the accessed address is partially accessible. For tag-based KASAN modes =
this
> +last report section shows the memory tags around the accessed address
> +(see the `Implementation details`_ section).
>
>  Boot parameters
>  ~~~~~~~~~~~~~~~
>
> -Hardware tag-based KASAN mode (see the section about different mode belo=
w) is
> +Hardware tag-based KASAN mode (see the section about various modes below=
) is
>  intended for use in production as a security mitigation. Therefore it su=
pports
>  boot parameters that allow to disable KASAN competely or otherwise contr=
ol
>  particular KASAN features.
> @@ -305,6 +304,13 @@ reserved to tag freed memory regions.
>  Hardware tag-based KASAN currently only supports tagging of
>  kmem_cache_alloc/kmalloc and page_alloc memory.
>
> +If the hardware doesn't support MTE (pre ARMv8.5), hardware tag-based KA=
SAN
> +won't be enabled. In this case all boot parameters are ignored.
> +
> +Note, that enabling CONFIG_KASAN_HW_TAGS always results in in-kernel TBI=
 being
> +enabled. Even when kasan.mode=3Doff is provided, or when the hardware do=
esn't
> +support MTE (but supports TBI).
> +
>  What memory accesses are sanitised by KASAN?
>  --------------------------------------------
>
> --
> 2.29.2.729.g45daf8777d-goog
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

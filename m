Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9E72D497E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbgLISv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387443AbgLISv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:51:58 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C13C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 10:51:17 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id j12so2400253ota.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 10:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YT5BHJcxpuXHRj14Xs4MOizg/4PTRYgUUf1aSMIZM3Y=;
        b=Hc+1o93cAMl1ROHeeYK6Kbiz3vyKi1cQ31vynsXzwNw/FN4xhHJq36IYk3VLEg06k0
         BT/p1ci4U+C/TFSkW1Uog19rU5q1AcvQVcgtWo3I/xFQEx8gZVNeSGOQgNukUrYZDz6K
         rx2BHlLuQuUR30NB1eQ7S4AmoWJf1/iQWX0bo02SKN6fpg8NNM5slv861Z3G98QRi48m
         RFhusNMk0juk4N6Vwhoo96QLnGw7fzN8U+fPk5l2k5h6HKGy1VE6lAFsbaXJg/Jt7wN0
         sCKF4oabqEAN5XGW8fjbtaBCa0T7YU65ZcLlJUeumQe5dDBxG3hrDrXqYl3ujR9mfoqY
         bErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YT5BHJcxpuXHRj14Xs4MOizg/4PTRYgUUf1aSMIZM3Y=;
        b=Zm4JJ3aOUX5Y8RRYGVvniLaomIpAx5dwiO04Ofkbq/qCdCrM797Wv+1OLJapZsYTgG
         029youdFGo9Jfzbx0io4BsaMlR18BgvBEMtP9Fr6E0oPcYqgM3nMDTaUI6rIlJ7gAscH
         8iM0aRvrxjD31sWulxnwkXSpikbXsocAfXnyXrfNscxn23xYOE31ysnDNWMzTojsD29b
         VJG5L3nN1WDa1j46fAnWz2ADlUGlKKVom/NpK6u3CiQhpTRA2A4ngX0VhwUi44pPh1Ia
         gs0Jiz4S8ZAZkmeVfB00XXMNXjStovzFDyGLFa2VT1O0iarMcPAgwpV8Fvu9KR7dh2eR
         dyJA==
X-Gm-Message-State: AOAM533qHYc53364FEpPwyZJPHf6V+4xOxhvJv2PwVcI2RvdYgcviZ0B
        IZCkATEJWMBbMAwjGyousc7KV9AfRljDHwoTOC9SRw==
X-Google-Smtp-Source: ABdhPJzjg43trPv/rgu+HRPFPFmTDSamvp5BPSMCfszGWyUgt789RrPbJTDwY25i1OliM5E4KsPW5RTWipc+t3ILdmA=
X-Received: by 2002:a9d:7cc8:: with SMTP id r8mr3011278otn.233.1607539877102;
 Wed, 09 Dec 2020 10:51:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1607537948.git.andreyknvl@google.com> <a6287f2b9836ba88132341766d85810096e27b8e.1607537948.git.andreyknvl@google.com>
In-Reply-To: <a6287f2b9836ba88132341766d85810096e27b8e.1607537948.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 9 Dec 2020 19:51:05 +0100
Message-ID: <CANpmjNM9suHQY-uQN9g5h=Vdv2wotDKNdcnHM=-RTtEb2sCZTA@mail.gmail.com>
Subject: Re: [PATCH mm 2/2] Revert "kasan, arm64: don't allow SW_TAGS with ARM64_MTE"
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
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

On Wed, 9 Dec 2020 at 19:24, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> This reverts "kasan, arm64: don't allow SW_TAGS with ARM64_MTE".
>
> In earlier versions on the hardware tag-based KASAN patchset in-kernel
> MTE used to be always enabled when CONFIG_ARM64_MTE is on. This caused
> conflicts with the software tag-based KASAN mode.
>
> This is no logner the case: in-kernel MTE is never enabled unless the
> CONFIG_KASAN_HW_TAGS is enabled, so there are no more conflicts with
> CONFIG_KASAN_SW_TAGS.
>
> Allow CONFIG_KASAN_SW_TAGS to be enabled even when CONFIG_ARM64_MTE is
> enabled.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6fefab9041d8..62a7668976a2 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -135,7 +135,7 @@ config ARM64
>         select HAVE_ARCH_JUMP_LABEL
>         select HAVE_ARCH_JUMP_LABEL_RELATIVE
>         select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
> -       select HAVE_ARCH_KASAN_SW_TAGS if (HAVE_ARCH_KASAN && !ARM64_MTE)
> +       select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
>         select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
>         select HAVE_ARCH_KFENCE
>         select HAVE_ARCH_KGDB
> --
> 2.29.2.576.ga3fc446d84-goog
>

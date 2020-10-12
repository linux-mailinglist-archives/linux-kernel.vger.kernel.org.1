Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D87528B3BC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388182AbgJLLYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:24:53 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:18817 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387617AbgJLLYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:24:52 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 09CBOVvL001659
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 20:24:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 09CBOVvL001659
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1602501872;
        bh=1O54a6n1Y+w47V7PlCYUyDXJQMalh1tOg45OGoRcFHk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1GPaEvWK+DHmCIuUnO4EqKaQte+XXmoDrwVsaAQYL3xqkBNyJqnFTMx9jpW3G5gNz
         DwHdDFueprAXpdkA6d0A+2Xo9WIkvHa+d1I7XhTYbr55VTEx1lEPp1/8z3ckICMvZN
         3L58OoRP0ivq0R7zTqt2u44jYMWVEXsjI+6MlSceaO+bjlX2F6y/fU70IAyKrvNz8Z
         PziIEvgiHxIWrypjfUM/fG6YAqaceBmVKVXOX9YN6yPhmyAXgZlCaDr2rDat7VFC10
         /dsOG8B93gA2v52Abj14y3I9/izd/ErB0Uj1tYimgiJwvkByS26U2Wyhk3J55JYDWd
         nsybF7TlN0H5A==
X-Nifty-SrcIP: [209.85.210.177]
Received: by mail-pf1-f177.google.com with SMTP id c20so2604387pfr.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 04:24:32 -0700 (PDT)
X-Gm-Message-State: AOAM531u3Dx0cq2I2jNMm62nO14+YMdhFlJN39SyaW2KZBbCuJynkq0D
        BtKAQ9owxb03CI4WnjEvIsL25njvup7MNstZnko=
X-Google-Smtp-Source: ABdhPJziJ+j3biZp2zAvX7hfva2hdJ1JB0L8oIwnObkHmznSugSjQcB8tSVwg8CaDAtHapcbnPXZqIqc3M2VwOgkO7E=
X-Received: by 2002:aa7:9501:0:b029:155:3b11:d5c4 with SMTP id
 b1-20020aa795010000b02901553b11d5c4mr19966263pfp.76.1602501871489; Mon, 12
 Oct 2020 04:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200831035803.96852-1-yamada.masahiro@socionext.com>
In-Reply-To: <20200831035803.96852-1-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 12 Oct 2020 20:23:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ4wp8UAhrAsSubJs_=0YeD++qnVezCcK8yHL=miHzyKw@mail.gmail.com>
Message-ID: <CAK7LNAQ4wp8UAhrAsSubJs_=0YeD++qnVezCcK8yHL=miHzyKw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: step down as maintainer of UniPhier SoCs and
 Denali driver
To:     soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 1:10 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> I am leaving Socionext. Orphan the UniPhier platform and Denali NAND
> driver until somebody takes the role.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> I hope this can be applied to the ARM-SOC tree.


Can you pick up this?



>  MAINTAINERS | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b186ade3597..33aa482fdf47 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2652,10 +2652,8 @@ M:       Dirk Opfer <dirk@opfer-online.de>
>  S:     Maintained
>
>  ARM/UNIPHIER ARCHITECTURE
> -M:     Masahiro Yamada <yamada.masahiro@socionext.com>
>  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -S:     Maintained
> -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> +S:     Orphan
>  F:     Documentation/devicetree/bindings/arm/socionext/uniphier.yaml
>  F:     Documentation/devicetree/bindings/gpio/socionext,uniphier-gpio.yaml
>  F:     Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
> @@ -4955,9 +4953,8 @@ T:        git git://linuxtv.org/media_tree.git
>  F:     drivers/media/platform/sti/delta
>
>  DENALI NAND DRIVER
> -M:     Masahiro Yamada <yamada.masahiro@socionext.com>
>  L:     linux-mtd@lists.infradead.org
> -S:     Supported
> +S:     Orphan
>  F:     drivers/mtd/nand/raw/denali*
>
>  DESIGNWARE EDMA CORE IP DRIVER
> --
> 2.25.1
>


-- 
Best Regards
Masahiro Yamada

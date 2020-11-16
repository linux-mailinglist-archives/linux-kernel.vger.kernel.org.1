Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319FF2B3BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 04:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgKPDdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 22:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgKPDdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 22:33:37 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94609C0613CF;
        Sun, 15 Nov 2020 19:33:37 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id v11so11959291qtq.12;
        Sun, 15 Nov 2020 19:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sp+Xd0qXLR5F3GGLG/m/VIpVfX8rv5kyrzW97rCHfyg=;
        b=QbtMGSSGq4rMRr95cxbyhkZXwyj3dBEBWqRsjEIQMkVzxgIBiDTnwXWGOR8OEhT6Ia
         facXJ4PrC2xTitPiKMh0E5bvbbLV4OMDxfCWgaWmeEPE01xBdXSdYUsWOdTTkkLsPwNU
         YfeSK/926BxBsxm0zxxbutrFtZXsCp2pcxFnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sp+Xd0qXLR5F3GGLG/m/VIpVfX8rv5kyrzW97rCHfyg=;
        b=EDehWwFbyZs7n+yKPKcSG12budSSdDumyPmTnHdWU34cNuQD8pYotwVT4tdJEMDXGc
         hyQFx63r+QlCH62CmyUmUzd7E+1w/6wMyNjot7358yvpUzHFghQvHsSQOtEoWwutLAbP
         BXuxbQ7djGP5RkwFJ4DEHfpcKn3WygtYIYErSSMHXKJCwGT2Fn2OTbbG4MkEbQMgRdbH
         aZ6SGqAdo14aPVmQfd0xVfx1FQmO0oMdDgVz3vR9oOoeLaLU4vK32njYrHObWY18QRiE
         6bX7uRwR810GLNe11NAXIY3uNzo6DfEAplQgIJvwMbNpwZMN7i4HYMFab6Mj7AaNo8Lg
         9Rng==
X-Gm-Message-State: AOAM530wJH4srXX+uWnKjOTxIEQ31l1djPTApN7qBNiTs2Bb1NKU+lsV
        RbiDGy5TAUduGqP4Hd9ABk/51nztLnSiqR0NgNw=
X-Google-Smtp-Source: ABdhPJzsWj+yxl3qg6XjJcPGcwkO69M1HymTilFfhNlF7YBUOR+anj3VYmzWzAkwEZq6Gg3CRaGVdagtdgfvrvMw57M=
X-Received: by 2002:aed:33a3:: with SMTP id v32mr12755782qtd.263.1605497616267;
 Sun, 15 Nov 2020 19:33:36 -0800 (PST)
MIME-Version: 1.0
References: <20201110072159.7941-1-rentao.bupt@gmail.com>
In-Reply-To: <20201110072159.7941-1-rentao.bupt@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 16 Nov 2020 03:33:24 +0000
Message-ID: <CACPK8Xcy=EAP4qTyBXoxExXthR31sqS_+gCu41X2yxL6aC8eMw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: wedge400: Fix FMC flash0 layout
To:     Tao Ren <rentao.bupt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 at 07:22, <rentao.bupt@gmail.com> wrote:
>
> From: Tao Ren <rentao.bupt@gmail.com>
>
> Update "data0" partition's size from 8MB to 4MB to fix "partition data0
> extends beyond the end of device" warning at bootup time.

Thanks for testing :)

> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

I will apply for 5.11.

> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
> index ad1fcad3676c..63a3dd548f30 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
> @@ -124,8 +124,8 @@
>                  * "data0" partition (4MB) is reserved for persistent
>                  * data store.
>                  */
> -               data0@3800000 {
> -                       reg = <0x7c00000 0x800000>;
> +               data0@7c00000 {
> +                       reg = <0x7c00000 0x400000>;
>                         label = "data0";
>                 };
>
> --
> 2.17.1
>

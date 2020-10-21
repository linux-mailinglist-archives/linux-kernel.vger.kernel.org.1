Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63022947AC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 07:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440333AbgJUFF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 01:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440323AbgJUFFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 01:05:24 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B403C0613CE;
        Tue, 20 Oct 2020 22:05:24 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z33so1085289qth.8;
        Tue, 20 Oct 2020 22:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=78wXEbS6ekdukUkUx63JywMGATdAYjZFw03TanW/IpQ=;
        b=l8CzAUudEDswINpyB+hifa2QzeewX76VbvBA98pOOcnwvHvhw4asi5BgCyGbdOsFZv
         yFeYi9EmGWt4Pmgfp3vT0WScIZbotse9ceH3XBYgqM8NVSVnWLYXgw4DMNaBIXWVF49/
         TH/ETgYtYTxlLaUlXLHyJ8QJlJNp3JP6nEVKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=78wXEbS6ekdukUkUx63JywMGATdAYjZFw03TanW/IpQ=;
        b=LjgZy7eEX/eX2z4Bm2V+qKU/cfzbI0gzxvJr5j3LivdC8dwABvyY84rfDvW5ExzP4s
         6OwQQ5y8XeoyZ3a/AsQT3a0xsGxBVK0MLx/PtTLuSYoJn++iKL9GCOHg1z4oMl4z/zKi
         E/hBtqzqlwlsSAgfV8jc0hapUHjOYFE/qZPVJAeFSc6yFTVCfhjPolwGsD4A1jFLPaKu
         hNNlWy7htELme8cdQdOx3fYsBNd41a1LuKJ71G7k7YxbTwD++0ywTV5t9A0PoJDYKiCC
         5Oo/kU2g+Ou8+fxyCnBgIrUYYSpVo3SXk1e6WL/Er+Un3YMdWkeZNHa/AbrcjvGSGCeS
         /H2w==
X-Gm-Message-State: AOAM5338/eCFPU7wnzY2qtel0ab6Ct1LGSlKL1KEeJhKliD9ycbmSr01
        1zlNfp2mx2o40T/V0TBGX73J3fyCmlfnJelHwsw=
X-Google-Smtp-Source: ABdhPJxYC3k0wPRhs+0XdUEQkPAhu2L6CxPNS4viq8Grxc8wAS+/fGWEFzckw41+y/kZrEgskwke7fKqeZA9N/Y3SEM=
X-Received: by 2002:aed:3325:: with SMTP id u34mr1553632qtd.263.1603256723674;
 Tue, 20 Oct 2020 22:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201016043513.119841-1-andrew@aj.id.au> <20201016043513.119841-3-andrew@aj.id.au>
In-Reply-To: <20201016043513.119841-3-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 21 Oct 2020 05:05:11 +0000
Message-ID: <CACPK8XeiPBPyLu5pvjCgYquCKh+PynVKGyibUSAi+W_xw0Awfg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: tacoma: Add reserved memory for ramoops
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Oct 2020 at 04:36, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Reserve a 1.5MiB region of memory to record kmsg dumps, console and
> userspace message state into 16kiB ring-buffer slots. The sizing allows
> for up to 32 dumps to be captured and read out.
>
> Set max-reason to KMSG_DUMP_EMERG to capture bad-path reboots.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> index 46f2f538baba..4f7e9b490e1a 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> @@ -26,6 +26,15 @@ reserved-memory {
>                 #size-cells = <1>;
>                 ranges;
>
> +               ramoops@b9e80000 {
> +                       compatible = "ramoops";
> +                       reg = <0xb9e80000 0x180000>;

I take that r-b back. When booting, we see:

[    0.000000] region@ba000000 (0xb8000000--0xbc000000) overlaps with
ramoops@b9e80000 (0xb9e80000--0xba000000)

Which appears to be a true statement.

> +                       record-size = <0x4000>;
> +                       console-size = <0x4000>;
> +                       pmsg-size = <0x4000>;
> +                       max-reason = <3>; /* KMSG_DUMP_EMERG */
> +               };
> +
>                 flash_memory: region@ba000000 {
>                         no-map;
>                         reg = <0xb8000000 0x4000000>; /* 64M */
> --
> 2.25.1
>

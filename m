Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052E627A74F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 08:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgI1GR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 02:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgI1GR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:17:59 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17911C0613CE;
        Sun, 27 Sep 2020 23:17:59 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id i26so6790220ejb.12;
        Sun, 27 Sep 2020 23:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=og/xKIlcnbQwfKfayjLu22fVEXxaNG/oUzExQ/XzAww=;
        b=WAQw2JxdpDxNCsx53zvA/3X0U++fqTbH9QXQn7Yt5HYkaUnc9AtPnWJlVatu8i/dg1
         HUxqUqF5NCaH+N4eVnQx36+Q2/SxFt19BupS6BpGajSgr6p3w834ktVrtSTneumMDqS1
         qK1A4h+KGEw5245Dv9CnwMHdo0f+plBx3oQwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=og/xKIlcnbQwfKfayjLu22fVEXxaNG/oUzExQ/XzAww=;
        b=m09h4ipZzkg2nd4UnUSz8eNCCnBUQukv80N45aGn/M5PWInlPqqnq2H6SZwMVBxeTE
         lnMrEVB265hXLL469LMPbQmRkgYe4m+Wt6/A/TeaQpMkcQFp9TzrQ2d6KUiQRyPa/alx
         p3nkd++CKPd9KZJbj6GbfBGDgCSCRPNkvWgYgp4DV0+ZF3sEMKmXEWPN4pPkVHqYIQnP
         n5klq04g5tKRqVWoUeJgMcDE/dHSP8ejVE5s6H0topSX5MjOjFCooUqkTDmXLv7PazO4
         fXafQ4YT+k+hZ+bzKBAaHSUhABP9Lp6DnODHUOg5vM8w3q9Jmo49Xob4i4R5brMLyKrP
         SGbw==
X-Gm-Message-State: AOAM533EzaGe1A+2D8pRJbn1MvOJfBUEF2/foGCOv6UJpooxn4gz4hj5
        F75TJ65xnoHMYfXNWMcUMN7JgX7aY8eOaFsp0jI=
X-Google-Smtp-Source: ABdhPJzsfZ9UNUyavQU1xUwjCp963U/zra5wh2Va6Jp9paYI+FUdpMAihGhZNiWAoH+ndHELSr6+0tK/s0lybXrQf0E=
X-Received: by 2002:a17:906:4cd6:: with SMTP id q22mr158265ejt.139.1601273877792;
 Sun, 27 Sep 2020 23:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200923164730.176881-1-tmaimon77@gmail.com> <20200923164730.176881-3-tmaimon77@gmail.com>
In-Reply-To: <20200923164730.176881-3-tmaimon77@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 28 Sep 2020 06:17:45 +0000
Message-ID: <CACPK8XfLn_AA3HJZ8kFadbdN0gn9i-eGoGXoHQ8C_Lu4CU1aYw@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] arm: dts: modify NPCM7xx device tree timer
 register size
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Sep 2020 at 16:48, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Modify NPCM7xx device tree timer register size
> from 0x50 to 0x1C to control only the timer registers
> and not other hw modules.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> index 16a28c5c4131..72e364054e72 100644
> --- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> +++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> @@ -120,7 +120,7 @@
>                         timer0: timer@8000 {
>                                 compatible = "nuvoton,npcm750-timer";
>                                 interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> -                               reg = <0x8000 0x50>;
> +                               reg = <0x8000 0x1C>;
>                                 clocks = <&clk NPCM7XX_CLK_TIMER>;
>                         };
>
> --
> 2.22.0
>

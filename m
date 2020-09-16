Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EA226C891
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgIPSw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgIPSJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:09:11 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7711EC014B6B;
        Wed, 16 Sep 2020 06:22:07 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p9so10304247ejf.6;
        Wed, 16 Sep 2020 06:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xD3NKK/9WqZQ8mSJmyDJLCFuzUla2/xMf/QmLlzIVUs=;
        b=fZtnO40nJ7jwoTUeAyUnrS8AOzePCAofkKgqmagwGlXgFefEkzw9npwQbgrMuXyj/D
         /rbW8aVb5WqEHT+Vr87oDvhx6nWq9bCNdnSytMLR1imfoKyBX8e6cYa2EkwrrIU3kh7K
         SHeRSbcisYb6NKJhumvxWNMbj0sULoa3gurGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xD3NKK/9WqZQ8mSJmyDJLCFuzUla2/xMf/QmLlzIVUs=;
        b=rDr+33nNn5qlU0HTJpNLte4Mo9k3qfTI44xdBQpcBXIecDgBcwG8jtNUDIohfZXGlO
         PMkfUcxsSmvym51hT2QEhVYT2KfbPvVwhltfVabmA6RNtONuA7HtEG7eq1CLB5xZAIoT
         QTspUxBRkDdHDno49xX935nILe8flJ6IRjYKGte8mkWw74gBTwxeiD5WvVF5+lpN3NvW
         8BETd0+rj5kWfP58xe101UGkKjrkkqIEu7F9injWGa82OTk7Zy//TVxIP49i1zxsdMMC
         wnkqnpHZubQpuv8T0NCMTuOYXTo+QdMGOXF6ZXcRadaMcz96rHUWEnJZpc1jcr6CHLWV
         AGGg==
X-Gm-Message-State: AOAM5304LRff72NEVqq3GC2/qv+PCZcDfmkDqug6OcxCDZR7k3k4BofX
        oOuV15cXDkvae+HUsn6Z4QwpayGOtsTInTZy2WU=
X-Google-Smtp-Source: ABdhPJzKZTpLLTK2F8ONzEfxczWJQjIJLJR9lH6/TQiDENHFpqKCpJVo/NuRQ6aP1FZYNuNqxWIiuoG92iWykc7fdN4=
X-Received: by 2002:a17:906:8695:: with SMTP id g21mr24573662ejx.504.1600262526112;
 Wed, 16 Sep 2020 06:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200916125554.195749-1-tmaimon77@gmail.com> <20200916125554.195749-3-tmaimon77@gmail.com>
In-Reply-To: <20200916125554.195749-3-tmaimon77@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 16 Sep 2020 13:21:54 +0000
Message-ID: <CACPK8Xc49DRhO-3bJN5f6g+qYYm=7OYxc_k18+cUJLnKURNUGw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] arm: dts: modify NPCM7xx device tree timer
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Sep 2020 at 12:56, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Modify NPCM7xx device tree timer register size
> from 0x50 to 0x1C.

We can see that you've done that from the patch. You should instead
use the commit message to describe why you're making that change.

Is it incorrect, or is there some other reason?

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

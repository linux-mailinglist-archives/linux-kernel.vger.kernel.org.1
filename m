Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038192D20BB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 03:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgLHCVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 21:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgLHCVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:21:38 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCD7C061749;
        Mon,  7 Dec 2020 18:20:58 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 186so849164qkj.3;
        Mon, 07 Dec 2020 18:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tRTmRR6i5ldsnDvLccKv0+2Lb/JpoYzM8sB3u0+LQeA=;
        b=CuiuUZ7cRzFVO+dKyyJQyf5ZHldpCmyxXrYWWL6lsEzQY2wslizR1rDI+AF6q4277L
         ixAreq4zBPDp3igSHHfdLP/YL6WtVuz8hh7uWrKiXZ812wu1hzrh+5Hcw3o5DTh3M3JB
         edRA4LLoiXWYh9drK4Cr+LTjjRzDxwRZf8+tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tRTmRR6i5ldsnDvLccKv0+2Lb/JpoYzM8sB3u0+LQeA=;
        b=r74prnFoibLQm3ztmkdcSzh5nBGoYzHdaRtRUtucLLTnUZP7FgRSaouQztxNw+Htzs
         xU7iSb40mSIvL8Wt7uhXuj4MYbZna7YVvTd6CXiCxiO/P9IsIm1+8QELJX6DP7b/9C+9
         WDXuUjChkqwOvUhLyVMm8Oyh0YnyKt/bcnBa6OJfmaACH/88G+dJ2XuVDmqiPQf8fZEs
         gM9BIAn5LQTTgKxkbmZx0l/IeV+zQkM7/knuSxJO5Y44GHN4WQ19khcaV5f6bfS16HNy
         9f1/lvOvbtKGMUYZdOaaFb0C2PBofC9t60ouMZhgShkhn3FHLd9D9v+rOoUQ4plcHwGT
         Ap4g==
X-Gm-Message-State: AOAM532Od+I2wmK6d7+mPJb/DyMfF7KKjc9j/27aBaUaTiJzEet3D+bB
        jNq6YP/5t3q+djmY8LqckQs/uqZXtkQBjfepS0I=
X-Google-Smtp-Source: ABdhPJw2ud19QUIg0leAoNjEpRtpBSdzoxEzw3u5EdIlzVd2mY+5KlLyp1VjqJyVAMszDwkqz31ae+WntOV9qGaODIQ=
X-Received: by 2002:a05:620a:7e8:: with SMTP id k8mr27038811qkk.273.1607394057671;
 Mon, 07 Dec 2020 18:20:57 -0800 (PST)
MIME-Version: 1.0
References: <20201202051634.490-1-wangzhiqiang.bj@bytedance.com> <20201202051634.490-2-wangzhiqiang.bj@bytedance.com>
In-Reply-To: <20201202051634.490-2-wangzhiqiang.bj@bytedance.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 8 Dec 2020 02:20:45 +0000
Message-ID: <CACPK8XfVGSy=ST8afmcA-VTRZEdf-5-LSbXbd5DZ7LQ999mcxA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Add LCLK to lpc-snoop
To:     John Wang <wangzhiqiang.bj@bytedance.com>
Cc:     xuxiaohan@bytedance.com,
        =?UTF-8?B?6YOB6Zu3?= <yulei.sh@bytedance.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020 at 05:16, John Wang <wangzhiqiang.bj@bytedance.com> wrote:
>

Can you add a note here about why we are adding these so it's clear is
a fix/enhancement?

Also add a Fixes line for both patches.

> Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>


Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 1 +
>  arch/arm/boot/dts/aspeed-g5.dtsi | 1 +
>  arch/arm/boot/dts/aspeed-g6.dtsi | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index f606fc01ff13..2364b660f2e4 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -370,6 +370,7 @@ lpc_snoop: lpc-snoop@10 {
>                                                 compatible = "aspeed,ast2400-lpc-snoop";
>                                                 reg = <0x10 0x8>;
>                                                 interrupts = <8>;
> +                                               clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
>                                                 status = "disabled";
>                                         };
>
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 19288495f41a..30bbf7452b90 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -496,6 +496,7 @@ lpc_snoop: lpc-snoop@10 {
>                                                 compatible = "aspeed,ast2500-lpc-snoop";
>                                                 reg = <0x10 0x8>;
>                                                 interrupts = <8>;
> +                                               clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
>                                                 status = "disabled";
>                                         };
>
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 97ca743363d7..4b1013870fb1 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -520,6 +520,7 @@ lpc_snoop: lpc-snoop@0 {
>                                                 compatible = "aspeed,ast2600-lpc-snoop";
>                                                 reg = <0x0 0x80>;
>                                                 interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
> +                                               clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
>                                                 status = "disabled";
>                                         };
>
> --
> 2.25.1
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C6B2D8299
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 00:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437052AbgLKXHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 18:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436997AbgLKXGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 18:06:39 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6349FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 15:05:59 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id 23so15533014lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 15:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VPtMdGDRGuPEDGFmGnMvWlPbwtTye9nLOQ6zo2Mm3+s=;
        b=Tkxo8ubznZ/ihmwdGKwM0mnEC/9Inp+35eFt9HZ4SSZ8hVM2LajmncJVbJ8vVT9g7Y
         Bzevfd9OPqrtR7vCmS+Qyq9Q66deWC7tSue0PfNWMwfZw+4NMc6PVS3sMyL2AEgdJLVQ
         bs5Q8FBifb8fdc0t8MaeXkMsujAtyFcoVR93gBdo3ts2xXxu84uSsSc7nvDA31bMjA0T
         zyDFK0CL+q56OwKRrpoRUSRwndyj0xZxR5Awy2lgC48HQMSVM7YiZzG6POcphjwjahwN
         rIia2uSFw7gU6bSo0F+0LAg6gQCxPIftjemfQbohCg3tLqSw2jxFdpQ51oypEL8ksD+W
         HPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPtMdGDRGuPEDGFmGnMvWlPbwtTye9nLOQ6zo2Mm3+s=;
        b=B3wqZkra21c+84+zQizkpPwqHD9vllSl2IfGgSsOjZ8/q20gycFn5/5ZSYQWGV3/GS
         BID2lI7NLyPST9fwl22b4gxnm2Dh9mxE5SkQ3Y9Oxw5cAlPj8qxCqI6YIggKrPBhWxSr
         nOZjIgZQmHTjqOkznGTzFZJIErdVqqScvQ+GyutXQfBuO3ynW7RcGHZHrDtiCI9d2TZD
         mwhZXIc+dwPpKvvLxKdz311191aijkCYVRqbyfut8V88iO+reUCDdURATpGn0gH07ku6
         jhy2jcpjZyT384anwu2rK0q9UfMNoDE6B9pN7f98Vj2SDXzg26Q08jcEFzHPltqHjvEF
         ZbYA==
X-Gm-Message-State: AOAM533pwoX3oajdow3IxdWWeR+EODI0hLm1xMvv3mdkuK5JjtLUcesZ
        /kixT+1mdhcDYkTNekkaoFnVTdxnK3qRQpZe2nD+WzZGQgjDml9Q
X-Google-Smtp-Source: ABdhPJyG4JiWO5sICrhd+prNYw2YnrYATbC3tLV3EewLAZiuaES/S08tUz/dKCFSdAJ+lv7Ji7zysfJtwScFy5P1idI=
X-Received: by 2002:a19:7d84:: with SMTP id y126mr5515292lfc.586.1607727957931;
 Fri, 11 Dec 2020 15:05:57 -0800 (PST)
MIME-Version: 1.0
References: <20201211094138.2863677-1-nobuhiro1.iwamatsu@toshiba.co.jp> <20201211094138.2863677-2-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20201211094138.2863677-2-nobuhiro1.iwamatsu@toshiba.co.jp>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Dec 2020 00:05:47 +0100
Message-ID: <CACRpkdbsELwWeXe1jM1PpBtgo5oiKOx7MwVA06uS1-ZvaLKnRQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: gpio: Add bindings for Toshiba
 Visconti GPIO Controller
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Marc Zyngier <maz@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        yuji2.ishikawa@toshiba.co.jp,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looping in Marc here:

On Fri, Dec 11, 2020 at 1:43 AM Nobuhiro Iwamatsu
<nobuhiro1.iwamatsu@toshiba.co.jp> wrote:

> Add bindings for the Toshiba Visconti GPIO Controller.
>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
(...)
> +          interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
> +              <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
> +              <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
> +              <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
> +              <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
> +              <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
> +              <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
> +              <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
> +              <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
> +              <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
> +              <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
> +              <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
> +              <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
> +              <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
> +              <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
> +              <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;

This is an hierarchical IRQ controller. (These IRQs are mapped 1-to-1
to IRQ lines.)
I was under the impression that we don't encode interrupts into the GPIO
controller like this when we have that.

Instead, hardcode these into the driver. The compatible string gives
away how the
local offsets map to the GIC IRQs.

Add no interrupts to the node but make sure that the GIC is the parent.
(Should be default.)

Compare e.g.
Documentation/devicetree/bindings/gpio/intel,ixp4xx-gpio.txt

Which has a similar "some hierarchical IRQs" setup.

Yours,
Linus Walleij

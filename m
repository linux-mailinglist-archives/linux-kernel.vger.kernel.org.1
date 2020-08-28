Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CDA255CE9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 16:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgH1Ope (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 10:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgH1Opc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:45:32 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329EFC061232
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:45:31 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id j15so847253lfg.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vp97yrSpR+OTzyZcNc9C0oseKakFgiDLfmVqjpmNJf8=;
        b=zX1fH0mQLlsOsTkogRPuQVazxLuvENgLGP+kJnv3g7XwwBkQ9LwPr6KCqTPSyamL3z
         U+ae7wn4s7H9Vzjo3mh56JDMvY1fDhnXioztSrabgO8Z9W3tkgxjYtb0swHQNeqRQ6hq
         DPiTqMgLwChxwCwItaY/EVXAD4nMXqzMVU8urFXOlw3E2lHCRx1YPFJerTVC7FWVctIJ
         ZzHutDEnHuGvz2Cs/uV0b89yvMUSuHuGPt9EBQtCfjqb0bblSGtZba5BM1UkTVxYbBNY
         DkAlccyj3nqVIMBdNZmven7zz1wB3TouEjPDLPOoe9e1qnWbZ5HefJ5G3eH8alDRvByi
         rH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vp97yrSpR+OTzyZcNc9C0oseKakFgiDLfmVqjpmNJf8=;
        b=SUVr7GxjkJNZefizjCx9RlIBWnyl6q7AqBj6hk7RaRgx8TfOhQR9kZDd4sis39R6h/
         e0kFNtuTW6g1qidHDu/I3yRND8XK13+IiWGpe995eR4xIn7UWMc4smSX0imcBYDq7e5s
         O8+UhmWK0MhjkvFOLCNNBt+iqudUXLa5BdwuUDLPb2c01GDkzIsTF7mgV5Nn3584iDQt
         FtNCRKwwAQe3zuOwORbAB8IEpL5irFsnMV5lVYXVQvXPjHqH6JLvO7PLSv5et6H23wiP
         7CNl9xvej/jnF3hr1SgzZj1O8UZXBbA/leQb8G3ou8MA13I+V6DF73H0Hq67B45JSVyb
         L9Wg==
X-Gm-Message-State: AOAM530/4/ZXC2+R6Wc8BVdJufu984OBR5G/3k8HcV53PYksDnt3lL0Q
        i7o/tnJjo2FcnL1mjIWvgdlDb/KkNKLuLxIfZ8PR3w==
X-Google-Smtp-Source: ABdhPJx+CL6vs2cc7cG2OqOnis0aSEP4pn2vlz9pcsjIjwaB64AYzwUnTUOBlVOHMmWmYhWcLF5+RGBhHe1v7dy2JVo=
X-Received: by 2002:ac2:4c05:: with SMTP id t5mr977971lfq.89.1598625930235;
 Fri, 28 Aug 2020 07:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200828130602.42203-1-andre.przywara@arm.com> <20200828130602.42203-8-andre.przywara@arm.com>
In-Reply-To: <20200828130602.42203-8-andre.przywara@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 16:45:19 +0200
Message-ID: <CACRpkdZ5er1MBiyYBNBG=7CfDyWv83GJtEURyBKbOHxSNP_GBA@mail.gmail.com>
Subject: Re: [PATCH 07/10] ARM: dts: arm: Fix SP805 clocks
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Viresh Kumar <vireshk@kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 3:06 PM Andre Przywara <andre.przywara@arm.com> wrote:

> The SP805 binding sets the name for the actual watchdog clock to
> "wdog_clk" (with an underscore).
>
> Change the name in the DTs for ARM Ltd. platforms to match that. The
> Linux and U-Boot driver use the *first* clock for this purpose anyway,
> so it does not break anything.
>
> For MPS2 we only specify one clock so far, but the binding requires
> two clocks to be named.
>
> In practice, Linux would pick a clock named "apb_pclk" for the bus
> clock, and the Linux and U-Boot SP805 driver would use the first clock
> to derive the actual watchdog counter frequency. So since currently both
> are the very same clock, we can just double the clock reference, and add
> the correct clock-names, to match the binding.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

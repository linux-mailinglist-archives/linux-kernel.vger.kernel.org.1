Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF7F2E8CEB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 16:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbhACPgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 10:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbhACPgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 10:36:05 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEBCC061573
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 07:35:24 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id i24so24641400edj.8
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 07:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M8EUldjyvk2v6GO3easV/bDTItJ4f4U6mdfimtYJN0A=;
        b=q2bVdZYxjyewijLVutaGwahEKegFtWwpymOP0F5g/i8xSQ0JiaL/ZF4wv+B/pS11uK
         HvLyXrsT2pry1T6a6JH+hDV3gLfwy7Nis7v9HuqtANuRfi9xoygFJN7OQgh/OH+fL3sz
         tL793KWxUj3my5HtSRDrhGBwwf/mS3kT3PRathvluF0LZBaLnWujU8qEbPJTibHYzsXP
         G2YO3mbzAWLnFyK0sf648uvhmD08m3CRgrDOWuXVWe3EpSnt+pjVtQRB+8ZwRfPYO8Hq
         PTCJ3xO0TaZANWPpKuX6tFsfYMKwm3uV9B4Rlkl71ujSFgy+/7mfN+ksoefrKbRJS0lu
         B1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8EUldjyvk2v6GO3easV/bDTItJ4f4U6mdfimtYJN0A=;
        b=sLhjt+rWvgKBLCPnliZb8NkJ05TSvHSCTtxeHG+B4AFihZUzNCDz9jGg13iksAqRiX
         jsh8m4TfEkUum8qVau6XizOvRJ+hgWI/R0+/6rEpAlhfxXh158GBdToEWZAql3g8cEpq
         qKQQZlthIyGp1nBbDOBdXTK4Ht8nN1Gu1FColukUDdbYw+mVsM863hHJAgqBNjV8NLoy
         CTSKyYrsXXcpe70SCSC9g3YUmaZDOrI0VX/cZv1snc1mpemGBOmX+OQaO+vxuvwGNgth
         Mp/yAgkZT7wC1wGVjDUMCCIrWuOBFWsBvMFbdR3cwuEtCS74TuA5ge14xKKenJXuDNgg
         fhbg==
X-Gm-Message-State: AOAM530cREMxcxBTuCSgDTx1aT/IR5FR+2NT7/mRXbDSQSjuMq6OuH8V
        uZ+BWOjoBlT82Qe53tTHTAzAopfWPqq9hRY0JdtvOw==
X-Google-Smtp-Source: ABdhPJzb4qlEP8bfOaM0fyTZxQzF/OvPUzBT2H3LyWrVjHiIFgsjX7PH+TJnpC5tCIRreernulsyYuhCUhVSMQ75rDg=
X-Received: by 2002:a05:6402:14c5:: with SMTP id f5mr66332936edx.232.1609688123457;
 Sun, 03 Jan 2021 07:35:23 -0800 (PST)
MIME-Version: 1.0
References: <1608888807-3117-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1608888807-3117-7-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1608888807-3117-7-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Sun, 3 Jan 2021 16:35:12 +0100
Message-ID: <CAMpxmJWsipPumbROrfas+Ldwh47wnZxORUWr0RjY-=0-B2pELA@mail.gmail.com>
Subject: Re: [PATCH v8 06/12] gpio: bd9571mwv: Use the SPDX license identifier
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     marek.vasut+renesas@gmail.com, Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        khiem.nguyen.xt@renesas.com, linux-power@fi.rohmeurope.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 25, 2020 at 10:33 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
> Use the SPDX license identifier instead of a local description.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/gpio/gpio-bd9571mwv.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/gpio/gpio-bd9571mwv.c b/drivers/gpio/gpio-bd9571mwv.c
> index c0abc9c..abb622c 100644
> --- a/drivers/gpio/gpio-bd9571mwv.c
> +++ b/drivers/gpio/gpio-bd9571mwv.c
> @@ -1,17 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * ROHM BD9571MWV-M GPIO driver
>   *
>   * Copyright (C) 2017 Marek Vasut <marek.vasut+renesas@gmail.com>
>   *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> - * kind, whether expressed or implied; without even the implied warranty
> - * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License version 2 for more details.
> - *
>   * Based on the TPS65086 driver
>   *
>   * NOTE: Interrupts are not supported yet.
> --
> 2.7.4
>

Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

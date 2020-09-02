Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF3325A847
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 11:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgIBJE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 05:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgIBJDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:03:54 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4E7C061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 02:03:53 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id v20so1341416ual.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 02:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJzUeSF+5rfhIEqW5Y3fudwXDrc2+BNzuQkwiBNzFL4=;
        b=WQ+kQwXpmiMbmM++3SGStKdu8DfotRMOpqrwA5q4bHtdJy9QMoEuJc5j/DKPN9esfh
         TQnNtWcPdvtjlOGXk6lMbGAWO97Q/B3oTIbShRS2KU7mN9bF8pwNxjqtEEOpNgKeeSoF
         5vPV4E1GH8dyf6dZN4nLeM4NYT2aVDd9zvoKiIUgsLohC+8JbQ22SJbx9wnjSbkj7xL8
         JsM/O3Q//97AjUOmNmXAzlIbuCSjbi/qQVWHYr3mood8wfSt8Zo60+0PYH3nWBUC9yct
         FTmh/ZE20RiJD40hlQlzblmlJbQWUdiyrAwwuV/0mkrVPnqhO7ph2zS10dQORe/iAwGQ
         yyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJzUeSF+5rfhIEqW5Y3fudwXDrc2+BNzuQkwiBNzFL4=;
        b=F4AILCrBSYqLgWj/asO21z0WUzCpTKMOTQBOLKEW1tgVK+B9JSWia9Vz0xvIfHCiqi
         XAARtX9seO4ziZ5/kq0CFDhM7A1p6OAp1/l5ugwKHsuYsbPNEYV2D/cq7lh02DC1z6/L
         kAgktFaDIsrFwU4PYwnondh+M1tptFe0P0cXpSyyX4oYkxh5RIm5GydqMpbYRYIUdWyi
         U+ycFdP9aMjp7ZRM+B/bP2CehCJN994goXUXsuaYLPMmLr7xNe6Ro6FqockyGI5+iIid
         jSU4jJ1mhTAFfakXRN9B9aIpmv5kVwHk115l2nd0Fz2/xSgF0EPsoiYbXhHW6bnePBY/
         uMqw==
X-Gm-Message-State: AOAM5309p/Fzk6v7DXhfBqrupHnb0zUKuORAP9yAq61GwF80Dm6xzqbh
        Gr2r0mDIVnnnt0Fb4+LQtQd1FnHLl+XLNdcYKHvMZsbQi6RjiA==
X-Google-Smtp-Source: ABdhPJyhJYTVm/R+GBYtGPEgC6V5+EOBdX93qBkeA616egxMMvQgh3s57gjKKHh0bsOtxZckjPPEU7gVSF32drfco5E=
X-Received: by 2002:ab0:2848:: with SMTP id c8mr4291207uaq.15.1599037433179;
 Wed, 02 Sep 2020 02:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200831102324.12566-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20200831102324.12566-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Sep 2020 11:03:16 +0200
Message-ID: <CAPDyKFpmfjuGcLTxCDdCvp5j_yaJzySENBEcgC_w1tvkK1Gz4g@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: use wrapper to avoid accessing internal vars
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 at 12:23, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Only buildtested. Found while analyzing retune-handling in the core.
>
>  drivers/mmc/host/meson-gx-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 08a3b1c05acb..a1db8685e30e 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -521,7 +521,7 @@ static int meson_mmc_resampling_tuning(struct mmc_host *mmc, u32 opcode)
>         val |= ADJUST_ADJ_EN;
>         writel(val, host->regs + host->data->adjust);
>
> -       if (mmc->doing_retune)
> +       if (mmc_doing_retune(mmc))
>                 dly = FIELD_GET(ADJUST_ADJ_DELAY_MASK, val) + 1;
>         else
>                 dly = 0;
> --
> 2.20.1
>

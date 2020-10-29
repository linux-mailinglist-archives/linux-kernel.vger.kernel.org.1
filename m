Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FBD29F14D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgJ2QXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgJ2QXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:23:09 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D3DC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:23:09 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id z10so837530vkn.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TyGKT1Ssh4EGtVJkUsdYOSjFOp44Ii97uktL7500tnU=;
        b=EU4Fj/uDwgPJsmMvCgG3jCvCR3wXy0zZ48+qsRQWLekp4/DTtv/OJfsPylzaeEcSjO
         TlmSRLJqFyniC8qHahEAdQVlKABPDCZW8B/oEQABP3UT5uPSuET1QUAVi/OwVdAOkjsb
         DPkoL+2mCtkiN100JyynufBZ3yTxp5g8NIupA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TyGKT1Ssh4EGtVJkUsdYOSjFOp44Ii97uktL7500tnU=;
        b=TQYXY6wh05Z1uC6kdmENYgiYff6cfeb0RDik0KDK3oayapDN7xFt+R5lSEN9muEcAH
         SYkXO+kcqgl4U6Nd7omT5lprmzz9p/+K7QPR8HGY5Nzpg9BkVX6q1GSqX4QxkmqLZ+Sn
         CcYj4IDuJjO7tV37K6Me1va62TKqgzelhWF5q/cEJflmTgbHHfX0vEmg1sx16pyRG0xG
         CRnRocgt8lEc+9KSmFitaHUf3dC7LLdDXdX1Wc9Rhvijh+/LHwFJ3tuGa8Duytiv1V1A
         byY0anEaYd7wyjQJiPvb+S8VHfbp0cKo2NYU9mWvFSnLjZoOBnVZxBAlPOU+r0cKKyhv
         URqA==
X-Gm-Message-State: AOAM533qxkEyiGEN9Fg0AawkKR6DfsEgif5nT9OTGL53RgAPirktePio
        Ii7qTNqhaLDAyi4Y841iJtJs6ggFQl2epQ==
X-Google-Smtp-Source: ABdhPJyy9zQ9YWwT+YUuXT+WDnA8vJ8VD0V4IN6cSXwe8KIoPAxKKo9KxjV8Dv8Fu7hayCHmJvIbiA==
X-Received: by 2002:ac5:c885:: with SMTP id n5mr3862908vkl.21.1603988588393;
        Thu, 29 Oct 2020 09:23:08 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id b62sm397509vsb.7.2020.10.29.09.23.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 09:23:07 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id x26so875158uau.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:23:07 -0700 (PDT)
X-Received: by 2002:ab0:6cb0:: with SMTP id j16mr3481621uaa.64.1603988587026;
 Thu, 29 Oct 2020 09:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201029011154.1515687-1-swboyd@chromium.org> <20201029011154.1515687-5-swboyd@chromium.org>
In-Reply-To: <20201029011154.1515687-5-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Oct 2020 09:22:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U93bfZv_uLG0XFXtBBMrD7gg=L3ijnpPnOCgeeo=CqAg@mail.gmail.com>
Message-ID: <CAD=FV=U93bfZv_uLG0XFXtBBMrD7gg=L3ijnpPnOCgeeo=CqAg@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/bridge: ti-sn65dsi86: Update reply on aux failures
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sean Paul <seanpaul@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 28, 2020 at 6:12 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We should be setting the drm_dp_aux_msg::reply field if a NACK or a
> SHORT reply happens.

I don't think you update the "reply" field for SHORT, right?  You just
return a different size?


> Update the error bit handling logic in
> ti_sn_aux_transfer() to handle these cases and notify upper layers that
> such errors have happened. This helps the retry logic understand that a
> timeout has happened, or to shorten the read length if the panel isn't
> able to handle the longest read possible.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> Cc: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 31 +++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 6b6e98ca2881..19737bc01b8f 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -878,6 +878,7 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
>         case DP_AUX_NATIVE_READ:
>         case DP_AUX_I2C_READ:
>                 regmap_write(pdata->regmap, SN_AUX_CMD_REG, request_val);
> +               msg->reply = 0; /* Assume it's good */
>                 break;
>         default:
>                 return -EINVAL;
> @@ -909,10 +910,32 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
>         ret = regmap_read(pdata->regmap, SN_AUX_CMD_STATUS_REG, &val);
>         if (ret)
>                 return ret;
> -       else if ((val & AUX_IRQ_STATUS_NAT_I2C_FAIL)
> -                || (val & AUX_IRQ_STATUS_AUX_RPLY_TOUT)
> -                || (val & AUX_IRQ_STATUS_AUX_SHORT))
> -               return -ENXIO;
> +
> +       if (val & AUX_IRQ_STATUS_AUX_RPLY_TOUT) {
> +               /*
> +                * The hardware tried the message seven times per the DP spec
> +                * but it hit a timeout. We ignore defers here because they're
> +                * handled in hardware.
> +                */
> +               return -ETIMEDOUT;
> +       }
> +       if (val & AUX_IRQ_STATUS_AUX_SHORT) {
> +               ret = regmap_read(pdata->regmap, SN_AUX_LENGTH_REG, &len);
> +               if (ret)
> +                       return ret;

IIUC, your digging through the code showed that in order to fully
handle the "SHORT" case you also needed to add support for
"DP_AUX_I2C_WRITE_STATUS_UPDATE", right?

Even without handling "DP_AUX_I2C_WRITE_STATUS_UPDATE" though, this
patch seems to be an improvement and I'd support landing it.

Oh, I guess one other thing: I think this is all from code inspection,
right?  You didn't manage to reproduce anything that would tickle one
of these code paths?  Might be worth mentioning, even if "after the
cut"?

-Doug

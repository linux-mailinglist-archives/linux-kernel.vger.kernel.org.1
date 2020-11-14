Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311702B3002
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 20:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgKNTMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 14:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgKNTML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 14:12:11 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DCFC0613D1;
        Sat, 14 Nov 2020 11:12:11 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id f20so18666040ejz.4;
        Sat, 14 Nov 2020 11:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u5WJiirRKNDUV5O3yKO2RQW3GzVNyUWzALcJgmi9qD8=;
        b=FSu31JSKLbwJZm8SKdIl9tHJVYSdoso0nbNX1WyZSqU7bJ+f3/mhAJKWP98OxztFvq
         GpqqwY1QxIJK9hRA4qjpD6KncuahjDOHrbayfw9KPlE/heg7r1R0rfDAJTbIAQJNuDr9
         IkJpuOQ2tuj/r96z41WusH70BMbCVlaD5vYOlEq3JiUbLmXUbNaOk2uJ8Xyka56OpZz3
         TEcOnoZkXQGGRi1idfvtDrP0MeDZR1wA40ED1SpzLXak4V5sPvxsBG7RJ5PDXD4JcD00
         dhRUSf3jZI7yX4WlK1PEEq6k83ONo5c19SPdweZAaQFGS8s0k7AW9ApQg34JKmOigg5w
         7NWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u5WJiirRKNDUV5O3yKO2RQW3GzVNyUWzALcJgmi9qD8=;
        b=cC1uwZXIxZoQsSN/8mCvM4nY29Z+XG7QqGGwnpkPRC/R2MFPOcubuc4aUcZzkO/TL7
         MCu49sZIXrMYjv0keNGzbi4YJW+yV2PlFI/JwCA2899r+qkDLFkspYKgp9Hj9AD+WWXn
         /rfJG9tP8UtuzPkvmD+MPAq+weXJHs7PFv40DzNj7svjJGxQp++klVXZBuo/qpXlINkK
         BMoAcYc9Otd1VlSlFZpgqcLCcFbYnz9bp6oUaNksAUseID8b1awAzB8OuLQfLcNyeumc
         32TVdVmdCKVE1YfYqjjTyfq8XYTyGEQN7jGYRtTlVL22hYe08lUUeW4gAxzgu+Gdge0t
         aqNw==
X-Gm-Message-State: AOAM531A7RSKLRLJxtTyC+gSQ+HTHKbPiN1B59zMkSlbdob9hvtHoLxG
        wAMUoC3HLj57jnoThE1VTNVag3vHQM/dOpXuxbw=
X-Google-Smtp-Source: ABdhPJzdMCUsv64szJ8LAp46qliACxg7P6fS8+B9EpwGZnNi0pnsgtbqLjudhNZQ7G9Q6urZlSQdUGypFLEZRpTpiTA=
X-Received: by 2002:a17:906:fa1b:: with SMTP id lo27mr7560682ejb.216.1605381129975;
 Sat, 14 Nov 2020 11:12:09 -0800 (PST)
MIME-Version: 1.0
References: <20201113000508.14702-1-aouledameur@baylibre.com> <20201113000508.14702-4-aouledameur@baylibre.com>
In-Reply-To: <20201113000508.14702-4-aouledameur@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 14 Nov 2020 20:11:59 +0100
Message-ID: <CAFBinCA6_Cei5QdiVRTX14S5QFoyDgAOhFUXtnx5uiAxuTRs9A@mail.gmail.com>
Subject: Re: [PATCH 3/3] phy: amlogic: meson8b-usb2: fix shared reset control use
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-amlogic@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amjad,

On Fri, Nov 13, 2020 at 1:07 AM Amjad Ouled-Ameur
<aouledameur@baylibre.com> wrote:
[...]
>         ret = clk_prepare_enable(priv->clk_usb);
>         if (ret) {
>                 dev_err(&phy->dev, "Failed to enable USB DDR clock\n");
> +               reset_control_rearm(priv->reset);
this should come after reset_control_rearm so we're cleaning up in
reverse order of initializing things
(in this case it probably makes no difference since
reset_control_rearm is not touching any registers, but I'd still have
it in the correct order to not confuse future developers)

>                 clk_disable_unprepare(priv->clk_usb_general);
>                 return ret;
>         }
> @@ -197,6 +199,7 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
>                         regmap_read(priv->regmap, REG_ADP_BC, &reg);
>                         if (reg & REG_ADP_BC_ACA_PIN_FLOAT) {
>                                 dev_warn(&phy->dev, "USB ID detect failed!\n");
> +                               reset_control_rearm(priv->reset);
same here, reset_control_rearm should be after clk_disable_unprepare

>                                 clk_disable_unprepare(priv->clk_usb);
>                                 clk_disable_unprepare(priv->clk_usb_general);
>                                 return -EINVAL;
> @@ -216,6 +219,7 @@ static int phy_meson8b_usb2_power_off(struct phy *phy)
>                                    REG_DBG_UART_SET_IDDQ,
>                                    REG_DBG_UART_SET_IDDQ);
>
> +       reset_control_rearm(priv->reset);
same here, reset_control_rearm should be after clk_disable_unprepare

>         clk_disable_unprepare(priv->clk_usb);
>         clk_disable_unprepare(priv->clk_usb_general);


Best regards,
Martin

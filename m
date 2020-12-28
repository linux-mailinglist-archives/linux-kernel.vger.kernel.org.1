Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2D42E33AA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 03:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgL1ChD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 27 Dec 2020 21:37:03 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:43028 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgL1ChD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 21:37:03 -0500
Received: by mail-lf1-f47.google.com with SMTP id 23so20923364lfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 18:36:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bSCVvBlwmwcUE+SiT7sYckVTnr8vEoE99rSzsLZGaHA=;
        b=gGoKee2rGDawW3TzShJKmmhpm2teQ7y9O5Hfse+GSnRgNbCWp7wb3zBqbNdSzHWCzu
         2XGPl69Mj6ar5AXTvzgxqCT0XylAWZYTiLATYzrID7Z6wcvyzYHUlfZtwEewkx5J0zBU
         Fdqydq8e4QioWWaZ0t3cP8+znXlC1lYFxaC8ZVGmBAIhW03QtkMXtbL+3i6PVIi/5gWm
         8xM1SwVBeKX98BLjZMW481R1LRhqq4LG4b1OLX/74gXsrrWznQmQh2+G1UJUIEgwBtIK
         I6/qhEPYqCMHFM6N7crXU1vtOsKGcT7tOLR/81LS3I5I4TjLCaBVnF0kfPUsgYNsDmSw
         H0eg==
X-Gm-Message-State: AOAM533EfHU4kRSgh/9BIM8eGjU4+DZY22tea8KGvDmYwBxXLiUfnBjt
        upgc/9xgpjjFIITeyIGdXcISAEuWQAWXew==
X-Google-Smtp-Source: ABdhPJzS8jSBaEk/JePTfQ7VKwDjuEmsAfOPqZ1uk8t44mc+jJS7XlbBQ+SCDl3DT00/GvFTRaeOxw==
X-Received: by 2002:a05:651c:489:: with SMTP id s9mr20028898ljc.188.1609122980567;
        Sun, 27 Dec 2020 18:36:20 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id t30sm5152219lft.266.2020.12.27.18.36.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Dec 2020 18:36:20 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id h22so21047082lfu.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 18:36:20 -0800 (PST)
X-Received: by 2002:a19:8041:: with SMTP id b62mr17740302lfd.496.1609122979962;
 Sun, 27 Dec 2020 18:36:19 -0800 (PST)
MIME-Version: 1.0
References: <20201227200000.28526-1-clabbe@baylibre.com> <25142918.GuFC1uy7vR@jernej-laptop>
In-Reply-To: <25142918.GuFC1uy7vR@jernej-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 28 Dec 2020 10:36:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v67nG1tCG7dUb3CVtQkOiWHQ9KdavCGSEihX_=nRF6wMaA@mail.gmail.com>
Message-ID: <CAGb2v67nG1tCG7dUb3CVtQkOiWHQ9KdavCGSEihX_=nRF6wMaA@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH RESEND] ARM: configs: sunxi: enable brcm wireless
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 4:03 AM Jernej Škrabec <jernej.skrabec@siol.net> wrote:
>
> Hi!
>
> Dne nedelja, 27. december 2020 ob 21:00:00 CET je Corentin Labbe napisal(a):
> > Lot of sunxi boards have BRCM wireless device, so let's enable necessary
> > options for it in our defconfig.
>
> Idea is good but modules (=m) instead of build in (=y) would be better. As you
> said, not all boards have such wifi and there is no need to make kernel binary
> bigger.

It's probably not very useful on its own if built in, since it also needs
firmware blobs, and when built in it doesn't wait for the rootfs to be
available.

ChenYu

> Best regards,
> Jernej
>
> >
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  arch/arm/configs/sunxi_defconfig | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/configs/sunxi_defconfig
> > b/arch/arm/configs/sunxi_defconfig index a60c134c5e04..4891aefdef7d 100644
> > --- a/arch/arm/configs/sunxi_defconfig
> > +++ b/arch/arm/configs/sunxi_defconfig
> > @@ -52,7 +52,28 @@ CONFIG_STMMAC_ETH=y
> >  # CONFIG_NET_VENDOR_WIZNET is not set
> >  CONFIG_MICREL_PHY=y
> >  CONFIG_REALTEK_PHY=y
> > -# CONFIG_WLAN is not set
> > +CONFIG_WLAN=y
> > +# CONFIG_WLAN_VENDOR_ADMTEK is not set
> > +# CONFIG_WLAN_VENDOR_ATH is not set
> > +# CONFIG_WLAN_VENDOR_ATMEL is not set
> > +CONFIG_WLAN_VENDOR_BROADCOM=y
> > +# CONFIG_WLAN_VENDOR_CISCO is not set
> > +# CONFIG_WLAN_VENDOR_INTEL is not set
> > +# CONFIG_WLAN_VENDOR_INTERSIL is not set
> > +# CONFIG_WLAN_VENDOR_MARVELL is not set
> > +# CONFIG_WLAN_VENDOR_MEDIATEK is not set
> > +# CONFIG_WLAN_VENDOR_MICROCHIP is not set
> > +# CONFIG_WLAN_VENDOR_RALINK is not set
> > +# CONFIG_WLAN_VENDOR_REALTEK is not set
> > +# CONFIG_WLAN_VENDOR_RSI is not set
> > +# CONFIG_WLAN_VENDOR_ST is not set
> > +# CONFIG_WLAN_VENDOR_TI is not set
> > +# CONFIG_WLAN_VENDOR_ZYDAS is not set
> > +# CONFIG_WLAN_VENDOR_QUANTENNA is not set
> > +CONFIG_CFG80211=y
> > +CONFIG_CFG80211_WEXT=y
> > +CONFIG_MAC80211=y
> > +CONFIG_BRCMFMAC=y
> >  CONFIG_INPUT_EVDEV=y
> >  CONFIG_KEYBOARD_SUN4I_LRADC=y
> >  # CONFIG_INPUT_MOUSE is not set
>
>
>
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/25142918.GuFC1uy7vR%40jernej-laptop.

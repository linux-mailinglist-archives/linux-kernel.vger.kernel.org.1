Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC182E32A9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 21:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgL0UEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 15:04:09 -0500
Received: from mailoutvs17.siol.net ([185.57.226.208]:53065 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726247AbgL0UEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 15:04:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id C9636520B40;
        Sun, 27 Dec 2020 21:03:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DmIu3-HX0VqP; Sun, 27 Dec 2020 21:03:25 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 804825212B4;
        Sun, 27 Dec 2020 21:03:25 +0100 (CET)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 00382520B40;
        Sun, 27 Dec 2020 21:03:23 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     linux@armlinux.org.uk, mripard@kernel.org, wens@csie.org,
        Corentin Labbe <clabbe@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH RESEND] ARM: configs: sunxi: enable brcm wireless
Date:   Sun, 27 Dec 2020 21:03:23 +0100
Message-ID: <25142918.GuFC1uy7vR@jernej-laptop>
In-Reply-To: <20201227200000.28526-1-clabbe@baylibre.com>
References: <20201227200000.28526-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne nedelja, 27. december 2020 ob 21:00:00 CET je Corentin Labbe napisal(a):
> Lot of sunxi boards have BRCM wireless device, so let's enable necessary
> options for it in our defconfig.

Idea is good but modules (=m) instead of build in (=y) would be better. As you 
said, not all boards have such wifi and there is no need to make kernel binary 
bigger.

Best regards,
Jernej

> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  arch/arm/configs/sunxi_defconfig | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/sunxi_defconfig
> b/arch/arm/configs/sunxi_defconfig index a60c134c5e04..4891aefdef7d 100644
> --- a/arch/arm/configs/sunxi_defconfig
> +++ b/arch/arm/configs/sunxi_defconfig
> @@ -52,7 +52,28 @@ CONFIG_STMMAC_ETH=y
>  # CONFIG_NET_VENDOR_WIZNET is not set
>  CONFIG_MICREL_PHY=y
>  CONFIG_REALTEK_PHY=y
> -# CONFIG_WLAN is not set
> +CONFIG_WLAN=y
> +# CONFIG_WLAN_VENDOR_ADMTEK is not set
> +# CONFIG_WLAN_VENDOR_ATH is not set
> +# CONFIG_WLAN_VENDOR_ATMEL is not set
> +CONFIG_WLAN_VENDOR_BROADCOM=y
> +# CONFIG_WLAN_VENDOR_CISCO is not set
> +# CONFIG_WLAN_VENDOR_INTEL is not set
> +# CONFIG_WLAN_VENDOR_INTERSIL is not set
> +# CONFIG_WLAN_VENDOR_MARVELL is not set
> +# CONFIG_WLAN_VENDOR_MEDIATEK is not set
> +# CONFIG_WLAN_VENDOR_MICROCHIP is not set
> +# CONFIG_WLAN_VENDOR_RALINK is not set
> +# CONFIG_WLAN_VENDOR_REALTEK is not set
> +# CONFIG_WLAN_VENDOR_RSI is not set
> +# CONFIG_WLAN_VENDOR_ST is not set
> +# CONFIG_WLAN_VENDOR_TI is not set
> +# CONFIG_WLAN_VENDOR_ZYDAS is not set
> +# CONFIG_WLAN_VENDOR_QUANTENNA is not set
> +CONFIG_CFG80211=y
> +CONFIG_CFG80211_WEXT=y
> +CONFIG_MAC80211=y
> +CONFIG_BRCMFMAC=y
>  CONFIG_INPUT_EVDEV=y
>  CONFIG_KEYBOARD_SUN4I_LRADC=y
>  # CONFIG_INPUT_MOUSE is not set





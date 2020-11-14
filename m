Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6780E2B2BE3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 08:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgKNHDs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 14 Nov 2020 02:03:48 -0500
Received: from mailoutvs35.siol.net ([185.57.226.226]:34057 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726380AbgKNHDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 02:03:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 41EFB521477;
        Sat, 14 Nov 2020 08:03:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id n-aETWd7PJg2; Sat, 14 Nov 2020 08:03:45 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id EFE7B521479;
        Sat, 14 Nov 2020 08:03:44 +0100 (CET)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id CC7B4521477;
        Sat, 14 Nov 2020 08:03:43 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org,
        Corentin Labbe <clabbe@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH] ARM: configs: sunxi: enable Realtek PHY
Date:   Sat, 14 Nov 2020 08:03:43 +0100
Message-ID: <3172346.gfnfIrP1Mj@jernej-laptop>
In-Reply-To: <20201112202652.27676-1-clabbe@baylibre.com>
References: <20201112202652.27676-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne četrtek, 12. november 2020 ob 21:26:52 CET je Corentin Labbe napisal(a):
> Lot of sunxi boards has a Realtek PHY, so let's enable it.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  arch/arm/configs/sunxi_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/sunxi_defconfig
> b/arch/arm/configs/sunxi_defconfig index 244126172fd6..05f7f4ed8ded 100644
> --- a/arch/arm/configs/sunxi_defconfig
> +++ b/arch/arm/configs/sunxi_defconfig
> @@ -51,6 +51,7 @@ CONFIG_STMMAC_ETH=y
>  # CONFIG_NET_VENDOR_VIA is not set
>  # CONFIG_NET_VENDOR_WIZNET is not set
>  CONFIG_MICREL_PHY=y
> +CONFIG_REALTEK_PHY=y
>  # CONFIG_WLAN is not set
>  CONFIG_INPUT_EVDEV=y
>  CONFIG_KEYBOARD_SUN4I_LRADC=y

Acked-by: Jernej Skrabec <jernej.skrabec@siol.net>

Thanks!

Best regards,
Jernej



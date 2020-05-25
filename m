Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9821E1133
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 17:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404074AbgEYPBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 11:01:53 -0400
Received: from gloria.sntech.de ([185.11.138.130]:54204 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404013AbgEYPBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 11:01:53 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jdEbk-0000T3-Rx; Mon, 25 May 2020 17:01:40 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v2 2/2] phy: Remove CONFIG_ARCH_* check for related subdir in Makefile
Date:   Mon, 25 May 2020 17:01:38 +0200
Message-ID: <10793802.6Woqi72AOj@diego>
In-Reply-To: <1590412138-13903-2-git-send-email-yangtiezhu@loongson.cn>
References: <1590412138-13903-1-git-send-email-yangtiezhu@loongson.cn> <1590412138-13903-2-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 25. Mai 2020, 15:08:58 CEST schrieb Tiezhu Yang:
> If CONFIG_ARCH_ROCKCHIP is not set but COMPILE_TEST is set, the file in
> the subdir rockchip can not be built due to CONFIG_ARCH_ROCKCHIP check
> in drivers/phy/Makefile.
> 
> Since the related configs in drivers/phy/rockchip/Kconfig depend on
> ARCH_ROCKCHIP, so remove CONFIG_ARCH_ROCKCHIP check for subdir rockchip
> in drivers/phy/Makefile.
> 
> The other CONFIG_ARCH_* about allwinner, amlogic, mediatek, renesas and
> tegra have the same situation, so remove them too.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

I did check the other vendor directories and all options there do
seem to depend on some ARCH_foo || COMPILE_TEST variant, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Heiko

> ---
> 
> v2:
>   - Remove all the CONFIG_ARCH_* check for related subdir in Makefile
>   - Modify the patch subject and update commit message
> 
>  drivers/phy/Makefile | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 310c149..16e2622 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -8,24 +8,24 @@ obj-$(CONFIG_GENERIC_PHY_MIPI_DPHY)	+= phy-core-mipi-dphy.o
>  obj-$(CONFIG_PHY_LPC18XX_USB_OTG)	+= phy-lpc18xx-usb-otg.o
>  obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
>  obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
> -obj-$(CONFIG_ARCH_SUNXI)		+= allwinner/
> -obj-$(CONFIG_ARCH_MESON)		+= amlogic/
> -obj-$(CONFIG_ARCH_MEDIATEK)		+= mediatek/
> -obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
> -obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
> -obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
> -obj-y					+= broadcom/	\
> +obj-y					+= allwinner/	\
> +					   amlogic/	\
> +					   broadcom/	\
>  					   cadence/	\
>  					   freescale/	\
>  					   hisilicon/	\
>  					   intel/	\
>  					   lantiq/	\
>  					   marvell/	\
> +					   mediatek/	\
>  					   motorola/	\
>  					   mscc/	\
>  					   qualcomm/	\
>  					   ralink/	\
> +					   renesas/	\
> +					   rockchip/	\
>  					   samsung/	\
>  					   socionext/	\
>  					   st/		\
> +					   tegra/	\
>  					   ti/
> 





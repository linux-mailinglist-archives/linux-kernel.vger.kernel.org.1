Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1FF2C242E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732750AbgKXLbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:31:05 -0500
Received: from gloria.sntech.de ([185.11.138.130]:38674 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgKXLbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:31:03 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1khWWm-0007V8-Iu; Tue, 24 Nov 2020 12:30:32 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH] phy/rockchip: Make PHY_ROCKCHIP_INNO_HDMI depend on HAS_IOMEM to fix build error
Date:   Tue, 24 Nov 2020 12:30:31 +0100
Message-ID: <2217294.nRIGxfEAI8@diego>
In-Reply-To: <1606216287-14648-1-git-send-email-yangtiezhu@loongson.cn>
References: <1606216287-14648-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 24. November 2020, 12:11:27 CET schrieb Tiezhu Yang:
> devm_ioremap_resource() will be not built in lib/devres.c if
> CONFIG_HAS_IOMEM is not set, and then there exists a build
> error about undefined reference to "devm_ioremap_resource"
> in the file phy-rockchip-inno-hdmi.c under COMPILE_TEST and
> CONFIG_PHY_ROCKCHIP_INNO_HDMI, make PHY_ROCKCHIP_INNO_HDMI
> depend on HAS_IOMEM to fix it.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/phy/rockchip/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
> index c2f22f9..159285f 100644
> --- a/drivers/phy/rockchip/Kconfig
> +++ b/drivers/phy/rockchip/Kconfig
> @@ -32,6 +32,7 @@ config PHY_ROCKCHIP_INNO_HDMI
>  	tristate "Rockchip INNO HDMI PHY Driver"
>  	depends on (ARCH_ROCKCHIP || COMPILE_TEST) && OF
>  	depends on COMMON_CLK
> +	depends on HAS_IOMEM
>  	select GENERIC_PHY
>  	help
>  	  Enable this to support the Rockchip Innosilicon HDMI PHY.
> 





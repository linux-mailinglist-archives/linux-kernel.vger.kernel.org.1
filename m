Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B601E0C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 12:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389883AbgEYKsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 06:48:38 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52778 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389484AbgEYKsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:48:37 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jdAem-0007hV-QC; Mon, 25 May 2020 12:48:32 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH 2/2] phy: Remove CONFIG_ARCH_ROCKCHIP check for subdir rockchip
Date:   Mon, 25 May 2020 12:48:32 +0200
Message-ID: <2687194.6AVWON70EC@diego>
In-Reply-To: <1590379739-18729-2-git-send-email-yangtiezhu@loongson.cn>
References: <1590379739-18729-1-git-send-email-yangtiezhu@loongson.cn> <1590379739-18729-2-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 25. Mai 2020, 06:08:59 CEST schrieb Tiezhu Yang:
> If CONFIG_ARCH_ROCKCHIP is not set but COMPILE_TEST is set, the file in
> the subdir rockchip can not be built due to CONFIG_ARCH_ROCKCHIP check
> in drivers/phy/Makefile.
> 
> Since the related configs in drivers/phy/rockchip/Kconfig depend on
> ARCH_ROCKCHIP, so remove CONFIG_ARCH_ROCKCHIP check for subdir rockchip
> in drivers/phy/Makefile.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

wouldn't this make more sense to do for all subdirs?

- allwinner: also has arch_sunxi || compile_test in its Kconfig
- amlogic: same
- mediatek: same
- renesas: same
- tega: same

So I think the right way would be to drop all the obj-$(CONFIG_ARCH_...)
options and group the separate directories into the generic subdir
listing below them.

Heiko

> ---
>  drivers/phy/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 310c149..e5b4f58 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -12,7 +12,7 @@ obj-$(CONFIG_ARCH_SUNXI)		+= allwinner/
>  obj-$(CONFIG_ARCH_MESON)		+= amlogic/
>  obj-$(CONFIG_ARCH_MEDIATEK)		+= mediatek/
>  obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
> -obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
> +obj-y					+= rockchip/
>  obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
>  obj-y					+= broadcom/	\
>  					   cadence/	\
> 





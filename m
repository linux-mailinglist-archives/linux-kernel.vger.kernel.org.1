Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B286B2CFA58
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 08:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgLEHwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 02:52:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbgLEHwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 02:52:05 -0500
Date:   Sat, 5 Dec 2020 13:21:20 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607154684;
        bh=GaxbPS8fHhiN9RhDI+/JzYD1c9Bk3jACxukW0zQnLAw=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=WbuDEhmrQiUNLTuokjtEHchH+bbS08fFU34VdR4lmISk9BUScVFwZ1uwvDsA7uEmc
         a159kXqqFRqPbpucDTTwnSrZIzYlkfW5xAtmpz9XNX+k57a6bANTJ+uPXd1XkrehOZ
         k+HSXIzdIfWknZkTmk8H+/qf1tn2pEV+ssLJWxcE0HFjGyZHPeKeLjI1EgkLLLHZt5
         epz9qQQMi0EAnbMgHOUGdRUw0GF+hl0T5eG0p82arWprWySQDfZ5fL7lxl40FSlIVU
         lnKTO7cMsVZVY0RdxRgK8wFOda+C6XaUBfBttKgbxR5l180E3jkm63iMTCbXAz+R6P
         UdiYs3H359n5g==
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] phy: mediatek: allow compile-testing the hdmi phy
Message-ID: <20201205075120.GT8403@vkoul-mobl>
References: <20201204135650.2744481-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204135650.2744481-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-12-20, 14:56, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Compile-testing the DRM_MEDIATEK_HDMI driver shows two missing
> dependencies, one results in a link failure:
> 
> arm-linux-gnueabi-ld: drivers/phy/mediatek/phy-mtk-hdmi.o: in function `mtk_hdmi_phy_probe':
> phy-mtk-hdmi.c:(.text+0xd8): undefined reference to `__clk_get_name'
> arm-linux-gnueabi-ld: phy-mtk-hdmi.c:(.text+0x12c): undefined reference to `devm_clk_register'
> arm-linux-gnueabi-ld: phy-mtk-hdmi.c:(.text+0x250): undefined reference to `of_clk_add_provider'
> arm-linux-gnueabi-ld: phy-mtk-hdmi.c:(.text+0x298): undefined reference to `of_clk_src_simple_get'
> 
> The other one is a harmless warning:
> 
> WARNING: unmet direct dependencies detected for PHY_MTK_HDMI
>   Depends on [n]: ARCH_MEDIATEK [=n] && OF [=y]
>   Selected by [y]:
>   - DRM_MEDIATEK_HDMI [=y] && HAS_IOMEM [=y] && DRM_MEDIATEK [=y]
> 
> Fix these by adding dependencies on CONFIG_OF and CONFIG_COMMON_CLK.
> With that done, there is also no reason against adding
> CONFIG_COMPILE_TEST.

Applied, thanks

-- 
~Vinod

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268F42CEF0F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 14:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbgLDNyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 08:54:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729031AbgLDNyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 08:54:31 -0500
X-Gm-Message-State: AOAM533mqCH+4AqZaPavrzWxvTx4HLFVo7lpopWAc6b3MXSt5cQ/MbPw
        TQ5flk6rtiWWr8xuI8zwga++YrSQH3xHaK/Gxrk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607090030;
        bh=kAyij9+4RX0y0DZNsysqqpS1CMViaFGNvc5aF6KEUiQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fNBgfc8cplNLpBDM+NibHgduG0XDO8cs7v9dphCQ7WINUnYGSjM1eVnHfn3vUcwqp
         soJLV/DyUpPVzgQ73ov0qNLMrNgb9csscWZ8J0x7TUhSWs7ShxJwa/Iv18wagSshot
         DNJgdJLrS9QxdTj7mjtl9DruPxFIJOrdWhonVDyaq6Ak7PHc+bxJr2KBw/2yyWHhJt
         w02nx+87/T4ClDvQE9b1dyvFHedLX+rwZ8k+CICSsiJfQVf3JobbVERK0jjtQ1xvOK
         AXUUSuFPGuSgfJdq4Y+3JQNPGjuRieaEsVQNEsBjwXY+89cqoS/LGZv+yljyCoG1Bd
         ZQRvCvPjYXDPw==
X-Google-Smtp-Source: ABdhPJyEkwJM1qhY4HUoSSRjTOLYZ7XOJZyRjgIIVnOtMvJEUNP3hofxY3AfejJTYvYN3Qv/dNvHa5aCwDT6HzFYVE8=
X-Received: by 2002:a9d:6317:: with SMTP id q23mr3706573otk.251.1607090029623;
 Fri, 04 Dec 2020 05:53:49 -0800 (PST)
MIME-Version: 1.0
References: <20201203225418.1477560-1-arnd@kernel.org> <1607046425.7284.17.camel@mhfsdcap03>
In-Reply-To: <1607046425.7284.17.camel@mhfsdcap03>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 4 Dec 2020 14:53:33 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3tbXLD-0UBCkYX+s1AR=edbT085AcMmU8iPO1o-TMF=Q@mail.gmail.com>
Message-ID: <CAK8P3a3tbXLD-0UBCkYX+s1AR=edbT085AcMmU8iPO1o-TMF=Q@mail.gmail.com>
Subject: Re: [PATCH] phy: mediatek: allow compile-testing the hdmi phy
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        CK Hu <ck.hu@mediatek.com>, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 2:47 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:

> > diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
> > index 65ed26e40c9f..29a85b2738f8 100644
> > --- a/drivers/phy/mediatek/Kconfig
> > +++ b/drivers/phy/mediatek/Kconfig
> > @@ -40,7 +40,9 @@ config PHY_MTK_XSPHY
> >
> >  config PHY_MTK_HDMI
> >       tristate "MediaTek HDMI-PHY Driver"
> > -     depends on ARCH_MEDIATEK && OF
> > +     depends on ARCH_MEDIATEK || COMPILE_TEST
> > +     depends on COMMON_CLK
> Seems no need add COMMON_CLK here

My mistake, I had squashed two build fixes for the same driver but
forgot to update the changelog with the other output. This is what
happens without CONFIG_COMMON_CLK:

arm-linux-gnueabi-ld: drivers/phy/mediatek/phy-mtk-hdmi.o: in function
`mtk_hdmi_phy_probe':
phy-mtk-hdmi.c:(.text+0xd8): undefined reference to `__clk_get_name'
arm-linux-gnueabi-ld: phy-mtk-hdmi.c:(.text+0x12c): undefined
reference to `devm_clk_register'
arm-linux-gnueabi-ld: phy-mtk-hdmi.c:(.text+0x250): undefined
reference to `of_clk_add_provider'
arm-linux-gnueabi-ld: phy-mtk-hdmi.c:(.text+0x298): undefined
reference to `of_clk_src_simple_get'

I'll resend with that added in.

       Arnd

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF0B29DAAE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390595AbgJ1X2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390441AbgJ1X2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:28:33 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C71C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:28:33 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id x20so1225755ilj.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z2nv8ieGjS37fi1b03zMseQoHKsRO+D/JXqI8/WM/lg=;
        b=II7y2sOO4VBMYCA8hvox5v3rLsbjjK+ou6Wgnt6+3iHcpCSwOMEyDXIgGkXoT99fbl
         L4S+W94x43NMy8AhMMFEFxUbPf6VxLU6vVJ4V/dnEPIY3iyrqijWlNa6gtC6UsAt1F4y
         rFgaskObCDEblL5aTglXYq15v9S1R69bZWSOSlREpM6g8neG4WGYk3JPzGzs+EXjG/Gb
         NH/X3uC5QaXqb1bsS3s27HpvpOkfyfBCiHKYKJ4yi9AjOteWgzlPxAIFbRslJvXinP0O
         9U2uOEo/TpsTI4M/2a6VrRGYVOxx1TD4hfaW+zQ8N/MayGM7tDgmoUx/Zyrr5yoMShl5
         WkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z2nv8ieGjS37fi1b03zMseQoHKsRO+D/JXqI8/WM/lg=;
        b=U7u5CBfV9YEOKZQZukrJwgOqbyQyyWB0h3VeJ7a+jCrCeYTzLe6t4R4EGglR2wjNv7
         IDYHWLe6QAcFbM5TeO1D/nhPkJTt6wKwzjgY3jRvg+vOKXzfkqjdVcINyWzmTsZHecsn
         sCfCPLHDfZS4ccophB9AfmS42pcs46LZ3u38NMjn3Am8lJy7+LdgU7/wK7yMXOQv++bS
         oYYRoMNCwIsKDfK05/nFy0xI9I0z2wDI8A4u6XO+wLYqoFDDYBHsywcbTx0ZdpwkpJ2f
         XwjN1VpJm8X7ifplfsXr6PFJtCqQ7/5faRo3EvddXIaNeCFJySMsb6WBu9KuaW1M4MTk
         IWAQ==
X-Gm-Message-State: AOAM533Q58VpvyfQWPFvkk5BQGd0496zK/7lSCOIt6fCPaVqJy9Dkw93
        j0EcFqDjuQPJbfJEMjzr+zPqp7BlYiAdjlsgoHcuzMYOmKY=
X-Google-Smtp-Source: ABdhPJz9PfM0Rg/BH/F/zTz+sEmqFR7fWaO1laj/CwdbRYwjhOTCkMQkThF45nzYh2RLYxT9cR9T15lxpMj5YrhhpnU=
X-Received: by 2002:a92:d8cb:: with SMTP id l11mr5348907ilo.88.1603880868118;
 Wed, 28 Oct 2020 03:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <1603371365-30863-1-git-send-email-weiyi.lu@mediatek.com> <1603371365-30863-11-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1603371365-30863-11-git-send-email-weiyi.lu@mediatek.com>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Wed, 28 Oct 2020 11:27:36 +0100
Message-ID: <CAOwMV_xh0=D+sEDZM4AOqid6XtGCenyjdzm=Go77DBaiuwe1Lg@mail.gmail.com>
Subject: Re: [PATCH 10/12] clk: mediatek: Clean up the pll_en_bit from en_mask
 on MT8183
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weiyi,

The clock driver for MT8167 has been merged in v5.10-rc1. Can you also
apply the change to that driver.
Thank you

Fabien

On Fri, Oct 23, 2020 at 2:44 AM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> remove pll_en_bit(bit0) from en_mask to make en_mask a pure en_mask
> that only used for pll dividers.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mt8183.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
> index 5046852..608108c 100644
> --- a/drivers/clk/mediatek/clk-mt8183.c
> +++ b/drivers/clk/mediatek/clk-mt8183.c
> @@ -1121,34 +1121,34 @@
>  };
>
>  static const struct mtk_pll_data plls[] = {
> -       PLL_B(CLK_APMIXED_ARMPLL_LL, "armpll_ll", 0x0200, 0x020C, 0x00000001,
> +       PLL_B(CLK_APMIXED_ARMPLL_LL, "armpll_ll", 0x0200, 0x020C, 0,
>                 HAVE_RST_BAR | PLL_AO, BIT(24), 22, 8, 0x0204, 24, 0x0, 0x0, 0,
>                 0x0204, 0, 0, armpll_div_table),
> -       PLL_B(CLK_APMIXED_ARMPLL_L, "armpll_l", 0x0210, 0x021C, 0x00000001,
> +       PLL_B(CLK_APMIXED_ARMPLL_L, "armpll_l", 0x0210, 0x021C, 0,
>                 HAVE_RST_BAR | PLL_AO, BIT(24), 22, 8, 0x0214, 24, 0x0, 0x0, 0,
>                 0x0214, 0, 0, armpll_div_table),
> -       PLL(CLK_APMIXED_CCIPLL, "ccipll", 0x0290, 0x029C, 0x00000001,
> +       PLL(CLK_APMIXED_CCIPLL, "ccipll", 0x0290, 0x029C, 0,
>                 HAVE_RST_BAR | PLL_AO, BIT(24), 22, 8, 0x0294, 24, 0x0, 0x0, 0,
>                 0x0294, 0, 0),
> -       PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0220, 0x022C, 0x00000001,
> +       PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0220, 0x022C, 0,
>                 HAVE_RST_BAR, BIT(24), 22, 8, 0x0224, 24, 0x0, 0x0, 0,
>                 0x0224, 0, 0),
> -       PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x0230, 0x023C, 0x00000001,
> +       PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x0230, 0x023C, 0,
>                 HAVE_RST_BAR, BIT(24), 22, 8, 0x0234, 24, 0x0, 0x0, 0,
>                 0x0234, 0, 0),
> -       PLL_B(CLK_APMIXED_MFGPLL, "mfgpll", 0x0240, 0x024C, 0x00000001,
> +       PLL_B(CLK_APMIXED_MFGPLL, "mfgpll", 0x0240, 0x024C, 0,
>                 0, 0, 22, 8, 0x0244, 24, 0x0, 0x0, 0, 0x0244, 0, 0,
>                 mfgpll_div_table),
> -       PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0250, 0x025C, 0x00000001,
> +       PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0250, 0x025C, 0,
>                 0, 0, 22, 8, 0x0254, 24, 0x0, 0x0, 0, 0x0254, 0, 0),
> -       PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0260, 0x026C, 0x00000001,
> +       PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0260, 0x026C, 0,
>                 0, 0, 22, 8, 0x0264, 24, 0x0, 0x0, 0, 0x0264, 0, 0),
> -       PLL(CLK_APMIXED_MMPLL, "mmpll", 0x0270, 0x027C, 0x00000001,
> +       PLL(CLK_APMIXED_MMPLL, "mmpll", 0x0270, 0x027C, 0,
>                 HAVE_RST_BAR, BIT(23), 22, 8, 0x0274, 24, 0x0, 0x0, 0,
>                 0x0274, 0, 0),
> -       PLL(CLK_APMIXED_APLL1, "apll1", 0x02A0, 0x02B0, 0x00000001,
> +       PLL(CLK_APMIXED_APLL1, "apll1", 0x02A0, 0x02B0, 0,
>                 0, 0, 32, 8, 0x02A0, 1, 0x02A8, 0x0014, 0, 0x02A4, 0, 0x02A0),
> -       PLL(CLK_APMIXED_APLL2, "apll2", 0x02b4, 0x02c4, 0x00000001,
> +       PLL(CLK_APMIXED_APLL2, "apll2", 0x02b4, 0x02c4, 0,
>                 0, 0, 32, 8, 0x02B4, 1, 0x02BC, 0x0014, 1, 0x02B8, 0, 0x02B4),
>  };
>
> --
> 1.8.1.1.dirty
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69D22EBC89
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 11:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbhAFKiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 05:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbhAFKiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 05:38:50 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7842EC06134D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 02:38:10 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b8so1364782plx.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 02:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ykF1Rb3QiEQMUMU6PE5g0toJSaxdQKEkjuP56ge2Po=;
        b=BKCkklBaIPc8Lsq0qg//XXFPAcTBHLOMOq5fFdPi6701/UvxlXpzzg5360reHNpmsb
         WnYtluMJQYiVkLoyzpN8CdR+K8VPmDiPBoCCIQL5iTvg404KKXqetpnIhpQg1uiGMmni
         aEtifk6yMcrayomUtYiuPH0RQduWPK+XRxghg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ykF1Rb3QiEQMUMU6PE5g0toJSaxdQKEkjuP56ge2Po=;
        b=RB2WdbycDAAlnZMEpBqDHTl5c9C/fCWqRn3kzReiaMa1zn6w22sytfyYpewQEUWhdq
         Qgmca4zF7rEj6gny3hY5d+7a8acltUOUq3X55H+n8JHxDVJpLu7vYd90oVzBLaWfURpx
         nDOwVIQ824xQKq/5Q1cCgybvETIDPFJ42OVCCSlP9tYZ2mmkofsb6kpC/g7HDvOkDXr5
         uEwUZHNnIVOgOi23NABd0bsgoB7oQ4Wuqxx3+1vqjxkfU9ORXhtyvxvqv2dGJ57zI1A9
         c2BgPcaPhuyjZQwP4GGqhCPnizPbI9IaNh9IIrHhdEkjpn8mqfAB5NI+yQWKPR0u3yRH
         qbGQ==
X-Gm-Message-State: AOAM531jf7sUlyXIVR9vPh6dk+/bEilOz/TEn7AgidJ0qgtuZi3CHozm
        pm2kpc5SxRMiozo1d5XAk6Da2Cb4HdeBtcwpTGlS0w==
X-Google-Smtp-Source: ABdhPJybAwz8Y0ZUFyv2j/otm9dwuw+OQd5TePRL99+ggjPgKnM/2LxZPzg3tJMbkaOANmzDOWF7PLPWmi6k0KNWVtE=
X-Received: by 2002:a17:90a:902:: with SMTP id n2mr3678005pjn.126.1609929489894;
 Wed, 06 Jan 2021 02:38:09 -0800 (PST)
MIME-Version: 1.0
References: <1608642587-15634-1-git-send-email-weiyi.lu@mediatek.com> <1608642587-15634-9-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1608642587-15634-9-git-send-email-weiyi.lu@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Wed, 6 Jan 2021 18:37:59 +0800
Message-ID: <CAATdQgBvd_izVUZ7NiDeHzZsQ4rL0=3LZ04diO7HQXop5rxYsw@mail.gmail.com>
Subject: Re: [PATCH v6 08/22] clk: mediatek: Add configurable enable control
 to mtk_pll_data
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        open list <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 9:11 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> In all MediaTek PLL design, bit0 of CON0 register is always
> the enable bit.
> However, there's a special case of usbpll on MT8192.
> The enable bit of usbpll is moved to bit2 of other register.
> Add configurable en_reg and pll_en_bit for enable control or
> default 0 where pll data are static variables.
> Hence, CON0_BASE_EN could also be removed.
> And there might have another special case on other chips,
> the enable bit is still on CON0 register but not at bit0.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

> ---
>  drivers/clk/mediatek/clk-mtk.h |  2 ++
>  drivers/clk/mediatek/clk-pll.c | 15 ++++++++++-----
>  2 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index c3d6756..c580663 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -233,6 +233,8 @@ struct mtk_pll_data {
>         uint32_t pcw_chg_reg;
>         const struct mtk_pll_div_table *div_table;
>         const char *parent_name;
> +       uint32_t en_reg;
> +       uint8_t pll_en_bit; /* Assume 0, indicates BIT(0) by default */
>  };
>
>  void mtk_clk_register_plls(struct device_node *node,
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index 11ed5d1..7fb001a 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -44,6 +44,7 @@ struct mtk_clk_pll {
>         void __iomem    *tuner_en_addr;
>         void __iomem    *pcw_addr;
>         void __iomem    *pcw_chg_addr;
> +       void __iomem    *en_addr;
>         const struct mtk_pll_data *data;
>  };
>
> @@ -56,7 +57,7 @@ static int mtk_pll_is_prepared(struct clk_hw *hw)
>  {
>         struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
>
> -       return (readl(pll->base_addr + REG_CON0) & CON0_BASE_EN) != 0;
> +       return (readl(pll->en_addr) & BIT(pll->data->pll_en_bit)) != 0;
>  }
>
>  static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 fin,
> @@ -248,8 +249,8 @@ static int mtk_pll_prepare(struct clk_hw *hw)
>         writel(r, pll->pwr_addr);
>         udelay(1);
>
> -       r = readl(pll->base_addr + REG_CON0) | CON0_BASE_EN;
> -       writel(r, pll->base_addr + REG_CON0);
> +       r = readl(pll->en_addr) | BIT(pll->data->pll_en_bit);
> +       writel(r, pll->en_addr);
>
>         div_en_mask = pll->data->en_mask & ~CON0_BASE_EN;
>         if (div_en_mask) {
> @@ -290,8 +291,8 @@ static void mtk_pll_unprepare(struct clk_hw *hw)
>                 writel(r, pll->base_addr + REG_CON0);
>         }
>
> -       r = readl(pll->base_addr + REG_CON0) & ~CON0_BASE_EN;
> -       writel(r, pll->base_addr + REG_CON0);
> +       r = readl(pll->en_addr) & ~BIT(pll->data->pll_en_bit);
> +       writel(r, pll->en_addr);
>
>         r = readl(pll->pwr_addr) | CON0_ISO_EN;
>         writel(r, pll->pwr_addr);
> @@ -333,6 +334,10 @@ static struct clk *mtk_clk_register_pll(const struct mtk_pll_data *data,
>                 pll->tuner_addr = base + data->tuner_reg;
>         if (data->tuner_en_reg)
>                 pll->tuner_en_addr = base + data->tuner_en_reg;
> +       if (data->en_reg)
> +               pll->en_addr = base + data->en_reg;
> +       else
> +               pll->en_addr = pll->base_addr + REG_CON0;
>         pll->hw.init = &init;
>         pll->data = data;
>
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

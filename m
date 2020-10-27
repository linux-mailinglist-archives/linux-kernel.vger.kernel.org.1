Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FD029A2BB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 03:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389905AbgJ0ClZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 22:41:25 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41351 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389248AbgJ0ClZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 22:41:25 -0400
Received: by mail-vs1-f65.google.com with SMTP id e3so51682vsr.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 19:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bmk0UTS3x9Tp1HCmgDXGjH+YpS7EiLVNFjl9WtxBa50=;
        b=oBV6h+fG2Mxgvbs1jMZ3U+Dxxal0evBf3S3wH6YrlK/pFt5T+D1VlhP3XbltSFGRcA
         KzpitOQ+M8phttR+1pxWGAtS9qNRLYQT/6uK9ZbWQk29CBjo2W4v/iYMfh5Gl9P4GbZN
         AiiY05SllXB9izzEZiG8uONUBp2kiLuegya7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bmk0UTS3x9Tp1HCmgDXGjH+YpS7EiLVNFjl9WtxBa50=;
        b=GBIQcw7PFatRpjaXAQvHHt2r+7r5SA9CyxdhV+dFLWSez8UPZ4fJLxluj+y6B3ho2w
         2BRxrC0bZNOA01XKrOjXw7OF/9EZMKG9lXRGWFF3HkX8V4JAS2yAQ/JAw5iUcIMOED8h
         kAF9OBvfkh674qngD5fxHqoHPxqYlvRroFbRGXRxA8fq1uxx1OqTj69oJoqS9VQzO7uL
         ql3JWXafrcifpHnU2sFTmvW+HZA2rEPKVLUhxbEYIWRNqTMA7jTHVRh3r9vRiU8w7BRh
         vTNONh4FzMGxDEoz2zWqPiEMViOzo4Hss8u+fSinA3sUbQyw9uXwv7/IUTH5HCUFM1iw
         /hTA==
X-Gm-Message-State: AOAM5308e4C8DPTFKnKKlbAl+QhS0P0vjwnL6+BMlfVCvt7MocfRvMBV
        2FPmAh84JLH4FIUgjJUcffGlFxdSnwpmRHDUEXVgIA==
X-Google-Smtp-Source: ABdhPJx2W7iE7ZtLv3PQAdx32ue6WAArJMZ6rjaKeAAEEdusvUyHsnHXrL0Eekr9cHR06NHe8++RceLGNh3DACqb/8k=
X-Received: by 2002:a67:15c6:: with SMTP id 189mr6110vsv.16.1603766483061;
 Mon, 26 Oct 2020 19:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201026175526.2915399-1-enric.balletbo@collabora.com> <20201026175526.2915399-6-enric.balletbo@collabora.com>
In-Reply-To: <20201026175526.2915399-6-enric.balletbo@collabora.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 27 Oct 2020 10:41:12 +0800
Message-ID: <CANMq1KBXBEWwweuGFYGTbVrhYXgdjZuwhWVC6SedArFH2GJHoQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/16] soc: mediatek: pm_domains: Make bus protection generic
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Joerg Roedel <jroedel@suse.de>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 1:55 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> From: Matthias Brugger <mbrugger@suse.com>
>
> Bus protection is not exclusively done by calling the infracfg misc driver.
> Make the calls for setting and clearing the bus protection generic so
> that we can use other blocks for it as well.
>
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
> Changes in v3: None
> Changes in v2: None
>
>  drivers/soc/mediatek/mtk-infracfg.c   |  5 ---
>  drivers/soc/mediatek/mtk-pm-domains.c | 53 +++++++++++++++++++++------
>  include/linux/soc/mediatek/infracfg.h |  5 +++
>  3 files changed, 47 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-infracfg.c b/drivers/soc/mediatek/mtk-infracfg.c
> index 4a123796aad3..0590b68e0d78 100644
> --- a/drivers/soc/mediatek/mtk-infracfg.c
> +++ b/drivers/soc/mediatek/mtk-infracfg.c
> @@ -12,11 +12,6 @@
>  #define MTK_POLL_DELAY_US   10
>  #define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
>
> -#define INFRA_TOPAXI_PROTECTEN         0x0220
> -#define INFRA_TOPAXI_PROTECTSTA1       0x0228
> -#define INFRA_TOPAXI_PROTECTEN_SET     0x0260
> -#define INFRA_TOPAXI_PROTECTEN_CLR     0x0264
> -
>  /**
>   * mtk_infracfg_set_bus_protection - enable bus protection
>   * @infracfg: The infracfg regmap
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index 2121e05cb9a4..92c61e59255b 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -87,18 +87,24 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
>                                         MTK_POLL_TIMEOUT);
>  }
>
> -static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
> +static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, struct regmap *regmap)
>  {
> -       const struct scpsys_bus_prot_data *bpd = pd->data->bp_infracfg;
>         int i, ret;
>
>         for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
> -               if (!bpd[i].bus_prot_mask)
> +               u32 val, mask = bpd[i].bus_prot_mask;
> +
> +               if (!mask)
>                         break;
>
> -               ret = mtk_infracfg_set_bus_protection(pd->infracfg,
> -                                                     bpd[i].bus_prot_mask,
> -                                                     bpd[i].bus_prot_reg_update);
> +               if (bpd[i].bus_prot_reg_update)
> +                       regmap_update_bits(regmap, INFRA_TOPAXI_PROTECTEN, mask, mask);
> +               else
> +                       regmap_write(regmap, INFRA_TOPAXI_PROTECTEN_SET, mask);
> +
> +               ret = regmap_read_poll_timeout(regmap, INFRA_TOPAXI_PROTECTSTA1,
> +                                              val, (val & mask) == mask,
> +                                              MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>                 if (ret)
>                         return ret;
>         }
> @@ -106,18 +112,34 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
>         return 0;
>  }
>
> -static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
> +static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
>  {
>         const struct scpsys_bus_prot_data *bpd = pd->data->bp_infracfg;
> +       int ret;
> +
> +       ret = _scpsys_bus_protect_enable(bpd, pd->infracfg);
> +       return ret;
> +}
> +
> +static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
> +                                      struct regmap *regmap)
> +{
>         int i, ret;
>
>         for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
> -               if (!bpd[i].bus_prot_mask)
> +               u32 val, mask = bpd[i].bus_prot_mask;
> +
> +               if (!mask)
>                         return 0;
>
> -               ret = mtk_infracfg_clear_bus_protection(pd->infracfg,
> -                                                       bpd[i].bus_prot_mask,
> -                                                       bpd[i].bus_prot_reg_update);
> +               if (bpd[i].bus_prot_reg_update)
> +                       regmap_update_bits(regmap, INFRA_TOPAXI_PROTECTEN, mask, 0);
> +               else
> +                       regmap_write(regmap, INFRA_TOPAXI_PROTECTEN_CLR, mask);
> +
> +               ret = regmap_read_poll_timeout(regmap, INFRA_TOPAXI_PROTECTSTA1,
> +                                              val, !(val & mask),
> +                                              MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>                 if (ret)
>                         return ret;
>         }
> @@ -125,6 +147,15 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
>         return 0;
>  }
>
> +static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
> +{
> +       const struct scpsys_bus_prot_data *bpd = pd->data->bp_infracfg;

More of a nit: The next patch gets rid of this line, so maybe you
don't need to add it here.

Also `int ret` isn't really needed, but I think that's ok since the
next CL needs to add another call.

> +       int ret;
> +
> +       ret = _scpsys_bus_protect_disable(bpd, pd->infracfg);
> +       return ret;
> +}
> +
>  static int scpsys_power_on(struct generic_pm_domain *genpd)
>  {
>         struct scpsys_domain *pd = container_of(genpd, struct scpsys_domain, genpd);
> diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
> index 233463d789c6..5bcaab767f6a 100644
> --- a/include/linux/soc/mediatek/infracfg.h
> +++ b/include/linux/soc/mediatek/infracfg.h
> @@ -32,6 +32,11 @@
>  #define MT7622_TOP_AXI_PROT_EN_WB              (BIT(2) | BIT(6) | \
>                                                  BIT(7) | BIT(8))
>
> +#define INFRA_TOPAXI_PROTECTEN                 0x0220
> +#define INFRA_TOPAXI_PROTECTSTA1               0x0228
> +#define INFRA_TOPAXI_PROTECTEN_SET             0x0260
> +#define INFRA_TOPAXI_PROTECTEN_CLR             0x0264
> +
>  #define REG_INFRA_MISC                         0xf00
>  #define F_DDR_4GB_SUPPORT_EN                   BIT(13)
>
> --
> 2.28.0
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F6229A1F6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 01:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503570AbgJ0A6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 20:58:31 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39111 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408913AbgJ0A6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 20:58:31 -0400
Received: by mail-ua1-f66.google.com with SMTP id t15so3462241ual.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 17:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3Dgok4l5W01MscgrMjsNMzh9a1zLXNZz5FzIwHMh5c=;
        b=NRilLnYpmuEX0BFu+m+kUP57pTYsg4kVFKKUQGl6g4Eldwv6rUcUnm+VFUgljy1Afm
         Yi9wSQKO2SdK9OEnr/vvGTwXpY5KMDKonTT8Jl7IE5bMM0jbjXjlD/Z2nCFgGuhq1dZY
         /X/tMpcQ62F2daXNyDP7ZhoxQe0f2eFGy8t/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3Dgok4l5W01MscgrMjsNMzh9a1zLXNZz5FzIwHMh5c=;
        b=OIaLb7XEwF2Z8gm/ifqct0GFTa1DINSYibdamN3aDc8VCdZwL5rmXGIwCSr5vdQOSr
         iwZp8vJFXkeJbxuXAEVY8slZviR20cmyCwyZdVNIA/9UYmkRZy+rzm0TOyVEZBv+S5CO
         zVgo81RjMzo+l7QjlMbr8VS15p28FovlZza+Oe6zmQ2P0mXxqhmqAb9y0/pSwVqIOSNc
         oDg+rmvO1LcgoWOPEBbQW0Qy+H/JiounC7PMcpFqlOEpdo3NNWIXxVKdF6xUeE3vVjPU
         4fifS/Ealu7f1lIdt+U0b5OoGrx5Nubg5j/YN3wOkzmeNLzQtlZIClGqTaPZkApy71zS
         rmTw==
X-Gm-Message-State: AOAM533vgRgpTFq7rwU+nM+Yg6lrLVe+n0LscPpSDTjxocOFShyFoBc1
        g2oCTVhP+uJcxmkfEhvrkro7y03Xex9vv3y/SPcyqA==
X-Google-Smtp-Source: ABdhPJz0LeHyzLgm/WyLe2NkYH2xM1sa3TF/3IA53PalCOXMGjrJpM1nmilBHXpKcbyaXjYyrfj0uJRVWlfmMAmaAcw=
X-Received: by 2002:ab0:7351:: with SMTP id k17mr13803047uap.88.1603760308466;
 Mon, 26 Oct 2020 17:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201026175526.2915399-1-enric.balletbo@collabora.com> <20201026175526.2915399-5-enric.balletbo@collabora.com>
In-Reply-To: <20201026175526.2915399-5-enric.balletbo@collabora.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 27 Oct 2020 08:58:17 +0800
Message-ID: <CANMq1KA=xVSAu6eYS8cUgdPK6kETvKSCndHrCqcngfd9o=abQQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/16] soc: mediatek: pm-domains: Add bus protection protocol
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Matthias Brugger <mbrugger@suse.com>,
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
> Bus protection will need to update more then one register
> in infracfg. Add support for several operations.
>
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>
> Changes in v3: None
> Changes in v2: None
>
>  drivers/soc/mediatek/mt8173-pm-domains.h |  4 +--
>  drivers/soc/mediatek/mtk-pm-domains.c    | 36 +++++++++++++++++-------
>  drivers/soc/mediatek/mtk-pm-domains.h    |  4 ++-
>  3 files changed, 31 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mt8173-pm-domains.h b/drivers/soc/mediatek/mt8173-pm-domains.h
> index a2a624bbd8b8..341cc287c8ce 100644
> --- a/drivers/soc/mediatek/mt8173-pm-domains.h
> +++ b/drivers/soc/mediatek/mt8173-pm-domains.h
> @@ -34,7 +34,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
>                 .ctl_offs = SPM_DIS_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
> -               .bp_infracfg = {
> +               .bp_infracfg[0] = {
>                         .bus_prot_reg_update = true,
>                         .bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MM_M0 |
>                                 MT8173_TOP_AXI_PROT_EN_MM_M1,
> @@ -76,7 +76,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
>                 .ctl_offs = SPM_MFG_PWR_CON,
>                 .sram_pdn_bits = GENMASK(13, 8),
>                 .sram_pdn_ack_bits = GENMASK(21, 16),
> -               .bp_infracfg = {
> +               .bp_infracfg[0] = {
>                         .bus_prot_reg_update = true,
>                         .bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MFG_S |
>                                 MT8173_TOP_AXI_PROT_EN_MFG_M0 |
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index 16503d6db6a8..2121e05cb9a4 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -89,24 +89,40 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
>
>  static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
>  {
> -       const struct scpsys_bus_prot_data *bp_data = &pd->data->bp_infracfg;
> +       const struct scpsys_bus_prot_data *bpd = pd->data->bp_infracfg;
> +       int i, ret;
>
> -       if (!bp_data->bus_prot_mask)
> -               return 0;
> +       for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
> +               if (!bpd[i].bus_prot_mask)
> +                       break;
>
> -       return mtk_infracfg_set_bus_protection(pd->infracfg, bp_data->bus_prot_mask,
> -                                              bp_data->bus_prot_reg_update);
> +               ret = mtk_infracfg_set_bus_protection(pd->infracfg,
> +                                                     bpd[i].bus_prot_mask,
> +                                                     bpd[i].bus_prot_reg_update);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
>  }
>
>  static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
>  {
> -       const struct scpsys_bus_prot_data *bp_data = &pd->data->bp_infracfg;
> +       const struct scpsys_bus_prot_data *bpd = pd->data->bp_infracfg;
> +       int i, ret;
>
> -       if (!bp_data->bus_prot_mask)
> -               return 0;
> +       for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
> +               if (!bpd[i].bus_prot_mask)
> +                       return 0;
>
> -       return mtk_infracfg_clear_bus_protection(pd->infracfg, bp_data->bus_prot_mask,
> -                                                bp_data->bus_prot_reg_update);
> +               ret = mtk_infracfg_clear_bus_protection(pd->infracfg,
> +                                                       bpd[i].bus_prot_mask,
> +                                                       bpd[i].bus_prot_reg_update);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
>  }
>
>  static int scpsys_power_on(struct generic_pm_domain *genpd)
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index 7c8efcb3cef2..e428fe23a7e3 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -32,6 +32,8 @@
>  #define PWR_STATUS_AUDIO               BIT(24)
>  #define PWR_STATUS_USB                 BIT(25)
>
> +#define SPM_MAX_BUS_PROT_DATA          3
> +
>  struct scpsys_bus_prot_data {
>         u32 bus_prot_mask;
>         bool bus_prot_reg_update;
> @@ -52,7 +54,7 @@ struct scpsys_domain_data {
>         u32 sram_pdn_bits;
>         u32 sram_pdn_ack_bits;
>         u8 caps;
> -       const struct scpsys_bus_prot_data bp_infracfg;
> +       const struct scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
>  };
>
>  struct scpsys_soc_data {
> --
> 2.28.0
>

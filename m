Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A03E29A2C9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 03:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394883AbgJ0CrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 22:47:20 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44602 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394713AbgJ0CrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 22:47:19 -0400
Received: by mail-ua1-f65.google.com with SMTP id k12so47369uad.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 19:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CfHMJowBDH8fp8MkQnVoV3I8mZnnK2rYmrQmkGAHTzk=;
        b=ceBFFlgjHmpT89ryHtdWPO+jbawd3DaOCZ5D0I9wPI7EANCEz9yiRF5j/PpZ0X9k8r
         PYDSAJeEQHPwrD+KlFRiMQEQ1f9cLZahvLrGuFHX6Y8tDyVxaenvNkfpXzdJRdi3Tn6l
         25+N0Xs9GMfsO9xLAUSjk/qNScs6PEEQGLDss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CfHMJowBDH8fp8MkQnVoV3I8mZnnK2rYmrQmkGAHTzk=;
        b=Dn80BBX2GD3EjQ1LznGM/U09dPy0bT3Nx2mh4MiX4aSw4zYvFIN+beYALhV0DSJu38
         L+/5DpLUnDn051/EvQQ/aSPELlV2PwCAg1RoZGsz/O34NptH2arSThGKI40L1p7vWwIy
         Xqa7sv/unnyBNleBKLr2ClhVcr70RSDrypcxU0OnGKN7qGCamJD6ocp+4+k0UlOOg8U0
         KxZLrmjyFVGR2qmc0Qqk3zXgSF9GR/ooKPPcvskb2t6vnFlvdj0LvgBbFJ7tFw6Mf1qH
         zdyNeP01z8o73Z31X9fZjmSvaJ9zW/YB3sxiENXAR++NUCky26TssluY/ygHfD1zwlFC
         6MJg==
X-Gm-Message-State: AOAM530dvPTKXpnhEOAHGmdu2IGhVViOd8fUcxLWBE2v27sCD/bnIe9C
        pBZUtQku6dHeGVEGxWOgXfmRLu0fMj3BXDWEXc/xmA==
X-Google-Smtp-Source: ABdhPJyGpM3YUMVBx+nYfxPQlQBmBPZ6taDoHHfBDTZRvvPNjg6JOU0pushp7zq9etEWT3DiHWgNQq2vIQtsljEaHek=
X-Received: by 2002:ab0:5b0b:: with SMTP id u11mr95907uae.74.1603766837803;
 Mon, 26 Oct 2020 19:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201026175526.2915399-1-enric.balletbo@collabora.com> <20201026175526.2915399-8-enric.balletbo@collabora.com>
In-Reply-To: <20201026175526.2915399-8-enric.balletbo@collabora.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 27 Oct 2020 10:47:06 +0800
Message-ID: <CANMq1KCRk6Wb=pFh03vUQ02ZoJw7ZvDJi8ayjsw1LG-hVqaBAQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/16] soc: mediatek: pm-domains: Add extra sram control
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
> For some power domains like vpu_core on MT8183 whose sram need to do clock
> and internal isolation while power on/off sram. We add a cap
> "MTK_SCPD_SRAM_ISO" to judge if we need to do the extra sram isolation
> control or not.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
> Changes in v3: None
> Changes in v2:
> - Nit, split readl(ctl_addr) | pd->data->sram_pdn_bits in two lines.
> - Use regmap API
>
>  drivers/soc/mediatek/mtk-pm-domains.c | 25 +++++++++++++++++++++++--
>  drivers/soc/mediatek/mtk-pm-domains.h |  1 +
>  2 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index 006eb7571d32..82f6d937ed93 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -24,6 +24,8 @@
>  #define PWR_ON_BIT                     BIT(2)
>  #define PWR_ON_2ND_BIT                 BIT(3)
>  #define PWR_CLK_DIS_BIT                        BIT(4)
> +#define PWR_SRAM_CLKISO_BIT            BIT(5)
> +#define PWR_SRAM_ISOINT_B_BIT          BIT(6)
>
>  struct scpsys_domain {
>         struct generic_pm_domain genpd;
> @@ -65,12 +67,24 @@ static int scpsys_sram_enable(struct scpsys_domain *pd)
>         u32 pdn_ack = pd->data->sram_pdn_ack_bits;
>         struct scpsys *scpsys = pd->scpsys;
>         unsigned int tmp;
> +       int ret;
>
>         regmap_update_bits(scpsys->base, pd->data->ctl_offs, pd->data->sram_pdn_bits, 0);
>
>         /* Either wait until SRAM_PDN_ACK all 1 or 0 */
> -       return regmap_read_poll_timeout(scpsys->base, pd->data->ctl_offs, tmp,
> -                                       (tmp & pdn_ack) == 0, MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +       ret = regmap_read_poll_timeout(scpsys->base, pd->data->ctl_offs, tmp,
> +                                      (tmp & pdn_ack) == 0, MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (MTK_SCPD_CAPS(pd, MTK_SCPD_SRAM_ISO)) {
> +               regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_SRAM_ISOINT_B_BIT,
> +                                  PWR_SRAM_ISOINT_B_BIT);

regmap_set_bits?

> +               udelay(1);
> +               regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_SRAM_CLKISO_BIT, 0);

regmap_clear_bits?

But then I'm afraid we'll want to modify it everywhere for consistency.

I only noticed here as the first call spans over 2 lines..

> +       }
> +
> +       return 0;
>  }
>
>  static int scpsys_sram_disable(struct scpsys_domain *pd)
> @@ -79,6 +93,13 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
>         struct scpsys *scpsys = pd->scpsys;
>         unsigned int tmp;
>
> +       if (MTK_SCPD_CAPS(pd, MTK_SCPD_SRAM_ISO)) {
> +               regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_SRAM_CLKISO_BIT,
> +                                  PWR_SRAM_CLKISO_BIT);
> +               udelay(1);
> +               regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_SRAM_ISOINT_B_BIT, 0);
> +       }
> +
>         regmap_update_bits(scpsys->base, pd->data->ctl_offs, pd->data->sram_pdn_bits,
>                            pd->data->sram_pdn_bits);
>
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index 7b1abcfc4ba3..4152b96c1b29 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -5,6 +5,7 @@
>
>  #define MTK_SCPD_ACTIVE_WAKEUP         BIT(0)
>  #define MTK_SCPD_FWAIT_SRAM            BIT(1)
> +#define MTK_SCPD_SRAM_ISO              BIT(2)
>  #define MTK_SCPD_CAPS(_scpd, _x)       ((_scpd)->data->caps & (_x))
>
>  #define SPM_VDE_PWR_CON                        0x0210
> --
> 2.28.0
>

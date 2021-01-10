Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA0F2F04BE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 02:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbhAJBuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 20:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbhAJBuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 20:50:08 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9057EC061786
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 17:49:28 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id f16so4783193uav.12
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 17:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1UjVBI6DwWGEqKjlb956Wzfzp6jzPMsT75ZWabonuRA=;
        b=mJ37GlA6KDO7ZYwk4swiCGQNWElQShNlGobj/6SXwudRq5SMY8GWPXxqXJLdEurKVX
         OQQzyL7n6Kj9tysDd7Om15PlCPGA7rOGtA4oka0yHLZdDcC1Qc1UkgAP3C4DlzZpsOog
         dWWdH1rTjXYcKkiSV8QvUcdErxw7sSNpW+yOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1UjVBI6DwWGEqKjlb956Wzfzp6jzPMsT75ZWabonuRA=;
        b=FYc2fgZaDspRWWJjhIyV1pz5OPwByGmMu35rAef7v73qvg34rl95X0htYE1Ihzqb5z
         5UjlJFI1kiOVeakaTcsvdyZtA9VX4Q/0fem5SO6SSONz4UNt/kyWuiuwxZbh1gGwKqdP
         hYpjB6EWtfdRhDrNpaBUHWzAJdiqlrNKQDD+uLsYAsxo/6aF5TmqP4AjN08nGYb2AptW
         OtB1ynTKOA3BRFidWuFJXXRsf+fINPc8yuSi1bGeGQJaw/y/qHdQshTMGNRVI37VTndq
         tP5RV1EkDxn2nzauGRM9MXJfjJqzZQMSWdFRANkeo8blm8fUXn5Tk7fBY+ECFa80X/tk
         W+jw==
X-Gm-Message-State: AOAM532oC1GjLc+2nOEMnP5mQMXdEPXETyBLUA9hvJ6uSTeggSzIRrNb
        3igdc/6V9IIvotP7Hw1XHSZhxHRjheXSRzq6nDocpw==
X-Google-Smtp-Source: ABdhPJzBebHk146ZhAkD8otYtFgViiYtu+ubVds7PRUth6EO2Xh1rNYSE0WzcSgsh+QcdojwPhtJGAZrnOAzVQbKXdQ=
X-Received: by 2002:ab0:474e:: with SMTP id i14mr8074392uac.74.1610243367666;
 Sat, 09 Jan 2021 17:49:27 -0800 (PST)
MIME-Version: 1.0
References: <20210107104915.2888408-1-hsinyi@chromium.org> <20210107104915.2888408-3-hsinyi@chromium.org>
In-Reply-To: <20210107104915.2888408-3-hsinyi@chromium.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Sun, 10 Jan 2021 09:49:16 +0800
Message-ID: <CANMq1KAWCbtpJWMG2nE6k1hOzA=hCWYJxzC7RXb_voEri0v2=g@mail.gmail.com>
Subject: Re: [PATCH 2/3] soc: mediatek: pm-domains: Add domain regulator supply
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 6:49 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Some power domains (eg. mfg) needs to turn on power supply before power
> on.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/soc/mediatek/mt8183-pm-domains.h |  1 +
>  drivers/soc/mediatek/mtk-pm-domains.c    | 36 +++++++++++++++++++++++-
>  drivers/soc/mediatek/mtk-pm-domains.h    |  1 +
>  3 files changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/mediatek/mt8183-pm-domains.h b/drivers/soc/mediatek/mt8183-pm-domains.h
> index 8d996c5d2682d..aa5230e6c12f8 100644
> --- a/drivers/soc/mediatek/mt8183-pm-domains.h
> +++ b/drivers/soc/mediatek/mt8183-pm-domains.h
> @@ -38,6 +38,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
>                 .ctl_offs = 0x0338,
>                 .sram_pdn_bits = GENMASK(8, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
> +               .caps = MTK_SCPD_DOMAIN_SUPPLY,
>         },
>         [MT8183_POWER_DOMAIN_MFG_CORE0] = {
>                 .sta_mask = BIT(7),
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index fb70cb3b07b36..ae255aa7b1a97 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
[snip]
> @@ -275,6 +295,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>  {
>         const struct scpsys_domain_data *domain_data;
>         struct scpsys_domain *pd;
> +       struct device_node *np = scpsys->dev->of_node;
>         struct property *prop;
>         const char *clk_name;
>         int i, ret, num_clks;
> @@ -307,6 +328,19 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>         pd->data = domain_data;
>         pd->scpsys = scpsys;
>
> +       if (MTK_SCPD_CAPS(pd, MTK_SCPD_DOMAIN_SUPPLY)) {
> +               /* Find regulator in current power domain node */
> +               scpsys->dev->of_node = node;
> +               pd->supply = devm_regulator_get(scpsys->dev, "domain");
> +               scpsys->dev->of_node = np;

This pattern is a bit strange to me. But Hsin-Yi pointed out that
there are precedents:
https://elixir.bootlin.com/linux/v5.11-rc2/source/drivers/iio/adc/rcar-gyroadc.c#L397
.

> +               if (IS_ERR(pd->supply)) {
> +                       dev_err_probe(scpsys->dev, PTR_ERR(pd->supply),
> +                                     "%pOF: failed to get power supply.\n",
> +                                     node);
> +                       return ERR_CAST(pd->supply);
> +               }
> +       }
> +
>         pd->infracfg = syscon_regmap_lookup_by_phandle_optional(node, "mediatek,infracfg");
>         if (IS_ERR(pd->infracfg))
>                 return ERR_CAST(pd->infracfg);
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index a2f4d8f97e058..b2770b5266dba 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -7,6 +7,7 @@
>  #define MTK_SCPD_FWAIT_SRAM            BIT(1)
>  #define MTK_SCPD_SRAM_ISO              BIT(2)
>  #define MTK_SCPD_KEEP_DEFAULT_OFF      BIT(3)
> +#define MTK_SCPD_DOMAIN_SUPPLY         BIT(4)
>  #define MTK_SCPD_CAPS(_scpd, _x)       ((_scpd)->data->caps & (_x))
>
>  #define SPM_VDE_PWR_CON                        0x0210
> --
> 2.29.2.729.g45daf8777d-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

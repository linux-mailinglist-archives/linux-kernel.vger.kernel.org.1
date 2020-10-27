Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25BC29A2C5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 03:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393599AbgJ0Co7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 22:44:59 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34867 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392992AbgJ0Co7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 22:44:59 -0400
Received: by mail-vs1-f67.google.com with SMTP id n18so64774vsl.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 19:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wXRta/l0rIpVqWKOqa7VKxnC+dawIwiqAsPvJhT8cAw=;
        b=T/557vXyVCMYMplHmwqgl2C/+oWuotWYjE5ulgHmbhcBcoUTGTUcLKoLrseSR4dNbW
         lf70JtnoluukbB2REDI+6kSD1qMUWEwgv4Nw3GBikF9JZLY7vPGmYAXbyJRKbcFRr3ar
         WJklOqdkzS/LIIQLdrIKO3yASrpnU3LO4SrEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wXRta/l0rIpVqWKOqa7VKxnC+dawIwiqAsPvJhT8cAw=;
        b=thOngOzfDieW5IDhgcIdIKTS1Gi/0TmfJShtduUSpzNgFxVk+cs7aUKhG/tbgV6kwN
         PUawgxg8olGF6EV5Scb7yGF0jXGWr8UF3UhbA+lqq9SUz8Z7MmObhxp+48WBjMhk0Met
         u1gqjudDk7rAE6UL8QlAsX+H22KHV5bdMXXz960absL8A1kWL4Xnn0IkcolDImvNOGkh
         wbJF6IGRbjiIH2EczJ712V3rp1/bnviV253YeZ75iOvJr/SPwKr0tdaLBDTsoHdYC/tl
         2ySJXBuskJcaKgxvmst6FWZTAvWdxQ4bRyHcVLKPpAG7wy2YiOrsRWZKU3HioSLRMVGK
         L/wQ==
X-Gm-Message-State: AOAM532YUtBLAJ58yd5H+4t/5PGweg1K6IOP7X0bYKApUZvvc0nvup5s
        jCjsvX8wZh2sUNhiFssdXJvl374eBV4nYioZZqk+wA==
X-Google-Smtp-Source: ABdhPJyaj4h+nsHSHvyeat3tzFBttagersKPsH8TB4jnReJYbVxBNFyR6MXj9JmE7u1qH0zeqev5JFPLu55kIKQjZFI=
X-Received: by 2002:a67:2783:: with SMTP id n125mr231844vsn.47.1603766697607;
 Mon, 26 Oct 2020 19:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201026175526.2915399-1-enric.balletbo@collabora.com> <20201026175526.2915399-7-enric.balletbo@collabora.com>
In-Reply-To: <20201026175526.2915399-7-enric.balletbo@collabora.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 27 Oct 2020 10:44:46 +0800
Message-ID: <CANMq1KCDNH1w+jo5kjyhusLdzCR0hF8QUi3a+jkkDvv75uGK5A@mail.gmail.com>
Subject: Re: [PATCH v3 06/16] soc: mediatek: pm-domains: Add SMI block as bus
 protection block
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
> Apart from the infracfg block, the SMI block is used to enable the bus
> protection for some power domains. Add support for this block.
>
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
> Changes in v3:
> - Do not reuse bpd for 2 different things.
> - Disable pd->smi first and after that pd->infracfg.
> - Rename BUT_PROT_UPDATE_MT8173 to BUS_PROT_UPDATE_TOPAXI as in all the
>   other SoCs TOPAXI is mapped to the same address.
>
[snip]
>  static int scpsys_power_on(struct generic_pm_domain *genpd)
> @@ -266,6 +271,10 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>         if (IS_ERR(pd->infracfg))
>                 pd->infracfg = NULL;
>
> +       pd->smi = syscon_regmap_lookup_by_phandle(node, "mediatek,smi");
> +       if (IS_ERR(pd->smi))
> +               pd->smi = NULL;

This is the second time I see this pattern, I think.

Do we want to create a new syscon_regmap_lookup_by_phandle_optional wrapper?

Also, are we ok with ignoring all errors? I agree we can ignore
-ENODEV if optional, but I'm not sure about the others.

> +
>         pd->num_clks = of_clk_get_parent_count(node);
>         if (pd->num_clks > 0) {
>                 pd->clks = devm_kcalloc(scpsys->dev, pd->num_clks, sizeof(*pd->clks), GFP_KERNEL);
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index e428fe23a7e3..7b1abcfc4ba3 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -34,8 +34,31 @@
>
>  #define SPM_MAX_BUS_PROT_DATA          3
>
> +#define _BUS_PROT(_mask, _set, _clr, _sta, _update) {  \
> +               .bus_prot_mask = (_mask),               \
> +               .bus_prot_set = _set,                   \
> +               .bus_prot_clr = _clr,                   \
> +               .bus_prot_sta = _sta,                   \
> +               .bus_prot_reg_update = _update,         \
> +       }
> +
> +#define BUS_PROT_WR(_mask, _set, _clr, _sta)           \
> +               _BUS_PROT(_mask, _set, _clr, _sta, false)
> +
> +#define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)               \
> +               _BUS_PROT(_mask, _set, _clr, _sta, true)
> +
> +#define BUS_PROT_UPDATE_TOPAXI(_mask)                          \
> +               BUS_PROT_UPDATE(_mask,                          \
> +                               INFRA_TOPAXI_PROTECTEN,         \
> +                               INFRA_TOPAXI_PROTECTEN_CLR,     \
> +                               INFRA_TOPAXI_PROTECTSTA1)
> +
>  struct scpsys_bus_prot_data {
>         u32 bus_prot_mask;
> +       u32 bus_prot_set;
> +       u32 bus_prot_clr;
> +       u32 bus_prot_sta;
>         bool bus_prot_reg_update;
>  };
>
> @@ -47,6 +70,7 @@ struct scpsys_bus_prot_data {
>   * @sram_pdn_ack_bits: The mask for sram power control acked bits.
>   * @caps: The flag for active wake-up action.
>   * @bp_infracfg: bus protection for infracfg subsystem
> + * @bp_smi: bus protection for smi subsystem
>   */
>  struct scpsys_domain_data {
>         u32 sta_mask;
> @@ -55,6 +79,7 @@ struct scpsys_domain_data {
>         u32 sram_pdn_ack_bits;
>         u8 caps;
>         const struct scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
> +       const struct scpsys_bus_prot_data bp_smi[SPM_MAX_BUS_PROT_DATA];
>  };
>
>  struct scpsys_soc_data {
> --
> 2.28.0
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F8528CB52
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 11:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbgJMJ73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 05:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgJMJ72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 05:59:28 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719E5C0613D5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 02:59:28 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id l6so9846784vsr.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 02:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94e1CygScgMia7B1GgYR76qDGeMl52sMlW+hZME3L4E=;
        b=Oe3z23rbXIRkPOg82eMRmptX/YGV1GSl80yu3tMF44SgpnJUFRyH31DYBPIeVvMPbO
         AkwaV7uoeoe8eL6jpyuuD7tl6V9On+NalcDWYZrADnmQE3CVirR1MxF9bnSYWP5zvdt7
         UyHnP7uTg6EDTd42K4QoytRC2rUs9qG0VKTtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94e1CygScgMia7B1GgYR76qDGeMl52sMlW+hZME3L4E=;
        b=c88hLJQmfu39E7kf7ojG/hJq8bRIgCKCo+m055knCXtnt365SuP3ftRTGYCzU3VSjX
         4TYOXTgd03JWtbM8vydetDyd+r4g2UG5LhCZSl8Dxg7oV5PeommjM0oyFhR84d8ewHCW
         Jkc2qBIiZGEtByMnrZf9xNN7254TowGvMyqtKUqc+wXEpDP5uHtLglexx3ds/Q4TCxOg
         t9e5PzP0W+NKIMU6WdUtM7jYkWxZhhtd+Z/lFukON+2mZqpQsDygh+8GK33t9AYmfhTC
         tTeTHHiVyoY4LUFq0tqe5VkfRM+jmGFOOWx1MiShZfl7szPJ8AvUHFcyBF6R6kanX8lb
         r9dQ==
X-Gm-Message-State: AOAM530phLNo8w9KWrkHp8S2r+fapdMWQdHkjPzcskyInvbb5ByXu6s0
        xxqeavse0yy1PD/6I5or0AR0RU01/QfWI1h/Kr/fiw==
X-Google-Smtp-Source: ABdhPJzItTAowLdsnhfumm+mBqc+gsfN23zIOAuSGUeM3jKA7wqcYf+bd8TLqy7xqG0e3C5ExIM5O3X1OXfMhR8c9Fs=
X-Received: by 2002:a05:6102:237c:: with SMTP id o28mr15745607vsa.60.1602583167480;
 Tue, 13 Oct 2020 02:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201012124547.16649-1-wenbin.mei@mediatek.com> <20201012124547.16649-5-wenbin.mei@mediatek.com>
In-Reply-To: <20201012124547.16649-5-wenbin.mei@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 13 Oct 2020 17:59:15 +0800
Message-ID: <CANMq1KAxY2gU4D6XUvq2SVGGq=8HpQ-uWWhgDBnymP=qSiuUDw@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] mmc: mediatek: Add subsys clock control for MT8192 msdc
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 8:46 PM Wenbin Mei <wenbin.mei@mediatek.com> wrote:
>
> MT8192 msdc is an independent sub system, we need control more bus
> clocks for it.
> Add support for the additional subsys clocks to allow it to be
> configured appropriately.
>

Looks ok now, but I'd still like to see 1 or 2 follow-up patches that:
 1. In msdc_ungate_clock: check all clk_prepare_enable return values
before busy looping (to be consistent with how you now handle
bulk_clks)
 2. In msdc_of_clock_parse: All these if(IS_ERR(clk)) clk = NULL;
should be replaced by if (IS_ERR(clk)) return PTR_ERR(clk);

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 74 +++++++++++++++++++++++++++++----------
>  1 file changed, 56 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index a704745e5882..c7df7510f120 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -35,6 +35,7 @@
>  #include "cqhci.h"
>
>  #define MAX_BD_NUM          1024
> +#define MSDC_NR_CLOCKS      3
>
>  /*--------------------------------------------------------------------------*/
>  /* Common Definition                                                        */
> @@ -425,6 +426,8 @@ struct msdc_host {
>         struct clk *h_clk;      /* msdc h_clk */
>         struct clk *bus_clk;    /* bus clock which used to access register */
>         struct clk *src_clk_cg; /* msdc source clock control gate */
> +       struct clk *sys_clk_cg; /* msdc subsys clock control gate */
> +       struct clk_bulk_data bulk_clks[MSDC_NR_CLOCKS];
>         u32 mclk;               /* mmc subsystem clock frequency */
>         u32 src_clk_freq;       /* source clock frequency */
>         unsigned char timing;
> @@ -784,6 +787,7 @@ static void msdc_set_busy_timeout(struct msdc_host *host, u64 ns, u64 clks)
>
>  static void msdc_gate_clock(struct msdc_host *host)
>  {
> +       clk_bulk_disable_unprepare(MSDC_NR_CLOCKS, host->bulk_clks);
>         clk_disable_unprepare(host->src_clk_cg);
>         clk_disable_unprepare(host->src_clk);
>         clk_disable_unprepare(host->bus_clk);
> @@ -792,10 +796,18 @@ static void msdc_gate_clock(struct msdc_host *host)
>
>  static void msdc_ungate_clock(struct msdc_host *host)
>  {
> +       int ret;
> +
>         clk_prepare_enable(host->h_clk);
>         clk_prepare_enable(host->bus_clk);
>         clk_prepare_enable(host->src_clk);
>         clk_prepare_enable(host->src_clk_cg);
> +       ret = clk_bulk_prepare_enable(MSDC_NR_CLOCKS, host->bulk_clks);
> +       if (ret) {
> +               dev_err(host->dev, "Cannot enable pclk/axi/ahb clock gates\n");
> +               return;
> +       }
> +
>         while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
>                 cpu_relax();
>  }
> @@ -2366,6 +2378,48 @@ static void msdc_of_property_parse(struct platform_device *pdev,
>                 host->cqhci = false;
>  }
>
> +static int msdc_of_clock_parse(struct platform_device *pdev,
> +                              struct msdc_host *host)
> +{
> +       int ret;
> +
> +       host->src_clk = devm_clk_get(&pdev->dev, "source");
> +       if (IS_ERR(host->src_clk))
> +               return PTR_ERR(host->src_clk);
> +
> +       host->h_clk = devm_clk_get(&pdev->dev, "hclk");
> +       if (IS_ERR(host->h_clk))
> +               return PTR_ERR(host->h_clk);
> +
> +       host->bus_clk = devm_clk_get_optional(&pdev->dev, "bus_clk");
> +       if (IS_ERR(host->bus_clk))
> +               host->bus_clk = NULL;
> +
> +       /*source clock control gate is optional clock*/
> +       host->src_clk_cg = devm_clk_get_optional(&pdev->dev, "source_cg");
> +       if (IS_ERR(host->src_clk_cg))
> +               host->src_clk_cg = NULL;
> +
> +       host->sys_clk_cg = devm_clk_get_optional(&pdev->dev, "sys_cg");
> +       if (IS_ERR(host->sys_clk_cg))
> +               host->sys_clk_cg = NULL;
> +
> +       /* If present, always enable for this clock gate */
> +       clk_prepare_enable(host->sys_clk_cg);
> +
> +       host->bulk_clks[0].id = "pclk_cg";
> +       host->bulk_clks[1].id = "axi_cg";
> +       host->bulk_clks[2].id = "ahb_cg";
> +       ret = devm_clk_bulk_get_optional(&pdev->dev, MSDC_NR_CLOCKS,
> +                                        host->bulk_clks);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Cannot get pclk/axi/ahb clock gates\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  static int msdc_drv_probe(struct platform_device *pdev)
>  {
>         struct mmc_host *mmc;
> @@ -2405,25 +2459,9 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         if (ret)
>                 goto host_free;
>
> -       host->src_clk = devm_clk_get(&pdev->dev, "source");
> -       if (IS_ERR(host->src_clk)) {
> -               ret = PTR_ERR(host->src_clk);
> -               goto host_free;
> -       }
> -
> -       host->h_clk = devm_clk_get(&pdev->dev, "hclk");
> -       if (IS_ERR(host->h_clk)) {
> -               ret = PTR_ERR(host->h_clk);
> +       ret = msdc_of_clock_parse(pdev, host);
> +       if (ret)
>                 goto host_free;
> -       }
> -
> -       host->bus_clk = devm_clk_get(&pdev->dev, "bus_clk");
> -       if (IS_ERR(host->bus_clk))
> -               host->bus_clk = NULL;
> -       /*source clock control gate is optional clock*/
> -       host->src_clk_cg = devm_clk_get(&pdev->dev, "source_cg");
> -       if (IS_ERR(host->src_clk_cg))
> -               host->src_clk_cg = NULL;
>
>         host->reset = devm_reset_control_get_optional_exclusive(&pdev->dev,
>                                                                 "hrst");
> --
> 2.18.0

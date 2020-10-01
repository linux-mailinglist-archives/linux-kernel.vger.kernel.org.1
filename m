Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF3327F957
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 08:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgJAGOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 02:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAGOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 02:14:14 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AB4C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 23:14:13 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id a16so2054253vsp.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 23:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VlK25AeCqL3jo7oZoKivx7ZKCZnGaTWNtqH24P3Rx58=;
        b=nsKh9SmyYr6dFqhw75fYDL7n5mG3UUdgFMIuakzzITavWvq6EHjqF1X9nWwIt2r+wX
         ojx5yjM71XwFhwhBRKWEodxX/dyhQeHrEI6fO/7tXmPZCrQuvRAeuMTU8UkiYbAfYgfV
         y257KdPrMIfZeX9eyDP+cp0PpHAtvE9Vqtfko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VlK25AeCqL3jo7oZoKivx7ZKCZnGaTWNtqH24P3Rx58=;
        b=euv697QB4I8kFhv0V59fkwI97+4pv7p0hpjAVASxJyGgEUyheWXjlnf3XEwZpHBeCi
         6krigb02HFP55zU55FGgdCATIRRpFa3UwqXf2rcv4UvlKad9wSZO60ny6sGxt/nsyzYb
         OusR73CSZp4xe0vUCRewIlWNLtq8WFbZDyyZ+1Lvl48w8agO53Dhy4dpqLbdJKKCPNnA
         Kh35VHlAwFpZ/fiAsXfSCexcdMR+3AUtOB2Z5Ur03G2wqaZ/e8dSKOxykijCW8qxdTSJ
         gDHtTZoye6zDBcMmgm3wuy+7sQkbYoEPy6Zg4DYqk3Z2n2zDlbtSbL7jihtXXJWvkW8F
         +zxg==
X-Gm-Message-State: AOAM533ghFyIExbcdeLlmWer7Ge1u+Yat3GJr9evaExd+ikmbhLtS1to
        sVpoUMgY8oMRrq3Z1qKT9ZrUtgwr+n688jf2vyQtQg==
X-Google-Smtp-Source: ABdhPJxLXQQGLRLzY6RFBL5DI0m1HQoOFsQi0w8LIWHFTIqUlUJYtSC0vKE7KVqUO73TNfZ8033bmhNJ5nUfTYZXppE=
X-Received: by 2002:a67:be08:: with SMTP id x8mr4072437vsq.47.1601532853052;
 Wed, 30 Sep 2020 23:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200930083120.11971-1-wenbin.mei@mediatek.com> <20200930083120.11971-5-wenbin.mei@mediatek.com>
In-Reply-To: <20200930083120.11971-5-wenbin.mei@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 1 Oct 2020 14:14:02 +0800
Message-ID: <CANMq1KCQ9x1kgME3dAQmGzjUoqkNLuWGS4dG07qhNKQ3N=o_dw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mmc: mediatek: Add subsys clock control for MT8192 msdc
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

On Wed, Sep 30, 2020 at 4:31 PM Wenbin Mei <wenbin.mei@mediatek.com> wrote:
>
> MT8192 msdc is an independent sub system, we need control more bus
> clocks for it.
> Add support for the additional subsys clocks to allow it to be
> configured appropriately.
>
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 77 ++++++++++++++++++++++++++++++---------
>  1 file changed, 59 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index a704745e5882..9a1422955593 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -425,6 +425,8 @@ struct msdc_host {
>         struct clk *h_clk;      /* msdc h_clk */
>         struct clk *bus_clk;    /* bus clock which used to access register */
>         struct clk *src_clk_cg; /* msdc source clock control gate */
> +       struct clk *sys_clk_cg; /* msdc subsys clock control gate */
> +       struct clk_bulk_data bulk_clks[3];      /* pclk, axi, ahb clock control gate */
>         u32 mclk;               /* mmc subsystem clock frequency */
>         u32 src_clk_freq;       /* source clock frequency */
>         unsigned char timing;
> @@ -784,6 +786,8 @@ static void msdc_set_busy_timeout(struct msdc_host *host, u64 ns, u64 clks)
>
>  static void msdc_gate_clock(struct msdc_host *host)
>  {
> +       clk_bulk_disable_unprepare(ARRAY_SIZE(host->bulk_clks),
> +                                  host->bulk_clks);
>         clk_disable_unprepare(host->src_clk_cg);
>         clk_disable_unprepare(host->src_clk);
>         clk_disable_unprepare(host->bus_clk);
> @@ -792,10 +796,17 @@ static void msdc_gate_clock(struct msdc_host *host)
>
>  static void msdc_ungate_clock(struct msdc_host *host)
>  {
> +       int ret;
> +
>         clk_prepare_enable(host->h_clk);
>         clk_prepare_enable(host->bus_clk);
>         clk_prepare_enable(host->src_clk);
>         clk_prepare_enable(host->src_clk_cg);
> +       ret = clk_bulk_prepare_enable(ARRAY_SIZE(host->bulk_clks),
> +                                     host->bulk_clks);
> +       if (ret)
> +               dev_dbg(host->dev, "enable clks failed!\n");

dev_err looks a lot more appropriate. Also, don't you want to exit the
function in that case, rather than going to the while loop below where
you may get stuck?

> +
>         while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
>                 cpu_relax();
>  }
> @@ -2366,6 +2377,52 @@ static void msdc_of_property_parse(struct platform_device *pdev,
>                 host->cqhci = false;
>  }
>
> +static int msdc_of_clock_parse(struct platform_device *pdev,
> +                              struct msdc_host *host)
> +{
> +       struct clk *clk;
> +
> +       host->src_clk = devm_clk_get(&pdev->dev, "source");
> +       if (IS_ERR(host->src_clk))
> +               return PTR_ERR(host->src_clk);
> +
> +       host->h_clk = devm_clk_get(&pdev->dev, "hclk");
> +       if (IS_ERR(host->h_clk))
> +               return PTR_ERR(host->h_clk);
> +
> +       host->bus_clk = devm_clk_get(&pdev->dev, "bus_clk");
> +       if (IS_ERR(host->bus_clk))
> +               host->bus_clk = NULL;

Use devm_clk_get_optional instead (ditto for the next 2).

> +
> +       /*source clock control gate is optional clock*/
> +       host->src_clk_cg = devm_clk_get(&pdev->dev, "source_cg");
> +       if (IS_ERR(host->src_clk_cg))
> +               host->src_clk_cg = NULL;
> +
> +       host->sys_clk_cg = devm_clk_get(&pdev->dev, "sys_cg");
> +       if (IS_ERR(host->sys_clk_cg))
> +               host->sys_clk_cg = NULL;
> +       else
> +               clk_prepare_enable(host->sys_clk_cg);

This doesn't need to be in an else branch, calling clk_prepare_enable
on a NULL clock is fine.

However, is it expected that this clock is turned on forever after
probe?! At the very least, the clock should be disabled in
msdc_drv_remove, but, really, I think it should be enabled as needed,
like the other clocks, in msdc_gate_clock?

> +
> +       clk = devm_clk_get(&pdev->dev, "pclk_cg");
> +       if (IS_ERR(clk))
> +               clk = NULL;
> +       host->bulk_clks[0].clk = clk;
> +
> +       clk = devm_clk_get(&pdev->dev, "axi_cg");
> +       if (IS_ERR(clk))
> +               clk = NULL;
> +       host->bulk_clks[1].clk = clk;
> +
> +       clk = devm_clk_get(&pdev->dev, "ahb_cg");
> +       if (IS_ERR(clk))
> +               clk = NULL;
> +       host->bulk_clks[2].clk = clk;

Use devm_clk_bulk_get_optional for these 3.

> +
> +       return 0;
> +}
> +
>  static int msdc_drv_probe(struct platform_device *pdev)
>  {
>         struct mmc_host *mmc;
> @@ -2405,25 +2462,9 @@ static int msdc_drv_probe(struct platform_device *pdev)
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

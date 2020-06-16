Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1302F1FAF48
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 13:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgFPLdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 07:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbgFPLdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:33:33 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FCBC08C5C3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 04:33:32 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id o2so11225850vsr.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 04:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z4+Iz5hXHc4KqHs/Siy+ZWN5Iucm03GbQ2VElO3GIbE=;
        b=nDIBdjVmKagHvZo44/5GnMutd+R9LOzqdj7KoKAjZCeARsNRBWF+9cGFnYMjSfV7Vs
         r4303MeB7Zgsz3BHhUBei2NxgJ77BYTNOA6KEqwV2dziFSfcZeH/37omrb/OhrA2FVhN
         iVNLxGGtaXs8BSbxMcqI1p1jIEB5fmqAanfN0b/EtI8ut38Sql4N/26QCNTV3WypKHL7
         Zt940MpjDG13b3XlCEGfJ5u6HOdKds0M50x4KT+fPeZ+d5gjJmO3/4sxjcS67kQrPfUf
         wAagBLnmntF9pcPlTMGp34+8QiVEPqy3ZyRCeSFCk6rky6z01YGR03XLjBKgUcGL6oXy
         h9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z4+Iz5hXHc4KqHs/Siy+ZWN5Iucm03GbQ2VElO3GIbE=;
        b=JWutJ3S5qLlbZQNArjLGxi1Zl4JNQfTZKZEPe9PuXk549pJkhx6RfC7ZHi4U9dQQZ9
         bibIH4WriG6DzQSbCZTJpL5BapuKv1Vowxpy8lubZTL/xr2i/edHI1knyHT967+Lkx5g
         nADkZW0aUoSRRulmuNivVnG/qLcQxx5UgZ8BVDoS8d4A5CkqD508wUTSAK05DThkv0gQ
         V5Bl09hVjE67bq43PGcv1MoOHCceJ+d31jGd50gq8wUIChrkotl0jhqiEOj+j1F7oc3i
         6Bnejh2S+p2/ngWKi6c72z46BlkSYqAOJOErfMLIlwJnhzkWlD4fvqyilnxYazruc93V
         ZUfQ==
X-Gm-Message-State: AOAM531d+RVmN2oDQ4J5KqUnE1W5msI8WcPLSIx3cmdA/HiCwa2GSu4p
        yH4+84IuWpq/EJRreA0To3OFY2D5R4mlbyUUFVbQgg==
X-Google-Smtp-Source: ABdhPJyGZERfhW1QKFPZ5+rChUj0a55YKn9tZGUbhrD+eRw5UOrhMGu/7HPk1pqELV9Q/H4lqZhJMwIGM2yDSPP9sLo=
X-Received: by 2002:a67:903:: with SMTP id 3mr1156423vsj.191.1592307212063;
 Tue, 16 Jun 2020 04:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200608162226.3259186-1-hslester96@gmail.com>
In-Reply-To: <20200608162226.3259186-1-hslester96@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 16 Jun 2020 13:32:55 +0200
Message-ID: <CAPDyKFrrrydrUaOVGB+VTgLSGMn41JO+ughhza_BzGPE7wm_yw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add missed checks for devm_clk_register()
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jun 2020 at 18:22, Chuhong Yuan <hslester96@gmail.com> wrote:
>
> These functions do not check the return value of devm_clk_register():
>   - sdhci_arasan_register_sdcardclk()
>   - sdhci_arasan_register_sampleclk()
>
> Therefore, add the missed checks to fix them.
>
> Fixes: c390f2110adf1 ("mmc: sdhci-of-arasan: Add ability to export card clock")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index db9b544465cd..fb26e743e1fd 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1299,6 +1299,8 @@ sdhci_arasan_register_sdcardclk(struct sdhci_arasan_data *sdhci_arasan,
>         clk_data->sdcardclk_hw.init = &sdcardclk_init;
>         clk_data->sdcardclk =
>                 devm_clk_register(dev, &clk_data->sdcardclk_hw);
> +       if (IS_ERR(clk_data->sdcardclk))
> +               return PTR_ERR(clk_data->sdcardclk);
>         clk_data->sdcardclk_hw.init = NULL;
>
>         ret = of_clk_add_provider(np, of_clk_src_simple_get,
> @@ -1349,6 +1351,8 @@ sdhci_arasan_register_sampleclk(struct sdhci_arasan_data *sdhci_arasan,
>         clk_data->sampleclk_hw.init = &sampleclk_init;
>         clk_data->sampleclk =
>                 devm_clk_register(dev, &clk_data->sampleclk_hw);
> +       if (IS_ERR(clk_data->sampleclk))
> +               return PTR_ERR(clk_data->sampleclk);
>         clk_data->sampleclk_hw.init = NULL;
>
>         ret = of_clk_add_provider(np, of_clk_src_simple_get,
> --
> 2.26.2
>

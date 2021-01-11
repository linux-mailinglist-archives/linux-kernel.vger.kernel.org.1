Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8112F1D93
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390260AbhAKSIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390219AbhAKSIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:08:09 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAF7C0617BA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:06:56 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id x4so54476vsp.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MfaOulU+Mc40b45/hjM/TjLBGSkN+SyhGctwM6EuRRA=;
        b=WskRhGFRleQ1ieZKijVafVEHRb4c8bzCFMA7RalCB2nRv2UwUR984nG6uHHsyYPGQu
         gqcvhtctdQFLp29fBJa0Qv5azxQvFQhjK+fl0EzzQJGN82UmIBn2hWXQMB33jvU4nxdS
         3WWd4onzEFI3JaAGrYrWSRz3u5oJIiVqZAKjHH73V1jE4j2ZM5RezxCOAGsY8XOxvpGy
         3aetwzYuCMQPsxRyH2QbvpQrfvZK71Veszma/z2LXDngU7APnO4M8OovambVXuqSD0rx
         uZEXpSELqk5LiOOZzWye3u4yjbg9sVUppGi6AlhHKUsVKABph0UD/fPrpEqNL9JbpmH8
         mGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MfaOulU+Mc40b45/hjM/TjLBGSkN+SyhGctwM6EuRRA=;
        b=WsJJgO/2wIniMTAjO6zKIHuZDrtG2KtTT/NnFceLO45VabgaxyZjdfDqz3QBP+mD3a
         IJH0bl2NIn0qtGFZ7+5LDnusfRqdH4/5BZE37Wnif4UdlhImiqLMtPAHYMp4WUTDO2j8
         tTkQmwQEfeaDg+aKUx6PvJ83MMN8DccVFeL6tDUW3x3Cr8ApMLC9LA8ZVao8/O+dV4r5
         Waoa7mGMnE9ugDMLPN3Z/8nc2mXhwJHG6Dbr4onlW5QfPOikXP15syRQcze87jgCBULo
         3ejUS40Zfqbga4nDUq0pZLV3dC01LBd0HFD/5LosWzh/yy9WzCeCvonL92/Y86TRNlyE
         KftA==
X-Gm-Message-State: AOAM531zotio7gvaFpKMNuMMwrW3QAq0l49414ASxvuL0HiNiWtrTGiu
        w735wo3GTgsSZOB5JNLfQtY9Y2BtSNa1p/EiK381QA==
X-Google-Smtp-Source: ABdhPJx1ve7hy46qo6dBg52+Hu667fG5dJSCb1YZ8cLvLpos6eZ79TYA80NOZQUo7CA+yNqluCztw1TSX5BzJU2+EbQ=
X-Received: by 2002:a67:fe85:: with SMTP id b5mr797102vsr.19.1610388415324;
 Mon, 11 Jan 2021 10:06:55 -0800 (PST)
MIME-Version: 1.0
References: <20201211011934.6171-1-andre.przywara@arm.com> <20201211011934.6171-10-andre.przywara@arm.com>
In-Reply-To: <20201211011934.6171-10-andre.przywara@arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Jan 2021 19:06:17 +0100
Message-ID: <CAPDyKFokNt1megz9MHcn8rSgYki=c_s=UeNk8cBLUaHVVKrQ6A@mail.gmail.com>
Subject: Re: [PATCH v2 09/21] mmc: sunxi: add support for A100 mmc controller
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Dec 2020 at 02:20, Andre Przywara <andre.przywara@arm.com> wrote:
>
> From: Yangtao Li <frank@allwinnertech.com>
>
> This patch adds support for A100 MMC controller, which use word address
> for internal dma.
>
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Applied for next to my mmc tree, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sunxi-mmc.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index fc62773602ec..1518b64112b7 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -244,6 +244,7 @@ struct sunxi_idma_des {
>
>  struct sunxi_mmc_cfg {
>         u32 idma_des_size_bits;
> +       u32 idma_des_shift;
>         const struct sunxi_mmc_clk_delay *clk_delays;
>
>         /* does the IP block support autocalibration? */
> @@ -343,7 +344,7 @@ static int sunxi_mmc_init_host(struct sunxi_mmc_host *host)
>         /* Enable CEATA support */
>         mmc_writel(host, REG_FUNS, SDXC_CEATA_ON);
>         /* Set DMA descriptor list base address */
> -       mmc_writel(host, REG_DLBA, host->sg_dma);
> +       mmc_writel(host, REG_DLBA, host->sg_dma >> host->cfg->idma_des_shift);
>
>         rval = mmc_readl(host, REG_GCTRL);
>         rval |= SDXC_INTERRUPT_ENABLE_BIT;
> @@ -373,8 +374,10 @@ static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
>
>                 next_desc += sizeof(struct sunxi_idma_des);
>                 pdes[i].buf_addr_ptr1 =
> -                       cpu_to_le32(sg_dma_address(&data->sg[i]));
> -               pdes[i].buf_addr_ptr2 = cpu_to_le32((u32)next_desc);
> +                       cpu_to_le32(sg_dma_address(&data->sg[i]) >>
> +                                   host->cfg->idma_des_shift);
> +               pdes[i].buf_addr_ptr2 = cpu_to_le32((u32)next_desc >>
> +                                                   host->cfg->idma_des_shift);
>         }
>
>         pdes[0].config |= cpu_to_le32(SDXC_IDMAC_DES0_FD);
> @@ -1178,6 +1181,23 @@ static const struct sunxi_mmc_cfg sun50i_a64_emmc_cfg = {
>         .needs_new_timings = true,
>  };
>
> +static const struct sunxi_mmc_cfg sun50i_a100_cfg = {
> +       .idma_des_size_bits = 16,
> +       .idma_des_shift = 2,
> +       .clk_delays = NULL,
> +       .can_calibrate = true,
> +       .mask_data0 = true,
> +       .needs_new_timings = true,
> +};
> +
> +static const struct sunxi_mmc_cfg sun50i_a100_emmc_cfg = {
> +       .idma_des_size_bits = 13,
> +       .idma_des_shift = 2,
> +       .clk_delays = NULL,
> +       .can_calibrate = true,
> +       .needs_new_timings = true,
> +};
> +
>  static const struct of_device_id sunxi_mmc_of_match[] = {
>         { .compatible = "allwinner,sun4i-a10-mmc", .data = &sun4i_a10_cfg },
>         { .compatible = "allwinner,sun5i-a13-mmc", .data = &sun5i_a13_cfg },
> @@ -1186,6 +1206,8 @@ static const struct of_device_id sunxi_mmc_of_match[] = {
>         { .compatible = "allwinner,sun9i-a80-mmc", .data = &sun9i_a80_cfg },
>         { .compatible = "allwinner,sun50i-a64-mmc", .data = &sun50i_a64_cfg },
>         { .compatible = "allwinner,sun50i-a64-emmc", .data = &sun50i_a64_emmc_cfg },
> +       { .compatible = "allwinner,sun50i-a100-mmc", .data = &sun50i_a100_cfg },
> +       { .compatible = "allwinner,sun50i-a100-emmc", .data = &sun50i_a100_emmc_cfg },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
> --
> 2.17.5
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B9C2F5DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbhANJln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbhANJll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:41:41 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540E5C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 01:41:03 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id w1so7182028ejf.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 01:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XtRchozMXYyxecV0O3wYbir6w5h71L6TdcF28RnWeBY=;
        b=Y8bXX1lbEW/3cmFQrnS+eYmDQ4vChpWqVuxI13qzfpyTTfnW2L2hooP9lSjWXUiHKl
         wjFBO5SWlHCx0ATesNnz6qkMKO1wMRV3lUJzpI4NvdOm4NTX6NX+pk5N2M/WrBRTgAZn
         67u8qzXMkXyiS03i1qX+D8eNFkrfG48K1Knqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XtRchozMXYyxecV0O3wYbir6w5h71L6TdcF28RnWeBY=;
        b=VAhihjytEiUskeYiXqaAfNN5WW0QlIBnZbQ740J0ADs+fbgvjoKHjTWiF6N1+AkuOk
         OMlbA9LHbIqcNblh8C3Q5Uc14Rs1NM9WZzX+j4sJJY1Tr+GBZE+PdhtcdMr5N/Bd2Ola
         Glp6Qiwh1VUNFLViWeqdfsXtosij1i7IClkY4Aqe1EWtuZPoTX5AwWHLRDRp7PNycWAO
         FoC6NCW1B/1sfUedxyQiItuETVIJcAmEzLWzLc8yjqMhf9eylS5gYdJxs6CXih0J/06V
         ZBgV8Yt+AlC8iHVrZbrSG45iGokmkIEIlZ1E6L9Jzmco4Ksge24FMKu6B+NBxYGH5x9B
         0zHA==
X-Gm-Message-State: AOAM5303Q1x+sjZUDYbmvvhGqvEMrZh4S9RNHONIegCXHkX+GhIiyiUY
        lYK9oN911iOL8LU5YMz3OmPVXYRfkQA6SWItXPkLUrKG2AFb0Q==
X-Google-Smtp-Source: ABdhPJxBmrMi6Lew1mqN5EeHda8QYdKgJ9IstDviL6V/cclaaacdFTUJzFYwQYjn5SjsWvoMXE9qYTI+Ch9dw6OhPtI=
X-Received: by 2002:a17:906:c78b:: with SMTP id cw11mr2378212ejb.448.1610617261954;
 Thu, 14 Jan 2021 01:41:01 -0800 (PST)
MIME-Version: 1.0
References: <1602732039-12179-1-git-send-email-neal.liu@mediatek.com> <1602732039-12179-3-git-send-email-neal.liu@mediatek.com>
In-Reply-To: <1602732039-12179-3-git-send-email-neal.liu@mediatek.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Thu, 14 Jan 2021 17:40:26 +0800
Message-ID: <CANdKZ0f7=-keVzKm7y5WHUhsCqjA75aCMf=ph+BmrDuS203fVg@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] soc: mediatek: add mt6779 devapc driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neal,
Please see inline comments below.

On Thu, Oct 15, 2020 at 11:21 AM Neal Liu <neal.liu@mediatek.com> wrote:
>
> MediaTek bus fabric provides TrustZone security support and data
> protection to prevent slaves from being accessed by unexpected
> masters.
> The security violation is logged and sent to the processor for
> further analysis or countermeasures.
>
> Any occurrence of security violation would raise an interrupt, and
> it will be handled by mtk-devapc driver. The violation
> information is printed in order to find the murderer.
>
> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> ---
>  drivers/soc/mediatek/Kconfig      |    9 ++
>  drivers/soc/mediatek/Makefile     |    1 +
>  drivers/soc/mediatek/mtk-devapc.c |  308 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 318 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mtk-devapc.c
>
> ...
> diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
> new file mode 100644
> index 0000000..f1cea04
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-devapc.c
>
> ...
>
> +
> +static void clear_vio_status(struct mtk_devapc_context *ctx)
> +{
> +       void __iomem *reg;
> +       int i;
> +
> +       reg = ctx->infra_base + ctx->data->vio_sta_offset;
> +
> +       for (i = 0; i < VIO_MOD_TO_REG_IND(ctx->data->vio_idx_num) - 1; i++)
> +               writel(GENMASK(31, 0), reg + 4 * i);
> +
> +       writel(GENMASK(VIO_MOD_TO_REG_OFF(ctx->data->vio_idx_num) - 1, 0),
> +              reg + 4 * i);

Is it guaranteed that vio_idx_num will always not a multiple of 32, or
should we check that VIO_MOD_TO_REG_OFF(ctx->data->vio_idx_num) is not
zero?

> +}
> +
> +static void mask_module_irq(struct mtk_devapc_context *ctx, bool mask)
> +{
> +       void __iomem *reg;
> +       u32 val;
> +       int i;
> +
> +       reg = ctx->infra_base + ctx->data->vio_mask_offset;
> +
> +       if (mask)
> +               val = GENMASK(31, 0);
> +       else
> +               val = 0;
> +
> +       for (i = 0; i < VIO_MOD_TO_REG_IND(ctx->data->vio_idx_num) - 1; i++)
> +               writel(val, reg + 4 * i);
> +
> +       val = readl(reg + 4 * i);
> +       if (mask)
> +               val |= GENMASK(VIO_MOD_TO_REG_OFF(ctx->data->vio_idx_num) - 1,
> +                              0);
> +       else
> +               val &= ~GENMASK(VIO_MOD_TO_REG_OFF(ctx->data->vio_idx_num) - 1,
> +                               0);

Same here.

> +
> +       writel(val, reg + 4 * i);
> +}
> +
> +#define PHY_DEVAPC_TIMEOUT     0x10000
> +
> +/*
> + * devapc_sync_vio_dbg - do "shift" mechansim" to get full violation information.

nit: One extra double quote in the comment.

> + *                       shift mechanism is depends on devapc hardware design.
> + *                       Mediatek devapc set multiple slaves as a group.
> + *                       When violation is triggered, violation info is kept
> + *                       inside devapc hardware.
> + *                       Driver should do shift mechansim to sync full violation
> + *                       info to VIO_DBGs registers.
> + *
> + */
> +static int devapc_sync_vio_dbg(struct mtk_devapc_context *ctx)
>
> ...
>
> +static int mtk_devapc_probe(struct platform_device *pdev)
> +{
> +       struct device_node *node = pdev->dev.of_node;
> +       struct mtk_devapc_context *ctx;
> +       u32 devapc_irq;
> +       int ret;
> +
> +       if (IS_ERR(node))

Does this ever happens? I feel the check should be `if (node == NULL)`.

> +               return -ENODEV;
> +
> +       ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
> +       if (!ctx)
> +               return -ENOMEM;
> +
> +       ctx->data = of_device_get_match_data(&pdev->dev);
> +       ctx->dev = &pdev->dev;
> +
> +       ctx->infra_base = of_iomap(node, 0);
> +       if (!ctx->infra_base)
> +               return -EINVAL;

Missing `iounmap(ctx->infra_base)` in the following error paths and
mtk_devapc_remove. Use devm_of_iomap instead?

> +
> +       devapc_irq = irq_of_parse_and_map(node, 0);
> +       if (!devapc_irq)
> +               return -EINVAL;
> +
> +       ctx->infra_clk = devm_clk_get(&pdev->dev, "devapc-infra-clock");
> +       if (IS_ERR(ctx->infra_clk))
> +               return -EINVAL;
> +
> +       if (clk_prepare_enable(ctx->infra_clk))
> +               return -EINVAL;
> +
> +       ret = devm_request_irq(&pdev->dev, devapc_irq, devapc_violation_irq,
> +                              IRQF_TRIGGER_NONE, "devapc", ctx);
> +       if (ret) {
> +               clk_disable_unprepare(ctx->infra_clk);
> +               return ret;
> +       }
> +
> +       platform_set_drvdata(pdev, ctx);
> +
> +       start_devapc(ctx);
> +
> +       return 0;
> +}
> +
> +static int mtk_devapc_remove(struct platform_device *pdev)
> +{
> +       struct mtk_devapc_context *ctx = platform_get_drvdata(pdev);
> +
> +       stop_devapc(ctx);
> +
> +       clk_disable_unprepare(ctx->infra_clk);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver mtk_devapc_driver = {
> +       .probe = mtk_devapc_probe,
> +       .remove = mtk_devapc_remove,
> +       .driver = {
> +               .name = "mtk-devapc",
> +               .of_match_table = mtk_devapc_dt_match,
> +       },
> +};
> +
> +module_platform_driver(mtk_devapc_driver);
> +
> +MODULE_DESCRIPTION("Mediatek Device APC Driver");
> +MODULE_AUTHOR("Neal Liu <neal.liu@mediatek.com>");
> +MODULE_LICENSE("GPL");
> --
> 1.7.9.5

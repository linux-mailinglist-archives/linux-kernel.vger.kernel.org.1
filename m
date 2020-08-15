Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C632A2453F8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 00:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbgHOWKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 18:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728715AbgHOWK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:27 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C87322E00;
        Sat, 15 Aug 2020 03:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597460618;
        bh=LWZ3gG05lyWwHbQNUP3ksCUHLVF4wFzI8rRKV3uiNak=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aPLmc5XIVhNgOz/dUkmBwJHhTub2jfiFdCUnXPgEVZvsfdM60xwqSPiHXUjZo/gZg
         W13nLli/i5dcL9+RLLKwoyKEj/1rS4pFIGP+81I7TUivDsE3PPl0LwR+oPRQbUf2eR
         Zq7320V1UEnYBmGlW09/3R0ltEf9DMa1/eUQy5SE=
Received: by mail-ej1-f53.google.com with SMTP id o18so11890552eje.7;
        Fri, 14 Aug 2020 20:03:38 -0700 (PDT)
X-Gm-Message-State: AOAM532l65Y/ZcRSYu08JznzZJX4t0VbxK+0NyP7fgsbMXobqvSx6uR6
        V4hyvhlOtaj5s/12iSBYqiYEfVXTgvT5G9IeYQ==
X-Google-Smtp-Source: ABdhPJyt/63tP7h7Rcip1YksjvsGO7WzFuUVEIVYhoFntsd6TkK7JtmalTJjkuyszotatOlhPqyFfaDNHeccHlw5oaU=
X-Received: by 2002:a17:906:7492:: with SMTP id e18mr5232063ejl.375.1597460616714;
 Fri, 14 Aug 2020 20:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <1597289564-17030-1-git-send-email-neal.liu@mediatek.com> <1597289564-17030-3-git-send-email-neal.liu@mediatek.com>
In-Reply-To: <1597289564-17030-3-git-send-email-neal.liu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 15 Aug 2020 11:03:24 +0800
X-Gmail-Original-Message-ID: <CAAOTY_88YSHOvDEHm+rM1=fTv_y25nUh1tuLUH8YSxH5UD1bug@mail.gmail.com>
Message-ID: <CAAOTY_88YSHOvDEHm+rM1=fTv_y25nUh1tuLUH8YSxH5UD1bug@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] soc: mediatek: add mt6779 devapc driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Neal:

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=8813=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8811:33=E5=AF=AB=E9=81=93=EF=BC=9A
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

[snip]

> +/*
> + * devapc_violation_irq - the devapc Interrupt Service Routine (ISR) wil=
l dump
> + *                        violation information including which master v=
iolates
> + *                        access slave.
> + */
> +static irqreturn_t devapc_violation_irq(int irq_number,
> +                                       struct mtk_devapc_context *ctx)
> +{
> +       /*
> +        * Mask slave's irq before clearing vio status.
> +        * Must do it to avoid nested interrupt and prevent
> +        * unexpected behavior.
> +        */
> +       mask_module_irq(ctx, true);

I still don't understand why nested interrupt happen. If two CPU
process different devapc interrupt at the same time, mask interrupt
could not prevent these two CPU to sync vio dbg at the same time. As I
know, in ARM CPU, only CPU0 process irq handler, and all devapc
interrupt has the same priority, so why nested interrupt happen? Could
you explain more detail about how nested interrupt happen?

> +
> +       while (devapc_sync_vio_dbg(ctx))
> +               devapc_extract_vio_dbg(ctx);
> +
> +       /*
> +        * Ensure that violation info are written
> +        * before further operations
> +        */
> +       smp_mb();
> +
> +       clear_vio_status(ctx);
> +       mask_module_irq(ctx, false);
> +
> +       return IRQ_HANDLED;
> +}
> +

[snip]

> +
> +static int mtk_devapc_remove(struct platform_device *pdev)
> +{
> +       struct mtk_devapc_context *ctx =3D platform_get_drvdata(pdev);
> +
> +       stop_devapc(ctx);
> +
> +       if (ctx->infra_clk)

This always true.

Regards,
Chun-Kuang.

> +               clk_disable_unprepare(ctx->infra_clk);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver mtk_devapc_driver =3D {
> +       .probe =3D mtk_devapc_probe,
> +       .remove =3D mtk_devapc_remove,
> +       .driver =3D {
> +               .name =3D KBUILD_MODNAME,
> +               .of_match_table =3D mtk_devapc_dt_match,
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
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

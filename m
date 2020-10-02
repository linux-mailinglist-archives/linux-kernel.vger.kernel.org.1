Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016B52817D7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388224AbgJBQYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:24:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBQYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:24:24 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFD0F206FA;
        Fri,  2 Oct 2020 16:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601655864;
        bh=XtQ41aWaPx5+LCDrh/lKMRy5xvIsR4YWuY5PCakwRNQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZYOFhNcFXvip8lefRJnbyFaI5/HwfeDCEj0Me6o8cW0aZDd1ptML2xpAHO5wN2Fzt
         gANDZaMG7TxBKVsxxs+eHw7SJRzbJeKapSno5Me62+RcoIAs49KXqkdaKPpP8ZwDp2
         BkhRqVcJ+A80+E7ygmaqaZ0jcoi1zB63H5w75pag=
Received: by mail-ed1-f54.google.com with SMTP id b12so2245591edz.11;
        Fri, 02 Oct 2020 09:24:23 -0700 (PDT)
X-Gm-Message-State: AOAM5315T/swyWw81t001eC4n9lzr4BT3kby/z7Psjw5Pz1KQ+CAzDaH
        9E7HFzGVz+Oy7cGwWl+bER4C4yo43USYCEQszg==
X-Google-Smtp-Source: ABdhPJyN//4Cvislw//mSBvfQZBNuVjL4cllDiY+cszv6mSEUbslgvX+YzhtpkT4+KNZyrMAfQjtD7p7+MGd7rEHeu0=
X-Received: by 2002:aa7:cd56:: with SMTP id v22mr393465edw.49.1601655862471;
 Fri, 02 Oct 2020 09:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <1598497593-15781-1-git-send-email-neal.liu@mediatek.com> <1598497593-15781-3-git-send-email-neal.liu@mediatek.com>
In-Reply-To: <1598497593-15781-3-git-send-email-neal.liu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 3 Oct 2020 00:24:11 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-KTs6-5ZpzAWs0Yn-R3AJc8tRhDyKbp8bx60EJtfu-_Q@mail.gmail.com>
Message-ID: <CAAOTY_-KTs6-5ZpzAWs0Yn-R3AJc8tRhDyKbp8bx60EJtfu-_Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] soc: mediatek: add mt6779 devapc driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Neal:

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=8827=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8811:07=E5=AF=AB=E9=81=93=EF=BC=9A
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
>  drivers/soc/mediatek/mtk-devapc.c |  305 +++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 315 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mtk-devapc.c
>

[snip]

> +
> +static int mtk_devapc_probe(struct platform_device *pdev)
> +{
> +       struct device_node *node =3D pdev->dev.of_node;
> +       struct mtk_devapc_context *ctx;
> +       u32 devapc_irq;
> +       int ret;
> +
> +       if (IS_ERR(node))
> +               return -ENODEV;
> +
> +       ctx =3D devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
> +       if (!ctx)
> +               return -ENOMEM;
> +
> +       ctx->data =3D of_device_get_match_data(&pdev->dev);
> +       ctx->dev =3D &pdev->dev;
> +
> +       ctx->infra_base =3D of_iomap(node, 0);
> +       if (!ctx->infra_base)
> +               return -EINVAL;
> +
> +       devapc_irq =3D irq_of_parse_and_map(node, 0);
> +       if (!devapc_irq)
> +               return -EINVAL;
> +
> +       ctx->infra_clk =3D devm_clk_get(&pdev->dev, "devapc-infra-clock")=
;
> +       if (IS_ERR(ctx->infra_clk))
> +               return -EINVAL;
> +
> +       if (clk_prepare_enable(ctx->infra_clk))
> +               return -EINVAL;

What would happen if you do not enable this clock? I think this
hardware is already initialized in trust zone.

Regards,
Chun-Kuang.

> +
> +       ret =3D devm_request_irq(&pdev->dev, devapc_irq,
> +                              (irq_handler_t)devapc_violation_irq,
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

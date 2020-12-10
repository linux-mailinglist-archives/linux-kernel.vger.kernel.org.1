Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D8C2D601C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403784AbgLJPll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:41:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391934AbgLJPlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:41:39 -0500
X-Gm-Message-State: AOAM533WBjJCglQTAFmX3DJhBukCoVLZIISGRCX5T4jrUSk93emkXuUo
        6Ylb+JVbudODLcN4LSD+Eu2AD+LQVoM6J8toKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607614857;
        bh=kLtdmt4oMcr69ZeEaGpqsEmfBzPYipCBB3bI8s06kKQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GVcosNOtUN4j/bxX47UVlveHVCGqW8i9QaQZ6HkPlxWC3uYI0yv+Gz8C/CmsFnuUh
         VHH6yRauv30XoxLjQP5qjpc9eNzgSOp8wiOZEFUefda4NKkf4zSwZUnhmpq04/8qxC
         32fwTWovPXPS9Zl/un6zRImWeQV8nhGgzN3F5iIYbeGf1eXyg6AGD8bzI0PSh1xxtT
         9pvdLYb2YwC3PrITFjio+/qf16+/CeVjxca6hB5cvpEs7nUm2sAyern7NBYbJbdmYr
         ITHCpGuWGMKHJQ91R/TmXQHkCPjo0M+0pbylEP5aNu4c0HmGWu90CNCtWfpWtSUrDu
         wYrkLofnlRiIg==
X-Google-Smtp-Source: ABdhPJx0j+Lqm6Jk4mCnuNpLmDuRmlHsWfRP57mzErtMeTRrN6xR9D9GsxcZ0189bugqUjaw7RdnSXryhX8yUPqWXoM=
X-Received: by 2002:a17:906:a106:: with SMTP id t6mr7055105ejy.63.1607614855174;
 Thu, 10 Dec 2020 07:40:55 -0800 (PST)
MIME-Version: 1.0
References: <1607591262-21736-1-git-send-email-yongqiang.niu@mediatek.com> <1607591262-21736-2-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1607591262-21736-2-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 10 Dec 2020 23:40:44 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-oL+NyzDKssCjyP=E8Py3oyEK6a6s=XoYvTFymZE9-zQ@mail.gmail.com>
Message-ID: <CAAOTY_-oL+NyzDKssCjyP=E8Py3oyEK6a6s=XoYvTFymZE9-zQ@mail.gmail.com>
Subject: Re: [PATCH v8, 1/6] dt-bindings: mediatek: add rdma_fifo_size
 description for mt8183 display
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B412=E6=9C=
=8810=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:22=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> rdma fifo size may be different even in same SOC, add this
> property to the corresponding rdma
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  .../bindings/display/mediatek/mediatek,disp.txt          | 16 ++++++++++=
++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp=
.txt
> index 1212207..64c64ee 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t
> @@ -66,6 +66,13 @@ Required properties (DMA function blocks):
>    argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.t=
xt
>    for details.
>
> +Optional properties (RDMA function blocks):
> +- mediatek,rdma_fifo_size: rdma fifo size may be different even in same =
SOC, add this
> +  property to the corresponding rdma
> +  the value is the Max value which defined in hardware data sheet.
> +  rdma_fifo_size of rdma0 in mt8183 is 5120
> +  rdma_fifo_size of rdma1 in mt8183 is 2048
> +
>  Examples:
>
>  mmsys: clock-controller@14000000 {
> @@ -207,3 +214,12 @@ od@14023000 {
>         power-domains =3D <&scpsys MT8173_POWER_DOMAIN_MM>;
>         clocks =3D <&mmsys CLK_MM_DISP_OD>;
>  };
> +
> +rdma1: rdma@1400c000 {
> +       compatible =3D "mediatek,mt8183-disp-rdma";
> +       reg =3D <0 0x1400c000 0 0x1000>;
> +       interrupts =3D <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
> +       power-domains =3D <&scpsys MT8183_POWER_DOMAIN_DISP>;
> +       clocks =3D <&mmsys CLK_MM_DISP_RDMA1>;
> +       mediatek,rdma_fifo_size =3D <2048>;
> +};

In [1], Rob has suggest that not add example of rdma1, it's better to
add mediatek,rdma_fifo_size in rdma0 for example.

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/1596855231-57=
82-2-git-send-email-yongqiang.niu@mediatek.com/

Regards,
Chun-Kuang.

> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

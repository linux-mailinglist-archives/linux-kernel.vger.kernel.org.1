Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134222ECD5E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbhAGJzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:55:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:50282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbhAGJzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:55:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD20923341;
        Thu,  7 Jan 2021 09:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610013271;
        bh=9pBng+AVEqLNZFQoFpUKzynC7ullL0lxTHI0rs1FDo4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b0kXrzJiWBzfthx6ighlPCQeNzGK0Pjy47IRrfuWCSaFdvt/ETQWsIzFhfsXP/V8S
         JncbvQ0z5n/yWSgDWiq8AEsqDuNc2TXiySr14pHtRqhHdCictbQzGcUNXlp3Rfm/nq
         nOlKbli2L0u0KTePIWH2+645lgunZZVMGLuNXopE5Z46p5usG0WWaY/8V/kHeKK8f7
         s84kWEt2r3xxQhVudPfVBQuszn0+QzOdM0iO6m/LPUfHdTr1U7i0QMJTMk93DpW95u
         bJmUp66tpgHr/guasp8OfTGLavYtFuGm77fmr5utx0+a/HCUnsdEzucf3qNM7CvZB6
         aQx4LSR5JNNhQ==
Received: by mail-ej1-f53.google.com with SMTP id w1so8759589ejf.11;
        Thu, 07 Jan 2021 01:54:30 -0800 (PST)
X-Gm-Message-State: AOAM533u6goVsYZRcgJ1f+isalL0OjAsWMGPhxGq6wKYw570USxU6TBT
        9/HHHNGQAh1EcbSCvG/2iW3EPJnFj1v43nHchg==
X-Google-Smtp-Source: ABdhPJwb3idVQRWQCrmNfDclIJoa1CSuPbDunAFSX4HX9CXgW142tjcm1t3p9B86xQsdcyQdWANVKIAM8+nvB3sqyHY=
X-Received: by 2002:a17:906:fb1a:: with SMTP id lz26mr5714887ejb.194.1610013269189;
 Thu, 07 Jan 2021 01:54:29 -0800 (PST)
MIME-Version: 1.0
References: <1609989081-29353-1-git-send-email-yongqiang.niu@mediatek.com> <1609989081-29353-2-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1609989081-29353-2-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 7 Jan 2021 17:54:17 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9FdLrZyKpgAsuJQxORh7uHhjYBn8Acu_1B0vQ0Uv_Nzw@mail.gmail.com>
Message-ID: <CAAOTY_9FdLrZyKpgAsuJQxORh7uHhjYBn8Acu_1B0vQ0Uv_Nzw@mail.gmail.com>
Subject: Re: [PATCH v9, 01/11] dt-bindings: mediatek: add rdma-fifo-size
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
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=
=887=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8811:11=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> rdma fifo size may be different even in same SOC, add this
> property to the corresponding rdma

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,disp.txt       | 9 +++=
++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp=
.txt
> index 33977e1..b07881e 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t
> @@ -66,6 +66,14 @@ Required properties (DMA function blocks):
>    argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.t=
xt
>    for details.
>
> +Optional properties (RDMA function blocks):
> +- mediatek,rdma-fifo-size: rdma fifo size may be different even in same =
SOC, add this
> +  property to the corresponding rdma
> +  the value is the Max value which defined in hardware data sheet.
> +  mediatek,rdma-fifo-size of mt8173-rdma0 is 8K
> +  mediatek,rdma-fifo-size of mt8183-rdma0 is 5K
> +  mediatek,rdma-fifo-size of mt8183-rdma1 is 2K
> +
>  Examples:
>
>  mmsys: clock-controller@14000000 {
> @@ -103,6 +111,7 @@ rdma0: rdma@1400e000 {
>         clocks =3D <&mmsys CLK_MM_DISP_RDMA0>;
>         iommus =3D <&iommu M4U_PORT_DISP_RDMA0>;
>         mediatek,larb =3D <&larb0>;
> +       mediatek,rdma-fifosize =3D <8192>;
>  };
>
>  rdma1: rdma@1400f000 {
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5429D2ECD64
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbhAGJ7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:59:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbhAGJ7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:59:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 259042312F;
        Thu,  7 Jan 2021 09:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610013505;
        bh=/IoyTbDRYdITqQ/ehLHHAr5zNu/uV79exeCn/3qbm4w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FhvFdx7YQqNX76DDQy8bm+QZG3FlLsKv+uvGJTWd+AYLs9DhEmarC2ooCBsWQoMj4
         d/ovB12fQV1lTPXUgTj82hkh4qH+KoDC8BgkjGzKR+hFWJNKdL/CfhtgcXA9RtTgf/
         f1yk/U/8+LQYLbF3rQjfmtKEuKS+p3voXHeiqfmU1LgwgqeG+g+iFrg64bjrgrCn6C
         AllCy1ilu5q5qviydFwac88yWMU4pu99tBPXhHaA4+OK0gEOLgMEJB6yYq9zvUPgKv
         UWamxX+fyPJoLqK5EAc0hjic7m0+L+B7PJDi3c6k88s/UcS2+PuJCH8l79jeiye57I
         cheAhGLJtsMBw==
Received: by mail-ed1-f52.google.com with SMTP id b2so7216417edm.3;
        Thu, 07 Jan 2021 01:58:25 -0800 (PST)
X-Gm-Message-State: AOAM533JCNEY0MvWKIFtANNJBwNYFSFL7gHl+L0EWiaGKUt31YTTFEk3
        f5Yok8687i2KYO6FzbFN5AaD7mqTnMq9xkQl7g==
X-Google-Smtp-Source: ABdhPJzuagogH0mSid9kt6qBlxG0IYM9hSJgtHkS+RyfrWE+l+JBeR+fcJikBQGl7vUlVHVFXv4wKYgD3LkjJMNaChA=
X-Received: by 2002:a05:6402:3048:: with SMTP id bu8mr1091459edb.49.1610013503677;
 Thu, 07 Jan 2021 01:58:23 -0800 (PST)
MIME-Version: 1.0
References: <1609989081-29353-1-git-send-email-yongqiang.niu@mediatek.com> <1609989081-29353-4-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1609989081-29353-4-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 7 Jan 2021 17:58:12 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9aD1ZjVMZbQxL17HTz5fCP7-paZbx-ybMVAJ7QLrVydg@mail.gmail.com>
Message-ID: <CAAOTY_9aD1ZjVMZbQxL17HTz5fCP7-paZbx-ybMVAJ7QLrVydg@mail.gmail.com>
Subject: Re: [PATCH v9, 03/11] arm64: dts: mt8183: rename rdma fifo size
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
=887=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8811:12=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> property name must include only lowercase and '-'

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8183.dtsi
> index 5b782a4..6c84ccb7 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1011,7 +1011,7 @@
>                         clocks =3D <&mmsys CLK_MM_DISP_RDMA0>;
>                         iommus =3D <&iommu M4U_PORT_DISP_RDMA0>;
>                         mediatek,larb =3D <&larb0>;
> -                       mediatek,rdma_fifo_size =3D <5120>;
> +                       mediatek,rdma-fifo-size =3D <5120>;
>                         mediatek,gce-client-reg =3D <&gce SUBSYS_1400XXXX=
 0xb000 0x1000>;
>                 };
>
> @@ -1023,7 +1023,7 @@
>                         clocks =3D <&mmsys CLK_MM_DISP_RDMA1>;
>                         iommus =3D <&iommu M4U_PORT_DISP_RDMA1>;
>                         mediatek,larb =3D <&larb0>;
> -                       mediatek,rdma_fifo_size =3D <2048>;
> +                       mediatek,rdma-fifo-size =3D <2048>;
>                         mediatek,gce-client-reg =3D <&gce SUBSYS_1400XXXX=
 0xc000 0x1000>;
>                 };
>
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

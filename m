Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA4B2EE9BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 00:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbhAGX1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 18:27:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:55122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbhAGX1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 18:27:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F96F23715;
        Thu,  7 Jan 2021 23:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610062024;
        bh=m7RW9HBtqQnfdINbdCHqEB+pyy8sssGGLdn1klRTWl4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gT80uxAxXHcdu8ANm4X/DEVzQeUX4d9Xzi4EyFcd2Ykoyn1JnHjE6IUi73B7hwBng
         TniP8Jqu0BEvWq+jm3pKWDRd6eBQmKFdPSEmOHGAGo2ugRzzb+p2Hb8CjG1b3AE7ZF
         6p9ClqBeZO/di4+CpDsIeM4MtyiX1e99RbIuKAHypqNG0rmplxPbOWGg9/bcOVr0Sj
         yNOuBTaAQJcrCcPmKCdXKmuh3+7tVEmMPGwACG7S4zhdeNtZb+QnVlXhU+tQ5a5XDm
         +KPOF84EebCj/bdCaRm0oIinNJd8WO8rIszZ0UDn/GQlU+mefjg2g7g6N/VOLwAGhG
         8Wr8IeoPANQKg==
Received: by mail-wm1-f53.google.com with SMTP id 3so6912502wmg.4;
        Thu, 07 Jan 2021 15:27:04 -0800 (PST)
X-Gm-Message-State: AOAM533I3sF6/CPG+IyPE5nxV57CfSwh8ZaSVJTqMpaVb+Z8tc4Os1qm
        5Qr1bmeNg/No7wy5pdIS4U3LzNGpxru0feBVMg==
X-Google-Smtp-Source: ABdhPJzS3UQ0x/poF8FnNPQV3fPhB+gtHlyJACLspO4RjxuVplYpY3mxzHHqv7Jv/wY6lB6d7fYsmOrLxCypguDO4Us=
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr663344wmi.45.1610062022818;
 Thu, 07 Jan 2021 15:27:02 -0800 (PST)
MIME-Version: 1.0
References: <20210107143352.50090-1-jitao.shi@mediatek.com>
In-Reply-To: <20210107143352.50090-1-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 8 Jan 2021 07:26:50 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-7PiBGPE57OiAVDbq5hRLFunKX-v-h5UUS4v9Q7SuH=g@mail.gmail.com>
Message-ID: <CAAOTY_-7PiBGPE57OiAVDbq5hRLFunKX-v-h5UUS4v9Q7SuH=g@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: dsi: Fix EoTp flag
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        huijuan.xie@mediatek.com, stonea168@163.com,
        cawa.cheng@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jitao:

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=887=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8810:34=E5=AF=AB=E9=81=93=EF=BC=9A
>
> SoC will transmit the EoTp (End of Transmission packet) when
> MIPI_DSI_MODE_EOT_PACKET flag is set.
>
> Enabling EoTp will make the line time larger, so the hfp and
> hbp should be reduced to keep line time.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 65fd99c528af..8c70ec39bfe1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -401,8 +401,11 @@ static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi=
)
>                 break;
>         }
>
> -       tmp_reg |=3D (dsi->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) <<=
 6;
> -       tmp_reg |=3D (dsi->mode_flags & MIPI_DSI_MODE_EOT_PACKET) >> 3;
> +       if (dsi->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS)
> +               tmp_reg |=3D HSTX_CKLP_EN;
> +
> +       if (!(dsi->mode_flags & MIPI_DSI_MODE_EOT_PACKET))
> +               tmp_reg |=3D DIS_EOT;

This part is not related to line time, so separate this part to another pat=
ch.

Regards,
Chun-Kuang.

>
>         writel(tmp_reg, dsi->regs + DSI_TXRX_CTRL);
>  }
> @@ -478,6 +481,7 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi =
*dsi)
>                           timing->da_hs_zero + timing->da_hs_exit + 3;
>
>         delta =3D dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST ? 18 : 12;
> +       delta +=3D dsi->mode_flags & MIPI_DSI_MODE_EOT_PACKET ? 2 : 0;
>
>         horizontal_frontporch_byte =3D vm->hfront_porch * dsi_tmp_buf_bpp=
;
>         horizontal_front_back_byte =3D horizontal_frontporch_byte + horiz=
ontal_backporch_byte;
> --
> 2.25.1
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

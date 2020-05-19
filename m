Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E3A1D9AE0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 17:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbgESPNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 11:13:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728775AbgESPNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 11:13:00 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D84832083E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589901180;
        bh=Qtbu//gwpsRgyyl9L3XkraCEI0EULn3K3RbouB9xCeQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jpt+oYEr/qLu8YKDUQL8P9cwVuslDQk/015dkdkhmsDRvEfaZtFD4uA1yKlYIYne8
         y47NLk9GyDnv+rTz3Jeuatg8RFxszmBvD4CUBHFaLvXDWHBGCz6HCGmaM6g1RiVCJp
         2AeoGrgrAa+hzL2tngLpK22kKiZ60Pq1WRzfandA=
Received: by mail-ed1-f43.google.com with SMTP id i16so7339446edv.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 08:12:59 -0700 (PDT)
X-Gm-Message-State: AOAM532NPoB+IT9MndIKrDOVQY5ryr5oABlQnJNwZvP+kOFN6DdHl4kX
        LsuCDRhbiKIkeLKhEpkJev8RkfcvGHezIT1HDg==
X-Google-Smtp-Source: ABdhPJyFxb862sEE7yUUw8vzjALBePQs+s7LW5KIAbQcfYVO9A/nJbgo93p98Hnk05Kl1tbTOxD4nL6FFB/3FC4K5Eo=
X-Received: by 2002:a50:e1c5:: with SMTP id m5mr12614504edl.47.1589901178288;
 Tue, 19 May 2020 08:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200519094045.2447940-1-enric.balletbo@collabora.com>
In-Reply-To: <20200519094045.2447940-1-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 19 May 2020 23:12:46 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-m67cCrrgb=Ot9gnj22Ks3qDCDFQhELMA=m0xSB9mwWQ@mail.gmail.com>
Message-ID: <CAAOTY_-m67cCrrgb=Ot9gnj22Ks3qDCDFQhELMA=m0xSB9mwWQ@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: mtk_mt8173_hdmi_phy: Remove unnused const variables
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Enric:

Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=B9=
=B45=E6=9C=8819=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:40=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> There are some `static const u8` variables that are not used, this
> triggers a warning building with `make W=3D1`, it is safe to remove them,
> so do it and make the compiler more happy.
>

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  .../gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c    | 48 -------------------
>  1 file changed, 48 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/gpu=
/drm/mediatek/mtk_mt8173_hdmi_phy.c
> index 1c3575372230..827b93786fac 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> @@ -107,54 +107,6 @@
>  #define RGS_HDMITX_5T1_EDG             (0xf << 4)
>  #define RGS_HDMITX_PLUG_TST            BIT(0)
>
> -static const u8 PREDIV[3][4] =3D {
> -       {0x0, 0x0, 0x0, 0x0},   /* 27Mhz */
> -       {0x1, 0x1, 0x1, 0x1},   /* 74Mhz */
> -       {0x1, 0x1, 0x1, 0x1}    /* 148Mhz */
> -};
> -
> -static const u8 TXDIV[3][4] =3D {
> -       {0x3, 0x3, 0x3, 0x2},   /* 27Mhz */
> -       {0x2, 0x1, 0x1, 0x1},   /* 74Mhz */
> -       {0x1, 0x0, 0x0, 0x0}    /* 148Mhz */
> -};
> -
> -static const u8 FBKSEL[3][4] =3D {
> -       {0x1, 0x1, 0x1, 0x1},   /* 27Mhz */
> -       {0x1, 0x0, 0x1, 0x1},   /* 74Mhz */
> -       {0x1, 0x0, 0x1, 0x1}    /* 148Mhz */
> -};
> -
> -static const u8 FBKDIV[3][4] =3D {
> -       {19, 24, 29, 19},       /* 27Mhz */
> -       {19, 24, 14, 19},       /* 74Mhz */
> -       {19, 24, 14, 19}        /* 148Mhz */
> -};
> -
> -static const u8 DIVEN[3][4] =3D {
> -       {0x2, 0x1, 0x1, 0x2},   /* 27Mhz */
> -       {0x2, 0x2, 0x2, 0x2},   /* 74Mhz */
> -       {0x2, 0x2, 0x2, 0x2}    /* 148Mhz */
> -};
> -
> -static const u8 HTPLLBP[3][4] =3D {
> -       {0xc, 0xc, 0x8, 0xc},   /* 27Mhz */
> -       {0xc, 0xf, 0xf, 0xc},   /* 74Mhz */
> -       {0xc, 0xf, 0xf, 0xc}    /* 148Mhz */
> -};
> -
> -static const u8 HTPLLBC[3][4] =3D {
> -       {0x2, 0x3, 0x3, 0x2},   /* 27Mhz */
> -       {0x2, 0x3, 0x3, 0x2},   /* 74Mhz */
> -       {0x2, 0x3, 0x3, 0x2}    /* 148Mhz */
> -};
> -
> -static const u8 HTPLLBR[3][4] =3D {
> -       {0x1, 0x1, 0x0, 0x1},   /* 27Mhz */
> -       {0x1, 0x2, 0x2, 0x1},   /* 74Mhz */
> -       {0x1, 0x2, 0x2, 0x1}    /* 148Mhz */
> -};
> -
>  static int mtk_hdmi_pll_prepare(struct clk_hw *hw)
>  {
>         struct mtk_hdmi_phy *hdmi_phy =3D to_mtk_hdmi_phy(hw);
> --
> 2.26.2
>

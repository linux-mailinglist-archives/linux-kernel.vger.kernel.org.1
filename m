Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A74E2C7195
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390863AbgK1Vvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:51:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:48382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730379AbgK1Sv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:51:56 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97B19222C4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 09:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606554021;
        bh=tCh3C64HLBruiQe7woUJh3PomiEkJaLuMsK2cYyZ3AE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f0Th5J3kNwanqwLrsUfcFVjKjBzG0T5dTMjmemdj2OHzf3R85LAQ5cvSp9donQn1q
         Da3O0EVQmMoPGwAkX8Q7/8OWXsu2pcL9ecIE8qQkDssINevLLPWWAEDfpQLrs9VO9q
         k0G2OrM0FzU/FxBRyGq71l4ts5SlyrbXAPQ5itYs=
Received: by mail-wr1-f53.google.com with SMTP id m6so7963829wrg.7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 01:00:21 -0800 (PST)
X-Gm-Message-State: AOAM530je1oN6mOyz+0K5BIPdqsfojlNwwYleXYZNFH1S9i3NIb0yRwS
        wBw2FaYpr/kRru50pppqlABByuJbZ5N60irL/Q==
X-Google-Smtp-Source: ABdhPJwaGpEa4Ug6G0e4ekBFpVOFIur24PSU0U73IWrhh0O8+yKHfKhXm6k7CY8fPX51ghX7CTQgvKr1wmwXSEjAldg=
X-Received: by 2002:adf:c147:: with SMTP id w7mr16556337wre.60.1606554020099;
 Sat, 28 Nov 2020 01:00:20 -0800 (PST)
MIME-Version: 1.0
References: <20201127110204.1984789-1-enric.balletbo@collabora.com>
In-Reply-To: <20201127110204.1984789-1-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 28 Nov 2020 17:00:08 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9udVi7s5HoB+4SMNsTRQp9WPnHXLhz8b0CCWzW73BNSw@mail.gmail.com>
Message-ID: <CAAOTY_9udVi7s5HoB+4SMNsTRQp9WPnHXLhz8b0CCWzW73BNSw@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Use correct aliases name for ovl
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Enric:

Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=B9=
=B411=E6=9C=8827=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=887:02=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> Aliases property name must include only lowercase and '-', so fix this
> in the driver, so we're not tempted to do "ovl_2l0 =3D &ovl_2l0" in the
> device-tree instead of the right one which is "ovl-2l0 =3D &ovl_2l0".
>

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

> Fixes: dd8feb2262d9 ("drm/mediatek: add component OVL_2L1")
> Fixes: b17bdd0d7a73 ("drm/mediatek: add component OVL_2L0")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index 8eba44be3a8a..3064eac1a750 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -359,7 +359,7 @@ static const struct mtk_ddp_comp_funcs ddp_ufoe =3D {
>
>  static const char * const mtk_ddp_comp_stem[MTK_DDP_COMP_TYPE_MAX] =3D {
>         [MTK_DISP_OVL] =3D "ovl",
> -       [MTK_DISP_OVL_2L] =3D "ovl_2l",
> +       [MTK_DISP_OVL_2L] =3D "ovl-2l",
>         [MTK_DISP_RDMA] =3D "rdma",
>         [MTK_DISP_WDMA] =3D "wdma",
>         [MTK_DISP_COLOR] =3D "color",
> --
> 2.29.2
>

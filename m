Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6077B29514F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 19:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503363AbgJURHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 13:07:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390995AbgJURHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 13:07:18 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19852223C6;
        Wed, 21 Oct 2020 17:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603300037;
        bh=cmX/YO3xz5pAF8CH4Yv2e+wNRl4pkQd8JHkdyLyXh1A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uul/3MRW1yCz1Mj6OHpN7L03VExvPsGkMsRM10hBPxslr6UgE2cIwbYwiJ6/srP9X
         eIJ0xDyWl5glw48AD5rG8IcPylxHA8AD7VQGdMeYPeEsPhfUYA6gLMq2yle8ZFkl1F
         +ZxctGWTnlfLf3f94y4EC0kzdcu+cJao5JZ8m0r0=
Received: by mail-ej1-f45.google.com with SMTP id w27so385962ejb.3;
        Wed, 21 Oct 2020 10:07:17 -0700 (PDT)
X-Gm-Message-State: AOAM530U2VPHVxEFvZGOH9fuSmaia6Ra+NhUL4CeTAs/hHS2Y+Nn0jO8
        9sYzNQ6JSCKiB30A52rRL9jdhK8Mi4YSRjofHg==
X-Google-Smtp-Source: ABdhPJzkI1tdwAjD8c04bQdTDw9wZakzcNHkiciym4rO8nnPUMoynFasWgKThhVCIRKLRPIRtHqBKCELzLsq4X0lGu8=
X-Received: by 2002:a17:906:95d1:: with SMTP id n17mr4668586ejy.75.1603300035519;
 Wed, 21 Oct 2020 10:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201020174253.3757771-1-fparent@baylibre.com> <20201020174253.3757771-5-fparent@baylibre.com>
In-Reply-To: <20201020174253.3757771-5-fparent@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 22 Oct 2020 01:07:04 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9Y98yHq7GcypUMryG4jMEdrDJeCeRXEKX3mb5g39y+sg@mail.gmail.com>
Message-ID: <CAAOTY_9Y98yHq7GcypUMryG4jMEdrDJeCeRXEKX3mb5g39y+sg@mail.gmail.com>
Subject: Re: [PATCH 4/8] drm/mediatek: dsi: add pdata variable to start clk in
 HS mode
To:     Fabien Parent <fparent@baylibre.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Fabien:

Fabien Parent <fparent@baylibre.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=8821=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=881:43=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On MT8167, DSI seems to work fine only if we start the clk in HS mode.
> If we don't start the clk in HS but try to switch later to HS, the
> display does not work.
>
> This commit adds a platform data variable to be used to start the
> DSI clk in HS mode at power on.

This patch looks like a hack patch. If you cowork with Mediatek,
please find out the correct solution or give a reasonable explanation.
If you could not get help from Mediatek, I would wait for comment on
this patch.

Regards,
Chun-Kuang.

>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 4a188a942c38..461643c05689 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -175,6 +175,7 @@ struct mtk_dsi_driver_data {
>         const u32 reg_cmdq_off;
>         bool has_shadow_ctl;
>         bool has_size_ctl;
> +       bool use_hs_on_power_on;
>  };
>
>  struct mtk_dsi {
> @@ -671,7 +672,7 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>
>         mtk_dsi_clk_ulp_mode_leave(dsi);
>         mtk_dsi_lane0_ulp_mode_leave(dsi);
> -       mtk_dsi_clk_hs_mode(dsi, 0);
> +       mtk_dsi_clk_hs_mode(dsi, !!dsi->driver_data->use_hs_on_power_on);
>
>         return 0;
>  err_disable_engine_clk:
> --
> 2.28.0
>

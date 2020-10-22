Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C344529630C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2902027AbgJVQtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898045AbgJVQtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:49:06 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1E4C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 09:49:06 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id b15so2324811iod.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 09:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kojjrYIgLi9atE3HNeKW+cJYZwBv9lJxNp3JGQTWaRE=;
        b=K5mKBqv7cFoRmE22R/SIBPXgp7gvRB4sBDus74dJx6EmpRVudHOEVDoogQnspJqgXK
         H1+0glvjt/unvvGqucop/d2nz3n2nfx33WbtnVA4BnPNI3dcL6JkqJ0qQt6UpV8EKYPJ
         rWS6KSPUHGtGC3xjgm5Cw4sKACUyGO902TBx2Y/N6g9Y56VbPw0jbMXl344rCGF9OZig
         Hv/Dp4/6U4Cdajs5wMQNivLMVRiVubZij2UhC7tylU1qo6fpuSee2/6nhkK7heeaHm59
         7Xp9pYjYEPMby7cdkhG6LVymKnqxEu/fvw0AQke7RKF7pfK1vx8NMgnB0ynKi+oPPaE3
         wI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kojjrYIgLi9atE3HNeKW+cJYZwBv9lJxNp3JGQTWaRE=;
        b=GiNXFZEZG5sOV3Co0hCI338YhG7UR8jSgGiR0vbb+J00LlYocBbJjMF/kvyC0HKcDx
         ehdqnsL0eCCTW1QvCcoeqd3NlerUAVUr2YEryrxX2FEovN7SLjKVN2U8sla2gtuhVjaQ
         pIjiaxkbAt7+ZEU4qp7IEmLYKutAiQSaDPb1hv6ERf7Uc51G05kUmY0+cfbllsEeoYZ/
         L8aMXy5aNVCvfbEvG2WzYE/OXLlVpPCDodNGwuzpCieiVtRMcb+46IzANuN9zYqEDIqQ
         1H4CIZfonYhQA5Qosck04k3ZWCo2Zc8eF8L8+T1OxGZjEuHvW1UiAfD/vPhhpNO3ACiT
         Bf3w==
X-Gm-Message-State: AOAM530TqaMrbSyDuniq9z4yXY5bYMsI4dOhvK6yRg6p0QubaGZpTN8X
        QlCz95Y7+8fblJzVuykQCfXWdKEEXm6kWfXSt9x9yA==
X-Google-Smtp-Source: ABdhPJzzXab4wojjo0aZU7//8U9GW/iQAWpNHIt2AGa+iJXMyyAIuiUtYo/vxW5cBuLPfvukrTY8jeMKX0DFbYpGYeg=
X-Received: by 2002:a5e:c112:: with SMTP id v18mr2520610iol.195.1603385345691;
 Thu, 22 Oct 2020 09:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201020174253.3757771-1-fparent@baylibre.com>
 <20201020174253.3757771-5-fparent@baylibre.com> <CAAOTY_9Y98yHq7GcypUMryG4jMEdrDJeCeRXEKX3mb5g39y+sg@mail.gmail.com>
In-Reply-To: <CAAOTY_9Y98yHq7GcypUMryG4jMEdrDJeCeRXEKX3mb5g39y+sg@mail.gmail.com>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Thu, 22 Oct 2020 18:48:54 +0200
Message-ID: <CAOwMV_yybF9j6GZpHfz3WjAHSQhQo=Ot+2frSkN6dpODe3nwCQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] drm/mediatek: dsi: add pdata variable to start clk in
 HS mode
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
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
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Kuang,

On Wed, Oct 21, 2020 at 7:07 PM Chun-Kuang Hu <chunkuang.hu@kernel.org> wro=
te:
>
> Hi, Fabien:
>
> Fabien Parent <fparent@baylibre.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=8821=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=881:43=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > On MT8167, DSI seems to work fine only if we start the clk in HS mode.
> > If we don't start the clk in HS but try to switch later to HS, the
> > display does not work.
> >
> > This commit adds a platform data variable to be used to start the
> > DSI clk in HS mode at power on.
>
> This patch looks like a hack patch. If you cowork with Mediatek,
> please find out the correct solution or give a reasonable explanation.
> If you could not get help from Mediatek, I would wait for comment on
> this patch.

It seems that this workaround is because of a specific display and not
because of a specific issue of the MT8167 DSI IP. I will drop this
patch in v2.

> Regards,
> Chun-Kuang.
>
> >
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/media=
tek/mtk_dsi.c
> > index 4a188a942c38..461643c05689 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -175,6 +175,7 @@ struct mtk_dsi_driver_data {
> >         const u32 reg_cmdq_off;
> >         bool has_shadow_ctl;
> >         bool has_size_ctl;
> > +       bool use_hs_on_power_on;
> >  };
> >
> >  struct mtk_dsi {
> > @@ -671,7 +672,7 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
> >
> >         mtk_dsi_clk_ulp_mode_leave(dsi);
> >         mtk_dsi_lane0_ulp_mode_leave(dsi);
> > -       mtk_dsi_clk_hs_mode(dsi, 0);
> > +       mtk_dsi_clk_hs_mode(dsi, !!dsi->driver_data->use_hs_on_power_on=
);
> >
> >         return 0;
> >  err_disable_engine_clk:
> > --
> > 2.28.0
> >

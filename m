Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D342BBE7E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 11:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgKUKh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 05:37:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbgKUKh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 05:37:58 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E82322254
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 10:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605955076;
        bh=0iPSg8OjIQe2EwLNb/s9nIdiFuPHQuOfmsC85sp8jCg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z8BGdgIZyJ89SBcXgRK/tQq1W75b7JbcAUk64naWQM60X7zxB3U0u+eh/aukIsBcs
         ulcPuega36oBIlk4axL2h29qK/76dqZaIjhWtayHaP1spkrX2rnMnpyep3hrPxZgS+
         fcreDNGBKMBfMLBGPwGBCpgtNvsQHBhhEVCVAIqg=
Received: by mail-wr1-f53.google.com with SMTP id m6so13452957wrg.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 02:37:56 -0800 (PST)
X-Gm-Message-State: AOAM532AZRgHQXnoS230HptvTmQ5HOGuuulGhHK1zLnOYIhvtJcMbEPH
        nGuvsJLPidfiovjylk5H1IqnJlb90exnTN1ZHw==
X-Google-Smtp-Source: ABdhPJwp4mVAZqzRDcuKqvKnD+d0FY5VtF17c3UkrCjWQfKRDx+PjqKzlAeeWBvohP0VqYKp57XUz0y81glkncyvErg=
X-Received: by 2002:a5d:6689:: with SMTP id l9mr19872241wru.134.1605955074930;
 Sat, 21 Nov 2020 02:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20201119232335.6704-1-chunkuang.hu@kernel.org> <20201120052950.0ca597fb@a-VirtualBox>
In-Reply-To: <20201120052950.0ca597fb@a-VirtualBox>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 21 Nov 2020 18:37:42 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8yS=c3052vCTtD53oz0bx6gQkCG9b-SvZR0oCznLUx1A@mail.gmail.com>
Message-ID: <CAAOTY_8yS=c3052vCTtD53oz0bx6gQkCG9b-SvZR0oCznLUx1A@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: dsi: Modify horizontal front/back porch
 byte formula
To:     Bilal Wasim <bilalwasim676@gmail.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, CK Hu <ck.hu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bilal Wasim <bilalwasim676@gmail.com> =E6=96=BC 2020=E5=B9=B411=E6=9C=8820=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=888:30=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi CK,
>
> On Fri, 20 Nov 2020 07:23:35 +0800
> Chun-Kuang Hu <chunkuang.hu@kernel.org> wrote:
>
> > From: CK Hu <ck.hu@mediatek.com>
> >
> > In the patch to be fixed, horizontal_backporch_byte become to large
> > for some panel, so roll back that patch. For small hfp or hbp panel,
> > using vm->hfront_porch + vm->hback_porch to calculate
> > horizontal_backporch_byte would make it negtive, so
> > use horizontal_backporch_byte itself to make it positive.

Applied to mediatek-drm-fixes [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

> >
> > Fixes: 35bf948f1edb ("drm/mediatek: dsi: Fix scrolling of panel with
> > small hfp or hbp")
> >
> > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c | 61
> > +++++++++++------------------- 1 file changed, 22 insertions(+), 39
> > deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > b/drivers/gpu/drm/mediatek/mtk_dsi.c index 4a188a942c38..65fd99c528af
> > 100644 --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -444,7 +444,10 @@ static void mtk_dsi_config_vdo_timing(struct
> > mtk_dsi *dsi) u32 horizontal_sync_active_byte;
> >       u32 horizontal_backporch_byte;
> >       u32 horizontal_frontporch_byte;
> > +     u32 horizontal_front_back_byte;
> > +     u32 data_phy_cycles_byte;
> >       u32 dsi_tmp_buf_bpp, data_phy_cycles;
> > +     u32 delta;
> >       struct mtk_phy_timing *timing =3D &dsi->phy_timing;
> >
> >       struct videomode *vm =3D &dsi->vm;
> > @@ -466,50 +469,30 @@ static void mtk_dsi_config_vdo_timing(struct
> > mtk_dsi *dsi) horizontal_sync_active_byte =3D (vm->hsync_len *
> > dsi_tmp_buf_bpp - 10);
> >       if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
> > -             horizontal_backporch_byte =3D vm->hback_porch *
> > dsi_tmp_buf_bpp;
> > +             horizontal_backporch_byte =3D vm->hback_porch *
> > dsi_tmp_buf_bpp - 10; else
> >               horizontal_backporch_byte =3D (vm->hback_porch +
> > vm->hsync_len) *
> > -                                         dsi_tmp_buf_bpp;
> > +                                         dsi_tmp_buf_bpp - 10;
> >
> >       data_phy_cycles =3D timing->lpx + timing->da_hs_prepare +
> > -                       timing->da_hs_zero + timing->da_hs_exit;
> > -
> > -     if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
> > -             if ((vm->hfront_porch + vm->hback_porch) *
> > dsi_tmp_buf_bpp >
> > -                 data_phy_cycles * dsi->lanes + 18) {
> > -                     horizontal_frontporch_byte =3D
> > -                             vm->hfront_porch * dsi_tmp_buf_bpp -
> > -                             (data_phy_cycles * dsi->lanes + 18) *
> > -                             vm->hfront_porch /
> > -                             (vm->hfront_porch + vm->hback_porch);
> > -
> > -                     horizontal_backporch_byte =3D
> > -                             horizontal_backporch_byte -
> > -                             (data_phy_cycles * dsi->lanes + 18) *
> > -                             vm->hback_porch /
> > -                             (vm->hfront_porch + vm->hback_porch);
> > -             } else {
> > -                     DRM_WARN("HFP less than d-phy, FPS will
> > under 60Hz\n");
> > -                     horizontal_frontporch_byte =3D
> > vm->hfront_porch *
> > -                                                  dsi_tmp_buf_bpp;
> > -             }
> > +                       timing->da_hs_zero + timing->da_hs_exit +
> > 3; +
> > +     delta =3D dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST ? 18 :
> > 12; +
> > +     horizontal_frontporch_byte =3D vm->hfront_porch *
> > dsi_tmp_buf_bpp;
> > +     horizontal_front_back_byte =3D horizontal_frontporch_byte +
> > horizontal_backporch_byte;
> > +     data_phy_cycles_byte =3D data_phy_cycles * dsi->lanes + delta;
> > +
> > +     if (horizontal_front_back_byte > data_phy_cycles_byte) {
> > +             horizontal_frontporch_byte -=3D data_phy_cycles_byte *
> > +
> > horizontal_frontporch_byte /
> > +
> > horizontal_front_back_byte; +
> > +             horizontal_backporch_byte -=3D data_phy_cycles_byte *
> > +
> > horizontal_backporch_byte /
> > +
> > horizontal_front_back_byte; } else {
> > -             if ((vm->hfront_porch + vm->hback_porch) *
> > dsi_tmp_buf_bpp >
> > -                 data_phy_cycles * dsi->lanes + 12) {
> > -                     horizontal_frontporch_byte =3D
> > -                             vm->hfront_porch * dsi_tmp_buf_bpp -
> > -                             (data_phy_cycles * dsi->lanes + 12) *
> > -                             vm->hfront_porch /
> > -                             (vm->hfront_porch + vm->hback_porch);
> > -                     horizontal_backporch_byte =3D
> > horizontal_backporch_byte -
> > -                             (data_phy_cycles * dsi->lanes + 12) *
> > -                             vm->hback_porch /
> > -                             (vm->hfront_porch + vm->hback_porch);
> > -             } else {
> > -                     DRM_WARN("HFP less than d-phy, FPS will
> > under 60Hz\n");
> > -                     horizontal_frontporch_byte =3D
> > vm->hfront_porch *
> > -                                                  dsi_tmp_buf_bpp;
> > -             }
> > +             DRM_WARN("HFP + HBP less than d-phy, FPS will under
> > 60Hz\n"); }
> >
> >       writel(horizontal_sync_active_byte, dsi->regs + DSI_HSA_WC);
>
> Tested on Chromebook ELM.
>
> Tested-by: Bilal Wasim <bilal.wasim@imgtec.com>
>
> Thanks,
> Bilal

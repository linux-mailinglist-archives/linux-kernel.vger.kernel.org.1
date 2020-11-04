Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01E92A7329
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387578AbgKDXu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:50:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733030AbgKDXup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:50:45 -0500
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3BD221734
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 23:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604533844;
        bh=rZVugjYB/4k+eXAwY+hWif6/XHITjDjkK7t3jd5Csy4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EsbawDsGEKH+HSWm5ZqrktZxUyNrCzYQca0ZDpvEtrcVpRXlKY6HNjfKKJ+3WlkQh
         BUK08Kd8M9xHJnWndv2aR9KWEJu5dOWzc5R/c7qA0Y37gn0u3HfLFO48b/npedoL1B
         j23Ym4si1TZbG6lj5jRJmyUiNKEgChO4xSbi2meE=
Received: by mail-ed1-f47.google.com with SMTP id o20so64784eds.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:50:43 -0800 (PST)
X-Gm-Message-State: AOAM530u+Q/UVhV7wuXMZs2q9/2s+0k5NBEj9eEcT7ok+Zyudzlo24G/
        gdVgjTEel5MfKkKFylBpAVRsreTT7Xdhmwx01w==
X-Google-Smtp-Source: ABdhPJw2MFzA4i3gboFt85gvfEIsJhYi9NkO2Z8ek0sVWS6OAHSRmjU7y5MiPocAd0n+Veh84MiPymNv3gkFS0LgVtE=
X-Received: by 2002:a50:d587:: with SMTP id v7mr306527edi.38.1604533842193;
 Wed, 04 Nov 2020 15:50:42 -0800 (PST)
MIME-Version: 1.0
References: <20201005162241.172912-1-enric.balletbo@collabora.com> <9752ce85-a3e3-1e2f-c9d8-eae729364fee@collabora.com>
In-Reply-To: <9752ce85-a3e3-1e2f-c9d8-eae729364fee@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 5 Nov 2020 07:50:30 +0800
X-Gmail-Original-Message-ID: <CAAOTY__yPAph065cbgL8St5U4auW9H8mfWJrT67q5HVNiAmsBA@mail.gmail.com>
Message-ID: <CAAOTY__yPAph065cbgL8St5U4auW9H8mfWJrT67q5HVNiAmsBA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: mtk_dpi: Fix unused variable 'mtk_dpi_encoder_funcs'
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        kernel test robot <lkp@intel.com>,
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Enric:

Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=B9=
=B411=E6=9C=884=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:40=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Hi
>
> On 5/10/20 18:22, Enric Balletbo i Serra wrote:
> > Commit f89c696e7f63 ("drm/mediatek: mtk_dpi: Convert to bridge driver")
> > introduced the following build warning with W=3D1
> >
> >  drivers/gpu/drm/mediatek/mtk_dpi.c:530:39: warning: unused variable 'm=
tk_dpi_encoder_funcs' [-Wunused-const-variable]
> >  static const struct drm_encoder_funcs mtk_dpi_encoder_funcs =3D {
> >
> > This struct is and the 'mtk_dpi_encoder_destroy()' are not needed
> > anymore, so remove them.
> >
> > Fixes: f89c696e7f63 ("drm/mediatek: mtk_dpi: Convert to bridge driver")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
>
> A gentle ping on this small fix. Thanks,

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
>   Enric
>
> >
> >  drivers/gpu/drm/mediatek/mtk_dpi.c | 9 ---------
> >  1 file changed, 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/media=
tek/mtk_dpi.c
> > index 589ef33a1780..2609d917e3f9 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > @@ -522,15 +522,6 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi=
 *dpi,
> >       return 0;
> >  }
> >
> > -static void mtk_dpi_encoder_destroy(struct drm_encoder *encoder)
> > -{
> > -     drm_encoder_cleanup(encoder);
> > -}
> > -
> > -static const struct drm_encoder_funcs mtk_dpi_encoder_funcs =3D {
> > -     .destroy =3D mtk_dpi_encoder_destroy,
> > -};
> > -
> >  static int mtk_dpi_bridge_attach(struct drm_bridge *bridge,
> >                                enum drm_bridge_attach_flags flags)
> >  {
> >

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DE9253A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 01:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgHZXEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 19:04:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgHZXEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 19:04:00 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 650BD21741
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 23:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598483039;
        bh=XwRld9s4bWwSDqk7OpTV0iyuBoFpuxzcSD+6/QSrZvM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MUn7URfhQyTV1VF8JhUC/cDazTURdvZBO9Rga7T98BYIbyOtKnJgA5z4kQss/r4TM
         lzyTXT+Y2Y6WObbuB3pcozz7BXDy7XYQuSpF4AkYuPD3IlBXTOya5ID869/CuP62yP
         Wl3TyDBUf2i9y5GOsPyy3m+B+WIsIrbIZcBxOZaE=
Received: by mail-ej1-f51.google.com with SMTP id si26so5071923ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 16:03:59 -0700 (PDT)
X-Gm-Message-State: AOAM531Hf1VEJj7DhW454Uf0g22iXghg0HfhdOWJeHQEVz/m/8VoFNZp
        1wS19R62+gi/l8i/RqqPZq7Bc0tVEIypQC1d6A==
X-Google-Smtp-Source: ABdhPJyg/7oRktjfShagR7wzytYd2W8ziwXzaMzApSrhbBtU/OM2q8Cna8GCDosKqDdIi9fWnzLjClLR0M24ndzIs6Q=
X-Received: by 2002:a17:906:3a41:: with SMTP id a1mr17890476ejf.260.1598483037963;
 Wed, 26 Aug 2020 16:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200819025829.57545-1-wanghai38@huawei.com> <CAAOTY_8-iB9sg4+-AyFpGACc2pW+ZzsJqUbvgReNcfu5kSX6Qw@mail.gmail.com>
In-Reply-To: <CAAOTY_8-iB9sg4+-AyFpGACc2pW+ZzsJqUbvgReNcfu5kSX6Qw@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 27 Aug 2020 07:03:46 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9DUUZuZO3Nu+bq-t0SyabRRqwW3B+V=--K_nHJ9sAxMg@mail.gmail.com>
Message-ID: <CAAOTY_9DUUZuZO3Nu+bq-t0SyabRRqwW3B+V=--K_nHJ9sAxMg@mail.gmail.com>
Subject: Re: [PATCH -next] drm/mediatek: remove duplicate include
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Wang Hai <wanghai38@huawei.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Wang Hai:

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8821=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=887:23=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi, Wang Hai:
>
> Wang Hai <wanghai38@huawei.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=8819=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8811:00=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > Remove mtk_drm_ddp.h which is included more than once
> >
>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Wang Hai <wanghai38@huawei.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/m=
ediatek/mtk_drm_drv.c
> > index 040a8f393fe2..a34fd805ce6d 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > @@ -27,7 +27,6 @@
> >
> >  #include "mtk_drm_crtc.h"
> >  #include "mtk_drm_ddp.h"
> > -#include "mtk_drm_ddp.h"
> >  #include "mtk_drm_ddp_comp.h"
> >  #include "mtk_drm_drv.h"
> >  #include "mtk_drm_gem.h"
> > --
> > 2.17.1
> >

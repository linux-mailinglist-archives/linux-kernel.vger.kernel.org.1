Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B068E2FE31A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbhAUGlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 01:41:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732101AbhATXo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 18:44:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A31AE23603
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 23:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611186204;
        bh=GbRF3i3x8D+is4aONiKOpafSZKWah8Gz4GGTPRXLbYw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ToPvmAjFKWIg8fBrTufi5tcLdsYaJaJQAEgis6nWuyHVNg+BQxyxaN5VvSdLq0ehS
         bwWnPDLxTAXKAcaG9jYXCJKof8PYkx4T+BOSGr/74BESA1WDTVar6UpnnpmQxsK3TK
         W0g46IXB9Qqw755cfGmq/Wh4WhMAt0TmvMpZmhG1oaXQGvcSagMg/du8E+saBib1tv
         o5O62x4lA/sJePJBgbX+p6JUBzDiVQsSHqkdN7bRUeeWkgKwF0wq3vqnxK9q6Jd6pR
         yDTtKMffXHsBcejvncQoW3Ni3ihI0NmvRWYEw0vr3ODuE7XRVRKc9Q06AkCF9wCSix
         4irK4HsTMysgA==
Received: by mail-wr1-f54.google.com with SMTP id d26so16221wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 15:43:24 -0800 (PST)
X-Gm-Message-State: AOAM532fQx5+ercqh9Lqph51jeh47ZA9EkuWEEM/aWKCalo2brZWjYV7
        qEYlWGtCk2WcSV3nD7BtG/+CfgC+tzT5eJYVHw==
X-Google-Smtp-Source: ABdhPJyLCbRd+WlYCtBDR0NwMoVCFhlQCm4Nu9FhzK8aR30JvgSkjnN2OLHoxHVVOwZsBj9K+JWiqW1czVnoCqcN0aA=
X-Received: by 2002:adf:e84c:: with SMTP id d12mr11979282wrn.382.1611186203245;
 Wed, 20 Jan 2021 15:43:23 -0800 (PST)
MIME-Version: 1.0
References: <20210106231729.17173-1-chunkuang.hu@kernel.org>
 <20210106231729.17173-6-chunkuang.hu@kernel.org> <YAh3WrRDwtGJIHok@ziggy.stardust>
In-Reply-To: <YAh3WrRDwtGJIHok@ziggy.stardust>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 21 Jan 2021 07:43:09 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9N2khR4Qdw8=sb4XnEpbq=HddLPkmfUJ03g=CQWVqNTg@mail.gmail.com>
Message-ID: <CAAOTY_9N2khR4Qdw8=sb4XnEpbq=HddLPkmfUJ03g=CQWVqNTg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] soc / drm: mediatek: Move mtk mutex driver to soc folder
To:     Matthias Brugger <matthias.bgg@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, CK Hu <ck.hu@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthias:

Matthias Brugger <matthias.bgg@kernel.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=
=8821=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=882:33=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Thu, Jan 07, 2021 at 07:17:29AM +0800, Chun-Kuang Hu wrote:
> > From: CK Hu <ck.hu@mediatek.com>
> >
> > mtk mutex is used by DRM and MDP driver, and its function is SoC-specif=
ic,
> > so move it to soc folder.
> >
> > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>
> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
>
> Please take the patch through your tree. Thanks!

Applied, thanks.

Regards,
Chun-Kuang.

>
> > ---
> >  drivers/gpu/drm/mediatek/Makefile                 |  3 +--
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c           |  2 +-
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c            |  1 -
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.h            |  1 -
> >  drivers/soc/mediatek/Makefile                     |  1 +
> >  .../mtk_mutex.c =3D> soc/mediatek/mtk-mutex.c}      | 15 +++++++++++++=
--
> >  .../linux/soc/mediatek/mtk-mutex.h                |  0
> >  7 files changed, 16 insertions(+), 7 deletions(-)
> >  rename drivers/{gpu/drm/mediatek/mtk_mutex.c =3D> soc/mediatek/mtk-mut=
ex.c} (96%)
> >  rename drivers/gpu/drm/mediatek/mtk_mutex.h =3D> include/linux/soc/med=
iatek/mtk-mutex.h (100%)
> >
> > diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediat=
ek/Makefile
> > index 09979c4c340a..01d06332f767 100644
> > --- a/drivers/gpu/drm/mediatek/Makefile
> > +++ b/drivers/gpu/drm/mediatek/Makefile
> > @@ -9,8 +9,7 @@ mediatek-drm-y :=3D mtk_disp_color.o \
> >                 mtk_drm_gem.o \
> >                 mtk_drm_plane.o \
> >                 mtk_dsi.o \
> > -               mtk_dpi.o \
> > -               mtk_mutex.o
> > +               mtk_dpi.o
> >
> >  obj-$(CONFIG_DRM_MEDIATEK) +=3D mediatek-drm.o
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/=
mediatek/mtk_drm_crtc.c
> > index 1e3a9450680b..e9b6788d52cd 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/soc/mediatek/mtk-cmdq.h>
> >  #include <linux/soc/mediatek/mtk-mmsys.h>
> > +#include <linux/soc/mediatek/mtk-mutex.h>
> >
> >  #include <asm/barrier.h>
> >  #include <soc/mediatek/smi.h>
> > @@ -22,7 +23,6 @@
> >  #include "mtk_drm_ddp_comp.h"
> >  #include "mtk_drm_gem.h"
> >  #include "mtk_drm_plane.h"
> > -#include "mtk_mutex.h"
> >
> >  /*
> >   * struct mtk_drm_crtc - MediaTek specific crtc structure.
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/m=
ediatek/mtk_drm_drv.c
> > index b99a06e6834e..5d39dd54255d 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > @@ -588,7 +588,6 @@ static struct platform_driver mtk_drm_platform_driv=
er =3D {
> >  };
> >
> >  static struct platform_driver * const mtk_drm_drivers[] =3D {
> > -     &mtk_mutex_driver,
> >       &mtk_disp_color_driver,
> >       &mtk_disp_ovl_driver,
> >       &mtk_disp_rdma_driver,
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/m=
ediatek/mtk_drm_drv.h
> > index ae366868d01a..e8238fa4aa2a 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> > @@ -46,7 +46,6 @@ struct mtk_drm_private {
> >       struct drm_atomic_state *suspend_state;
> >  };
> >
> > -extern struct platform_driver mtk_mutex_driver;
> >  extern struct platform_driver mtk_disp_color_driver;
> >  extern struct platform_driver mtk_disp_ovl_driver;
> >  extern struct platform_driver mtk_disp_rdma_driver;
> > diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makef=
ile
> > index b6908db534c2..90270f8114ed 100644
> > --- a/drivers/soc/mediatek/Makefile
> > +++ b/drivers/soc/mediatek/Makefile
> > @@ -6,3 +6,4 @@ obj-$(CONFIG_MTK_PMIC_WRAP) +=3D mtk-pmic-wrap.o
> >  obj-$(CONFIG_MTK_SCPSYS) +=3D mtk-scpsys.o
> >  obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) +=3D mtk-pm-domains.o
> >  obj-$(CONFIG_MTK_MMSYS) +=3D mtk-mmsys.o
> > +obj-$(CONFIG_MTK_MMSYS) +=3D mtk-mutex.o
> > diff --git a/drivers/gpu/drm/mediatek/mtk_mutex.c b/drivers/soc/mediate=
k/mtk-mutex.c
> > similarity index 96%
> > rename from drivers/gpu/drm/mediatek/mtk_mutex.c
> > rename to drivers/soc/mediatek/mtk-mutex.c
> > index 66344759e622..f531b119da7a 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_mutex.c
> > +++ b/drivers/soc/mediatek/mtk-mutex.c
> > @@ -10,8 +10,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> >  #include <linux/soc/mediatek/mtk-mmsys.h>
> > -
> > -#include "mtk_mutex.h"
> > +#include <linux/soc/mediatek/mtk-mutex.h>
> >
> >  #define MT2701_MUTEX0_MOD0                   0x2c
> >  #define MT2701_MUTEX0_SOF0                   0x30
> > @@ -241,6 +240,7 @@ struct mtk_mutex *mtk_mutex_get(struct device *dev)
> >
> >       return ERR_PTR(-EBUSY);
> >  }
> > +EXPORT_SYMBOL_GPL(mtk_mutex_get);
> >
> >  void mtk_mutex_put(struct mtk_mutex *mutex)
> >  {
> > @@ -251,6 +251,7 @@ void mtk_mutex_put(struct mtk_mutex *mutex)
> >
> >       mutex->claimed =3D false;
> >  }
> > +EXPORT_SYMBOL_GPL(mtk_mutex_put);
> >
> >  int mtk_mutex_prepare(struct mtk_mutex *mutex)
> >  {
> > @@ -258,6 +259,7 @@ int mtk_mutex_prepare(struct mtk_mutex *mutex)
> >                                                mutex[mutex->id]);
> >       return clk_prepare_enable(mtx->clk);
> >  }
> > +EXPORT_SYMBOL_GPL(mtk_mutex_prepare);
> >
> >  void mtk_mutex_unprepare(struct mtk_mutex *mutex)
> >  {
> > @@ -265,6 +267,7 @@ void mtk_mutex_unprepare(struct mtk_mutex *mutex)
> >                                                mutex[mutex->id]);
> >       clk_disable_unprepare(mtx->clk);
> >  }
> > +EXPORT_SYMBOL_GPL(mtk_mutex_unprepare);
> >
> >  void mtk_mutex_add_comp(struct mtk_mutex *mutex,
> >                       enum mtk_ddp_comp_id id)
> > @@ -316,6 +319,7 @@ void mtk_mutex_add_comp(struct mtk_mutex *mutex,
> >                      mtx->regs +
> >                      DISP_REG_MUTEX_SOF(mtx->data->mutex_sof_reg, mutex=
->id));
> >  }
> > +EXPORT_SYMBOL_GPL(mtk_mutex_add_comp);
> >
> >  void mtk_mutex_remove_comp(struct mtk_mutex *mutex,
> >                          enum mtk_ddp_comp_id id)
> > @@ -355,6 +359,7 @@ void mtk_mutex_remove_comp(struct mtk_mutex *mutex,
> >               break;
> >       }
> >  }
> > +EXPORT_SYMBOL_GPL(mtk_mutex_remove_comp);
> >
> >  void mtk_mutex_enable(struct mtk_mutex *mutex)
> >  {
> > @@ -365,6 +370,7 @@ void mtk_mutex_enable(struct mtk_mutex *mutex)
> >
> >       writel(1, mtx->regs + DISP_REG_MUTEX_EN(mutex->id));
> >  }
> > +EXPORT_SYMBOL_GPL(mtk_mutex_enable);
> >
> >  void mtk_mutex_disable(struct mtk_mutex *mutex)
> >  {
> > @@ -375,6 +381,7 @@ void mtk_mutex_disable(struct mtk_mutex *mutex)
> >
> >       writel(0, mtx->regs + DISP_REG_MUTEX_EN(mutex->id));
> >  }
> > +EXPORT_SYMBOL_GPL(mtk_mutex_disable);
> >
> >  void mtk_mutex_acquire(struct mtk_mutex *mutex)
> >  {
> > @@ -388,6 +395,7 @@ void mtk_mutex_acquire(struct mtk_mutex *mutex)
> >                                     tmp, tmp & INT_MUTEX, 1, 10000))
> >               pr_err("could not acquire mutex %d\n", mutex->id);
> >  }
> > +EXPORT_SYMBOL_GPL(mtk_mutex_acquire);
> >
> >  void mtk_mutex_release(struct mtk_mutex *mutex)
> >  {
> > @@ -396,6 +404,7 @@ void mtk_mutex_release(struct mtk_mutex *mutex)
> >
> >       writel(0, mtx->regs + DISP_REG_MUTEX(mutex->id));
> >  }
> > +EXPORT_SYMBOL_GPL(mtk_mutex_release);
> >
> >  static int mtk_mutex_probe(struct platform_device *pdev)
> >  {
> > @@ -461,3 +470,5 @@ struct platform_driver mtk_mutex_driver =3D {
> >               .of_match_table =3D mutex_driver_dt_match,
> >       },
> >  };
> > +
> > +builtin_platform_driver(mtk_mutex_driver);
> > diff --git a/drivers/gpu/drm/mediatek/mtk_mutex.h b/include/linux/soc/m=
ediatek/mtk-mutex.h
> > similarity index 100%
> > rename from drivers/gpu/drm/mediatek/mtk_mutex.h
> > rename to include/linux/soc/mediatek/mtk-mutex.h
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek

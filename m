Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A2C2FDA38
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732744AbhATSnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:43:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:51892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404615AbhATSdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:33:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 748E1233ED;
        Wed, 20 Jan 2021 18:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611167583;
        bh=gS5YCcmo42SQE5E2c/zKvc5ZsGlT6rIPmyPqhGBK0GE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZiQj3doEVDhjfKTGbmTOw+RLHT109BtBRb762soUVj2EoVQmEn0B/YTdnkEoyDim4
         j2jWI2JFuTsgBvXDKswlL8p+9YfsQvKhIgLHhf1nZnELh7x4WVgXzDtnCkG4Eq8kjV
         zAdc0jiLeJRnDoPFRX7DSF3gpKF31Zhm3IZ1YmBvreOhIZHBV/lMqECcN8PNh/+Q1w
         p+KYJxgD7aLod0exFQWFQSmQgDhEc8NcQnO39uawNK55dxp0+Nd+g8kAGNxLBSTqTK
         z79lKNdo8ggz8ymWVCwG9YX0dGNDE4wfmNMptV3CJaQP+WZg+1hlkgdiVah2sxLWDE
         a9gtoWPx2Z+Ig==
Date:   Wed, 20 Jan 2021 19:32:58 +0100
From:   Matthias Brugger <matthias.bgg@kernel.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, CK Hu <ck.hu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/5] soc / drm: mediatek: Move mtk mutex driver to soc
 folder
Message-ID: <YAh3WrRDwtGJIHok@ziggy.stardust>
References: <20210106231729.17173-1-chunkuang.hu@kernel.org>
 <20210106231729.17173-6-chunkuang.hu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210106231729.17173-6-chunkuang.hu@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 07:17:29AM +0800, Chun-Kuang Hu wrote:
> From: CK Hu <ck.hu@mediatek.com>
> 
> mtk mutex is used by DRM and MDP driver, and its function is SoC-specific,
> so move it to soc folder.
> 
> Signed-off-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

Please take the patch through your tree. Thanks!

> ---
>  drivers/gpu/drm/mediatek/Makefile                 |  3 +--
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c           |  2 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c            |  1 -
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h            |  1 -
>  drivers/soc/mediatek/Makefile                     |  1 +
>  .../mtk_mutex.c => soc/mediatek/mtk-mutex.c}      | 15 +++++++++++++--
>  .../linux/soc/mediatek/mtk-mutex.h                |  0
>  7 files changed, 16 insertions(+), 7 deletions(-)
>  rename drivers/{gpu/drm/mediatek/mtk_mutex.c => soc/mediatek/mtk-mutex.c} (96%)
>  rename drivers/gpu/drm/mediatek/mtk_mutex.h => include/linux/soc/mediatek/mtk-mutex.h (100%)
> 
> diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
> index 09979c4c340a..01d06332f767 100644
> --- a/drivers/gpu/drm/mediatek/Makefile
> +++ b/drivers/gpu/drm/mediatek/Makefile
> @@ -9,8 +9,7 @@ mediatek-drm-y := mtk_disp_color.o \
>  		  mtk_drm_gem.o \
>  		  mtk_drm_plane.o \
>  		  mtk_dsi.o \
> -		  mtk_dpi.o \
> -		  mtk_mutex.o
> +		  mtk_dpi.o
>  
>  obj-$(CONFIG_DRM_MEDIATEK) += mediatek-drm.o
>  
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index 1e3a9450680b..e9b6788d52cd 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -7,6 +7,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/soc/mediatek/mtk-cmdq.h>
>  #include <linux/soc/mediatek/mtk-mmsys.h>
> +#include <linux/soc/mediatek/mtk-mutex.h>
>  
>  #include <asm/barrier.h>
>  #include <soc/mediatek/smi.h>
> @@ -22,7 +23,6 @@
>  #include "mtk_drm_ddp_comp.h"
>  #include "mtk_drm_gem.h"
>  #include "mtk_drm_plane.h"
> -#include "mtk_mutex.h"
>  
>  /*
>   * struct mtk_drm_crtc - MediaTek specific crtc structure.
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index b99a06e6834e..5d39dd54255d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -588,7 +588,6 @@ static struct platform_driver mtk_drm_platform_driver = {
>  };
>  
>  static struct platform_driver * const mtk_drm_drivers[] = {
> -	&mtk_mutex_driver,
>  	&mtk_disp_color_driver,
>  	&mtk_disp_ovl_driver,
>  	&mtk_disp_rdma_driver,
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> index ae366868d01a..e8238fa4aa2a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -46,7 +46,6 @@ struct mtk_drm_private {
>  	struct drm_atomic_state *suspend_state;
>  };
>  
> -extern struct platform_driver mtk_mutex_driver;
>  extern struct platform_driver mtk_disp_color_driver;
>  extern struct platform_driver mtk_disp_ovl_driver;
>  extern struct platform_driver mtk_disp_rdma_driver;
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index b6908db534c2..90270f8114ed 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -6,3 +6,4 @@ obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
>  obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
>  obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) += mtk-pm-domains.o
>  obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
> +obj-$(CONFIG_MTK_MMSYS) += mtk-mutex.o
> diff --git a/drivers/gpu/drm/mediatek/mtk_mutex.c b/drivers/soc/mediatek/mtk-mutex.c
> similarity index 96%
> rename from drivers/gpu/drm/mediatek/mtk_mutex.c
> rename to drivers/soc/mediatek/mtk-mutex.c
> index 66344759e622..f531b119da7a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mutex.c
> +++ b/drivers/soc/mediatek/mtk-mutex.c
> @@ -10,8 +10,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/soc/mediatek/mtk-mmsys.h>
> -
> -#include "mtk_mutex.h"
> +#include <linux/soc/mediatek/mtk-mutex.h>
>  
>  #define MT2701_MUTEX0_MOD0			0x2c
>  #define MT2701_MUTEX0_SOF0			0x30
> @@ -241,6 +240,7 @@ struct mtk_mutex *mtk_mutex_get(struct device *dev)
>  
>  	return ERR_PTR(-EBUSY);
>  }
> +EXPORT_SYMBOL_GPL(mtk_mutex_get);
>  
>  void mtk_mutex_put(struct mtk_mutex *mutex)
>  {
> @@ -251,6 +251,7 @@ void mtk_mutex_put(struct mtk_mutex *mutex)
>  
>  	mutex->claimed = false;
>  }
> +EXPORT_SYMBOL_GPL(mtk_mutex_put);
>  
>  int mtk_mutex_prepare(struct mtk_mutex *mutex)
>  {
> @@ -258,6 +259,7 @@ int mtk_mutex_prepare(struct mtk_mutex *mutex)
>  						 mutex[mutex->id]);
>  	return clk_prepare_enable(mtx->clk);
>  }
> +EXPORT_SYMBOL_GPL(mtk_mutex_prepare);
>  
>  void mtk_mutex_unprepare(struct mtk_mutex *mutex)
>  {
> @@ -265,6 +267,7 @@ void mtk_mutex_unprepare(struct mtk_mutex *mutex)
>  						 mutex[mutex->id]);
>  	clk_disable_unprepare(mtx->clk);
>  }
> +EXPORT_SYMBOL_GPL(mtk_mutex_unprepare);
>  
>  void mtk_mutex_add_comp(struct mtk_mutex *mutex,
>  			enum mtk_ddp_comp_id id)
> @@ -316,6 +319,7 @@ void mtk_mutex_add_comp(struct mtk_mutex *mutex,
>  		       mtx->regs +
>  		       DISP_REG_MUTEX_SOF(mtx->data->mutex_sof_reg, mutex->id));
>  }
> +EXPORT_SYMBOL_GPL(mtk_mutex_add_comp);
>  
>  void mtk_mutex_remove_comp(struct mtk_mutex *mutex,
>  			   enum mtk_ddp_comp_id id)
> @@ -355,6 +359,7 @@ void mtk_mutex_remove_comp(struct mtk_mutex *mutex,
>  		break;
>  	}
>  }
> +EXPORT_SYMBOL_GPL(mtk_mutex_remove_comp);
>  
>  void mtk_mutex_enable(struct mtk_mutex *mutex)
>  {
> @@ -365,6 +370,7 @@ void mtk_mutex_enable(struct mtk_mutex *mutex)
>  
>  	writel(1, mtx->regs + DISP_REG_MUTEX_EN(mutex->id));
>  }
> +EXPORT_SYMBOL_GPL(mtk_mutex_enable);
>  
>  void mtk_mutex_disable(struct mtk_mutex *mutex)
>  {
> @@ -375,6 +381,7 @@ void mtk_mutex_disable(struct mtk_mutex *mutex)
>  
>  	writel(0, mtx->regs + DISP_REG_MUTEX_EN(mutex->id));
>  }
> +EXPORT_SYMBOL_GPL(mtk_mutex_disable);
>  
>  void mtk_mutex_acquire(struct mtk_mutex *mutex)
>  {
> @@ -388,6 +395,7 @@ void mtk_mutex_acquire(struct mtk_mutex *mutex)
>  				      tmp, tmp & INT_MUTEX, 1, 10000))
>  		pr_err("could not acquire mutex %d\n", mutex->id);
>  }
> +EXPORT_SYMBOL_GPL(mtk_mutex_acquire);
>  
>  void mtk_mutex_release(struct mtk_mutex *mutex)
>  {
> @@ -396,6 +404,7 @@ void mtk_mutex_release(struct mtk_mutex *mutex)
>  
>  	writel(0, mtx->regs + DISP_REG_MUTEX(mutex->id));
>  }
> +EXPORT_SYMBOL_GPL(mtk_mutex_release);
>  
>  static int mtk_mutex_probe(struct platform_device *pdev)
>  {
> @@ -461,3 +470,5 @@ struct platform_driver mtk_mutex_driver = {
>  		.of_match_table = mutex_driver_dt_match,
>  	},
>  };
> +
> +builtin_platform_driver(mtk_mutex_driver);
> diff --git a/drivers/gpu/drm/mediatek/mtk_mutex.h b/include/linux/soc/mediatek/mtk-mutex.h
> similarity index 100%
> rename from drivers/gpu/drm/mediatek/mtk_mutex.h
> rename to include/linux/soc/mediatek/mtk-mutex.h
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB10A2A6F8A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 22:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbgKDVW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 16:22:29 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:40798 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKDVW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 16:22:29 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 5DFB020066;
        Wed,  4 Nov 2020 22:22:23 +0100 (CET)
Date:   Wed, 4 Nov 2020 22:22:21 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v7 2/3] drm: Add support for the LogiCVC display
 controller
Message-ID: <20201104212221.GA5588@ravnborg.org>
References: <20201102155308.142691-1-paul.kocialkowski@bootlin.com>
 <20201102155308.142691-3-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102155308.142691-3-paul.kocialkowski@bootlin.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8
        a=P1BnusSwAAAA:8 a=j2HRoelctIqCdkGHX-MA:9 a=CjuIK1q_8ugA:10
        a=d3PnA9EDa4IxuAV0gXij:22 a=AjGcO6oz07-iQ99wixmX:22
        a=Vxmtnl_E_bksehYqCbjh:22 a=D0XLA9XvdZm18NrgonBM:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

A few comments in the following. I did not find time to read all of the
driver.

	Sam

On Mon, Nov 02, 2020 at 04:53:07PM +0100, Paul Kocialkowski wrote:
> Introduces a driver for the LogiCVC display controller, a programmable
> logic controller optimized for use in Xilinx Zynq-7000 SoCs and other
> Xilinx FPGAs. The controller is mostly configured at logic synthesis
> time so only a subset of configuration is left for the driver to
> handle.
> 
> The following features are implemented and tested:
> - LVDS 4-bit interface;
> - RGB565 pixel formats;
> - Multiple layers and hardware composition;
> - Layer-wide alpha mode;
> 
> The following features are implemented but untested:
> - Other RGB pixel formats;
> - Layer framebuffer configuration for version 4;
> - Lowest-layer used as background color;
> - Per-pixel alpha mode.
> 
> The following features are not implemented:
> - YUV pixel formats;
> - DVI, LVDS 3-bit, ITU656 and camera link interfaces;
> - External parallel input for layer;
> - Color-keying;
> - LUT-based alpha modes.
> 
> Additional implementation-specific notes:
> - Panels are only enabled after the first page flip to avoid flashing a
>   white screen.
> - Depth used in context of the LogiCVC driver only counts color components
>   to match the definition of the synthesis parameters.
> 
> Support is implemented for both version 3 and 4 of the controller.
> 
> With version 3, framebuffers are stored in a dedicated contiguous
> memory area, with a base address hardcoded for each layer. This requires
> using a dedicated CMA pool registered at the base address and tweaking a
> few offset-related registers to try to use any buffer allocated from
> the pool. This is done on a best-effort basis to have the hardware cope
> with the DRM framebuffer allocation model and there is no guarantee
> that each buffer allocated by GEM CMA can be used for any layer.
> In particular, buffers allocated below the base address for a layer are
> guaranteed not to be configurable for that layer. See the implementation of
> logicvc_layer_buffer_find_setup for specifics.
> 
> Version 4 allows configuring each buffer address directly, which
> guarantees that any buffer can be configured.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> ---
>  MAINTAINERS                                 |   6 +
>  drivers/gpu/drm/Kconfig                     |   2 +
>  drivers/gpu/drm/Makefile                    |   1 +
>  drivers/gpu/drm/logicvc/Kconfig             |   9 +
>  drivers/gpu/drm/logicvc/Makefile            |   4 +
>  drivers/gpu/drm/logicvc/logicvc_crtc.c      | 277 +++++++++
>  drivers/gpu/drm/logicvc/logicvc_crtc.h      |  21 +
>  drivers/gpu/drm/logicvc/logicvc_drm.c       | 472 +++++++++++++++
>  drivers/gpu/drm/logicvc/logicvc_drm.h       |  64 ++
>  drivers/gpu/drm/logicvc/logicvc_interface.c | 224 +++++++
>  drivers/gpu/drm/logicvc/logicvc_interface.h |  30 +
>  drivers/gpu/drm/logicvc/logicvc_layer.c     | 615 ++++++++++++++++++++
>  drivers/gpu/drm/logicvc/logicvc_layer.h     |  64 ++
>  drivers/gpu/drm/logicvc/logicvc_mode.c      | 101 ++++
>  drivers/gpu/drm/logicvc/logicvc_mode.h      |  15 +
>  drivers/gpu/drm/logicvc/logicvc_of.c        | 197 +++++++
>  drivers/gpu/drm/logicvc/logicvc_of.h        |  46 ++
>  drivers/gpu/drm/logicvc/logicvc_regs.h      |  88 +++
>  18 files changed, 2236 insertions(+)
>  create mode 100644 drivers/gpu/drm/logicvc/Kconfig
>  create mode 100644 drivers/gpu/drm/logicvc/Makefile
>  create mode 100644 drivers/gpu/drm/logicvc/logicvc_crtc.c
>  create mode 100644 drivers/gpu/drm/logicvc/logicvc_crtc.h
>  create mode 100644 drivers/gpu/drm/logicvc/logicvc_drm.c
>  create mode 100644 drivers/gpu/drm/logicvc/logicvc_drm.h
>  create mode 100644 drivers/gpu/drm/logicvc/logicvc_interface.c
>  create mode 100644 drivers/gpu/drm/logicvc/logicvc_interface.h
>  create mode 100644 drivers/gpu/drm/logicvc/logicvc_layer.c
>  create mode 100644 drivers/gpu/drm/logicvc/logicvc_layer.h
>  create mode 100644 drivers/gpu/drm/logicvc/logicvc_mode.c
>  create mode 100644 drivers/gpu/drm/logicvc/logicvc_mode.h
>  create mode 100644 drivers/gpu/drm/logicvc/logicvc_of.c
>  create mode 100644 drivers/gpu/drm/logicvc/logicvc_of.h
>  create mode 100644 drivers/gpu/drm/logicvc/logicvc_regs.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 71e29dc0ab9d..9c4c5edef0ba 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5522,6 +5522,12 @@ S:	Orphan / Obsolete
>  F:	drivers/gpu/drm/i810/
>  F:	include/uapi/drm/i810_drm.h
>  
> +DRM DRIVER FOR LOGICVC DISPLAY CONTROLLER
> +M:	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +S:	Supported
> +F:	drivers/gpu/drm/logicvc/
> +
>  DRM DRIVER FOR LVDS PANELS
>  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>  L:	dri-devel@lists.freedesktop.org
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 64376dd298ed..7b280056207f 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -352,6 +352,8 @@ source "drivers/gpu/drm/arc/Kconfig"
>  
>  source "drivers/gpu/drm/hisilicon/Kconfig"
>  
> +source "drivers/gpu/drm/logicvc/Kconfig"
> +
>  source "drivers/gpu/drm/mediatek/Kconfig"
>  
>  source "drivers/gpu/drm/zte/Kconfig"
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 81569009f884..29fbb7cd9570 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -102,6 +102,7 @@ obj-$(CONFIG_DRM_STM) += stm/
>  obj-$(CONFIG_DRM_STI) += sti/
>  obj-y 			+= imx/
>  obj-$(CONFIG_DRM_INGENIC) += ingenic/
> +obj-$(CONFIG_DRM_LOGICVC) += logicvc/
>  obj-$(CONFIG_DRM_MEDIATEK) += mediatek/
>  obj-$(CONFIG_DRM_MESON)	+= meson/
>  obj-y			+= i2c/
> diff --git a/drivers/gpu/drm/logicvc/Kconfig b/drivers/gpu/drm/logicvc/Kconfig
> new file mode 100644
> index 000000000000..300b2be07385
> --- /dev/null
> +++ b/drivers/gpu/drm/logicvc/Kconfig
> @@ -0,0 +1,9 @@
> +config DRM_LOGICVC
> +	tristate "LogiCVC DRM"
> +	depends on DRM
> +	depends on OF || COMPILE_TEST
> +	select DRM_KMS_HELPER
> +	select DRM_KMS_CMA_HELPER
> +	select DRM_GEM_CMA_HELPER
> +	help
> +	  DRM display driver for the logiCVC programmable logic block from Xylon
> diff --git a/drivers/gpu/drm/logicvc/Makefile b/drivers/gpu/drm/logicvc/Makefile
> new file mode 100644
> index 000000000000..c09531fbd6ad
> --- /dev/null
> +++ b/drivers/gpu/drm/logicvc/Makefile
> @@ -0,0 +1,4 @@
> +logicvc-drm-y += logicvc_crtc.o logicvc_drm.o logicvc_interface.o \
> +		 logicvc_layer.o logicvc_mode.o logicvc_of.o
> +
Even after maintaining kbuild for several years and reading far too many
Makefile I still dislike the use of '\' to break long assignments.

logicvc-drm-y := logicvc_crtc.o
logicvc-drm-y += logicvc_drm.o
logicvc-drm-y += logicvc_interface.o
logicvc-drm-y += logicvc_layer.o
logicvc-drm-y += logicvc_mode.o
logicvc-drm-y += logicvc_of.o

Or if this is too much repeated the shorter:
logicvc-drm-y := logicvc_crtc.o logicvc_drm.o logicvc_interface.o
logicvc-drm-y += logicvc_layer.o logicvc_mode.o logicvc_of.o

Also note that the first stement is an assingnment and not an addition.

It is a personal thing - so feel free to ignore.



> +obj-$(CONFIG_DRM_LOGICVC) += logicvc-drm.o
> diff --git a/drivers/gpu/drm/logicvc/logicvc_crtc.c b/drivers/gpu/drm/logicvc/logicvc_crtc.c
> new file mode 100644
> index 000000000000..75e6a47a7724
> --- /dev/null
> +++ b/drivers/gpu/drm/logicvc/logicvc_crtc.c
> @@ -0,0 +1,277 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2019 Bootlin
> + * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> + */
> +
...

 +
> +int logicvc_crtc_init(struct logicvc_drm *logicvc)
> +{
> +	struct drm_device *drm_dev = &logicvc->drm_dev;
> +	struct device *dev = drm_dev->dev;
> +	struct device_node *of_node = dev->of_node;
> +	struct logicvc_crtc *crtc;
> +	struct logicvc_layer *layer_primary;
> +	int ret;
> +
> +	crtc = devm_kzalloc(dev, sizeof(*crtc), GFP_KERNEL);
> +	if (!crtc)
> +		return -ENOMEM;
> +
> +	layer_primary = logicvc_layer_get_primary(logicvc);
> +	if (!layer_primary) {
> +		DRM_ERROR("Failed to get primary layer\n");
> +		return -EINVAL;
> +	}
Please use drm_err(logicvc->drm, "...") and friends all over the file.
DRM_DEV_ERROR() and friends are deprecated.
If you have no drm_device use whatever.


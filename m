Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634B82E895F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 00:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbhABXqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jan 2021 18:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbhABXqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 18:46:15 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBB6C061573
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jan 2021 15:45:34 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id 91so27240328wrj.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jan 2021 15:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oiqcBp2KAElTs9dOPNYLnYvG9oB7g9MLqN9OAEFRAh8=;
        b=e9avM2k7O1I5PPA8YBYtZWEXSWrTwO/LKl9Ajo7EmcFNliNiyh5Hij0h/qlj2EfYZw
         WbvbjvfSGIhjiYi6INqmHJNRE34jhVk6m/FJvOJM2tIBwAaT8Zu2bJuEf+xVvMD50Dkr
         o/HofBOjuGCKil1ccbDAcM/ImIlRsh3+Lx9vvqMqHQurz42IawVE2DjaIKVmcPmZgut1
         r3NcGFvX8zOKudYZ2IPXozxXUCi86LRAkwmzc3nx2WJMM+f/f1S5QD1WFIEZjwEZk/eg
         QG8lXt+sOITg6LdU9UwCwjyQi/rLMW2FYX32phdHho9Owkh2n9qWw08N+3Bs80Tjh2AZ
         7OkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oiqcBp2KAElTs9dOPNYLnYvG9oB7g9MLqN9OAEFRAh8=;
        b=kizkezeBEp0XqHjjzW2PeHA1NuSzLQFN0upU4h5gJuqIKX2WuAB6dn3gT1d8/g4Jyx
         xFTl/ET8L72bdMVLvL2HthKjTHQU2/at3Sl6TEmfHFxSLhiyZrYm1YCurlteor221u46
         SIwkNgRgg4SnRGEwHIo37hq/gHHfZQP+7o9/vb2pUSqrwEJiCZSeeQ+RsakNCIiDt82i
         9Bzi1X3Y6BeWBdGdssMyAySM5iEyvz4pj7D8eDb1LHrDwTE7HHw5VzD5mz1WXQVdGjd/
         VbPtcTDrTLdL4oCq/QmcsVKc75V3VXxxxN2aDf3oLI8duyJEb68QLnaCTM2Yw2Hknft5
         JS/A==
X-Gm-Message-State: AOAM5303mj9OH7tfcgXCgnyP6erJ94mTYyYRdxzwacAwp9pqk9MFjic7
        ADp7/9DZiIm1jY4zwctn04g=
X-Google-Smtp-Source: ABdhPJznFmVOysGyh8qbi12W6KDlcHlq2prc82N13A5GdDq+QRQz9wv3b0H+ocfijkm+69YtlmMdug==
X-Received: by 2002:adf:fe05:: with SMTP id n5mr75061339wrr.9.1609631133148;
        Sat, 02 Jan 2021 15:45:33 -0800 (PST)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id w8sm82574750wrl.91.2021.01.02.15.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 15:45:32 -0800 (PST)
Date:   Sat, 2 Jan 2021 20:45:25 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] drm/vkms: Decouple config data for configfs
Message-ID: <20210102234525.l2j2s2rcd4p56rzr@smtp.gmail.com>
References: <20210102115557.qqfhohlx6yeo27vh@adolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210102115557.qqfhohlx6yeo27vh@adolin>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumera,

Thanks for your patch.
Please see some comments below.

On 01/02, Sumera Priyadarsini wrote:
> Currently, data for the device instance is held by vkms_device.
> Add a separate type, vkms_config to contain configuration details
> for the device and various modes to be later used by configfs.
> This config data stays constant once the device is created.
> 
> Accordingly, add vkms_create and vkms_destroy to initialize/destroy
> device through configfs. Currently, they are being called from vkms_init
> and vkms_exit, but will be evoked from configfs later on. When configfs
> is added, device configuration- enabling/disabling features will
> be tracked by configfs and only vkms device lifetime will be kept track of
> by vkms_init and vkms_exit functions.

I didn't quite understand this very last sentence.

> 
> Modify usage of enable_cursor feature to reflect the changes in
> relevant files.

Since the goal is also enabling/disabling writeback and vblank via a
future configfs support, it would be nice to see here this same cursor
adaptation applied to others, initially as a module parameter.  For
writeback, it's really straightforward...

> 
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> Co-developed-by: Daniel Vetter <danvet.vetter@ffwl.ch>

There are some formatting details for credits, for example, including
the co-developer s-o-b. See here:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

> ---
> Changes in v2:
> - add Co-developed-by tag
> 
> ---
>  drivers/gpu/drm/vkms/vkms_drv.c    | 40 ++++++++++++++++++++++++------
>  drivers/gpu/drm/vkms/vkms_drv.h    | 11 +++++---
>  drivers/gpu/drm/vkms/vkms_output.c |  4 +--
>  3 files changed, 42 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index aef29393b811..6b33975a5cb2 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -34,9 +34,9 @@
>  #define DRIVER_MAJOR	1
>  #define DRIVER_MINOR	0
>  
> -static struct vkms_device *vkms_device;
> +static struct vkms_config *default_config;
>  
> -bool enable_cursor = true;
> +static bool enable_cursor = true;
>  module_param_named(enable_cursor, enable_cursor, bool, 0444);
>  MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
>  
> @@ -122,10 +122,11 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
>  	return vkms_output_init(vkmsdev, 0);
>  }
>  
> -static int __init vkms_init(void)
> +static int vkms_create(struct vkms_config *config)
>  {
>  	int ret;
>  	struct platform_device *pdev;
> +	struct vkms_device *vkms_device;
>  
>  	pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
>  	if (IS_ERR(pdev))
> @@ -143,6 +144,8 @@ static int __init vkms_init(void)
>  		goto out_devres;
>  	}
>  	vkms_device->platform = pdev;
> +	vkms_device->config = config;
> +	config->dev = vkms_device;
>  
>  	ret = dma_coerce_mask_and_coherent(vkms_device->drm.dev,
>  					   DMA_BIT_MASK(64));
> @@ -179,21 +182,42 @@ static int __init vkms_init(void)
>  	return ret;
>  }
>  
> -static void __exit vkms_exit(void)
> +static int __init vkms_init(void)
> +{
> +	struct vkms_config *config = kmalloc(sizeof(*config), GFP_KERNEL);
> +
> +	default_config = config;
> +
> +	config->cursor = enable_cursor;
> +
> +	return vkms_create(config);
> +}
> +
> +static void vkms_destroy(struct vkms_config *config)
>  {
>  	struct platform_device *pdev;
>  
> -	if (!vkms_device) {
> +	if (!config->dev) {
>  		DRM_INFO("vkms_device is NULL.\n");
>  		return;
>  	}
>  
> -	pdev = vkms_device->platform;
> +	pdev = config->dev->platform;
>  
> -	drm_dev_unregister(&vkms_device->drm);
> -	drm_atomic_helper_shutdown(&vkms_device->drm);
> +	drm_dev_unregister(&config->dev->drm);
> +	drm_atomic_helper_shutdown(&config->dev->drm);
>  	devres_release_group(&pdev->dev, NULL);
>  	platform_device_unregister(pdev);
> +
> +	config->dev = NULL;
> +}
> +
> +static void __exit vkms_exit(void)
> +{
> +	if (default_config->dev)
> +		vkms_destroy(default_config);
> +
> +	kfree(default_config);
>  }
>  
>  module_init(vkms_init);
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 5ed91ff08cb3..2fa0c52f1dd8 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -19,8 +19,6 @@
>  #define XRES_MAX  8192
>  #define YRES_MAX  8192
>  
> -extern bool enable_cursor;
> -
>  struct vkms_composer {
>  	struct drm_framebuffer fb;
>  	struct drm_rect src, dst;
> @@ -82,10 +80,17 @@ struct vkms_output {
>  	spinlock_t composer_lock;
>  };
>  
> +struct vkms_device;
> +struct vkms_config {
> +	bool cursor;
> +	/* only set when instantiated */
> +	struct vkms_device *dev;
> +};
>  struct vkms_device {
>  	struct drm_device drm;
>  	struct platform_device *platform;
>  	struct vkms_output output;
> +	const struct vkms_config *config;
>  };
>  
>  #define drm_crtc_to_vkms_output(target) \
> @@ -123,4 +128,4 @@ void vkms_set_composer(struct vkms_output *out, bool enabled);
>  /* Writeback */
>  int vkms_enable_writeback_connector(struct vkms_device *vkmsdev);
>  
> -#endif /* _VKMS_DRV_H_ */
> +#endif /* _VKMS_DRV_H_ */
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 4a1848b0318f..8f3ffb28b9d1 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -46,7 +46,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
>  	if (IS_ERR(primary))
>  		return PTR_ERR(primary);
>  
> -	if (enable_cursor) {
> +	if (vkmsdev->config->cursor) {
>  		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, index);
>  		if (IS_ERR(cursor)) {
>  			ret = PTR_ERR(cursor);
> @@ -98,7 +98,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
>  	drm_crtc_cleanup(crtc);
>  
>  err_crtc:
> -	if (enable_cursor)
> +	if (vkmsdev->config->cursor)
>  		drm_plane_cleanup(cursor);
>  
>  err_cursor:
> -- 
> 2.25.1
> 

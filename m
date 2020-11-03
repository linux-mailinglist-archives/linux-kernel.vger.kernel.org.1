Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A0F2A44A2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 12:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgKCL5T convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Nov 2020 06:57:19 -0500
Received: from aposti.net ([89.234.176.197]:59548 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgKCL5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 06:57:18 -0500
Date:   Tue, 03 Nov 2020 11:56:53 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 5/5] drm/ingenic: Add option to alloc cached GEM buffers
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-Id: <TIY7JQ.DHN50AN4EDIS3@crapouillou.net>
In-Reply-To: <20201103101757.GZ401619@phenom.ffwll.local>
References: <20201102220651.22069-1-paul@crapouillou.net>
        <20201102220651.22069-6-paul@crapouillou.net>
        <20201103101757.GZ401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Le mar. 3 nov. 2020 à 11:17, Daniel Vetter <daniel@ffwll.ch> a écrit :
> On Mon, Nov 02, 2020 at 10:06:51PM +0000, Paul Cercueil wrote:
>>  With the module parameter ingenic-drm.cached_gem_buffers, it is 
>> possible
>>  to specify that we want GEM buffers backed by non-coherent memory.
>> 
>>  This dramatically speeds up software rendering on Ingenic SoCs, 
>> even for
>>  tasks where write-combine memory should in theory be faster (e.g. 
>> simple
>>  blits).
>> 
>>  Leave it disabled by default, since it is specific to one use-case
>>  (software rendering).
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> 
> Hm so maybe I'm making myself supremely unpopular here again with 
> being
> very late, but we have dev->mode_config.prefer_shadow for this. 
> Drivers
> should set this if software rendering is slow, and userspace should 
> follow
> this.
> 
> Now unfortunately it looks like most kms drivers don't bother setting
> this, and we're a lot worse.
> 
> So if "slow sw rendering" is the only reason, setting that flag is the
> right option.

The "prefer_shadow" is based on the assumption that rendering to a 
shadow buffer, then memcpy that buffer to the write-combine destination 
buffer, is faster than rendering to a non-coherent destination buffer 
and sync the data cache. This might be true on some hardware, but is 
not the case on Ingenic SoCs, where even simple blits (e.g. memcpy) are 
about three times faster using the second method.

-Paul

> Now the other thing is fbdev, since fbdev doesn't have this hint at 
> all.
> But we already have full generic fbdev shadow support (for defio), so 
> for
> that I think the best option is adding a force_shadow option to fbdev.
> 
> If we otoh do this here, and some drivers get a in-kernel shadow 
> support
> for kms, while others don't, then we have a pretty supreme mess. I'd 
> like
> to avoid that.
> 
> So maybe the right solution here is that we make sure that when you 
> have
> cma helpers set up that mode_config.prefer_shadow is set. Ideally only
> when coherent dma memory is uncached/write-combine and hence slow for 
> sw
> rendering. This might need a slight dma-api layering violation.
> 
> -Daniel
> 
>>  ---
>>   drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 58 
>> +++++++++++++++++++++--
>>   drivers/gpu/drm/ingenic/ingenic-drm.h     |  4 ++
>>   drivers/gpu/drm/ingenic/ingenic-ipu.c     | 12 ++++-
>>   3 files changed, 69 insertions(+), 5 deletions(-)
>> 
>>  diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c 
>> b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>>  index b9c156e13156..1ec2ec2faa04 100644
>>  --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>>  +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>>  @@ -9,6 +9,7 @@
>>   #include <linux/component.h>
>>   #include <linux/clk.h>
>>   #include <linux/dma-mapping.h>
>>  +#include <linux/io.h>
>>   #include <linux/module.h>
>>   #include <linux/mutex.h>
>>   #include <linux/of_device.h>
>>  @@ -22,6 +23,7 @@
>>   #include <drm/drm_color_mgmt.h>
>>   #include <drm/drm_crtc.h>
>>   #include <drm/drm_crtc_helper.h>
>>  +#include <drm/drm_damage_helper.h>
>>   #include <drm/drm_drv.h>
>>   #include <drm/drm_gem_cma_helper.h>
>>   #include <drm/drm_fb_cma_helper.h>
>>  @@ -97,6 +99,11 @@ struct ingenic_drm {
>>   	struct notifier_block clock_nb;
>>   };
>> 
>>  +static bool ingenic_drm_cached_gem_buf;
>>  +module_param_named(cached_gem_buffers, ingenic_drm_cached_gem_buf, 
>> bool, 0400);
>>  +MODULE_PARM_DESC(cached_gem_buffers,
>>  +		 "Enable fully cached GEM buffers [default=false]");
>>  +
>>   static bool ingenic_drm_writeable_reg(struct device *dev, unsigned 
>> int reg)
>>   {
>>   	switch (reg) {
>>  @@ -400,6 +407,8 @@ static int 
>> ingenic_drm_plane_atomic_check(struct drm_plane *plane,
>>   	     plane->state->fb->format->format != 
>> state->fb->format->format))
>>   		crtc_state->mode_changed = true;
>> 
>>  +	drm_atomic_helper_check_plane_damage(state->state, state);
>>  +
>>   	return 0;
>>   }
>> 
>>  @@ -531,6 +540,14 @@ static void ingenic_drm_update_palette(struct 
>> ingenic_drm *priv,
>>   	}
>>   }
>> 
>>  +void ingenic_drm_sync_data(struct device *dev,
>>  +			   struct drm_plane_state *old_state,
>>  +			   struct drm_plane_state *state)
>>  +{
>>  +	if (ingenic_drm_cached_gem_buf)
>>  +		drm_gem_cma_sync_data(dev, old_state, state);
>>  +}
>>  +
>>   static void ingenic_drm_plane_atomic_update(struct drm_plane 
>> *plane,
>>   					    struct drm_plane_state *oldstate)
>>   {
>>  @@ -543,6 +560,8 @@ static void 
>> ingenic_drm_plane_atomic_update(struct drm_plane *plane,
>>   	u32 fourcc;
>> 
>>   	if (state && state->fb) {
>>  +		ingenic_drm_sync_data(priv->dev, oldstate, state);
>>  +
>>   		crtc_state = state->crtc->state;
>> 
>>   		addr = drm_fb_cma_get_gem_addr(state->fb, state, 0);
>>  @@ -714,7 +733,36 @@ static void ingenic_drm_disable_vblank(struct 
>> drm_crtc *crtc)
>>   	regmap_update_bits(priv->map, JZ_REG_LCD_CTRL, 
>> JZ_LCD_CTRL_EOF_IRQ, 0);
>>   }
>> 
>>  -DEFINE_DRM_GEM_CMA_FOPS(ingenic_drm_fops);
>>  +static struct drm_framebuffer *
>>  +ingenic_drm_gem_fb_create(struct drm_device *dev, struct drm_file 
>> *file,
>>  +			  const struct drm_mode_fb_cmd2 *mode_cmd)
>>  +{
>>  +	if (ingenic_drm_cached_gem_buf)
>>  +		return drm_gem_fb_create_with_dirty(dev, file, mode_cmd);
>>  +
>>  +	return drm_gem_fb_create(dev, file, mode_cmd);
>>  +}
>>  +
>>  +static int ingenic_drm_gem_cma_mmap(struct file *filp,
>>  +				    struct vm_area_struct *vma)
>>  +{
>>  +	if (ingenic_drm_cached_gem_buf)
>>  +		return drm_gem_cma_mmap_noncoherent(filp, vma);
>>  +
>>  +	return drm_gem_cma_mmap(filp, vma);
>>  +}
>>  +
>>  +static const struct file_operations ingenic_drm_fops = {
>>  +	.owner		= THIS_MODULE,
>>  +	.open		= drm_open,
>>  +	.release	= drm_release,
>>  +	.unlocked_ioctl	= drm_ioctl,
>>  +	.compat_ioctl	= drm_compat_ioctl,
>>  +	.poll		= drm_poll,
>>  +	.read		= drm_read,
>>  +	.llseek		= noop_llseek,
>>  +	.mmap		= ingenic_drm_gem_cma_mmap,
>>  +};
>> 
>>   static struct drm_driver ingenic_drm_driver_data = {
>>   	.driver_features	= DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
>>  @@ -726,7 +774,7 @@ static struct drm_driver 
>> ingenic_drm_driver_data = {
>>   	.patchlevel		= 0,
>> 
>>   	.fops			= &ingenic_drm_fops,
>>  -	DRM_GEM_CMA_DRIVER_OPS,
>>  
>> +	DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE(drm_gem_cma_dumb_create_noncoherent),
>> 
>>   	.irq_handler		= ingenic_drm_irq_handler,
>>   };
>>  @@ -778,7 +826,7 @@ static const struct drm_encoder_helper_funcs 
>> ingenic_drm_encoder_helper_funcs =
>>   };
>> 
>>   static const struct drm_mode_config_funcs 
>> ingenic_drm_mode_config_funcs = {
>>  -	.fb_create		= drm_gem_fb_create,
>>  +	.fb_create		= ingenic_drm_gem_fb_create,
>>   	.output_poll_changed	= drm_fb_helper_output_poll_changed,
>>   	.atomic_check		= drm_atomic_helper_check,
>>   	.atomic_commit		= drm_atomic_helper_commit,
>>  @@ -932,6 +980,8 @@ static int ingenic_drm_bind(struct device *dev, 
>> bool has_components)
>>   		return ret;
>>   	}
>> 
>>  +	drm_plane_enable_fb_damage_clips(&priv->f1);
>>  +
>>   	drm_crtc_helper_add(&priv->crtc, &ingenic_drm_crtc_helper_funcs);
>> 
>>   	ret = drm_crtc_init_with_planes(drm, &priv->crtc, &priv->f1,
>>  @@ -960,6 +1010,8 @@ static int ingenic_drm_bind(struct device 
>> *dev, bool has_components)
>>   			return ret;
>>   		}
>> 
>>  +		drm_plane_enable_fb_damage_clips(&priv->f0);
>>  +
>>   		if (IS_ENABLED(CONFIG_DRM_INGENIC_IPU) && has_components) {
>>   			ret = component_bind_all(dev, drm);
>>   			if (ret) {
>>  diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.h 
>> b/drivers/gpu/drm/ingenic/ingenic-drm.h
>>  index 9b48ce02803d..ee3a892c0383 100644
>>  --- a/drivers/gpu/drm/ingenic/ingenic-drm.h
>>  +++ b/drivers/gpu/drm/ingenic/ingenic-drm.h
>>  @@ -171,6 +171,10 @@ void ingenic_drm_plane_config(struct device 
>> *dev,
>>   			      struct drm_plane *plane, u32 fourcc);
>>   void ingenic_drm_plane_disable(struct device *dev, struct 
>> drm_plane *plane);
>> 
>>  +void ingenic_drm_sync_data(struct device *dev,
>>  +			   struct drm_plane_state *old_state,
>>  +			   struct drm_plane_state *state);
>>  +
>>   extern struct platform_driver *ingenic_ipu_driver_ptr;
>> 
>>   #endif /* DRIVERS_GPU_DRM_INGENIC_INGENIC_DRM_H */
>>  diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c 
>> b/drivers/gpu/drm/ingenic/ingenic-ipu.c
>>  index fc8c6e970ee3..38c83e8cc6a5 100644
>>  --- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
>>  +++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
>>  @@ -20,6 +20,7 @@
>> 
>>   #include <drm/drm_atomic.h>
>>   #include <drm/drm_atomic_helper.h>
>>  +#include <drm/drm_damage_helper.h>
>>   #include <drm/drm_drv.h>
>>   #include <drm/drm_fb_cma_helper.h>
>>   #include <drm/drm_fourcc.h>
>>  @@ -316,6 +317,8 @@ static void 
>> ingenic_ipu_plane_atomic_update(struct drm_plane *plane,
>>   				JZ_IPU_CTRL_CHIP_EN | JZ_IPU_CTRL_LCDC_SEL);
>>   	}
>> 
>>  +	ingenic_drm_sync_data(ipu->master, oldstate, state);
>>  +
>>   	/* New addresses will be committed in vblank handler... */
>>   	ipu->addr_y = drm_fb_cma_get_gem_addr(state->fb, state, 0);
>>   	if (finfo->num_planes > 1)
>>  @@ -534,7 +537,7 @@ static int 
>> ingenic_ipu_plane_atomic_check(struct drm_plane *plane,
>> 
>>   	if (!state->crtc ||
>>   	    !crtc_state->mode.hdisplay || !crtc_state->mode.vdisplay)
>>  -		return 0;
>>  +		goto out_check_damage;
>> 
>>   	/* Plane must be fully visible */
>>   	if (state->crtc_x < 0 || state->crtc_y < 0 ||
>>  @@ -551,7 +554,7 @@ static int 
>> ingenic_ipu_plane_atomic_check(struct drm_plane *plane,
>>   		return -EINVAL;
>> 
>>   	if (!osd_changed(state, plane->state))
>>  -		return 0;
>>  +		goto out_check_damage;
>> 
>>   	crtc_state->mode_changed = true;
>> 
>>  @@ -578,6 +581,9 @@ static int 
>> ingenic_ipu_plane_atomic_check(struct drm_plane *plane,
>>   	ipu->denom_w = denom_w;
>>   	ipu->denom_h = denom_h;
>> 
>>  +out_check_damage:
>>  +	drm_atomic_helper_check_plane_damage(state->state, state);
>>  +
>>   	return 0;
>>   }
>> 
>>  @@ -759,6 +765,8 @@ static int ingenic_ipu_bind(struct device *dev, 
>> struct device *master, void *d)
>>   		return err;
>>   	}
>> 
>>  +	drm_plane_enable_fb_damage_clips(plane);
>>  +
>>   	/*
>>   	 * Sharpness settings range is [0,32]
>>   	 * 0       : nearest-neighbor
>>  --
>>  2.28.0
>> 
> 
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch



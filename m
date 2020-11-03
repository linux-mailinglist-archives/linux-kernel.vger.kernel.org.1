Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE502A4591
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgKCMwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgKCMww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:52:52 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190CCC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 04:52:51 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id z16so10643046otq.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 04:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mbeR1WgNoVOIWFIyNrSnvwP8bnhhOsmRlDiRcONko1I=;
        b=A7AOs5LON28JiD0vkuRuCj71QkclWBsS3X1DoHFUQuPc6q+eZJbGWUvraVVxnVK5cS
         z0LKpnFxpn9bKWvbotaLNS6sDs06ngtdPVZtswFBOM6q5NwF/dmcu2NYwM+01WAxBE1a
         5EIqSYIUbXTbW9lZQrE0vIJTUQnOKkY9DcASs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mbeR1WgNoVOIWFIyNrSnvwP8bnhhOsmRlDiRcONko1I=;
        b=NBi6l7jPZGoLDiyq+5GVzp9Lh8stWMs/Ffhm1i1Q3W5I9O9x9yuV26+uhNyGRdEmr9
         LG/L7xGH2FPmp+Ex0Pd7byBF2EER405u07TZt4zMht41vWM8qoAZgcRAq52hKEC6luZK
         uX/DRekSOG0ihMk9as3FpIyl8cx6smFOTMDiBa9Js2ck3x8afrMC3rpW+OrvRHCfAuEx
         eFr6wBJhN9/OlndLjafL96UN9yXRqwH4iw6cafYhaZUZWsQG48yHLNue7qjFWlztAFo6
         4zrZKaD7tca/2REtDZvUjjWnZjHlckC86WLQ11qFmm/T2gpmWoEdOtCp12W0Ibax5Who
         JYGg==
X-Gm-Message-State: AOAM530bIjbxwSccZhOwAwgMyi4PYsIm6egGRZ28ZSJGKqs2QUr+2Jt7
        48EoRUP+ezOxTal5+eHPq052Aaw4p4mlaZdwbm/DxQ==
X-Google-Smtp-Source: ABdhPJyPQgdqKkoqyEgscx0xuVJUacM6pZCsbmH/OauTGOeVNpmWIduDY6G3M6B6ki2Cj6FL+idoPQzPsT/Ox0godpg=
X-Received: by 2002:a05:6830:1647:: with SMTP id h7mr16264711otr.281.1604407970260;
 Tue, 03 Nov 2020 04:52:50 -0800 (PST)
MIME-Version: 1.0
References: <20201102220651.22069-1-paul@crapouillou.net> <20201102220651.22069-6-paul@crapouillou.net>
 <20201103101757.GZ401619@phenom.ffwll.local> <TIY7JQ.DHN50AN4EDIS3@crapouillou.net>
In-Reply-To: <TIY7JQ.DHN50AN4EDIS3@crapouillou.net>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 3 Nov 2020 13:52:39 +0100
Message-ID: <CAKMK7uHhAzJZSaxcwNRtFRacjGNRvGweYu9D8gZh-gP=EFjeAA@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/ingenic: Add option to alloc cached GEM buffers
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, od@zcrc.me,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 12:57 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Daniel,
>
> Le mar. 3 nov. 2020 =C3=A0 11:17, Daniel Vetter <daniel@ffwll.ch> a =C3=
=A9crit :
> > On Mon, Nov 02, 2020 at 10:06:51PM +0000, Paul Cercueil wrote:
> >>  With the module parameter ingenic-drm.cached_gem_buffers, it is
> >> possible
> >>  to specify that we want GEM buffers backed by non-coherent memory.
> >>
> >>  This dramatically speeds up software rendering on Ingenic SoCs,
> >> even for
> >>  tasks where write-combine memory should in theory be faster (e.g.
> >> simple
> >>  blits).
> >>
> >>  Leave it disabled by default, since it is specific to one use-case
> >>  (software rendering).
> >>
> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >
> > Hm so maybe I'm making myself supremely unpopular here again with
> > being
> > very late, but we have dev->mode_config.prefer_shadow for this.
> > Drivers
> > should set this if software rendering is slow, and userspace should
> > follow
> > this.
> >
> > Now unfortunately it looks like most kms drivers don't bother setting
> > this, and we're a lot worse.
> >
> > So if "slow sw rendering" is the only reason, setting that flag is the
> > right option.
>
> The "prefer_shadow" is based on the assumption that rendering to a
> shadow buffer, then memcpy that buffer to the write-combine destination
> buffer, is faster than rendering to a non-coherent destination buffer
> and sync the data cache. This might be true on some hardware, but is
> not the case on Ingenic SoCs, where even simple blits (e.g. memcpy) are
> about three times faster using the second method.

Ah right, vague memories coming back, pretty sure I asked this before.
Please include this in your commit message (and ideally also in some
code comment somewhere), since otherwise I'll keep asking the same
question every single time you submit this or I stumble over it again
:-)

Cheers, Daniel

>
> -Paul
>
> > Now the other thing is fbdev, since fbdev doesn't have this hint at
> > all.
> > But we already have full generic fbdev shadow support (for defio), so
> > for
> > that I think the best option is adding a force_shadow option to fbdev.
> >
> > If we otoh do this here, and some drivers get a in-kernel shadow
> > support
> > for kms, while others don't, then we have a pretty supreme mess. I'd
> > like
> > to avoid that.
> >
> > So maybe the right solution here is that we make sure that when you
> > have
> > cma helpers set up that mode_config.prefer_shadow is set. Ideally only
> > when coherent dma memory is uncached/write-combine and hence slow for
> > sw
> > rendering. This might need a slight dma-api layering violation.
> >
> > -Daniel
> >
> >>  ---
> >>   drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 58
> >> +++++++++++++++++++++--
> >>   drivers/gpu/drm/ingenic/ingenic-drm.h     |  4 ++
> >>   drivers/gpu/drm/ingenic/ingenic-ipu.c     | 12 ++++-
> >>   3 files changed, 69 insertions(+), 5 deletions(-)
> >>
> >>  diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> >> b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> >>  index b9c156e13156..1ec2ec2faa04 100644
> >>  --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> >>  +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> >>  @@ -9,6 +9,7 @@
> >>   #include <linux/component.h>
> >>   #include <linux/clk.h>
> >>   #include <linux/dma-mapping.h>
> >>  +#include <linux/io.h>
> >>   #include <linux/module.h>
> >>   #include <linux/mutex.h>
> >>   #include <linux/of_device.h>
> >>  @@ -22,6 +23,7 @@
> >>   #include <drm/drm_color_mgmt.h>
> >>   #include <drm/drm_crtc.h>
> >>   #include <drm/drm_crtc_helper.h>
> >>  +#include <drm/drm_damage_helper.h>
> >>   #include <drm/drm_drv.h>
> >>   #include <drm/drm_gem_cma_helper.h>
> >>   #include <drm/drm_fb_cma_helper.h>
> >>  @@ -97,6 +99,11 @@ struct ingenic_drm {
> >>      struct notifier_block clock_nb;
> >>   };
> >>
> >>  +static bool ingenic_drm_cached_gem_buf;
> >>  +module_param_named(cached_gem_buffers, ingenic_drm_cached_gem_buf,
> >> bool, 0400);
> >>  +MODULE_PARM_DESC(cached_gem_buffers,
> >>  +            "Enable fully cached GEM buffers [default=3Dfalse]");
> >>  +
> >>   static bool ingenic_drm_writeable_reg(struct device *dev, unsigned
> >> int reg)
> >>   {
> >>      switch (reg) {
> >>  @@ -400,6 +407,8 @@ static int
> >> ingenic_drm_plane_atomic_check(struct drm_plane *plane,
> >>           plane->state->fb->format->format !=3D
> >> state->fb->format->format))
> >>              crtc_state->mode_changed =3D true;
> >>
> >>  +   drm_atomic_helper_check_plane_damage(state->state, state);
> >>  +
> >>      return 0;
> >>   }
> >>
> >>  @@ -531,6 +540,14 @@ static void ingenic_drm_update_palette(struct
> >> ingenic_drm *priv,
> >>      }
> >>   }
> >>
> >>  +void ingenic_drm_sync_data(struct device *dev,
> >>  +                      struct drm_plane_state *old_state,
> >>  +                      struct drm_plane_state *state)
> >>  +{
> >>  +   if (ingenic_drm_cached_gem_buf)
> >>  +           drm_gem_cma_sync_data(dev, old_state, state);
> >>  +}
> >>  +
> >>   static void ingenic_drm_plane_atomic_update(struct drm_plane
> >> *plane,
> >>                                          struct drm_plane_state *oldst=
ate)
> >>   {
> >>  @@ -543,6 +560,8 @@ static void
> >> ingenic_drm_plane_atomic_update(struct drm_plane *plane,
> >>      u32 fourcc;
> >>
> >>      if (state && state->fb) {
> >>  +           ingenic_drm_sync_data(priv->dev, oldstate, state);
> >>  +
> >>              crtc_state =3D state->crtc->state;
> >>
> >>              addr =3D drm_fb_cma_get_gem_addr(state->fb, state, 0);
> >>  @@ -714,7 +733,36 @@ static void ingenic_drm_disable_vblank(struct
> >> drm_crtc *crtc)
> >>      regmap_update_bits(priv->map, JZ_REG_LCD_CTRL,
> >> JZ_LCD_CTRL_EOF_IRQ, 0);
> >>   }
> >>
> >>  -DEFINE_DRM_GEM_CMA_FOPS(ingenic_drm_fops);
> >>  +static struct drm_framebuffer *
> >>  +ingenic_drm_gem_fb_create(struct drm_device *dev, struct drm_file
> >> *file,
> >>  +                     const struct drm_mode_fb_cmd2 *mode_cmd)
> >>  +{
> >>  +   if (ingenic_drm_cached_gem_buf)
> >>  +           return drm_gem_fb_create_with_dirty(dev, file, mode_cmd);
> >>  +
> >>  +   return drm_gem_fb_create(dev, file, mode_cmd);
> >>  +}
> >>  +
> >>  +static int ingenic_drm_gem_cma_mmap(struct file *filp,
> >>  +                               struct vm_area_struct *vma)
> >>  +{
> >>  +   if (ingenic_drm_cached_gem_buf)
> >>  +           return drm_gem_cma_mmap_noncoherent(filp, vma);
> >>  +
> >>  +   return drm_gem_cma_mmap(filp, vma);
> >>  +}
> >>  +
> >>  +static const struct file_operations ingenic_drm_fops =3D {
> >>  +   .owner          =3D THIS_MODULE,
> >>  +   .open           =3D drm_open,
> >>  +   .release        =3D drm_release,
> >>  +   .unlocked_ioctl =3D drm_ioctl,
> >>  +   .compat_ioctl   =3D drm_compat_ioctl,
> >>  +   .poll           =3D drm_poll,
> >>  +   .read           =3D drm_read,
> >>  +   .llseek         =3D noop_llseek,
> >>  +   .mmap           =3D ingenic_drm_gem_cma_mmap,
> >>  +};
> >>
> >>   static struct drm_driver ingenic_drm_driver_data =3D {
> >>      .driver_features        =3D DRIVER_MODESET | DRIVER_GEM | DRIVER_=
ATOMIC,
> >>  @@ -726,7 +774,7 @@ static struct drm_driver
> >> ingenic_drm_driver_data =3D {
> >>      .patchlevel             =3D 0,
> >>
> >>      .fops                   =3D &ingenic_drm_fops,
> >>  -   DRM_GEM_CMA_DRIVER_OPS,
> >>
> >> +    DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE(drm_gem_cma_dumb_create_n=
oncoherent),
> >>
> >>      .irq_handler            =3D ingenic_drm_irq_handler,
> >>   };
> >>  @@ -778,7 +826,7 @@ static const struct drm_encoder_helper_funcs
> >> ingenic_drm_encoder_helper_funcs =3D
> >>   };
> >>
> >>   static const struct drm_mode_config_funcs
> >> ingenic_drm_mode_config_funcs =3D {
> >>  -   .fb_create              =3D drm_gem_fb_create,
> >>  +   .fb_create              =3D ingenic_drm_gem_fb_create,
> >>      .output_poll_changed    =3D drm_fb_helper_output_poll_changed,
> >>      .atomic_check           =3D drm_atomic_helper_check,
> >>      .atomic_commit          =3D drm_atomic_helper_commit,
> >>  @@ -932,6 +980,8 @@ static int ingenic_drm_bind(struct device *dev,
> >> bool has_components)
> >>              return ret;
> >>      }
> >>
> >>  +   drm_plane_enable_fb_damage_clips(&priv->f1);
> >>  +
> >>      drm_crtc_helper_add(&priv->crtc, &ingenic_drm_crtc_helper_funcs);
> >>
> >>      ret =3D drm_crtc_init_with_planes(drm, &priv->crtc, &priv->f1,
> >>  @@ -960,6 +1010,8 @@ static int ingenic_drm_bind(struct device
> >> *dev, bool has_components)
> >>                      return ret;
> >>              }
> >>
> >>  +           drm_plane_enable_fb_damage_clips(&priv->f0);
> >>  +
> >>              if (IS_ENABLED(CONFIG_DRM_INGENIC_IPU) && has_components)=
 {
> >>                      ret =3D component_bind_all(dev, drm);
> >>                      if (ret) {
> >>  diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.h
> >> b/drivers/gpu/drm/ingenic/ingenic-drm.h
> >>  index 9b48ce02803d..ee3a892c0383 100644
> >>  --- a/drivers/gpu/drm/ingenic/ingenic-drm.h
> >>  +++ b/drivers/gpu/drm/ingenic/ingenic-drm.h
> >>  @@ -171,6 +171,10 @@ void ingenic_drm_plane_config(struct device
> >> *dev,
> >>                            struct drm_plane *plane, u32 fourcc);
> >>   void ingenic_drm_plane_disable(struct device *dev, struct
> >> drm_plane *plane);
> >>
> >>  +void ingenic_drm_sync_data(struct device *dev,
> >>  +                      struct drm_plane_state *old_state,
> >>  +                      struct drm_plane_state *state);
> >>  +
> >>   extern struct platform_driver *ingenic_ipu_driver_ptr;
> >>
> >>   #endif /* DRIVERS_GPU_DRM_INGENIC_INGENIC_DRM_H */
> >>  diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c
> >> b/drivers/gpu/drm/ingenic/ingenic-ipu.c
> >>  index fc8c6e970ee3..38c83e8cc6a5 100644
> >>  --- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
> >>  +++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
> >>  @@ -20,6 +20,7 @@
> >>
> >>   #include <drm/drm_atomic.h>
> >>   #include <drm/drm_atomic_helper.h>
> >>  +#include <drm/drm_damage_helper.h>
> >>   #include <drm/drm_drv.h>
> >>   #include <drm/drm_fb_cma_helper.h>
> >>   #include <drm/drm_fourcc.h>
> >>  @@ -316,6 +317,8 @@ static void
> >> ingenic_ipu_plane_atomic_update(struct drm_plane *plane,
> >>                              JZ_IPU_CTRL_CHIP_EN | JZ_IPU_CTRL_LCDC_SE=
L);
> >>      }
> >>
> >>  +   ingenic_drm_sync_data(ipu->master, oldstate, state);
> >>  +
> >>      /* New addresses will be committed in vblank handler... */
> >>      ipu->addr_y =3D drm_fb_cma_get_gem_addr(state->fb, state, 0);
> >>      if (finfo->num_planes > 1)
> >>  @@ -534,7 +537,7 @@ static int
> >> ingenic_ipu_plane_atomic_check(struct drm_plane *plane,
> >>
> >>      if (!state->crtc ||
> >>          !crtc_state->mode.hdisplay || !crtc_state->mode.vdisplay)
> >>  -           return 0;
> >>  +           goto out_check_damage;
> >>
> >>      /* Plane must be fully visible */
> >>      if (state->crtc_x < 0 || state->crtc_y < 0 ||
> >>  @@ -551,7 +554,7 @@ static int
> >> ingenic_ipu_plane_atomic_check(struct drm_plane *plane,
> >>              return -EINVAL;
> >>
> >>      if (!osd_changed(state, plane->state))
> >>  -           return 0;
> >>  +           goto out_check_damage;
> >>
> >>      crtc_state->mode_changed =3D true;
> >>
> >>  @@ -578,6 +581,9 @@ static int
> >> ingenic_ipu_plane_atomic_check(struct drm_plane *plane,
> >>      ipu->denom_w =3D denom_w;
> >>      ipu->denom_h =3D denom_h;
> >>
> >>  +out_check_damage:
> >>  +   drm_atomic_helper_check_plane_damage(state->state, state);
> >>  +
> >>      return 0;
> >>   }
> >>
> >>  @@ -759,6 +765,8 @@ static int ingenic_ipu_bind(struct device *dev,
> >> struct device *master, void *d)
> >>              return err;
> >>      }
> >>
> >>  +   drm_plane_enable_fb_damage_clips(plane);
> >>  +
> >>      /*
> >>       * Sharpness settings range is [0,32]
> >>       * 0       : nearest-neighbor
> >>  --
> >>  2.28.0
> >>
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
>
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

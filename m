Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABC226E448
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgIQSnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:43:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726366AbgIQSnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600368197;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3YNQVnEuBKgoNoOeSf/PGT265VJnw8WjVqokOBI4jU=;
        b=ZM1aKL81vme2mX8Lwzo6wKqxssnqd/2sGwFdLOwCnTs1KBJcVXp1iu/YzoZ537bkEswhGD
        i+26YgGa30ZUVfzcbOR5Ajvf+aMM3HJHI3wX7iwD43PCucv0lLFRkj3m+jh/gDN9kzHnT+
        pLyl42ImFZ71LPmy7f2oBwYdqmPWJBY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-5ARzEGOENKyI3es496KxNw-1; Thu, 17 Sep 2020 14:43:14 -0400
X-MC-Unique: 5ARzEGOENKyI3es496KxNw-1
Received: by mail-qv1-f69.google.com with SMTP id i17so2057269qvj.22
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=X3YNQVnEuBKgoNoOeSf/PGT265VJnw8WjVqokOBI4jU=;
        b=R5nyqTGQiyGuasjQng4BT4GLWgdgY1x0L4W8VGFWswmDzLMJNHga9cJsqjCUsSC6YM
         GCAt3KofA+jp4Bjdt9JhveSFo3jr7D6ndTE5LRYhTgAc4MIklI4+K4ON8ix2m3zvDEBK
         5oNRUaJNurBOthxR+mDDi/qmFdsSgWXJn7b6bSZ7Uq8+Fi8MHw2r1BSZIZuoD1P8grrt
         dz0lWZXKSG5NIPXrIFbuoF+kbeAUBeMvaLqEK7z13bxS5F98IZ/RGhU6gz/j0DGwAU/d
         OImFnX+s3O/+VDqyta2joDF7Rl1dGsppB/owLHgrDVKTS9ExXVIYjKe3O9ESkASPmCP3
         fxEQ==
X-Gm-Message-State: AOAM531z2w/MN1rRnML9lpk7ad2giSBmELt4MUnSuiVUpJ24A1vwiRY2
        Ip4Dke/kBKvm9Ehp3Llu1gQ30/ExsMaAfSuZmQZSNTCiIiD1SSicp7p59nNAx0O0TAfnr+EWa/k
        Zd7s2q8xgOq1lqNGk4hSB6up5
X-Received: by 2002:a37:d41:: with SMTP id 62mr28143140qkn.444.1600368193677;
        Thu, 17 Sep 2020 11:43:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxk05EjX7xa4fRonNyj7Mx6EBr991YUqmf+oiqoc5wCLLzGZb5RBN6j4SU3TcogZaG/7aXr+g==
X-Received: by 2002:a37:d41:: with SMTP id 62mr28143102qkn.444.1600368193202;
        Thu, 17 Sep 2020 11:43:13 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id t26sm445203qkt.29.2020.09.17.11.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 11:43:12 -0700 (PDT)
Message-ID: <be7332a49139dd12e3569b35ce4533f6bf415db4.camel@redhat.com>
Subject: Re: [PATCH] i915: Introduce quirk for shifting eDP brightness.
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Puthikorn Voravootivat <puthik@chromium.org>
Cc:     Kevin Chowski <chowski@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Hans de Goede <hdegoede@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        dri-devel@lists.freedesktop.org
Date:   Thu, 17 Sep 2020 14:43:11 -0400
In-Reply-To: <20200917182535.GC6112@intel.com>
References: <20200917110838.1.I63d52f5b96d7e81e1e2dc2a72c4bf5fd84d3d3d0@changeid>
         <87o8m4uxcn.fsf@intel.com>
         <CANM=9DOn9wvL1RBDhxzawY1rRq0PFUBmKdXUGmG1CygApK1Vyg@mail.gmail.com>
         <CANCcNXc18jEXF+wdLm8sxR3ySR88D8S65a2x_vYtR5ihZ6XnMw@mail.gmail.com>
         <20200917182535.GC6112@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-09-17 at 21:25 +0300, Ville Syrjälä wrote:
> On Thu, Sep 17, 2020 at 11:14:43AM -0700, Puthikorn Voravootivat wrote:
> > The Lyude fde7266fb2f6 change is actually based on Chromium change
> > (https://crrev.com/c/1650325) that fixes the brightness for Samsung
> > Galaxy Chromebook. So currently we have 2 examples that use LSB
> > interpretation and 1 that use MSB.
> 
> "If field 4:0 of the EDP_PWMGEN_BIT_COUNT register represents a value
> of greater than 8 and the BACKLIGHT_BRIGHTNESS_BYTE_COUNT bit
> is cleared to 0, only the 8 MSB of the brightness control value can be
> controlled.
> (See Note below.)
> Assigned bits are allocated to the MSB of the enabled register
> combination."
> 
> I think that's pretty clear the assigned bits are supposed to be
> msb aligned.

Are we sure that isn't just referring to the DP_EDP_BACKLIGHT_BRIGHTNESS_MSB
register, as opposed to alignment of the whole value in that register? My
understanding of this was just that if there wasn't a pwmgen bit count
specified, that the backlight level would just be written to
DP_EDP_BACKLIGHT_BRIGHTNESS_MSB and DP_EDP_BACKLIGHT_BRIGHTNESS_LSB would be
ignored. 

Hopefully I'm not misunderstanding Ville, but I don't think so since the current
code we have already follows the understanding I just gave:

	vals[0] = level;

	/* Write the MSB and/or LSB */
	if (intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_BYTE_COUNT) {
		vals[0] = (level & 0xFF00) >> 8;
		vals[1] = (level & 0xFF);
	}

(vals[0] == MSB)
> 
> > 
> > On Thu, Sep 17, 2020 at 10:55 AM Kevin Chowski <chowski@chromium.org> wrote:
> > > Apologies for being too vague. To be as precise I can be, here is the
> > > specific code delta I tested: https://crrev.com/c/2406616 . To answer
> > > your other question, the code I tested against is indeed including the
> > > fde7266fb2f6 (despite ostensibly being called 5.4 in my commit
> > > message): our current top-of-tree for our 5.4 branch includes the
> > > intel_dp_aux_calc_max_backlight logic. Further, I'll note that change
> > > is exactly the change which breaks my Pixelbook model: prior to the
> > > change, the max_brightness was hard-coded to 0xFFFF and the math
> > > worked out that it didn't matter that the hardware cared about the MSB
> > > despite the driver code caring about the LSB.
> > > 
> > > To answer Ville's question: the fde7266fb2f6 change which fixes one
> > > laptop (I believe Thinkpad X1 extreme Gen 2, from some bug reports I
> > > dug up) and breaks another (Pixelbook); so unfortunately I believe we
> > > need a quirk at least for some laptop. Reading through the copy of the
> > > datasheet I have, it wasn't clear to me which was the correct
> > > interpretation. I'm cc'ing puthik@, who was leaning toward the current
> > > kernel code (caring about LSB) being the correct interpretation. I
> > > believe we have other chromebooks which do rely on LSB functionality,
> > > so unless we can find more examples of laptops wanting MSB it
> > > currently looks like Pixelbook is the outlier.
> > > 
> > > On Thu, Sep 17, 2020 at 11:28 AM Jani Nikula
> > > <jani.nikula@linux.intel.com> wrote:
> > > > On Thu, 17 Sep 2020, Kevin Chowski <chowski@chromium.org> wrote:
> > > > > We have observed that Google Pixelbook's backlight hardware is
> > > > > interpretting these backlight bits from the most-significant side of
> > > > > the
> > > > > 16 bit word (if DP_EDP_PWMGEN_BIT_COUNT < 16), whereas the driver code
> > > > > assumes the peripheral cares about the least-significant bits.
> > > > > 
> > > > > Testing was done from within Chrome OS's build environment when the
> > > > > patch is backported to 5.4 (the version we are newly targeting for the
> > > > > Pixelbook); for the record:
> > > > >    $ emerge-eve-kernelnext sys-kernel/chromeos-kernel-5_4 && \
> > > > >       ./update_kernel.sh --remote=$IP
> > > > > 
> > > > > I used `/sys/kernel/debug/dri/0/eDP-1/i915_dpcd` on my laptop to
> > > > > verify
> > > > > that the registers were being set according to what the actual
> > > > > hardware
> > > > > expects; I also observe that the backlight is noticeably brighter with
> > > > > this patch.
> > > > 
> > > > It's unclear to me what kernel version this is against, and what you've
> > > > actually tested.
> > > > 
> > > > Have you tried v5.7 kernel with Lyude's fde7266fb2f6 ("drm/i915: Fix eDP
> > > > DPCD aux max backlight calculations")?
> > > > 
> > > > I just want to make sure you've tested with all the relevant fixes
> > > > before adding quirks.
> > > > 
> > > > BR,
> > > > Jani.
> > > > 
> > > > > Signed-off-by: Kevin Chowski <chowski@chromium.org>
> > > > > ---
> > > > > 
> > > > >  .../drm/i915/display/intel_dp_aux_backlight.c | 34
> > > > > +++++++++++++++++++
> > > > >  drivers/gpu/drm/i915/display/intel_quirks.c   | 13 +++++++
> > > > >  drivers/gpu/drm/i915/i915_drv.h               |  1 +
> > > > >  3 files changed, 48 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > > > > b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > > > > index acbd7eb66cbe3..99c98f217356d 100644
> > > > > --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > > > > +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > > > > @@ -91,6 +91,23 @@ static u32 intel_dp_aux_get_backlight(struct
> > > > > intel_connector *connector)
> > > > >       if (intel_dp->edp_dpcd[2] &
> > > > > DP_EDP_BACKLIGHT_BRIGHTNESS_BYTE_COUNT)
> > > > >               level = (read_val[0] << 8 | read_val[1]);
> > > > > 
> > > > > +     if (i915->quirks & QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS) {
> > > > > +             if (!drm_dp_dpcd_readb(&intel_dp->aux,
> > > > > DP_EDP_PWMGEN_BIT_COUNT,
> > > > > +                                             &read_val[0])) {
> > > > > +                     DRM_DEBUG_KMS("Failed to read DPCD register
> > > > > 0x%x\n",
> > > > > +                                     DP_EDP_PWMGEN_BIT_COUNT);
> > > > > +                     return 0;
> > > > > +             }
> > > > > +             // Only bits 4:0 are used, 7:5 are reserved.
> > > > > +             read_val[0] = read_val[0] & 0x1F;
> > > > > +             if (read_val[0] > 16) {
> > > > > +                     DRM_DEBUG_KMS("Invalid DP_EDP_PWNGEN_BIT_COUNT
> > > > > 0x%X, expected at most 16\n",
> > > > > +                                             read_val[0]);
> > > > > +                     return 0;
> > > > > +             }
> > > > > +             level >>= 16 - read_val[0];
> > > > > +     }
> > > > > +
> > > > >       return level;
> > > > >  }
> > > > > 
> > > > > @@ -106,6 +123,23 @@ intel_dp_aux_set_backlight(const struct
> > > > > drm_connector_state *conn_state, u32 lev
> > > > >       struct drm_i915_private *i915 = dp_to_i915(intel_dp);
> > > > >       u8 vals[2] = { 0x0 };
> > > > > 
> > > > > +     if (i915->quirks & QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS) {
> > > > > +             if (!drm_dp_dpcd_readb(&intel_dp->aux,
> > > > > DP_EDP_PWMGEN_BIT_COUNT,
> > > > > +                                             &vals[0])) {
> > > > > +                     DRM_DEBUG_KMS("Failed to write aux backlight
> > > > > level: Failed to read DPCD register 0x%x\n",
> > > > > +                                       DP_EDP_PWMGEN_BIT_COUNT);
> > > > > +                     return;
> > > > > +             }
> > > > > +             // Only bits 4:0 are used, 7:5 are reserved.
> > > > > +             vals[0] = vals[0] & 0x1F;
> > > > > +             if (vals[0] > 16) {
> > > > > +                     DRM_DEBUG_KMS("Failed to write aux backlight
> > > > > level: Invalid DP_EDP_PWNGEN_BIT_COUNT 0x%X, expected at most 16\n",
> > > > > +                                             vals[0]);
> > > > > +                     return;
> > > > > +             }
> > > > > +             level <<= (16 - vals[0]) & 0xFFFF;
> > > > > +     }
> > > > > +
> > > > >       vals[0] = level;
> > > > > 
> > > > >       /* Write the MSB and/or LSB */
> > > > > diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c
> > > > > b/drivers/gpu/drm/i915/display/intel_quirks.c
> > > > > index 46beb155d835f..63b27d49b2864 100644
> > > > > --- a/drivers/gpu/drm/i915/display/intel_quirks.c
> > > > > +++ b/drivers/gpu/drm/i915/display/intel_quirks.c
> > > > > @@ -53,6 +53,16 @@ static void quirk_increase_ddi_disabled_time(struct
> > > > > drm_i915_private *i915)
> > > > >       drm_info(&i915->drm, "Applying Increase DDI Disabled quirk\n");
> > > > >  }
> > > > > 
> > > > > +/*
> > > > > + * Some eDP backlight hardware uses the most-significant bits of the
> > > > > brightness
> > > > > + * register, so brightness values must be shifted first.
> > > > > + */
> > > > > +static void quirk_shift_edp_backlight_brightness(struct
> > > > > drm_i915_private *i915)
> > > > > +{
> > > > > +     i915->quirks |= QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS;
> > > > > +     DRM_INFO("Applying shift eDP backlight brightness quirk\n");
> > > > > +}
> > > > > +
> > > > >  struct intel_quirk {
> > > > >       int device;
> > > > >       int subsystem_vendor;
> > > > > @@ -156,6 +166,9 @@ static struct intel_quirk intel_quirks[] = {
> > > > >       /* ASRock ITX*/
> > > > >       { 0x3185, 0x1849, 0x2212, quirk_increase_ddi_disabled_time },
> > > > >       { 0x3184, 0x1849, 0x2212, quirk_increase_ddi_disabled_time },
> > > > > +
> > > > > +     /* Google Pixelbook */
> > > > > +     { 0x591E, 0x8086, 0x2212, quirk_shift_edp_backlight_brightness
> > > > > },
> > > > >  };
> > > > > 
> > > > >  void intel_init_quirks(struct drm_i915_private *i915)
> > > > > diff --git a/drivers/gpu/drm/i915/i915_drv.h
> > > > > b/drivers/gpu/drm/i915/i915_drv.h
> > > > > index e4f7f6518945b..cc93bede4fab8 100644
> > > > > --- a/drivers/gpu/drm/i915/i915_drv.h
> > > > > +++ b/drivers/gpu/drm/i915/i915_drv.h
> > > > > @@ -525,6 +525,7 @@ struct i915_psr {
> > > > >  #define QUIRK_PIN_SWIZZLED_PAGES (1<<5)
> > > > >  #define QUIRK_INCREASE_T12_DELAY (1<<6)
> > > > >  #define QUIRK_INCREASE_DDI_DISABLED_TIME (1<<7)
> > > > > +#define QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS (1<<8)
> > > > > 
> > > > >  struct intel_fbdev;
> > > > >  struct intel_fbc_work;
> > > > 
> > > > --
> > > > Jani Nikula, Intel Open Source Graphics Center
-- 
Sincerely,
      Lyude Paul (she/her)
      Software Engineer at Red Hat


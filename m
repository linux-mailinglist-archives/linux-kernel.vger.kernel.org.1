Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85F426E287
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 19:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIQRec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 13:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgIQReH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:34:07 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34B6C061756
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 10:34:06 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id a19so3077624ilq.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 10:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bvEQFztQPuE8viTRZv4r7NoJrBod8jSBPM7mRWmOF+Q=;
        b=jCONn2tTLvDiGW7wFctPJ63OT+YcQ7bhKJF4WyqpYEfE5v/++tWhcomwDc+jqGwFBq
         MfF6zoiPZM+Iy7spF56rgE/fs3LXOhz9B4bgA2yfBZ8DFDyBKIM0aKk5atHVP7eQgS0v
         0LMFKG4dY9VTvVLwbmWg+9da7/b++K0dmxPiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bvEQFztQPuE8viTRZv4r7NoJrBod8jSBPM7mRWmOF+Q=;
        b=gC9H/wauKLZmjW9Yl2nzrqLFYLw1o1501wxOI9lTDZzs47CsvUbxDuau6foe4NedHT
         7DebTIpzW/hJQ43Lnm7+MP4XQLoj3XqGuEv7IhG95I+Qh5TT+Fi1eRUShNyMJygXPFea
         tl9aZJU36Ip5nwXxqaHJo9ilCu1l/KgegR0aCxsBQnD3vC3qHgHESU5T/12Klr8Cw3i5
         LtbgKXVJx04aY462RgZkRg/0mPk0xCz7/Ek47y7s/EtELH23e/4G5St6Pbrgxr9vgLBc
         sci2cJmLzEHyTU+C+h38jolk0UuR4uUB6SSaO1uGVZZcyYYaPBE9MDIZ+VTdsB0tBK9b
         sz/Q==
X-Gm-Message-State: AOAM531NFCZguELOFq3bsgJpZxjZXgWbpjU70ul2TBT1A01YJFnzSRea
        /eqeSUlxLcnCOUph1BkgyImUjMp818TraaEzdk4yfA==
X-Google-Smtp-Source: ABdhPJy+6fAG8ognE5b0H5zeigIDrGPIlgUmyvJHvGbn0gU4BsqIo9N+xzdQEUiHr4ZlYAPQadfXG13Z3Eo+ig1LkxI=
X-Received: by 2002:a92:d785:: with SMTP id d5mr19151636iln.123.1600364045296;
 Thu, 17 Sep 2020 10:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200917110838.1.I63d52f5b96d7e81e1e2dc2a72c4bf5fd84d3d3d0@changeid>
 <e3dfb952555890779ad0717370786bf748955494.camel@redhat.com>
In-Reply-To: <e3dfb952555890779ad0717370786bf748955494.camel@redhat.com>
From:   Kevin Chowski <chowski@chromium.org>
Date:   Thu, 17 Sep 2020 11:33:54 -0600
Message-ID: <CANM=9DPUh8tZbW=qXEdoE7bKqCv55hHr-YAAOerKi+ES_JSH+A@mail.gmail.com>
Subject: Re: [PATCH] i915: Introduce quirk for shifting eDP brightness.
To:     Lyude Paul <lyude@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(resending as plain-text, my last mail was rejected by lots of
addresses for some reason)

Thanks very much for the quick reply, Lyude!

I'm happy to make the requested changes, but I wanted to clarify
before falling down the wrong hole: are you suggesting that I move the
intel_dp_aux_set_backlight/intel_dp_aux_get_backlight routines to the
drm_dp_helper.c file?

On Thu, Sep 17, 2020 at 11:13 AM Lyude Paul <lyude@redhat.com> wrote:
>
> Just an FYI, my plan for some of this eDP backlight code is to move as much of
> it into helpers as possible since we need to implement the same interface in
> nouveau. We probably can figure out some other solution for handling this quirk
> if this isn't possible, but could we maybe use the panel's OUI here and add a
> quirk to drm_dp_helper.c instead?
>
> On Thu, 2020-09-17 at 11:09 -0600, Kevin Chowski wrote:
> > We have observed that Google Pixelbook's backlight hardware is
> > interpretting these backlight bits from the most-significant side of the
> > 16 bit word (if DP_EDP_PWMGEN_BIT_COUNT < 16), whereas the driver code
> > assumes the peripheral cares about the least-significant bits.
> >
> > Testing was done from within Chrome OS's build environment when the
> > patch is backported to 5.4 (the version we are newly targeting for the
> > Pixelbook); for the record:
> >    $ emerge-eve-kernelnext sys-kernel/chromeos-kernel-5_4 && \
> >       ./update_kernel.sh --remote=$IP
> >
> > I used `/sys/kernel/debug/dri/0/eDP-1/i915_dpcd` on my laptop to verify
> > that the registers were being set according to what the actual hardware
> > expects; I also observe that the backlight is noticeably brighter with
> > this patch.
> >
> > Signed-off-by: Kevin Chowski <chowski@chromium.org>
> > ---
> >
> >  .../drm/i915/display/intel_dp_aux_backlight.c | 34 +++++++++++++++++++
> >  drivers/gpu/drm/i915/display/intel_quirks.c   | 13 +++++++
> >  drivers/gpu/drm/i915/i915_drv.h               |  1 +
> >  3 files changed, 48 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > index acbd7eb66cbe3..99c98f217356d 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > @@ -91,6 +91,23 @@ static u32 intel_dp_aux_get_backlight(struct
> > intel_connector *connector)
> >       if (intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_BYTE_COUNT)
> >               level = (read_val[0] << 8 | read_val[1]);
> >
> > +     if (i915->quirks & QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS) {
> > +             if (!drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_PWMGEN_BIT_COUNT,
> > +                                             &read_val[0])) {
> > +                     DRM_DEBUG_KMS("Failed to read DPCD register 0x%x\n",
> > +                                     DP_EDP_PWMGEN_BIT_COUNT);
> > +                     return 0;
> > +             }
> > +             // Only bits 4:0 are used, 7:5 are reserved.
> > +             read_val[0] = read_val[0] & 0x1F;
> > +             if (read_val[0] > 16) {
> > +                     DRM_DEBUG_KMS("Invalid DP_EDP_PWNGEN_BIT_COUNT 0x%X,
> > expected at most 16\n",
> > +                                             read_val[0]);
> > +                     return 0;
> > +             }
> > +             level >>= 16 - read_val[0];
> > +     }
> > +
> >       return level;
> >  }
> >
> > @@ -106,6 +123,23 @@ intel_dp_aux_set_backlight(const struct
> > drm_connector_state *conn_state, u32 lev
> >       struct drm_i915_private *i915 = dp_to_i915(intel_dp);
> >       u8 vals[2] = { 0x0 };
> >
> > +     if (i915->quirks & QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS) {
> > +             if (!drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_PWMGEN_BIT_COUNT,
> > +                                             &vals[0])) {
> > +                     DRM_DEBUG_KMS("Failed to write aux backlight level:
> > Failed to read DPCD register 0x%x\n",
> > +                                       DP_EDP_PWMGEN_BIT_COUNT);
> > +                     return;
> > +             }
> > +             // Only bits 4:0 are used, 7:5 are reserved.
> > +             vals[0] = vals[0] & 0x1F;
> > +             if (vals[0] > 16) {
> > +                     DRM_DEBUG_KMS("Failed to write aux backlight level:
> > Invalid DP_EDP_PWNGEN_BIT_COUNT 0x%X, expected at most 16\n",
> > +                                             vals[0]);
> > +                     return;
> > +             }
> > +             level <<= (16 - vals[0]) & 0xFFFF;
> > +     }
> > +
> >       vals[0] = level;
> >
> >       /* Write the MSB and/or LSB */
> > diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c
> > b/drivers/gpu/drm/i915/display/intel_quirks.c
> > index 46beb155d835f..63b27d49b2864 100644
> > --- a/drivers/gpu/drm/i915/display/intel_quirks.c
> > +++ b/drivers/gpu/drm/i915/display/intel_quirks.c
> > @@ -53,6 +53,16 @@ static void quirk_increase_ddi_disabled_time(struct
> > drm_i915_private *i915)
> >       drm_info(&i915->drm, "Applying Increase DDI Disabled quirk\n");
> >  }
> >
> > +/*
> > + * Some eDP backlight hardware uses the most-significant bits of the
> > brightness
> > + * register, so brightness values must be shifted first.
> > + */
> > +static void quirk_shift_edp_backlight_brightness(struct drm_i915_private
> > *i915)
> > +{
> > +     i915->quirks |= QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS;
> > +     DRM_INFO("Applying shift eDP backlight brightness quirk\n");
> > +}
> > +
> >  struct intel_quirk {
> >       int device;
> >       int subsystem_vendor;
> > @@ -156,6 +166,9 @@ static struct intel_quirk intel_quirks[] = {
> >       /* ASRock ITX*/
> >       { 0x3185, 0x1849, 0x2212, quirk_increase_ddi_disabled_time },
> >       { 0x3184, 0x1849, 0x2212, quirk_increase_ddi_disabled_time },
> > +
> > +     /* Google Pixelbook */
> > +     { 0x591E, 0x8086, 0x2212, quirk_shift_edp_backlight_brightness },
> >  };
> >
> >  void intel_init_quirks(struct drm_i915_private *i915)
> > diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
> > index e4f7f6518945b..cc93bede4fab8 100644
> > --- a/drivers/gpu/drm/i915/i915_drv.h
> > +++ b/drivers/gpu/drm/i915/i915_drv.h
> > @@ -525,6 +525,7 @@ struct i915_psr {
> >  #define QUIRK_PIN_SWIZZLED_PAGES (1<<5)
> >  #define QUIRK_INCREASE_T12_DELAY (1<<6)
> >  #define QUIRK_INCREASE_DDI_DISABLED_TIME (1<<7)
> > +#define QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS (1<<8)
> >
> >  struct intel_fbdev;
> >  struct intel_fbc_work;
> --
> Sincerely,
>       Lyude Paul (she/her)
>       Software Engineer at Red Hat
>

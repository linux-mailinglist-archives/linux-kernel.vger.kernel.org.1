Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB11827039C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 19:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgIRR7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 13:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgIRR7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 13:59:52 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5B1C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 10:59:52 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id x18so4637019ila.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 10:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=arHqpFkdE744ooy989iqglGtJs0WbTa/g7nZ2e5dTPM=;
        b=VxkPHOs4ZlscDmeOkweOzG4WpligSfKvJZIgTxz1S6J4QyUAMjCv8HmAebWS6LxOQK
         qvq3M858BrPInw+5g+qnqU+5rvGESjpk0xvoFJwXKdkJHCGjtA1QzYV7fac27z7WXgvV
         5r2gsReMhBUHhqDyQUCtxQ3SX/LNSd7LY2pNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=arHqpFkdE744ooy989iqglGtJs0WbTa/g7nZ2e5dTPM=;
        b=dZrfTA5PTm1XW90+Z12+T8Xv5uuJvM2HCQJkIsIoltx5BTjRWY5W5cGZBIppowqq37
         iWnZp1S/y0psmQNtp2zmmGo0QXP8eidGPg7U3Xd2LZ5C8+XC8OUzqq31Bes9OD6xTIkO
         /mVFFH1NTHIXILCv+cm7uTZFSoUvTakFHFVLbx6TcidSROyAIjeJ5HP9T+k9/uDaW17w
         DrFjzZz+4V/a0uehksHJgyNFsOMYkIUjMNjxoXwhHKxgSyHZRwH1KlbDXSLG1G9tPcMG
         ABt+vjGlTKsL0UtK6QWziRlYbscM8rA5uvHd99wf12a+iQ4TyxDHJfIz8BZQdmPLkIRd
         c3xA==
X-Gm-Message-State: AOAM531xvtXQcdXmIqtBwXpAyfAhHyQI/s3YdzmN4GqafPHx+UHdw9EB
        TQSrBZN/5TWrh75I20kcLYqyEkUuBqwyswbYfVg+Tg==
X-Google-Smtp-Source: ABdhPJzdOic+CnQ8tIp5EM+aQlmvai5nedyX3FdtDSP6CDSvNOPda1yVWou7dyIGHmmNtAGvl6WAHWxmaD9DWsgWJyE=
X-Received: by 2002:a92:aa86:: with SMTP id p6mr6926824ill.157.1600451991651;
 Fri, 18 Sep 2020 10:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200917110838.1.I63d52f5b96d7e81e1e2dc2a72c4bf5fd84d3d3d0@changeid>
 <87o8m4uxcn.fsf@intel.com> <CANM=9DOn9wvL1RBDhxzawY1rRq0PFUBmKdXUGmG1CygApK1Vyg@mail.gmail.com>
 <CANCcNXc18jEXF+wdLm8sxR3ySR88D8S65a2x_vYtR5ihZ6XnMw@mail.gmail.com>
 <20200917182535.GC6112@intel.com> <20200917201102.GD6112@intel.com>
In-Reply-To: <20200917201102.GD6112@intel.com>
From:   Kevin Chowski <chowski@chromium.org>
Date:   Fri, 18 Sep 2020 11:59:40 -0600
Message-ID: <CANM=9DNOHHjrmBRhBGE2_WEumQ612jUFAJPO8x=Zs6EY-R87+A@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH] i915: Introduce quirk for shifting eDP brightness.
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Puthikorn Voravootivat <puthik@chromium.org>,
        David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies once again, some of my emails were bouncing for some
addresses yesterday. Hopefully it was a temporary condition; I'll
continue trying to dig into it on my end if it happens again for this
email.

Since there's evidence that some models want lsb and some (well, at
least one) want msb, my understanding is that we'll need a quirk one
way or the other (please correct if I'm mistaken). I unfortunately
don't have the ability to test anything other than the Pixelbook, so
if we decide the msb is the "right" way, then I will have to rely on
others to test (and find the OUI of) other models which require lsb.

I am happy to make any changes requested, but I do not at all have
enough background here to make the decision on whether the msb
functionality deserves the quirk or if the lsb one does. How can I
help you all come to an agreement here?

* It seems like Ville feels strongly about the msb being the correct
interpretation of the spec.
* It's unclear to me on which side of the fence Lyude falls, I
couldn't pick up a strong opinion in her clarifying question.
* Puthikorn seems to be on the side of lsb being correct, but maybe
was swayed by Ville's argument.

If no one feels that Ville's argument is not strong in some way, and
we go with that, I will get to work on the requested changes. I am
concerned, though, about changing the default functionality without
testing it widely to find the set of laptops which require the lsb
quirk. I'd appreciate any advice people might have about making this
change safely.

Thank you for your time,
Kevin

On Thu, Sep 17, 2020 at 2:11 PM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Thu, Sep 17, 2020 at 09:25:35PM +0300, Ville Syrj=C3=A4l=C3=A4 wrote:
> > On Thu, Sep 17, 2020 at 11:14:43AM -0700, Puthikorn Voravootivat wrote:
> > > The Lyude fde7266fb2f6 change is actually based on Chromium change
> > > (https://crrev.com/c/1650325) that fixes the brightness for Samsung
> > > Galaxy Chromebook. So currently we have 2 examples that use LSB
> > > interpretation and 1 that use MSB.
> >
> > "If field 4:0 of the EDP_PWMGEN_BIT_COUNT register represents a value
> > of greater than 8 and the BACKLIGHT_BRIGHTNESS_BYTE_COUNT bit
> > is cleared to 0, only the 8 MSB of the brightness control value can be
> > controlled.
> > (See Note below.)
> > Assigned bits are allocated to the MSB of the enabled register
> > combination."
> >
> > I think that's pretty clear the assigned bits are supposed to be
> > msb aligned.
>
> I guess there's some email issues happening, but just to clarify:
>
> When the spec says MSB in caps here it clearly means
> "most significant-bit(s)" since otherwise "8 MSB" would not make
> any sense in the context of a 2 byte value.
>
> Granted the spec is crap here since "Table 1-1: Acronyms and
> Initialism" does claim "MSB" should be byte(s) and "msb" bit(s).
>
> Also I can't imagine anyone would allocate the bits starting
> from the lsb when the whole thing is clearly supposed to be a
> 16bit big endian integer. So with >8 assigned bits you'd end
> up with crazy stuff like this:
>
> [ 7 ... 0 ][7   ...   0]
> [ 8 MSB   ][XXXX][N LSB]
>
> so you couldn't even treat the value as a regular big endian
> thing. Instead, if you squint a bit, it now looks like a funky
> little endian value. So we're deep into some mixed endian land
> where nothing makes sense anymore.
>
> Anyways I think the code should simply do this to match the spec:
> u16 value =3D brightness << (16 - num_assigned_bits);
> val[0] =3D value >> 8;
> val[1] =3D value & 0xff;
>
>
> >
> > >
> > >
> > > On Thu, Sep 17, 2020 at 10:55 AM Kevin Chowski <chowski@chromium.org>=
 wrote:
> > > >
> > > > Apologies for being too vague. To be as precise I can be, here is t=
he
> > > > specific code delta I tested: https://crrev.com/c/2406616 . To answ=
er
> > > > your other question, the code I tested against is indeed including =
the
> > > > fde7266fb2f6 (despite ostensibly being called 5.4 in my commit
> > > > message): our current top-of-tree for our 5.4 branch includes the
> > > > intel_dp_aux_calc_max_backlight logic. Further, I'll note that chan=
ge
> > > > is exactly the change which breaks my Pixelbook model: prior to the
> > > > change, the max_brightness was hard-coded to 0xFFFF and the math
> > > > worked out that it didn't matter that the hardware cared about the =
MSB
> > > > despite the driver code caring about the LSB.
> > > >
> > > > To answer Ville's question: the fde7266fb2f6 change which fixes one
> > > > laptop (I believe Thinkpad X1 extreme Gen 2, from some bug reports =
I
> > > > dug up) and breaks another (Pixelbook); so unfortunately I believe =
we
> > > > need a quirk at least for some laptop. Reading through the copy of =
the
> > > > datasheet I have, it wasn't clear to me which was the correct
> > > > interpretation. I'm cc'ing puthik@, who was leaning toward the curr=
ent
> > > > kernel code (caring about LSB) being the correct interpretation. I
> > > > believe we have other chromebooks which do rely on LSB functionalit=
y,
> > > > so unless we can find more examples of laptops wanting MSB it
> > > > currently looks like Pixelbook is the outlier.
> > > >
> > > > On Thu, Sep 17, 2020 at 11:28 AM Jani Nikula
> > > > <jani.nikula@linux.intel.com> wrote:
> > > > >
> > > > > On Thu, 17 Sep 2020, Kevin Chowski <chowski@chromium.org> wrote:
> > > > > > We have observed that Google Pixelbook's backlight hardware is
> > > > > > interpretting these backlight bits from the most-significant si=
de of the
> > > > > > 16 bit word (if DP_EDP_PWMGEN_BIT_COUNT < 16), whereas the driv=
er code
> > > > > > assumes the peripheral cares about the least-significant bits.
> > > > > >
> > > > > > Testing was done from within Chrome OS's build environment when=
 the
> > > > > > patch is backported to 5.4 (the version we are newly targeting =
for the
> > > > > > Pixelbook); for the record:
> > > > > >    $ emerge-eve-kernelnext sys-kernel/chromeos-kernel-5_4 && \
> > > > > >       ./update_kernel.sh --remote=3D$IP
> > > > > >
> > > > > > I used `/sys/kernel/debug/dri/0/eDP-1/i915_dpcd` on my laptop t=
o verify
> > > > > > that the registers were being set according to what the actual =
hardware
> > > > > > expects; I also observe that the backlight is noticeably bright=
er with
> > > > > > this patch.
> > > > >
> > > > > It's unclear to me what kernel version this is against, and what =
you've
> > > > > actually tested.
> > > > >
> > > > > Have you tried v5.7 kernel with Lyude's fde7266fb2f6 ("drm/i915: =
Fix eDP
> > > > > DPCD aux max backlight calculations")?
> > > > >
> > > > > I just want to make sure you've tested with all the relevant fixe=
s
> > > > > before adding quirks.
> > > > >
> > > > > BR,
> > > > > Jani.
> > > > >
> > > > > >
> > > > > > Signed-off-by: Kevin Chowski <chowski@chromium.org>
> > > > > > ---
> > > > > >
> > > > > >  .../drm/i915/display/intel_dp_aux_backlight.c | 34 +++++++++++=
++++++++
> > > > > >  drivers/gpu/drm/i915/display/intel_quirks.c   | 13 +++++++
> > > > > >  drivers/gpu/drm/i915/i915_drv.h               |  1 +
> > > > > >  3 files changed, 48 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backligh=
t.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > > > > > index acbd7eb66cbe3..99c98f217356d 100644
> > > > > > --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > > > > > +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > > > > > @@ -91,6 +91,23 @@ static u32 intel_dp_aux_get_backlight(struct=
 intel_connector *connector)
> > > > > >       if (intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_B=
YTE_COUNT)
> > > > > >               level =3D (read_val[0] << 8 | read_val[1]);
> > > > > >
> > > > > > +     if (i915->quirks & QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS) =
{
> > > > > > +             if (!drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_PWM=
GEN_BIT_COUNT,
> > > > > > +                                             &read_val[0])) {
> > > > > > +                     DRM_DEBUG_KMS("Failed to read DPCD regist=
er 0x%x\n",
> > > > > > +                                     DP_EDP_PWMGEN_BIT_COUNT);
> > > > > > +                     return 0;
> > > > > > +             }
> > > > > > +             // Only bits 4:0 are used, 7:5 are reserved.
> > > > > > +             read_val[0] =3D read_val[0] & 0x1F;
> > > > > > +             if (read_val[0] > 16) {
> > > > > > +                     DRM_DEBUG_KMS("Invalid DP_EDP_PWNGEN_BIT_=
COUNT 0x%X, expected at most 16\n",
> > > > > > +                                             read_val[0]);
> > > > > > +                     return 0;
> > > > > > +             }
> > > > > > +             level >>=3D 16 - read_val[0];
> > > > > > +     }
> > > > > > +
> > > > > >       return level;
> > > > > >  }
> > > > > >
> > > > > > @@ -106,6 +123,23 @@ intel_dp_aux_set_backlight(const struct dr=
m_connector_state *conn_state, u32 lev
> > > > > >       struct drm_i915_private *i915 =3D dp_to_i915(intel_dp);
> > > > > >       u8 vals[2] =3D { 0x0 };
> > > > > >
> > > > > > +     if (i915->quirks & QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS) =
{
> > > > > > +             if (!drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_PWM=
GEN_BIT_COUNT,
> > > > > > +                                             &vals[0])) {
> > > > > > +                     DRM_DEBUG_KMS("Failed to write aux backli=
ght level: Failed to read DPCD register 0x%x\n",
> > > > > > +                                       DP_EDP_PWMGEN_BIT_COUNT=
);
> > > > > > +                     return;
> > > > > > +             }
> > > > > > +             // Only bits 4:0 are used, 7:5 are reserved.
> > > > > > +             vals[0] =3D vals[0] & 0x1F;
> > > > > > +             if (vals[0] > 16) {
> > > > > > +                     DRM_DEBUG_KMS("Failed to write aux backli=
ght level: Invalid DP_EDP_PWNGEN_BIT_COUNT 0x%X, expected at most 16\n",
> > > > > > +                                             vals[0]);
> > > > > > +                     return;
> > > > > > +             }
> > > > > > +             level <<=3D (16 - vals[0]) & 0xFFFF;
> > > > > > +     }
> > > > > > +
> > > > > >       vals[0] =3D level;
> > > > > >
> > > > > >       /* Write the MSB and/or LSB */
> > > > > > diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/driv=
ers/gpu/drm/i915/display/intel_quirks.c
> > > > > > index 46beb155d835f..63b27d49b2864 100644
> > > > > > --- a/drivers/gpu/drm/i915/display/intel_quirks.c
> > > > > > +++ b/drivers/gpu/drm/i915/display/intel_quirks.c
> > > > > > @@ -53,6 +53,16 @@ static void quirk_increase_ddi_disabled_time=
(struct drm_i915_private *i915)
> > > > > >       drm_info(&i915->drm, "Applying Increase DDI Disabled quir=
k\n");
> > > > > >  }
> > > > > >
> > > > > > +/*
> > > > > > + * Some eDP backlight hardware uses the most-significant bits =
of the brightness
> > > > > > + * register, so brightness values must be shifted first.
> > > > > > + */
> > > > > > +static void quirk_shift_edp_backlight_brightness(struct drm_i9=
15_private *i915)
> > > > > > +{
> > > > > > +     i915->quirks |=3D QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS;
> > > > > > +     DRM_INFO("Applying shift eDP backlight brightness quirk\n=
");
> > > > > > +}
> > > > > > +
> > > > > >  struct intel_quirk {
> > > > > >       int device;
> > > > > >       int subsystem_vendor;
> > > > > > @@ -156,6 +166,9 @@ static struct intel_quirk intel_quirks[] =
=3D {
> > > > > >       /* ASRock ITX*/
> > > > > >       { 0x3185, 0x1849, 0x2212, quirk_increase_ddi_disabled_tim=
e },
> > > > > >       { 0x3184, 0x1849, 0x2212, quirk_increase_ddi_disabled_tim=
e },
> > > > > > +
> > > > > > +     /* Google Pixelbook */
> > > > > > +     { 0x591E, 0x8086, 0x2212, quirk_shift_edp_backlight_brigh=
tness },
> > > > > >  };
> > > > > >
> > > > > >  void intel_init_quirks(struct drm_i915_private *i915)
> > > > > > diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/=
i915/i915_drv.h
> > > > > > index e4f7f6518945b..cc93bede4fab8 100644
> > > > > > --- a/drivers/gpu/drm/i915/i915_drv.h
> > > > > > +++ b/drivers/gpu/drm/i915/i915_drv.h
> > > > > > @@ -525,6 +525,7 @@ struct i915_psr {
> > > > > >  #define QUIRK_PIN_SWIZZLED_PAGES (1<<5)
> > > > > >  #define QUIRK_INCREASE_T12_DELAY (1<<6)
> > > > > >  #define QUIRK_INCREASE_DDI_DISABLED_TIME (1<<7)
> > > > > > +#define QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS (1<<8)
> > > > > >
> > > > > >  struct intel_fbdev;
> > > > > >  struct intel_fbc_work;
> > > > >
> > > > > --
> > > > > Jani Nikula, Intel Open Source Graphics Center
> >
> > --
> > Ville Syrj=C3=A4l=C3=A4
> > Intel
> > _______________________________________________
> > Intel-gfx mailing list
> > Intel-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/intel-gfx
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel

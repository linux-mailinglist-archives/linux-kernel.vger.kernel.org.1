Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D8B274B2B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 23:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgIVVax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 17:30:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31474 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbgIVVaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600810248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wMcbdg3OL7L4nWZgtpOymh/0pK9VUsln15fyBfQ/GWI=;
        b=Pj5qOVxMfuBr76rBPOC3afb9Wz/9yz2SKmu99diIEuxlqqA+4hozTUouJ8OXO7ZEi49x3P
        utW87vYdOcYDjJamz2m+bOw2QI3AxLld5a9pev9SC7gz6zt0oS80L/ddEja8cvodK/AJ7I
        UMaFCug1uAQm8pQBpwhqD6FoYo0L0O0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-1PoqiBb_PiuwDQUu6li0Kw-1; Tue, 22 Sep 2020 17:30:42 -0400
X-MC-Unique: 1PoqiBb_PiuwDQUu6li0Kw-1
Received: by mail-qt1-f198.google.com with SMTP id a16so17314029qtj.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 14:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=wMcbdg3OL7L4nWZgtpOymh/0pK9VUsln15fyBfQ/GWI=;
        b=RbDeKMFRVIxcBDMeQ48mjuk//n1n5daf7SSXYPkOyS44vinZREWPsM10e9CB03/vBj
         Hhu416x8ySpqEZT62g2dTSGzvxttTBOWyl9bWLQP9CD6+I78oQPgwP1w2p49vyehC/FM
         93rzbIFQxlfe15dnmv5brXFoh8K2EiAKrizPiHCisHAIY+ItJ6IZi7rAfQVxGmwA5TC6
         YISzyS0g1us7gPkAaqC3cfAHG2+v869mMR/Uvs+niUg8/x2E2G8iLBIkOXFbYpSZnyLl
         t8bY37bRwNqJgXDKQ8EaIm7vN/BX0R8OKupRd+H612HFjxxbRwUZxFmkDumOIsfxgJ9+
         TEXw==
X-Gm-Message-State: AOAM532Pzl5Cn9VRgadNcNM3+vB6GIJcFN+0aRVi1c7Qi//VOI663ZHJ
        V9qEHDy7qXyF5xhfNp2gK+vR+/fotKnWzHb3yXAfPFMb7H8SsFHuS2cLwTt3N6cRulam8dHOO/6
        Qi8DUERIjTD+CuSQKILoNZe2S
X-Received: by 2002:a37:6610:: with SMTP id a16mr6662248qkc.134.1600810241136;
        Tue, 22 Sep 2020 14:30:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxadCWQymNw7jDGAAG/XN93DJ3APDI9Zl3oX2US1BhpCsSEN+8GYZy3nYMIjQkNybAU65+0dA==
X-Received: by 2002:a37:6610:: with SMTP id a16mr6662199qkc.134.1600810240530;
        Tue, 22 Sep 2020 14:30:40 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id k22sm12228360qkk.13.2020.09.22.14.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 14:30:38 -0700 (PDT)
Message-ID: <a90da83996a15ddf4d4ae89cea9d20fc5c6ee021.camel@redhat.com>
Subject: Re: [Intel-gfx] [PATCH] i915: Introduce quirk for shifting eDP
 brightness.
From:   Lyude Paul <lyude@redhat.com>
To:     Puthikorn Voravootivat <puthik@chromium.org>,
        Kevin Chowski <chowski@chromium.org>
Cc:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Date:   Tue, 22 Sep 2020 17:30:36 -0400
In-Reply-To: <CANCcNXdYjMxt6Yw-9j0QaZagUnuTtABKmVF_3N8GjRE_uO8Rng@mail.gmail.com>
References: <20200917110838.1.I63d52f5b96d7e81e1e2dc2a72c4bf5fd84d3d3d0@changeid>
         <87o8m4uxcn.fsf@intel.com>
         <CANM=9DOn9wvL1RBDhxzawY1rRq0PFUBmKdXUGmG1CygApK1Vyg@mail.gmail.com>
         <CANCcNXc18jEXF+wdLm8sxR3ySR88D8S65a2x_vYtR5ihZ6XnMw@mail.gmail.com>
         <20200917182535.GC6112@intel.com> <20200917201102.GD6112@intel.com>
         <CANM=9DNOHHjrmBRhBGE2_WEumQ612jUFAJPO8x=Zs6EY-R87+A@mail.gmail.com>
         <CANCcNXcegO7it_Cv2j+zS0qK57h6E0zngYKE4=m1YTyEpE6eqA@mail.gmail.com>
         <CANM=9DMQgFSZ3x8Oz-FF2=S041A8fb3afRSa21mWbNhgbZKU+w@mail.gmail.com>
         <CANCcNXdYjMxt6Yw-9j0QaZagUnuTtABKmVF_3N8GjRE_uO8Rng@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! Since I got dropped from the thread, many responses inline

On Tue, 2020-09-22 at 12:58 -0700, Puthikorn Voravootivat wrote:
> +Lyude
> I notice that Lyude email was somehow dropped from the thread.
> Lyude was the person who submitted the patch for Thinkpad and should
> know the OUI of the panel.

no need - currently because of some confusion that got caused by the Intel HDR
backlight interface being the only backlight interface that works properly on
a lot of panels (many panels will advertise both interfaces, but might only
work with the Intel one), we actually rely on a small allowlist of "approved"
panels for enabling DPCD backlight control.

…however, many of these panels are annoying and don't actually provide a
reliable enough OUID to use for quirk detection, which is why we had to add
EDID quirk detection as a temporary workaround for this. The current list of
panels lives in drm_dp_helper.c:

/*
 * Some devices have unreliable OUIDs where they don't set the device ID
 * correctly, and as a result we need to use the EDID for finding additional
 * DP quirks in such cases.
 */
static const struct edid_quirk edid_quirk_list[] = {
	/* Optional 4K AMOLED panel in the ThinkPad X1 Extreme 2nd Generation
	 * only supports DPCD backlight controls
	 */
	{ MFG(0x4c, 0x83), PROD_ID(0x41, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
	/*
	 * Some Dell CML 2020 systems have panels support both AUX and PWM
	 * backlight control, and some only support AUX backlight control. All
	 * said panels start up in AUX mode by default, and we don't have any
	 * support for disabling HDR mode on these panels which would be
	 * required to switch to PWM backlight control mode (plus, I'm not
	 * even sure we want PWM backlight controls over DPCD backlight
	 * controls anyway...). Until we have a better way of detecting these,
	 * force DPCD backlight mode on all of them.
	 */
	{ MFG(0x06, 0xaf), PROD_ID(0x9b, 0x32), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
	{ MFG(0x06, 0xaf), PROD_ID(0xeb, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
	{ MFG(0x4d, 0x10), PROD_ID(0xc7, 0x14), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
	{ MFG(0x4d, 0x10), PROD_ID(0xe6, 0x14), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
	{ MFG(0x4c, 0x83), PROD_ID(0x47, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
};

Also note that I think just about every panel on that list supports the Intel
HDR backlight interface, so it's -possible- that the VESA interface could be
broken on these panels. But, that would be a lot of different panels from
different vendors to all be broken in the same way.

> 
> On Tue, Sep 22, 2020 at 11:47 AM Kevin Chowski <chowski@chromium.org> wrote:
> > Alrighty, I'll take everyone else's silence as tacit approval of
> > Ville's opinions. (I didn't receive any email bounces this time, so I
> > think my issue was transient.) I will start on inverting the quirk and
> > making the most-significant-alignment matter for these registers by
> > default.
> > 
> > Who can help me gather a list of OUIs that we need to add to the
> > quirk? I can follow up with Puthikorn about the relevant Chromebooks,
> > but I don't know what other types of laptops are using this driver.
> > 
> > Thanks for your time,
> > Kevin Chowski
> > 
> > 
> > On Fri, Sep 18, 2020 at 12:16 PM Puthikorn Voravootivat
> > <puthik@chromium.org> wrote:
> > > I'll defer to Ville & Lyude.
> > > 
> > > I dug up more on the bug report and found that both Thinkpad and
> > > Galaxy Chromebook use the same Samsung OLED.
> > > So my 2 vs 1 argument is actually not valid.
> > > 
> > > On Fri, Sep 18, 2020 at 10:59 AM Kevin Chowski <chowski@chromium.org>
> > > wrote:
> > > > Apologies once again, some of my emails were bouncing for some
> > > > addresses yesterday. Hopefully it was a temporary condition; I'll
> > > > continue trying to dig into it on my end if it happens again for this
> > > > email.
> > > > 
> > > > Since there's evidence that some models want lsb and some (well, at
> > > > least one) want msb, my understanding is that we'll need a quirk one
> > > > way or the other (please correct if I'm mistaken). I unfortunately
> > > > don't have the ability to test anything other than the Pixelbook, so
> > > > if we decide the msb is the "right" way, then I will have to rely on
> > > > others to test (and find the OUI of) other models which require lsb.
> > > > 
> > > > I am happy to make any changes requested, but I do not at all have
> > > > enough background here to make the decision on whether the msb
> > > > functionality deserves the quirk or if the lsb one does. How can I
> > > > help you all come to an agreement here?
> > > > 
> > > > * It seems like Ville feels strongly about the msb being the correct
> > > > interpretation of the spec.
> > > > * It's unclear to me on which side of the fence Lyude falls, I
> > > > couldn't pick up a strong opinion in her clarifying question.
> > > > * Puthikorn seems to be on the side of lsb being correct, but maybe
> > > > was swayed by Ville's argument.

Honestly I'm not hard to convince :P, if it looks like we got the bit shift
wrong for the majority of devices and everyone else agrees then I'm fine with
assuming that's the case. I'm just quite surprised, seeing as we've tested
many different panels from a few vendors and haven't run into any issues with
this before.

Honestly - if there's this much uncertainty about it, maybe we should just ask
VESA directly what the correct interpretation of this is? Note I'm not on the
VESA board (I get access to DP/eDP specs through X.org) so unless the contacts
I've got from VESA would work (Bill Lempesis bill at vesa dot org) for that it
might be a better idea for someone from Google or Intel to ask.

> > > > 
> > > > If no one feels that Ville's argument is not strong in some way, and
> > > > we go with that, I will get to work on the requested changes. I am
> > > > concerned, though, about changing the default functionality without
> > > > testing it widely to find the set of laptops which require the lsb
> > > > quirk. I'd appreciate any advice people might have about making this
> > > > change safely.

Usually, I just try to stick with what the majority of machines need to do. I
still think it'd be a good idea for us to verify this with VESA if there's
that much confusion though

> > > > 
> > > > Thank you for your time,
> > > > Kevin
> > > > 
> > > > On Thu, Sep 17, 2020 at 2:11 PM Ville Syrjälä
> > > > <ville.syrjala@linux.intel.com> wrote:
> > > > > On Thu, Sep 17, 2020 at 09:25:35PM +0300, Ville Syrjälä wrote:
> > > > > > On Thu, Sep 17, 2020 at 11:14:43AM -0700, Puthikorn Voravootivat
> > > > > > wrote:
> > > > > > > The Lyude fde7266fb2f6 change is actually based on Chromium
> > > > > > > change
> > > > > > > (https://crrev.com/c/1650325) that fixes the brightness for
> > > > > > > Samsung
> > > > > > > Galaxy Chromebook. So currently we have 2 examples that use LSB
> > > > > > > interpretation and 1 that use MSB.
> > > > > > 
> > > > > > "If field 4:0 of the EDP_PWMGEN_BIT_COUNT register represents a
> > > > > > value
> > > > > > of greater than 8 and the BACKLIGHT_BRIGHTNESS_BYTE_COUNT bit
> > > > > > is cleared to 0, only the 8 MSB of the brightness control value
> > > > > > can be
> > > > > > controlled.
> > > > > > (See Note below.)
> > > > > > Assigned bits are allocated to the MSB of the enabled register
> > > > > > combination."
> > > > > > 
> > > > > > I think that's pretty clear the assigned bits are supposed to be
> > > > > > msb aligned.
> > > > > 
> > > > > I guess there's some email issues happening, but just to clarify:
> > > > > 
> > > > > When the spec says MSB in caps here it clearly means
> > > > > "most significant-bit(s)" since otherwise "8 MSB" would not make
> > > > > any sense in the context of a 2 byte value.
> > > > > 
> > > > > Granted the spec is crap here since "Table 1-1: Acronyms and
> > > > > Initialism" does claim "MSB" should be byte(s) and "msb" bit(s).
> > > > > 
> > > > > Also I can't imagine anyone would allocate the bits starting
> > > > > from the lsb when the whole thing is clearly supposed to be a
> > > > > 16bit big endian integer. So with >8 assigned bits you'd end
> > > > > up with crazy stuff like this:
> > > > > 
> > > > > [ 7 ... 0 ][7   ...   0]
> > > > > [ 8 MSB   ][XXXX][N LSB]
> > > > > 
> > > > > so you couldn't even treat the value as a regular big endian
> > > > > thing. Instead, if you squint a bit, it now looks like a funky
> > > > > little endian value. So we're deep into some mixed endian land
> > > > > where nothing makes sense anymore.
> > > > > 
> > > > > Anyways I think the code should simply do this to match the spec:
> > > > > u16 value = brightness << (16 - num_assigned_bits);
> > > > > val[0] = value >> 8;
> > > > > val[1] = value & 0xff;
> > > > > 
> > > > > 
> > > > > > > 
> > > > > > > On Thu, Sep 17, 2020 at 10:55 AM Kevin Chowski <
> > > > > > > chowski@chromium.org> wrote:
> > > > > > > > Apologies for being too vague. To be as precise I can be, here
> > > > > > > > is the
> > > > > > > > specific code delta I tested: https://crrev.com/c/2406616 . To
> > > > > > > > answer
> > > > > > > > your other question, the code I tested against is indeed
> > > > > > > > including the
> > > > > > > > fde7266fb2f6 (despite ostensibly being called 5.4 in my commit
> > > > > > > > message): our current top-of-tree for our 5.4 branch includes
> > > > > > > > the
> > > > > > > > intel_dp_aux_calc_max_backlight logic. Further, I'll note that
> > > > > > > > change
> > > > > > > > is exactly the change which breaks my Pixelbook model: prior
> > > > > > > > to the
> > > > > > > > change, the max_brightness was hard-coded to 0xFFFF and the
> > > > > > > > math
> > > > > > > > worked out that it didn't matter that the hardware cared about
> > > > > > > > the MSB
> > > > > > > > despite the driver code caring about the LSB.
> > > > > > > > 
> > > > > > > > To answer Ville's question: the fde7266fb2f6 change which
> > > > > > > > fixes one
> > > > > > > > laptop (I believe Thinkpad X1 extreme Gen 2, from some bug
> > > > > > > > reports I
> > > > > > > > dug up) and breaks another (Pixelbook); so unfortunately I
> > > > > > > > believe we
> > > > > > > > need a quirk at least for some laptop. Reading through the
> > > > > > > > copy of the
> > > > > > > > datasheet I have, it wasn't clear to me which was the correct
> > > > > > > > interpretation. I'm cc'ing puthik@, who was leaning toward the
> > > > > > > > current
> > > > > > > > kernel code (caring about LSB) being the correct
> > > > > > > > interpretation. I
> > > > > > > > believe we have other chromebooks which do rely on LSB
> > > > > > > > functionality,
> > > > > > > > so unless we can find more examples of laptops wanting MSB it
> > > > > > > > currently looks like Pixelbook is the outlier.
> > > > > > > > 
> > > > > > > > On Thu, Sep 17, 2020 at 11:28 AM Jani Nikula
> > > > > > > > <jani.nikula@linux.intel.com> wrote:
> > > > > > > > > On Thu, 17 Sep 2020, Kevin Chowski <chowski@chromium.org>
> > > > > > > > > wrote:
> > > > > > > > > > We have observed that Google Pixelbook's backlight
> > > > > > > > > > hardware is
> > > > > > > > > > interpretting these backlight bits from the most-
> > > > > > > > > > significant side of the
> > > > > > > > > > 16 bit word (if DP_EDP_PWMGEN_BIT_COUNT < 16), whereas the
> > > > > > > > > > driver code
> > > > > > > > > > assumes the peripheral cares about the least-significant
> > > > > > > > > > bits.
> > > > > > > > > > 
> > > > > > > > > > Testing was done from within Chrome OS's build environment
> > > > > > > > > > when the
> > > > > > > > > > patch is backported to 5.4 (the version we are newly
> > > > > > > > > > targeting for the
> > > > > > > > > > Pixelbook); for the record:
> > > > > > > > > >    $ emerge-eve-kernelnext sys-kernel/chromeos-kernel-5_4
> > > > > > > > > > && \
> > > > > > > > > >       ./update_kernel.sh --remote=$IP
> > > > > > > > > > 
> > > > > > > > > > I used `/sys/kernel/debug/dri/0/eDP-1/i915_dpcd` on my
> > > > > > > > > > laptop to verify
> > > > > > > > > > that the registers were being set according to what the
> > > > > > > > > > actual hardware
> > > > > > > > > > expects; I also observe that the backlight is noticeably
> > > > > > > > > > brighter with
> > > > > > > > > > this patch.
> > > > > > > > > 
> > > > > > > > > It's unclear to me what kernel version this is against, and
> > > > > > > > > what you've
> > > > > > > > > actually tested.
> > > > > > > > > 
> > > > > > > > > Have you tried v5.7 kernel with Lyude's fde7266fb2f6
> > > > > > > > > ("drm/i915: Fix eDP
> > > > > > > > > DPCD aux max backlight calculations")?
> > > > > > > > > 
> > > > > > > > > I just want to make sure you've tested with all the relevant
> > > > > > > > > fixes
> > > > > > > > > before adding quirks.
> > > > > > > > > 
> > > > > > > > > BR,
> > > > > > > > > Jani.
> > > > > > > > > 
> > > > > > > > > > Signed-off-by: Kevin Chowski <chowski@chromium.org>
> > > > > > > > > > ---
> > > > > > > > > > 
> > > > > > > > > >  .../drm/i915/display/intel_dp_aux_backlight.c | 34
> > > > > > > > > > +++++++++++++++++++
> > > > > > > > > >  drivers/gpu/drm/i915/display/intel_quirks.c   | 13
> > > > > > > > > > +++++++
> > > > > > > > > >  drivers/gpu/drm/i915/i915_drv.h               |  1 +
> > > > > > > > > >  3 files changed, 48 insertions(+)
> > > > > > > > > > 
> > > > > > > > > > diff --git
> > > > > > > > > > a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > > > > > > > > > b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > > > > > > > > > index acbd7eb66cbe3..99c98f217356d 100644
> > > > > > > > > > ---
> > > > > > > > > > a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > > > > > > > > > +++
> > > > > > > > > > b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > > > > > > > > > @@ -91,6 +91,23 @@ static u32
> > > > > > > > > > intel_dp_aux_get_backlight(struct intel_connector
> > > > > > > > > > *connector)
> > > > > > > > > >       if (intel_dp->edp_dpcd[2] &
> > > > > > > > > > DP_EDP_BACKLIGHT_BRIGHTNESS_BYTE_COUNT)
> > > > > > > > > >               level = (read_val[0] << 8 | read_val[1]);
> > > > > > > > > > 
> > > > > > > > > > +     if (i915->quirks &
> > > > > > > > > > QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS) {
> > > > > > > > > > +             if (!drm_dp_dpcd_readb(&intel_dp->aux,
> > > > > > > > > > DP_EDP_PWMGEN_BIT_COUNT,
> > > > > > > > > > +                                             &read_val[0]
> > > > > > > > > > )) {
> > > > > > > > > > +                     DRM_DEBUG_KMS("Failed to read DPCD
> > > > > > > > > > register 0x%x\n",
> > > > > > > > > > +                                     DP_EDP_PWMGEN_BIT_CO
> > > > > > > > > > UNT);
> > > > > > > > > > +                     return 0;
> > > > > > > > > > +             }
> > > > > > > > > > +             // Only bits 4:0 are used, 7:5 are reserved.
> > > > > > > > > > +             read_val[0] = read_val[0] & 0x1F;
> > > > > > > > > > +             if (read_val[0] > 16) {
> > > > > > > > > > +                     DRM_DEBUG_KMS("Invalid
> > > > > > > > > > DP_EDP_PWNGEN_BIT_COUNT 0x%X, expected at most 16\n",
> > > > > > > > > > +                                             read_val[0])
> > > > > > > > > > ;
> > > > > > > > > > +                     return 0;
> > > > > > > > > > +             }
> > > > > > > > > > +             level >>= 16 - read_val[0];
> > > > > > > > > > +     }
> > > > > > > > > > +
> > > > > > > > > >       return level;
> > > > > > > > > >  }
> > > > > > > > > > 
> > > > > > > > > > @@ -106,6 +123,23 @@ intel_dp_aux_set_backlight(const
> > > > > > > > > > struct drm_connector_state *conn_state, u32 lev
> > > > > > > > > >       struct drm_i915_private *i915 =
> > > > > > > > > > dp_to_i915(intel_dp);
> > > > > > > > > >       u8 vals[2] = { 0x0 };
> > > > > > > > > > 
> > > > > > > > > > +     if (i915->quirks &
> > > > > > > > > > QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS) {
> > > > > > > > > > +             if (!drm_dp_dpcd_readb(&intel_dp->aux,
> > > > > > > > > > DP_EDP_PWMGEN_BIT_COUNT,
> > > > > > > > > > +                                             &vals[0])) {
> > > > > > > > > > +                     DRM_DEBUG_KMS("Failed to write aux
> > > > > > > > > > backlight level: Failed to read DPCD register 0x%x\n",
> > > > > > > > > > +                                       DP_EDP_PWMGEN_BIT_
> > > > > > > > > > COUNT);
> > > > > > > > > > +                     return;
> > > > > > > > > > +             }
> > > > > > > > > > +             // Only bits 4:0 are used, 7:5 are reserved.
> > > > > > > > > > +             vals[0] = vals[0] & 0x1F;
> > > > > > > > > > +             if (vals[0] > 16) {
> > > > > > > > > > +                     DRM_DEBUG_KMS("Failed to write aux
> > > > > > > > > > backlight level: Invalid DP_EDP_PWNGEN_BIT_COUNT 0x%X,
> > > > > > > > > > expected at most 16\n",
> > > > > > > > > > +                                             vals[0]);
> > > > > > > > > > +                     return;
> > > > > > > > > > +             }
> > > > > > > > > > +             level <<= (16 - vals[0]) & 0xFFFF;
> > > > > > > > > > +     }
> > > > > > > > > > +
> > > > > > > > > >       vals[0] = level;
> > > > > > > > > > 
> > > > > > > > > >       /* Write the MSB and/or LSB */
> > > > > > > > > > diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c
> > > > > > > > > > b/drivers/gpu/drm/i915/display/intel_quirks.c
> > > > > > > > > > index 46beb155d835f..63b27d49b2864 100644
> > > > > > > > > > --- a/drivers/gpu/drm/i915/display/intel_quirks.c
> > > > > > > > > > +++ b/drivers/gpu/drm/i915/display/intel_quirks.c
> > > > > > > > > > @@ -53,6 +53,16 @@ static void
> > > > > > > > > > quirk_increase_ddi_disabled_time(struct drm_i915_private
> > > > > > > > > > *i915)
> > > > > > > > > >       drm_info(&i915->drm, "Applying Increase DDI Disabled
> > > > > > > > > > quirk\n");
> > > > > > > > > >  }
> > > > > > > > > > 
> > > > > > > > > > +/*
> > > > > > > > > > + * Some eDP backlight hardware uses the most-significant
> > > > > > > > > > bits of the brightness
> > > > > > > > > > + * register, so brightness values must be shifted first.
> > > > > > > > > > + */
> > > > > > > > > > +static void quirk_shift_edp_backlight_brightness(struct
> > > > > > > > > > drm_i915_private *i915)
> > > > > > > > > > +{
> > > > > > > > > > +     i915->quirks |=
> > > > > > > > > > QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS;
> > > > > > > > > > +     DRM_INFO("Applying shift eDP backlight brightness
> > > > > > > > > > quirk\n");
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >  struct intel_quirk {
> > > > > > > > > >       int device;
> > > > > > > > > >       int subsystem_vendor;
> > > > > > > > > > @@ -156,6 +166,9 @@ static struct intel_quirk
> > > > > > > > > > intel_quirks[] = {
> > > > > > > > > >       /* ASRock ITX*/
> > > > > > > > > >       { 0x3185, 0x1849, 0x2212,
> > > > > > > > > > quirk_increase_ddi_disabled_time },
> > > > > > > > > >       { 0x3184, 0x1849, 0x2212,
> > > > > > > > > > quirk_increase_ddi_disabled_time },
> > > > > > > > > > +
> > > > > > > > > > +     /* Google Pixelbook */
> > > > > > > > > > +     { 0x591E, 0x8086, 0x2212,
> > > > > > > > > > quirk_shift_edp_backlight_brightness },
> > > > > > > > > >  };
> > > > > > > > > > 
> > > > > > > > > >  void intel_init_quirks(struct drm_i915_private *i915)
> > > > > > > > > > diff --git a/drivers/gpu/drm/i915/i915_drv.h
> > > > > > > > > > b/drivers/gpu/drm/i915/i915_drv.h
> > > > > > > > > > index e4f7f6518945b..cc93bede4fab8 100644
> > > > > > > > > > --- a/drivers/gpu/drm/i915/i915_drv.h
> > > > > > > > > > +++ b/drivers/gpu/drm/i915/i915_drv.h
> > > > > > > > > > @@ -525,6 +525,7 @@ struct i915_psr {
> > > > > > > > > >  #define QUIRK_PIN_SWIZZLED_PAGES (1<<5)
> > > > > > > > > >  #define QUIRK_INCREASE_T12_DELAY (1<<6)
> > > > > > > > > >  #define QUIRK_INCREASE_DDI_DISABLED_TIME (1<<7)
> > > > > > > > > > +#define QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS (1<<8)
> > > > > > > > > > 
> > > > > > > > > >  struct intel_fbdev;
> > > > > > > > > >  struct intel_fbc_work;
> > > > > > > > > 
> > > > > > > > > --
> > > > > > > > > Jani Nikula, Intel Open Source Graphics Center
> > > > > > 
> > > > > > --
> > > > > > Ville Syrjälä
> > > > > > Intel
> > > > > > _______________________________________________
> > > > > > Intel-gfx mailing list
> > > > > > Intel-gfx@lists.freedesktop.org
> > > > > > https://lists.freedesktop.org/mailman/listinfo/intel-gfx
> > > > > 
> > > > > --
> > > > > Ville Syrjälä
> > > > > Intel
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB9C278F29
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbgIYQxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:53:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727324AbgIYQxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:53:38 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601052813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bpUGMcwvdNI1X0aDj/iwu1akGrhtmnN7zlVK5NxAg2g=;
        b=XTEOlNzhYPCsthOQtIkHqHts/sK6b8ddtJuPHDQ5k+ovmHrkBL+Bvc1TwVD9MB6Wl2kPMy
        vwLUDfOsFfLEZZW8eR82U6P1Tc99VV56Z4o0uegZ7vbUwTjMZNBU2Atho/J8iBNkuVKu4q
        GXl9f4ytLB8WyuhJUxNpQn8gPFO813k=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-qV5x_XtCNK6LvizgUKd9yw-1; Fri, 25 Sep 2020 12:53:26 -0400
X-MC-Unique: qV5x_XtCNK6LvizgUKd9yw-1
Received: by mail-qk1-f200.google.com with SMTP id a2so2366987qkg.19
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=bpUGMcwvdNI1X0aDj/iwu1akGrhtmnN7zlVK5NxAg2g=;
        b=HWaZyWMqQAnlyB+XlU7LvUuDjMTQsE1pjnxXDc7SRHRGJ07fuwmwEB63Knzh3aMAm6
         WYloN5EDWfnRq5+ImM11QC7DX7o11cwpAeB4LK3e/vdCdVL/kPS1II/enyPCe50xO7Ar
         sK6NS3GHC0fSW4Y3EEpHf2/cAO5ebTEdv9EL961ze1BKHVVdgxki3XsAU/3e0mYyCQ8G
         qb1mbaQo7P8sSR3doL3WvNYEPORBaGg+z6+1wxJJRop+yJrF3lbYbZi9O4LN4Xcl+Fhj
         TuuhquM4P4Qyzaztb6C/ECgRZHxxA2podT21F84QEVJxdrVbXC8Xe9ziqVv95EPlmQhu
         tl5w==
X-Gm-Message-State: AOAM530t49V7kR01lSc/J3gEUCGsgIB0GvgM5VWiI9FLat6YJJLHwfvm
        ctKLE3xbNshY04ezbAPkpwIJM9oxBt7/Rf8TMUCJ3gXA9G48EKpg1F/J+mMlYOIvuQGmnVjfZ20
        PisqxCeuFE/uZA/bUikd0bMAu
X-Received: by 2002:a05:620a:1ef:: with SMTP id x15mr900390qkn.182.1601052804974;
        Fri, 25 Sep 2020 09:53:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwm9l3TXZPpxknhjOWRt17WwfTMryKg+4+HlKa45rrHHHdVUq1ob7Z42sctCucVFuX8lWGeog==
X-Received: by 2002:a05:620a:1ef:: with SMTP id x15mr900327qkn.182.1601052804141;
        Fri, 25 Sep 2020 09:53:24 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id j25sm2233312qtr.83.2020.09.25.09.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 09:53:23 -0700 (PDT)
Message-ID: <e03e94af2b058f3eb732bceb25a74d748c0f25cf.camel@redhat.com>
Subject: Re: [Intel-gfx] [PATCH] i915: Introduce quirk for shifting eDP
 brightness.
From:   Lyude Paul <lyude@redhat.com>
To:     Kevin Chowski <chowski@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Puthikorn Voravootivat <puthik@chromium.org>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 25 Sep 2020 12:53:21 -0400
In-Reply-To: <CANM=9DPYDeAaNMWyPO5dus8Z-WL2Y+mewFQWd1YiNUyN2JeQnw@mail.gmail.com>
References: <20200917110838.1.I63d52f5b96d7e81e1e2dc2a72c4bf5fd84d3d3d0@changeid>
         <87o8m4uxcn.fsf@intel.com>
         <CANM=9DOn9wvL1RBDhxzawY1rRq0PFUBmKdXUGmG1CygApK1Vyg@mail.gmail.com>
         <CANCcNXc18jEXF+wdLm8sxR3ySR88D8S65a2x_vYtR5ihZ6XnMw@mail.gmail.com>
         <20200917182535.GC6112@intel.com> <20200917201102.GD6112@intel.com>
         <CANM=9DNOHHjrmBRhBGE2_WEumQ612jUFAJPO8x=Zs6EY-R87+A@mail.gmail.com>
         <CANCcNXcegO7it_Cv2j+zS0qK57h6E0zngYKE4=m1YTyEpE6eqA@mail.gmail.com>
         <CANM=9DMQgFSZ3x8Oz-FF2=S041A8fb3afRSa21mWbNhgbZKU+w@mail.gmail.com>
         <CANCcNXdYjMxt6Yw-9j0QaZagUnuTtABKmVF_3N8GjRE_uO8Rng@mail.gmail.com>
         <a90da83996a15ddf4d4ae89cea9d20fc5c6ee021.camel@redhat.com>
         <CANM=9DPYDeAaNMWyPO5dus8Z-WL2Y+mewFQWd1YiNUyN2JeQnw@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-09-24 at 17:46 -0600, Kevin Chowski wrote:
> cc back a few others who were unintentionally dropped from the thread
> earlier.
> 
> Someone (at Google) helped me dig into this a little more and they
> found a document titled "eDP Backlight Brightness bit alignment" sent
> out for review in January 2017. I registered for a new account (google
> is a member) and have access to the document; here is the URL for
> those who also have access:
> https://groups.vesa.org/wg/AllMem/document/7786. For what it's worth,
> it seems like Lyude's contact Bill Lempesis uploaded this
> change-request document, so I think we can reach out to him if we have
> further questions. It's actually unclear to me what the status of this
> change request is, and whether it's been officially accepted. But I
> think it can be seen as some official advice on how we can move
> forward here.
> 
> Basically, this is a change request to the spec which acknowledges
> that, despite the original spec implying that the
> most-significant-bits were relevant here, many implementations used
> the least-significant-bits. In defense of most-significant it laid out
> some similar arguments to what Ville was saying. But it ends up
> saying:
> 
> > Unfortunately, the most common interpretation that we have
> > encountered is case 1 in the example above. TCON vendors
> > tend to align the valid bits to the LSBs, not the MSBs.
> 
> Instead of changing the default defined functionality (as some earlier
> version of this doc apparently suggested), this doc prefers to
> allocate two extra bits in EDP_GENERAL_CAPABILITY_2 so that future
> backlight devices can specify to the Source how to program them:
> 
> 00: the current functionality, i,e. no defined interpretation
> 01: aligned to most-significant bits
> 10: aligned to least-significant bits
> 11: reserved
> 
> It also says "[Sources] should only need panel-specific workarounds
> for the currently available panels."
> 
> So I believe this document is an acknowledgement of many
> implementations having their alignment to the least-significant bits,
> and (to my eyes) clearly validates that the spec "should" be the
> opposite. If we believe the doc's claim that "the most common
> interpretation" is least-significant, it seems to me that it would
> require more quirks if we made most-significant the default
> implementation.
> 
> Ville mentioned at some point earlier that we should try to match the
> spec, whereas Lyude mentioned we should prefer to do what the majority
> of machines do. What do you both think of this new development?

That's how displayport happens to be sometimes :). Definitely isn't the first
time something in the spec like this got implemented incorrectly so many times
by different vendors that they had to update the spec in response (same thing
happened with MST and interleaved sideband messages as of DP 2.0), so I'm
really glad we went and actually investigated this.

So yes - I think a quirk for this would definitely be a good idea, and IMO we
should always lean on the side that more panels implement even if it's not
according to spec - so defaulting to the behavior we currently have in the
kernel, and adding quirks for panels that were smart enough not to fall for
this would probably be the best way to go. That just leaves the challenge of
"how do we figure out which panels actually need this and which ones don't?"

This might end up being a bit of a challenge, but I've got some ideas on how
we might be able to tackle it to the best of our ability based off my
discussions with laptop vendors. It seems like some of the homegrown backlight
interfaces might help us out here. Note I'm mentioning other laptop vendors
here because at least for nouveau, our plan for DPCD backlight support is to
move a lot of the code for handling it that currently lives in i915 into
shared DRM helpers (which now we'll definitely need to do as a result of these
quirks).

So, on the x86 front, there's already a few different interfaces in use for
laptop panels:
 * AMD usually uses their own backlight interface, so for AMD-only laptops we
   can probably safely ignore this
 * Intel uses their own DPCD backlight interface on most of the _non-ChromeOS_ 
   machines on the market right now afaik based off my discussion with some
   laptop vendors. For panels that only come up in Intel-only machines, that
   means we only really need to care about the ChromeOS case here. So-if
   Google's able to actually survey the devices they're shipping with ChromeOS
   right now to figure out which ones are using DPCD backlight controls, and
   which ones need to be MSB aligned - then I'd think we could probably build
   an accurate quirk list of those panels easily.
 * This just leaves the nvidia case. Nvidia seems to be one of the only GPU
   vendors that didn't come up with their own backlight interface over DPCD,
   and they actually require that the panel support the VESA backlight control
   interface. Incidentally, a lot of the laptops that I've force-enabled VESA
   backlight controls on have nvidia GPUs in them, and so far every single one
   has worked with the code we currently use in the kernel. My hope with this
   would be that since nvidia's driver support is somewhat consistent, they
   either might have a list of problematic panels or can just verify with us
   that all of the panels that their driver interacts with follow the LSB
   preference.

For the ChromeOS guys in the thread, does this sound like it could be
workable? For the time being, I'll also send my nvidia contacts a poke to see
what info they can give us. As well, we should probably poke Bill just in case
he might know of some resource that documents some of the problematic panels
out there (probably not, but it's at least worth a shot). I'll try to get
around this today, but we might have to poke him once or twice since there
originally was a problem with any of the emails from Red Hat getting through
to him…

> 
> I will also look into whether my specific device supports this
> extension, and in that case I'll volunteer to implement this new
> functionality in the driver.
> 
> Thanks for your time,
> Kevin
> 
> On Tue, Sep 22, 2020 at 3:30 PM Lyude Paul <lyude@redhat.com> wrote:
> > Hi! Since I got dropped from the thread, many responses inline
> > 
> > On Tue, 2020-09-22 at 12:58 -0700, Puthikorn Voravootivat wrote:
> > > +Lyude
> > > I notice that Lyude email was somehow dropped from the thread.
> > > Lyude was the person who submitted the patch for Thinkpad and should
> > > know the OUI of the panel.
> > 
> > no need - currently because of some confusion that got caused by the Intel
> > HDR
> > backlight interface being the only backlight interface that works properly
> > on
> > a lot of panels (many panels will advertise both interfaces, but might
> > only
> > work with the Intel one), we actually rely on a small allowlist of
> > "approved"
> > panels for enabling DPCD backlight control.
> > 
> > …however, many of these panels are annoying and don't actually provide a
> > reliable enough OUID to use for quirk detection, which is why we had to
> > add
> > EDID quirk detection as a temporary workaround for this. The current list
> > of
> > panels lives in drm_dp_helper.c:
> > 
> > /*
> >  * Some devices have unreliable OUIDs where they don't set the device ID
> >  * correctly, and as a result we need to use the EDID for finding
> > additional
> >  * DP quirks in such cases.
> >  */
> > static const struct edid_quirk edid_quirk_list[] = {
> >         /* Optional 4K AMOLED panel in the ThinkPad X1 Extreme 2nd
> > Generation
> >          * only supports DPCD backlight controls
> >          */
> >         { MFG(0x4c, 0x83), PROD_ID(0x41, 0x41),
> > BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
> >         /*
> >          * Some Dell CML 2020 systems have panels support both AUX and PWM
> >          * backlight control, and some only support AUX backlight control.
> > All
> >          * said panels start up in AUX mode by default, and we don't have
> > any
> >          * support for disabling HDR mode on these panels which would be
> >          * required to switch to PWM backlight control mode (plus, I'm not
> >          * even sure we want PWM backlight controls over DPCD backlight
> >          * controls anyway...). Until we have a better way of detecting
> > these,
> >          * force DPCD backlight mode on all of them.
> >          */
> >         { MFG(0x06, 0xaf), PROD_ID(0x9b, 0x32),
> > BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
> >         { MFG(0x06, 0xaf), PROD_ID(0xeb, 0x41),
> > BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
> >         { MFG(0x4d, 0x10), PROD_ID(0xc7, 0x14),
> > BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
> >         { MFG(0x4d, 0x10), PROD_ID(0xe6, 0x14),
> > BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
> >         { MFG(0x4c, 0x83), PROD_ID(0x47, 0x41),
> > BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
> > };
> > 
> > Also note that I think just about every panel on that list supports the
> > Intel
> > HDR backlight interface, so it's -possible- that the VESA interface could
> > be
> > broken on these panels. But, that would be a lot of different panels from
> > different vendors to all be broken in the same way.
> > 
> > > On Tue, Sep 22, 2020 at 11:47 AM Kevin Chowski <chowski@chromium.org>
> > > wrote:
> > > > Alrighty, I'll take everyone else's silence as tacit approval of
> > > > Ville's opinions. (I didn't receive any email bounces this time, so I
> > > > think my issue was transient.) I will start on inverting the quirk and
> > > > making the most-significant-alignment matter for these registers by
> > > > default.
> > > > 
> > > > Who can help me gather a list of OUIs that we need to add to the
> > > > quirk? I can follow up with Puthikorn about the relevant Chromebooks,
> > > > but I don't know what other types of laptops are using this driver.
> > > > 
> > > > Thanks for your time,
> > > > Kevin Chowski
> > > > 
> > > > 
> > > > On Fri, Sep 18, 2020 at 12:16 PM Puthikorn Voravootivat
> > > > <puthik@chromium.org> wrote:
> > > > > I'll defer to Ville & Lyude.
> > > > > 
> > > > > I dug up more on the bug report and found that both Thinkpad and
> > > > > Galaxy Chromebook use the same Samsung OLED.
> > > > > So my 2 vs 1 argument is actually not valid.
> > > > > 
> > > > > On Fri, Sep 18, 2020 at 10:59 AM Kevin Chowski <chowski@chromium.org
> > > > > >
> > > > > wrote:
> > > > > > Apologies once again, some of my emails were bouncing for some
> > > > > > addresses yesterday. Hopefully it was a temporary condition; I'll
> > > > > > continue trying to dig into it on my end if it happens again for
> > > > > > this
> > > > > > email.
> > > > > > 
> > > > > > Since there's evidence that some models want lsb and some (well,
> > > > > > at
> > > > > > least one) want msb, my understanding is that we'll need a quirk
> > > > > > one
> > > > > > way or the other (please correct if I'm mistaken). I unfortunately
> > > > > > don't have the ability to test anything other than the Pixelbook,
> > > > > > so
> > > > > > if we decide the msb is the "right" way, then I will have to rely
> > > > > > on
> > > > > > others to test (and find the OUI of) other models which require
> > > > > > lsb.
> > > > > > 
> > > > > > I am happy to make any changes requested, but I do not at all have
> > > > > > enough background here to make the decision on whether the msb
> > > > > > functionality deserves the quirk or if the lsb one does. How can I
> > > > > > help you all come to an agreement here?
> > > > > > 
> > > > > > * It seems like Ville feels strongly about the msb being the
> > > > > > correct
> > > > > > interpretation of the spec.
> > > > > > * It's unclear to me on which side of the fence Lyude falls, I
> > > > > > couldn't pick up a strong opinion in her clarifying question.
> > > > > > * Puthikorn seems to be on the side of lsb being correct, but
> > > > > > maybe
> > > > > > was swayed by Ville's argument.
> > 
> > Honestly I'm not hard to convince :P, if it looks like we got the bit
> > shift
> > wrong for the majority of devices and everyone else agrees then I'm fine
> > with
> > assuming that's the case. I'm just quite surprised, seeing as we've tested
> > many different panels from a few vendors and haven't run into any issues
> > with
> > this before.
> > 
> > Honestly - if there's this much uncertainty about it, maybe we should just
> > ask
> > VESA directly what the correct interpretation of this is? Note I'm not on
> > the
> > VESA board (I get access to DP/eDP specs through X.org) so unless the
> > contacts
> > I've got from VESA would work (Bill Lempesis bill at vesa dot org) for
> > that it
> > might be a better idea for someone from Google or Intel to ask.
> > 
> > > > > > If no one feels that Ville's argument is not strong in some way,
> > > > > > and
> > > > > > we go with that, I will get to work on the requested changes. I am
> > > > > > concerned, though, about changing the default functionality
> > > > > > without
> > > > > > testing it widely to find the set of laptops which require the lsb
> > > > > > quirk. I'd appreciate any advice people might have about making
> > > > > > this
> > > > > > change safely.
> > 
> > Usually, I just try to stick with what the majority of machines need to
> > do. I
> > still think it'd be a good idea for us to verify this with VESA if there's
> > that much confusion though
> > 
> > > > > > Thank you for your time,
> > > > > > Kevin
> > > > > > 
> > > > > > On Thu, Sep 17, 2020 at 2:11 PM Ville Syrjälä
> > > > > > <ville.syrjala@linux.intel.com> wrote:
> > > > > > > On Thu, Sep 17, 2020 at 09:25:35PM +0300, Ville Syrjälä wrote:
> > > > > > > > On Thu, Sep 17, 2020 at 11:14:43AM -0700, Puthikorn
> > > > > > > > Voravootivat
> > > > > > > > wrote:
> > > > > > > > > The Lyude fde7266fb2f6 change is actually based on Chromium
> > > > > > > > > change
> > > > > > > > > (https://crrev.com/c/1650325) that fixes the brightness for
> > > > > > > > > Samsung
> > > > > > > > > Galaxy Chromebook. So currently we have 2 examples that use
> > > > > > > > > LSB
> > > > > > > > > interpretation and 1 that use MSB.
> > > > > > > > 
> > > > > > > > "If field 4:0 of the EDP_PWMGEN_BIT_COUNT register represents
> > > > > > > > a
> > > > > > > > value
> > > > > > > > of greater than 8 and the BACKLIGHT_BRIGHTNESS_BYTE_COUNT bit
> > > > > > > > is cleared to 0, only the 8 MSB of the brightness control
> > > > > > > > value
> > > > > > > > can be
> > > > > > > > controlled.
> > > > > > > > (See Note below.)
> > > > > > > > Assigned bits are allocated to the MSB of the enabled register
> > > > > > > > combination."
> > > > > > > > 
> > > > > > > > I think that's pretty clear the assigned bits are supposed to
> > > > > > > > be
> > > > > > > > msb aligned.
> > > > > > > 
> > > > > > > I guess there's some email issues happening, but just to
> > > > > > > clarify:
> > > > > > > 
> > > > > > > When the spec says MSB in caps here it clearly means
> > > > > > > "most significant-bit(s)" since otherwise "8 MSB" would not make
> > > > > > > any sense in the context of a 2 byte value.
> > > > > > > 
> > > > > > > Granted the spec is crap here since "Table 1-1: Acronyms and
> > > > > > > Initialism" does claim "MSB" should be byte(s) and "msb" bit(s).
> > > > > > > 
> > > > > > > Also I can't imagine anyone would allocate the bits starting
> > > > > > > from the lsb when the whole thing is clearly supposed to be a
> > > > > > > 16bit big endian integer. So with >8 assigned bits you'd end
> > > > > > > up with crazy stuff like this:
> > > > > > > 
> > > > > > > [ 7 ... 0 ][7   ...   0]
> > > > > > > [ 8 MSB   ][XXXX][N LSB]
> > > > > > > 
> > > > > > > so you couldn't even treat the value as a regular big endian
> > > > > > > thing. Instead, if you squint a bit, it now looks like a funky
> > > > > > > little endian value. So we're deep into some mixed endian land
> > > > > > > where nothing makes sense anymore.
> > > > > > > 
> > > > > > > Anyways I think the code should simply do this to match the
> > > > > > > spec:
> > > > > > > u16 value = brightness << (16 - num_assigned_bits);
> > > > > > > val[0] = value >> 8;
> > > > > > > val[1] = value & 0xff;
> > > > > > > 
> > > > > > > 
> > > > > > > > > On Thu, Sep 17, 2020 at 10:55 AM Kevin Chowski <
> > > > > > > > > chowski@chromium.org> wrote:
> > > > > > > > > > Apologies for being too vague. To be as precise I can be,
> > > > > > > > > > here
> > > > > > > > > > is the
> > > > > > > > > > specific code delta I tested: https://crrev.com/c/2406616
> > > > > > > > > > . To
> > > > > > > > > > answer
> > > > > > > > > > your other question, the code I tested against is indeed
> > > > > > > > > > including the
> > > > > > > > > > fde7266fb2f6 (despite ostensibly being called 5.4 in my
> > > > > > > > > > commit
> > > > > > > > > > message): our current top-of-tree for our 5.4 branch
> > > > > > > > > > includes
> > > > > > > > > > the
> > > > > > > > > > intel_dp_aux_calc_max_backlight logic. Further, I'll note
> > > > > > > > > > that
> > > > > > > > > > change
> > > > > > > > > > is exactly the change which breaks my Pixelbook model:
> > > > > > > > > > prior
> > > > > > > > > > to the
> > > > > > > > > > change, the max_brightness was hard-coded to 0xFFFF and
> > > > > > > > > > the
> > > > > > > > > > math
> > > > > > > > > > worked out that it didn't matter that the hardware cared
> > > > > > > > > > about
> > > > > > > > > > the MSB
> > > > > > > > > > despite the driver code caring about the LSB.
> > > > > > > > > > 
> > > > > > > > > > To answer Ville's question: the fde7266fb2f6 change which
> > > > > > > > > > fixes one
> > > > > > > > > > laptop (I believe Thinkpad X1 extreme Gen 2, from some bug
> > > > > > > > > > reports I
> > > > > > > > > > dug up) and breaks another (Pixelbook); so unfortunately I
> > > > > > > > > > believe we
> > > > > > > > > > need a quirk at least for some laptop. Reading through the
> > > > > > > > > > copy of the
> > > > > > > > > > datasheet I have, it wasn't clear to me which was the
> > > > > > > > > > correct
> > > > > > > > > > interpretation. I'm cc'ing puthik@, who was leaning toward
> > > > > > > > > > the
> > > > > > > > > > current
> > > > > > > > > > kernel code (caring about LSB) being the correct
> > > > > > > > > > interpretation. I
> > > > > > > > > > believe we have other chromebooks which do rely on LSB
> > > > > > > > > > functionality,
> > > > > > > > > > so unless we can find more examples of laptops wanting MSB
> > > > > > > > > > it
> > > > > > > > > > currently looks like Pixelbook is the outlier.
> > > > > > > > > > 
> > > > > > > > > > On Thu, Sep 17, 2020 at 11:28 AM Jani Nikula
> > > > > > > > > > <jani.nikula@linux.intel.com> wrote:
> > > > > > > > > > > On Thu, 17 Sep 2020, Kevin Chowski <chowski@chromium.org
> > > > > > > > > > > >
> > > > > > > > > > > wrote:
> > > > > > > > > > > > We have observed that Google Pixelbook's backlight
> > > > > > > > > > > > hardware is
> > > > > > > > > > > > interpretting these backlight bits from the most-
> > > > > > > > > > > > significant side of the
> > > > > > > > > > > > 16 bit word (if DP_EDP_PWMGEN_BIT_COUNT < 16), whereas
> > > > > > > > > > > > the
> > > > > > > > > > > > driver code
> > > > > > > > > > > > assumes the peripheral cares about the least-
> > > > > > > > > > > > significant
> > > > > > > > > > > > bits.
> > > > > > > > > > > > 
> > > > > > > > > > > > Testing was done from within Chrome OS's build
> > > > > > > > > > > > environment
> > > > > > > > > > > > when the
> > > > > > > > > > > > patch is backported to 5.4 (the version we are newly
> > > > > > > > > > > > targeting for the
> > > > > > > > > > > > Pixelbook); for the record:
> > > > > > > > > > > >    $ emerge-eve-kernelnext sys-kernel/chromeos-kernel-
> > > > > > > > > > > > 5_4
> > > > > > > > > > > > && \
> > > > > > > > > > > >       ./update_kernel.sh --remote=$IP
> > > > > > > > > > > > 
> > > > > > > > > > > > I used `/sys/kernel/debug/dri/0/eDP-1/i915_dpcd` on my
> > > > > > > > > > > > laptop to verify
> > > > > > > > > > > > that the registers were being set according to what
> > > > > > > > > > > > the
> > > > > > > > > > > > actual hardware
> > > > > > > > > > > > expects; I also observe that the backlight is
> > > > > > > > > > > > noticeably
> > > > > > > > > > > > brighter with
> > > > > > > > > > > > this patch.
> > > > > > > > > > > 
> > > > > > > > > > > It's unclear to me what kernel version this is against,
> > > > > > > > > > > and
> > > > > > > > > > > what you've
> > > > > > > > > > > actually tested.
> > > > > > > > > > > 
> > > > > > > > > > > Have you tried v5.7 kernel with Lyude's fde7266fb2f6
> > > > > > > > > > > ("drm/i915: Fix eDP
> > > > > > > > > > > DPCD aux max backlight calculations")?
> > > > > > > > > > > 
> > > > > > > > > > > I just want to make sure you've tested with all the
> > > > > > > > > > > relevant
> > > > > > > > > > > fixes
> > > > > > > > > > > before adding quirks.
> > > > > > > > > > > 
> > > > > > > > > > > BR,
> > > > > > > > > > > Jani.
> > > > > > > > > > > 
> > > > > > > > > > > > Signed-off-by: Kevin Chowski <chowski@chromium.org>
> > > > > > > > > > > > ---
> > > > > > > > > > > > 
> > > > > > > > > > > >  .../drm/i915/display/intel_dp_aux_backlight.c | 34
> > > > > > > > > > > > +++++++++++++++++++
> > > > > > > > > > > >  drivers/gpu/drm/i915/display/intel_quirks.c   | 13
> > > > > > > > > > > > +++++++
> > > > > > > > > > > >  drivers/gpu/drm/i915/i915_drv.h               |  1 +
> > > > > > > > > > > >  3 files changed, 48 insertions(+)
> > > > > > > > > > > > 
> > > > > > > > > > > > diff --git
> > > > > > > > > > > > a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.
> > > > > > > > > > > > c
> > > > > > > > > > > > b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.
> > > > > > > > > > > > c
> > > > > > > > > > > > index acbd7eb66cbe3..99c98f217356d 100644
> > > > > > > > > > > > ---
> > > > > > > > > > > > a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.
> > > > > > > > > > > > c
> > > > > > > > > > > > +++
> > > > > > > > > > > > b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.
> > > > > > > > > > > > c
> > > > > > > > > > > > @@ -91,6 +91,23 @@ static u32
> > > > > > > > > > > > intel_dp_aux_get_backlight(struct intel_connector
> > > > > > > > > > > > *connector)
> > > > > > > > > > > >       if (intel_dp->edp_dpcd[2] &
> > > > > > > > > > > > DP_EDP_BACKLIGHT_BRIGHTNESS_BYTE_COUNT)
> > > > > > > > > > > >               level = (read_val[0] << 8 |
> > > > > > > > > > > > read_val[1]);
> > > > > > > > > > > > 
> > > > > > > > > > > > +     if (i915->quirks &
> > > > > > > > > > > > QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS) {
> > > > > > > > > > > > +             if (!drm_dp_dpcd_readb(&intel_dp->aux,
> > > > > > > > > > > > DP_EDP_PWMGEN_BIT_COUNT,
> > > > > > > > > > > > +                                             &read_va
> > > > > > > > > > > > l[0]
> > > > > > > > > > > > )) {
> > > > > > > > > > > > +                     DRM_DEBUG_KMS("Failed to read
> > > > > > > > > > > > DPCD
> > > > > > > > > > > > register 0x%x\n",
> > > > > > > > > > > > +                                     DP_EDP_PWMGEN_BI
> > > > > > > > > > > > T_CO
> > > > > > > > > > > > UNT);
> > > > > > > > > > > > +                     return 0;
> > > > > > > > > > > > +             }
> > > > > > > > > > > > +             // Only bits 4:0 are used, 7:5 are
> > > > > > > > > > > > reserved.
> > > > > > > > > > > > +             read_val[0] = read_val[0] & 0x1F;
> > > > > > > > > > > > +             if (read_val[0] > 16) {
> > > > > > > > > > > > +                     DRM_DEBUG_KMS("Invalid
> > > > > > > > > > > > DP_EDP_PWNGEN_BIT_COUNT 0x%X, expected at most 16\n",
> > > > > > > > > > > > +                                             read_val
> > > > > > > > > > > > [0])
> > > > > > > > > > > > ;
> > > > > > > > > > > > +                     return 0;
> > > > > > > > > > > > +             }
> > > > > > > > > > > > +             level >>= 16 - read_val[0];
> > > > > > > > > > > > +     }
> > > > > > > > > > > > +
> > > > > > > > > > > >       return level;
> > > > > > > > > > > >  }
> > > > > > > > > > > > 
> > > > > > > > > > > > @@ -106,6 +123,23 @@ intel_dp_aux_set_backlight(const
> > > > > > > > > > > > struct drm_connector_state *conn_state, u32 lev
> > > > > > > > > > > >       struct drm_i915_private *i915 =
> > > > > > > > > > > > dp_to_i915(intel_dp);
> > > > > > > > > > > >       u8 vals[2] = { 0x0 };
> > > > > > > > > > > > 
> > > > > > > > > > > > +     if (i915->quirks &
> > > > > > > > > > > > QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS) {
> > > > > > > > > > > > +             if (!drm_dp_dpcd_readb(&intel_dp->aux,
> > > > > > > > > > > > DP_EDP_PWMGEN_BIT_COUNT,
> > > > > > > > > > > > +                                             &vals[0]
> > > > > > > > > > > > )) {
> > > > > > > > > > > > +                     DRM_DEBUG_KMS("Failed to write
> > > > > > > > > > > > aux
> > > > > > > > > > > > backlight level: Failed to read DPCD register 0x%x\n",
> > > > > > > > > > > > +                                       DP_EDP_PWMGEN_
> > > > > > > > > > > > BIT_
> > > > > > > > > > > > COUNT);
> > > > > > > > > > > > +                     return;
> > > > > > > > > > > > +             }
> > > > > > > > > > > > +             // Only bits 4:0 are used, 7:5 are
> > > > > > > > > > > > reserved.
> > > > > > > > > > > > +             vals[0] = vals[0] & 0x1F;
> > > > > > > > > > > > +             if (vals[0] > 16) {
> > > > > > > > > > > > +                     DRM_DEBUG_KMS("Failed to write
> > > > > > > > > > > > aux
> > > > > > > > > > > > backlight level: Invalid DP_EDP_PWNGEN_BIT_COUNT 0x%X,
> > > > > > > > > > > > expected at most 16\n",
> > > > > > > > > > > > +                                             vals[0])
> > > > > > > > > > > > ;
> > > > > > > > > > > > +                     return;
> > > > > > > > > > > > +             }
> > > > > > > > > > > > +             level <<= (16 - vals[0]) & 0xFFFF;
> > > > > > > > > > > > +     }
> > > > > > > > > > > > +
> > > > > > > > > > > >       vals[0] = level;
> > > > > > > > > > > > 
> > > > > > > > > > > >       /* Write the MSB and/or LSB */
> > > > > > > > > > > > diff --git
> > > > > > > > > > > > a/drivers/gpu/drm/i915/display/intel_quirks.c
> > > > > > > > > > > > b/drivers/gpu/drm/i915/display/intel_quirks.c
> > > > > > > > > > > > index 46beb155d835f..63b27d49b2864 100644
> > > > > > > > > > > > --- a/drivers/gpu/drm/i915/display/intel_quirks.c
> > > > > > > > > > > > +++ b/drivers/gpu/drm/i915/display/intel_quirks.c
> > > > > > > > > > > > @@ -53,6 +53,16 @@ static void
> > > > > > > > > > > > quirk_increase_ddi_disabled_time(struct
> > > > > > > > > > > > drm_i915_private
> > > > > > > > > > > > *i915)
> > > > > > > > > > > >       drm_info(&i915->drm, "Applying Increase DDI
> > > > > > > > > > > > Disabled
> > > > > > > > > > > > quirk\n");
> > > > > > > > > > > >  }
> > > > > > > > > > > > 
> > > > > > > > > > > > +/*
> > > > > > > > > > > > + * Some eDP backlight hardware uses the most-
> > > > > > > > > > > > significant
> > > > > > > > > > > > bits of the brightness
> > > > > > > > > > > > + * register, so brightness values must be shifted
> > > > > > > > > > > > first.
> > > > > > > > > > > > + */
> > > > > > > > > > > > +static void
> > > > > > > > > > > > quirk_shift_edp_backlight_brightness(struct
> > > > > > > > > > > > drm_i915_private *i915)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +     i915->quirks |=
> > > > > > > > > > > > QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS;
> > > > > > > > > > > > +     DRM_INFO("Applying shift eDP backlight
> > > > > > > > > > > > brightness
> > > > > > > > > > > > quirk\n");
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > >  struct intel_quirk {
> > > > > > > > > > > >       int device;
> > > > > > > > > > > >       int subsystem_vendor;
> > > > > > > > > > > > @@ -156,6 +166,9 @@ static struct intel_quirk
> > > > > > > > > > > > intel_quirks[] = {
> > > > > > > > > > > >       /* ASRock ITX*/
> > > > > > > > > > > >       { 0x3185, 0x1849, 0x2212,
> > > > > > > > > > > > quirk_increase_ddi_disabled_time },
> > > > > > > > > > > >       { 0x3184, 0x1849, 0x2212,
> > > > > > > > > > > > quirk_increase_ddi_disabled_time },
> > > > > > > > > > > > +
> > > > > > > > > > > > +     /* Google Pixelbook */
> > > > > > > > > > > > +     { 0x591E, 0x8086, 0x2212,
> > > > > > > > > > > > quirk_shift_edp_backlight_brightness },
> > > > > > > > > > > >  };
> > > > > > > > > > > > 
> > > > > > > > > > > >  void intel_init_quirks(struct drm_i915_private *i915)
> > > > > > > > > > > > diff --git a/drivers/gpu/drm/i915/i915_drv.h
> > > > > > > > > > > > b/drivers/gpu/drm/i915/i915_drv.h
> > > > > > > > > > > > index e4f7f6518945b..cc93bede4fab8 100644
> > > > > > > > > > > > --- a/drivers/gpu/drm/i915/i915_drv.h
> > > > > > > > > > > > +++ b/drivers/gpu/drm/i915/i915_drv.h
> > > > > > > > > > > > @@ -525,6 +525,7 @@ struct i915_psr {
> > > > > > > > > > > >  #define QUIRK_PIN_SWIZZLED_PAGES (1<<5)
> > > > > > > > > > > >  #define QUIRK_INCREASE_T12_DELAY (1<<6)
> > > > > > > > > > > >  #define QUIRK_INCREASE_DDI_DISABLED_TIME (1<<7)
> > > > > > > > > > > > +#define QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS (1<<8)
> > > > > > > > > > > > 
> > > > > > > > > > > >  struct intel_fbdev;
> > > > > > > > > > > >  struct intel_fbc_work;
> > > > > > > > > > > 
> > > > > > > > > > > --
> > > > > > > > > > > Jani Nikula, Intel Open Source Graphics Center
> > > > > > > > 
> > > > > > > > --
> > > > > > > > Ville Syrjälä
> > > > > > > > Intel
> > > > > > > > _______________________________________________
> > > > > > > > Intel-gfx mailing list
> > > > > > > > Intel-gfx@lists.freedesktop.org
> > > > > > > > https://lists.freedesktop.org/mailman/listinfo/intel-gfx
> > > > > > > 
> > > > > > > --
> > > > > > > Ville Syrjälä
> > > > > > > Intel
> > --
> > Cheers,
> >         Lyude Paul (she/her)
> >         Software Engineer at Red Hat
> > 
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat


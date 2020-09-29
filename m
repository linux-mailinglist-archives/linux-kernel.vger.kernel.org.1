Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF9B27D6F7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgI2TdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgI2TdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:33:04 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0240C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 12:33:04 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id m17so6094194ioo.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 12:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JYFCRpHB7ScAzK88pmUZvQhVzbzRw8Fx28t3kJjd5cw=;
        b=IjKUiu1NuCBZpwuZxjNq6AjIg5m3k8MMhIjwtx/BM8Vylohh8DdKWNJW5XILHGeB9b
         lD1BVyVqYBuDVPPfiAwvSfJ7nFrGGbpWm2LbrzXzLpJWCtQuRs7eotybIyK9YJc/1L5u
         UggPBJilaHkStYAED9seppeQ03+jbtWPl8iUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JYFCRpHB7ScAzK88pmUZvQhVzbzRw8Fx28t3kJjd5cw=;
        b=CN5KpcciL4zmCMqj39ha3EWy/3/IILAS8DoruCJEAKKSFb5+laPyoYrwtXvVr+izOW
         LJeFdXyl4zb2T9RKl0c05D2iwB6whizH2M4GC2ucDl+ldMMCXjXk9QDreDGEngXvF8Su
         fgNSXlbfzeCdcNwjSZpJYluqJlEQPPfV0+CfwY2f9BnbcXBFohylJTEzJgyMPp+eyopZ
         eDWUmezmb2Fyi86F2PiKS/qEe6m0wwAJAP+1gaWInvjpWqJhugxcseaXS1mV03ho/KOj
         +LzVk/o+T6WFg2fsai6wgDswLgf3LbdRuuYbTNO/GReZl6gT4s6F3CmfYFETGb2CPH5G
         VK2w==
X-Gm-Message-State: AOAM532oI2U+H99IAlp5T5iXecAYkv12YjyydEwAS5Iy+1CcgPiIlLxg
        8sO0SeQCrTl/l3lbE8CyEB9xKtu2c6FBjTkmMWfcpw==
X-Google-Smtp-Source: ABdhPJz27cHFe3lIYi83BloigrU0WvSNaGzs3E0FKRARqHHsHboxQCoDNsiVvrthYewrH8H+ZapQMQ6+za7Q2JAeFKs=
X-Received: by 2002:a6b:7112:: with SMTP id q18mr3665826iog.79.1601407983439;
 Tue, 29 Sep 2020 12:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200917110838.1.I63d52f5b96d7e81e1e2dc2a72c4bf5fd84d3d3d0@changeid>
 <87o8m4uxcn.fsf@intel.com> <CANM=9DOn9wvL1RBDhxzawY1rRq0PFUBmKdXUGmG1CygApK1Vyg@mail.gmail.com>
 <CANCcNXc18jEXF+wdLm8sxR3ySR88D8S65a2x_vYtR5ihZ6XnMw@mail.gmail.com>
 <20200917182535.GC6112@intel.com> <20200917201102.GD6112@intel.com>
 <CANM=9DNOHHjrmBRhBGE2_WEumQ612jUFAJPO8x=Zs6EY-R87+A@mail.gmail.com>
 <CANCcNXcegO7it_Cv2j+zS0qK57h6E0zngYKE4=m1YTyEpE6eqA@mail.gmail.com>
 <CANM=9DMQgFSZ3x8Oz-FF2=S041A8fb3afRSa21mWbNhgbZKU+w@mail.gmail.com>
 <CANCcNXdYjMxt6Yw-9j0QaZagUnuTtABKmVF_3N8GjRE_uO8Rng@mail.gmail.com>
 <a90da83996a15ddf4d4ae89cea9d20fc5c6ee021.camel@redhat.com>
 <CANM=9DPYDeAaNMWyPO5dus8Z-WL2Y+mewFQWd1YiNUyN2JeQnw@mail.gmail.com> <e03e94af2b058f3eb732bceb25a74d748c0f25cf.camel@redhat.com>
In-Reply-To: <e03e94af2b058f3eb732bceb25a74d748c0f25cf.camel@redhat.com>
From:   Kevin Chowski <chowski@chromium.org>
Date:   Tue, 29 Sep 2020 13:32:52 -0600
Message-ID: <CANM=9DPhKtLh90iujfTHYXahc-E7sC_-toqFkDsDB27PR9xRAg@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH] i915: Introduce quirk for shifting eDP brightness.
To:     Lyude Paul <lyude@redhat.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Puthikorn Voravootivat <puthik@chromium.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the reply. And in regards to digging into it further,
thanks for requesting that I do some more due diligence here :)

Also if you did get around to it, thanks for double-checking with
Bill! Let me know if you'd like me to reach out instead, or if
anything else needs to be done in this regard.

So to clarify the plan: if we do actually move forwards with leaving
the current functionality as the default, do we need to have the
complete list of devices which need the quirk applied when the patch
first goes in? From my perspective, we definitely have one device
which needs the quirk (and preferably, it'd be good to do it sooner
than later so that we can get this bugfix out to our users) and an
unknowable number of others. Would it be OK to introduce the quirk for
just Pixelbook and to follow up to add others once we have that list?
It may take a good amount of time for me to herd the cats inside
Google, especially given there's a chance that there are affected
laptops and that no one has noticed (e.g., I almost didn't notice with
the Pixelbook). Given Lyude's analysis it seems like Chrome OS devices
may be the largest affected group here, so I am incentivized to not
drop the ball after fixing my immediate Pixelbook problem :)

On Fri, Sep 25, 2020 at 10:53 AM Lyude Paul <lyude@redhat.com> wrote:
>
> On Thu, 2020-09-24 at 17:46 -0600, Kevin Chowski wrote:
> > cc back a few others who were unintentionally dropped from the thread
> > earlier.
> >
> > Someone (at Google) helped me dig into this a little more and they
> > found a document titled "eDP Backlight Brightness bit alignment" sent
> > out for review in January 2017. I registered for a new account (google
> > is a member) and have access to the document; here is the URL for
> > those who also have access:
> > https://groups.vesa.org/wg/AllMem/document/7786. For what it's worth,
> > it seems like Lyude's contact Bill Lempesis uploaded this
> > change-request document, so I think we can reach out to him if we have
> > further questions. It's actually unclear to me what the status of this
> > change request is, and whether it's been officially accepted. But I
> > think it can be seen as some official advice on how we can move
> > forward here.
> >
> > Basically, this is a change request to the spec which acknowledges
> > that, despite the original spec implying that the
> > most-significant-bits were relevant here, many implementations used
> > the least-significant-bits. In defense of most-significant it laid out
> > some similar arguments to what Ville was saying. But it ends up
> > saying:
> >
> > > Unfortunately, the most common interpretation that we have
> > > encountered is case 1 in the example above. TCON vendors
> > > tend to align the valid bits to the LSBs, not the MSBs.
> >
> > Instead of changing the default defined functionality (as some earlier
> > version of this doc apparently suggested), this doc prefers to
> > allocate two extra bits in EDP_GENERAL_CAPABILITY_2 so that future
> > backlight devices can specify to the Source how to program them:
> >
> > 00: the current functionality, i,e. no defined interpretation
> > 01: aligned to most-significant bits
> > 10: aligned to least-significant bits
> > 11: reserved
> >
> > It also says "[Sources] should only need panel-specific workarounds
> > for the currently available panels."
> >
> > So I believe this document is an acknowledgement of many
> > implementations having their alignment to the least-significant bits,
> > and (to my eyes) clearly validates that the spec "should" be the
> > opposite. If we believe the doc's claim that "the most common
> > interpretation" is least-significant, it seems to me that it would
> > require more quirks if we made most-significant the default
> > implementation.
> >
> > Ville mentioned at some point earlier that we should try to match the
> > spec, whereas Lyude mentioned we should prefer to do what the majority
> > of machines do. What do you both think of this new development?
>
> That's how displayport happens to be sometimes :). Definitely isn't the f=
irst
> time something in the spec like this got implemented incorrectly so many =
times
> by different vendors that they had to update the spec in response (same t=
hing
> happened with MST and interleaved sideband messages as of DP 2.0), so I'm
> really glad we went and actually investigated this.
>
> So yes - I think a quirk for this would definitely be a good idea, and IM=
O we
> should always lean on the side that more panels implement even if it's no=
t
> according to spec - so defaulting to the behavior we currently have in th=
e
> kernel, and adding quirks for panels that were smart enough not to fall f=
or
> this would probably be the best way to go. That just leaves the challenge=
 of
> "how do we figure out which panels actually need this and which ones don'=
t?"
>
> This might end up being a bit of a challenge, but I've got some ideas on =
how
> we might be able to tackle it to the best of our ability based off my
> discussions with laptop vendors. It seems like some of the homegrown back=
light
> interfaces might help us out here. Note I'm mentioning other laptop vendo=
rs
> here because at least for nouveau, our plan for DPCD backlight support is=
 to
> move a lot of the code for handling it that currently lives in i915 into
> shared DRM helpers (which now we'll definitely need to do as a result of =
these
> quirks).
>
> So, on the x86 front, there's already a few different interfaces in use f=
or
> laptop panels:
>  * AMD usually uses their own backlight interface, so for AMD-only laptop=
s we
>    can probably safely ignore this
>  * Intel uses their own DPCD backlight interface on most of the _non-Chro=
meOS_
>    machines on the market right now afaik based off my discussion with so=
me
>    laptop vendors. For panels that only come up in Intel-only machines, t=
hat
>    means we only really need to care about the ChromeOS case here. So-if
>    Google's able to actually survey the devices they're shipping with Chr=
omeOS
>    right now to figure out which ones are using DPCD backlight controls, =
and
>    which ones need to be MSB aligned - then I'd think we could probably b=
uild
>    an accurate quirk list of those panels easily.
>  * This just leaves the nvidia case. Nvidia seems to be one of the only G=
PU
>    vendors that didn't come up with their own backlight interface over DP=
CD,
>    and they actually require that the panel support the VESA backlight co=
ntrol
>    interface. Incidentally, a lot of the laptops that I've force-enabled =
VESA
>    backlight controls on have nvidia GPUs in them, and so far every singl=
e one
>    has worked with the code we currently use in the kernel. My hope with =
this
>    would be that since nvidia's driver support is somewhat consistent, th=
ey
>    either might have a list of problematic panels or can just verify with=
 us
>    that all of the panels that their driver interacts with follow the LSB
>    preference.
>
> For the ChromeOS guys in the thread, does this sound like it could be
> workable? For the time being, I'll also send my nvidia contacts a poke to=
 see
> what info they can give us. As well, we should probably poke Bill just in=
 case
> he might know of some resource that documents some of the problematic pan=
els
> out there (probably not, but it's at least worth a shot). I'll try to get
> around this today, but we might have to poke him once or twice since ther=
e
> originally was a problem with any of the emails from Red Hat getting thro=
ugh
> to him=E2=80=A6
>
> >
> > I will also look into whether my specific device supports this
> > extension, and in that case I'll volunteer to implement this new
> > functionality in the driver.
> >
> > Thanks for your time,
> > Kevin
> >
> > On Tue, Sep 22, 2020 at 3:30 PM Lyude Paul <lyude@redhat.com> wrote:
> > > Hi! Since I got dropped from the thread, many responses inline
> > >
> > > On Tue, 2020-09-22 at 12:58 -0700, Puthikorn Voravootivat wrote:
> > > > +Lyude
> > > > I notice that Lyude email was somehow dropped from the thread.
> > > > Lyude was the person who submitted the patch for Thinkpad and shoul=
d
> > > > know the OUI of the panel.
> > >
> > > no need - currently because of some confusion that got caused by the =
Intel
> > > HDR
> > > backlight interface being the only backlight interface that works pro=
perly
> > > on
> > > a lot of panels (many panels will advertise both interfaces, but migh=
t
> > > only
> > > work with the Intel one), we actually rely on a small allowlist of
> > > "approved"
> > > panels for enabling DPCD backlight control.
> > >
> > > =E2=80=A6however, many of these panels are annoying and don't actuall=
y provide a
> > > reliable enough OUID to use for quirk detection, which is why we had =
to
> > > add
> > > EDID quirk detection as a temporary workaround for this. The current =
list
> > > of
> > > panels lives in drm_dp_helper.c:
> > >
> > > /*
> > >  * Some devices have unreliable OUIDs where they don't set the device=
 ID
> > >  * correctly, and as a result we need to use the EDID for finding
> > > additional
> > >  * DP quirks in such cases.
> > >  */
> > > static const struct edid_quirk edid_quirk_list[] =3D {
> > >         /* Optional 4K AMOLED panel in the ThinkPad X1 Extreme 2nd
> > > Generation
> > >          * only supports DPCD backlight controls
> > >          */
> > >         { MFG(0x4c, 0x83), PROD_ID(0x41, 0x41),
> > > BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
> > >         /*
> > >          * Some Dell CML 2020 systems have panels support both AUX an=
d PWM
> > >          * backlight control, and some only support AUX backlight con=
trol.
> > > All
> > >          * said panels start up in AUX mode by default, and we don't =
have
> > > any
> > >          * support for disabling HDR mode on these panels which would=
 be
> > >          * required to switch to PWM backlight control mode (plus, I'=
m not
> > >          * even sure we want PWM backlight controls over DPCD backlig=
ht
> > >          * controls anyway...). Until we have a better way of detecti=
ng
> > > these,
> > >          * force DPCD backlight mode on all of them.
> > >          */
> > >         { MFG(0x06, 0xaf), PROD_ID(0x9b, 0x32),
> > > BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
> > >         { MFG(0x06, 0xaf), PROD_ID(0xeb, 0x41),
> > > BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
> > >         { MFG(0x4d, 0x10), PROD_ID(0xc7, 0x14),
> > > BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
> > >         { MFG(0x4d, 0x10), PROD_ID(0xe6, 0x14),
> > > BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
> > >         { MFG(0x4c, 0x83), PROD_ID(0x47, 0x41),
> > > BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
> > > };
> > >
> > > Also note that I think just about every panel on that list supports t=
he
> > > Intel
> > > HDR backlight interface, so it's -possible- that the VESA interface c=
ould
> > > be
> > > broken on these panels. But, that would be a lot of different panels =
from
> > > different vendors to all be broken in the same way.
> > >
> > > > On Tue, Sep 22, 2020 at 11:47 AM Kevin Chowski <chowski@chromium.or=
g>
> > > > wrote:
> > > > > Alrighty, I'll take everyone else's silence as tacit approval of
> > > > > Ville's opinions. (I didn't receive any email bounces this time, =
so I
> > > > > think my issue was transient.) I will start on inverting the quir=
k and
> > > > > making the most-significant-alignment matter for these registers =
by
> > > > > default.
> > > > >
> > > > > Who can help me gather a list of OUIs that we need to add to the
> > > > > quirk? I can follow up with Puthikorn about the relevant Chromebo=
oks,
> > > > > but I don't know what other types of laptops are using this drive=
r.
> > > > >
> > > > > Thanks for your time,
> > > > > Kevin Chowski
> > > > >
> > > > >
> > > > > On Fri, Sep 18, 2020 at 12:16 PM Puthikorn Voravootivat
> > > > > <puthik@chromium.org> wrote:
> > > > > > I'll defer to Ville & Lyude.
> > > > > >
> > > > > > I dug up more on the bug report and found that both Thinkpad an=
d
> > > > > > Galaxy Chromebook use the same Samsung OLED.
> > > > > > So my 2 vs 1 argument is actually not valid.
> > > > > >
> > > > > > On Fri, Sep 18, 2020 at 10:59 AM Kevin Chowski <chowski@chromiu=
m.org
> > > > > > >
> > > > > > wrote:
> > > > > > > Apologies once again, some of my emails were bouncing for som=
e
> > > > > > > addresses yesterday. Hopefully it was a temporary condition; =
I'll
> > > > > > > continue trying to dig into it on my end if it happens again =
for
> > > > > > > this
> > > > > > > email.
> > > > > > >
> > > > > > > Since there's evidence that some models want lsb and some (we=
ll,
> > > > > > > at
> > > > > > > least one) want msb, my understanding is that we'll need a qu=
irk
> > > > > > > one
> > > > > > > way or the other (please correct if I'm mistaken). I unfortun=
ately
> > > > > > > don't have the ability to test anything other than the Pixelb=
ook,
> > > > > > > so
> > > > > > > if we decide the msb is the "right" way, then I will have to =
rely
> > > > > > > on
> > > > > > > others to test (and find the OUI of) other models which requi=
re
> > > > > > > lsb.
> > > > > > >
> > > > > > > I am happy to make any changes requested, but I do not at all=
 have
> > > > > > > enough background here to make the decision on whether the ms=
b
> > > > > > > functionality deserves the quirk or if the lsb one does. How =
can I
> > > > > > > help you all come to an agreement here?
> > > > > > >
> > > > > > > * It seems like Ville feels strongly about the msb being the
> > > > > > > correct
> > > > > > > interpretation of the spec.
> > > > > > > * It's unclear to me on which side of the fence Lyude falls, =
I
> > > > > > > couldn't pick up a strong opinion in her clarifying question.
> > > > > > > * Puthikorn seems to be on the side of lsb being correct, but
> > > > > > > maybe
> > > > > > > was swayed by Ville's argument.
> > >
> > > Honestly I'm not hard to convince :P, if it looks like we got the bit
> > > shift
> > > wrong for the majority of devices and everyone else agrees then I'm f=
ine
> > > with
> > > assuming that's the case. I'm just quite surprised, seeing as we've t=
ested
> > > many different panels from a few vendors and haven't run into any iss=
ues
> > > with
> > > this before.
> > >
> > > Honestly - if there's this much uncertainty about it, maybe we should=
 just
> > > ask
> > > VESA directly what the correct interpretation of this is? Note I'm no=
t on
> > > the
> > > VESA board (I get access to DP/eDP specs through X.org) so unless the
> > > contacts
> > > I've got from VESA would work (Bill Lempesis bill at vesa dot org) fo=
r
> > > that it
> > > might be a better idea for someone from Google or Intel to ask.
> > >
> > > > > > > If no one feels that Ville's argument is not strong in some w=
ay,
> > > > > > > and
> > > > > > > we go with that, I will get to work on the requested changes.=
 I am
> > > > > > > concerned, though, about changing the default functionality
> > > > > > > without
> > > > > > > testing it widely to find the set of laptops which require th=
e lsb
> > > > > > > quirk. I'd appreciate any advice people might have about maki=
ng
> > > > > > > this
> > > > > > > change safely.
> > >
> > > Usually, I just try to stick with what the majority of machines need =
to
> > > do. I
> > > still think it'd be a good idea for us to verify this with VESA if th=
ere's
> > > that much confusion though
> > >
> > > > > > > Thank you for your time,
> > > > > > > Kevin
> > > > > > >
> > > > > > > On Thu, Sep 17, 2020 at 2:11 PM Ville Syrj=C3=A4l=C3=A4
> > > > > > > <ville.syrjala@linux.intel.com> wrote:
> > > > > > > > On Thu, Sep 17, 2020 at 09:25:35PM +0300, Ville Syrj=C3=A4l=
=C3=A4 wrote:
> > > > > > > > > On Thu, Sep 17, 2020 at 11:14:43AM -0700, Puthikorn
> > > > > > > > > Voravootivat
> > > > > > > > > wrote:
> > > > > > > > > > The Lyude fde7266fb2f6 change is actually based on Chro=
mium
> > > > > > > > > > change
> > > > > > > > > > (https://crrev.com/c/1650325) that fixes the brightness=
 for
> > > > > > > > > > Samsung
> > > > > > > > > > Galaxy Chromebook. So currently we have 2 examples that=
 use
> > > > > > > > > > LSB
> > > > > > > > > > interpretation and 1 that use MSB.
> > > > > > > > >
> > > > > > > > > "If field 4:0 of the EDP_PWMGEN_BIT_COUNT register repres=
ents
> > > > > > > > > a
> > > > > > > > > value
> > > > > > > > > of greater than 8 and the BACKLIGHT_BRIGHTNESS_BYTE_COUNT=
 bit
> > > > > > > > > is cleared to 0, only the 8 MSB of the brightness control
> > > > > > > > > value
> > > > > > > > > can be
> > > > > > > > > controlled.
> > > > > > > > > (See Note below.)
> > > > > > > > > Assigned bits are allocated to the MSB of the enabled reg=
ister
> > > > > > > > > combination."
> > > > > > > > >
> > > > > > > > > I think that's pretty clear the assigned bits are suppose=
d to
> > > > > > > > > be
> > > > > > > > > msb aligned.
> > > > > > > >
> > > > > > > > I guess there's some email issues happening, but just to
> > > > > > > > clarify:
> > > > > > > >
> > > > > > > > When the spec says MSB in caps here it clearly means
> > > > > > > > "most significant-bit(s)" since otherwise "8 MSB" would not=
 make
> > > > > > > > any sense in the context of a 2 byte value.
> > > > > > > >
> > > > > > > > Granted the spec is crap here since "Table 1-1: Acronyms an=
d
> > > > > > > > Initialism" does claim "MSB" should be byte(s) and "msb" bi=
t(s).
> > > > > > > >
> > > > > > > > Also I can't imagine anyone would allocate the bits startin=
g
> > > > > > > > from the lsb when the whole thing is clearly supposed to be=
 a
> > > > > > > > 16bit big endian integer. So with >8 assigned bits you'd en=
d
> > > > > > > > up with crazy stuff like this:
> > > > > > > >
> > > > > > > > [ 7 ... 0 ][7   ...   0]
> > > > > > > > [ 8 MSB   ][XXXX][N LSB]
> > > > > > > >
> > > > > > > > so you couldn't even treat the value as a regular big endia=
n
> > > > > > > > thing. Instead, if you squint a bit, it now looks like a fu=
nky
> > > > > > > > little endian value. So we're deep into some mixed endian l=
and
> > > > > > > > where nothing makes sense anymore.
> > > > > > > >
> > > > > > > > Anyways I think the code should simply do this to match the
> > > > > > > > spec:
> > > > > > > > u16 value =3D brightness << (16 - num_assigned_bits);
> > > > > > > > val[0] =3D value >> 8;
> > > > > > > > val[1] =3D value & 0xff;
> > > > > > > >
> > > > > > > >
> > > > > > > > > > On Thu, Sep 17, 2020 at 10:55 AM Kevin Chowski <
> > > > > > > > > > chowski@chromium.org> wrote:
> > > > > > > > > > > Apologies for being too vague. To be as precise I can=
 be,
> > > > > > > > > > > here
> > > > > > > > > > > is the
> > > > > > > > > > > specific code delta I tested: https://crrev.com/c/240=
6616
> > > > > > > > > > > . To
> > > > > > > > > > > answer
> > > > > > > > > > > your other question, the code I tested against is ind=
eed
> > > > > > > > > > > including the
> > > > > > > > > > > fde7266fb2f6 (despite ostensibly being called 5.4 in =
my
> > > > > > > > > > > commit
> > > > > > > > > > > message): our current top-of-tree for our 5.4 branch
> > > > > > > > > > > includes
> > > > > > > > > > > the
> > > > > > > > > > > intel_dp_aux_calc_max_backlight logic. Further, I'll =
note
> > > > > > > > > > > that
> > > > > > > > > > > change
> > > > > > > > > > > is exactly the change which breaks my Pixelbook model=
:
> > > > > > > > > > > prior
> > > > > > > > > > > to the
> > > > > > > > > > > change, the max_brightness was hard-coded to 0xFFFF a=
nd
> > > > > > > > > > > the
> > > > > > > > > > > math
> > > > > > > > > > > worked out that it didn't matter that the hardware ca=
red
> > > > > > > > > > > about
> > > > > > > > > > > the MSB
> > > > > > > > > > > despite the driver code caring about the LSB.
> > > > > > > > > > >
> > > > > > > > > > > To answer Ville's question: the fde7266fb2f6 change w=
hich
> > > > > > > > > > > fixes one
> > > > > > > > > > > laptop (I believe Thinkpad X1 extreme Gen 2, from som=
e bug
> > > > > > > > > > > reports I
> > > > > > > > > > > dug up) and breaks another (Pixelbook); so unfortunat=
ely I
> > > > > > > > > > > believe we
> > > > > > > > > > > need a quirk at least for some laptop. Reading throug=
h the
> > > > > > > > > > > copy of the
> > > > > > > > > > > datasheet I have, it wasn't clear to me which was the
> > > > > > > > > > > correct
> > > > > > > > > > > interpretation. I'm cc'ing puthik@, who was leaning t=
oward
> > > > > > > > > > > the
> > > > > > > > > > > current
> > > > > > > > > > > kernel code (caring about LSB) being the correct
> > > > > > > > > > > interpretation. I
> > > > > > > > > > > believe we have other chromebooks which do rely on LS=
B
> > > > > > > > > > > functionality,
> > > > > > > > > > > so unless we can find more examples of laptops wantin=
g MSB
> > > > > > > > > > > it
> > > > > > > > > > > currently looks like Pixelbook is the outlier.
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Sep 17, 2020 at 11:28 AM Jani Nikula
> > > > > > > > > > > <jani.nikula@linux.intel.com> wrote:
> > > > > > > > > > > > On Thu, 17 Sep 2020, Kevin Chowski <chowski@chromiu=
m.org
> > > > > > > > > > > > >
> > > > > > > > > > > > wrote:
> > > > > > > > > > > > > We have observed that Google Pixelbook's backligh=
t
> > > > > > > > > > > > > hardware is
> > > > > > > > > > > > > interpretting these backlight bits from the most-
> > > > > > > > > > > > > significant side of the
> > > > > > > > > > > > > 16 bit word (if DP_EDP_PWMGEN_BIT_COUNT < 16), wh=
ereas
> > > > > > > > > > > > > the
> > > > > > > > > > > > > driver code
> > > > > > > > > > > > > assumes the peripheral cares about the least-
> > > > > > > > > > > > > significant
> > > > > > > > > > > > > bits.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Testing was done from within Chrome OS's build
> > > > > > > > > > > > > environment
> > > > > > > > > > > > > when the
> > > > > > > > > > > > > patch is backported to 5.4 (the version we are ne=
wly
> > > > > > > > > > > > > targeting for the
> > > > > > > > > > > > > Pixelbook); for the record:
> > > > > > > > > > > > >    $ emerge-eve-kernelnext sys-kernel/chromeos-ke=
rnel-
> > > > > > > > > > > > > 5_4
> > > > > > > > > > > > > && \
> > > > > > > > > > > > >       ./update_kernel.sh --remote=3D$IP
> > > > > > > > > > > > >
> > > > > > > > > > > > > I used `/sys/kernel/debug/dri/0/eDP-1/i915_dpcd` =
on my
> > > > > > > > > > > > > laptop to verify
> > > > > > > > > > > > > that the registers were being set according to wh=
at
> > > > > > > > > > > > > the
> > > > > > > > > > > > > actual hardware
> > > > > > > > > > > > > expects; I also observe that the backlight is
> > > > > > > > > > > > > noticeably
> > > > > > > > > > > > > brighter with
> > > > > > > > > > > > > this patch.
> > > > > > > > > > > >
> > > > > > > > > > > > It's unclear to me what kernel version this is agai=
nst,
> > > > > > > > > > > > and
> > > > > > > > > > > > what you've
> > > > > > > > > > > > actually tested.
> > > > > > > > > > > >
> > > > > > > > > > > > Have you tried v5.7 kernel with Lyude's fde7266fb2f=
6
> > > > > > > > > > > > ("drm/i915: Fix eDP
> > > > > > > > > > > > DPCD aux max backlight calculations")?
> > > > > > > > > > > >
> > > > > > > > > > > > I just want to make sure you've tested with all the
> > > > > > > > > > > > relevant
> > > > > > > > > > > > fixes
> > > > > > > > > > > > before adding quirks.
> > > > > > > > > > > >
> > > > > > > > > > > > BR,
> > > > > > > > > > > > Jani.
> > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Kevin Chowski <chowski@chromium.or=
g>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >
> > > > > > > > > > > > >  .../drm/i915/display/intel_dp_aux_backlight.c | =
34
> > > > > > > > > > > > > +++++++++++++++++++
> > > > > > > > > > > > >  drivers/gpu/drm/i915/display/intel_quirks.c   | =
13
> > > > > > > > > > > > > +++++++
> > > > > > > > > > > > >  drivers/gpu/drm/i915/i915_drv.h               | =
 1 +
> > > > > > > > > > > > >  3 files changed, 48 insertions(+)
> > > > > > > > > > > > >
> > > > > > > > > > > > > diff --git
> > > > > > > > > > > > > a/drivers/gpu/drm/i915/display/intel_dp_aux_backl=
ight.
> > > > > > > > > > > > > c
> > > > > > > > > > > > > b/drivers/gpu/drm/i915/display/intel_dp_aux_backl=
ight.
> > > > > > > > > > > > > c
> > > > > > > > > > > > > index acbd7eb66cbe3..99c98f217356d 100644
> > > > > > > > > > > > > ---
> > > > > > > > > > > > > a/drivers/gpu/drm/i915/display/intel_dp_aux_backl=
ight.
> > > > > > > > > > > > > c
> > > > > > > > > > > > > +++
> > > > > > > > > > > > > b/drivers/gpu/drm/i915/display/intel_dp_aux_backl=
ight.
> > > > > > > > > > > > > c
> > > > > > > > > > > > > @@ -91,6 +91,23 @@ static u32
> > > > > > > > > > > > > intel_dp_aux_get_backlight(struct intel_connector
> > > > > > > > > > > > > *connector)
> > > > > > > > > > > > >       if (intel_dp->edp_dpcd[2] &
> > > > > > > > > > > > > DP_EDP_BACKLIGHT_BRIGHTNESS_BYTE_COUNT)
> > > > > > > > > > > > >               level =3D (read_val[0] << 8 |
> > > > > > > > > > > > > read_val[1]);
> > > > > > > > > > > > >
> > > > > > > > > > > > > +     if (i915->quirks &
> > > > > > > > > > > > > QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS) {
> > > > > > > > > > > > > +             if (!drm_dp_dpcd_readb(&intel_dp->a=
ux,
> > > > > > > > > > > > > DP_EDP_PWMGEN_BIT_COUNT,
> > > > > > > > > > > > > +                                             &re=
ad_va
> > > > > > > > > > > > > l[0]
> > > > > > > > > > > > > )) {
> > > > > > > > > > > > > +                     DRM_DEBUG_KMS("Failed to re=
ad
> > > > > > > > > > > > > DPCD
> > > > > > > > > > > > > register 0x%x\n",
> > > > > > > > > > > > > +                                     DP_EDP_PWMG=
EN_BI
> > > > > > > > > > > > > T_CO
> > > > > > > > > > > > > UNT);
> > > > > > > > > > > > > +                     return 0;
> > > > > > > > > > > > > +             }
> > > > > > > > > > > > > +             // Only bits 4:0 are used, 7:5 are
> > > > > > > > > > > > > reserved.
> > > > > > > > > > > > > +             read_val[0] =3D read_val[0] & 0x1F;
> > > > > > > > > > > > > +             if (read_val[0] > 16) {
> > > > > > > > > > > > > +                     DRM_DEBUG_KMS("Invalid
> > > > > > > > > > > > > DP_EDP_PWNGEN_BIT_COUNT 0x%X, expected at most 16=
\n",
> > > > > > > > > > > > > +                                             rea=
d_val
> > > > > > > > > > > > > [0])
> > > > > > > > > > > > > ;
> > > > > > > > > > > > > +                     return 0;
> > > > > > > > > > > > > +             }
> > > > > > > > > > > > > +             level >>=3D 16 - read_val[0];
> > > > > > > > > > > > > +     }
> > > > > > > > > > > > > +
> > > > > > > > > > > > >       return level;
> > > > > > > > > > > > >  }
> > > > > > > > > > > > >
> > > > > > > > > > > > > @@ -106,6 +123,23 @@ intel_dp_aux_set_backlight(c=
onst
> > > > > > > > > > > > > struct drm_connector_state *conn_state, u32 lev
> > > > > > > > > > > > >       struct drm_i915_private *i915 =3D
> > > > > > > > > > > > > dp_to_i915(intel_dp);
> > > > > > > > > > > > >       u8 vals[2] =3D { 0x0 };
> > > > > > > > > > > > >
> > > > > > > > > > > > > +     if (i915->quirks &
> > > > > > > > > > > > > QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS) {
> > > > > > > > > > > > > +             if (!drm_dp_dpcd_readb(&intel_dp->a=
ux,
> > > > > > > > > > > > > DP_EDP_PWMGEN_BIT_COUNT,
> > > > > > > > > > > > > +                                             &va=
ls[0]
> > > > > > > > > > > > > )) {
> > > > > > > > > > > > > +                     DRM_DEBUG_KMS("Failed to wr=
ite
> > > > > > > > > > > > > aux
> > > > > > > > > > > > > backlight level: Failed to read DPCD register 0x%=
x\n",
> > > > > > > > > > > > > +                                       DP_EDP_PW=
MGEN_
> > > > > > > > > > > > > BIT_
> > > > > > > > > > > > > COUNT);
> > > > > > > > > > > > > +                     return;
> > > > > > > > > > > > > +             }
> > > > > > > > > > > > > +             // Only bits 4:0 are used, 7:5 are
> > > > > > > > > > > > > reserved.
> > > > > > > > > > > > > +             vals[0] =3D vals[0] & 0x1F;
> > > > > > > > > > > > > +             if (vals[0] > 16) {
> > > > > > > > > > > > > +                     DRM_DEBUG_KMS("Failed to wr=
ite
> > > > > > > > > > > > > aux
> > > > > > > > > > > > > backlight level: Invalid DP_EDP_PWNGEN_BIT_COUNT =
0x%X,
> > > > > > > > > > > > > expected at most 16\n",
> > > > > > > > > > > > > +                                             val=
s[0])
> > > > > > > > > > > > > ;
> > > > > > > > > > > > > +                     return;
> > > > > > > > > > > > > +             }
> > > > > > > > > > > > > +             level <<=3D (16 - vals[0]) & 0xFFFF=
;
> > > > > > > > > > > > > +     }
> > > > > > > > > > > > > +
> > > > > > > > > > > > >       vals[0] =3D level;
> > > > > > > > > > > > >
> > > > > > > > > > > > >       /* Write the MSB and/or LSB */
> > > > > > > > > > > > > diff --git
> > > > > > > > > > > > > a/drivers/gpu/drm/i915/display/intel_quirks.c
> > > > > > > > > > > > > b/drivers/gpu/drm/i915/display/intel_quirks.c
> > > > > > > > > > > > > index 46beb155d835f..63b27d49b2864 100644
> > > > > > > > > > > > > --- a/drivers/gpu/drm/i915/display/intel_quirks.c
> > > > > > > > > > > > > +++ b/drivers/gpu/drm/i915/display/intel_quirks.c
> > > > > > > > > > > > > @@ -53,6 +53,16 @@ static void
> > > > > > > > > > > > > quirk_increase_ddi_disabled_time(struct
> > > > > > > > > > > > > drm_i915_private
> > > > > > > > > > > > > *i915)
> > > > > > > > > > > > >       drm_info(&i915->drm, "Applying Increase DDI
> > > > > > > > > > > > > Disabled
> > > > > > > > > > > > > quirk\n");
> > > > > > > > > > > > >  }
> > > > > > > > > > > > >
> > > > > > > > > > > > > +/*
> > > > > > > > > > > > > + * Some eDP backlight hardware uses the most-
> > > > > > > > > > > > > significant
> > > > > > > > > > > > > bits of the brightness
> > > > > > > > > > > > > + * register, so brightness values must be shifte=
d
> > > > > > > > > > > > > first.
> > > > > > > > > > > > > + */
> > > > > > > > > > > > > +static void
> > > > > > > > > > > > > quirk_shift_edp_backlight_brightness(struct
> > > > > > > > > > > > > drm_i915_private *i915)
> > > > > > > > > > > > > +{
> > > > > > > > > > > > > +     i915->quirks |=3D
> > > > > > > > > > > > > QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS;
> > > > > > > > > > > > > +     DRM_INFO("Applying shift eDP backlight
> > > > > > > > > > > > > brightness
> > > > > > > > > > > > > quirk\n");
> > > > > > > > > > > > > +}
> > > > > > > > > > > > > +
> > > > > > > > > > > > >  struct intel_quirk {
> > > > > > > > > > > > >       int device;
> > > > > > > > > > > > >       int subsystem_vendor;
> > > > > > > > > > > > > @@ -156,6 +166,9 @@ static struct intel_quirk
> > > > > > > > > > > > > intel_quirks[] =3D {
> > > > > > > > > > > > >       /* ASRock ITX*/
> > > > > > > > > > > > >       { 0x3185, 0x1849, 0x2212,
> > > > > > > > > > > > > quirk_increase_ddi_disabled_time },
> > > > > > > > > > > > >       { 0x3184, 0x1849, 0x2212,
> > > > > > > > > > > > > quirk_increase_ddi_disabled_time },
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +     /* Google Pixelbook */
> > > > > > > > > > > > > +     { 0x591E, 0x8086, 0x2212,
> > > > > > > > > > > > > quirk_shift_edp_backlight_brightness },
> > > > > > > > > > > > >  };
> > > > > > > > > > > > >
> > > > > > > > > > > > >  void intel_init_quirks(struct drm_i915_private *=
i915)
> > > > > > > > > > > > > diff --git a/drivers/gpu/drm/i915/i915_drv.h
> > > > > > > > > > > > > b/drivers/gpu/drm/i915/i915_drv.h
> > > > > > > > > > > > > index e4f7f6518945b..cc93bede4fab8 100644
> > > > > > > > > > > > > --- a/drivers/gpu/drm/i915/i915_drv.h
> > > > > > > > > > > > > +++ b/drivers/gpu/drm/i915/i915_drv.h
> > > > > > > > > > > > > @@ -525,6 +525,7 @@ struct i915_psr {
> > > > > > > > > > > > >  #define QUIRK_PIN_SWIZZLED_PAGES (1<<5)
> > > > > > > > > > > > >  #define QUIRK_INCREASE_T12_DELAY (1<<6)
> > > > > > > > > > > > >  #define QUIRK_INCREASE_DDI_DISABLED_TIME (1<<7)
> > > > > > > > > > > > > +#define QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS (1<=
<8)
> > > > > > > > > > > > >
> > > > > > > > > > > > >  struct intel_fbdev;
> > > > > > > > > > > > >  struct intel_fbc_work;
> > > > > > > > > > > >
> > > > > > > > > > > > --
> > > > > > > > > > > > Jani Nikula, Intel Open Source Graphics Center
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > Ville Syrj=C3=A4l=C3=A4
> > > > > > > > > Intel
> > > > > > > > > _______________________________________________
> > > > > > > > > Intel-gfx mailing list
> > > > > > > > > Intel-gfx@lists.freedesktop.org
> > > > > > > > > https://lists.freedesktop.org/mailman/listinfo/intel-gfx
> > > > > > > >
> > > > > > > > --
> > > > > > > > Ville Syrj=C3=A4l=C3=A4
> > > > > > > > Intel
> > > --
> > > Cheers,
> > >         Lyude Paul (she/her)
> > >         Software Engineer at Red Hat
> > >
> --
> Cheers,
>         Lyude Paul (she/her)
>         Software Engineer at Red Hat
>

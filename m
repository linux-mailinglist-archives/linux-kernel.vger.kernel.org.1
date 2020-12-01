Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EBB2C950F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 03:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgLACLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 21:11:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22385 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726862AbgLACLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 21:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606788615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XPYUombMnqQEmmxc+jyUTzWB2TL/8J8ymhI/NTRuPO0=;
        b=RNDsyUP9hxYGwDjDk1NHLLUH8Arv6aZObJamZWjV0iwqCVNseCzu/aB3XSwJcLmeuv9pcO
        1Mgm72MbTVEAkuG47YfX/f/hcshc/Sq2wGMtAV4TfT0rS3R1KMMreDmUMIXYyq6fav69vy
        g9mhckxMAL3vysOe2/kms5gLEpCtfuc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-MrKyArhiO8aTVf3BM-6fKQ-1; Mon, 30 Nov 2020 21:10:09 -0500
X-MC-Unique: MrKyArhiO8aTVf3BM-6fKQ-1
Received: by mail-qk1-f197.google.com with SMTP id o25so168091qkj.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 18:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=XPYUombMnqQEmmxc+jyUTzWB2TL/8J8ymhI/NTRuPO0=;
        b=KSL7uYr6zujKH0NZD5aERnHXa/ECzneWK4CJmfAw4F8VVKr+CsXwkSlsPxQ52VWItr
         iPKhTxWISfy0YtO4VCRtM0IxzKz/butmb6o+EMyL2FIEEFxwZmJDjulKTEydOVe4jvbl
         kp/pRnhKEFIx8dexxXfOnxWVwJcuksIM7PptKkFXuN/35Rjub0eOMHkbRey/aDf3wfPn
         ozW6iNM+X2KGOdSWcWqk1J1qrq62NdKZrKAbc/3uYO9qbRARAPAwsqyt94wVE68u0+GJ
         kB2OLVJ3m0I+YRUQZScnbruU0iRuieDX5B5a++Jfel9yVzUzHh1GCWyGgZagfXH7haJC
         AmGA==
X-Gm-Message-State: AOAM530xtbELxxysAUnaadT9ws5iOFvEeQHoKi1EDc8cMQ1BUtJxvG9o
        aVcF4mmagCEqctZCI+qTQvoAMhHDIzyXk+4POJzTBoVDHX3ExbRPlCPEMjVNsAljfk2wylhl/G8
        vLTGxeLpGp6osCr0hUEGIEyvC
X-Received: by 2002:ac8:548e:: with SMTP id h14mr523051qtq.326.1606788607518;
        Mon, 30 Nov 2020 18:10:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJydnmSM0Rc6kiEQxTp05Nu/josJ8rsxGS/zqzDwekiSnfNPQj14p4efdq7tNnm247maQH8toA==
X-Received: by 2002:ac8:548e:: with SMTP id h14mr523017qtq.326.1606788607170;
        Mon, 30 Nov 2020 18:10:07 -0800 (PST)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id j13sm484482qtc.81.2020.11.30.18.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 18:10:06 -0800 (PST)
Message-ID: <c376a1ef52782d8e73ad69c38cfaa4951bf907c1.camel@redhat.com>
Subject: Re: [Intel-gfx] [RFC v2 3/8] drm/i915: Keep track of pwm-related
 backlight hooks separately
From:   Lyude Paul <lyude@redhat.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Dave Airlie <airlied@gmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Wambui Karuga <wambui.karugax@gmail.com>
Date:   Mon, 30 Nov 2020 21:10:05 -0500
In-Reply-To: <87o8jkl4a6.fsf@intel.com>
References: <20200916171855.129511-1-lyude@redhat.com>
         <20200916171855.129511-4-lyude@redhat.com>
         <CAPM=9tzLK3caEW661tCeSPhn0G0NihuztCdgyABDgtvZRvV4xA@mail.gmail.com>
         <87o8jkl4a6.fsf@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-11-26 at 13:57 +0200, Jani Nikula wrote:
> On Thu, 26 Nov 2020, Dave Airlie <airlied@gmail.com> wrote:
> > On Thu, 17 Sept 2020 at 03:19, Lyude Paul <lyude@redhat.com> wrote:
> > > 
> > > Currently, every different type of backlight hook that i915 supports is
> > > pretty straight forward - you have a backlight, probably through PWM
> > > (but maybe DPCD), with a single set of platform-specific hooks that are
> > > used for controlling it.
> > > 
> > > HDR backlights, in particular VESA and Intel's HDR backlight
> > > implementations, can end up being more complicated. With Intel's
> > > proprietary interface, HDR backlight controls always run through the
> > > DPCD. When the backlight is in SDR backlight mode however, the driver
> > > may need to bypass the TCON and control the backlight directly through
> > > PWM.
> > > 
> > > So, in order to support this we'll need to split our backlight callbacks
> > > into two groups: a set of high-level backlight control callbacks in
> > > intel_panel, and an additional set of pwm-specific backlight control
> > > callbacks. This also implies a functional changes for how these
> > > callbacks are used:
> > > 
> > > * We now keep track of two separate backlight level ranges, one for the
> > >   high-level backlight, and one for the pwm backlight range
> > > * We also keep track of backlight enablement and PWM backlight
> > >   enablement separately
> > > * Since the currently set backlight level might not be the same as the
> > >   currently programmed PWM backlight level, we stop setting
> > >   panel->backlight.level with the currently programmed PWM backlight
> > >   level in panel->backlight.pwm_funcs.setup(). Instead, we rely
> > >   on the higher level backlight control functions to retrieve the
> > >   current PWM backlight level (in this case, intel_pwm_get_backlight()).
> > >   Note that there are still a few PWM backlight setup callbacks that
> > >   do actually need to retrieve the current PWM backlight level, although
> > >   we no longer save this value in panel->backlight.level like before.
> > > * panel->backlight.pwm_funcs.enable()/disable() both accept a PWM
> > >   brightness level, unlike their siblings
> > >   panel->backlight.enable()/disable(). This is so we can calculate the
> > >   actual PWM brightness level we want to set on disable/enable in the
> > >   higher level backlight enable()/disable() functions, since this value
> > >   might be scaled from a brightness level that doesn't come from PWM.
> > 
> > Oh this patch is a handful, I can see why people stall out here.
> > 
> > I'm going to be annoying maintainer and see if you can clean this up a
> > bit in advance of this patch.
> 
> Agreed. And not looking into and requesting this earlier is on me.
> 
> The thing that still keeps bugging me about the DPCD brightness control
> in general is that it's a historical mistake to put all of this under
> i915. (Again, mea culpa.) The standard DPCD brightness control should
> really be under drm core, in one form or another.

JFYI - I already actually have a WIP series to move all of the VESA standard
brightness stuff into the DRM core (especially since I am adding support for
the VESA interface to nouveau). It is pretty important to do so especially
considering some of the ways panel manufacturers seem to have consistently
gotten some portions of the spec wrong (there's currently a bug on almost
every panel I've run into, minus some panels in laptops that run ChromeOS,
where they interpret the brightness value as LSB aligned and not MSB aligned
(which is what the eDP spec actually says), because almost everyone misread
it. So, definitely the kind of stuff we'd want to keep in the drm core to make
maintaining quirks like this easier.

> 
> I'm not asking to fix that here. But I *am* wondering if the series
> makes that harder. What would it look like if we did have that unicorn
> of a brightness connector property? How would that tie into the hooks we
> have?

Re: making it harder, not really. But either way I'm planning on doing the
work for this anyway :)

> 
> Maybe the answer is that the DPCD backlight functions should just be
> library code in drm core that the drivers could call. In the long run,
> i915 really can't be the only one needing this stuff.
> 
> We haven't implemented the mixed modes of DPCD and eDP PWM pin
> brightness control. But the point is, the library code can't call into
> i915 specific eDP PWM pin control code. The proprietary HDR brightness
> code will still be i915 specific, but does it make sense to have a mixed
> mode there that will be completely different from what a mixed mode with
> the standard VESA DPCD brightness could be?
> 
> I.e. what should be the entry points for the hooks, and who calls what?

I think i915 is actually exactly where we want the hooks for this particular
backlight interface, mostly because amdgpu already had to implement their own
backlight control interface for similar reasons to Intel. From what I've seen,
the interfaces which a panel supports backlight control through tend to be
tightly tied to the hardware those panels usually accompany (at least in the
x86 world, no idea about elsewhere). For example, I've only seen laptops which
have no support/broken support for the VESA backlight interface, but not
Intel's, on hardware which only had an Intel GPU present. Every single laptop
I've tested with a Intel/Nvidia GPU setup (where the Nvidia GPU could drive the
eDP display, no idea what the situation is like elsewhere) seems to support both
interfaces perfectly. So, I don't think we'll ever see any need for this outside
of i915 at least.

Also in specific regards to the pwm control: I'm actually planning on keeping
that out of the DRM core libraries, because some variants of the VESA interface
actually need to be able to call down to PWM driver functions as well. Thus, I
think the only way of coming up with helpers for this that make sense is to only
add helpers for the DPCD related portions of backlight control that are going to
apply to all drivers. So far the only spot where we ask the driver for PWM
related info is during eDP backlight probing, where we can use it to calculate
the number of supported backlight levels, but this is entirely optional for the
driver to support it.

JFYI, here's a WIP of that:

https://gitlab.freedesktop.org/lyudess/linux/-/commit/a4bbe0d5ad980c12eb776e59a1bd522d74d09006

> 
> BR,
> Jani.
> 
> > 
> > 1) move the callbacks out of struct intel_panel.backlight into a separate
> > struct
> > and use const static object tables, having fn ptrs and data co-located
> > in a struct
> > isn't great.
> > 
> > strcut intel_panel_backlight_funcs {
> > 
> > };
> > struct intel_panel {
> >     struct {
> >         struct intel_panel_backlight_funcs *funcs;
> >     };
> > };
> > 
> > type of thing.
> > 
> > I think you could reuse the backlight funcs struct for the pwm stuff
> > as well. (maybe with an assert on hz_to_pwm for the old hooks).
> > 
> > 2) change the apis to pass 0 down in a separate patch, this modifies a
> > bunch of apis to pass in an extra level parameter, do that
> > first in a separate patch that doesn't change anything but hands 0
> > down the chain. Then switch over in another patch.
> > 
> > 3) One comment in passing below.
> > > 
> > > 
> > > -       if (cpu_mode)
> > > -               val = pch_get_backlight(connector);
> > > -       else
> > > -               val = lpt_get_backlight(connector);
> > > -       val = intel_panel_compute_brightness(connector, val);
> > > -       panel->backlight.level = clamp(val, panel->backlight.min,
> > > -                                      panel->backlight.max);
> > > 
> > >         if (cpu_mode) {
> > > +               val = intel_panel_sanitize_pwm_level(connector,
> > > pch_get_backlight(connector));
> > > +
> > >                 drm_dbg_kms(&dev_priv->drm,
> > >                             "CPU backlight register was enabled,
> > > switching to PCH override\n");
> > > 
> > >                 /* Write converted CPU PWM value to PCH override
> > > register */
> > > -               lpt_set_backlight(connector->base.state, panel-
> > > >backlight.level);
> > > +               lpt_set_backlight(connector->base.state, val);
> > >                 intel_de_write(dev_priv, BLC_PWM_PCH_CTL1,
> > >                                pch_ctl1 | BLM_PCH_OVERRIDE_ENABLE);
> > > 
> > The change here confused me since it no longer calls lpt_get_backlight
> > in this path, the commit msg might explain this, but it didn't explain
> > is so I could figure out if that was a mistake or intentional.
> > 
> > Dave.
> > _______________________________________________
> > Intel-gfx mailing list
> > Intel-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/intel-gfx
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


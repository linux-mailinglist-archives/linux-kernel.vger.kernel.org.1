Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39B32C9269
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387791AbgK3XUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:20:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727114AbgK3XUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606778346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=li46zMc89mfoLeOz5v4yxiqqtOji3DIchTYZPR9M9IE=;
        b=II68JylJJbH308P1ybizHzAF5Nsb1KegH4uEaQTvFCY6/1ZnO70HeN3Bp7/kjHnL+O2zGF
        UqS0NeKUXfTVbzvq3t33Bs/2T1CJvadahJA5GF5BZvvwpEWS3//kk0Noyhdp7dh2/G3U0v
        oWO0FcuUJ4uOtPKg1p3Jd+nus/okUmg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-8wZ-jNM2NgaH6-ogAzlESw-1; Mon, 30 Nov 2020 18:19:04 -0500
X-MC-Unique: 8wZ-jNM2NgaH6-ogAzlESw-1
Received: by mail-qv1-f70.google.com with SMTP id bn4so8677792qvb.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=li46zMc89mfoLeOz5v4yxiqqtOji3DIchTYZPR9M9IE=;
        b=mZZ7vUkQQu+KS/LBiH4MbWd8ObxK5XE59Wa3rbGGV0uzC0PqeQ4zrRyIY27VDg5B8t
         HZkLi3JORbV0O5a8C9yFCrkiavZsffh868C8SPCmCkYjU7v6Z+PAcBY+japqONmiwpUY
         NNrUHJONWYvhgOcPaqbW7NEfp2HNzOFEOVEwN2JE5mYZ0BfRam9AetCVauvdP/nswSmS
         6Cyg1A3kC31XEvZUxPKSDv8vQQu/VpDl5Yu86ikjIFdBE4MnspTOMFj/BfHf6tMjNolm
         OtC4XWdvxO4J0WIE9ok/7kJL0r3YllDMpDQwJwW+7SJt+V3N6SRu+vfqq8PDbUT8KwJV
         wOAQ==
X-Gm-Message-State: AOAM5338t+P83svtA8mO8Ferl1ocpFnTO+Pe6Pzc1u5ollSwPJupeTtw
        VKcMya2ZKghJ1dn0MF//JA4QINqyYIg8oG+A09omgVsJmOfWKRh6YYlk+4TJiwf1ZzXv3Eejl97
        c0u8K+95vmM4EaBzAK951Sk0H
X-Received: by 2002:ac8:4884:: with SMTP id i4mr24968494qtq.300.1606778344218;
        Mon, 30 Nov 2020 15:19:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzoxLBQzzYqP8Msgg1a4Q3kgPx/56xTZZXS8WWKqosF6BtSsQWM84rV1f8H29HjoMDjXH4Eeg==
X-Received: by 2002:ac8:4884:: with SMTP id i4mr24968476qtq.300.1606778344011;
        Mon, 30 Nov 2020 15:19:04 -0800 (PST)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id g11sm16404443qkk.72.2020.11.30.15.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 15:19:03 -0800 (PST)
Message-ID: <cb55ab8e5eee5ccece8212fa0576de16cc12dcd5.camel@redhat.com>
Subject: Re: [Intel-gfx] [RFC v2 3/8] drm/i915: Keep track of pwm-related
 backlight hooks separately
From:   Lyude Paul <lyude@redhat.com>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Wambui Karuga <wambui.karugax@gmail.com>
Date:   Mon, 30 Nov 2020 18:19:02 -0500
In-Reply-To: <CAPM=9tzLK3caEW661tCeSPhn0G0NihuztCdgyABDgtvZRvV4xA@mail.gmail.com>
References: <20200916171855.129511-1-lyude@redhat.com>
         <20200916171855.129511-4-lyude@redhat.com>
         <CAPM=9tzLK3caEW661tCeSPhn0G0NihuztCdgyABDgtvZRvV4xA@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-11-26 at 11:03 +1000, Dave Airlie wrote:
> On Thu, 17 Sept 2020 at 03:19, Lyude Paul <lyude@redhat.com> wrote:
> > 
> > Currently, every different type of backlight hook that i915 supports is
> > pretty straight forward - you have a backlight, probably through PWM
> > (but maybe DPCD), with a single set of platform-specific hooks that are
> > used for controlling it.
> > 
> > HDR backlights, in particular VESA and Intel's HDR backlight
> > implementations, can end up being more complicated. With Intel's
> > proprietary interface, HDR backlight controls always run through the
> > DPCD. When the backlight is in SDR backlight mode however, the driver
> > may need to bypass the TCON and control the backlight directly through
> > PWM.
> > 
> > So, in order to support this we'll need to split our backlight callbacks
> > into two groups: a set of high-level backlight control callbacks in
> > intel_panel, and an additional set of pwm-specific backlight control
> > callbacks. This also implies a functional changes for how these
> > callbacks are used:
> > 
> > * We now keep track of two separate backlight level ranges, one for the
> >   high-level backlight, and one for the pwm backlight range
> > * We also keep track of backlight enablement and PWM backlight
> >   enablement separately
> > * Since the currently set backlight level might not be the same as the
> >   currently programmed PWM backlight level, we stop setting
> >   panel->backlight.level with the currently programmed PWM backlight
> >   level in panel->backlight.pwm_funcs.setup(). Instead, we rely
> >   on the higher level backlight control functions to retrieve the
> >   current PWM backlight level (in this case, intel_pwm_get_backlight()).
> >   Note that there are still a few PWM backlight setup callbacks that
> >   do actually need to retrieve the current PWM backlight level, although
> >   we no longer save this value in panel->backlight.level like before.
> > * panel->backlight.pwm_funcs.enable()/disable() both accept a PWM
> >   brightness level, unlike their siblings
> >   panel->backlight.enable()/disable(). This is so we can calculate the
> >   actual PWM brightness level we want to set on disable/enable in the
> >   higher level backlight enable()/disable() functions, since this value
> >   might be scaled from a brightness level that doesn't come from PWM.
> 
> Oh this patch is a handful, I can see why people stall out here.
> 
> I'm going to be annoying maintainer and see if you can clean this up a
> bit in advance
> of this patch.
> 

Not annoying at all :), I was hoping there'd be a good bit of criticism on
this patch series since it's been hard to figure out if I'm even implementing
things in the right way or not (especially because I really don't know what
the HDR side of this is going to look like, although I assume it's probably
going to be pretty hands-off in the kernel).

JFYI too for folks on the list, any suggestions about the HDR side of this are
super appreciated. I'm barely familiar with such things.

> 1) move the callbacks out of struct intel_panel.backlight into a separate
> struct
> and use const static object tables, having fn ptrs and data co-located
> in a struct
> isn't great.
> 
> strcut intel_panel_backlight_funcs {
> 
> };
> struct intel_panel {
>     struct {
>         struct intel_panel_backlight_funcs *funcs;
>     };
> };
> 
> type of thing.
> 
> I think you could reuse the backlight funcs struct for the pwm stuff
> as well. (maybe with an assert on hz_to_pwm for the old hooks).
> 
> 2) change the apis to pass 0 down in a separate patch, this modifies a
> bunch of apis to pass in an extra level parameter, do that
> first in a separate patch that doesn't change anything but hands 0
> down the chain. Then switch over in another patch.
> 
> 3) One comment in passing below.
> > 
> > 
> > -       if (cpu_mode)
> > -               val = pch_get_backlight(connector);
> > -       else
> > -               val = lpt_get_backlight(connector);
> > -       val = intel_panel_compute_brightness(connector, val);
> > -       panel->backlight.level = clamp(val, panel->backlight.min,
> > -                                      panel->backlight.max);
> > 
> >         if (cpu_mode) {
> > +               val = intel_panel_sanitize_pwm_level(connector,
> > pch_get_backlight(connector));
> > +
> >                 drm_dbg_kms(&dev_priv->drm,
> >                             "CPU backlight register was enabled, switching
> > to PCH override\n");
> > 
> >                 /* Write converted CPU PWM value to PCH override register
> > */
> > -               lpt_set_backlight(connector->base.state, panel-
> > >backlight.level);
> > +               lpt_set_backlight(connector->base.state, val);
> >                 intel_de_write(dev_priv, BLC_PWM_PCH_CTL1,
> >                                pch_ctl1 | BLM_PCH_OVERRIDE_ENABLE);
> > 
> The change here confused me since it no longer calls lpt_get_backlight
> in this path, the commit msg might explain this, but it didn't explain
> is so I could figure out if that was a mistake or intentional.

Will address these in the next respin, thanks for the review!

> 
> Dave.
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


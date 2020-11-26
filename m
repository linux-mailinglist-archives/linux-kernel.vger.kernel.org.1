Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9BC2C4C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 02:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbgKZBDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 20:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730333AbgKZBDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 20:03:54 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A8BC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 17:03:52 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id t9so414027edq.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 17:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xrUNecpYGl2ZnAp3rrJ3f1A3dARLvQsZlRdOapjfXw0=;
        b=vMGQxGq7y+sUnfus4NNRlL7mJjO9BypG6eZpEKOX6MCNRDwwh7y5crDpnFTnhHRmOP
         iy1uxKv1PZ5qbXmgEMT5JS6z/cCyMhACpHO5ZsTXWYCjHwj8k1qgv8K4Mkk/V5Xw8O9w
         C5XKeTrxCMEc+x59jwuuO16fxqeOqSBaQnLDf2KY1v/CHzjs5coG53sDnlrWtJ37MxmO
         dyUHl10DpedfN3cyOtD/GN780M2GUveW5IXZsZhXj3rW2n32pmX1Il6WjOF70KBPowEd
         ovsiIq2DYj/RC1EDllVNMUkQ1msXJbvYkqNLmdqFeRrMmcIDBtJLa632zjchBwm388AJ
         ATVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xrUNecpYGl2ZnAp3rrJ3f1A3dARLvQsZlRdOapjfXw0=;
        b=oxbiZcNFR+VHwgiT8Q8sYGmmfLsI3X4A7EJIL4NGpO4g2Kcm2BXjRrdWCY0Sd2dbfO
         oqosgAzMsShenrdUuHMyVDQTXyKQY5v0rpESYwOmVuT9Hgc+dGa4k183jKRL0aVMCJR+
         /4HiIrCm8iCddDBHCKJ2IxEnLRLv8/IBGXGEHHeRwMYXE8Wn41oSPjHCT7VBl+yiVK3I
         ztxg3q1wFY+Fr5rMd2ciowzGzFGIqfNd4JpoPMOFbwcIoyRRyaiDZv9r9IaJt5RCT9L0
         BiZulUpA7R2LKOusqiTwosJW/1WhiyoffftJctsXXRrDzKu97/BeLLPO6Q5a84IASxt/
         SMag==
X-Gm-Message-State: AOAM5320MkFpN6Jl2QxpjQUCbnyl7/qZOSa+WvdF5elW+TquOq3kgQzR
        Ez0xuBGtp/ax9fZtso+r1ov0+EckTZoDBqut8Qk=
X-Google-Smtp-Source: ABdhPJwvoiEFiU5WBVRmpS6yLY1p8hwLYrKdQkByYXpFCjjUpX5zzGilbEr7+ASxTqngdlxEOXFe3x92Yd0obzSArVE=
X-Received: by 2002:a05:6402:1ac4:: with SMTP id ba4mr273237edb.383.1606352630490;
 Wed, 25 Nov 2020 17:03:50 -0800 (PST)
MIME-Version: 1.0
References: <20200916171855.129511-1-lyude@redhat.com> <20200916171855.129511-4-lyude@redhat.com>
In-Reply-To: <20200916171855.129511-4-lyude@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 26 Nov 2020 11:03:39 +1000
Message-ID: <CAPM=9tzLK3caEW661tCeSPhn0G0NihuztCdgyABDgtvZRvV4xA@mail.gmail.com>
Subject: Re: [Intel-gfx] [RFC v2 3/8] drm/i915: Keep track of pwm-related
 backlight hooks separately
To:     Lyude Paul <lyude@redhat.com>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Wambui Karuga <wambui.karugax@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sept 2020 at 03:19, Lyude Paul <lyude@redhat.com> wrote:
>
> Currently, every different type of backlight hook that i915 supports is
> pretty straight forward - you have a backlight, probably through PWM
> (but maybe DPCD), with a single set of platform-specific hooks that are
> used for controlling it.
>
> HDR backlights, in particular VESA and Intel's HDR backlight
> implementations, can end up being more complicated. With Intel's
> proprietary interface, HDR backlight controls always run through the
> DPCD. When the backlight is in SDR backlight mode however, the driver
> may need to bypass the TCON and control the backlight directly through
> PWM.
>
> So, in order to support this we'll need to split our backlight callbacks
> into two groups: a set of high-level backlight control callbacks in
> intel_panel, and an additional set of pwm-specific backlight control
> callbacks. This also implies a functional changes for how these
> callbacks are used:
>
> * We now keep track of two separate backlight level ranges, one for the
>   high-level backlight, and one for the pwm backlight range
> * We also keep track of backlight enablement and PWM backlight
>   enablement separately
> * Since the currently set backlight level might not be the same as the
>   currently programmed PWM backlight level, we stop setting
>   panel->backlight.level with the currently programmed PWM backlight
>   level in panel->backlight.pwm_funcs.setup(). Instead, we rely
>   on the higher level backlight control functions to retrieve the
>   current PWM backlight level (in this case, intel_pwm_get_backlight()).
>   Note that there are still a few PWM backlight setup callbacks that
>   do actually need to retrieve the current PWM backlight level, although
>   we no longer save this value in panel->backlight.level like before.
> * panel->backlight.pwm_funcs.enable()/disable() both accept a PWM
>   brightness level, unlike their siblings
>   panel->backlight.enable()/disable(). This is so we can calculate the
>   actual PWM brightness level we want to set on disable/enable in the
>   higher level backlight enable()/disable() functions, since this value
>   might be scaled from a brightness level that doesn't come from PWM.

Oh this patch is a handful, I can see why people stall out here.

I'm going to be annoying maintainer and see if you can clean this up a
bit in advance
of this patch.

1) move the callbacks out of struct intel_panel.backlight into a separate struct
and use const static object tables, having fn ptrs and data co-located
in a struct
isn't great.

strcut intel_panel_backlight_funcs {

};
struct intel_panel {
    struct {
        struct intel_panel_backlight_funcs *funcs;
    };
};

type of thing.

I think you could reuse the backlight funcs struct for the pwm stuff
as well. (maybe with an assert on hz_to_pwm for the old hooks).

2) change the apis to pass 0 down in a separate patch, this modifies a
bunch of apis to pass in an extra level parameter, do that
first in a separate patch that doesn't change anything but hands 0
down the chain. Then switch over in another patch.

3) One comment in passing below.
>
>
> -       if (cpu_mode)
> -               val = pch_get_backlight(connector);
> -       else
> -               val = lpt_get_backlight(connector);
> -       val = intel_panel_compute_brightness(connector, val);
> -       panel->backlight.level = clamp(val, panel->backlight.min,
> -                                      panel->backlight.max);
>
>         if (cpu_mode) {
> +               val = intel_panel_sanitize_pwm_level(connector, pch_get_backlight(connector));
> +
>                 drm_dbg_kms(&dev_priv->drm,
>                             "CPU backlight register was enabled, switching to PCH override\n");
>
>                 /* Write converted CPU PWM value to PCH override register */
> -               lpt_set_backlight(connector->base.state, panel->backlight.level);
> +               lpt_set_backlight(connector->base.state, val);
>                 intel_de_write(dev_priv, BLC_PWM_PCH_CTL1,
>                                pch_ctl1 | BLM_PCH_OVERRIDE_ENABLE);
>
The change here confused me since it no longer calls lpt_get_backlight
in this path, the commit msg might explain this, but it didn't explain
is so I could figure out if that was a mistake or intentional.

Dave.

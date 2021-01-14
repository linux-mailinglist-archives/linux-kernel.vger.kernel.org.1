Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEE12F6845
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbhANRuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:50:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26440 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726636AbhANRuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610646562;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TtX+ysF9mxhJUL+KHuF0ROOkxy6TbvUay1ZViHUo3dU=;
        b=Xm9AdCaGz7EoIIzAOtLFo1zD0h/RLsl3GlbjbjW8O6Ln0SQvph6KOwXnaotoKLH7zZPhLS
        Gyhg6tQcYFo5jArlpmc1JnCWh9QrRdU5+dQR5+nT0PtxMIyhXKfjugw6SdNKkbJcjtqMdq
        UNmHwO6/+8/AvXZGHhauL2lcvGh8x70=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-EoIDAywdNRq_kfPO8m47Sg-1; Thu, 14 Jan 2021 12:49:18 -0500
X-MC-Unique: EoIDAywdNRq_kfPO8m47Sg-1
Received: by mail-qk1-f199.google.com with SMTP id q7so5379395qki.16
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:49:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=TtX+ysF9mxhJUL+KHuF0ROOkxy6TbvUay1ZViHUo3dU=;
        b=LFJBQQ3ykLjx7TgOhF/0iI7l9bdjBvfZQSFfOnqMnJqaHvlkYkXpv9+hKUdPBSkGb4
         7lPgTj/3dkf/CoWJRbhfgpuLl2qGxJYFm6l0y/EeETWCd/bzRvvb2aK4nCKRvO6yW5f/
         yU5qvbrp4x3Iq9wVl0CTG2bJzYe9hPob0PcKNFA9Js0XeoRenVLgtEU//Rm71jj6rDP4
         fioeiJ3mMmZAXkbPTnZEefdM5ykfLAXOi08Cn8Ns3FLhLnxXv8uqUEdM+ybMZTnMcc4/
         QndbuLMK9gdb0J2CewWk6eXq7Y6Yif6W65yaOD1qSUJ1zgD6Z/B3yCyATQBZtVPJWeXk
         hsgw==
X-Gm-Message-State: AOAM533OZAkHLNve/TDl8greV7ue/SMeAD+LRsqZUclTawpteFSWNvq6
        y0Xx4+kJ0G3atbrwnehlvBg74Ab388Xe4sFmasjqSPsrybjOtZSuMgtW1uQ/jEcVW+JHC5AjHS8
        ZS6Bd2C02pYDMMj+glKkm9s5P
X-Received: by 2002:ac8:7b32:: with SMTP id l18mr8117210qtu.289.1610646558351;
        Thu, 14 Jan 2021 09:49:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsVNOFuAKll7hJcgESJVJTKv4fj1JcwCahdX3vEpg1Cjht7GQVp9EeEaCo26B2AboGnal7qQ==
X-Received: by 2002:ac8:7b32:: with SMTP id l18mr8117179qtu.289.1610646558024;
        Thu, 14 Jan 2021 09:49:18 -0800 (PST)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id u5sm3431430qkb.120.2021.01.14.09.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:49:17 -0800 (PST)
Message-ID: <37d0f105066da31e19fbbd490e8824f58980a42e.camel@redhat.com>
Subject: Re: [PATCH v6 1/4] drm/i915: Keep track of pwm-related backlight
 hooks separately
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Jani Nikula <jani.nikula@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc:     thaytan@noraisin.net, Vasily Khoruzhick <anarsoul@gmail.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ramalingam C <ramalingam.c@intel.com>,
        Anshuman Gupta <anshuman.gupta@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 14 Jan 2021 12:49:15 -0500
In-Reply-To: <871reornzr.fsf@intel.com>
References: <20210113235426.2190684-1-lyude@redhat.com>
         <20210113235426.2190684-2-lyude@redhat.com> <871reornzr.fsf@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-01-14 at 09:12 +0200, Jani Nikula wrote:
> On Wed, 13 Jan 2021, Lyude Paul <lyude@redhat.com> wrote:
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
> >   level in panel->backlight.pwm_funcs->setup(). Instead, we rely
> >   on the higher level backlight control functions to retrieve the
> >   current PWM backlight level (in this case, intel_pwm_get_backlight()).
> >   Note that there are still a few PWM backlight setup callbacks that
> >   do actually need to retrieve the current PWM backlight level, although
> >   we no longer save this value in panel->backlight.level like before.
> > 
> > Additionally, we drop the call to lpt_get_backlight() in
> > lpt_setup_backlight(), and avoid unconditionally writing the PWM value that
> > we get from it and only write it back if we're in CPU mode, and switching
> > to PCH mode. The reason for this is because in the original codepath for
> > this, it was expected that the intel_panel_bl_funcs->setup() hook would be
> > responsible for fetching the initial backlight level. On lpt systems, the
> > only time we could ever be in PCH backlight mode is during the initial
> > driver load - meaning that outside of the setup() hook, lpt_get_backlight()
> > will always be the callback used for retrieving the current backlight
> > level. After this patch we still need to fetch and write-back the PCH
> > backlight value if we're switching from CPU mode to PCH, but because
> > intel_pwm_setup_backlight() will retrieve the backlight level after setup()
> > using the get() hook, which always ends up being lpt_get_backlight(). Thus
> > - an additional call to lpt_get_backlight() in lpt_setup_backlight() is
> > made redundant.
> > 
> > v7:
> > * Use panel->backlight.pwm_funcs->get() to get the backlight level in
> >   intel_pwm_setup_backlight(), lest we upset lockdep
> 
> I think this change is wrong, as it now bypasses
> intel_panel_invert_pwm_level(). Please explain. I don't see anything in
> there that could trigger a lockdep warning.

yeah-this was definitely me misunderstanding what the issue we were hitting here
was.

> 
> Perhaps it's the below you're referring to, but I think the root cause
> is different?
> 
> > @@ -1788,22 +1780,17 @@ static int vlv_setup_backlight(struct
> > intel_connector *connector, enum pipe pipe
> >         panel->backlight.active_low_pwm = ctl2 & BLM_POLARITY_I965;
> >  
> >         ctl = intel_de_read(dev_priv, VLV_BLC_PWM_CTL(pipe));
> > -       panel->backlight.max = ctl >> 16;
> > +       panel->backlight.pwm_level_max = ctl >> 16;
> >  
> > -       if (!panel->backlight.max)
> > -               panel->backlight.max = get_backlight_max_vbt(connector);
> > +       if (!panel->backlight.pwm_level_max)
> > +               panel->backlight.pwm_level_max =
> > get_backlight_max_vbt(connector);
> >  
> > -       if (!panel->backlight.max)
> > +       if (!panel->backlight.pwm_level_max)
> >                 return -ENODEV;
> >  
> > -       panel->backlight.min = get_backlight_min_vbt(connector);
> > +       panel->backlight.pwm_level_min = get_backlight_min_vbt(connector);
> >  
> > -       val = _vlv_get_backlight(dev_priv, pipe);
> 
> Turns out this is a meaningful change, as the higher level
> vlv_get_backlight() function that will be called instead hits:
> 
> <4>[   12.870202] i915 0000:00:02.0: drm_WARN_ON(!drm_modeset_is_locked(&dev-
> >mode_config.connection_mutex))
> 
> in intel_connector_get_pipe(connector).
> 
> It's a real problem. See this, it's obvious (in retrospect):
> 
>  
> https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_19348/fi-bsw-kefka/igt@runner@aborted.html
>  
> https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_19348/fi-bsw-kefka/boot0.txt
> 
> I don't have a quick answer how this could be handled neatly. Perhaps
> the ->get call (or rather, intel_pwm_get_backlight) to set
> panel->backlight.level needs to be spread out to the end of each
> pwm_funcs->setup function after all? Though it's at the wrong
> abstraction level wrt level being a higher level, uh, level.
> 
> I don't think it's enough to just grab connection_mutex around setup
> (and even checking if we can do that is a bunch of digging) - I think
> it's likely intel_connector_get_pipe() returns INVALID_PIPE at that
> point.
> 
> Okay, here's a clumsy suggestion that I think works around this and
> unblocks the series until we figure out a better way:
> 
> 1. At the end of vlv_setup_backlight():
> 
>         /* add fixme comment about how wrong this is */
>         panel->backlight.level = intel_panel_invert_pwm_level(connector,
> _vlv_get_backlight());
>         
> 
> 2. In intel_pwm_setup_backlight() only set level if ->setup didn't:
> 
>         if (!panel->backlight.level)
>                 panel->backlight.level = intel_pwm_get_backlight(connector);
> 
> What do you think?

Hm, I might have a better idea. Why not just adjust struct intel_panel_bl_funcs
so that it accepts an enum pipe, since we're already being passed a pipe in -
>setup(). Then in places where we call ->get() we can just make retrieving the
currently set pipe from the atomic state or somewhere else the responsibility of
the caller. I think I'm going to add an additional patch to give this a shot and
see how it goes.
> 
> BR,
> Jani.
> 
> > -       val = intel_panel_compute_brightness(connector, val);
> > -       panel->backlight.level = clamp(val, panel->backlight.min,
> > -                                      panel->backlight.max);
> > -
> > -       panel->backlight.enabled = ctl2 & BLM_PWM_ENABLE;
> > +       panel->backlight.pwm_enabled = ctl2 & BLM_PWM_ENABLE;
> >  
> >         return 0;
> >  }
> > @@ -1828,24 +1815,18 @@ bxt_setup_backlight(struct intel_connector
> > *connector, enum pipe unused)
> 

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!


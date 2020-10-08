Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4D8287A17
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 18:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbgJHQjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 12:39:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20729 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726766AbgJHQjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 12:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602175174;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gHKD0aQI/7JBaioK/QfMPV93J3kvny7ubmqoofn11rg=;
        b=CTXsZJ4brXiM5FS6278xm7NpdZvLBSBZ/zBagJLJ3X+H+UXJouighUVDmwF/zBFwUPntNs
        5IofaOEhSgQnYsLJ2zUfqA85hMbWxKncv7ZcPJ/TB5O79jm5qs8UzD0zbblitJKJBpbaBJ
        QK68ny1w4F6N9DPU+Wjhu8+JeEcCTQg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-kXgQlSRsPZyRZW8uIu7wuQ-1; Thu, 08 Oct 2020 12:39:33 -0400
X-MC-Unique: kXgQlSRsPZyRZW8uIu7wuQ-1
Received: by mail-qt1-f200.google.com with SMTP id o25so1064317qtt.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 09:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=gHKD0aQI/7JBaioK/QfMPV93J3kvny7ubmqoofn11rg=;
        b=SWFMRN9VwBNKxD1XA2NOWFtVsMVloKONi6GPsGjKwWDn6gOHm1SB7MM8tmIQ2iEOpa
         ffqRxyUIwtwn2kg6h6JCJxzJNcqnseu0oh65tVFKS7HmEQ6Je6uUwaufdq+QrioDBgIu
         dwsdR8Fm8+jyZwpR3ujsjGOvqzEYkDftsWUSSkN0XOOumf498vreAK7Tu0xm2WtgQJ0k
         9ivIXmNgSXhnm806cEJHVaknoFXd9jBCGzv4QQBXPdAksOseGEYhvEenDwx9bItLN2YW
         Ttg5UAd10cz1E5S0x2EqJWxXZddW2zXhT+tULD/wDseOB/RP8vYCHAjSrXZkdwtPzfZB
         zK7A==
X-Gm-Message-State: AOAM533TDyHEpuOrNyae+7OUgIhDwx0wh7fGR5E2zluLy+yB9TjSEUAT
        xkJ45zCOhEHJlYHmif09SfUhLYrn5EGMKGrXuBvhOC6CWEDqCU1wAlbs6ByNgR7BhudGJIJM/v2
        p/cBv7SO6aC4sGSnB4iPGwTwl
X-Received: by 2002:a05:6214:a03:: with SMTP id dw3mr8534284qvb.44.1602175172884;
        Thu, 08 Oct 2020 09:39:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzD/BIqM2qDW5EZsbmKgRQ4QnPZvC3mJ/hmWWb2lDFMa2/m4vcbfXCB2+gIzlq1RNY0B0gDA==
X-Received: by 2002:a05:6214:a03:: with SMTP id dw3mr8534258qvb.44.1602175172573;
        Thu, 08 Oct 2020 09:39:32 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id c1sm4534743qta.86.2020.10.08.09.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 09:39:31 -0700 (PDT)
Message-ID: <c06193df9273fb396bdb40e73aed64197ba3b01d.camel@redhat.com>
Subject: Re: [PATCH 1/2] drm/i915/dpcd_bl: Skip testing control capability
 with force DPCD quirk
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Satadru Pramanik <satadru@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        intel-gfx@lists.freedesktop.org,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 08 Oct 2020 12:39:30 -0400
In-Reply-To: <D18BA369-25A0-4D5E-A171-9EACF7DC950B@canonical.com>
References: <20201007065915.13883-1-kai.heng.feng@canonical.com>
         <268f495fbb7e3042eb613398a8513a83d28d3fd9.camel@redhat.com>
         <D18BA369-25A0-4D5E-A171-9EACF7DC950B@canonical.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-10-08 at 10:32 +0800, Kai-Heng Feng wrote:
> Hi Lyude,
> 
> > On Oct 8, 2020, at 05:53, Lyude Paul <lyude@redhat.com> wrote:
> > 
> > Hi! I thought this patch rang a bell, we actually already had some
> > discussion
> > about this since there's a couple of other systems this was causing issues
> > for.
> > Unfortunately it never seems like that patch got sent out. Satadru?
> > 
> > (if I don't hear back from them soon, I'll just send out a patch for this
> > myself)
> > 
> > JFYI - the proper fix here is to just drop the
> > DP_EDP_BACKLIGHT_BRIGHTNESS_PWM_PIN_CAP check from the code entirely. As
> > long as
> > the backlight supports AUX_SET_CAP, that should be enough for us to control
> > it.
> 
> Does the proper fix include dropping DP_QUIRK_FORCE_DPCD_BACKLIGHT entirely?\

Not yet - we need someone to help with reviewing my Intel HDR backlight
interface patches before we can drop that. I was just talking about dropping the
check where we don't enable the DPCD backlight if it claims to support
DP_EDP_BACKLIGHT_BRIGHTNESS_PWM_PIN_CAP

> 
> Kai-Heng
> 
> > 
> > On Wed, 2020-10-07 at 14:58 +0800, Kai-Heng Feng wrote:
> > > HP DreamColor panel needs to be controlled via AUX interface. However,
> > > it has both DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP and
> > > DP_EDP_BACKLIGHT_BRIGHTNESS_PWM_PIN_CAP set, so it fails to pass
> > > intel_dp_aux_display_control_capable() test.
> > > 
> > > Skip the test if the panel has force DPCD quirk.
> > > 
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > > drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 10 ++++++----
> > > 1 file changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > > b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > > index acbd7eb66cbe..acf2e1c65290 100644
> > > --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > > +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > > @@ -347,9 +347,13 @@ int intel_dp_aux_init_backlight_funcs(struct
> > > intel_connector *intel_connector)
> > > 	struct intel_panel *panel = &intel_connector->panel;
> > > 	struct intel_dp *intel_dp = enc_to_intel_dp(intel_connector->encoder);
> > > 	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
> > > +	bool force_dpcd;
> > > +
> > > +	force_dpcd = drm_dp_has_quirk(&intel_dp->desc, intel_dp->edid_quirks,
> > > +				      DP_QUIRK_FORCE_DPCD_BACKLIGHT);
> > > 
> > > 	if (i915->params.enable_dpcd_backlight == 0 ||
> > > -	    !intel_dp_aux_display_control_capable(intel_connector))
> > > +	    (!force_dpcd &&
> > > !intel_dp_aux_display_control_capable(intel_connector)))
> > > 		return -ENODEV;
> > > 
> > > 	/*
> > > @@ -358,9 +362,7 @@ int intel_dp_aux_init_backlight_funcs(struct
> > > intel_connector *intel_connector)
> > > 	 */
> > > 	if (i915->vbt.backlight.type !=
> > > 	    INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE &&
> > > -	    i915->params.enable_dpcd_backlight != 1 &&
> > > -	    !drm_dp_has_quirk(&intel_dp->desc, intel_dp->edid_quirks,
> > > -			      DP_QUIRK_FORCE_DPCD_BACKLIGHT)) {
> > > +	    i915->params.enable_dpcd_backlight != 1 && !force_dpcd) {
> > > 		drm_info(&i915->drm,
> > > 			 "Panel advertises DPCD backlight support, but "
> > > 			 "VBT disagrees. If your backlight controls "
> > -- 
> > Sincerely,
> >      Lyude Paul (she/her)
> >      Software Engineer at Red Hat
-- 
Sincerely,
      Lyude Paul (she/her)
      Software Engineer at Red Hat


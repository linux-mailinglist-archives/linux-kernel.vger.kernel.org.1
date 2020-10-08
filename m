Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651CA287A94
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 19:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbgJHRHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 13:07:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23576 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731593AbgJHRHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602176822;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rK1iYGxAQ5ciDSQAszI1wUVPzFtoiJoG8sac/Clna0o=;
        b=X2ZO5ffjOAmq12BLTKkp+xuJWVJrZzC30+AosoSwEqwbYr7VXLpH8xxO/LjPENoG8vV2/6
        2Yp1O3Oe6AVz9PnKTG452e0vymr06kjGpJ21gfRDBKhCxPUix7cSworgxY4hn47IX26Dop
        2vAGlHaSyRK/2kKWw4NpHXaIc4Cjt4o=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-96WTLkq5OTSQE0t6aRIO1A-1; Thu, 08 Oct 2020 13:06:59 -0400
X-MC-Unique: 96WTLkq5OTSQE0t6aRIO1A-1
Received: by mail-qv1-f72.google.com with SMTP id ct11so3866899qvb.16
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 10:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=rK1iYGxAQ5ciDSQAszI1wUVPzFtoiJoG8sac/Clna0o=;
        b=VhgigDKS3uBkLhn15YQXKpjqNIyvDPoYWJy7C+sknz62uEpxwaI9QIOfon0f+Gfc6+
         rGM7oMHiTvbn/OvpjG8DMelECtlMfJlVN348kl/GigSbYB5/xWW7hWjmwch1OTz2EYRS
         vgbxdotxWU6crnd3x4GG5PT+QNnAETz7quEVETi/GmgdEGPyQQCCbp/210RO7vIPGIBK
         qa+tP/IvTfr+yxhg62pzeblJy5X2BrmHhQ9+SXayz0YEQN4+Ct4ZXBbo/IfriR+IGtWi
         JAlyii1n+kQAF3XKa1e/7/xUh4uHSM1hFHD/1WO0HjHtZXkNxD3vUk84dHMQL7py30o1
         Mt/A==
X-Gm-Message-State: AOAM5321b4tvK12KgmcEh3VQl79E5lbVgsUbNla8xZAj53+nUPP47pDN
        E6+bMK7Y7WynhLkrpgToqOlyru5dqSt5WZf71sS6dlWhpmNOySHlm8pmO3o6qbORpv5cWdTnYqr
        74KE6Eglmhs91d+VdRuHIYg9a
X-Received: by 2002:ac8:73d0:: with SMTP id v16mr9207123qtp.384.1602176819471;
        Thu, 08 Oct 2020 10:06:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWocfkdhUGtEO7kiKzKyk6jBtDfxMhS6Bm8W9msZo38JHs1faT+EE/7YE2XbW0+jmyeTPl3A==
X-Received: by 2002:ac8:73d0:: with SMTP id v16mr9207108qtp.384.1602176819239;
        Thu, 08 Oct 2020 10:06:59 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id j24sm4342925qkg.107.2020.10.08.10.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 10:06:58 -0700 (PDT)
Message-ID: <27402476cddeef59e9ee05e1cdda430a9e34d29c.camel@redhat.com>
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
Date:   Thu, 08 Oct 2020 13:06:57 -0400
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

oh hold on, I misspoke. Here's the patch I was thinking of:

https://patchwork.freedesktop.org/series/82041/

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
> Does the proper fix include dropping DP_QUIRK_FORCE_DPCD_BACKLIGHT entirely?
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


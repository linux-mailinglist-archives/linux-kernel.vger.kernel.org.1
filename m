Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85612286A89
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 23:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgJGVx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 17:53:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38218 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728649AbgJGVx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 17:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602107605;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BXDLJy3cpaM5bBZA0XOwM+ZPJVSdq/P/kp7oZvNnPnY=;
        b=X5640okfPXJTktdvl2NE0KeCy2nk2DO0qfWioBoW05db4KLD4ub3SSbdVOv9i0ycpx2avS
        3t8NC87NpAI1h2ZlvIcM5UAzsSEcIRDjm3kpz7JtpYmVzk7m+jQi3wcgWqLdUmVnlhoGhy
        E0AOwk+dvptRPwDQ/DgBmU47BygRQaA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-MVfO5Ox2PfCqeN5pD7l17Q-1; Wed, 07 Oct 2020 17:53:23 -0400
X-MC-Unique: MVfO5Ox2PfCqeN5pD7l17Q-1
Received: by mail-qk1-f200.google.com with SMTP id q15so2315154qkq.23
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 14:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=BXDLJy3cpaM5bBZA0XOwM+ZPJVSdq/P/kp7oZvNnPnY=;
        b=B/i7VhrMQ4JBVgvo/lCVzl2CVpQVlz+lNrPWGNnkJbl5fpHJGATcgdZT67lvO53Aht
         cbj7Sz7uRtGgmmw7kyB9tE9dAKOLzty5kgvmuC7UXn6C0FOWmfbLYiGXDiZTB/Y9/asB
         Sf9+5f6LZFt494nuG1vbYn5Z9OTbOKxO0UGqnDu0BZZxluWjvNwYBYAylICEgLTvfUJ8
         z/rDeoeuiwz4YpfWNMf66mGsw5Wln6uzpSDuRSK2v/dF7xpuG//vNR4dLt8oM2uqZAJN
         oTcBGDDR8vxL+y2EjLGXjd4N1vA7eqQkoAUrxELM9uSZcg/5zO6bBo9GkkBeWhZYXIvV
         5Nkg==
X-Gm-Message-State: AOAM5315rCECWVamX8MRITGQyCq08LMvmXix8y46syHVNZsTx4LdHhF+
        cpoRaQJcOlkZYeH1yiG6FGaYwaYYjbKOWPA2eHa9IGirNaUvci+gtnOTCudPwGTUZbVixEJRTrM
        MLrxs0C+Qp1yh70+481Zm32OT
X-Received: by 2002:ac8:2f4f:: with SMTP id k15mr5437820qta.178.1602107603051;
        Wed, 07 Oct 2020 14:53:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztgHq1DT8+0EZ0EAp6o4jDXABu9jdnfkiN69e3Dl5kWLMjxM+WdfGkPc8Onrw+Fq1DP+x8Zg==
X-Received: by 2002:ac8:2f4f:: with SMTP id k15mr5437813qta.178.1602107602829;
        Wed, 07 Oct 2020 14:53:22 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id g1sm2485892qtp.74.2020.10.07.14.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 14:53:22 -0700 (PDT)
Message-ID: <268f495fbb7e3042eb613398a8513a83d28d3fd9.camel@redhat.com>
Subject: Re: [PATCH 1/2] drm/i915/dpcd_bl: Skip testing control capability
 with force DPCD quirk
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Satadru Pramanik <satadru@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
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
Date:   Wed, 07 Oct 2020 17:53:21 -0400
In-Reply-To: <20201007065915.13883-1-kai.heng.feng@canonical.com>
References: <20201007065915.13883-1-kai.heng.feng@canonical.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! I thought this patch rang a bell, we actually already had some discussion
about this since there's a couple of other systems this was causing issues for.
Unfortunately it never seems like that patch got sent out. Satadru?

(if I don't hear back from them soon, I'll just send out a patch for this
myself)

JFYI - the proper fix here is to just drop the
DP_EDP_BACKLIGHT_BRIGHTNESS_PWM_PIN_CAP check from the code entirely. As long as
the backlight supports AUX_SET_CAP, that should be enough for us to control it.


On Wed, 2020-10-07 at 14:58 +0800, Kai-Heng Feng wrote:
> HP DreamColor panel needs to be controlled via AUX interface. However,
> it has both DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP and
> DP_EDP_BACKLIGHT_BRIGHTNESS_PWM_PIN_CAP set, so it fails to pass
> intel_dp_aux_display_control_capable() test.
> 
> Skip the test if the panel has force DPCD quirk.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> index acbd7eb66cbe..acf2e1c65290 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> @@ -347,9 +347,13 @@ int intel_dp_aux_init_backlight_funcs(struct
> intel_connector *intel_connector)
>  	struct intel_panel *panel = &intel_connector->panel;
>  	struct intel_dp *intel_dp = enc_to_intel_dp(intel_connector->encoder);
>  	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
> +	bool force_dpcd;
> +
> +	force_dpcd = drm_dp_has_quirk(&intel_dp->desc, intel_dp->edid_quirks,
> +				      DP_QUIRK_FORCE_DPCD_BACKLIGHT);
>  
>  	if (i915->params.enable_dpcd_backlight == 0 ||
> -	    !intel_dp_aux_display_control_capable(intel_connector))
> +	    (!force_dpcd &&
> !intel_dp_aux_display_control_capable(intel_connector)))
>  		return -ENODEV;
>  
>  	/*
> @@ -358,9 +362,7 @@ int intel_dp_aux_init_backlight_funcs(struct
> intel_connector *intel_connector)
>  	 */
>  	if (i915->vbt.backlight.type !=
>  	    INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE &&
> -	    i915->params.enable_dpcd_backlight != 1 &&
> -	    !drm_dp_has_quirk(&intel_dp->desc, intel_dp->edid_quirks,
> -			      DP_QUIRK_FORCE_DPCD_BACKLIGHT)) {
> +	    i915->params.enable_dpcd_backlight != 1 && !force_dpcd) {
>  		drm_info(&i915->drm,
>  			 "Panel advertises DPCD backlight support, but "
>  			 "VBT disagrees. If your backlight controls "
-- 
Sincerely,
      Lyude Paul (she/her)
      Software Engineer at Red Hat


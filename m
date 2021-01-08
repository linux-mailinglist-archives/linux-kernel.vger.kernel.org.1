Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A419C2EF47D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbhAHPGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:06:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:51806 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbhAHPGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:06:06 -0500
IronPort-SDR: pN1I6WAH9H8ZNi8UpDU33Vdd3zN2WkCj/nSdmMiGz8mnNz0qgjLmuaXEmRI8GqA27k4bC3+ArN
 ejf0fncENA7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="196175257"
X-IronPort-AV: E=Sophos;i="5.79,331,1602572400"; 
   d="scan'208";a="196175257"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 07:05:25 -0800
IronPort-SDR: FBGvmLPT5HSVhtytI3cq7+A5YKhYUjPW1QrEXXZd6v7ffAr9zUF8C6P3SKZ9mV8aAMq6BIp56C
 U8VUwjYChQOg==
X-IronPort-AV: E=Sophos;i="5.79,331,1602572400"; 
   d="scan'208";a="380147241"
Received: from rgwhiteh-mobl.ger.corp.intel.com (HELO localhost) ([10.213.205.160])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 07:05:18 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org
Cc:     thaytan@noraisin.net, Vasily Khoruzhick <anarsoul@gmail.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Sean Paul <seanpaul@chromium.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list\:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/4] drm/i915: Keep track of pwm-related backlight hooks separately
In-Reply-To: <20210107225207.28091-2-lyude@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210107225207.28091-1-lyude@redhat.com> <20210107225207.28091-2-lyude@redhat.com>
Date:   Fri, 08 Jan 2021 17:05:16 +0200
Message-ID: <87r1mvxydv.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Jan 2021, Lyude Paul <lyude@redhat.com> wrote:
> @@ -1628,37 +1633,32 @@ static int lpt_setup_backlight(struct intel_connector *connector, enum pipe unus
>  	panel->backlight.active_low_pwm = pch_ctl1 & BLM_PCH_POLARITY;
>  
>  	pch_ctl2 = intel_de_read(dev_priv, BLC_PWM_PCH_CTL2);
> -	panel->backlight.max = pch_ctl2 >> 16;
> +	panel->backlight.pwm_level_max = pch_ctl2 >> 16;
>  
>  	cpu_ctl2 = intel_de_read(dev_priv, BLC_PWM_CPU_CTL2);
>  
> -	if (!panel->backlight.max)
> -		panel->backlight.max = get_backlight_max_vbt(connector);
> +	if (!panel->backlight.pwm_level_max)
> +		panel->backlight.pwm_level_max = get_backlight_max_vbt(connector);
>  
> -	if (!panel->backlight.max)
> +	if (!panel->backlight.pwm_level_max)
>  		return -ENODEV;
>  
> -	panel->backlight.min = get_backlight_min_vbt(connector);
> +	panel->backlight.pwm_level_min = get_backlight_min_vbt(connector);
>  
> -	panel->backlight.enabled = pch_ctl1 & BLM_PCH_PWM_ENABLE;
> +	panel->backlight.pwm_enabled = pch_ctl1 & BLM_PCH_PWM_ENABLE;
>  
> -	cpu_mode = panel->backlight.enabled && HAS_PCH_LPT(dev_priv) &&
> +	cpu_mode = panel->backlight.pwm_enabled && HAS_PCH_LPT(dev_priv) &&
>  		   !(pch_ctl1 & BLM_PCH_OVERRIDE_ENABLE) &&
>  		   (cpu_ctl2 & BLM_PWM_ENABLE);
> -	if (cpu_mode)
> -		val = pch_get_backlight(connector);
> -	else
> -		val = lpt_get_backlight(connector);
> -	val = intel_panel_compute_brightness(connector, val);
> -	panel->backlight.level = clamp(val, panel->backlight.min,
> -				       panel->backlight.max);
>  
>  	if (cpu_mode) {
> +		val = intel_panel_sanitize_pwm_level(connector, pch_get_backlight(connector));
> +

(This really is a PITA to review, not because of how you do it but
because of the hardware and the code itself. I'm just pointing out one
thing here, but I'm not finished yet.)

I think this sanitize call is wrong here. It should be called only when
converting to and from the hw register. Here, we read directly from one
hw register and write back to another hw register.

Now, looking at the history, I think it's been wrong all the way since
commit 5b1ec9ac7ab5 ("drm/i915/backlight: Fix backlight takeover on LPT,
v3."). Probably nobody noticed, because AFAIK inverted brightness
control has only ever been an issue on some gen4 platforms...

*facepalm*

BR,
Jani.

>  		drm_dbg_kms(&dev_priv->drm,
>  			    "CPU backlight register was enabled, switching to PCH override\n");
>  
>  		/* Write converted CPU PWM value to PCH override register */
> -		lpt_set_backlight(connector->base.state, panel->backlight.level);
> +		lpt_set_backlight(connector->base.state, val);
>  		intel_de_write(dev_priv, BLC_PWM_PCH_CTL1,
>  			       pch_ctl1 | BLM_PCH_OVERRIDE_ENABLE);
>  

-- 
Jani Nikula, Intel Open Source Graphics Center

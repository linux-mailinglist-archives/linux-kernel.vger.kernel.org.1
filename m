Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4BE288FF6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 19:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbgJIR1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 13:27:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34352 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732937AbgJIR0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 13:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602264395;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y6ikGGK6aHMQWPhD82bP38Tw8B11lHIqI5A5jkizye8=;
        b=M6BxPl7dJ38A3so/hfs2SfcCFIqcJM+bor1AQuA76Btpbs9NauYIcApaFIAPrjXMtZnfFQ
        nq3aQ38hXHFFlSos2yDjDniqwYL3sFy25VT5snwguVAdT6rF5Ff+dQ/kMEYKLFXeDgv3Ou
        3H+NeHzF8fJV0fAhHceU9LCEvM9E660=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-EW4XLOm2P0un1Ab8Kjm10Q-1; Fri, 09 Oct 2020 13:26:33 -0400
X-MC-Unique: EW4XLOm2P0un1Ab8Kjm10Q-1
Received: by mail-qk1-f199.google.com with SMTP id m186so7265552qkf.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 10:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=Y6ikGGK6aHMQWPhD82bP38Tw8B11lHIqI5A5jkizye8=;
        b=d5z2f4k/8nwaVqTNARH/ojOSWRTq7owRQEI/AGrwrzIvkdcYO+nCBaJqpx166o9SpU
         fOiHB9R9ms8FPa8kH1DSoXyvhiT8YP+HSvQWNzXReNX9RrKn2RYpIDAODw5dRSCSkhsd
         2M/8+O4BcCcjYas2YcQfP7EjaCRa4TybIKjIubKO7rbRviFYrpEXoE43lTT4sVSnlob5
         WPH8/VxJ8UEm4SbozokeimmUxd4xYMpVSkkS/znv2oW6iXLf8oW2GjpzpQVW6VWQjSjm
         on+KoG7Egep+UH96hGhudoc3W6qO9YET5u/xfJVJXxDe7UM0W9z3h9p0WzOAfr0tsuix
         Wumw==
X-Gm-Message-State: AOAM532CVeYIfxtnoS0L+P8NnVIUdzdDOLAgv0Ax/GVfJi6yWvlUUjVN
        A996LDDu+m/HK9GfXyzwx602g46F/IDNNLIykjzyKIKkB1jUBYc7R4XKg/ufY4k2XsAKLw62mV9
        JVmfJ64QdRycGLTctS3GsyOBw
X-Received: by 2002:a05:620a:1185:: with SMTP id b5mr14323722qkk.386.1602264393195;
        Fri, 09 Oct 2020 10:26:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp/SIm+I2tHWObGoz+HG1lGQmMTfmJLrFa/PeGFE7GwdStIYKbBNERYwy5v5frpjQ2xEoNwQ==
X-Received: by 2002:a05:620a:1185:: with SMTP id b5mr14323708qkk.386.1602264392973;
        Fri, 09 Oct 2020 10:26:32 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id m18sm6767237qkg.77.2020.10.09.10.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 10:26:32 -0700 (PDT)
Message-ID: <983f12944c0f14a7eee7d77bac98203a5c18981c.camel@redhat.com>
Subject: (Cc: drm-misc/intel maintainers) Re: [PATCH 1/2] drm/i915/dpcd_bl:
 uncheck PWM_PIN_CAP when detect eDP backlight capabilities
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Aaron Ma <aaron.ma@canonical.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        mapengyu@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        tzimmermann@suse.de, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, rodrigo.vivi@intel.com,
        joonas.lahtinen@linux.intel.com, jani.nikula@linux.intel.com,
        ville.syrjala@linux.intel.com
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Date:   Fri, 09 Oct 2020 13:26:31 -0400
In-Reply-To: <20201009085750.88490-1-aaron.ma@canonical.com>
References: <20201009085750.88490-1-aaron.ma@canonical.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the whole series:

For the whole series:

Reviewed-by: Lyude Paul <lyude@redhat.com>

I'm going to add a Cc for stable so that it can be backported, and I'll push it
to drm-intel-next-queued once I get the OK from drm-misc/i915 folks

On Fri, 2020-10-09 at 16:57 +0800, Aaron Ma wrote:
> BOE panel with ID 2270 claims both PWM_PIN_CAP and AUX_SET_CAP backlight
> control bits, but default chip backlight failed to control brightness.
> 
> Check AUX_SET_CAP and proceed to check quirks or VBT backlight type.
> DPCD can control the brightness of this pannel.
> 
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> index acbd7eb66cbe..308b14159b7c 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> @@ -334,8 +334,7 @@ intel_dp_aux_display_control_capable(struct
> intel_connector *connector)
>  	 * the panel can support backlight control over the aux channel
>  	 */
>  	if (intel_dp->edp_dpcd[1] & DP_EDP_TCON_BACKLIGHT_ADJUSTMENT_CAP &&
> -	    (intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP) &&
> -	    !(intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_PWM_PIN_CAP))
> {
> +	    (intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP)) {
>  		drm_dbg_kms(&i915->drm, "AUX Backlight Control Supported!\n");
>  		return true;
>  	}
-- 
Sincerely,
      Lyude Paul (she/her)
      Software Engineer at Red Hat


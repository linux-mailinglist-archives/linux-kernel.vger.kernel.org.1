Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A88728C54F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 01:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbgJLXjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 19:39:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726780AbgJLXjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 19:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602545956;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rW0rq42E0Ia7pA/3O1pSHV86DfoT5jFkZR8FD7wpIhQ=;
        b=FjhfLqUU90o5Z5jPNA+2M0yrTeLW6/utZC6+EbmFxusn2VMGXqCEYyCMv68VjXFtAKEE7t
        DJ8rTYFAzNJnLtADKuGDyZHUX2zCx4Cyp77Xbq4dD7fbqOcB3ig7845sP7oqI+x3GBJdUK
        9Drdu6I1UN4qZ3t2u7mxaNfUlEP9AFc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-NeAfapKNPXi-Rdu4nZmhcw-1; Mon, 12 Oct 2020 19:39:14 -0400
X-MC-Unique: NeAfapKNPXi-Rdu4nZmhcw-1
Received: by mail-qv1-f72.google.com with SMTP id y45so11727685qve.15
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 16:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=rW0rq42E0Ia7pA/3O1pSHV86DfoT5jFkZR8FD7wpIhQ=;
        b=bXIAdFcGzQkVM0mo7ExINkt6RSxALKb6KspiQoyWap5Ong32ZFWF/aA7JHLMR2AgJl
         Ye1TZXp0KKNDaHybdl5c7+fVM0tL3uqdk/SDmm+AdqYmqwLozT7yFwsx6rpUmpkg071F
         xzx2pFTZLNYMog12WIFs24DCGXQB8OiEPWXhKIRhaIovFb2ODphV4d2Q//LWdNHmGqe4
         NirSRTCc/CHGwsx1oQuFd3aRbN1z7V/SYUnAtzXevtzm15/06pDEQRw8bjx1RZzEQEpx
         9cIsccNoc4AD6P27Q5rdJQoWn8TpSgXdIYbLNHLimWEJz3UYbALetIvJQI6dpIxGT4YF
         SNHA==
X-Gm-Message-State: AOAM5330VGvAeLPhBH9tqfFVPECbir5na0xb/gwSf+0/Wd9BadPJXPam
        tjRzN7QgrSCoLO4jYDqbneTWfE9CHC0LDXAgVbrBzg18FZP97g9eXGaL/QxYnoc6o09GphiTto1
        /UcAXT0BBI6aWa9lH+MYcPM57
X-Received: by 2002:a05:620a:4:: with SMTP id j4mr8855254qki.164.1602545954411;
        Mon, 12 Oct 2020 16:39:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPc5P35iA6gXgoVAJSgh/p8EZmd1mF8MJWKHd6dMdvNW16yF9VfLRK/jtKJ+he966MNK0pKA==
X-Received: by 2002:a05:620a:4:: with SMTP id j4mr8855235qki.164.1602545954156;
        Mon, 12 Oct 2020 16:39:14 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id g5sm13323920qtx.43.2020.10.12.16.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 16:39:13 -0700 (PDT)
Message-ID: <3a89934f69387ddf654745e2c78bbb8362bbc4b4.camel@redhat.com>
Subject: Re: [PATCH 1/2] drm/i915/dpcd_bl: uncheck PWM_PIN_CAP when detect
 eDP backlight capabilities
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Aaron Ma <aaron.ma@canonical.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        mapengyu@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        tzimmermann@suse.de, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, rodrigo.vivi@intel.com,
        joonas.lahtinen@linux.intel.com, jani.nikula@linux.intel.com,
        ville.syrjala@linux.intel.com
Date:   Mon, 12 Oct 2020 19:39:11 -0400
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

Completely zoned out on Ccing these patches to stable before submitting them,
but once they hit the mainline kernel you should be able to ask Greg to backport
them if you need. Anyway, pushed to drm-intel-next-queued. Thanks for the
patches!

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

Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!


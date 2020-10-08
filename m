Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEBD286CC9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 04:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgJHCcS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Oct 2020 22:32:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40552 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgJHCcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 22:32:18 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kQLj5-0005Y8-BS
        for linux-kernel@vger.kernel.org; Thu, 08 Oct 2020 02:32:15 +0000
Received: by mail-pf1-f197.google.com with SMTP id x24so2663141pfi.18
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 19:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WaLLCnozNIzQ1r5C2Z6XspFXu6ao9ONVd8SifGFTtSg=;
        b=gmt21l1YALyz3gZppF9b9sd0BMRm+2tNOENVKzipjh+hwENf4qn0R6aGb4o9SA/UVa
         fxabV9gccrO1Vpbm6TtB8X5I9v3kKGp+Gmoi4/7msGJqsEU0YtPna2r+wkRFUVYEJF+J
         RPNgKNaFSzhNNeNx5dFgEZkyWJRkXhCqyhnHbE8ebtSdo/T+pUIGSi4w/h39XJS/EhfA
         xOZx+RakxKh/1x6f1bRnoyC+CR29SMpAfQL1EY935Js8dzJMYoOQKOPbp2rDEXpExHPP
         303B/6K/Aho+euUZoYQ93iT8pDv+Cg5gXBTcQ6sUSBsO3MMfYKm0a++xESC8zUfSsIF+
         584Q==
X-Gm-Message-State: AOAM5339MyaDRSSkzoo24riRuUeW3w/+cN+kDLRl59a3jcZLBWvoAlP5
        E7OKx8oh1AzDHU2t8gl4ePasoRd/W81/SDRJAVeqinlfwFM8/UyGuqBcrN7YJ2xvUGAVrxRrqAK
        mooJHQJVsfaGgLO0Ma1uATls0qc89p7llw11qJW9y2Q==
X-Received: by 2002:a62:88c6:0:b029:151:fa4e:a52f with SMTP id l189-20020a6288c60000b0290151fa4ea52fmr5414619pfd.50.1602124333942;
        Wed, 07 Oct 2020 19:32:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYaxP6TzYQgm3m3RC+U8ZDTOxm794OVOfBCgv9EDu2B4QeFW53oN7cuwhhfGetD2Fa7vBHpw==
X-Received: by 2002:a62:88c6:0:b029:151:fa4e:a52f with SMTP id l189-20020a6288c60000b0290151fa4ea52fmr5414605pfd.50.1602124333596;
        Wed, 07 Oct 2020 19:32:13 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id b16sm4829172pfp.195.2020.10.07.19.32.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2020 19:32:12 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 1/2] drm/i915/dpcd_bl: Skip testing control capability
 with force DPCD quirk
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <268f495fbb7e3042eb613398a8513a83d28d3fd9.camel@redhat.com>
Date:   Thu, 8 Oct 2020 10:32:09 +0800
Cc:     Satadru Pramanik <satadru@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        intel-gfx@lists.freedesktop.org,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <D18BA369-25A0-4D5E-A171-9EACF7DC950B@canonical.com>
References: <20201007065915.13883-1-kai.heng.feng@canonical.com>
 <268f495fbb7e3042eb613398a8513a83d28d3fd9.camel@redhat.com>
To:     lyude@redhat.com
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lyude,

> On Oct 8, 2020, at 05:53, Lyude Paul <lyude@redhat.com> wrote:
> 
> Hi! I thought this patch rang a bell, we actually already had some discussion
> about this since there's a couple of other systems this was causing issues for.
> Unfortunately it never seems like that patch got sent out. Satadru?
> 
> (if I don't hear back from them soon, I'll just send out a patch for this
> myself)
> 
> JFYI - the proper fix here is to just drop the
> DP_EDP_BACKLIGHT_BRIGHTNESS_PWM_PIN_CAP check from the code entirely. As long as
> the backlight supports AUX_SET_CAP, that should be enough for us to control it.

Does the proper fix include dropping DP_QUIRK_FORCE_DPCD_BACKLIGHT entirely?

Kai-Heng

> 
> 
> On Wed, 2020-10-07 at 14:58 +0800, Kai-Heng Feng wrote:
>> HP DreamColor panel needs to be controlled via AUX interface. However,
>> it has both DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP and
>> DP_EDP_BACKLIGHT_BRIGHTNESS_PWM_PIN_CAP set, so it fails to pass
>> intel_dp_aux_display_control_capable() test.
>> 
>> Skip the test if the panel has force DPCD quirk.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 10 ++++++----
>> 1 file changed, 6 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
>> b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
>> index acbd7eb66cbe..acf2e1c65290 100644
>> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
>> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
>> @@ -347,9 +347,13 @@ int intel_dp_aux_init_backlight_funcs(struct
>> intel_connector *intel_connector)
>> 	struct intel_panel *panel = &intel_connector->panel;
>> 	struct intel_dp *intel_dp = enc_to_intel_dp(intel_connector->encoder);
>> 	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
>> +	bool force_dpcd;
>> +
>> +	force_dpcd = drm_dp_has_quirk(&intel_dp->desc, intel_dp->edid_quirks,
>> +				      DP_QUIRK_FORCE_DPCD_BACKLIGHT);
>> 
>> 	if (i915->params.enable_dpcd_backlight == 0 ||
>> -	    !intel_dp_aux_display_control_capable(intel_connector))
>> +	    (!force_dpcd &&
>> !intel_dp_aux_display_control_capable(intel_connector)))
>> 		return -ENODEV;
>> 
>> 	/*
>> @@ -358,9 +362,7 @@ int intel_dp_aux_init_backlight_funcs(struct
>> intel_connector *intel_connector)
>> 	 */
>> 	if (i915->vbt.backlight.type !=
>> 	    INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE &&
>> -	    i915->params.enable_dpcd_backlight != 1 &&
>> -	    !drm_dp_has_quirk(&intel_dp->desc, intel_dp->edid_quirks,
>> -			      DP_QUIRK_FORCE_DPCD_BACKLIGHT)) {
>> +	    i915->params.enable_dpcd_backlight != 1 && !force_dpcd) {
>> 		drm_info(&i915->drm,
>> 			 "Panel advertises DPCD backlight support, but "
>> 			 "VBT disagrees. If your backlight controls "
> -- 
> Sincerely,
>      Lyude Paul (she/her)
>      Software Engineer at Red Hat


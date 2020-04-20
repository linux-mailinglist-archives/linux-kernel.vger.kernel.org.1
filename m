Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA361B0695
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 12:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgDTK2x convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Apr 2020 06:28:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:16088 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgDTK2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 06:28:53 -0400
IronPort-SDR: CENwxbK1p15MvzzwW5dGlkvuJbjZ00UQ6Usu0qap1q1hDSY1AV60SHo647FSwCPYUPEnDiNhpM
 9MirdJQQAY2Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 03:28:53 -0700
IronPort-SDR: nBw9rc0cJTSj1Prd6W+PnY6lodt0rR2nfxouUPx6OV+8KPmiFVeHwvzUZutezUrxz5yGCZ9ICH
 +B7+OdhoT1zQ==
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="429073035"
Received: from iastakh-mobl.ccr.corp.intel.com (HELO localhost) ([10.252.63.229])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 03:28:49 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org
Cc:     Adam Jackson <ajax@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/dpcd_bl: Unbreak enable_dpcd_backlight modparam
In-Reply-To: <20200413214407.1851002-1-lyude@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200413214407.1851002-1-lyude@redhat.com>
Date:   Mon, 20 Apr 2020 13:28:46 +0300
Message-ID: <87sggy1me9.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Apr 2020, Lyude Paul <lyude@redhat.com> wrote:
> Looks like I accidentally made it so you couldn't force DPCD backlight
> support on, whoops. Fix that.

Thanks, pushed.

BR,
Jani.



>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 17f5d57915be ("drm/i915: Force DPCD backlight mode on X1 Extreme 2nd Gen 4K AMOLED panel")
> Cc: Adam Jackson <ajax@redhat.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: "Ville Syrjälä" <ville.syrjala@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> index 4b916468540f..0722540d64ad 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> @@ -358,6 +358,7 @@ int intel_dp_aux_init_backlight_funcs(struct intel_connector *intel_connector)
>  	 */
>  	if (i915->vbt.backlight.type !=
>  	    INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE &&
> +	    i915_modparams.enable_dpcd_backlight != 1 &&
>  	    !drm_dp_has_quirk(&intel_dp->desc, intel_dp->edid_quirks,
>  			      DP_QUIRK_FORCE_DPCD_BACKLIGHT)) {
>  		drm_info(&i915->drm,

-- 
Jani Nikula, Intel Open Source Graphics Center

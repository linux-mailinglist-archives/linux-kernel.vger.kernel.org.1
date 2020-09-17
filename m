Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1593926E29F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 19:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgIQRjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 13:39:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:14043 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgIQRfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:35:31 -0400
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 13:35:31 EDT
IronPort-SDR: 0b9JM4YyfVwzrvrX4O5ndOnMwOwOe4QusUASg0pWOlc3rhHfFsoXMhs39cxXJenWkojG3vhQWQ
 XfHKIuTFkaNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="157150411"
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="157150411"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 10:26:39 -0700
IronPort-SDR: G514JGVLOK+sUhI/C3txGDde3ZmT+wYLMiC+9qApFr442GdBdM/NFdMhk+U6+rJI3GFEE8NQ6y
 4S4EH+LbIKMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="344432425"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 17 Sep 2020 10:26:35 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 17 Sep 2020 20:26:34 +0300
Date:   Thu, 17 Sep 2020 20:26:34 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Kevin Chowski <chowski@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Lyude Paul <lyude@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] i915: Introduce quirk for shifting eDP brightness.
Message-ID: <20200917172634.GB6112@intel.com>
References: <20200917110838.1.I63d52f5b96d7e81e1e2dc2a72c4bf5fd84d3d3d0@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200917110838.1.I63d52f5b96d7e81e1e2dc2a72c4bf5fd84d3d3d0@changeid>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:09:06AM -0600, Kevin Chowski wrote:
> We have observed that Google Pixelbook's backlight hardware is
> interpretting these backlight bits from the most-significant side of the
> 16 bit word (if DP_EDP_PWMGEN_BIT_COUNT < 16), whereas the driver code
> assumes the peripheral cares about the least-significant bits.

The spec seems to agree with the msb interpretation. So looks like
the current code is just broken?

> 
> Testing was done from within Chrome OS's build environment when the
> patch is backported to 5.4 (the version we are newly targeting for the
> Pixelbook); for the record:
>    $ emerge-eve-kernelnext sys-kernel/chromeos-kernel-5_4 && \
>       ./update_kernel.sh --remote=$IP
> 
> I used `/sys/kernel/debug/dri/0/eDP-1/i915_dpcd` on my laptop to verify
> that the registers were being set according to what the actual hardware
> expects; I also observe that the backlight is noticeably brighter with
> this patch.
> 
> Signed-off-by: Kevin Chowski <chowski@chromium.org>
> ---
> 
>  .../drm/i915/display/intel_dp_aux_backlight.c | 34 +++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_quirks.c   | 13 +++++++
>  drivers/gpu/drm/i915/i915_drv.h               |  1 +
>  3 files changed, 48 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> index acbd7eb66cbe3..99c98f217356d 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> @@ -91,6 +91,23 @@ static u32 intel_dp_aux_get_backlight(struct intel_connector *connector)
>  	if (intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_BYTE_COUNT)
>  		level = (read_val[0] << 8 | read_val[1]);
>  
> +	if (i915->quirks & QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS) {
> +		if (!drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_PWMGEN_BIT_COUNT,
> +						&read_val[0])) {
> +			DRM_DEBUG_KMS("Failed to read DPCD register 0x%x\n",
> +					DP_EDP_PWMGEN_BIT_COUNT);
> +			return 0;
> +		}
> +		// Only bits 4:0 are used, 7:5 are reserved.
> +		read_val[0] = read_val[0] & 0x1F;
> +		if (read_val[0] > 16) {
> +			DRM_DEBUG_KMS("Invalid DP_EDP_PWNGEN_BIT_COUNT 0x%X, expected at most 16\n",
> +						read_val[0]);
> +			return 0;
> +		}
> +		level >>= 16 - read_val[0];
> +	}
> +
>  	return level;
>  }
>  
> @@ -106,6 +123,23 @@ intel_dp_aux_set_backlight(const struct drm_connector_state *conn_state, u32 lev
>  	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
>  	u8 vals[2] = { 0x0 };
>  
> +	if (i915->quirks & QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS) {
> +		if (!drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_PWMGEN_BIT_COUNT,
> +						&vals[0])) {
> +			DRM_DEBUG_KMS("Failed to write aux backlight level: Failed to read DPCD register 0x%x\n",
> +					  DP_EDP_PWMGEN_BIT_COUNT);
> +			return;
> +		}
> +		// Only bits 4:0 are used, 7:5 are reserved.
> +		vals[0] = vals[0] & 0x1F;
> +		if (vals[0] > 16) {
> +			DRM_DEBUG_KMS("Failed to write aux backlight level: Invalid DP_EDP_PWNGEN_BIT_COUNT 0x%X, expected at most 16\n",
> +						vals[0]);
> +			return;
> +		}
> +		level <<= (16 - vals[0]) & 0xFFFF;
> +	}
> +
>  	vals[0] = level;
>  
>  	/* Write the MSB and/or LSB */
> diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
> index 46beb155d835f..63b27d49b2864 100644
> --- a/drivers/gpu/drm/i915/display/intel_quirks.c
> +++ b/drivers/gpu/drm/i915/display/intel_quirks.c
> @@ -53,6 +53,16 @@ static void quirk_increase_ddi_disabled_time(struct drm_i915_private *i915)
>  	drm_info(&i915->drm, "Applying Increase DDI Disabled quirk\n");
>  }
>  
> +/*
> + * Some eDP backlight hardware uses the most-significant bits of the brightness
> + * register, so brightness values must be shifted first.
> + */
> +static void quirk_shift_edp_backlight_brightness(struct drm_i915_private *i915)
> +{
> +	i915->quirks |= QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS;
> +	DRM_INFO("Applying shift eDP backlight brightness quirk\n");
> +}
> +
>  struct intel_quirk {
>  	int device;
>  	int subsystem_vendor;
> @@ -156,6 +166,9 @@ static struct intel_quirk intel_quirks[] = {
>  	/* ASRock ITX*/
>  	{ 0x3185, 0x1849, 0x2212, quirk_increase_ddi_disabled_time },
>  	{ 0x3184, 0x1849, 0x2212, quirk_increase_ddi_disabled_time },
> +
> +	/* Google Pixelbook */
> +	{ 0x591E, 0x8086, 0x2212, quirk_shift_edp_backlight_brightness },
>  };
>  
>  void intel_init_quirks(struct drm_i915_private *i915)
> diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
> index e4f7f6518945b..cc93bede4fab8 100644
> --- a/drivers/gpu/drm/i915/i915_drv.h
> +++ b/drivers/gpu/drm/i915/i915_drv.h
> @@ -525,6 +525,7 @@ struct i915_psr {
>  #define QUIRK_PIN_SWIZZLED_PAGES (1<<5)
>  #define QUIRK_INCREASE_T12_DELAY (1<<6)
>  #define QUIRK_INCREASE_DDI_DISABLED_TIME (1<<7)
> +#define QUIRK_SHIFT_EDP_BACKLIGHT_BRIGHTNESS (1<<8)
>  
>  struct intel_fbdev;
>  struct intel_fbc_work;
> -- 
> 2.28.0.618.gf4bc123cb7-goog

-- 
Ville Syrjälä
Intel

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D6B2C5277
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 11:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388478AbgKZKwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 05:52:09 -0500
Received: from mga03.intel.com ([134.134.136.65]:16687 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388334AbgKZKwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 05:52:08 -0500
IronPort-SDR: ZOmKIf8KGl5F8oxcjXNgGP3o4A5p3H5GxB3eyH4IknmOzp5hJ7UkYg0LloUSK0qMSofvbqqkih
 i6IBn0bw0NOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="172367908"
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="172367908"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 02:52:07 -0800
IronPort-SDR: 5YJqH7VXGPfJMrrTtrb7gn3s2INDXe4ZESZDJ0xsav8xz6z2aY5ks+FW2U3UNVv77i9PHqfmY+
 fKYlkDcDK9SA==
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="547673952"
Received: from mpascu-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.41.186])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 02:52:01 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org
Cc:     thaytan@noraisin.net, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?utf-8?Q?Jos=C3=A9?= Roberto de Souza <jose.souza@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: Re: [RFC v2 1/8] drm/i915/dp: Program source OUI on eDP panels
In-Reply-To: <20200916171855.129511-2-lyude@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200916171855.129511-1-lyude@redhat.com> <20200916171855.129511-2-lyude@redhat.com>
Date:   Thu, 26 Nov 2020 12:51:58 +0200
Message-ID: <87v9dsl7ap.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Sep 2020, Lyude Paul <lyude@redhat.com> wrote:
> Since we're about to start adding support for Intel's magic HDR
> backlight interface over DPCD, we need to ensure we're properly
> programming this field so that Intel specific sink services are exposed.
> Otherwise, 0x300-0x3ff will just read zeroes.
>
> We also take care not to reprogram the source OUI if it already matches
> what we expect. This is just to be careful so that we don't accidentally
> take the panel out of any backlight control modes we found it in.
>
> v2:
> * Add careful parameter to intel_edp_init_source_oui() to avoid
>   re-writing the source OUI if it's already been set during driver
>   initialization
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: thaytan@noraisin.net
> Cc: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 33 +++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 4bd10456ad188..7db2b6a3cd52e 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -3424,6 +3424,29 @@ void intel_dp_sink_set_decompression_state(struct intel_dp *intel_dp,
>  			    enable ? "enable" : "disable");
>  }
>  
> +static void
> +intel_edp_init_source_oui(struct intel_dp *intel_dp, bool careful)
> +{
> +	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
> +	u8 oui[] = { 0x00, 0xaa, 0x01 };

Nitpick, could be static const.

> +	u8 buf[3] = { 0 };
> +
> +	/*
> +	 * During driver init, we want to be careful and avoid changing the source OUI if it's
> +	 * already set to what we want, so as to avoid clearing any state by accident
> +	 */

Did you actually observe any ill behaviour with unconditionally writing
the source OUI?

I mean it's easy to add the "careful" mode afterwards if there are
concrete issues, but it'll be hard to remove because it'll be a
functional change potentially causing regressions.

> +	if (careful) {
> +		if (drm_dp_dpcd_read(&intel_dp->aux, DP_SOURCE_OUI, buf, sizeof(buf)) < 0)
> +			drm_err(&i915->drm, "Failed to read source OUI\n");
> +
> +		if (memcmp(oui, buf, sizeof(oui)) == 0)
> +			return;
> +	}
> +
> +	if (drm_dp_dpcd_write(&intel_dp->aux, DP_SOURCE_OUI, oui, sizeof(oui)) < 0)
> +		drm_err(&i915->drm, "Failed to write source OUI\n");
> +}
> +
>  /* If the sink supports it, try to set the power state appropriately */
>  void intel_dp_sink_dpms(struct intel_dp *intel_dp, int mode)
>  {
> @@ -3443,6 +3466,10 @@ void intel_dp_sink_dpms(struct intel_dp *intel_dp, int mode)
>  	} else {
>  		struct intel_lspcon *lspcon = dp_to_lspcon(intel_dp);
>  
> +		/* Write the source OUI as early as possible */
> +		if (intel_dp_is_edp(intel_dp))
> +			intel_edp_init_source_oui(intel_dp, false);
> +

This hunk conflicts, will need a rebase.

BR,
Jani.


>  		/*
>  		 * When turning on, we need to retry for 1ms to give the sink
>  		 * time to wake up.
> @@ -4607,6 +4634,12 @@ intel_edp_init_dpcd(struct intel_dp *intel_dp)
>  	if (INTEL_GEN(dev_priv) >= 10 || IS_GEMINILAKE(dev_priv))
>  		intel_dp_get_dsc_sink_cap(intel_dp);
>  
> +	/*
> +	 * If needed, program our source OUI so we can make various Intel-specific AUX services
> +	 * available (such as HDR backlight controls)
> +	 */
> +	intel_edp_init_source_oui(intel_dp, true);
> +
>  	return true;
>  }

-- 
Jani Nikula, Intel Open Source Graphics Center

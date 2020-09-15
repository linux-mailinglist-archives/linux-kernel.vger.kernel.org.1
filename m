Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BC026ACF0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgIOTEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:04:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:25358 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbgIOTE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:04:26 -0400
IronPort-SDR: ZwA8agPH0rk1apOJrovga+xbuu8wR0TKj9LOPd/olg6PQOdfVMwpVzBCtJ3oIhhH4mDNm3osyw
 P9POVQWYfn9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="156716843"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="156716843"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 12:04:21 -0700
IronPort-SDR: 5FIuHz+wpLv9I75nZJ44QarO2AkAvPpiEwMKJxB3GdpIO+9q33aKJU4yAYPTJKV72heBpqvf3S
 lKrm/b9XNIrA==
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="345964726"
Received: from rdvivi-losangeles.jf.intel.com (HELO intel.com) ([10.165.21.201])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 12:04:21 -0700
Date:   Tue, 15 Sep 2020 15:06:39 -0400
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        thaytan@noraisin.net, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        =?iso-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, Manasi Navare <manasi.d.navare@intel.com>,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: Re: [RFC 1/5] drm/i915/dp: Program source OUI on eDP panels
Message-ID: <20200915190639.GC503362@intel.com>
References: <20200915172939.2810538-1-lyude@redhat.com>
 <20200915172939.2810538-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915172939.2810538-2-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 01:29:35PM -0400, Lyude Paul wrote:
> Since we're about to start adding support for Intel's magic HDR
> backlight interface over DPCD, we need to ensure we're properly
> programming this field so that Intel specific sink services are exposed.
> Otherwise, 0x300-0x3ff will just read zeroes.
> 
> We also take care not to reprogram the source OUI if it already matches
> what we expect. This is just to be careful so that we don't accidentally
> take the panel out of any backlight control modes we found it in.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: thaytan@noraisin.net
> Cc: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 32 +++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 4bd10456ad188..b591672ec4eab 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -3428,6 +3428,7 @@ void intel_dp_sink_set_decompression_state(struct intel_dp *intel_dp,
>  void intel_dp_sink_dpms(struct intel_dp *intel_dp, int mode)
>  {
>  	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
> +	u8 edp_oui[] = { 0x00, 0xaa, 0x01 };

what are these values?

>  	int ret, i;
>  
>  	/* Should have a valid DPCD by this point */
> @@ -3443,6 +3444,14 @@ void intel_dp_sink_dpms(struct intel_dp *intel_dp, int mode)
>  	} else {
>  		struct intel_lspcon *lspcon = dp_to_lspcon(intel_dp);
>  
> +		/* Write the source OUI as early as possible */
> +		if (intel_dp_is_edp(intel_dp)) {
> +			ret = drm_dp_dpcd_write(&intel_dp->aux, DP_SOURCE_OUI, edp_oui,
> +						sizeof(edp_oui));
> +			if (ret < 0)
> +				drm_err(&i915->drm, "Failed to write eDP source OUI\n");
> +		}
> +
>  		/*
>  		 * When turning on, we need to retry for 1ms to give the sink
>  		 * time to wake up.
> @@ -4530,6 +4539,23 @@ static void intel_dp_get_dsc_sink_cap(struct intel_dp *intel_dp)
>  	}
>  }
>  
> +static void
> +intel_edp_init_source_oui(struct intel_dp *intel_dp)
> +{
> +	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
> +	u8 oui[] = { 0x00, 0xaa, 0x01 };
> +	u8 buf[3] = { 0 };
> +
> +	if (drm_dp_dpcd_read(&intel_dp->aux, DP_SOURCE_OUI, buf, sizeof(buf)) < 0)
> +		drm_err(&i915->drm, "Failed to read source OUI\n");
> +
> +	if (memcmp(oui, buf, sizeof(oui)) == 0)
> +		return;
> +
> +	if (drm_dp_dpcd_write(&intel_dp->aux, DP_SOURCE_OUI, oui, sizeof(oui)) < 0)
> +		drm_err(&i915->drm, "Failed to write source OUI\n");
> +}
> +
>  static bool
>  intel_edp_init_dpcd(struct intel_dp *intel_dp)
>  {
> @@ -4607,6 +4633,12 @@ intel_edp_init_dpcd(struct intel_dp *intel_dp)
>  	if (INTEL_GEN(dev_priv) >= 10 || IS_GEMINILAKE(dev_priv))
>  		intel_dp_get_dsc_sink_cap(intel_dp);
>  
> +	/*
> +	 * Program our source OUI so we can make various Intel-specific AUX
> +	 * services available (such as HDR backlight controls)
> +	 */
> +	intel_edp_init_source_oui(intel_dp);

I believe we should restrict this to the supported platforms: cfl, whl, cml, icl, tgl
no?

> +
>  	return true;
>  }
>  
> -- 
> 2.26.2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

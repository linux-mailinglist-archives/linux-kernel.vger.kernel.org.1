Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B244426BE61
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 09:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgIPHni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 03:43:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:22721 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgIPHnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:43:37 -0400
IronPort-SDR: 9w+ZN43qWVCDwqoonecx6fC9GgLqd1Kt5qBML2P+TKuXCuR4g6TRip4zswjD1JDk2r+EBsq/QN
 8qGGyuhnsiJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="220975308"
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="220975308"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 00:43:36 -0700
IronPort-SDR: OZ7tMty0VP/hRXfVXL0x4qgPXpQXMNVgdmQghv9OU0GOtBg6LdI4ZajhNrKK03UbRAXfRCzuQ8
 uyjHu6wOhSvw==
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="483196147"
Received: from djgriffi-mobl.ger.corp.intel.com (HELO localhost) ([10.252.8.217])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 00:43:30 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Lyude Paul <lyude@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: Re: [Intel-gfx] [RFC 1/5] drm/i915/dp: Program source OUI on eDP panels
In-Reply-To: <20200915190639.GC503362@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200915172939.2810538-1-lyude@redhat.com> <20200915172939.2810538-2-lyude@redhat.com> <20200915190639.GC503362@intel.com>
Date:   Wed, 16 Sep 2020 10:43:35 +0300
Message-ID: <87mu1qw4ig.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020, Rodrigo Vivi <rodrigo.vivi@intel.com> wrote:
> On Tue, Sep 15, 2020 at 01:29:35PM -0400, Lyude Paul wrote:
>> Since we're about to start adding support for Intel's magic HDR
>> backlight interface over DPCD, we need to ensure we're properly
>> programming this field so that Intel specific sink services are exposed.
>> Otherwise, 0x300-0x3ff will just read zeroes.
>> 
>> We also take care not to reprogram the source OUI if it already matches
>> what we expect. This is just to be careful so that we don't accidentally
>> take the panel out of any backlight control modes we found it in.

(For whatever reason I didn't receive the original message.)

>> 
>> Signed-off-by: Lyude Paul <lyude@redhat.com>
>> Cc: thaytan@noraisin.net
>> Cc: Vasily Khoruzhick <anarsoul@gmail.com>
>> ---
>>  drivers/gpu/drm/i915/display/intel_dp.c | 32 +++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>> 
>> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
>> index 4bd10456ad188..b591672ec4eab 100644
>> --- a/drivers/gpu/drm/i915/display/intel_dp.c
>> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
>> @@ -3428,6 +3428,7 @@ void intel_dp_sink_set_decompression_state(struct intel_dp *intel_dp,
>>  void intel_dp_sink_dpms(struct intel_dp *intel_dp, int mode)
>>  {
>>  	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
>> +	u8 edp_oui[] = { 0x00, 0xaa, 0x01 };
>
> what are these values?

An OUI lookup confirms these are Intel OUI.

>
>>  	int ret, i;
>>  
>>  	/* Should have a valid DPCD by this point */
>> @@ -3443,6 +3444,14 @@ void intel_dp_sink_dpms(struct intel_dp *intel_dp, int mode)
>>  	} else {
>>  		struct intel_lspcon *lspcon = dp_to_lspcon(intel_dp);
>>  
>> +		/* Write the source OUI as early as possible */
>> +		if (intel_dp_is_edp(intel_dp)) {
>> +			ret = drm_dp_dpcd_write(&intel_dp->aux, DP_SOURCE_OUI, edp_oui,
>> +						sizeof(edp_oui));
>> +			if (ret < 0)
>> +				drm_err(&i915->drm, "Failed to write eDP source OUI\n");
>> +		}
>> +
>>  		/*
>>  		 * When turning on, we need to retry for 1ms to give the sink
>>  		 * time to wake up.
>> @@ -4530,6 +4539,23 @@ static void intel_dp_get_dsc_sink_cap(struct intel_dp *intel_dp)
>>  	}
>>  }
>>  
>> +static void
>> +intel_edp_init_source_oui(struct intel_dp *intel_dp)
>> +{
>> +	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
>> +	u8 oui[] = { 0x00, 0xaa, 0x01 };
>> +	u8 buf[3] = { 0 };
>> +
>> +	if (drm_dp_dpcd_read(&intel_dp->aux, DP_SOURCE_OUI, buf, sizeof(buf)) < 0)
>> +		drm_err(&i915->drm, "Failed to read source OUI\n");
>> +
>> +	if (memcmp(oui, buf, sizeof(oui)) == 0)
>> +		return;
>> +
>> +	if (drm_dp_dpcd_write(&intel_dp->aux, DP_SOURCE_OUI, oui, sizeof(oui)) < 0)
>> +		drm_err(&i915->drm, "Failed to write source OUI\n");
>> +}

Maybe add this function with a parameter to force write or write only if
necessary, and call from both places that set source OUI?

>> +
>>  static bool
>>  intel_edp_init_dpcd(struct intel_dp *intel_dp)
>>  {
>> @@ -4607,6 +4633,12 @@ intel_edp_init_dpcd(struct intel_dp *intel_dp)
>>  	if (INTEL_GEN(dev_priv) >= 10 || IS_GEMINILAKE(dev_priv))
>>  		intel_dp_get_dsc_sink_cap(intel_dp);
>>  
>> +	/*
>> +	 * Program our source OUI so we can make various Intel-specific AUX
>> +	 * services available (such as HDR backlight controls)
>> +	 */
>> +	intel_edp_init_source_oui(intel_dp);
>
> I believe we should restrict this to the supported platforms: cfl, whl, cml, icl, tgl
> no?

Mmh, this just exposes sink behaviour that I think can be supported by
any platform. I don't understand the notion of "supported platforms"
here.

>
>> +
>>  	return true;
>>  }
>>  
>> -- 
>> 2.26.2
>> 
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Jani Nikula, Intel Open Source Graphics Center

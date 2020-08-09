Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C2723FF34
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Aug 2020 18:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgHIQ0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Aug 2020 12:26:48 -0400
Received: from mail.ispras.ru ([83.149.199.84]:60456 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgHIQ0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 12:26:46 -0400
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
        by mail.ispras.ru (Postfix) with ESMTPS id B6F6C40A2045;
        Sun,  9 Aug 2020 16:26:42 +0000 (UTC)
Date:   Sun, 9 Aug 2020 19:26:42 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     amd-gfx@lists.freedesktop.org
cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: use correct scale for
 actual_brightness
In-Reply-To: <20200804201313.6464-1-amonakov@ispras.ru>
Message-ID: <alpine.LNX.2.20.13.2008091925270.2454@monopod.intra.ispras.ru>
References: <20200804201313.6464-1-amonakov@ispras.ru>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Aug 2020, Alexander Monakov wrote:

> Documentation for sysfs backlight level interface requires that
> values in both 'brightness' and 'actual_brightness' files are
> interpreted to be in range from 0 to the value given in the
> 'max_brightness' file.
> 
> With amdgpu, max_brightness gives 255, and values written by the user
> into 'brightness' are internally rescaled to a wider range. However,
> reading from 'actual_brightness' gives the raw register value without
> inverse rescaling. This causes issues for various userspace tools such
> as PowerTop and systemd that expect the value to be in the correct
> range.
> 
> Introduce a helper to retrieve internal backlight range. Use it to
> reimplement 'convert_brightness' as 'convert_brightness_from_user' and
> introduce 'convert_brightness_to_user'.
> 
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=203905
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1242
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> ---
> v2: split convert_brightness to &_from_user and &_to_user (Nicholas)

Nicholas, does this implement the kind of split you had in mind?

>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 81 +++++++++----------
>  1 file changed, 40 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 710edc70e37e..b60a763f3f95 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2881,51 +2881,50 @@ static int set_backlight_via_aux(struct dc_link *link, uint32_t brightness)
>  	return rc ? 0 : 1;
>  }
>  
> -static u32 convert_brightness(const struct amdgpu_dm_backlight_caps *caps,
> -			      const uint32_t user_brightness)
> +static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
> +				unsigned *min, unsigned *max)
>  {
> -	u32 min, max, conversion_pace;
> -	u32 brightness = user_brightness;
> -
>  	if (!caps)
> -		goto out;
> +		return 0;
>  
> -	if (!caps->aux_support) {
> -		max = caps->max_input_signal;
> -		min = caps->min_input_signal;
> -		/*
> -		 * The brightness input is in the range 0-255
> -		 * It needs to be rescaled to be between the
> -		 * requested min and max input signal
> -		 * It also needs to be scaled up by 0x101 to
> -		 * match the DC interface which has a range of
> -		 * 0 to 0xffff
> -		 */
> -		conversion_pace = 0x101;
> -		brightness =
> -			user_brightness
> -			* conversion_pace
> -			* (max - min)
> -			/ AMDGPU_MAX_BL_LEVEL
> -			+ min * conversion_pace;
> +	if (caps->aux_support) {
> +		// Firmware limits are in nits, DC API wants millinits.
> +		*max = 1000 * caps->aux_max_input_signal;
> +		*min = 1000 * caps->aux_min_input_signal;
>  	} else {
> -		/* TODO
> -		 * We are doing a linear interpolation here, which is OK but
> -		 * does not provide the optimal result. We probably want
> -		 * something close to the Perceptual Quantizer (PQ) curve.
> -		 */
> -		max = caps->aux_max_input_signal;
> -		min = caps->aux_min_input_signal;
> -
> -		brightness = (AMDGPU_MAX_BL_LEVEL - user_brightness) * min
> -			       + user_brightness * max;
> -		// Multiple the value by 1000 since we use millinits
> -		brightness *= 1000;
> -		brightness = DIV_ROUND_CLOSEST(brightness, AMDGPU_MAX_BL_LEVEL);
> +		// Firmware limits are 8-bit, PWM control is 16-bit.
> +		*max = 0x101 * caps->max_input_signal;
> +		*min = 0x101 * caps->min_input_signal;
>  	}
> +	return 1;
> +}
>  
> -out:
> -	return brightness;
> +static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
> +					uint32_t brightness)
> +{
> +	unsigned min, max;
> +
> +	if (!get_brightness_range(caps, &min, &max))
> +		return brightness;
> +
> +	// Rescale 0..255 to min..max
> +	return min + DIV_ROUND_CLOSEST((max - min) * brightness,
> +				       AMDGPU_MAX_BL_LEVEL);
> +}
> +
> +static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
> +				      uint32_t brightness)
> +{
> +	unsigned min, max;
> +
> +	if (!get_brightness_range(caps, &min, &max))
> +		return brightness;
> +
> +	if (brightness < min)
> +		return 0;
> +	// Rescale min..max to 0..255
> +	return DIV_ROUND_CLOSEST(AMDGPU_MAX_BL_LEVEL * (brightness - min),
> +				 max - min);
>  }
>  
>  static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
> @@ -2941,7 +2940,7 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
>  
>  	link = (struct dc_link *)dm->backlight_link;
>  
> -	brightness = convert_brightness(&caps, bd->props.brightness);
> +	brightness = convert_brightness_from_user(&caps, bd->props.brightness);
>  	// Change brightness based on AUX property
>  	if (caps.aux_support)
>  		return set_backlight_via_aux(link, brightness);
> @@ -2958,7 +2957,7 @@ static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
>  
>  	if (ret == DC_ERROR_UNEXPECTED)
>  		return bd->props.brightness;
> -	return ret;
> +	return convert_brightness_to_user(&dm->backlight_caps, ret);
>  }
>  
>  static const struct backlight_ops amdgpu_dm_backlight_ops = {
> 
> base-commit: bcf876870b95592b52519ed4aafcf9d95999bc9c
> 

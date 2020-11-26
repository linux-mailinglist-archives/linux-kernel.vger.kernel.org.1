Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45ABF2C5369
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 13:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388005AbgKZL5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 06:57:13 -0500
Received: from mga09.intel.com ([134.134.136.24]:1476 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729257AbgKZL5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 06:57:13 -0500
IronPort-SDR: PPgq88w5chmZzzDdYXxOnm82pGjV0IVHK+XZTZjCY2WOLmTlgxpyr8OhWhq2jkBu47/0GYTzOv
 lWmV3B5p6HnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="172431182"
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="172431182"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 03:57:12 -0800
IronPort-SDR: z9+MdCtPxpANd2MGsBizYDWK2k6FBc2q8jZ35KkrSPGVaOVmaixqqEdwXSFsdddO5qS4fxG2ji
 GVPWjTgNO3Ng==
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="547691187"
Received: from mpascu-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.41.186])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 03:57:08 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Dave Airlie <airlied@gmail.com>, Lyude Paul <lyude@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: Re: [Intel-gfx] [RFC v2 3/8] drm/i915: Keep track of pwm-related backlight hooks separately
In-Reply-To: <CAPM=9tzLK3caEW661tCeSPhn0G0NihuztCdgyABDgtvZRvV4xA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200916171855.129511-1-lyude@redhat.com> <20200916171855.129511-4-lyude@redhat.com> <CAPM=9tzLK3caEW661tCeSPhn0G0NihuztCdgyABDgtvZRvV4xA@mail.gmail.com>
Date:   Thu, 26 Nov 2020 13:57:05 +0200
Message-ID: <87o8jkl4a6.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020, Dave Airlie <airlied@gmail.com> wrote:
> On Thu, 17 Sept 2020 at 03:19, Lyude Paul <lyude@redhat.com> wrote:
>>
>> Currently, every different type of backlight hook that i915 supports is
>> pretty straight forward - you have a backlight, probably through PWM
>> (but maybe DPCD), with a single set of platform-specific hooks that are
>> used for controlling it.
>>
>> HDR backlights, in particular VESA and Intel's HDR backlight
>> implementations, can end up being more complicated. With Intel's
>> proprietary interface, HDR backlight controls always run through the
>> DPCD. When the backlight is in SDR backlight mode however, the driver
>> may need to bypass the TCON and control the backlight directly through
>> PWM.
>>
>> So, in order to support this we'll need to split our backlight callbacks
>> into two groups: a set of high-level backlight control callbacks in
>> intel_panel, and an additional set of pwm-specific backlight control
>> callbacks. This also implies a functional changes for how these
>> callbacks are used:
>>
>> * We now keep track of two separate backlight level ranges, one for the
>>   high-level backlight, and one for the pwm backlight range
>> * We also keep track of backlight enablement and PWM backlight
>>   enablement separately
>> * Since the currently set backlight level might not be the same as the
>>   currently programmed PWM backlight level, we stop setting
>>   panel->backlight.level with the currently programmed PWM backlight
>>   level in panel->backlight.pwm_funcs.setup(). Instead, we rely
>>   on the higher level backlight control functions to retrieve the
>>   current PWM backlight level (in this case, intel_pwm_get_backlight()).
>>   Note that there are still a few PWM backlight setup callbacks that
>>   do actually need to retrieve the current PWM backlight level, although
>>   we no longer save this value in panel->backlight.level like before.
>> * panel->backlight.pwm_funcs.enable()/disable() both accept a PWM
>>   brightness level, unlike their siblings
>>   panel->backlight.enable()/disable(). This is so we can calculate the
>>   actual PWM brightness level we want to set on disable/enable in the
>>   higher level backlight enable()/disable() functions, since this value
>>   might be scaled from a brightness level that doesn't come from PWM.
>
> Oh this patch is a handful, I can see why people stall out here.
>
> I'm going to be annoying maintainer and see if you can clean this up a
> bit in advance of this patch.

Agreed. And not looking into and requesting this earlier is on me.

The thing that still keeps bugging me about the DPCD brightness control
in general is that it's a historical mistake to put all of this under
i915. (Again, mea culpa.) The standard DPCD brightness control should
really be under drm core, in one form or another.

I'm not asking to fix that here. But I *am* wondering if the series
makes that harder. What would it look like if we did have that unicorn
of a brightness connector property? How would that tie into the hooks we
have?

Maybe the answer is that the DPCD backlight functions should just be
library code in drm core that the drivers could call. In the long run,
i915 really can't be the only one needing this stuff.

We haven't implemented the mixed modes of DPCD and eDP PWM pin
brightness control. But the point is, the library code can't call into
i915 specific eDP PWM pin control code. The proprietary HDR brightness
code will still be i915 specific, but does it make sense to have a mixed
mode there that will be completely different from what a mixed mode with
the standard VESA DPCD brightness could be?

I.e. what should be the entry points for the hooks, and who calls what?

BR,
Jani.

>
> 1) move the callbacks out of struct intel_panel.backlight into a separate struct
> and use const static object tables, having fn ptrs and data co-located
> in a struct
> isn't great.
>
> strcut intel_panel_backlight_funcs {
>
> };
> struct intel_panel {
>     struct {
>         struct intel_panel_backlight_funcs *funcs;
>     };
> };
>
> type of thing.
>
> I think you could reuse the backlight funcs struct for the pwm stuff
> as well. (maybe with an assert on hz_to_pwm for the old hooks).
>
> 2) change the apis to pass 0 down in a separate patch, this modifies a
> bunch of apis to pass in an extra level parameter, do that
> first in a separate patch that doesn't change anything but hands 0
> down the chain. Then switch over in another patch.
>
> 3) One comment in passing below.
>>
>>
>> -       if (cpu_mode)
>> -               val = pch_get_backlight(connector);
>> -       else
>> -               val = lpt_get_backlight(connector);
>> -       val = intel_panel_compute_brightness(connector, val);
>> -       panel->backlight.level = clamp(val, panel->backlight.min,
>> -                                      panel->backlight.max);
>>
>>         if (cpu_mode) {
>> +               val = intel_panel_sanitize_pwm_level(connector, pch_get_backlight(connector));
>> +
>>                 drm_dbg_kms(&dev_priv->drm,
>>                             "CPU backlight register was enabled, switching to PCH override\n");
>>
>>                 /* Write converted CPU PWM value to PCH override register */
>> -               lpt_set_backlight(connector->base.state, panel->backlight.level);
>> +               lpt_set_backlight(connector->base.state, val);
>>                 intel_de_write(dev_priv, BLC_PWM_PCH_CTL1,
>>                                pch_ctl1 | BLM_PCH_OVERRIDE_ENABLE);
>>
> The change here confused me since it no longer calls lpt_get_backlight
> in this path, the commit msg might explain this, but it didn't explain
> is so I could figure out if that was a mistake or intentional.
>
> Dave.
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Jani Nikula, Intel Open Source Graphics Center

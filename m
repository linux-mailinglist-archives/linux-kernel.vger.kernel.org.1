Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7462228626B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 17:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgJGPpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 11:45:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:21310 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbgJGPpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:45:34 -0400
IronPort-SDR: 5JoB1Amrhf6l+4MSPP2MV1SBFOAgvEQfVPBjZGSRkNkPOst7CjhuDPSKShqgViYgFao6n8wSt0
 l3pDhgQLGoQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="151925280"
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="151925280"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 08:45:33 -0700
IronPort-SDR: dSzd2fqw2gQ5jdGVKSZWflL8Vl34KK9OtKbcpqH7DBqlCDWtQvQw88yvE9H04nY/6r1FUMgWY8
 GYn/U2+rSKjA==
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="528014627"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.145.6]) ([10.249.145.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 08:45:32 -0700
Subject: Re: ACPI _CST introduced performance regresions on Haswll
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
References: <20201006083639.GJ3227@techsingularity.net>
 <c3566d2b-3da1-917b-2df6-f7dcfb33c8ed@intel.com>
 <20201006190322.GL3227@techsingularity.net>
 <25f31d3e-7a67-935f-93ba-32216a5084e2@intel.com>
 <20201006211820.GN3227@techsingularity.net>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <2382d796-7c2f-665e-9169-5cdc437bf34c@intel.com>
Date:   Wed, 7 Oct 2020 17:45:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201006211820.GN3227@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/2020 11:18 PM, Mel Gorman wrote:
> On Tue, Oct 06, 2020 at 09:29:24PM +0200, Rafael J. Wysocki wrote:
>>> After the commit, the default_status file does not appear in /sys
>>>
>> Something is amiss, then, because the commit doesn't affect the presence of
>> this file.
>>
> This was cleared up in another mail.
>
>> The only thing it does is to set the use_acpi flag for several processor
>> models in intel_idle.c.
>>
>> It can be effectively reversed by removing all of the ".use_acpi = true,"
>> lines from intel_idle.c.
>>
>> In particular, please check if changing the value of use_acpi in struct
>> idle_cpu_hsx from 'true' to 'false' alone (without reverting the commit)
>> makes the issue go away in 5.9-rc8 (the default_status file should be
>> present regardless).
>>
> Thanks.  I applied the following
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 9a810e4a7946..6478347669a9 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1044,7 +1044,7 @@ static const struct idle_cpu idle_cpu_hsw __initconst = {
>   static const struct idle_cpu idle_cpu_hsx __initconst = {
>   	.state_table = hsw_cstates,
>   	.disable_promotion_to_c1e = true,
> -	.use_acpi = true,
> +	.use_acpi = false,
>   };
>
> netperf UDP_STREAM
>                                        pre                 enable                 enable                5.9-rc8                5.9-rc8
>                                        cst                    cst        cst-no-hsx-acpi                vanilla            no-hsx-acpi
> Hmean     send-64       203.96 (   0.00%)      179.23 * -12.13%*      201.04 (  -1.44%)      203.24 (  -0.36%)      233.43 *  14.45%*
> Hmean     send-128      403.66 (   0.00%)      355.99 * -11.81%*      402.28 (  -0.34%)      387.65 *  -3.97%*      461.47 *  14.32%*
> Hmean     send-256      784.39 (   0.00%)      697.78 * -11.04%*      782.15 (  -0.29%)      758.49 *  -3.30%*      895.31 *  14.14%*
> Hmean     recv-64       203.96 (   0.00%)      179.23 * -12.13%*      201.04 (  -1.44%)      203.24 (  -0.36%)      233.43 *  14.45%*
> Hmean     recv-128      403.66 (   0.00%)      355.99 * -11.81%*      402.28 (  -0.34%)      387.65 *  -3.97%*      461.47 *  14.32%*
> Hmean     recv-256      784.39 (   0.00%)      697.78 * -11.04%*      782.15 (  -0.29%)      758.49 *  -3.30%*      895.28 *  14.14%*
>
> This is a more limited run to save time but is enough to illustrate
> the point.
>
> pre-cst is just before your patch
> enable-cst is your patch that was bisected
> enable-cst-no-hsx-acpi is your patch with use_acpi disabled
> 5.9-rc8-vanilla is what it sounds like
> 5.9-rc8-no-hsx-acpi disables use_acpi
>
> The enable-cst-no-hsx-acpi result indicates that use_acpi was the issue for
> Haswell (at least these machines). Looking just at 5.9-rc8-vanillaa might
> have been misleading because its performance is not far off the baseline
> due to unrelated changes that mostly offset the performance penalty.
>
> The key question is -- how appropriate would it be to disable acpi for
> Haswell? Would that be generally safe or could it hide other surprises?
>
It should be safe, but let's try to do something more fine-grained.

There is the CPUIDLE_FLAG_ALWAYS_ENABLE flag that is set for C1E.  Can 
you please try to set it for C6 in hsw_cstates instead of clearing 
use_acpi in idle_cpu_hsx and retest?



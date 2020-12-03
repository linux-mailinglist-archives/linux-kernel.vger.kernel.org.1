Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F10A2CF185
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbgLDQFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:05:01 -0500
Received: from mga09.intel.com ([134.134.136.24]:42515 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbgLDQE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:04:58 -0500
IronPort-SDR: MFNtlOhjbfylw0+q+7R8/6eep6J2ZzygkYS9S3K6tHJgANtmQgHb1BRJ4jDfl+hOUJxp+7Nf9O
 qH3ESzvo/OoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="173551471"
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="173551471"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 08:03:16 -0800
IronPort-SDR: /SIAt6AXx4ob0LCsOSeQ1gW9ktDI70TDWFTpVGfBprl3q2Ms/Sgazfz/0P13Bthv1hLmI2lt+Q
 w2KfKBhgMwrA==
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="373960693"
Received: from emogena-mobl1.amr.corp.intel.com (HELO [10.212.90.42]) ([10.212.90.42])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 08:03:15 -0800
Subject: Re: [PATCH] soundwire: intel: fix another unused-function warning
To:     Arnd Bergmann <arnd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Rander Wang <rander.wang@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20201203230502.1480063-1-arnd@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <070e64b8-88e4-ccf1-b51e-99de513ab55c@linux.intel.com>
Date:   Thu, 3 Dec 2020 17:48:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201203230502.1480063-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/3/20 5:04 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Without CONFIG_PM, there is another warning about an unused function:
> 
> drivers/soundwire/intel.c:530:12: error: 'intel_link_power_down' defined but not used [-Werror=unused-function]
> 
> After a previous fix, the driver already uses both an #ifdef and
> a __maybe_unused annotation but still gets it wrong. Remove the
> ifdef and instead use __maybe_unused consistently to avoid the
> problem for good.
> 
> Fixes: f046b2334083 ("soundwire: intel: fix intel_suspend/resume defined but not used warning")
> Fixes: ebf878eddbb4 ("soundwire: intel: add pm_runtime support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch Arnd, indeed that's a miss.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   drivers/soundwire/intel.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 6a1e862b16c3..66adb258a425 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1585,8 +1585,6 @@ int intel_master_process_wakeen_event(struct platform_device *pdev)
>    * PM calls
>    */
>   
> -#ifdef CONFIG_PM
> -
>   static int __maybe_unused intel_suspend(struct device *dev)
>   {
>   	struct sdw_cdns *cdns = dev_get_drvdata(dev);
> @@ -1641,7 +1639,7 @@ static int __maybe_unused intel_suspend(struct device *dev)
>   	return 0;
>   }
>   
> -static int intel_suspend_runtime(struct device *dev)
> +static int __maybe_unused intel_suspend_runtime(struct device *dev)
>   {
>   	struct sdw_cdns *cdns = dev_get_drvdata(dev);
>   	struct sdw_intel *sdw = cdns_to_intel(cdns);
> @@ -1796,7 +1794,7 @@ static int __maybe_unused intel_resume(struct device *dev)
>   	return ret;
>   }
>   
> -static int intel_resume_runtime(struct device *dev)
> +static int __maybe_unused intel_resume_runtime(struct device *dev)
>   {
>   	struct sdw_cdns *cdns = dev_get_drvdata(dev);
>   	struct sdw_intel *sdw = cdns_to_intel(cdns);
> @@ -1969,8 +1967,6 @@ static int intel_resume_runtime(struct device *dev)
>   	return ret;
>   }
>   
> -#endif
> -
>   static const struct dev_pm_ops intel_pm = {
>   	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
>   	SET_RUNTIME_PM_OPS(intel_suspend_runtime, intel_resume_runtime, NULL)
> 

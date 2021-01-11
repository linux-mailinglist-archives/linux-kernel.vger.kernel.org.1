Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEDE2F20D0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387503AbhAKUaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:30:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:38638 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728701AbhAKUaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:30:20 -0500
IronPort-SDR: IxDCphXIE4LbiU4fglFCXbfFD8RPTgCk3vcFB3k5/Y2C0xRXbGoEDOJ2VNdpKuDuROG9WiWUVo
 k6Cc07bkkaSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="157110608"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="157110608"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 12:28:34 -0800
IronPort-SDR: 7Lmv4jpP+QuEafbuouAL4jOSz3kIZVScDA8uz+WZCQOjEsYkHs4kPTvy+63kmXbu6sGVUjS2+o
 Nw+oosBYKUFg==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="344995375"
Received: from gkbech1x-mobl.amr.corp.intel.com (HELO [10.212.87.85]) ([10.212.87.85])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 12:28:33 -0800
Subject: Re: [PATCH 12/14] ASoC: Intel: Add DMI quirk table to
 soc_intel_is_byt_cr()
To:     Hans de Goede <hdegoede@redhat.com>,
        Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20201227211232.117801-1-hdegoede@redhat.com>
 <20201227211232.117801-13-hdegoede@redhat.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <92934cb4-0b68-bdcc-d63b-d20628bc3c94@linux.intel.com>
Date:   Mon, 11 Jan 2021 11:52:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201227211232.117801-13-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/27/20 3:12 PM, Hans de Goede wrote:
> Some Bay Trail systems:
> 1. Use a non CR version of the Bay Trail SoC
> 2. Contain at least 6 interrupt resources so that the
>     platform_get_resource(pdev, IORESOURCE_IRQ, 5) check to workaround
>     non CR systems which list their IPC IRQ at index 0 despite being
>     non CR does not work
> 3. Despite 1. and 2. still have their IPC IRQ at index 0 rather then 5
> 
> Add a DMI quirk table to check for the few known models with this issue,
> so that the right IPC IRQ index is used on these systems.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks Hans!

> ---
>   sound/soc/intel/common/soc-intel-quirks.h | 25 +++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/sound/soc/intel/common/soc-intel-quirks.h b/sound/soc/intel/common/soc-intel-quirks.h
> index b07df3059926..a93987ab7f4d 100644
> --- a/sound/soc/intel/common/soc-intel-quirks.h
> +++ b/sound/soc/intel/common/soc-intel-quirks.h
> @@ -11,6 +11,7 @@
>   
>   #if IS_ENABLED(CONFIG_X86)
>   
> +#include <linux/dmi.h>
>   #include <asm/cpu_device_id.h>
>   #include <asm/intel-family.h>
>   #include <asm/iosf_mbi.h>
> @@ -38,12 +39,36 @@ SOC_INTEL_IS_CPU(cml, KABYLAKE_L);
>   
>   static inline bool soc_intel_is_byt_cr(struct platform_device *pdev)
>   {
> +	/*
> +	 * List of systems which:
> +	 * 1. Use a non CR version of the Bay Trail SoC
> +	 * 2. Contain at least 6 interrupt resources so that the
> +	 *    platform_get_resource(pdev, IORESOURCE_IRQ, 5) check below
> +	 *    succeeds
> +	 * 3. Despite 1. and 2. still have their IPC IRQ at index 0 rather then 5
> +	 *
> +	 * This needs to be here so that it can be shared between the SST and
> +	 * SOF drivers. We rely on the compiler to optimize this out in files
> +	 * where soc_intel_is_byt_cr is not used.
> +	 */
> +	static const struct dmi_system_id force_bytcr_table[] = {
> +		{	/* Lenovo Yoga Tablet 2 series */
> +			.matches = {
> +				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +				DMI_MATCH(DMI_PRODUCT_FAMILY, "YOGATablet2"),
> +			},
> +		},
> +		{}
> +	};
>   	struct device *dev = &pdev->dev;
>   	int status = 0;
>   
>   	if (!soc_intel_is_byt())
>   		return false;
>   
> +	if (dmi_check_system(force_bytcr_table))
> +		return true;
> +
>   	if (iosf_mbi_available()) {
>   		u32 bios_status;
>   
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F151A76C6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 11:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437300AbgDNJAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 05:00:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:58091 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437280AbgDNI7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:59:55 -0400
IronPort-SDR: OWTwU1xjVLqcg4ZyAc2E8iauy2D8NQFFAgIh3Qtx/WjYin6vwrODWfG+c/kipqDgoUZ1FWqSd3
 TVk/LWTcP/2w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 01:59:54 -0700
IronPort-SDR: nTRY4F9FYKyL9PfVM6xsZ5/9u0TRKVZNswM5DrPWZ0E9d8IIUx3Jnr5XWmaDCrn73Jj4aa20Gd
 101o5HYFttVQ==
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="253141691"
Received: from aslawinx-mobl1.ger.corp.intel.com (HELO [10.249.141.95]) ([10.249.141.95])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 01:59:50 -0700
Subject: Re: [PATCH] ASoC: Intel: sst: ipc command timeout
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Richard Fontana <rfontana@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
References: <1586506705-3194-1-git-send-email-brent.lu@intel.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Message-ID: <d59774fc-bc95-d6c7-e354-a81e6490049a@linux.intel.com>
Date:   Tue, 14 Apr 2020 10:59:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1586506705-3194-1-git-send-email-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/2020 10:18 AM, Brent Lu wrote:
> After sending an ipc command to DSP, the host waits for the reply message
> which will be read from SST_IPCD register in sst_byt_irq_thread() to
> complete the transaction. Sometimes the value read from SST_IPCD register
> is still the reply message for previous command instead of the waiting
> command so ipc command timeout happens.
> 
> In an experiment we read the same SST_IPCD register again when the defect
> happens and found the value of second read is different from previous one
> and is the correct reply message. It suggests the DSP is okay but the way
> we read the register may be the cause.
> 
> Currently the driver is using memcpy_fromio() to read the value of 64-bit
> registers. This function is based on __builtin_memcpy() call and depends
> on the implementation of compiler. Since this issue happens right after
> the toolchain switched from clang 10 to clang 11, we replace the register
> read with two readl() function calls to avoid all optimization from
> compiler's library.
> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>   sound/soc/intel/common/sst-dsp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/common/sst-dsp.c b/sound/soc/intel/common/sst-dsp.c
> index ec66be2..12af7aa 100644
> --- a/sound/soc/intel/common/sst-dsp.c
> +++ b/sound/soc/intel/common/sst-dsp.c
> @@ -42,7 +42,7 @@ u64 sst_shim32_read64(void __iomem *addr, u32 offset)
>   {
>   	u64 val;
>   
> -	memcpy_fromio(&val, addr + offset, sizeof(val));
> +	sst_memcpy_fromio_32(NULL, &val, addr + offset, sizeof(val));
>   	return val;
>   }
>   EXPORT_SYMBOL_GPL(sst_shim32_read64);
> 

I'm not convinced that it is a correct fix. From your description it 
seems to be a timing issue and you are just masking a problem, while 
real problem is flow which allows to read data before confirming that 
DSP finished processing.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C22228CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 01:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbgGUXqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 19:46:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:44145 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731526AbgGUXqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:46:07 -0400
IronPort-SDR: VioAt7F/yJYuhaE9p1OBpfrI3iGKWxaZaR41kXPOWwLYv1kBStMBv5Aa3jhhVPwpZ+25OpNvkf
 5zHSv30ERtew==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="129815369"
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; 
   d="scan'208";a="129815369"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 16:46:06 -0700
IronPort-SDR: 0xLtgHHJOzzRc95f2kjcdPpW6Ib8fQaUUy4cYYiK9FUL41OzMeYpNocbp6tYml5MSEvN77aelG
 +X7Ab/L1y5Sg==
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; 
   d="scan'208";a="362539378"
Received: from krlloyd-mobl.amr.corp.intel.com (HELO [10.255.231.6]) ([10.255.231.6])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 16:46:05 -0700
Subject: Re: [PATCH v2 9/9] ASoC: q6asm-dai: add support to copy callback
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
References: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
 <20200721165306.29082-10-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e3ad122c-d560-33f6-1bff-ea2b16fe47b5@linux.intel.com>
Date:   Tue, 21 Jul 2020 14:54:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721165306.29082-10-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> +static int q6asm_compr_copy(struct snd_soc_component *component,
> +			    struct snd_compr_stream *stream, char __user *buf,
> +			    size_t count)
>   {
>   	struct snd_compr_runtime *runtime = stream->runtime;
>   	struct q6asm_dai_rtd *prtd = runtime->private_data;
>   	unsigned long flags;
> +	u32 wflags = 0;
> +	int avail, bytes_in_flight = 0;
> +	void *dstn;
> +	size_t copy;
> +	u32 app_pointer;
> +	u32 bytes_received;
> +
> +	bytes_received = prtd->bytes_received;
> +
> +	/**

/*

> +	 * Make sure that next track data pointer is aligned at 32 bit boundary
> +	 * This is a Mandatory requirement from DSP data buffers alignment
> +	 */
> +	if (prtd->next_track)
> +		bytes_received = ALIGN(prtd->bytes_received, prtd->pcm_count);
> +
> +	app_pointer = bytes_received/prtd->pcm_size;
> +	app_pointer = bytes_received -  (app_pointer * prtd->pcm_size);
> +	dstn = prtd->dma_buffer.area + app_pointer;
> +
> +	if (count < prtd->pcm_size - app_pointer) {
> +		if (copy_from_user(dstn, buf, count))
> +			return -EFAULT;
> +	} else {
> +		copy = prtd->pcm_size - app_pointer;
> +		if (copy_from_user(dstn, buf, copy))
> +			return -EFAULT;
> +		if (copy_from_user(prtd->dma_buffer.area, buf + copy,
> +				   count - copy))
> +			return -EFAULT;
> +	}


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2892177EF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 21:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgGGT0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 15:26:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:56354 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbgGGT0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:26:47 -0400
IronPort-SDR: 90PVq3A3svhlp41RH3g4hcyZ9QCu/1ZIzfgxt1G5suiW8bB/l5HXhdbyK++1yHcrg5OdPK/uMs
 6o0piXdB8bsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="135925959"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="135925959"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:26:47 -0700
IronPort-SDR: 9li1rqbK/QdwedKg4BVTGrrBeOzWqQZc81aCjJ7zwNf7tqs0nv+wlUeHkqg+KbHwLekN8Ao+Zg
 MYQFvRCrCaEQ==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="297493435"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO [10.254.77.62]) ([10.254.77.62])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:26:46 -0700
Subject: Re: [PATCH 06/11] ASoC: q6asm: add support to remove intial and
 trailing silence
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
 <20200707163641.17113-7-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <dd0d970e-109f-9a41-f2b9-a970e4d20caa@linux.intel.com>
Date:   Tue, 7 Jul 2020 11:55:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707163641.17113-7-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> +int q6asm_stream_remove_initial_silence(struct audio_client *ac,
> +					uint32_t stream_id,
> +					uint32_t initial_samples)
> +{
> +	return q6asm_stream_remove_silence(ac, stream_id,
> +					   ASM_DATA_CMD_REMOVE_INITIAL_SILENCE,
> +					   initial_samples);
> +}
> +EXPORT_SYMBOL_GPL(q6asm_stream_remove_initial_silence);
> +
> +int q6asm_stream_remove_trailing_silence(struct audio_client *ac, uint32_t stream_id,
> +					 uint32_t trailing_samples)
> +{
> +	return q6asm_stream_remove_silence(ac, stream_id,
> +				   ASM_DATA_CMD_REMOVE_TRAILING_SILENCE,
> +				   trailing_samples);
> +}
> +EXPORT_SYMBOL_GPL(q6asm_stream_remove_trailing_silence);

do you need those wrappers? Might as well call the _remove_silence() 
function with the right parameters, no?

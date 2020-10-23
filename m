Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAD2297595
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 19:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753134AbgJWRLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 13:11:35 -0400
Received: from foss.arm.com ([217.140.110.172]:57010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753127AbgJWRLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 13:11:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C70411FB;
        Fri, 23 Oct 2020 10:11:32 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22F4E3F719;
        Fri, 23 Oct 2020 10:11:31 -0700 (PDT)
Subject: Re: [PATCH v3 15/20] perf arm-spe: Remove size condition checking for
 events
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
References: <20201022145816.14069-1-leo.yan@linaro.org>
 <20201022145816.14069-16-leo.yan@linaro.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <d87b2f3b-e6f6-99aa-5a94-3ff348e8aaf4@arm.com>
Date:   Fri, 23 Oct 2020 18:10:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201022145816.14069-16-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2020 15:58, Leo Yan wrote:
> In the Armv8 ARM (ARM DDI 0487F.c), chapter "D10.2.6 Events packet", it
> describes the event bit is valid with specific payload requirement.  For
> example, the Last Level cache access event, the bit is defined as:
> 
>   E[8], byte 1 bit [0], when SZ == 0b01 , when SZ == 0b10 ,
>   		     or when SZ == 0b11
> 
> It requires the payload size is at least 2 bytes, when byte 1 (start
> counting from 0) is valid, E[8] (bit 0 in byte 1) can be used for LLC
> access event type.  For safety, the code checks the condition for
> payload size firstly, if meet the requirement for payload size, then
> continue to parse event type.
> 
> If review function arm_spe_get_payload(), it has used cast, so any bytes
> beyond the valid size have been set to zeros.
> 
> For this reason, we don't need to check payload size anymore afterwards
> when parse events, thus this patch removes payload size conditions.
> 
> Suggested-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Thanks, that looks better now!

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  .../util/arm-spe-decoder/arm-spe-decoder.c    |  9 ++----
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 30 +++++++++----------
>  2 files changed, 17 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> index 776b3e6628bb..a5d7509d5daa 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> @@ -178,16 +178,13 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>  			if (payload & BIT(EV_TLB_ACCESS))
>  				decoder->record.type |= ARM_SPE_TLB_ACCESS;
>  
> -			if ((idx == 2 || idx == 4 || idx == 8) &&
> -			    (payload & BIT(EV_LLC_MISS)))
> +			if (payload & BIT(EV_LLC_MISS))
>  				decoder->record.type |= ARM_SPE_LLC_MISS;
>  
> -			if ((idx == 2 || idx == 4 || idx == 8) &&
> -			    (payload & BIT(EV_LLC_ACCESS)))
> +			if (payload & BIT(EV_LLC_ACCESS))
>  				decoder->record.type |= ARM_SPE_LLC_ACCESS;
>  
> -			if ((idx == 2 || idx == 4 || idx == 8) &&
> -			    (payload & BIT(EV_REMOTE_ACCESS)))
> +			if (payload & BIT(EV_REMOTE_ACCESS))
>  				decoder->record.type |= ARM_SPE_REMOTE_ACCESS;
>  
>  			if (payload & BIT(EV_MISPRED))
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 58a1390b7a43..2cb019999016 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -317,22 +317,20 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
>  		if (ret < 0)
>  			return ret;
>  	}
> -	if (packet->index > 1) {
> -		if (payload & BIT(EV_LLC_ACCESS)) {
> -			ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-ACCESS");
> -			if (ret < 0)
> -				return ret;
> -		}
> -		if (payload & BIT(EV_LLC_MISS)) {
> -			ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-REFILL");
> -			if (ret < 0)
> -				return ret;
> -		}
> -		if (payload & BIT(EV_REMOTE_ACCESS)) {
> -			ret = arm_spe_pkt_snprintf(&buf, &blen, " REMOTE-ACCESS");
> -			if (ret < 0)
> -				return ret;
> -		}
> +	if (payload & BIT(EV_LLC_ACCESS)) {
> +		ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-ACCESS");
> +		if (ret < 0)
> +			return ret;
> +	}
> +	if (payload & BIT(EV_LLC_MISS)) {
> +		ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-REFILL");
> +		if (ret < 0)
> +			return ret;
> +	}
> +	if (payload & BIT(EV_REMOTE_ACCESS)) {
> +		ret = arm_spe_pkt_snprintf(&buf, &blen, " REMOTE-ACCESS");
> +		if (ret < 0)
> +			return ret;
>  	}
>  
>  	return buf_len - blen;
> 


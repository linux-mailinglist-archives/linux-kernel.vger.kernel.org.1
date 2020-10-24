Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BBC297A06
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 02:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755358AbgJXAdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 20:33:01 -0400
Received: from foss.arm.com ([217.140.110.172]:60406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754492AbgJXAdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 20:33:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87AA7113E;
        Fri, 23 Oct 2020 17:33:00 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4C393F719;
        Fri, 23 Oct 2020 17:32:58 -0700 (PDT)
Subject: Re: [PATCH v3 13/20] perf arm-spe: Add new function
 arm_spe_pkt_desc_event()
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
 <20201022145816.14069-14-leo.yan@linaro.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <97a6bc9a-eeda-bb55-fc2c-1c9b600e3365@arm.com>
Date:   Sat, 24 Oct 2020 01:32:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201022145816.14069-14-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2020 15:58, Leo Yan wrote:

Hi,

> This patch moves out the event packet parsing from arm_spe_pkt_desc()
> to the new function arm_spe_pkt_desc_event().
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

diff -w says this is correct, so:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks!
Andre

> ---
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 136 ++++++++++--------
>  1 file changed, 73 insertions(+), 63 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 6eebd30f3d78..8a6b50f32a52 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -266,6 +266,78 @@ static int arm_spe_pkt_snprintf(char **buf_p, size_t *blen,
>  	return ret;
>  }
>  
> +static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
> +				  char *buf, size_t buf_len)
> +{
> +	u64 payload = packet->payload;
> +	size_t blen = buf_len;
> +	int ret;
> +
> +	ret = arm_spe_pkt_snprintf(&buf, &blen, "EV");
> +	if (ret < 0)
> +		return ret;
> +
> +	if (payload & 0x1) {
> +		ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCEPTION-GEN");
> +		if (ret < 0)
> +			return ret;
> +	}
> +	if (payload & 0x2) {
> +		ret = arm_spe_pkt_snprintf(&buf, &blen, " RETIRED");
> +		if (ret < 0)
> +			return ret;
> +	}
> +	if (payload & 0x4) {
> +		ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-ACCESS");
> +		if (ret < 0)
> +			return ret;
> +	}
> +	if (payload & 0x8) {
> +		ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-REFILL");
> +		if (ret < 0)
> +			return ret;
> +	}
> +	if (payload & 0x10) {
> +		ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-ACCESS");
> +		if (ret < 0)
> +			return ret;
> +	}
> +	if (payload & 0x20) {
> +		ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-REFILL");
> +		if (ret < 0)
> +			return ret;
> +	}
> +	if (payload & 0x40) {
> +		ret = arm_spe_pkt_snprintf(&buf, &blen, " NOT-TAKEN");
> +		if (ret < 0)
> +			return ret;
> +	}
> +	if (payload & 0x80) {
> +		ret = arm_spe_pkt_snprintf(&buf, &blen, " MISPRED");
> +		if (ret < 0)
> +			return ret;
> +	}
> +	if (packet->index > 1) {
> +		if (payload & 0x100) {
> +			ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-ACCESS");
> +			if (ret < 0)
> +				return ret;
> +		}
> +		if (payload & 0x200) {
> +			ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-REFILL");
> +			if (ret < 0)
> +				return ret;
> +		}
> +		if (payload & 0x400) {
> +			ret = arm_spe_pkt_snprintf(&buf, &blen, " REMOTE-ACCESS");
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
> +	return buf_len - blen;
> +}
> +
>  static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
>  				 char *buf, size_t buf_len)
>  {
> @@ -344,69 +416,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  	case ARM_SPE_END:
>  		return arm_spe_pkt_snprintf(&buf, &blen, "%s", name);
>  	case ARM_SPE_EVENTS:
> -		ret = arm_spe_pkt_snprintf(&buf, &blen, "EV");
> -		if (ret < 0)
> -			return ret;
> -
> -		if (payload & 0x1) {
> -			ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCEPTION-GEN");
> -			if (ret < 0)
> -				return ret;
> -		}
> -		if (payload & 0x2) {
> -			ret = arm_spe_pkt_snprintf(&buf, &blen, " RETIRED");
> -			if (ret < 0)
> -				return ret;
> -		}
> -		if (payload & 0x4) {
> -			ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-ACCESS");
> -			if (ret < 0)
> -				return ret;
> -		}
> -		if (payload & 0x8) {
> -			ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-REFILL");
> -			if (ret < 0)
> -				return ret;
> -		}
> -		if (payload & 0x10) {
> -			ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-ACCESS");
> -			if (ret < 0)
> -				return ret;
> -		}
> -		if (payload & 0x20) {
> -			ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-REFILL");
> -			if (ret < 0)
> -				return ret;
> -		}
> -		if (payload & 0x40) {
> -			ret = arm_spe_pkt_snprintf(&buf, &blen, " NOT-TAKEN");
> -			if (ret < 0)
> -				return ret;
> -		}
> -		if (payload & 0x80) {
> -			ret = arm_spe_pkt_snprintf(&buf, &blen, " MISPRED");
> -			if (ret < 0)
> -				return ret;
> -		}
> -		if (idx > 1) {
> -			if (payload & 0x100) {
> -				ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-ACCESS");
> -				if (ret < 0)
> -					return ret;
> -			}
> -			if (payload & 0x200) {
> -				ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-REFILL");
> -				if (ret < 0)
> -					return ret;
> -			}
> -			if (payload & 0x400) {
> -				ret = arm_spe_pkt_snprintf(&buf, &blen, " REMOTE-ACCESS");
> -				if (ret < 0)
> -					return ret;
> -			}
> -		}
> -		return buf_len - blen;
> -
> +		return arm_spe_pkt_desc_event(packet, buf, buf_len);
>  	case ARM_SPE_OP_TYPE:
>  		switch (idx) {
>  		case 0:
> 


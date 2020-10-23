Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2C9297594
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 19:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753124AbgJWRLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 13:11:14 -0400
Received: from foss.arm.com ([217.140.110.172]:56990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753117AbgJWRLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 13:11:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 430121FB;
        Fri, 23 Oct 2020 10:11:12 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90F803F719;
        Fri, 23 Oct 2020 10:11:10 -0700 (PDT)
Subject: Re: [PATCH v3 11/20] perf arm-spe: Add new function
 arm_spe_pkt_desc_counter()
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
 <20201022145816.14069-12-leo.yan@linaro.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <5845e1fb-57ed-0883-b477-7f3d4a521d31@arm.com>
Date:   Fri, 23 Oct 2020 18:10:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201022145816.14069-12-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2020 15:58, Leo Yan wrote:
> This patch moves out the counter packet parsing code from
> arm_spe_pkt_desc() to the new function arm_spe_pkt_desc_counter().
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Confirmed by diff'ing '-' vs. '+' to not introduce an actual change.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 64 +++++++++++--------
>  1 file changed, 37 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 1fc07c693640..023bcc9be3cc 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -293,6 +293,42 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
>  	}
>  }
>  
> +static int arm_spe_pkt_desc_counter(const struct arm_spe_pkt *packet,
> +				    char *buf, size_t buf_len)
> +{
> +	u64 payload = packet->payload;
> +	const char *name = arm_spe_pkt_name(packet->type);
> +	size_t blen = buf_len;
> +	int ret;
> +
> +	ret = arm_spe_pkt_snprintf(&buf, &blen, "%s %d ", name,
> +				   (unsigned short)payload);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (packet->index) {
> +	case 0:
> +		ret = arm_spe_pkt_snprintf(&buf, &blen, "TOT");
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	case 1:
> +		ret = arm_spe_pkt_snprintf(&buf, &blen, "ISSUE");
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	case 2:
> +		ret = arm_spe_pkt_snprintf(&buf, &blen, "XLAT");
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return buf_len - blen;
> +}
> +
>  int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  		     size_t buf_len)
>  {
> @@ -435,33 +471,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  		return arm_spe_pkt_snprintf(&buf, &blen, "%s 0x%lx el%d",
>  					    name, (unsigned long)payload, idx + 1);
>  	case ARM_SPE_COUNTER:
> -		ret = arm_spe_pkt_snprintf(&buf, &blen, "%s %d ", name,
> -					   (unsigned short)payload);
> -		if (ret < 0)
> -			return ret;
> -
> -		switch (idx) {
> -		case 0:
> -			ret = arm_spe_pkt_snprintf(&buf, &blen, "TOT");
> -			if (ret < 0)
> -				return ret;
> -			break;
> -		case 1:
> -			ret = arm_spe_pkt_snprintf(&buf, &blen, "ISSUE");
> -			if (ret < 0)
> -				return ret;
> -			break;
> -		case 2:
> -			ret = arm_spe_pkt_snprintf(&buf, &blen, "XLAT");
> -			if (ret < 0)
> -				return ret;
> -			break;
> -		default:
> -			break;
> -		}
> -
> -		return buf_len - blen;
> -
> +		return arm_spe_pkt_desc_counter(packet, buf, buf_len);
>  	default:
>  		break;
>  	}
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E382AC167
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbgKIQwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:52:41 -0500
Received: from foss.arm.com ([217.140.110.172]:42844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729776AbgKIQwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:52:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA6FB31B;
        Mon,  9 Nov 2020 08:52:39 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82C9B3F719;
        Mon,  9 Nov 2020 08:52:37 -0800 (PST)
Subject: Re: [PATCH v7 07/22] perf arm-spe: Consolidate arm_spe_pkt_desc()'s
 return value
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Al Grant <Al.Grant@arm.com>, Wei Li <liwei391@huawei.com>,
        linux-kernel@vger.kernel.org
References: <20201106014136.14103-1-leo.yan@linaro.org>
 <20201106014136.14103-8-leo.yan@linaro.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <478837ab-5477-ef17-fe6a-6ea24311d904@arm.com>
Date:   Mon, 9 Nov 2020 16:52:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201106014136.14103-8-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2020 01:41, Leo Yan wrote:
> arm_spe_pkt_desc() returns the length of consumed the buffer for
> the success case; otherwise, it delivers the return value from
> arm_spe_pkt_snprintf(), and returns the last return value if there have
> multiple calling arm_spe_pkt_snprintf().
> 
> Since arm_spe_pkt_snprintf() has the same semantics with vsnprintf() for
> the return value, and vsnprintf() might return value equals to or bigger
> than the parameter 'size' to indicate the truncation.  Because the
> return value is >= 0 when the string is truncated, this condition will
> be returned up the stack as "success".
> 
> This patch simplifies the return value for arm_spe_pkt_desc(): '0' means
> success and other values mean an error has occurred.  To realize this,
> it relies on arm_spe_pkt_snprintf()'s parameter 'err', the 'err' is a
> cumulative value, returns its final value if printing buffer is called
> for one time or multiple times.
> 
> To unify the error value generation, this patch handles error in a
> central place, rather than directly bailing out in switch-cases,
> it returns error at the end of arm_spe_pkt_desc().

And the but-last hunk means it will basically always return 0?
Just checking, it's probably fine (and I don't want to review a v8 ;-)

> This patch changes the caller arm_spe_dump() to respect the updated
> return value semantics of arm_spe_pkt_desc().
> 
> Suggested-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

One tiny thing below ...

> ---
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 128 +++++++++---------
>  tools/perf/util/arm-spe.c                     |   2 +-
>  2 files changed, 68 insertions(+), 62 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 1970686f7020..33baef0c2c0b 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -301,9 +301,10 @@ static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
>  int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  		     size_t buf_len)
>  {
> -	int ret, ns, el, idx = packet->index;
> +	int ns, el, idx = packet->index;
>  	unsigned long long payload = packet->payload;
>  	const char *name = arm_spe_pkt_name(packet->type);
> +	char *buf_orig = buf;
>  	size_t blen = buf_len;
>  	int err = 0;
>  
> @@ -311,82 +312,76 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  	case ARM_SPE_BAD:
>  	case ARM_SPE_PAD:
>  	case ARM_SPE_END:
> -		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s", name);
> +		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s", name);
> +		break;
>  	case ARM_SPE_EVENTS:
> -		ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "EV");
> +		arm_spe_pkt_snprintf(&err, &buf, &blen, "EV");
>  
>  		if (payload & 0x1)
> -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCEPTION-GEN");
> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCEPTION-GEN");
>  		if (payload & 0x2)
> -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " RETIRED");
> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " RETIRED");
>  		if (payload & 0x4)
> -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-ACCESS");
> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-ACCESS");
>  		if (payload & 0x8)
> -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-REFILL");
> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-REFILL");
>  		if (payload & 0x10)
> -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-ACCESS");
> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-ACCESS");
>  		if (payload & 0x20)
> -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-REFILL");
> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-REFILL");
>  		if (payload & 0x40)
> -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " NOT-TAKEN");
> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " NOT-TAKEN");
>  		if (payload & 0x80)
> -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " MISPRED");
> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " MISPRED");
>  		if (idx > 1) {
>  			if (payload & 0x100)
> -				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-ACCESS");
> +				arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-ACCESS");
>  			if (payload & 0x200)
> -				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-REFILL");
> +				arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-REFILL");
>  			if (payload & 0x400)
> -				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " REMOTE-ACCESS");
> +				arm_spe_pkt_snprintf(&err, &buf, &blen, " REMOTE-ACCESS");
>  		}
> -		if (ret < 0)
> -			return ret;
> -		blen -= ret;
> -		return buf_len - blen;
> +		break;
>  	case ARM_SPE_OP_TYPE:
>  		switch (idx) {
>  		case 0:
> -			return arm_spe_pkt_snprintf(&err, &buf, &blen,
> +			arm_spe_pkt_snprintf(&err, &buf, &blen,
>  					payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
> +			break;
>  		case 1:
> -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen,
> -						   payload & 0x1 ? "ST" : "LD");
> +			arm_spe_pkt_snprintf(&err, &buf, &blen,
> +					     payload & 0x1 ? "ST" : "LD");
>  
>  			if (payload & 0x2) {
>  				if (payload & 0x4)
> -					ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " AT");
> +					arm_spe_pkt_snprintf(&err, &buf, &blen, " AT");
>  				if (payload & 0x8)
> -					ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCL");
> +					arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCL");
>  				if (payload & 0x10)
> -					ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " AR");
> +					arm_spe_pkt_snprintf(&err, &buf, &blen, " AR");
>  			} else if (payload & 0x4) {
> -				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " SIMD-FP");
> +				arm_spe_pkt_snprintf(&err, &buf, &blen, " SIMD-FP");
>  			}
> -
> -			if (ret < 0)
> -				return ret;
> -			blen -= ret;
> -			return buf_len - blen;
> -
> +			break;
>  		case 2:
> -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "B");
> +			arm_spe_pkt_snprintf(&err, &buf, &blen, "B");
>  
>  			if (payload & 0x1)
> -				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " COND");
> +				arm_spe_pkt_snprintf(&err, &buf, &blen, " COND");
>  			if (payload & 0x2)
> -				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " IND");
> -
> -			if (ret < 0)
> -				return ret;
> -			blen -= ret;
> -			return buf_len - blen;
> +				arm_spe_pkt_snprintf(&err, &buf, &blen, " IND");
>  
> +			break;
>  		default:
> -			return 0;
> +			/* Unknown index */
> +			err = -1;
> +			break;
>  		}
> +		break;
>  	case ARM_SPE_DATA_SOURCE:
>  	case ARM_SPE_TIMESTAMP:
> -		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %lld", name, payload);
> +		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %lld", name, payload);
> +		break;
>  	case ARM_SPE_ADDRESS:
>  		switch (idx) {
>  		case 0:
> @@ -394,48 +389,59 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  			ns = !!(packet->payload & NS_FLAG);
>  			el = (packet->payload & EL_FLAG) >> 61;
>  			payload &= ~(0xffULL << 56);
> -			return arm_spe_pkt_snprintf(&err, &buf, &blen,
> +			arm_spe_pkt_snprintf(&err, &buf, &blen,
>  					"%s 0x%llx el%d ns=%d",
>  				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
> +			break;
>  		case 2:
> -			return arm_spe_pkt_snprintf(&err, &buf, &blen,
> -						    "VA 0x%llx", payload);
> +			arm_spe_pkt_snprintf(&err, &buf, &blen,
> +					     "VA 0x%llx", payload);
> +			break;
>  		case 3:
>  			ns = !!(packet->payload & NS_FLAG);
>  			payload &= ~(0xffULL << 56);
> -			return arm_spe_pkt_snprintf(&err, &buf, &blen,
> -						    "PA 0x%llx ns=%d", payload, ns);
> +			arm_spe_pkt_snprintf(&err, &buf, &blen,
> +					     "PA 0x%llx ns=%d", payload, ns);
> +			break;
>  		default:
> -			return 0;
> +			/* Unknown index */
> +			err = -1;
> +			break;
>  		}
> +		break;
>  	case ARM_SPE_CONTEXT:
> -		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%lx el%d",
> -					    name, (unsigned long)payload, idx + 1);
> +		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%lx el%d",
> +				     name, (unsigned long)payload, idx + 1);
> +		break;
>  	case ARM_SPE_COUNTER:
> -		ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %d ", name,
> -					   (unsigned short)payload);
> +		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %d ", name,
> +				     (unsigned short)payload);
>  		switch (idx) {
>  		case 0:
> -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "TOT");
> +			arm_spe_pkt_snprintf(&err, &buf, &blen, "TOT");
>  			break;
>  		case 1:
> -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "ISSUE");
> +			arm_spe_pkt_snprintf(&err, &buf, &blen, "ISSUE");
>  			break;
>  		case 2:
> -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "XLAT");
> +			arm_spe_pkt_snprintf(&err, &buf, &blen, "XLAT");
>  			break;
>  		default:
> -			ret = 0;
>  			break;
>  		}
> -		if (ret < 0)
> -			return ret;
> -		blen -= ret;
> -		return buf_len - blen;
> +		break;
>  	default:
> +		/* Unknown index */
> +		err = -1;
>  		break;
>  	}
>  
> -	return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%llx (%d)",
> -				    name, payload, packet->index);
> +	/* Output raw data if detect any error */
> +	if (err) {
> +		err = 0;
> +		arm_spe_pkt_snprintf(&err, &buf_orig, &blen, "%s 0x%llx (%d)",

That needs to be &buf_len here, doesn't it?

With that fixed:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> +				     name, payload, packet->index);
> +	}
> +
> +	return err;
>  }
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 3882a5360ada..8901a1656a41 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -113,7 +113,7 @@ static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
>  		if (ret > 0) {
>  			ret = arm_spe_pkt_desc(&packet, desc,
>  					       ARM_SPE_PKT_DESC_MAX);
> -			if (ret > 0)
> +			if (!ret)
>  				color_fprintf(stdout, color, " %s\n", desc);
>  		} else {
>  			color_fprintf(stdout, color, " Bad packet!\n");
> 


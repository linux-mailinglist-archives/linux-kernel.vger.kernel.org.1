Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9B7297597
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 19:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbgJWRLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 13:11:48 -0400
Received: from foss.arm.com ([217.140.110.172]:57030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753137AbgJWRLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 13:11:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 234961FB;
        Fri, 23 Oct 2020 10:11:46 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73B853F719;
        Fri, 23 Oct 2020 10:11:44 -0700 (PDT)
Subject: Re: [PATCH v3 16/20] perf arm-spe: Add new function
 arm_spe_pkt_desc_op_type()
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
 <20201022145816.14069-17-leo.yan@linaro.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <53edb27d-bfa5-7e84-0f6e-ab721c65f457@arm.com>
Date:   Fri, 23 Oct 2020 18:10:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201022145816.14069-17-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2020 15:58, Leo Yan wrote:

Hi,

> The operation type packet is complex and contains subclass; the parsing
> flow causes deep indentation; for more readable, this patch introduces
> a new function arm_spe_pkt_desc_op_type() which is used for operation
> type parsing.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Compared '-' and '+' with diff -w, no changes.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks,
Andre

> ---
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 122 ++++++++++--------
>  1 file changed, 66 insertions(+), 56 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 2cb019999016..19d05d9734ab 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -336,6 +336,70 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
>  	return buf_len - blen;
>  }
>  
> +static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
> +				    char *buf, size_t buf_len)
> +{
> +	int ret, idx = packet->index;
> +	unsigned long long payload = packet->payload;
> +	size_t blen = buf_len;
> +
> +	switch (idx) {
> +	case 0:
> +		return arm_spe_pkt_snprintf(&buf, &blen,
> +				payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
> +	case 1:
> +		ret = arm_spe_pkt_snprintf(&buf, &blen,
> +					   payload & 0x1 ? "ST" : "LD");
> +		if (ret < 0)
> +			return ret;
> +
> +		if (payload & 0x2) {
> +			if (payload & 0x4) {
> +				ret = arm_spe_pkt_snprintf(&buf, &blen, " AT");
> +				if (ret < 0)
> +					return ret;
> +			}
> +			if (payload & 0x8) {
> +				ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCL");
> +				if (ret < 0)
> +					return ret;
> +			}
> +			if (payload & 0x10) {
> +				ret = arm_spe_pkt_snprintf(&buf, &blen, " AR");
> +				if (ret < 0)
> +					return ret;
> +			}
> +		} else if (payload & 0x4) {
> +			ret = arm_spe_pkt_snprintf(&buf, &blen, " SIMD-FP");
> +			if (ret < 0)
> +				return ret;
> +		}
> +
> +		return buf_len - blen;
> +
> +	case 2:
> +		ret = arm_spe_pkt_snprintf(&buf, &blen, "B");
> +		if (ret < 0)
> +			return ret;
> +
> +		if (payload & 0x1) {
> +			ret = arm_spe_pkt_snprintf(&buf, &blen, " COND");
> +			if (ret < 0)
> +				return ret;
> +		}
> +		if (payload & 0x2) {
> +			ret = arm_spe_pkt_snprintf(&buf, &blen, " IND");
> +			if (ret < 0)
> +				return ret;
> +		}
> +
> +		return buf_len - blen;
> +
> +	default:
> +		return 0;
> +	}
> +}
> +
>  static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
>  				 char *buf, size_t buf_len)
>  {
> @@ -403,7 +467,7 @@ static int arm_spe_pkt_desc_counter(const struct arm_spe_pkt *packet,
>  int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  		     size_t buf_len)
>  {
> -	int ret, idx = packet->index;
> +	int idx = packet->index;
>  	unsigned long long payload = packet->payload;
>  	const char *name = arm_spe_pkt_name(packet->type);
>  	size_t blen = buf_len;
> @@ -416,61 +480,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  	case ARM_SPE_EVENTS:
>  		return arm_spe_pkt_desc_event(packet, buf, buf_len);
>  	case ARM_SPE_OP_TYPE:
> -		switch (idx) {
> -		case 0:
> -			return arm_spe_pkt_snprintf(&buf, &blen,
> -					payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
> -		case 1:
> -			ret = arm_spe_pkt_snprintf(&buf, &blen,
> -						   payload & 0x1 ? "ST" : "LD");
> -			if (ret < 0)
> -				return ret;
> -
> -			if (payload & 0x2) {
> -				if (payload & 0x4) {
> -					ret = arm_spe_pkt_snprintf(&buf, &blen, " AT");
> -					if (ret < 0)
> -						return ret;
> -				}
> -				if (payload & 0x8) {
> -					ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCL");
> -					if (ret < 0)
> -						return ret;
> -				}
> -				if (payload & 0x10) {
> -					ret = arm_spe_pkt_snprintf(&buf, &blen, " AR");
> -					if (ret < 0)
> -						return ret;
> -				}
> -			} else if (payload & 0x4) {
> -				ret = arm_spe_pkt_snprintf(&buf, &blen, " SIMD-FP");
> -				if (ret < 0)
> -					return ret;
> -			}
> -
> -			return buf_len - blen;
> -
> -		case 2:
> -			ret = arm_spe_pkt_snprintf(&buf, &blen, "B");
> -			if (ret < 0)
> -				return ret;
> -
> -			if (payload & 0x1) {
> -				ret = arm_spe_pkt_snprintf(&buf, &blen, " COND");
> -				if (ret < 0)
> -					return ret;
> -			}
> -			if (payload & 0x2) {
> -				ret = arm_spe_pkt_snprintf(&buf, &blen, " IND");
> -				if (ret < 0)
> -					return ret;
> -			}
> -
> -			return buf_len - blen;
> -
> -		default:
> -			return 0;
> -		}
> +		return arm_spe_pkt_desc_op_type(packet, buf, buf_len);
>  	case ARM_SPE_DATA_SOURCE:
>  	case ARM_SPE_TIMESTAMP:
>  		return arm_spe_pkt_snprintf(&buf, &blen, "%s %lld", name, payload);
> 


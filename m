Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AA729951F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789496AbgJZSSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:18:22 -0400
Received: from foss.arm.com ([217.140.110.172]:47220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1789488AbgJZSSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:18:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0F89139F;
        Mon, 26 Oct 2020 11:18:19 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3E9F3F66E;
        Mon, 26 Oct 2020 11:18:17 -0700 (PDT)
Subject: Re: [PATCH v3 20/20] perf arm-spe: Add support for ARMv8.3-SPE
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
 <20201022145816.14069-21-leo.yan@linaro.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <c4baccf4-2ecd-1633-ec87-0f4911cbdc50@arm.com>
Date:   Mon, 26 Oct 2020 18:17:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201022145816.14069-21-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2020 15:58, Leo Yan wrote:

Hi,

> From: Wei Li <liwei391@huawei.com>
> 
> This patch is to support Armv8.3 extension for SPE, it adds alignment
> field in the Events packet and it supports the Scalable Vector Extension
> (SVE) for Operation packet and Events packet with two additions:
> 
>   - The vector length for SVE operations in the Operation Type packet;
>   - The incomplete predicate and empty predicate fields in the Events
>     packet.
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 74 ++++++++++++++++++-
>  .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 18 +++++
>  2 files changed, 90 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 74ac12cbec69..6da4cfbc9914 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -332,6 +332,21 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
>  		if (ret < 0)
>  			return ret;
>  	}
> +	if (payload & BIT(EV_ALIGNMENT)) {
> +		ret = arm_spe_pkt_snprintf(&buf, &blen, " ALIGNMENT");
> +		if (ret < 0)
> +			return ret;
> +	}
> +	if (payload & BIT(EV_PARTIAL_PREDICATE)) {
> +		ret = arm_spe_pkt_snprintf(&buf, &blen, " SVE-PARTIAL-PRED");
> +		if (ret < 0)
> +			return ret;
> +	}
> +	if (payload & BIT(EV_EMPTY_PREDICATE)) {
> +		ret = arm_spe_pkt_snprintf(&buf, &blen, " SVE-EMPTY-PRED");
> +		if (ret < 0)
> +			return ret;
> +	}
>  
>  	return buf_len - blen;
>  }
> @@ -345,8 +360,43 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
>  
>  	switch (class) {
>  	case SPE_OP_PKT_HDR_CLASS_OTHER:
> -		return arm_spe_pkt_snprintf(&buf, &blen,
> -			payload & SPE_OP_PKT_COND ? "COND-SELECT" : "INSN-OTHER");
> +		if (SPE_OP_PKT_OTHER_SUBCLASS_SVE_OP_GET(payload) ==
> +				SPE_OP_PKT_OTHER_SUBCLASS_SVE_OP) {

Same comment as in the other patch, can you combine those two into one
symbol?

> +
> +			ret = arm_spe_pkt_snprintf(&buf, &blen, "SVE-OTHER");
> +			if (ret < 0)
> +				return ret;
> +
> +			/* SVE effective vector length */
> +			ret = arm_spe_pkt_snprintf(&buf, &blen, " EVLEN %d",
> +						   SPE_OP_PKG_SVE_EVL(payload));
> +			if (ret < 0)
> +				return ret;
> +
> +			if (payload & SPE_OP_PKT_SVE_FP) {
> +				ret = arm_spe_pkt_snprintf(&buf, &blen, " FP");
> +				if (ret < 0)
> +					return ret;
> +			}
> +			if (payload & SPE_OP_PKT_SVE_PRED) {
> +				ret = arm_spe_pkt_snprintf(&buf, &blen, " PRED");
> +				if (ret < 0)
> +					return ret;
> +			}
> +		} else {
> +			ret = arm_spe_pkt_snprintf(&buf, &blen, "OTHER");
> +			if (ret < 0)
> +				return ret;
> +
> +			ret = arm_spe_pkt_snprintf(&buf, &blen, " %s",
> +					payload & SPE_OP_PKT_COND ?
> +					"COND-SELECT" : "INSN-OTHER");
> +			if (ret < 0)
> +				return ret;
> +		}
> +
> +		return buf_len - blen;
> +
>  	case SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC:
>  		ret = arm_spe_pkt_snprintf(&buf, &blen,
>  					   payload & SPE_OP_PKT_ST ? "ST" : "LD");
> @@ -401,6 +451,26 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
>  			break;
>  		}
>  
> +		if (SPE_OP_PKT_LDST_SUBCLASS_SVE_GET(payload) ==
> +				SPE_OP_PKT_LDST_SUBCLASS_SVE) {

Same here, could be combined into one symbol.

> +			/* SVE effective vector length */
> +			ret = arm_spe_pkt_snprintf(&buf, &blen, " EVLEN %d",
> +						   SPE_OP_PKG_SVE_EVL(payload));
> +			if (ret < 0)
> +				return ret;
> +
> +			if (payload & SPE_OP_PKT_SVE_PRED) {
> +				ret = arm_spe_pkt_snprintf(&buf, &blen, " PRED");
> +				if (ret < 0)
> +					return ret;
> +			}
> +			if (payload & SPE_OP_PKT_SVE_SG) {
> +				ret = arm_spe_pkt_snprintf(&buf, &blen, " SG");
> +				if (ret < 0)
> +					return ret;
> +			}
> +		}
> +
>  		return buf_len - blen;
>  
>  	case SPE_OP_PKT_HDR_CLASS_BR_ERET:
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> index d69af0d618ea..04bc09f3ea17 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> @@ -118,6 +118,9 @@ enum arm_spe_events {
>  #define SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC	0x1
>  #define SPE_OP_PKT_HDR_CLASS_BR_ERET		0x2
>  
> +#define SPE_OP_PKT_OTHER_SUBCLASS_SVE_OP_GET(v)	((v) & (BIT(7) | BIT(3) | BIT(0)))
> +#define SPE_OP_PKT_OTHER_SUBCLASS_SVE_OP	0x8
> +
>  #define SPE_OP_PKT_COND				BIT(0)
>  
>  #define SPE_OP_PKT_LDST_SUBCLASS_GET(v)		((v) & GENMASK_ULL(7, 1))
> @@ -134,6 +137,21 @@ enum arm_spe_events {
>  #define SPE_OP_PKT_AT				BIT(2)
>  #define SPE_OP_PKT_ST				BIT(0)
>  
> +#define SPE_OP_PKT_LDST_SUBCLASS_SVE_GET(v)	((v) & (GENMASK_ULL(3, 3) | GENMASK_ULL(1, 1)))
> +#define SPE_OP_PKT_LDST_SUBCLASS_SVE		0x8
> +
> +#define SPE_OP_PKT_SVE_SG			BIT(7)
> +/*
> + * SVE effective vector length (EVL) is stored in byte 0 bits [6:4];
> + * the length is rounded up to a power of two and use 32 as one step,
> + * so EVL calculation is:
> + *
> + *   32 * (2 ^ bits [6:4]) = 32 << (bits [6:4])
> + */

Thanks for adding the comment!

Cheers,
Andre

> +#define SPE_OP_PKG_SVE_EVL(v)			(32 << (((v) & GENMASK_ULL(6, 4)) >> 4))
> +#define SPE_OP_PKT_SVE_PRED			BIT(2)
> +#define SPE_OP_PKT_SVE_FP			BIT(1)
> +
>  #define SPE_OP_PKT_BRANCH_SUBCLASS_GET(v)	((v) & GENMASK_ULL(7, 1))
>  #define SPE_OP_PKT_BRANCH_SUBCLASS_DIRECT	0x0
>  #define SPE_OP_PKT_BRANCH_SUBCLASS_INDIRECT	0x2
> 


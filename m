Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428052944C1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 23:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410028AbgJTVzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 17:55:37 -0400
Received: from foss.arm.com ([217.140.110.172]:56504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392448AbgJTVzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 17:55:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A23581FB;
        Tue, 20 Oct 2020 14:55:35 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED1253F66B;
        Tue, 20 Oct 2020 14:55:33 -0700 (PDT)
Subject: Re: [PATCH v2 14/14] perf arm-spe: Add support for ARMv8.3-SPE
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org, Al Grant <Al.Grant@arm.com>
References: <20200929133917.9224-1-leo.yan@linaro.org>
 <20200929133917.9224-15-leo.yan@linaro.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <9c74082b-fccf-7713-b98d-50da76c5d7af@arm.com>
Date:   Tue, 20 Oct 2020 22:54:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200929133917.9224-15-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2020 14:39, Leo Yan wrote:

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
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 84 ++++++++++++++++++-
>  .../arm-spe-decoder/arm-spe-pkt-decoder.h     |  6 ++
>  2 files changed, 87 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 05a4c74399d7..3ec381fddfcb 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -342,14 +342,73 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  					return ret;
>  			}
>  		}
> +		if (idx > 2) {

As I mentioned in the other patch, I doubt this extra comparison is
useful. Does that protect us from anything?

> +			if (payload & SPE_EVT_PKT_ALIGNMENT) {

Mmh, but this is bit 11, right? So would need to go into the (idx > 1)
section (covering bits 8-15)? Another reason to ditch this comparison above.

> +				ret = snprintf(buf, buf_len, " ALIGNMENT");
> +				if (ret < 0)
> +					return ret;
> +				buf += ret;
> +				blen -= ret;

Shouldn't we use the new arm_spe_pkt_snprintf() function here as well?
Or is there a reason that this doesn't work?

> +			}
> +			if (payload & SPE_EVT_PKT_SVE_PARTIAL_PREDICATE) {
> +				ret = snprintf(buf, buf_len, " SVE-PARTIAL-PRED");
> +				if (ret < 0)
> +					return ret;
> +				buf += ret;
> +				blen -= ret;
> +			}
> +			if (payload & SPE_EVT_PKT_SVE_EMPTY_PREDICATE) {
> +				ret = snprintf(buf, buf_len, " SVE-EMPTY-PRED");
> +				if (ret < 0)
> +					return ret;
> +				buf += ret;
> +				blen -= ret;
> +			}
> +		}
> +
>  		return buf_len - blen;
>  
>  	case ARM_SPE_OP_TYPE:
>  		switch (idx) {
>  		case SPE_OP_PKT_HDR_CLASS_OTHER:
> -			return arm_spe_pkt_snprintf(&buf, &blen,
> -					payload & SPE_OP_PKT_OTHER_SUBCLASS_COND ?
> -					"COND-SELECT" : "INSN-OTHER");
> +			if ((payload & SPE_OP_PKT_OTHER_SVE_SUBCLASS_MASK) ==
> +					SPE_OP_PKT_OTHER_SUBCLASS_SVG_OP) {
> +
> +				ret = arm_spe_pkt_snprintf(&buf, &blen, "SVE-OTHER");
> +				if (ret < 0)
> +					return ret;
> +
> +				/* Effective vector length: step is 32 bits */
> +				ret = arm_spe_pkt_snprintf(&buf, &blen, " EVLEN %d",
> +					32 << ((payload & SPE_OP_PKT_SVE_EVL_MASK) >>
> +						SPE_OP_PKT_SVE_EVL_SHIFT));

Can you move this into a macro, and add a comment about how this works?
People might get confused over the "32 << something".

Cheers,
Andre

> +				if (ret < 0)
> +					return ret;
> +
> +				if (payload & SPE_OP_PKT_SVE_FP) {
> +					ret = arm_spe_pkt_snprintf(&buf, &blen, " FP");
> +					if (ret < 0)
> +						return ret;
> +				}
> +				if (payload & SPE_OP_PKT_SVE_PRED) {
> +					ret = arm_spe_pkt_snprintf(&buf, &blen, " PRED");
> +					if (ret < 0)
> +						return ret;
> +				}
> +			} else {
> +				ret = arm_spe_pkt_snprintf(&buf, &blen, "OTHER");
> +				if (ret < 0)
> +					return ret;
> +
> +				ret = arm_spe_pkt_snprintf(&buf, &blen, " %s",
> +					       payload & SPE_OP_PKT_OTHER_SUBCLASS_COND ?
> +					       "COND-SELECT" : "UNCOND");
> +				if (ret < 0)
> +					return ret;
> +			}
> +
> +			return buf_len - blen;
> +
>  		case SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC:
>  			ret = arm_spe_pkt_snprintf(&buf, &blen,
>  						   payload & SPE_OP_PKT_LDST ?
> @@ -394,6 +453,25 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  				ret = arm_spe_pkt_snprintf(&buf, &blen, " NV-SYSREG");
>  				if (ret < 0)
>  					return ret;
> +			} else if ((payload & SPE_OP_PKT_LDST_SUBCLASS_SVE_MASK) ==
> +					SPE_OP_PKT_LDST_SUBCLASS_SVE) {
> +				/* Effective vector length: step is 32 bits */
> +				ret = arm_spe_pkt_snprintf(&buf, &blen, " EVLEN %d",
> +					32 << ((payload & SPE_OP_PKT_SVE_EVL_MASK) >>
> +						SPE_OP_PKT_SVE_EVL_SHIFT));
> +				if (ret < 0)
> +					return ret;
> +
> +				if (payload & SPE_OP_PKT_SVE_PRED) {
> +					ret = arm_spe_pkt_snprintf(&buf, &blen, " PRED");
> +					if (ret < 0)
> +						return ret;
> +				}
> +				if (payload & SPE_OP_PKT_SVE_SG) {
> +					ret = arm_spe_pkt_snprintf(&buf, &blen, " SG");
> +					if (ret < 0)
> +						return ret;
> +				}
>  			}
>  
>  			return buf_len - blen;
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> index 1847cad517db..80266bfebec2 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> @@ -147,6 +147,12 @@ struct arm_spe_pkt {
>  #define SPE_OP_PKT_LDST_SUBCLASS_SVE_MASK	(GENMASK_ULL(3, 3) | GENMASK_ULL(1, 1))
>  #define SPE_OP_PKT_LDST_SUBCLASS_SVE		(0x8)
>  
> +#define SPE_OP_PKT_SVE_SG			BIT(7)
> +#define SPE_OP_PKT_SVE_EVL_MASK			GENMASK_ULL(6, 4)
> +#define SPE_OP_PKT_SVE_EVL_SHIFT		(4)
> +#define SPE_OP_PKT_SVE_PRED			BIT(2)
> +#define SPE_OP_PKT_SVE_FP			BIT(1)
> +
>  #define SPE_OP_PKT_AR				BIT(4)
>  #define SPE_OP_PKT_EXCL				BIT(3)
>  #define SPE_OP_PKT_AT				BIT(2)
> 


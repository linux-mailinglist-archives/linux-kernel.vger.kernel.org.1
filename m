Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E156D297A08
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 02:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755499AbgJXAdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 20:33:22 -0400
Received: from foss.arm.com ([217.140.110.172]:60442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755382AbgJXAdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 20:33:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C867113E;
        Fri, 23 Oct 2020 17:33:21 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F3043F719;
        Fri, 23 Oct 2020 17:33:19 -0700 (PDT)
Subject: Re: [PATCH v3 18/20] perf arm-spe: Add more sub classes for operation
 packet
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
 <20201022145816.14069-19-leo.yan@linaro.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <b029198a-7b04-14e3-261c-f17b4e44d586@arm.com>
Date:   Sat, 24 Oct 2020 01:32:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201022145816.14069-19-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2020 15:58, Leo Yan wrote:

Hi,

> For the operation type packet payload with load/store class, it misses
> to support these sub classes:
> 
>   - A load/store targeting the general-purpose registers;
>   - A load/store targeting unspecified registers;
>   - The ARMv8.4 nested virtualisation extension can redirect system
>     register accesses to a memory page controlled by the hypervisor.
>     The SPE profiling feature in newer implementations can tag those
>     memory accesses accordingly.
> 
> Add the bit pattern describing load/store sub classes, so that the perf
> tool can decode it properly.
> 
> Inspired by Andre Przywara, refined the commit log and code for more
> clear description.
> 
> Co-developed-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 28 +++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 59b538563d31..c1a3b0afd1de 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -370,11 +370,35 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
>  				if (ret < 0)
>  					return ret;
>  			}
> -		} else if (SPE_OP_PKT_LDST_SUBCLASS_GET(payload) ==
> -					SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP) {
> +		}
> +
> +		switch (SPE_OP_PKT_LDST_SUBCLASS_GET(payload)) {
> +		case SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP:
>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " SIMD-FP");
>  			if (ret < 0)
>  				return ret;
> +
> +			break;
> +		case SPE_OP_PKT_LDST_SUBCLASS_GP_REG:
> +			ret = arm_spe_pkt_snprintf(&buf, &blen, " GP-REG");
> +			if (ret < 0)
> +				return ret;
> +
> +			break;
> +		case SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG:
> +			ret = arm_spe_pkt_snprintf(&buf, &blen, " UNSPEC-REG");
> +			if (ret < 0)
> +				return ret;
> +
> +			break;
> +		case SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG:
> +			ret = arm_spe_pkt_snprintf(&buf, &blen, " NV-SYSREG");
> +			if (ret < 0)
> +				return ret;
> +
> +			break;
> +		default:
> +			break;
>  		}
>  
>  		return buf_len - blen;
> 


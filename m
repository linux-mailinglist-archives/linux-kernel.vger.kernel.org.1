Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104E8297A0C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 02:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755857AbgJXAdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 20:33:32 -0400
Received: from foss.arm.com ([217.140.110.172]:60466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755607AbgJXAdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 20:33:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DDA7113E;
        Fri, 23 Oct 2020 17:33:31 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DA7B3F719;
        Fri, 23 Oct 2020 17:33:29 -0700 (PDT)
Subject: Re: [PATCH v3 19/20] perf arm_spe: Decode memory tagging properties
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
 <20201022145816.14069-20-leo.yan@linaro.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <e213f5f1-42a1-5155-433c-9617cb444a9e@arm.com>
Date:   Sat, 24 Oct 2020 01:32:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201022145816.14069-20-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2020 15:58, Leo Yan wrote:

Hi,

> From: Andre Przywara <andre.przywara@arm.com>
> 
> When SPE records a physical address, it can additionally tag the event
> with information from the Memory Tagging architecture extension.
> 
> Decode the two additional fields in the SPE event payload.
> 
> [leoy: Refined patch to use predefined macros]
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 6 +++++-
>  tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 2 ++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index c1a3b0afd1de..74ac12cbec69 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -432,6 +432,7 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
>  				 char *buf, size_t buf_len)
>  {
>  	int ns, el, idx = packet->index;
> +	int ch, pat;
>  	u64 payload = packet->payload;
>  
>  	switch (idx) {
> @@ -448,9 +449,12 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
>  					    "VA 0x%llx", payload);
>  	case SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS:
>  		ns = !!SPE_ADDR_PKT_GET_NS(payload);
> +		ch = !!SPE_ADDR_PKT_GET_CH(payload);
> +		pat = SPE_ADDR_PKT_GET_PAT(payload);
>  		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
>  		return arm_spe_pkt_snprintf(&buf, &buf_len,
> -					    "PA 0x%llx ns=%d", payload, ns);
> +					    "PA 0x%llx ns=%d ch=%d, pat=%x",
> +					    payload, ns, ch, pat);
>  	default:
>  		return 0;
>  	}
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> index 31dbb8c0fde3..d69af0d618ea 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> @@ -75,6 +75,8 @@ struct arm_spe_pkt {
>  
>  #define SPE_ADDR_PKT_GET_NS(v)			(((v) & BIT(63)) >> 63)
>  #define SPE_ADDR_PKT_GET_EL(v)			(((v) & GENMASK_ULL(62, 61)) >> 61)
> +#define SPE_ADDR_PKT_GET_CH(v)			(((v) & BIT(62)) >> 62)

You need BIT_ULL() here to make this work on 32-bit systems.

Cheers,
Andre

> +#define SPE_ADDR_PKT_GET_PAT(v)			(((v) & GENMASK_ULL(59, 56)) >> 56)
>  
>  #define SPE_ADDR_PKT_EL0			0
>  #define SPE_ADDR_PKT_EL1			1
> 


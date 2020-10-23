Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98132297591
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 19:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753114AbgJWRKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 13:10:43 -0400
Received: from foss.arm.com ([217.140.110.172]:56968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S465752AbgJWRKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 13:10:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B2561FB;
        Fri, 23 Oct 2020 10:10:40 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71A8D3F719;
        Fri, 23 Oct 2020 10:10:38 -0700 (PDT)
Subject: Re: [PATCH v3 08/20] perf arm-spe: Add new function
 arm_spe_pkt_desc_addr()
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
 <20201022145816.14069-9-leo.yan@linaro.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <3428fe2c-77b1-1ad4-ddf6-513eb409c284@arm.com>
Date:   Fri, 23 Oct 2020 18:09:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201022145816.14069-9-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2020 15:58, Leo Yan wrote:
> This patch moves out the address parsing code from arm_spe_pkt_desc()
> and uses the new introduced function arm_spe_pkt_desc_addr() to process
> address packet.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Can confirm the move is correct.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 49 ++++++++++++-------
>  1 file changed, 30 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 6f2329990729..550cd7648c73 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -267,10 +267,38 @@ static int arm_spe_pkt_snprintf(char **buf_p, size_t *blen,
>  	return ret;
>  }
>  
> +static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
> +				 char *buf, size_t buf_len)
> +{
> +	int ns, el, idx = packet->index;
> +	u64 payload = packet->payload;
> +
> +	switch (idx) {
> +	case 0:
> +	case 1:
> +		ns = !!(packet->payload & NS_FLAG);
> +		el = (packet->payload & EL_FLAG) >> 61;
> +		payload &= ~(0xffULL << 56);
> +		return arm_spe_pkt_snprintf(&buf, &buf_len,
> +				"%s 0x%llx el%d ns=%d",
> +				(idx == 1) ? "TGT" : "PC", payload, el, ns);
> +	case 2:
> +		return arm_spe_pkt_snprintf(&buf, &buf_len,
> +					    "VA 0x%llx", payload);
> +	case 3:
> +		ns = !!(packet->payload & NS_FLAG);
> +		payload &= ~(0xffULL << 56);
> +		return arm_spe_pkt_snprintf(&buf, &buf_len,
> +					    "PA 0x%llx ns=%d", payload, ns);
> +	default:
> +		return 0;
> +	}
> +}
> +
>  int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  		     size_t buf_len)
>  {
> -	int ret, ns, el, idx = packet->index;
> +	int ret, idx = packet->index;
>  	unsigned long long payload = packet->payload;
>  	const char *name = arm_spe_pkt_name(packet->type);
>  	size_t blen = buf_len;
> @@ -404,24 +432,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  	case ARM_SPE_TIMESTAMP:
>  		return arm_spe_pkt_snprintf(&buf, &blen, "%s %lld", name, payload);
>  	case ARM_SPE_ADDRESS:
> -		switch (idx) {
> -		case 0:
> -		case 1: ns = !!(packet->payload & NS_FLAG);
> -			el = (packet->payload & EL_FLAG) >> 61;
> -			payload &= ~(0xffULL << 56);
> -			return arm_spe_pkt_snprintf(&buf, &blen,
> -					"%s 0x%llx el%d ns=%d",
> -				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
> -		case 2:
> -			return arm_spe_pkt_snprintf(&buf, &blen,
> -						    "VA 0x%llx", payload);
> -		case 3:	ns = !!(packet->payload & NS_FLAG);
> -			payload &= ~(0xffULL << 56);
> -			return arm_spe_pkt_snprintf(&buf, &blen,
> -						    "PA 0x%llx ns=%d", payload, ns);
> -		default:
> -			return 0;
> -		}
> +		return arm_spe_pkt_desc_addr(packet, buf, buf_len);
>  	case ARM_SPE_CONTEXT:
>  		return arm_spe_pkt_snprintf(&buf, &blen, "%s 0x%lx el%d",
>  					    name, (unsigned long)payload, idx + 1);
> 


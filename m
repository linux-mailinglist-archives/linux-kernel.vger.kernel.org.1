Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721AA297A05
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 02:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754469AbgJXAcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 20:32:53 -0400
Received: from foss.arm.com ([217.140.110.172]:60384 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752762AbgJXAcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 20:32:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2807B113E;
        Fri, 23 Oct 2020 17:32:52 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71AB73F719;
        Fri, 23 Oct 2020 17:32:50 -0700 (PDT)
Subject: Re: [PATCH v3 12/20] perf arm-spe: Refactor counter packet handling
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
 <20201022145816.14069-13-leo.yan@linaro.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <3a8f4d5c-b00a-d6b5-1bbf-c5c56254f9f2@arm.com>
Date:   Sat, 24 Oct 2020 01:31:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201022145816.14069-13-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2020 15:58, Leo Yan wrote:

Hi,

> This patch defines macros for counter packet header, and uses macros to
> replace hard code values in functions arm_spe_get_counter() and
> arm_spe_pkt_desc().
> 
> In the function arm_spe_get_counter(), adds a new line for more
> readable.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 11 ++++++-----
>  tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h |  8 ++++++++
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 023bcc9be3cc..6eebd30f3d78 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -152,10 +152,11 @@ static int arm_spe_get_counter(const unsigned char *buf, size_t len,
>  			       const unsigned char ext_hdr, struct arm_spe_pkt *packet)
>  {
>  	packet->type = ARM_SPE_COUNTER;
> +
>  	if (ext_hdr)
> -		packet->index = ((buf[0] & 0x3) << 3) | (buf[1] & 0x7);
> +		packet->index = SPE_CNT_PKT_HDR_EXTENDED_INDEX(buf[0], buf[1]);
>  	else
> -		packet->index = buf[0] & 0x7;
> +		packet->index = SPE_CNT_PKT_HDR_SHORT_INDEX(buf[0]);
>  
>  	return arm_spe_get_payload(buf, len, ext_hdr, packet);
>  }
> @@ -307,17 +308,17 @@ static int arm_spe_pkt_desc_counter(const struct arm_spe_pkt *packet,
>  		return ret;
>  
>  	switch (packet->index) {
> -	case 0:
> +	case SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT:
>  		ret = arm_spe_pkt_snprintf(&buf, &blen, "TOT");
>  		if (ret < 0)
>  			return ret;
>  		break;
> -	case 1:
> +	case SPE_CNT_PKT_HDR_INDEX_ISSUE_LAT:
>  		ret = arm_spe_pkt_snprintf(&buf, &blen, "ISSUE");
>  		if (ret < 0)
>  			return ret;
>  		break;
> -	case 2:
> +	case SPE_CNT_PKT_HDR_INDEX_TRANS_LAT:
>  		ret = arm_spe_pkt_snprintf(&buf, &blen, "XLAT");
>  		if (ret < 0)
>  			return ret;
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> index 8808f2d0b6e4..8a291f451ef8 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> @@ -84,6 +84,14 @@ struct arm_spe_pkt {
>  /* Context packet header */
>  #define SPE_CTX_PKT_HDR_INDEX(h)		((h) & GENMASK_ULL(1, 0))
>  
> +/* Counter packet header */
> +#define SPE_CNT_PKT_HDR_SHORT_INDEX(h)		((h) & GENMASK_ULL(2, 0))
> +#define SPE_CNT_PKT_HDR_EXTENDED_INDEX(h0, h1)	(((h0) & GENMASK_ULL(1, 0)) << 3 | \
> +						 SPE_ADDR_PKT_HDR_SHORT_INDEX(h1))

I would still like to see this merged with the SPE_ADDR_PKT_HDR_*_INDEX
definition in patch 10/20.

Otherwise this patch is fine.

Cheers,
Andre

> +#define SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT		0x0
> +#define SPE_CNT_PKT_HDR_INDEX_ISSUE_LAT		0x1
> +#define SPE_CNT_PKT_HDR_INDEX_TRANS_LAT		0x2
> +
>  const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
>  
>  int arm_spe_get_packet(const unsigned char *buf, size_t len,
> 


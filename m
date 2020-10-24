Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EC9297A07
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 02:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755419AbgJXAdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 20:33:09 -0400
Received: from foss.arm.com ([217.140.110.172]:60424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755375AbgJXAdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 20:33:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94F4A113E;
        Fri, 23 Oct 2020 17:33:08 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E83343F719;
        Fri, 23 Oct 2020 17:33:06 -0700 (PDT)
Subject: Re: [PATCH v3 14/20] perf arm-spe: Refactor event type handling
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
 <20201022145816.14069-15-leo.yan@linaro.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <97a7b5b2-2bed-1044-a5c3-14d875e3b888@arm.com>
Date:   Sat, 24 Oct 2020 01:32:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201022145816.14069-15-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2020 15:58, Leo Yan wrote:

Hi,

> Move the enums of event types to arm-spe-pkt-decoder.h, thus function
> arm_spe_pkt_desc() can them for bitmasks.
> 
> Suggested-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

The move is fine, and I checked the bitmasks as well.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  .../util/arm-spe-decoder/arm-spe-decoder.h    | 17 --------------
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 22 +++++++++----------
>  .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 18 +++++++++++++++
>  3 files changed, 29 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> index a5111a8d4360..24727b8ca7ff 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -13,23 +13,6 @@
>  
>  #include "arm-spe-pkt-decoder.h"
>  
> -enum arm_spe_events {
> -	EV_EXCEPTION_GEN	= 0,
> -	EV_RETIRED		= 1,
> -	EV_L1D_ACCESS		= 2,
> -	EV_L1D_REFILL		= 3,
> -	EV_TLB_ACCESS		= 4,
> -	EV_TLB_WALK		= 5,
> -	EV_NOT_TAKEN		= 6,
> -	EV_MISPRED		= 7,
> -	EV_LLC_ACCESS		= 8,
> -	EV_LLC_MISS		= 9,
> -	EV_REMOTE_ACCESS	= 10,
> -	EV_ALIGNMENT		= 11,
> -	EV_PARTIAL_PREDICATE	= 17,
> -	EV_EMPTY_PREDICATE	= 18,
> -};
> -
>  enum arm_spe_sample_type {
>  	ARM_SPE_L1D_ACCESS	= 1 << 0,
>  	ARM_SPE_L1D_MISS	= 1 << 1,
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 8a6b50f32a52..58a1390b7a43 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -277,58 +277,58 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
>  	if (ret < 0)
>  		return ret;
>  
> -	if (payload & 0x1) {
> +	if (payload & BIT(EV_EXCEPTION_GEN)) {
>  		ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCEPTION-GEN");
>  		if (ret < 0)
>  			return ret;
>  	}
> -	if (payload & 0x2) {
> +	if (payload & BIT(EV_RETIRED)) {
>  		ret = arm_spe_pkt_snprintf(&buf, &blen, " RETIRED");
>  		if (ret < 0)
>  			return ret;
>  	}
> -	if (payload & 0x4) {
> +	if (payload & BIT(EV_L1D_ACCESS)) {
>  		ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-ACCESS");
>  		if (ret < 0)
>  			return ret;
>  	}
> -	if (payload & 0x8) {
> +	if (payload & BIT(EV_L1D_REFILL)) {
>  		ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-REFILL");
>  		if (ret < 0)
>  			return ret;
>  	}
> -	if (payload & 0x10) {
> +	if (payload & BIT(EV_TLB_ACCESS)) {
>  		ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-ACCESS");
>  		if (ret < 0)
>  			return ret;
>  	}
> -	if (payload & 0x20) {
> +	if (payload & BIT(EV_TLB_WALK)) {
>  		ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-REFILL");
>  		if (ret < 0)
>  			return ret;
>  	}
> -	if (payload & 0x40) {
> +	if (payload & BIT(EV_NOT_TAKEN)) {
>  		ret = arm_spe_pkt_snprintf(&buf, &blen, " NOT-TAKEN");
>  		if (ret < 0)
>  			return ret;
>  	}
> -	if (payload & 0x80) {
> +	if (payload & BIT(EV_MISPRED)) {
>  		ret = arm_spe_pkt_snprintf(&buf, &blen, " MISPRED");
>  		if (ret < 0)
>  			return ret;
>  	}
>  	if (packet->index > 1) {
> -		if (payload & 0x100) {
> +		if (payload & BIT(EV_LLC_ACCESS)) {
>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-ACCESS");
>  			if (ret < 0)
>  				return ret;
>  		}
> -		if (payload & 0x200) {
> +		if (payload & BIT(EV_LLC_MISS)) {
>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-REFILL");
>  			if (ret < 0)
>  				return ret;
>  		}
> -		if (payload & 0x400) {
> +		if (payload & BIT(EV_REMOTE_ACCESS)) {
>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " REMOTE-ACCESS");
>  			if (ret < 0)
>  				return ret;
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> index 8a291f451ef8..12c344454cf1 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> @@ -92,6 +92,24 @@ struct arm_spe_pkt {
>  #define SPE_CNT_PKT_HDR_INDEX_ISSUE_LAT		0x1
>  #define SPE_CNT_PKT_HDR_INDEX_TRANS_LAT		0x2
>  
> +/* Event packet payload */
> +enum arm_spe_events {
> +	EV_EXCEPTION_GEN	= 0,
> +	EV_RETIRED		= 1,
> +	EV_L1D_ACCESS		= 2,
> +	EV_L1D_REFILL		= 3,
> +	EV_TLB_ACCESS		= 4,
> +	EV_TLB_WALK		= 5,
> +	EV_NOT_TAKEN		= 6,
> +	EV_MISPRED		= 7,
> +	EV_LLC_ACCESS		= 8,
> +	EV_LLC_MISS		= 9,
> +	EV_REMOTE_ACCESS	= 10,
> +	EV_ALIGNMENT		= 11,
> +	EV_PARTIAL_PREDICATE	= 17,
> +	EV_EMPTY_PREDICATE	= 18,
> +};
> +
>  const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
>  
>  int arm_spe_get_packet(const unsigned char *buf, size_t len,
> 


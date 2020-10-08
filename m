Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D357228755F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 15:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbgJHNpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 09:45:54 -0400
Received: from foss.arm.com ([217.140.110.172]:58462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730387AbgJHNpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 09:45:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59FB91529;
        Thu,  8 Oct 2020 06:45:53 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65DDF3F70D;
        Thu,  8 Oct 2020 06:45:50 -0700 (PDT)
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Subject: Re: [PATCH v2 03/14] perf arm-spe: Refactor payload length
 calculation
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
 <20200929133917.9224-4-leo.yan@linaro.org>
Organization: ARM Ltd.
Message-ID: <995b40af-13b9-faef-fb3b-235f04289eb5@arm.com>
Date:   Thu, 8 Oct 2020 14:44:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200929133917.9224-4-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2020 14:39, Leo Yan wrote:

Hi Leo,

> Defines macro for payload length calculation instead of static function.

What is the reason for that? I thought the kernel's direction is more
the other way: replacing macros with static functions ("Don't write CPP,
write C")? Ideally the compiler would generate the same code.

> Currently the event packet's 'index' is assigned as payload length, but
> the flow is not directive: it firstly gets the packet length (includes
> header length and payload length) and then reduces header length from
> packet length, so finally get the payload length; to simplify the code,
> this patch directly assigns payload length to event packet's index.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 26 ++++++++-----------
>  .../arm-spe-decoder/arm-spe-pkt-decoder.h     |  4 +++
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 7c7b5eb09fba..5a8696031e16 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -69,22 +69,20 @@ const char *arm_spe_pkt_name(enum arm_spe_pkt_type type)
>  	return arm_spe_packet_name[type];
>  }
>  
> -/* return ARM SPE payload size from its encoding,
> - * which is in bits 5:4 of the byte.
> - * 00 : byte
> - * 01 : halfword (2)
> - * 10 : word (4)
> - * 11 : doubleword (8)
> +/*
> + * Return ARM SPE payload size from header bits 5:4
> + *   00 : byte
> + *   01 : halfword (2)
> + *   10 : word (4)
> + *   11 : doubleword (8)
>   */
> -static int payloadlen(unsigned char byte)
> -{
> -	return 1 << ((byte & 0x30) >> 4);
> -}
> +#define PAYLOAD_LEN(val)	\
> +	(1 << (((val) & SPE_HEADER_SZ_MASK) >> SPE_HEADER_SZ_SHIFT))

This change of the expression is good (although it should be 1U), but
please keep it a function. The return type should be unsigned, I guess.

The rest looks fine.

Cheers,
Andre

>  
>  static int arm_spe_get_payload(const unsigned char *buf, size_t len,
>  			       struct arm_spe_pkt *packet)
>  {
> -	size_t payload_len = payloadlen(buf[0]);
> +	size_t payload_len = PAYLOAD_LEN(buf[0]);
>  
>  	if (len < 1 + payload_len)
>  		return ARM_SPE_NEED_MORE_BYTES;
> @@ -136,8 +134,6 @@ static int arm_spe_get_timestamp(const unsigned char *buf, size_t len,
>  static int arm_spe_get_events(const unsigned char *buf, size_t len,
>  			      struct arm_spe_pkt *packet)
>  {
> -	int ret = arm_spe_get_payload(buf, len, packet);
> -
>  	packet->type = ARM_SPE_EVENTS;
>  
>  	/* we use index to identify Events with a less number of
> @@ -145,9 +141,9 @@ static int arm_spe_get_events(const unsigned char *buf, size_t len,
>  	 * LLC-REFILL, and REMOTE-ACCESS events are identified if
>  	 * index > 1.
>  	 */
> -	packet->index = ret - 1;
> +	packet->index = PAYLOAD_LEN(buf[0]);
>  
> -	return ret;
> +	return arm_spe_get_payload(buf, len, packet);
>  }
>  
>  static int arm_spe_get_data_source(const unsigned char *buf, size_t len,
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> index 4c870521b8eb..f2d0af39a58c 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> @@ -9,6 +9,7 @@
>  
>  #include <stddef.h>
>  #include <stdint.h>
> +#include <linux/bits.h>
>  
>  #define ARM_SPE_PKT_DESC_MAX		256
>  
> @@ -36,6 +37,9 @@ struct arm_spe_pkt {
>  	uint64_t		payload;
>  };
>  
> +#define SPE_HEADER_SZ_SHIFT		(4)
> +#define SPE_HEADER_SZ_MASK		GENMASK_ULL(5, 4)
> +
>  #define SPE_ADDR_PKT_HDR_INDEX_INS		(0x0)
>  #define SPE_ADDR_PKT_HDR_INDEX_BRANCH		(0x1)
>  #define SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT	(0x2)
> 


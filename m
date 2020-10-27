Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A654529C0D3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1818343AbgJ0RTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:19:09 -0400
Received: from foss.arm.com ([217.140.110.172]:42734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2900712AbgJ0OzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:55:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2412150C;
        Tue, 27 Oct 2020 07:55:04 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F7E53F719;
        Tue, 27 Oct 2020 07:55:03 -0700 (PDT)
Subject: Re: [PATCH v4 03/21] perf arm-spe: Refactor payload size calculation
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
References: <20201027030917.15404-1-leo.yan@linaro.org>
 <20201027030917.15404-4-leo.yan@linaro.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <bcca927c-bf32-e58c-a67c-e4e452daa641@arm.com>
Date:   Tue, 27 Oct 2020 14:53:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201027030917.15404-4-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2020 03:08, Leo Yan wrote:
> This patch defines macro to extract "sz" field from header, and renames
> the function payloadlen() to arm_spe_payload_len().
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  .../util/arm-spe-decoder/arm-spe-pkt-decoder.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 7c7b5eb09fba..06b3eec4494e 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -69,22 +69,22 @@ const char *arm_spe_pkt_name(enum arm_spe_pkt_type type)
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
> + * Extracts the field "sz" from header bits and converts to bytes:
> + *   00 : byte (1)
> + *   01 : halfword (2)
> + *   10 : word (4)
> + *   11 : doubleword (8)
>   */
> -static int payloadlen(unsigned char byte)
> +static unsigned int arm_spe_payload_len(unsigned char hdr)
>  {
> -	return 1 << ((byte & 0x30) >> 4);
> +	return 1U << ((hdr & GENMASK_ULL(5, 4)) >> 4);
>  }
>  
>  static int arm_spe_get_payload(const unsigned char *buf, size_t len,
>  			       struct arm_spe_pkt *packet)
>  {
> -	size_t payload_len = payloadlen(buf[0]);
> +	size_t payload_len = arm_spe_payload_len(buf[0]);
>  
>  	if (len < 1 + payload_len)
>  		return ARM_SPE_NEED_MORE_BYTES;
> 


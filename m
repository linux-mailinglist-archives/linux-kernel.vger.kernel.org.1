Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0745A29BE40
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1794330AbgJ0PLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 11:11:15 -0400
Received: from foss.arm.com ([217.140.110.172]:43114 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1789486AbgJ0PCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:02:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F57B13D5;
        Tue, 27 Oct 2020 08:02:21 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAA7A3F719;
        Tue, 27 Oct 2020 08:02:19 -0700 (PDT)
Subject: Re: [PATCH v4 10/21] perf arm_spe: Fixup top byte for data virtual
 address
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
 <20201027030917.15404-11-leo.yan@linaro.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <dfb599fd-b253-ba94-59c0-a76e5043fbb7@arm.com>
Date:   Tue, 27 Oct 2020 15:01:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201027030917.15404-11-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2020 03:09, Leo Yan wrote:
> To establish a valid address from the address packet payload and finally
> the address value can be used for parsing data symbol in DSO, current
> code uses 0xff to replace the tag in the top byte of data virtual
> address.
> 
> So far the code only fixups top byte for the memory layouts with 4KB
> pages, it misses to support memory layouts with 64KB pages.
> 
> This patch adds the conditions for checking bits [55:48] are 0xf0 or
> 0xfd, if detects the patterns it will fill 0xff into the top byte of the
> address, also adds comment to explain the fixing up.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  .../util/arm-spe-decoder/arm-spe-decoder.c    | 24 ++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> index 776b3e6628bb..e135ac01d94a 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> @@ -24,7 +24,7 @@
>  
>  static u64 arm_spe_calc_ip(int index, u64 payload)
>  {
> -	u64 ns, el;
> +	u64 ns, el, val;
>  
>  	/* Instruction virtual address or Branch target address */
>  	if (index == SPE_ADDR_PKT_HDR_INDEX_INS ||
> @@ -45,8 +45,26 @@ static u64 arm_spe_calc_ip(int index, u64 payload)
>  		/* Clean tags */
>  		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
>  
> -		/* Fill highest byte if bits [48..55] is 0xff */
> -		if (SPE_ADDR_PKT_ADDR_GET_BYTE_6(payload) == 0xffULL)
> +		/*
> +		 * Armv8 ARM (ARM DDI 0487F.c), chapter "D10.2.1 Address packet"
> +		 * defines the data virtual address payload format, the top byte
> +		 * (bits [63:56]) is assigned as top-byte tag; so we only can
> +		 * retrieve address value from bits [55:0].
> +		 *
> +		 * According to Documentation/arm64/memory.rst, if detects the
> +		 * specific pattern in bits [55:48] of payload which falls in
> +		 * the kernel space, should fixup the top byte and this allows
> +		 * perf tool to parse DSO symbol for data address correctly.
> +		 *
> +		 * For this reason, if detects the bits [55:48] is one of
> +		 * following values, will fill 0xff into the top byte:
> +		 *
> +		 *   - 0xff (for most kernel memory regions);
> +		 *   - 0xf0 (for kernel logical memory map with 64KB pages);
> +		 *   - 0xfd (for kasan shadow region with 64KB pages).
> +		 */
> +		val = SPE_ADDR_PKT_ADDR_GET_BYTE_6(payload);
> +		if (val == 0xffULL || val == 0xf0ULL || val == 0xfdULL)

But those values are just the beginning of the region used by the
kernel, aren't they? So the kernel logical map goes from 0xfff000.. to
0xfff7fff..., for instance.

But actually I wonder why were are so selective here? Wouldn't it just
suffice to look at bits [55:52] to be either 0 or F?

Cheers,
Andre

>  			payload |= 0xffULL << SPE_ADDR_PKT_ADDR_BYTE7_SHIFT;
>  
>  	/* Data access physical address */
> 


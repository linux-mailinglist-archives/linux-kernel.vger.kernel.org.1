Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C986129EB2E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgJ2MCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:02:32 -0400
Received: from foss.arm.com ([217.140.110.172]:34246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgJ2MCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:02:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2324113A1;
        Thu, 29 Oct 2020 05:02:20 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75E463F719;
        Thu, 29 Oct 2020 05:02:18 -0700 (PDT)
Subject: Re: [PATCH v5 10/21] perf arm_spe: Fixup top byte for data virtual
 address
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201029071927.9308-1-leo.yan@linaro.org>
 <20201029071927.9308-11-leo.yan@linaro.org>
From:   Andre Przywara <andre.przywara@foss.arm.com>
Message-ID: <8db2729f-c59d-2119-cb44-ca916a194624@foss.arm.com>
Date:   Thu, 29 Oct 2020 12:01:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201029071927.9308-11-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2020 07:19, Leo Yan wrote:
> To establish a valid address from the address packet payload and finally
> the address value can be used for parsing data symbol in DSO, current
> code uses 0xff to replace the tag in the top byte of data virtual
> address.
> 
> So far the code only fixups top byte for the memory layouts with 4KB
> pages, it misses to support memory layouts with 64KB pages.
> 
> This patch adds the conditions for checking bits [55:52] are 0xf, if
> detects the pattern it will fill 0xff into the top byte of the address,
> also adds comment to explain the fixing up.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Thanks for the change!

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  .../util/arm-spe-decoder/arm-spe-decoder.c    | 20 ++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> index 776b3e6628bb..cac2ef79c025 100644
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
> @@ -45,8 +45,22 @@ static u64 arm_spe_calc_ip(int index, u64 payload)
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
> +		 * specific pattern in bits [55:52] of payload which falls in
> +		 * the kernel space, should fixup the top byte and this allows
> +		 * perf tool to parse DSO symbol for data address correctly.
> +		 *
> +		 * For this reason, if detects the bits [55:52] is 0xf, will
> +		 * fill 0xff into the top byte.
> +		 */
> +		val = SPE_ADDR_PKT_ADDR_GET_BYTE_6(payload);
> +		if ((val & 0xf0ULL) == 0xf0ULL)
>  			payload |= 0xffULL << SPE_ADDR_PKT_ADDR_BYTE7_SHIFT;
>  
>  	/* Data access physical address */
> 


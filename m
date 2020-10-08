Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B1728755E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 15:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgJHNpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 09:45:36 -0400
Received: from foss.arm.com ([217.140.110.172]:58430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728969AbgJHNpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 09:45:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3D541529;
        Thu,  8 Oct 2020 06:45:32 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B61CF3F70D;
        Thu,  8 Oct 2020 06:45:30 -0700 (PDT)
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Subject: Re: [PATCH v2 01/14] perf arm-spe: Include bitops.h for BIT() macro
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
 <20200929133917.9224-2-leo.yan@linaro.org>
Organization: ARM Ltd.
Message-ID: <e61b9ce6-5ab1-126d-4528-431885ca8fae@arm.com>
Date:   Thu, 8 Oct 2020 14:44:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200929133917.9224-2-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2020 14:39, Leo Yan wrote:
> Include header linux/bitops.h, directly use its BIT() macro and remove
> the self defined macros.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks,
Andre

> ---
>  tools/perf/util/arm-spe-decoder/arm-spe-decoder.c     | 5 +----
>  tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 3 +--
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> index 93e063f22be5..cc18a1e8c212 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> @@ -12,6 +12,7 @@
>  #include <string.h>
>  #include <stdint.h>
>  #include <stdlib.h>
> +#include <linux/bitops.h>
>  #include <linux/compiler.h>
>  #include <linux/zalloc.h>
>  
> @@ -21,10 +22,6 @@
>  
>  #include "arm-spe-decoder.h"
>  
> -#ifndef BIT
> -#define BIT(n)		(1UL << (n))
> -#endif
> -
>  static u64 arm_spe_calc_ip(int index, u64 payload)
>  {
>  	u8 *addr = (u8 *)&payload;
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index b94001b756c7..46ddb53a6457 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -8,11 +8,10 @@
>  #include <string.h>
>  #include <endian.h>
>  #include <byteswap.h>
> +#include <linux/bitops.h>
>  
>  #include "arm-spe-pkt-decoder.h"
>  
> -#define BIT(n)		(1ULL << (n))
> -
>  #define NS_FLAG		BIT(63)
>  #define EL_FLAG		(BIT(62) | BIT(61))
>  
> 


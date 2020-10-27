Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C26029B1C3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 15:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898276AbgJ0Od7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 10:33:59 -0400
Received: from foss.arm.com ([217.140.110.172]:41964 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897650AbgJ0OcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:32:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23C8013D5;
        Tue, 27 Oct 2020 07:31:59 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 775DC3F719;
        Tue, 27 Oct 2020 07:31:57 -0700 (PDT)
Date:   Tue, 27 Oct 2020 14:31:54 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andre Przywara <Andre.Przywara@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <James.Clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 06/21] perf arm-spe: Refactor printing string to buffer
Message-ID: <20201027143153.GF27285@arm.com>
References: <20201027030917.15404-1-leo.yan@linaro.org>
 <20201027030917.15404-7-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027030917.15404-7-leo.yan@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 03:09:02AM +0000, Leo Yan wrote:
> When outputs strings to the decoding buffer with function snprintf(),
> SPE decoder needs to detects if any error returns from snprintf() and if
> so needs to directly bail out.  If snprintf() returns success, it needs
> to update buffer pointer and reduce the buffer length so can continue to
> output the next string into the consequent memory space.
> 
> This complex logics are spreading in the function arm_spe_pkt_desc() so
> there has many duplicate codes for handling error detecting, increment
> buffer pointer and decrement buffer size.
> 
> To avoid the duplicate code, this patch introduces a new helper function
> arm_spe_pkt_snprintf() which is used to wrap up the complex logics, and
> the caller arm_spe_pkt_desc() will call it and simply check the returns
> value.
> 
> This patch also moves the variable 'blen' as the function's local
> variable, this allows to remove the unnecessary braces and improve the
> readability.
> 
> Suggested-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 247 ++++++++++--------
>  1 file changed, 135 insertions(+), 112 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 04fd7fd7c15f..b400636e6da2 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -9,6 +9,7 @@
>  #include <endian.h>
>  #include <byteswap.h>
>  #include <linux/bitops.h>
> +#include <stdarg.h>
>  
>  #include "arm-spe-pkt-decoder.h"
>  
> @@ -258,192 +259,214 @@ int arm_spe_get_packet(const unsigned char *buf, size_t len,
>  	return ret;
>  }
>  
> +static int arm_spe_pkt_snprintf(char **buf_p, size_t *blen,
> +				const char *fmt, ...)
> +{
> +	va_list ap;
> +	int ret;
> +
> +	va_start(ap, fmt);
> +	ret = vsnprintf(*buf_p, *blen, fmt, ap);
> +	va_end(ap);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	*buf_p += ret;
> +	*blen -= ret;
> +	return ret;
> +}
> +

This approach seems OK, though I wonder whether all the
"if (ret < 0) return;" logic is really needed.

In case of failure, it probably doesn't matter what ends up in buf.
If not, we could just implement a cumulative error:

static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
{

	/* ... */

	if (ret < 0) {
		if (err && !*err)
			*err = ret;
	} else {
		*buf_p += ret;
		*blen -= ret;
	}

	return err ? *err : ret;
}

and just return the final value of err.



>  int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  		     size_t buf_len)
>  {
>  	int ret, ns, el, idx = packet->index;
>  	unsigned long long payload = packet->payload;
>  	const char *name = arm_spe_pkt_name(packet->type);
> +	size_t blen = buf_len;
>  
>  	switch (packet->type) {
>  	case ARM_SPE_BAD:
>  	case ARM_SPE_PAD:
>  	case ARM_SPE_END:
> -		return snprintf(buf, buf_len, "%s", name);
> -	case ARM_SPE_EVENTS: {
> -		size_t blen = buf_len;
> -
> -		ret = 0;
> -		ret = snprintf(buf, buf_len, "EV");
> -		buf += ret;
> -		blen -= ret;
> +		return arm_spe_pkt_snprintf(&buf, &blen, "%s", name);
> +	case ARM_SPE_EVENTS:
> +		ret = arm_spe_pkt_snprintf(&buf, &blen, "EV");
> +		if (ret < 0)
> +			return ret;
> +

...

Then this becomes

	case ARM_SPE_END:
		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s", name);
	case ARM_SPE_EVENTS:
		arm_spe_pkt_snprintf(&ret, &buf, &blen, "%s", name);

		if (payload & 0x1)
			arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCEPTION-GEN");
		if (payload & 0x2)
			arm_spe_pkt_snprintf(&err, &buf, &blen, " RETIRED");

	/* ... */


This might be over-engineering, but it does help to condense the code.

[...]

Cheers
---Dave

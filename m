Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57732AF583
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgKKPx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:53:27 -0500
Received: from foss.arm.com ([217.140.110.172]:56876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbgKKPx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:53:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 300C7101E;
        Wed, 11 Nov 2020 07:53:26 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3333C3F6CF;
        Wed, 11 Nov 2020 07:53:24 -0800 (PST)
Date:   Wed, 11 Nov 2020 15:53:20 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andre Przywara <Andre.Przywara@arm.com>,
        James Clark <James.Clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Al Grant <Al.Grant@arm.com>, Wei Li <liwei391@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 06/22] perf arm-spe: Refactor printing string to buffer
Message-ID: <20201111155320.GM6882@arm.com>
References: <20201111071149.815-1-leo.yan@linaro.org>
 <20201111071149.815-7-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111071149.815-7-leo.yan@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 07:11:33AM +0000, Leo Yan wrote:
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
> it's used by the caller arm_spe_pkt_desc().
> 
> This patch also moves the variable 'blen' as the function's local
> variable, this allows to remove the unnecessary braces and improve the
> readability.
> 
> Suggested-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Mostly looks fine to me now, thought there are a few potentionalu
issues -- comments below.

Cheers
---Dave

> ---
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 260 +++++++++---------
>  1 file changed, 126 insertions(+), 134 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 04fd7fd7c15f..1970686f7020 100644
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
> @@ -258,192 +259,183 @@ int arm_spe_get_packet(const unsigned char *buf, size_t len,
>  	return ret;
>  }
>  
> +static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
> +				const char *fmt, ...)
> +{
> +	va_list ap;
> +	int ret;
> +
> +	/* Bail out if any error occurred */
> +	if (err && *err)
> +		return *err;
> +
> +	va_start(ap, fmt);
> +	ret = vsnprintf(*buf_p, *blen, fmt, ap);
> +	va_end(ap);
> +
> +	if (ret < 0) {
> +		if (err && !*err)
> +			*err = ret;
> +
> +	/*
> +	 * A return value of (*blen - 1) or more means that the
> +	 * output was truncated and the buffer is overrun.
> +	 */

(*blen - 1) chars, + 1 for '\0', is exactly *blen bytes.  So ret ==
*blen - 1 is not an error.

> +	} else if (ret >= ((int)*blen - 1)) {

So I suggest

	if (ret >= *blen)

here.

Nit: If gcc moans about signedness in the comparison, I think it's
preferable to say

	if ((size_t)ret >= *blen)

rather than casting *blen to an int.  We already know that ret >= 0, and
UINT_MAX always fits in a size_t.  On this code path it probably doesn't
matter in practice through, since *blen will be much less than INT_MAX.
vsnprintf() probably doesn't cope gracefully with super-large buffers
anyway, and the ISO C standards don't describe this situation
adequately.

If gcc doesn't warn, just drop the cast.

> +		(*buf_p)[*blen - 1] = '\0';
> +
> +		/*
> +		 * Set *err to 'ret' to avoid overflow if tries to
> +		 * fill this buffer sequentially.
> +		 */
> +		if (err && !*err)
> +			*err = ret;
> +	} else {
> +		*buf_p += ret;
> +		*blen -= ret;
> +	}
> +
> +	return ret;
> +}
> +
>  int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  		     size_t buf_len)
>  {
>  	int ret, ns, el, idx = packet->index;
>  	unsigned long long payload = packet->payload;
>  	const char *name = arm_spe_pkt_name(packet->type);
> +	size_t blen = buf_len;
> +	int err = 0;
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
> -		if (payload & 0x1) {
> -			ret = snprintf(buf, buf_len, " EXCEPTION-GEN");
> -			buf += ret;
> -			blen -= ret;
> -		}
> -		if (payload & 0x2) {
> -			ret = snprintf(buf, buf_len, " RETIRED");
> -			buf += ret;
> -			blen -= ret;
> -		}
> -		if (payload & 0x4) {
> -			ret = snprintf(buf, buf_len, " L1D-ACCESS");
> -			buf += ret;
> -			blen -= ret;
> -		}
> -		if (payload & 0x8) {
> -			ret = snprintf(buf, buf_len, " L1D-REFILL");
> -			buf += ret;
> -			blen -= ret;
> -		}
> -		if (payload & 0x10) {
> -			ret = snprintf(buf, buf_len, " TLB-ACCESS");
> -			buf += ret;
> -			blen -= ret;
> -		}
> -		if (payload & 0x20) {
> -			ret = snprintf(buf, buf_len, " TLB-REFILL");
> -			buf += ret;
> -			blen -= ret;
> -		}
> -		if (payload & 0x40) {
> -			ret = snprintf(buf, buf_len, " NOT-TAKEN");
> -			buf += ret;
> -			blen -= ret;
> -		}
> -		if (payload & 0x80) {
> -			ret = snprintf(buf, buf_len, " MISPRED");
> -			buf += ret;
> -			blen -= ret;
> -		}
> +		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s", name);
> +	case ARM_SPE_EVENTS:
> +		ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "EV");
> +
> +		if (payload & 0x1)
> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCEPTION-GEN");
> +		if (payload & 0x2)
> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " RETIRED");
> +		if (payload & 0x4)
> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-ACCESS");
> +		if (payload & 0x8)
> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-REFILL");
> +		if (payload & 0x10)
> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-ACCESS");
> +		if (payload & 0x20)
> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-REFILL");
> +		if (payload & 0x40)
> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " NOT-TAKEN");
> +		if (payload & 0x80)
> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " MISPRED");
>  		if (idx > 1) {
> -			if (payload & 0x100) {
> -				ret = snprintf(buf, buf_len, " LLC-ACCESS");
> -				buf += ret;
> -				blen -= ret;
> -			}
> -			if (payload & 0x200) {
> -				ret = snprintf(buf, buf_len, " LLC-REFILL");
> -				buf += ret;
> -				blen -= ret;
> -			}
> -			if (payload & 0x400) {
> -				ret = snprintf(buf, buf_len, " REMOTE-ACCESS");
> -				buf += ret;
> -				blen -= ret;
> -			}
> +			if (payload & 0x100)
> +				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-ACCESS");
> +			if (payload & 0x200)
> +				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-REFILL");
> +			if (payload & 0x400)
> +				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " REMOTE-ACCESS");
>  		}
>  		if (ret < 0)
>  			return ret;
>  		blen -= ret;

I thought that arm_spe_pkt_snprintf() already did this subtraction?

Also, arm_spe_pkt_snprintf() can return a value >= blen if it overflows
the buffer, so I think this subtraction can underflow away.

If you always do the subtraction at the and of arm_spe_pkt_snprintf()
rather than outside, and if arm_spe_pkt_snprintf() subtracts no more
than blen - 1, then I think this all just works.

>  		return buf_len - blen;
> -	}
>  	case ARM_SPE_OP_TYPE:
>  		switch (idx) {
> -		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
> -					"COND-SELECT" : "INSN-OTHER");
> -		case 1:	{
> -			size_t blen = buf_len;
> +		case 0:
> +			return arm_spe_pkt_snprintf(&err, &buf, &blen,
> +					payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
> +		case 1:
> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen,
> +						   payload & 0x1 ? "ST" : "LD");
>  
> -			if (payload & 0x1)
> -				ret = snprintf(buf, buf_len, "ST");
> -			else
> -				ret = snprintf(buf, buf_len, "LD");
> -			buf += ret;
> -			blen -= ret;
>  			if (payload & 0x2) {
> -				if (payload & 0x4) {
> -					ret = snprintf(buf, buf_len, " AT");
> -					buf += ret;
> -					blen -= ret;
> -				}
> -				if (payload & 0x8) {
> -					ret = snprintf(buf, buf_len, " EXCL");
> -					buf += ret;
> -					blen -= ret;
> -				}
> -				if (payload & 0x10) {
> -					ret = snprintf(buf, buf_len, " AR");
> -					buf += ret;
> -					blen -= ret;
> -				}
> +				if (payload & 0x4)
> +					ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " AT");
> +				if (payload & 0x8)
> +					ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCL");
> +				if (payload & 0x10)
> +					ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " AR");
>  			} else if (payload & 0x4) {
> -				ret = snprintf(buf, buf_len, " SIMD-FP");
> -				buf += ret;
> -				blen -= ret;
> +				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " SIMD-FP");
>  			}
> +
>  			if (ret < 0)
>  				return ret;
>  			blen -= ret;

Same here.

>  			return buf_len - blen;
> -		}
> -		case 2:	{
> -			size_t blen = buf_len;
>  
> -			ret = snprintf(buf, buf_len, "B");
> -			buf += ret;
> -			blen -= ret;
> -			if (payload & 0x1) {
> -				ret = snprintf(buf, buf_len, " COND");
> -				buf += ret;
> -				blen -= ret;
> -			}
> -			if (payload & 0x2) {
> -				ret = snprintf(buf, buf_len, " IND");
> -				buf += ret;
> -				blen -= ret;
> -			}
> +		case 2:
> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "B");
> +
> +			if (payload & 0x1)
> +				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " COND");
> +			if (payload & 0x2)
> +				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " IND");
> +
>  			if (ret < 0)
>  				return ret;
>  			blen -= ret;
>  			return buf_len - blen;
> -			}
> -		default: return 0;
> +
> +		default:
> +			return 0;
>  		}
>  	case ARM_SPE_DATA_SOURCE:
>  	case ARM_SPE_TIMESTAMP:
> -		return snprintf(buf, buf_len, "%s %lld", name, payload);
> +		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %lld", name, payload);
>  	case ARM_SPE_ADDRESS:
>  		switch (idx) {
>  		case 0:
> -		case 1: ns = !!(packet->payload & NS_FLAG);
> +		case 1:
> +			ns = !!(packet->payload & NS_FLAG);
>  			el = (packet->payload & EL_FLAG) >> 61;
>  			payload &= ~(0xffULL << 56);
> -			return snprintf(buf, buf_len, "%s 0x%llx el%d ns=%d",
> +			return arm_spe_pkt_snprintf(&err, &buf, &blen,
> +					"%s 0x%llx el%d ns=%d",
>  				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
> -		case 2:	return snprintf(buf, buf_len, "VA 0x%llx", payload);
> -		case 3:	ns = !!(packet->payload & NS_FLAG);
> +		case 2:
> +			return arm_spe_pkt_snprintf(&err, &buf, &blen,
> +						    "VA 0x%llx", payload);
> +		case 3:
> +			ns = !!(packet->payload & NS_FLAG);
>  			payload &= ~(0xffULL << 56);
> -			return snprintf(buf, buf_len, "PA 0x%llx ns=%d",
> -					payload, ns);
> -		default: return 0;
> +			return arm_spe_pkt_snprintf(&err, &buf, &blen,
> +						    "PA 0x%llx ns=%d", payload, ns);
> +		default:
> +			return 0;
>  		}
>  	case ARM_SPE_CONTEXT:
> -		return snprintf(buf, buf_len, "%s 0x%lx el%d", name,
> -				(unsigned long)payload, idx + 1);
> -	case ARM_SPE_COUNTER: {
> -		size_t blen = buf_len;
> -
> -		ret = snprintf(buf, buf_len, "%s %d ", name,
> -			       (unsigned short)payload);
> -		buf += ret;
> -		blen -= ret;
> +		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%lx el%d",
> +					    name, (unsigned long)payload, idx + 1);
> +	case ARM_SPE_COUNTER:
> +		ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %d ", name,
> +					   (unsigned short)payload);
>  		switch (idx) {
> -		case 0:	ret = snprintf(buf, buf_len, "TOT"); break;
> -		case 1:	ret = snprintf(buf, buf_len, "ISSUE"); break;
> -		case 2:	ret = snprintf(buf, buf_len, "XLAT"); break;
> -		default: ret = 0;
> +		case 0:
> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "TOT");
> +			break;
> +		case 1:
> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "ISSUE");
> +			break;
> +		case 2:
> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "XLAT");
> +			break;
> +		default:
> +			ret = 0;
> +			break;
>  		}
>  		if (ret < 0)
>  			return ret;
>  		blen -= ret;
>  		return buf_len - blen;

Is it my imagination, or does every case that doesn't end in a break
have the same sequence here?

Can we just break and put

	if (err)
		return err;

at the end of the big switch?

I'm assuming that the caller treats any nonzero value as an error -- I
seem to remeber you mentioning this previously?

[...]

Cheers
---Dave

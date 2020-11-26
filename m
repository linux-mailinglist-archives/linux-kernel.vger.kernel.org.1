Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E702C53A6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 13:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbgKZMMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 07:12:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbgKZMMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 07:12:02 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 582942087C;
        Thu, 26 Nov 2020 12:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606392720;
        bh=jiLdiUKiqyv3eHHhgDwb7iMV2zASuI2inczaEBrTNW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WWIvXgG1mXbsNAZYwT7q6lNTsjHNHk78UMmoDTPMkhAnb9pBjRkrsuTLmgimdB1GA
         N/BBU67tiWHmUeIx6IiuSt0qxnX6+wEhbaMXLgdne6j3CzQfz1xHoeRynKKKEU8OQ+
         giOHfwIfe4E30ChNQTT6WspRP+/h2YkEuCoDMOOQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4620540E29; Thu, 26 Nov 2020 09:11:58 -0300 (-03)
Date:   Thu, 26 Nov 2020 09:11:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Al Grant <Al.Grant@arm.com>, Wei Li <liwei391@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 01/16] perf arm-spe: Refactor printing string to buffer
Message-ID: <20201126121158.GB53384@kernel.org>
References: <20201119152441.6972-1-leo.yan@linaro.org>
 <20201119152441.6972-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119152441.6972-2-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 19, 2020 at 11:24:26PM +0800, Leo Yan escreveu:
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
> arm_spe_pkt_out_string() which is used to wrap up the complex logics,
> and it's used by the caller arm_spe_pkt_desc().  This patch moves the
> variable 'blen' as the function's local variable so allows to remove
> the unnecessary braces and improve the readability.
> 
> This patch simplifies the return value for arm_spe_pkt_desc(): '0' means
> success and other values mean an error has occurred.  To realize this,
> it relies on arm_spe_pkt_out_string()'s parameter 'err', the 'err' is a
> cumulative value, returns its final value if printing buffer is called
> for one time or multiple times.  Finally, the error is handled in a
> central place, rather than directly bailing out in switch-cases, it
> returns error at the end of arm_spe_pkt_desc().
> 
> This patch changes the caller arm_spe_dump() to respect the updated
> return value semantics of arm_spe_pkt_desc().
> 
> Suggested-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 302 +++++++++---------
>  tools/perf/util/arm-spe.c                     |   2 +-
>  2 files changed, 151 insertions(+), 153 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 671a4763fb47..fbededc1bcd4 100644
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
> @@ -258,192 +259,189 @@ int arm_spe_get_packet(const unsigned char *buf, size_t len,
>  	return ret;
>  }
>  
> +static int arm_spe_pkt_out_string(int *err, char **buf_p, size_t *blen,
> +				  const char *fmt, ...)
> +{
> +	va_list ap;
> +	int ret;


Ok, from a quick look this continues confusing, but at least its not
named scnprintf() and then people won't expect the usual semantics.

Applying.

- Arnaldo

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
> +	 * A return value of *blen or more means that the output was
> +	 * truncated and the buffer is overrun.
> +	 */
> +	} else if ((size_t)ret >= *blen) {
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
> -	int ret, ns, el, idx = packet->index;
> +	int ns, el, idx = packet->index;
>  	unsigned long long payload = packet->payload;
>  	const char *name = arm_spe_pkt_name(packet->type);
> +	char *buf_orig = buf;
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
> +		arm_spe_pkt_out_string(&err, &buf, &blen, "%s", name);
> +		break;
> +	case ARM_SPE_EVENTS:
> +		arm_spe_pkt_out_string(&err, &buf, &blen, "EV");
> +
> +		if (payload & 0x1)
> +			arm_spe_pkt_out_string(&err, &buf, &blen, " EXCEPTION-GEN");
> +		if (payload & 0x2)
> +			arm_spe_pkt_out_string(&err, &buf, &blen, " RETIRED");
> +		if (payload & 0x4)
> +			arm_spe_pkt_out_string(&err, &buf, &blen, " L1D-ACCESS");
> +		if (payload & 0x8)
> +			arm_spe_pkt_out_string(&err, &buf, &blen, " L1D-REFILL");
> +		if (payload & 0x10)
> +			arm_spe_pkt_out_string(&err, &buf, &blen, " TLB-ACCESS");
> +		if (payload & 0x20)
> +			arm_spe_pkt_out_string(&err, &buf, &blen, " TLB-REFILL");
> +		if (payload & 0x40)
> +			arm_spe_pkt_out_string(&err, &buf, &blen, " NOT-TAKEN");
> +		if (payload & 0x80)
> +			arm_spe_pkt_out_string(&err, &buf, &blen, " MISPRED");
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
> +				arm_spe_pkt_out_string(&err, &buf, &blen, " LLC-ACCESS");
> +			if (payload & 0x200)
> +				arm_spe_pkt_out_string(&err, &buf, &blen, " LLC-REFILL");
> +			if (payload & 0x400)
> +				arm_spe_pkt_out_string(&err, &buf, &blen, " REMOTE-ACCESS");
>  		}
> -		if (ret < 0)
> -			return ret;
> -		blen -= ret;
> -		return buf_len - blen;
> -	}
> +		break;
>  	case ARM_SPE_OP_TYPE:
>  		switch (idx) {
> -		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
> -					"COND-SELECT" : "INSN-OTHER");
> -		case 1:	{
> -			size_t blen = buf_len;
> +		case 0:
> +			arm_spe_pkt_out_string(&err, &buf, &blen,
> +					payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
> +			break;
> +		case 1:
> +			arm_spe_pkt_out_string(&err, &buf, &blen,
> +					       payload & 0x1 ? "ST" : "LD");
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
> +					arm_spe_pkt_out_string(&err, &buf, &blen, " AT");
> +				if (payload & 0x8)
> +					arm_spe_pkt_out_string(&err, &buf, &blen, " EXCL");
> +				if (payload & 0x10)
> +					arm_spe_pkt_out_string(&err, &buf, &blen, " AR");
>  			} else if (payload & 0x4) {
> -				ret = snprintf(buf, buf_len, " SIMD-FP");
> -				buf += ret;
> -				blen -= ret;
> -			}
> -			if (ret < 0)
> -				return ret;
> -			blen -= ret;
> -			return buf_len - blen;
> -		}
> -		case 2:	{
> -			size_t blen = buf_len;
> -
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
> -			if (ret < 0)
> -				return ret;
> -			blen -= ret;
> -			return buf_len - blen;
> +				arm_spe_pkt_out_string(&err, &buf, &blen, " SIMD-FP");
>  			}
> -		default: return 0;
> +			break;
> +		case 2:
> +			arm_spe_pkt_out_string(&err, &buf, &blen, "B");
> +
> +			if (payload & 0x1)
> +				arm_spe_pkt_out_string(&err, &buf, &blen, " COND");
> +			if (payload & 0x2)
> +				arm_spe_pkt_out_string(&err, &buf, &blen, " IND");
> +
> +			break;
> +		default:
> +			/* Unknown index */
> +			err = -1;
> +			break;
>  		}
> +		break;
>  	case ARM_SPE_DATA_SOURCE:
>  	case ARM_SPE_TIMESTAMP:
> -		return snprintf(buf, buf_len, "%s %lld", name, payload);
> +		arm_spe_pkt_out_string(&err, &buf, &blen, "%s %lld", name, payload);
> +		break;
>  	case ARM_SPE_ADDRESS:
>  		switch (idx) {
>  		case 0:
> -		case 1: ns = !!(packet->payload & NS_FLAG);
> +		case 1:
> +			ns = !!(packet->payload & NS_FLAG);
>  			el = (packet->payload & EL_FLAG) >> 61;
>  			payload &= ~(0xffULL << 56);
> -			return snprintf(buf, buf_len, "%s 0x%llx el%d ns=%d",
> +			arm_spe_pkt_out_string(&err, &buf, &blen,
> +					"%s 0x%llx el%d ns=%d",
>  				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
> -		case 2:	return snprintf(buf, buf_len, "VA 0x%llx", payload);
> -		case 3:	ns = !!(packet->payload & NS_FLAG);
> +			break;
> +		case 2:
> +			arm_spe_pkt_out_string(&err, &buf, &blen,
> +					       "VA 0x%llx", payload);
> +			break;
> +		case 3:
> +			ns = !!(packet->payload & NS_FLAG);
>  			payload &= ~(0xffULL << 56);
> -			return snprintf(buf, buf_len, "PA 0x%llx ns=%d",
> -					payload, ns);
> -		default: return 0;
> +			arm_spe_pkt_out_string(&err, &buf, &blen,
> +					       "PA 0x%llx ns=%d", payload, ns);
> +			break;
> +		default:
> +			/* Unknown index */
> +			err = -1;
> +			break;
>  		}
> +		break;
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
> +		arm_spe_pkt_out_string(&err, &buf, &blen, "%s 0x%lx el%d",
> +				       name, (unsigned long)payload, idx + 1);
> +		break;
> +	case ARM_SPE_COUNTER:
> +		arm_spe_pkt_out_string(&err, &buf, &blen, "%s %d ", name,
> +				       (unsigned short)payload);
>  		switch (idx) {
> -		case 0:	ret = snprintf(buf, buf_len, "TOT"); break;
> -		case 1:	ret = snprintf(buf, buf_len, "ISSUE"); break;
> -		case 2:	ret = snprintf(buf, buf_len, "XLAT"); break;
> -		default: ret = 0;
> +		case 0:
> +			arm_spe_pkt_out_string(&err, &buf, &blen, "TOT");
> +			break;
> +		case 1:
> +			arm_spe_pkt_out_string(&err, &buf, &blen, "ISSUE");
> +			break;
> +		case 2:
> +			arm_spe_pkt_out_string(&err, &buf, &blen, "XLAT");
> +			break;
> +		default:
> +			break;
>  		}
> -		if (ret < 0)
> -			return ret;
> -		blen -= ret;
> -		return buf_len - blen;
> -	}
> +		break;
>  	default:
> +		/* Unknown packet type */
> +		err = -1;
>  		break;
>  	}
>  
> -	return snprintf(buf, buf_len, "%s 0x%llx (%d)",
> -			name, payload, packet->index);
> +	/* Output raw data if detect any error */
> +	if (err) {
> +		err = 0;
> +		arm_spe_pkt_out_string(&err, &buf_orig, &buf_len, "%s 0x%llx (%d)",
> +				       name, payload, packet->index);
> +	}
> +
> +	return err;
>  }
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 3882a5360ada..8901a1656a41 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -113,7 +113,7 @@ static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
>  		if (ret > 0) {
>  			ret = arm_spe_pkt_desc(&packet, desc,
>  					       ARM_SPE_PKT_DESC_MAX);
> -			if (ret > 0)
> +			if (!ret)
>  				color_fprintf(stdout, color, " %s\n", desc);
>  		} else {
>  			color_fprintf(stdout, color, " Bad packet!\n");
> -- 
> 2.17.1
> 

-- 

- Arnaldo

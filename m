Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E3C2AF551
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgKKPpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:45:36 -0500
Received: from foss.arm.com ([217.140.110.172]:56734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbgKKPpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:45:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2D7231B;
        Wed, 11 Nov 2020 07:45:33 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E8A83F718;
        Wed, 11 Nov 2020 07:45:31 -0800 (PST)
Subject: Re: [PATCH v8 06/22] perf arm-spe: Refactor printing string to buffer
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
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
        linux-kernel@vger.kernel.org
References: <20201111071149.815-1-leo.yan@linaro.org>
 <20201111071149.815-7-leo.yan@linaro.org>
 <20201111153555.GG355344@kernel.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <a1ca3412-3815-e2a8-0334-f3059802df6a@arm.com>
Date:   Wed, 11 Nov 2020 15:45:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201111153555.GG355344@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2020 15:35, Arnaldo Carvalho de Melo wrote:

Hi Arnaldo,

thanks for taking a look!

> Em Wed, Nov 11, 2020 at 03:11:33PM +0800, Leo Yan escreveu:
>> When outputs strings to the decoding buffer with function snprintf(),
>> SPE decoder needs to detects if any error returns from snprintf() and if
>> so needs to directly bail out.  If snprintf() returns success, it needs
>> to update buffer pointer and reduce the buffer length so can continue to
>> output the next string into the consequent memory space.
>>
>> This complex logics are spreading in the function arm_spe_pkt_desc() so
>> there has many duplicate codes for handling error detecting, increment
>> buffer pointer and decrement buffer size.
>>
>> To avoid the duplicate code, this patch introduces a new helper function
>> arm_spe_pkt_snprintf() which is used to wrap up the complex logics, and
>> it's used by the caller arm_spe_pkt_desc().
>>
>> This patch also moves the variable 'blen' as the function's local
>> variable, this allows to remove the unnecessary braces and improve the
>> readability.
>>
>> Suggested-by: Dave Martin <Dave.Martin@arm.com>
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 260 +++++++++---------
>>  1 file changed, 126 insertions(+), 134 deletions(-)
>>
>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>> index 04fd7fd7c15f..1970686f7020 100644
>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>> @@ -9,6 +9,7 @@
>>  #include <endian.h>
>>  #include <byteswap.h>
>>  #include <linux/bitops.h>
>> +#include <stdarg.h>
>>  
>>  #include "arm-spe-pkt-decoder.h"
>>  
>> @@ -258,192 +259,183 @@ int arm_spe_get_packet(const unsigned char *buf, size_t len,
>>  	return ret;
>>  }
>>  
>> +static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
>> +				const char *fmt, ...)
>> +{
>> +	va_list ap;
>> +	int ret;
>> +
>> +	/* Bail out if any error occurred */
>> +	if (err && *err)
>> +		return *err;
>> +
>> +	va_start(ap, fmt);
>> +	ret = vsnprintf(*buf_p, *blen, fmt, ap);
>> +	va_end(ap);
>> +
>> +	if (ret < 0) {
>> +		if (err && !*err)
>> +			*err = ret;
>> +
>> +	/*
>> +	 * A return value of (*blen - 1) or more means that the
>> +	 * output was truncated and the buffer is overrun.
>> +	 */
>> +	} else if (ret >= ((int)*blen - 1)) {
>> +		(*buf_p)[*blen - 1] = '\0';
>> +
>> +		/*
>> +		 * Set *err to 'ret' to avoid overflow if tries to
>> +		 * fill this buffer sequentially.
>> +		 */
>> +		if (err && !*err)
>> +			*err = ret;
>> +	} else {
>> +		*buf_p += ret;
>> +		*blen -= ret;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>  int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>>  		     size_t buf_len)
>>  {
>>  	int ret, ns, el, idx = packet->index;
>>  	unsigned long long payload = packet->payload;
>>  	const char *name = arm_spe_pkt_name(packet->type);
>> +	size_t blen = buf_len;
>> +	int err = 0;
>>  
>>  	switch (packet->type) {
>>  	case ARM_SPE_BAD:
>>  	case ARM_SPE_PAD:
>>  	case ARM_SPE_END:
>> -		return snprintf(buf, buf_len, "%s", name);
>> -	case ARM_SPE_EVENTS: {
>> -		size_t blen = buf_len;
>> -
>> -		ret = 0;
>> -		ret = snprintf(buf, buf_len, "EV");
>> -		buf += ret;
>> -		blen -= ret;
>> -		if (payload & 0x1) {
>> -			ret = snprintf(buf, buf_len, " EXCEPTION-GEN");
>> -			buf += ret;
>> -			blen -= ret;
>> -		}
>> -		if (payload & 0x2) {
>> -			ret = snprintf(buf, buf_len, " RETIRED");
>> -			buf += ret;
>> -			blen -= ret;
>> -		}
>> -		if (payload & 0x4) {
>> -			ret = snprintf(buf, buf_len, " L1D-ACCESS");
>> -			buf += ret;
>> -			blen -= ret;
>> -		}
>> -		if (payload & 0x8) {
>> -			ret = snprintf(buf, buf_len, " L1D-REFILL");
>> -			buf += ret;
>> -			blen -= ret;
>> -		}
>> -		if (payload & 0x10) {
>> -			ret = snprintf(buf, buf_len, " TLB-ACCESS");
>> -			buf += ret;
>> -			blen -= ret;
>> -		}
>> -		if (payload & 0x20) {
>> -			ret = snprintf(buf, buf_len, " TLB-REFILL");
>> -			buf += ret;
>> -			blen -= ret;
>> -		}
>> -		if (payload & 0x40) {
>> -			ret = snprintf(buf, buf_len, " NOT-TAKEN");
>> -			buf += ret;
>> -			blen -= ret;
>> -		}
>> -		if (payload & 0x80) {
>> -			ret = snprintf(buf, buf_len, " MISPRED");
>> -			buf += ret;
>> -			blen -= ret;
>> -		}
>> +		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s", name);
>> +	case ARM_SPE_EVENTS:
>> +		ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "EV");
>> +
>> +		if (payload & 0x1)
>> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCEPTION-GEN");
> 
> Isn't this 'ret +=' ? Otherwise if any of these arm_spe_pkt_snprintf()
> calls are made the previous 'ret' value is simply discarded. Can you
> clarify this?

ret is the same as err. If err is negative (from previous calls), we
return that straight away, so it does nothing but propagating the error.
That redundancy gets cleaned up in the next patch.

This patch split is somewhat cumbersome, but was done to simplify review
(originally 06 and 07 were one patch). The combined patch made it hard
to match the individual changes. If you feel unsure about it, or you
feel it looks better, you could also merge both 06/22 and 07/22 into a
single patch.

Hope that helps.

Cheers,
Andre.



> 
> I applied all patches before this one.
> 
> - Arnaldo
> 
>> +		if (payload & 0x2)
>> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " RETIRED");
>> +		if (payload & 0x4)
>> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-ACCESS");
>> +		if (payload & 0x8)
>> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-REFILL");
>> +		if (payload & 0x10)
>> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-ACCESS");
>> +		if (payload & 0x20)
>> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-REFILL");
>> +		if (payload & 0x40)
>> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " NOT-TAKEN");
>> +		if (payload & 0x80)
>> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " MISPRED");
>>  		if (idx > 1) {
>> -			if (payload & 0x100) {
>> -				ret = snprintf(buf, buf_len, " LLC-ACCESS");
>> -				buf += ret;
>> -				blen -= ret;
>> -			}
>> -			if (payload & 0x200) {
>> -				ret = snprintf(buf, buf_len, " LLC-REFILL");
>> -				buf += ret;
>> -				blen -= ret;
>> -			}
>> -			if (payload & 0x400) {
>> -				ret = snprintf(buf, buf_len, " REMOTE-ACCESS");
>> -				buf += ret;
>> -				blen -= ret;
>> -			}
>> +			if (payload & 0x100)
>> +				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-ACCESS");
>> +			if (payload & 0x200)
>> +				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-REFILL");
>> +			if (payload & 0x400)
>> +				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " REMOTE-ACCESS");
>>  		}
>>  		if (ret < 0)
>>  			return ret;
>>  		blen -= ret;
>>  		return buf_len - blen;
>> -	}
>>  	case ARM_SPE_OP_TYPE:
>>  		switch (idx) {
>> -		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
>> -					"COND-SELECT" : "INSN-OTHER");
>> -		case 1:	{
>> -			size_t blen = buf_len;
>> +		case 0:
>> +			return arm_spe_pkt_snprintf(&err, &buf, &blen,
>> +					payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
>> +		case 1:
>> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen,
>> +						   payload & 0x1 ? "ST" : "LD");
>>  
>> -			if (payload & 0x1)
>> -				ret = snprintf(buf, buf_len, "ST");
>> -			else
>> -				ret = snprintf(buf, buf_len, "LD");
>> -			buf += ret;
>> -			blen -= ret;
>>  			if (payload & 0x2) {
>> -				if (payload & 0x4) {
>> -					ret = snprintf(buf, buf_len, " AT");
>> -					buf += ret;
>> -					blen -= ret;
>> -				}
>> -				if (payload & 0x8) {
>> -					ret = snprintf(buf, buf_len, " EXCL");
>> -					buf += ret;
>> -					blen -= ret;
>> -				}
>> -				if (payload & 0x10) {
>> -					ret = snprintf(buf, buf_len, " AR");
>> -					buf += ret;
>> -					blen -= ret;
>> -				}
>> +				if (payload & 0x4)
>> +					ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " AT");
>> +				if (payload & 0x8)
>> +					ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCL");
>> +				if (payload & 0x10)
>> +					ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " AR");
>>  			} else if (payload & 0x4) {
>> -				ret = snprintf(buf, buf_len, " SIMD-FP");
>> -				buf += ret;
>> -				blen -= ret;
>> +				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " SIMD-FP");
>>  			}
>> +
>>  			if (ret < 0)
>>  				return ret;
>>  			blen -= ret;
>>  			return buf_len - blen;
>> -		}
>> -		case 2:	{
>> -			size_t blen = buf_len;
>>  
>> -			ret = snprintf(buf, buf_len, "B");
>> -			buf += ret;
>> -			blen -= ret;
>> -			if (payload & 0x1) {
>> -				ret = snprintf(buf, buf_len, " COND");
>> -				buf += ret;
>> -				blen -= ret;
>> -			}
>> -			if (payload & 0x2) {
>> -				ret = snprintf(buf, buf_len, " IND");
>> -				buf += ret;
>> -				blen -= ret;
>> -			}
>> +		case 2:
>> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "B");
>> +
>> +			if (payload & 0x1)
>> +				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " COND");
>> +			if (payload & 0x2)
>> +				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " IND");
>> +
>>  			if (ret < 0)
>>  				return ret;
>>  			blen -= ret;
>>  			return buf_len - blen;
>> -			}
>> -		default: return 0;
>> +
>> +		default:
>> +			return 0;
>>  		}
>>  	case ARM_SPE_DATA_SOURCE:
>>  	case ARM_SPE_TIMESTAMP:
>> -		return snprintf(buf, buf_len, "%s %lld", name, payload);
>> +		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %lld", name, payload);
>>  	case ARM_SPE_ADDRESS:
>>  		switch (idx) {
>>  		case 0:
>> -		case 1: ns = !!(packet->payload & NS_FLAG);
>> +		case 1:
>> +			ns = !!(packet->payload & NS_FLAG);
>>  			el = (packet->payload & EL_FLAG) >> 61;
>>  			payload &= ~(0xffULL << 56);
>> -			return snprintf(buf, buf_len, "%s 0x%llx el%d ns=%d",
>> +			return arm_spe_pkt_snprintf(&err, &buf, &blen,
>> +					"%s 0x%llx el%d ns=%d",
>>  				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
>> -		case 2:	return snprintf(buf, buf_len, "VA 0x%llx", payload);
>> -		case 3:	ns = !!(packet->payload & NS_FLAG);
>> +		case 2:
>> +			return arm_spe_pkt_snprintf(&err, &buf, &blen,
>> +						    "VA 0x%llx", payload);
>> +		case 3:
>> +			ns = !!(packet->payload & NS_FLAG);
>>  			payload &= ~(0xffULL << 56);
>> -			return snprintf(buf, buf_len, "PA 0x%llx ns=%d",
>> -					payload, ns);
>> -		default: return 0;
>> +			return arm_spe_pkt_snprintf(&err, &buf, &blen,
>> +						    "PA 0x%llx ns=%d", payload, ns);
>> +		default:
>> +			return 0;
>>  		}
>>  	case ARM_SPE_CONTEXT:
>> -		return snprintf(buf, buf_len, "%s 0x%lx el%d", name,
>> -				(unsigned long)payload, idx + 1);
>> -	case ARM_SPE_COUNTER: {
>> -		size_t blen = buf_len;
>> -
>> -		ret = snprintf(buf, buf_len, "%s %d ", name,
>> -			       (unsigned short)payload);
>> -		buf += ret;
>> -		blen -= ret;
>> +		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%lx el%d",
>> +					    name, (unsigned long)payload, idx + 1);
>> +	case ARM_SPE_COUNTER:
>> +		ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %d ", name,
>> +					   (unsigned short)payload);
>>  		switch (idx) {
>> -		case 0:	ret = snprintf(buf, buf_len, "TOT"); break;
>> -		case 1:	ret = snprintf(buf, buf_len, "ISSUE"); break;
>> -		case 2:	ret = snprintf(buf, buf_len, "XLAT"); break;
>> -		default: ret = 0;
>> +		case 0:
>> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "TOT");
>> +			break;
>> +		case 1:
>> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "ISSUE");
>> +			break;
>> +		case 2:
>> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "XLAT");
>> +			break;
>> +		default:
>> +			ret = 0;
>> +			break;
>>  		}
>>  		if (ret < 0)
>>  			return ret;
>>  		blen -= ret;
>>  		return buf_len - blen;
>> -	}
>>  	default:
>>  		break;
>>  	}
>>  
>> -	return snprintf(buf, buf_len, "%s 0x%llx (%d)",
>> -			name, payload, packet->index);
>> +	return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%llx (%d)",
>> +				    name, payload, packet->index);
>>  }
>> -- 
>> 2.17.1
>>
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929822A416B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgKCKO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:14:56 -0500
Received: from foss.arm.com ([217.140.110.172]:45806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgKCKOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:14:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15812139F;
        Tue,  3 Nov 2020 02:14:54 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4791C3F66E;
        Tue,  3 Nov 2020 02:14:52 -0800 (PST)
Subject: Re: [PATCH v6 06/21] perf arm-spe: Refactor printing string to buffer
To:     Leo Yan <leo.yan@linaro.org>, Dave Martin <Dave.Martin@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <James.Clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        Wei Li <liwei391@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201030025724.19157-1-leo.yan@linaro.org>
 <20201030025724.19157-7-leo.yan@linaro.org> <20201102170653.GB6882@arm.com>
 <20201103064047.GD13232@leoy-ThinkPad-X240s>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <2b7d74c6-898c-75b1-338f-142bd62860c9@arm.com>
Date:   Tue, 3 Nov 2020 10:13:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201103064047.GD13232@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2020 06:40, Leo Yan wrote:

Hi Dave, Leo,

> On Mon, Nov 02, 2020 at 05:06:53PM +0000, Dave Martin wrote:
>> On Fri, Oct 30, 2020 at 02:57:09AM +0000, Leo Yan wrote:
>>> When outputs strings to the decoding buffer with function snprintf(),
>>> SPE decoder needs to detects if any error returns from snprintf() and if
>>> so needs to directly bail out.  If snprintf() returns success, it needs
>>> to update buffer pointer and reduce the buffer length so can continue to
>>> output the next string into the consequent memory space.
>>>
>>> This complex logics are spreading in the function arm_spe_pkt_desc() so
>>> there has many duplicate codes for handling error detecting, increment
>>> buffer pointer and decrement buffer size.
>>>
>>> To avoid the duplicate code, this patch introduces a new helper function
>>> arm_spe_pkt_snprintf() which is used to wrap up the complex logics, and
>>> it's used by the caller arm_spe_pkt_desc(); if printing buffer is called
>>> for multiple times in a flow, the error is a cumulative value and simply
>>> returns its final value.
>>>
>>> This patch also moves the variable 'blen' as the function's local
>>> variable, this allows to remove the unnecessary braces and improve the
>>> readability.
>>>
>>> Suggested-by: Dave Martin <Dave.Martin@arm.com>
>>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>>
>> This looks like a good refacroting now, but as pointed out by Andre this
>> patch is now rather hard to review, since it combines the refactoring
>> with other changes.
>>
>> If reposting this series, it would be good if this could be split into a
>> first patch that introduces arm_spe_pkt_snprintf() and just updates each
>> snprintf() call site to use it, but without moving other code around or
>> optimising anything, followed by one or more patches that clean up and
>> simplify arm_spe_pkt_desc().
> 
> I will respin the patch set and follow this approach.

Well, I am afraid this is not easily possible.

Dave: this patch is basically following the pattern turning this:
===============
	if (condition) {
		ret = snprintf(buf, buf_len, "foo");
		buf += ret;
		blen -= ret;
	}
	...
	if (ret < 0)
		return ret;
	blen -= ret;
	return buf_len - blen;
===============
into this:
---------------
	if (condition)
		arm_spe_pkt_snprintf(&err, &buf, &blen, "foo");
	...
	return err ?: (int)(buf_len - blen);
---------------

And "diff" is getting really ahead of itself here and tries to be super
clever, which leads to this hard to read patch.

But I don't think there is anything we can really do here, this is
already the minimal version. Leo adds the optimisations only later on,
in other patches.

Cheers,
Andre


> 
>> If the series is otherwise mature though, then this rework may be
>> overkill.
>>
>>> ---
>>>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 267 ++++++++----------
>>>  1 file changed, 117 insertions(+), 150 deletions(-)
>>>
>>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>>> index 04fd7fd7c15f..1ecaf9805b79 100644
>>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>>> @@ -9,6 +9,7 @@
>>>  #include <endian.h>
>>>  #include <byteswap.h>
>>>  #include <linux/bitops.h>
>>> +#include <stdarg.h>
>>>  
>>>  #include "arm-spe-pkt-decoder.h"
>>>  
>>> @@ -258,192 +259,158 @@ int arm_spe_get_packet(const unsigned char *buf, size_t len,
>>>  	return ret;
>>>  }
>>>  
>>> +static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
>>> +				const char *fmt, ...)
>>> +{
>>> +	va_list ap;
>>> +	int ret;
>>> +
>>> +	/* Bail out if any error occurred */
>>> +	if (err && *err)
>>> +		return *err;
>>> +
>>> +	va_start(ap, fmt);
>>> +	ret = vsnprintf(*buf_p, *blen, fmt, ap);
>>> +	va_end(ap);
>>> +
>>> +	if (ret < 0) {
>>> +		if (err && !*err)
>>> +			*err = ret;
>>
>> What happens on buffer overrun (i.e., ret >= *blen)?
>>
>> It looks to me like we'll advance buf_p too far, blen will wrap around,
>> and the string at *buf_p won't be null terminated.  Because the return
>> value is still >= 0, this condition will be returned up the stack as
>> "success".
> 
> Thanks for pointint out this.  I never note for the potential issue
> caused by returned value (ret >= *blen);  checked again for the
> manual, it says:
> 
> "The functions snprintf() and vsnprintf() do not write more than size
> bytes (including the terminating null byte ('\0')).  If the output was
> truncated due to this limit, then the return value is the number of
> characters (excluding  the  terminating  null  byte) which would have
> been written to the final string if enough space had been available.
> Thus, a return value of size or more means that the output was
> truncated."
> 
>> Perhaps this can never happen given the actual buffer sizes and strings
>> being printed, but it feels a bit unsafe.
>>
>>
>> It may be better to clamp the adjustments to *buf_p and *blen to
>> *blen - 1 in this case, and explicitly set (*buf_p)[*blen - 1] to '\0'.
>> We _may_ want indicate failure in the return from arm_spe_pkt_desc() in
>> this situation, but I don't know enough about how this code is called to
>> enable me to judge that.
> 
> The caller arm_spe_dump() will print out the string if the return
> value > 0 [1]; so I think it can simply return the string length which
> has been written to the buffer (with the clamped value).  The function
> can be refined as below:
> 
> static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
> 				const char *fmt, ...)
> {
> 	va_list ap;
> 	int ret;
> 
> 	/* Bail out if any error occurred */
> 	if (err && *err)
> 		return *err;
> 
> 	va_start(ap, fmt);
> 	ret = vsnprintf(*buf_p, *blen - 1, fmt, ap);
> 	va_end(ap);
> 
> 	if (ret < 0) {
> 		if (err && !*err)
> 			*err = ret;
> 	} else {
> 
>                 /*
>                  * A return value of (*blen - 1) or more means that the
>                  * output was truncated and the buffer is overrun.
>                  */
>                 if (ret >= (*blen - 1)) {
>                         (*buf_p)[*blen - 1] = '\0';
> 
>                         /*
>                          * Set *err to -1 to avoid overflow if tries to
>                          * fill this buffer sequentially.
>                          */
> 		        if (err && !*err)
> 		        	*err = -1;
> 
>                         /* Clamp the size of characters printed */
>                         ret = min(ret, *blen);
>                 }
> 
> 		*buf_p += ret;
> 		*blen -= ret;
> 	}
> 
> 	return ret;
> }
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/arm-spe.c#n116
> 
>> (Note, this issue is not introduced by this patch, but this refactoring
>> makes it easier to address it in a single place -- so it may now be
>> worth doing so.)
> 
> Agree.
> 
>>> +	} else {
>>> +		*buf_p += ret;
>>> +		*blen -= ret;
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>  int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>>>  		     size_t buf_len)
>>>  {
>>> -	int ret, ns, el, idx = packet->index;
>>> +	int ns, el, idx = packet->index;
>>>  	unsigned long long payload = packet->payload;
>>>  	const char *name = arm_spe_pkt_name(packet->type);
>>> +	size_t blen = buf_len;
>>> +	int err = 0;
>>>  
>>>  	switch (packet->type) {
>>>  	case ARM_SPE_BAD:
>>>  	case ARM_SPE_PAD:
>>>  	case ARM_SPE_END:
>>> -		return snprintf(buf, buf_len, "%s", name);
>>> -	case ARM_SPE_EVENTS: {
>>> -		size_t blen = buf_len;
>>> -
>>> -		ret = 0;
>>> -		ret = snprintf(buf, buf_len, "EV");
>>> -		buf += ret;
>>> -		blen -= ret;
>>> -		if (payload & 0x1) {
>>> -			ret = snprintf(buf, buf_len, " EXCEPTION-GEN");
>>> -			buf += ret;
>>> -			blen -= ret;
>>> -		}
>>> -		if (payload & 0x2) {
>>> -			ret = snprintf(buf, buf_len, " RETIRED");
>>> -			buf += ret;
>>> -			blen -= ret;
>>> -		}
>>> -		if (payload & 0x4) {
>>> -			ret = snprintf(buf, buf_len, " L1D-ACCESS");
>>> -			buf += ret;
>>> -			blen -= ret;
>>> -		}
>>> -		if (payload & 0x8) {
>>> -			ret = snprintf(buf, buf_len, " L1D-REFILL");
>>> -			buf += ret;
>>> -			blen -= ret;
>>> -		}
>>> -		if (payload & 0x10) {
>>> -			ret = snprintf(buf, buf_len, " TLB-ACCESS");
>>> -			buf += ret;
>>> -			blen -= ret;
>>> -		}
>>> -		if (payload & 0x20) {
>>> -			ret = snprintf(buf, buf_len, " TLB-REFILL");
>>> -			buf += ret;
>>> -			blen -= ret;
>>> -		}
>>> -		if (payload & 0x40) {
>>> -			ret = snprintf(buf, buf_len, " NOT-TAKEN");
>>> -			buf += ret;
>>> -			blen -= ret;
>>> -		}
>>> -		if (payload & 0x80) {
>>> -			ret = snprintf(buf, buf_len, " MISPRED");
>>> -			buf += ret;
>>> -			blen -= ret;
>>> -		}
>>> +		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s", name);
>>> +	case ARM_SPE_EVENTS:
>>> +		arm_spe_pkt_snprintf(&err, &buf, &blen, "EV");
>>> +
>>> +		if (payload & 0x1)
>>> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCEPTION-GEN");
>>> +		if (payload & 0x2)
>>> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " RETIRED");
>>> +		if (payload & 0x4)
>>> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-ACCESS");
>>> +		if (payload & 0x8)
>>> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-REFILL");
>>> +		if (payload & 0x10)
>>> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-ACCESS");
>>> +		if (payload & 0x20)
>>> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-REFILL");
>>> +		if (payload & 0x40)
>>> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " NOT-TAKEN");
>>> +		if (payload & 0x80)
>>> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " MISPRED");
>>>  		if (idx > 1) {
>>> -			if (payload & 0x100) {
>>> -				ret = snprintf(buf, buf_len, " LLC-ACCESS");
>>> -				buf += ret;
>>> -				blen -= ret;
>>> -			}
>>> -			if (payload & 0x200) {
>>> -				ret = snprintf(buf, buf_len, " LLC-REFILL");
>>> -				buf += ret;
>>> -				blen -= ret;
>>> -			}
>>> -			if (payload & 0x400) {
>>> -				ret = snprintf(buf, buf_len, " REMOTE-ACCESS");
>>> -				buf += ret;
>>> -				blen -= ret;
>>> -			}
>>> +			if (payload & 0x100)
>>> +				arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-ACCESS");
>>> +			if (payload & 0x200)
>>> +				arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-REFILL");
>>> +			if (payload & 0x400)
>>> +				arm_spe_pkt_snprintf(&err, &buf, &blen, " REMOTE-ACCESS");
>>>  		}
>>> -		if (ret < 0)
>>> -			return ret;
>>> -		blen -= ret;
>>> -		return buf_len - blen;
>>
>> It looks like we now fall off the bottom of the switch() here.  It's
>> preferable to add a break, both to document the intended code flow, and
>> to avoid accidents if another case is added later.
> 
> Will do this.
> 
>>> -	}
>>> +		return err ?: (int)(buf_len - blen);
>>
>> Nit: unexplained type cast.  Does the result definitely fit into an int?
>> If not, why doesn't it matter?
> 
> The case is to dismiss the compiler warning.
> 
> GCC doesn't compliant for the code:
> 
>   return buf_len - blen;
>   
> But GCC compliants type mismatch after change to code:
> 
>   return err ?: buf_len - blen;
> 
>> Also:
>>
>> If the actual return value is important for the caller to determine the
>> number of bytes appended, then it would be better to compute it in one
>> place.  Otherwise, it would be better to squash all success returns to 0,
>> rather than spend effort computing a value that may be misleading or
>> wrong anyway.
>>
>> In its current form, it's tricky to see whether this patch derives the
>> return value consistently for all cases.  In particular, if some code
>> patch does one or more arm_spe_pkt_snprintf(), followed by a
>> return arm_spe_pkt_snprintf(); then the return value (which only takes
>> the last arm_spe_pkt_desc() into account) would be wrong.  It would be
>> preferable if the return value for the success case were always
>> computed from buf_len and blen, to avoid this risk.  (I'm not saying
>> this bug exists, just that it's hard to see from the patch that it
>> doesn't exist.)
> 
> I think I can go back to return value "buf_len - blen" and don't
> check "err" anymore.
> 
> If the string buffer is truncated due to size limitation, we can still
> return "buf_len - blen" so can allow caller to dump string as
> possible.
> 
> If arm_spe_pkt_snprintf() returns -1 at the first call, "buf_len" is
> equal to "blen", thus return value of "buf_len - blen" will be zero.
> For this case, the caller will get to know there have no valid string
> and will skip to print anything.
> 
> Does this make sense?
> 
>>> +
>>>  	case ARM_SPE_OP_TYPE:
>>>  		switch (idx) {
>>> -		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
>>> -					"COND-SELECT" : "INSN-OTHER");
>>> -		case 1:	{
>>> -			size_t blen = buf_len;
>>> +		case 0:
>>> +			return arm_spe_pkt_snprintf(&err, &buf, &blen,
>>> +					payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
>>> +		case 1:
>>> +			arm_spe_pkt_snprintf(&err, &buf, &blen,
>>> +					     payload & 0x1 ? "ST" : "LD");
>>>  
>>> -			if (payload & 0x1)
>>> -				ret = snprintf(buf, buf_len, "ST");
>>> -			else
>>> -				ret = snprintf(buf, buf_len, "LD");
>>> -			buf += ret;
>>> -			blen -= ret;
>>>  			if (payload & 0x2) {
>>> -				if (payload & 0x4) {
>>> -					ret = snprintf(buf, buf_len, " AT");
>>> -					buf += ret;
>>> -					blen -= ret;
>>> -				}
>>> -				if (payload & 0x8) {
>>> -					ret = snprintf(buf, buf_len, " EXCL");
>>> -					buf += ret;
>>> -					blen -= ret;
>>> -				}
>>> -				if (payload & 0x10) {
>>> -					ret = snprintf(buf, buf_len, " AR");
>>> -					buf += ret;
>>> -					blen -= ret;
>>> -				}
>>> +				if (payload & 0x4)
>>> +					arm_spe_pkt_snprintf(&err, &buf, &blen, " AT");
>>> +				if (payload & 0x8)
>>> +					arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCL");
>>> +				if (payload & 0x10)
>>> +					arm_spe_pkt_snprintf(&err, &buf, &blen, " AR");
>>>  			} else if (payload & 0x4) {
>>> -				ret = snprintf(buf, buf_len, " SIMD-FP");
>>> -				buf += ret;
>>> -				blen -= ret;
>>> -			}
>>> -			if (ret < 0)
>>> -				return ret;
>>> -			blen -= ret;
>>> -			return buf_len - blen;
>>> -		}
>>> -		case 2:	{
>>> -			size_t blen = buf_len;
>>> -
>>> -			ret = snprintf(buf, buf_len, "B");
>>> -			buf += ret;
>>> -			blen -= ret;
>>> -			if (payload & 0x1) {
>>> -				ret = snprintf(buf, buf_len, " COND");
>>> -				buf += ret;
>>> -				blen -= ret;
>>> -			}
>>> -			if (payload & 0x2) {
>>> -				ret = snprintf(buf, buf_len, " IND");
>>> -				buf += ret;
>>> -				blen -= ret;
>>> +				arm_spe_pkt_snprintf(&err, &buf, &blen, " SIMD-FP");
>>>  			}
>>> -			if (ret < 0)
>>> -				return ret;
>>> -			blen -= ret;
>>> -			return buf_len - blen;
>>> -			}
>>> -		default: return 0;
>>> +
>>> +			return err ?: (int)(buf_len - blen);
>>> +
>>> +		case 2:
>>> +			arm_spe_pkt_snprintf(&err, &buf, &blen, "B");
>>> +
>>> +			if (payload & 0x1)
>>> +				arm_spe_pkt_snprintf(&err, &buf, &blen, " COND");
>>> +			if (payload & 0x2)
>>> +				arm_spe_pkt_snprintf(&err, &buf, &blen, " IND");
>>> +
>>> +			return err ?: (int)(buf_len - blen);
>>> +
>>> +		default:
>>> +			return 0;
>>>  		}
>>>  	case ARM_SPE_DATA_SOURCE:
>>>  	case ARM_SPE_TIMESTAMP:
>>> -		return snprintf(buf, buf_len, "%s %lld", name, payload);
>>> +		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %lld", name, payload);
>>>  	case ARM_SPE_ADDRESS:
>>>  		switch (idx) {
>>>  		case 0:
>>>  		case 1: ns = !!(packet->payload & NS_FLAG);
>>>  			el = (packet->payload & EL_FLAG) >> 61;
>>>  			payload &= ~(0xffULL << 56);
>>> -			return snprintf(buf, buf_len, "%s 0x%llx el%d ns=%d",
>>> +			return arm_spe_pkt_snprintf(&err, &buf, &blen,
>>> +					"%s 0x%llx el%d ns=%d",
>>>  				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
>>> -		case 2:	return snprintf(buf, buf_len, "VA 0x%llx", payload);
>>> +		case 2:
>>> +			return arm_spe_pkt_snprintf(&err, &buf, &blen,
>>> +						    "VA 0x%llx", payload);
>>>  		case 3:	ns = !!(packet->payload & NS_FLAG);
>>>  			payload &= ~(0xffULL << 56);
>>> -			return snprintf(buf, buf_len, "PA 0x%llx ns=%d",
>>> -					payload, ns);
>>> -		default: return 0;
>>> +			return arm_spe_pkt_snprintf(&err, &buf, &blen,
>>> +						    "PA 0x%llx ns=%d", payload, ns);
>>> +		default:
>>> +			return 0;
>>>  		}
>>>  	case ARM_SPE_CONTEXT:
>>> -		return snprintf(buf, buf_len, "%s 0x%lx el%d", name,
>>> -				(unsigned long)payload, idx + 1);
>>> -	case ARM_SPE_COUNTER: {
>>> -		size_t blen = buf_len;
>>> -
>>> -		ret = snprintf(buf, buf_len, "%s %d ", name,
>>> -			       (unsigned short)payload);
>>> -		buf += ret;
>>> -		blen -= ret;
>>> +		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%lx el%d",
>>> +					    name, (unsigned long)payload, idx + 1);
>>> +	case ARM_SPE_COUNTER:
>>> +		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %d ", name,
>>> +				     (unsigned short)payload);
>>> +
>>>  		switch (idx) {
>>> -		case 0:	ret = snprintf(buf, buf_len, "TOT"); break;
>>> -		case 1:	ret = snprintf(buf, buf_len, "ISSUE"); break;
>>> -		case 2:	ret = snprintf(buf, buf_len, "XLAT"); break;
>>> -		default: ret = 0;
>>> +		case 0:
>>> +			arm_spe_pkt_snprintf(&err, &buf, &blen, "TOT");
>>> +			break;
>>> +		case 1:
>>> +			arm_spe_pkt_snprintf(&err, &buf, &blen, "ISSUE");
>>> +			break;
>>> +		case 2:
>>> +			arm_spe_pkt_snprintf(&err, &buf, &blen, "XLAT");
>>> +			break;
>>> +		default:
>>> +			break;
>>>  		}
>>> -		if (ret < 0)
>>> -			return ret;
>>> -		blen -= ret;
>>> -		return buf_len - blen;
>>> -	}
>>> +
>>> +		return err ?: (int)(buf_len - blen);
>>> +
>>>  	default:
>>>  		break;
>>>  	}
>>>  
>>> -	return snprintf(buf, buf_len, "%s 0x%llx (%d)",
>>> -			name, payload, packet->index);
>>> +	return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%llx (%d)",
>>> +				    name, payload, packet->index);
>>
>> Otherwise, the patch looks generally OK, but I'd like to see an answer
>> on my points above.
> 
> Thanks a lot for reviewing!
> 
> Leo
> 


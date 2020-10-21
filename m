Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AB9294A7A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 11:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395368AbgJUJ1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 05:27:00 -0400
Received: from foss.arm.com ([217.140.110.172]:60778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395255AbgJUJ07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 05:26:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A803F31B;
        Wed, 21 Oct 2020 02:26:58 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 049133F66E;
        Wed, 21 Oct 2020 02:26:56 -0700 (PDT)
Subject: Re: [PATCH v2 14/14] perf arm-spe: Add support for ARMv8.3-SPE
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
 <20200929133917.9224-15-leo.yan@linaro.org>
 <9c74082b-fccf-7713-b98d-50da76c5d7af@arm.com>
 <20201021051031.GE7226@leoy-ThinkPad-X240s>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <df1faa9b-d8cb-ebcf-b70f-3672a6d8db1f@arm.com>
Date:   Wed, 21 Oct 2020 10:26:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201021051031.GE7226@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2020 06:10, Leo Yan wrote:

Hi,

> On Tue, Oct 20, 2020 at 10:54:44PM +0100, Andrï¿½ Przywara wrote:
>> On 29/09/2020 14:39, Leo Yan wrote:
>>
>> Hi,
>>
>>> From: Wei Li <liwei391@huawei.com>
>>>
>>> This patch is to support Armv8.3 extension for SPE, it adds alignment
>>> field in the Events packet and it supports the Scalable Vector Extension
>>> (SVE) for Operation packet and Events packet with two additions:
>>>
>>>   - The vector length for SVE operations in the Operation Type packet;
>>>   - The incomplete predicate and empty predicate fields in the Events
>>>     packet.
>>>
>>> Signed-off-by: Wei Li <liwei391@huawei.com>
>>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>>> ---
>>>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 84 ++++++++++++++++++-
>>>  .../arm-spe-decoder/arm-spe-pkt-decoder.h     |  6 ++
>>>  2 files changed, 87 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>>> index 05a4c74399d7..3ec381fddfcb 100644
>>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>>> @@ -342,14 +342,73 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>>>  					return ret;
>>>  			}
>>>  		}
>>> +		if (idx > 2) {
>>
>> As I mentioned in the other patch, I doubt this extra comparison is
>> useful. Does that protect us from anything?
> 
> It's the same reason with Event packet which have explained for replying
> patch 10, the condition is to respect the SPE specifiction:
> 
>   E[11], byte 1, bit [11], when SZ == 0b10 , or SZ == 0b11
>      Alignment.
>      ...
>      Otherwise this bit reads-as-zero.
> 
> So we gives higher priority for checking payload size than the Event
> bit setting; if you have other thinking for this, please let me know.

Ah, thanks for pointing this out. It looks like a bug in the manual
then, because I don't see why bit 11 should be any different from bits
[10:8] and bits [15:12] in this respect. And in the diagrams above you
clearly see bit 11 being shown even when SZ == 0b01.

I will try to follow this up here.

>>> +			if (payload & SPE_EVT_PKT_ALIGNMENT) {
>>
>> Mmh, but this is bit 11, right?
> 
> Yes.
> 
>> So would need to go into the (idx > 1)
>> section (covering bits 8-15)? Another reason to ditch this comparison above.
> 
> As has explained in patch 10, idx is not the same thing with "sz"
> field; "idx" stands for payload length in bytes, so:
> 
>   idx = 1 << sz
> 
> The spec defines the sz is 2 or 3, thus idx is 4 or 8; so this is why
> here use the condition "(idx > 2)".
> 
> I think here need to refine code for more explict expression so can
> avoid confusion.  So I think it's better to condition such like:
> 
>   if (payload_len >= 4) {

Yes, that would be (or have been) more helpful, but as mentioned in the
other patch, I'd rather see those comparisons go entirely.

Cheers,
Andre

> 
>      ...
> 
>   }
> 
>>> +				ret = snprintf(buf, buf_len, " ALIGNMENT");
>>> +				if (ret < 0)
>>> +					return ret;
>>> +				buf += ret;
>>> +				blen -= ret;
>>
>> Shouldn't we use the new arm_spe_pkt_snprintf() function here as well?
>> Or is there a reason that this doesn't work?
> 
> Goot point.  Will change to use arm_spe_pkt_snprintf().
> 
>>> +			}
>>> +			if (payload & SPE_EVT_PKT_SVE_PARTIAL_PREDICATE) {
>>> +				ret = snprintf(buf, buf_len, " SVE-PARTIAL-PRED");
>>> +				if (ret < 0)
>>> +					return ret;
>>> +				buf += ret;
>>> +				blen -= ret;
>>> +			}
>>> +			if (payload & SPE_EVT_PKT_SVE_EMPTY_PREDICATE) {
>>> +				ret = snprintf(buf, buf_len, " SVE-EMPTY-PRED");
>>> +				if (ret < 0)
>>> +					return ret;
>>> +				buf += ret;
>>> +				blen -= ret;
>>> +			}
>>> +		}
>>> +
>>>  		return buf_len - blen;
>>>  
>>>  	case ARM_SPE_OP_TYPE:
>>>  		switch (idx) {
>>>  		case SPE_OP_PKT_HDR_CLASS_OTHER:
>>> -			return arm_spe_pkt_snprintf(&buf, &blen,
>>> -					payload & SPE_OP_PKT_OTHER_SUBCLASS_COND ?
>>> -					"COND-SELECT" : "INSN-OTHER");
>>> +			if ((payload & SPE_OP_PKT_OTHER_SVE_SUBCLASS_MASK) ==
>>> +					SPE_OP_PKT_OTHER_SUBCLASS_SVG_OP) {
>>> +
>>> +				ret = arm_spe_pkt_snprintf(&buf, &blen, "SVE-OTHER");
>>> +				if (ret < 0)
>>> +					return ret;
>>> +
>>> +				/* Effective vector length: step is 32 bits */
>>> +				ret = arm_spe_pkt_snprintf(&buf, &blen, " EVLEN %d",
>>> +					32 << ((payload & SPE_OP_PKT_SVE_EVL_MASK) >>
>>> +						SPE_OP_PKT_SVE_EVL_SHIFT));
>>
>> Can you move this into a macro, and add a comment about how this works?
>> People might get confused over the "32 << something".
> 
> Yeah, will refine for it.
> 
> Thanks,
> Leo
> 


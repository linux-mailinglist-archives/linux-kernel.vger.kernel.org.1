Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705B127AF88
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 16:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgI1OAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 10:00:16 -0400
Received: from foss.arm.com ([217.140.110.172]:52112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgI1OAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:00:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B87681063;
        Mon, 28 Sep 2020 07:00:14 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 672023F73B;
        Mon, 28 Sep 2020 07:00:12 -0700 (PDT)
Subject: Re: [PATCH 5/5] perf: arm_spe: Decode SVE events
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        linux-arm-kernel@lists.infradead.org, Wei Li <liwei391@huawei.com>
References: <20200922101225.183554-1-andre.przywara@arm.com>
 <20200922101225.183554-6-andre.przywara@arm.com>
 <20200928132114.GF6642@arm.com>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <8efd63eb-5ae7-0f9a-6c37-ef5e68af4e6c@arm.com>
Date:   Mon, 28 Sep 2020 14:59:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200928132114.GF6642@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2020 14:21, Dave Martin wrote:

Hi Dave,

> On Tue, Sep 22, 2020 at 11:12:25AM +0100, Andre Przywara wrote:
>> The Scalable Vector Extension (SVE) is an ARMv8 architecture extension
>> that introduces very long vector operations (up to 2048 bits).
> 
> (8192, in fact, though don't expect to see that on real hardware any
> time soon...  qemu and the Arm fast model can do it, though.)
> 
>> The SPE profiling feature can tag SVE instructions with additional
>> properties like predication or the effective vector length.
>>
>> Decode the new operation type bits in the SPE decoder to allow the perf
>> tool to correctly report about SVE instructions.
> 
> 
> I don't know anything about SPE, so just commenting on a few minor
> things that catch my eye here.

Many thanks for taking a look!
Please note that I actually missed a prior submission by Wei, so the
code changes here will end up in:
https://lore.kernel.org/patchwork/patch/1288413/

But your two points below magically apply to his patch as well, so....

> 
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 48 ++++++++++++++++++-
>>  1 file changed, 47 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>> index a033f34846a6..f0c369259554 100644
>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>> @@ -372,8 +372,35 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>>  	}
>>  	case ARM_SPE_OP_TYPE:
>>  		switch (idx) {
>> -		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
>> +		case 0: {
>> +			size_t blen = buf_len;
>> +
>> +			if ((payload & 0x89) == 0x08) {
>> +				ret = snprintf(buf, buf_len, "SVE");
>> +				buf += ret;
>> +				blen -= ret;
> 
> (Nit: can ret be < 0 ?  I've never been 100% clear on this myself for
> the s*printf() family -- if this assumption is widespread in perf tool
> a lready that I guess just go with the flow.)

Yeah, some parts of the code in here check for -1, actually, but doing
this on every call to snprintf would push this current code over the
edge - and I cowardly avoided a refactoring ;-)

Please note that his is perf userland, and also we are printing constant
strings here.
Although admittedly this starts to sounds like an excuse now ...

> I wonder if this snprintf+increment+decrement sequence could be wrapped
> up as a helper, rather than having to be repeated all over the place.

Yes, I was hoping nobody would notice ;-)

>> +				if (payload & 0x2)
>> +					ret = snprintf(buf, buf_len, " FP");
>> +				else
>> +					ret = snprintf(buf, buf_len, " INT");
>> +				buf += ret;
>> +				blen -= ret;
>> +				if (payload & 0x4) {
>> +					ret = snprintf(buf, buf_len, " PRED");
>> +					buf += ret;
>> +					blen -= ret;
>> +				}
>> +				/* Bits [7..4] encode the vector length */
>> +				ret = snprintf(buf, buf_len, " EVLEN%d",
>> +					       32 << ((payload >> 4) & 0x7));
> 
> Isn't this just extracting 3 bits (0x7)? 

Ah, right, the comment is wrong. It's actually bits [6:4].

> And what unit are we aiming
> for here: is it the number of bytes per vector, or something else?  I'm
> confused by the fact that this will go up in steps of 32, which doesn't
> seem to match up to the architecure.

So this is how SPE encodes the effective vector length in its payload:
the format is described in section "D10.2.7 Operation Type packet" in a
(recent) ARMv8 ARM. I put the above statement in a C file and ran all
input values through it, it produced the exact *bit* length values as in
the spec.

Is there any particular pattern you are concerned about?
I admit this is somewhat hackish, I can do an extra function to put some
comments in there.

> 
> I notice that bit 7 has to be zero to get into this if() though.
> 
>> +				buf += ret;
>> +				blen -= ret;
>> +				return buf_len - blen;
>> +			}
>> +
>> +			return snprintf(buf, buf_len, "%s", payload & 0x1 ?
>>  					"COND-SELECT" : "INSN-OTHER");
>> +			}
>>  		case 1:	{
>>  			size_t blen = buf_len;
>>  
>> @@ -403,6 +430,25 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>>  				ret = snprintf(buf, buf_len, " NV-SYSREG");
>>  				buf += ret;
>>  				blen -= ret;
>> +			} else if ((payload & 0x0a) == 0x08) {
>> +				ret = snprintf(buf, buf_len, " SVE");
>> +				buf += ret;
>> +				blen -= ret;
>> +				if (payload & 0x4) {
>> +					ret = snprintf(buf, buf_len, " PRED");
>> +					buf += ret;
>> +					blen -= ret;
>> +				}
>> +				if (payload & 0x80) {
>> +					ret = snprintf(buf, buf_len, " SG");
>> +					buf += ret;
>> +					blen -= ret;
>> +				}
>> +				/* Bits [7..4] encode the vector length */
>> +				ret = snprintf(buf, buf_len, " EVLEN%d",
>> +					       32 << ((payload >> 4) & 0x7));
> 
> Same comment as above.  Maybe have a common helper for decoding the
> vector length bits so it can be fixed in a single place?

Yup. Although I wonder if this is the smallest of the problems with this
function going forward.

Cheers,
Andre

> 
>> +				buf += ret;
>> +				blen -= ret;
>>  			} else if (payload & 0x4) {
>>  				ret = snprintf(buf, buf_len, " SIMD-FP");
>>  				buf += ret;
> 
> Cheers
> ---Dave
> 


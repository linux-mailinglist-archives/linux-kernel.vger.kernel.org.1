Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9842944C0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 23:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410022AbgJTVzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 17:55:10 -0400
Received: from foss.arm.com ([217.140.110.172]:56486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392428AbgJTVzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 17:55:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B03A21FB;
        Tue, 20 Oct 2020 14:55:08 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2CC43F66B;
        Tue, 20 Oct 2020 14:55:06 -0700 (PDT)
Subject: Re: [PATCH v2 10/14] perf arm-spe: Refactor event type handling
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
 <20200929133917.9224-11-leo.yan@linaro.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 xsFNBFNPCKMBEAC+6GVcuP9ri8r+gg2fHZDedOmFRZPtcrMMF2Cx6KrTUT0YEISsqPoJTKld
 tPfEG0KnRL9CWvftyHseWTnU2Gi7hKNwhRkC0oBL5Er2hhNpoi8x4VcsxQ6bHG5/dA7ctvL6
 kYvKAZw4X2Y3GTbAZIOLf+leNPiF9175S8pvqMPi0qu67RWZD5H/uT/TfLpvmmOlRzNiXMBm
 kGvewkBpL3R2clHquv7pB6KLoY3uvjFhZfEedqSqTwBVu/JVZZO7tvYCJPfyY5JG9+BjPmr+
 REe2gS6w/4DJ4D8oMWKoY3r6ZpHx3YS2hWZFUYiCYovPxfj5+bOr78sg3JleEd0OB0yYtzTT
 esiNlQpCo0oOevwHR+jUiaZevM4xCyt23L2G+euzdRsUZcK/M6qYf41Dy6Afqa+PxgMEiDto
 ITEH3Dv+zfzwdeqCuNU0VOGrQZs/vrKOUmU/QDlYL7G8OIg5Ekheq4N+Ay+3EYCROXkstQnf
 YYxRn5F1oeVeqoh1LgGH7YN9H9LeIajwBD8OgiZDVsmb67DdF6EQtklH0ycBcVodG1zTCfqM
 AavYMfhldNMBg4vaLh0cJ/3ZXZNIyDlV372GmxSJJiidxDm7E1PkgdfCnHk+pD8YeITmSNyb
 7qeU08Hqqh4ui8SSeUp7+yie9zBhJB5vVBJoO5D0MikZAODIDwARAQABzS1BbmRyZSBQcnp5
 d2FyYSAoQVJNKSA8YW5kcmUucHJ6eXdhcmFAYXJtLmNvbT7CwXsEEwECACUCGwMGCwkIBwMC
 BhUIAgkKCwQWAgMBAh4BAheABQJTWSV8AhkBAAoJEAL1yD+ydue63REP/1tPqTo/f6StS00g
 NTUpjgVqxgsPWYWwSLkgkaUZn2z9Edv86BLpqTY8OBQZ19EUwfNehcnvR+Olw+7wxNnatyxo
 D2FG0paTia1SjxaJ8Nx3e85jy6l7N2AQrTCFCtFN9lp8Pc0LVBpSbjmP+Peh5Mi7gtCBNkpz
 KShEaJE25a/+rnIrIXzJHrsbC2GwcssAF3bd03iU41J1gMTalB6HCtQUwgqSsbG8MsR/IwHW
 XruOnVp0GQRJwlw07e9T3PKTLj3LWsAPe0LHm5W1Q+euoCLsZfYwr7phQ19HAxSCu8hzp43u
 zSw0+sEQsO+9wz2nGDgQCGepCcJR1lygVn2zwRTQKbq7Hjs+IWZ0gN2nDajScuR1RsxTE4WR
 lj0+Ne6VrAmPiW6QqRhliDO+e82riI75ywSWrJb9TQw0+UkIQ2DlNr0u0TwCUTcQNN6aKnru
 ouVt3qoRlcD5MuRhLH+ttAcmNITMg7GQ6RQajWrSKuKFrt6iuDbjgO2cnaTrLbNBBKPTG4oF
 D6kX8Zea0KvVBagBsaC1CDTDQQMxYBPDBSlqYCb/b2x7KHTvTAHUBSsBRL6MKz8wwruDodTM
 4E4ToV9URl4aE/msBZ4GLTtEmUHBh4/AYwk6ACYByYKyx5r3PDG0iHnJ8bV0OeyQ9ujfgBBP
 B2t4oASNnIOeGEEcQ2rjzsFNBFNPCKMBEACm7Xqafb1Dp1nDl06aw/3O9ixWsGMv1Uhfd2B6
 it6wh1HDCn9HpekgouR2HLMvdd3Y//GG89irEasjzENZPsK82PS0bvkxxIHRFm0pikF4ljIb
 6tca2sxFr/H7CCtWYZjZzPgnOPtnagN0qVVyEM7L5f7KjGb1/o5EDkVR2SVSSjrlmNdTL2Rd
 zaPqrBoxuR/y/n856deWqS1ZssOpqwKhxT1IVlF6S47CjFJ3+fiHNjkljLfxzDyQXwXCNoZn
 BKcW9PvAMf6W1DGASoXtsMg4HHzZ5fW+vnjzvWiC4pXrcP7Ivfxx5pB+nGiOfOY+/VSUlW/9
 GdzPlOIc1bGyKc6tGREH5lErmeoJZ5k7E9cMJx+xzuDItvnZbf6RuH5fg3QsljQy8jLlr4S6
 8YwxlObySJ5K+suPRzZOG2+kq77RJVqAgZXp3Zdvdaov4a5J3H8pxzjj0yZ2JZlndM4X7Msr
 P5tfxy1WvV4Km6QeFAsjcF5gM+wWl+mf2qrlp3dRwniG1vkLsnQugQ4oNUrx0ahwOSm9p6kM
 CIiTITo+W7O9KEE9XCb4vV0ejmLlgdDV8ASVUekeTJkmRIBnz0fa4pa1vbtZoi6/LlIdAEEt
 PY6p3hgkLLtr2GRodOW/Y3vPRd9+rJHq/tLIfwc58ZhQKmRcgrhtlnuTGTmyUqGSiMNfpwAR
 AQABwsFfBBgBAgAJBQJTTwijAhsMAAoJEAL1yD+ydue64BgP/33QKczgAvSdj9XTC14wZCGE
 U8ygZwkkyNf021iNMj+o0dpLU48PIhHIMTXlM2aiiZlPWgKVlDRjlYuc9EZqGgbOOuR/pNYA
 JX9vaqszyE34JzXBL9DBKUuAui8z8GcxRcz49/xtzzP0kH3OQbBIqZWuMRxKEpRptRT0wzBL
 O31ygf4FRxs68jvPCuZjTGKELIo656/Hmk17cmjoBAJK7JHfqdGkDXk5tneeHCkB411p9WJU
 vMO2EqsHjobjuFm89hI0pSxlUoiTL0Nuk9Edemjw70W4anGNyaQtBq+qu1RdjUPBvoJec7y/
 EXJtoGxq9Y+tmm22xwApSiIOyMwUi9A1iLjQLmngLeUdsHyrEWTbEYHd2sAM2sqKoZRyBDSv
 ejRvZD6zwkY/9nRqXt02H1quVOP42xlkwOQU6gxm93o/bxd7S5tEA359Sli5gZRaucpNQkwd
 KLQdCvFdksD270r4jU/rwR2R/Ubi+txfy0dk2wGBjl1xpSf0Lbl/KMR5TQntELfLR4etizLq
 Xpd2byn96Ivi8C8u9zJruXTueHH8vt7gJ1oax3yKRGU5o2eipCRiKZ0s/T7fvkdq+8beg9ku
 fDO4SAgJMIl6H5awliCY2zQvLHysS/Wb8QuB09hmhLZ4AifdHyF1J5qeePEhgTA+BaUbiUZf
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <2605044c-8172-00cf-e924-ece5a0b70e2c@arm.com>
Date:   Tue, 20 Oct 2020 22:54:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200929133917.9224-11-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2020 14:39, Leo Yan wrote:

Hi,

> Use macros instead of the enum values for event types, this is more
> directive and without bit shifting when parse packet.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  .../util/arm-spe-decoder/arm-spe-decoder.c    | 16 +++++++-------
>  .../util/arm-spe-decoder/arm-spe-decoder.h    | 17 --------------
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 22 +++++++++----------
>  .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 16 ++++++++++++++
>  4 files changed, 35 insertions(+), 36 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> index 9d3de163d47c..ac66e7f42a58 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> @@ -168,31 +168,31 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>  		case ARM_SPE_OP_TYPE:
>  			break;
>  		case ARM_SPE_EVENTS:
> -			if (payload & BIT(EV_L1D_REFILL))
> +			if (payload & SPE_EVT_PKT_L1D_REFILL)

Not sure this (and the others below) are an improvement? I liked the
enum below, and reading BIT() here tells me that it's a bitmask.

>  				decoder->record.type |= ARM_SPE_L1D_MISS;
>  
> -			if (payload & BIT(EV_L1D_ACCESS))
> +			if (payload & SPE_EVT_PKT_L1D_ACCESS)
>  				decoder->record.type |= ARM_SPE_L1D_ACCESS;
>  
> -			if (payload & BIT(EV_TLB_WALK))
> +			if (payload & SPE_EVT_PKT_TLB_WALK)
>  				decoder->record.type |= ARM_SPE_TLB_MISS;
>  
> -			if (payload & BIT(EV_TLB_ACCESS))
> +			if (payload & SPE_EVT_PKT_TLB_ACCESS)
>  				decoder->record.type |= ARM_SPE_TLB_ACCESS;
>  
>  			if ((idx == 2 || idx == 4 || idx == 8) &&
> -			    (payload & BIT(EV_LLC_MISS)))
> +			    (payload & SPE_EVT_PKT_LLC_MISS))
>  				decoder->record.type |= ARM_SPE_LLC_MISS;
>  
>  			if ((idx == 2 || idx == 4 || idx == 8) &&
> -			    (payload & BIT(EV_LLC_ACCESS)))
> +			    (payload & SPE_EVT_PKT_LLC_ACCESS))
>  				decoder->record.type |= ARM_SPE_LLC_ACCESS;
>  
>  			if ((idx == 2 || idx == 4 || idx == 8) &&
> -			    (payload & BIT(EV_REMOTE_ACCESS)))
> +			    (payload & SPE_EVT_PKT_REMOTE_ACCESS))
>  				decoder->record.type |= ARM_SPE_REMOTE_ACCESS;
>  
> -			if (payload & BIT(EV_MISPRED))
> +			if (payload & SPE_EVT_PKT_MISPREDICTED)
>  				decoder->record.type |= ARM_SPE_BRANCH_MISS;
>  
>  			break;
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> index a5111a8d4360..24727b8ca7ff 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -13,23 +13,6 @@
>  
>  #include "arm-spe-pkt-decoder.h"
>  
> -enum arm_spe_events {
> -	EV_EXCEPTION_GEN	= 0,
> -	EV_RETIRED		= 1,
> -	EV_L1D_ACCESS		= 2,
> -	EV_L1D_REFILL		= 3,
> -	EV_TLB_ACCESS		= 4,
> -	EV_TLB_WALK		= 5,
> -	EV_NOT_TAKEN		= 6,
> -	EV_MISPRED		= 7,
> -	EV_LLC_ACCESS		= 8,
> -	EV_LLC_MISS		= 9,
> -	EV_REMOTE_ACCESS	= 10,
> -	EV_ALIGNMENT		= 11,
> -	EV_PARTIAL_PREDICATE	= 17,
> -	EV_EMPTY_PREDICATE	= 18,
> -};

So what about keeping this, but moving it into the other header file?
coding-style.rst says: "Enums are preferred when defining several
related constants."

> -
>  enum arm_spe_sample_type {
>  	ARM_SPE_L1D_ACCESS	= 1 << 0,
>  	ARM_SPE_L1D_MISS	= 1 << 1,
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index ed0f4c74dfc5..b8f343320abf 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -284,58 +284,58 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  		if (ret < 0)
>  			return ret;
>  
> -		if (payload & 0x1) {
> +		if (payload & SPE_EVT_PKT_GEN_EXCEPTION) {

Having the bitmask here directly is indeed not very nice and error
prone. But I would rather see the above solution:
		if (payload & BIT(EV_EXCEPTION_GEN)) {

>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCEPTION-GEN");
>  			if (ret < 0)
>  				return ret;
>  		}
> -		if (payload & 0x2) {
> +		if (payload & SPE_EVT_PKT_ARCH_RETIRED) {
>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " RETIRED");
>  			if (ret < 0)
>  				return ret;
>  		}
> -		if (payload & 0x4) {
> +		if (payload & SPE_EVT_PKT_L1D_ACCESS) {
>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-ACCESS");
>  			if (ret < 0)
>  				return ret;
>  		}
> -		if (payload & 0x8) {
> +		if (payload & SPE_EVT_PKT_L1D_REFILL) {
>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-REFILL");
>  			if (ret < 0)
>  				return ret;
>  		}
> -		if (payload & 0x10) {
> +		if (payload & SPE_EVT_PKT_TLB_ACCESS) {
>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-ACCESS");
>  			if (ret < 0)
>  				return ret;
>  		}
> -		if (payload & 0x20) {
> +		if (payload & SPE_EVT_PKT_TLB_WALK) {
>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-REFILL");
>  			if (ret < 0)
>  				return ret;
>  		}
> -		if (payload & 0x40) {
> +		if (payload & SPE_EVT_PKT_NOT_TAKEN) {
>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " NOT-TAKEN");
>  			if (ret < 0)
>  				return ret;
>  		}
> -		if (payload & 0x80) {
> +		if (payload & SPE_EVT_PKT_MISPREDICTED) {
>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " MISPRED");
>  			if (ret < 0)
>  				return ret;
>  		}
>  		if (idx > 1) {

Do you know what the purpose of this comparison is? Surely payload would
not contain more bits than would fit in "idx" bytes? So is this some
attempt of an optimisation? If so, I doubt it's really useful, the
compiler might find a smarter solution to the problem. Just continuing
with the bit mask comparison would make it look nicer, I think.

Cheers,
Andre

> -			if (payload & 0x100) {
> +			if (payload & SPE_EVT_PKT_LLC_ACCESS) {
>  				ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-ACCESS");
>  				if (ret < 0)
>  					return ret;
>  			}
> -			if (payload & 0x200) {
> +			if (payload & SPE_EVT_PKT_LLC_MISS) {
>  				ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-REFILL");
>  				if (ret < 0)
>  					return ret;
>  			}
> -			if (payload & 0x400) {
> +			if (payload & SPE_EVT_PKT_REMOTE_ACCESS) {
>  				ret = arm_spe_pkt_snprintf(&buf, &blen, " REMOTE-ACCESS");
>  				if (ret < 0)
>  					return ret;
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> index 18667a63f5ba..e9a88cf685bb 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> @@ -98,6 +98,22 @@ struct arm_spe_pkt {
>  #define SPE_CNT_PKT_HDR_EXT_INDEX_MASK		GENMASK_ULL(1, 0)
>  #define SPE_CNT_PKT_HDR_EXT_INDEX_SHIFT		(3)
>  
> +/* Event packet payload */
> +#define SPE_EVT_PKT_SVE_EMPTY_PREDICATE		BIT(18)
> +#define SPE_EVT_PKT_SVE_PARTIAL_PREDICATE	BIT(17)
> +#define SPE_EVT_PKT_ALIGNMENT			BIT(11)
> +#define SPE_EVT_PKT_REMOTE_ACCESS		BIT(10)
> +#define SPE_EVT_PKT_LLC_MISS			BIT(9)
> +#define SPE_EVT_PKT_LLC_ACCESS			BIT(8)
> +#define SPE_EVT_PKT_MISPREDICTED		BIT(7)
> +#define SPE_EVT_PKT_NOT_TAKEN			BIT(6)
> +#define SPE_EVT_PKT_TLB_WALK			BIT(5)
> +#define SPE_EVT_PKT_TLB_ACCESS			BIT(4)
> +#define SPE_EVT_PKT_L1D_REFILL			BIT(3)
> +#define SPE_EVT_PKT_L1D_ACCESS			BIT(2)
> +#define SPE_EVT_PKT_ARCH_RETIRED		BIT(1)
> +#define SPE_EVT_PKT_GEN_EXCEPTION		BIT(0)
> +
>  const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
>  
>  int arm_spe_get_packet(const unsigned char *buf, size_t len,
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F0F29951B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783942AbgJZSSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:18:09 -0400
Received: from foss.arm.com ([217.140.110.172]:47142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1783842AbgJZSSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:18:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C10E139F;
        Mon, 26 Oct 2020 11:18:05 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 549703F66E;
        Mon, 26 Oct 2020 11:18:03 -0700 (PDT)
Subject: Re: [PATCH v3 17/20] perf arm-spe: Refactor operation packet handling
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
References: <20201022145816.14069-1-leo.yan@linaro.org>
 <20201022145816.14069-18-leo.yan@linaro.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <4908efac-0cb4-b2db-69d2-f81cbe14c021@arm.com>
Date:   Mon, 26 Oct 2020 18:17:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201022145816.14069-18-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2020 15:58, Leo Yan wrote:

Hi,

> Defines macros for operation packet header and formats (support sub
> classes for 'other', 'branch', 'load and store', etc).  Uses these
> macros for operation packet decoding and dumping.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 34 +++++++++++--------
>  .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 26 ++++++++++++++
>  2 files changed, 45 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 19d05d9734ab..59b538563d31 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -144,7 +144,7 @@ static int arm_spe_get_op_type(const unsigned char *buf, size_t len,
>  			       struct arm_spe_pkt *packet)
>  {
>  	packet->type = ARM_SPE_OP_TYPE;
> -	packet->index = buf[0] & 0x3;
> +	packet->index = SPE_OP_PKT_HDR_CLASS(buf[0]);
>  	return arm_spe_get_payload(buf, len, 0, packet);
>  }
>  
> @@ -339,37 +339,39 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
>  static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
>  				    char *buf, size_t buf_len)
>  {
> -	int ret, idx = packet->index;
> +	int ret, class = packet->index;
>  	unsigned long long payload = packet->payload;
>  	size_t blen = buf_len;
>  
> -	switch (idx) {
> -	case 0:
> +	switch (class) {
> +	case SPE_OP_PKT_HDR_CLASS_OTHER:
>  		return arm_spe_pkt_snprintf(&buf, &blen,
> -				payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
> -	case 1:
> +			payload & SPE_OP_PKT_COND ? "COND-SELECT" : "INSN-OTHER");
> +	case SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC:
>  		ret = arm_spe_pkt_snprintf(&buf, &blen,
> -					   payload & 0x1 ? "ST" : "LD");
> +					   payload & SPE_OP_PKT_ST ? "ST" : "LD");
>  		if (ret < 0)
>  			return ret;
>  
> -		if (payload & 0x2) {
> -			if (payload & 0x4) {
> +		if (SPE_OP_PKT_LDST_SUBCLASS_ATOMIC_GET(payload) ==
> +					SPE_OP_PKT_LDST_SUBCLASS_ATOMIC) {

This looks somewhat hard to read, and those symbols are only used once?
So what about combining this down in the header so that you can use:
		if (SPE_OP_PKT_IS_LDST_ATOMIC(payload)) {

> +			if (payload & SPE_OP_PKT_AT) {
>  				ret = arm_spe_pkt_snprintf(&buf, &blen, " AT");
>  				if (ret < 0)
>  					return ret;
>  			}
> -			if (payload & 0x8) {
> +			if (payload & SPE_OP_PKT_EXCL) {
>  				ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCL");
>  				if (ret < 0)
>  					return ret;
>  			}
> -			if (payload & 0x10) {
> +			if (payload & SPE_OP_PKT_AR) {
>  				ret = arm_spe_pkt_snprintf(&buf, &blen, " AR");
>  				if (ret < 0)
>  					return ret;
>  			}
> -		} else if (payload & 0x4) {
> +		} else if (SPE_OP_PKT_LDST_SUBCLASS_GET(payload) ==
> +					SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP) {
>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " SIMD-FP");
>  			if (ret < 0)
>  				return ret;
> @@ -377,17 +379,19 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
>  
>  		return buf_len - blen;
>  
> -	case 2:
> +	case SPE_OP_PKT_HDR_CLASS_BR_ERET:
>  		ret = arm_spe_pkt_snprintf(&buf, &blen, "B");
>  		if (ret < 0)
>  			return ret;
>  
> -		if (payload & 0x1) {
> +		if (payload & SPE_OP_PKT_COND) {
>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " COND");
>  			if (ret < 0)
>  				return ret;
>  		}
> -		if (payload & 0x2) {
> +
> +		if (SPE_OP_PKT_BRANCH_SUBCLASS_GET(payload) ==
> +				SPE_OP_PKT_BRANCH_SUBCLASS_INDIRECT) {

Same here, it's the only user of both symbols, so maybe:
		if (SPE_OP_PKT_IS_INDIRECT_BRANCH(payload)) {

Cheers,
Andre

>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " IND");
>  			if (ret < 0)
>  				return ret;
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> index 12c344454cf1..31dbb8c0fde3 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> @@ -110,6 +110,32 @@ enum arm_spe_events {
>  	EV_EMPTY_PREDICATE	= 18,
>  };
>  
> +/* Operation packet header */
> +#define SPE_OP_PKT_HDR_CLASS(h)			((h) & GENMASK_ULL(1, 0))
> +#define SPE_OP_PKT_HDR_CLASS_OTHER		0x0
> +#define SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC	0x1
> +#define SPE_OP_PKT_HDR_CLASS_BR_ERET		0x2
> +
> +#define SPE_OP_PKT_COND				BIT(0)
> +
> +#define SPE_OP_PKT_LDST_SUBCLASS_GET(v)		((v) & GENMASK_ULL(7, 1))
> +#define SPE_OP_PKT_LDST_SUBCLASS_GP_REG		0x0
> +#define SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP	0x4
> +#define SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG	0x10
> +#define SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG	0x30
> +
> +#define SPE_OP_PKT_LDST_SUBCLASS_ATOMIC_GET(v)	((v) & (GENMASK_ULL(7, 5) | GENMASK_ULL(1, 1)))
> +#define SPE_OP_PKT_LDST_SUBCLASS_ATOMIC		0x2
> +
> +#define SPE_OP_PKT_AR				BIT(4)
> +#define SPE_OP_PKT_EXCL				BIT(3)
> +#define SPE_OP_PKT_AT				BIT(2)
> +#define SPE_OP_PKT_ST				BIT(0)
> +
> +#define SPE_OP_PKT_BRANCH_SUBCLASS_GET(v)	((v) & GENMASK_ULL(7, 1))
> +#define SPE_OP_PKT_BRANCH_SUBCLASS_DIRECT	0x0
> +#define SPE_OP_PKT_BRANCH_SUBCLASS_INDIRECT	0x2
> +
>  const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
>  
>  int arm_spe_get_packet(const unsigned char *buf, size_t len,
> 


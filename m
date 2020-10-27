Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2023A29B448
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 16:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787773AbgJ0PAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 11:00:17 -0400
Received: from foss.arm.com ([217.140.110.172]:42790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752689AbgJ0OzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:55:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 966D113D5;
        Tue, 27 Oct 2020 07:55:20 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D78793F719;
        Tue, 27 Oct 2020 07:55:18 -0700 (PDT)
Subject: Re: [PATCH v4 18/21] perf arm-spe: Refactor operation packet handling
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
References: <20201027030917.15404-1-leo.yan@linaro.org>
 <20201027030917.15404-19-leo.yan@linaro.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <ca8f91f6-36af-dc40-34ba-2752ee64bd8e@arm.com>
Date:   Tue, 27 Oct 2020 14:54:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201027030917.15404-19-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2020 03:09, Leo Yan wrote:
> Defines macros for operation packet header and formats (support sub
> classes for 'other', 'branch', 'load and store', etc).  Uses these
> macros for operation packet decoding and dumping.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Looks good now, thanks!

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 32 ++++++++++---------
>  .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 23 +++++++++++++
>  2 files changed, 40 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 7c6a0caed976..e3b0d22743e8 100644
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
> @@ -339,37 +339,38 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
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
> +		if (SPE_OP_PKT_IS_LDST_ATOMIC(payload)) {
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
> @@ -377,17 +378,18 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
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
> +		if (SPE_OP_PKT_IS_INDIRECT_BRANCH(payload)) {
>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " IND");
>  			if (ret < 0)
>  				return ret;
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> index 42ed4e61ede2..7032fc141ad4 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> @@ -105,6 +105,29 @@ enum arm_spe_events {
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
> +#define SPE_OP_PKT_IS_LDST_ATOMIC(v)		(((v) & (GENMASK_ULL(7, 5) | BIT(1))) == 0x2)
> +
> +#define SPE_OP_PKT_AR				BIT(4)
> +#define SPE_OP_PKT_EXCL				BIT(3)
> +#define SPE_OP_PKT_AT				BIT(2)
> +#define SPE_OP_PKT_ST				BIT(0)
> +
> +#define SPE_OP_PKT_IS_INDIRECT_BRANCH(v)	(((v) & GENMASK_ULL(7, 1)) == 0x2)
> +
>  const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
>  
>  int arm_spe_get_packet(const unsigned char *buf, size_t len,
> 


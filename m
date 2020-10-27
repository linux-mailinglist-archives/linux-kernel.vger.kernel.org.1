Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A778829C10E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1818668AbgJ0RV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:21:57 -0400
Received: from foss.arm.com ([217.140.110.172]:42716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1780768AbgJ0OzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:55:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C470513D5;
        Tue, 27 Oct 2020 07:54:59 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 176393F719;
        Tue, 27 Oct 2020 07:54:57 -0700 (PDT)
Subject: Re: [PATCH v4 09/21] perf arm-spe: Refactor address packet handling
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
 <20201027030917.15404-10-leo.yan@linaro.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <7f495290-e2b2-c74e-8337-05d7be348aad@arm.com>
Date:   Tue, 27 Oct 2020 14:53:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201027030917.15404-10-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2020 03:09, Leo Yan wrote:
> This patch is to refactor address packet handling, it defines macros for
> address packet's header and payload, these macros are used by decoder
> and the dump flow.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Thanks for the changes!

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  .../util/arm-spe-decoder/arm-spe-decoder.c    | 29 ++++++++-------
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 26 +++++++-------
>  .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 35 ++++++++++++-------
>  3 files changed, 48 insertions(+), 42 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> index cc18a1e8c212..776b3e6628bb 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> @@ -24,36 +24,35 @@
>  
>  static u64 arm_spe_calc_ip(int index, u64 payload)
>  {
> -	u8 *addr = (u8 *)&payload;
> -	int ns, el;
> +	u64 ns, el;
>  
>  	/* Instruction virtual address or Branch target address */
>  	if (index == SPE_ADDR_PKT_HDR_INDEX_INS ||
>  	    index == SPE_ADDR_PKT_HDR_INDEX_BRANCH) {
> -		ns = addr[7] & SPE_ADDR_PKT_NS;
> -		el = (addr[7] & SPE_ADDR_PKT_EL_MASK) >> SPE_ADDR_PKT_EL_OFFSET;
> +		ns = SPE_ADDR_PKT_GET_NS(payload);
> +		el = SPE_ADDR_PKT_GET_EL(payload);
> +
> +		/* Clean highest byte */
> +		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
>  
>  		/* Fill highest byte for EL1 or EL2 (VHE) mode */
>  		if (ns && (el == SPE_ADDR_PKT_EL1 || el == SPE_ADDR_PKT_EL2))
> -			addr[7] = 0xff;
> -		/* Clean highest byte for other cases */
> -		else
> -			addr[7] = 0x0;
> +			payload |= 0xffULL << SPE_ADDR_PKT_ADDR_BYTE7_SHIFT;
>  
>  	/* Data access virtual address */
>  	} else if (index == SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT) {
>  
> +		/* Clean tags */
> +		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
> +
>  		/* Fill highest byte if bits [48..55] is 0xff */
> -		if (addr[6] == 0xff)
> -			addr[7] = 0xff;
> -		/* Otherwise, cleanup tags */
> -		else
> -			addr[7] = 0x0;
> +		if (SPE_ADDR_PKT_ADDR_GET_BYTE_6(payload) == 0xffULL)
> +			payload |= 0xffULL << SPE_ADDR_PKT_ADDR_BYTE7_SHIFT;
>  
>  	/* Data access physical address */
>  	} else if (index == SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS) {
> -		/* Cleanup byte 7 */
> -		addr[7] = 0x0;
> +		/* Clean highest byte */
> +		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
>  	} else {
>  		pr_err("unsupported address packet index: 0x%x\n", index);
>  	}
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index e372e85e1c14..1218a731638f 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -13,9 +13,6 @@
>  
>  #include "arm-spe-pkt-decoder.h"
>  
> -#define NS_FLAG		BIT(63)
> -#define EL_FLAG		(BIT(62) | BIT(61))
> -
>  #if __BYTE_ORDER == __BIG_ENDIAN
>  #define le16_to_cpu bswap_16
>  #define le32_to_cpu bswap_32
> @@ -167,10 +164,11 @@ static int arm_spe_get_addr(const unsigned char *buf, size_t len,
>  			    const unsigned char ext_hdr, struct arm_spe_pkt *packet)
>  {
>  	packet->type = ARM_SPE_ADDRESS;
> +
>  	if (ext_hdr)
> -		packet->index = ((buf[0] & 0x3) << 3) | (buf[1] & 0x7);
> +		packet->index = SPE_HDR_EXTENDED_INDEX(buf[0], buf[1]);
>  	else
> -		packet->index = buf[0] & 0x7;
> +		packet->index = SPE_HDR_SHORT_INDEX(buf[0]);
>  
>  	return arm_spe_get_payload(buf, len, ext_hdr, packet);
>  }
> @@ -274,20 +272,20 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
>  	u64 payload = packet->payload;
>  
>  	switch (idx) {
> -	case 0:
> -	case 1:
> -		ns = !!(packet->payload & NS_FLAG);
> -		el = (packet->payload & EL_FLAG) >> 61;
> -		payload &= ~(0xffULL << 56);
> +	case SPE_ADDR_PKT_HDR_INDEX_INS:
> +	case SPE_ADDR_PKT_HDR_INDEX_BRANCH:
> +		ns = !!SPE_ADDR_PKT_GET_NS(payload);
> +		el = SPE_ADDR_PKT_GET_EL(payload);
> +		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
>  		return arm_spe_pkt_snprintf(&buf, &buf_len,
>  				"%s 0x%llx el%d ns=%d",
>  				(idx == 1) ? "TGT" : "PC", payload, el, ns);
> -	case 2:
> +	case SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT:
>  		return arm_spe_pkt_snprintf(&buf, &buf_len,
>  					    "VA 0x%llx", payload);
> -	case 3:
> -		ns = !!(packet->payload & NS_FLAG);
> -		payload &= ~(0xffULL << 56);
> +	case SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS:
> +		ns = !!SPE_ADDR_PKT_GET_NS(payload);
> +		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
>  		return arm_spe_pkt_snprintf(&buf, &buf_len,
>  					    "PA 0x%llx ns=%d", payload, ns);
>  	default:
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> index 129f43405eb1..f97d6840be3a 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> @@ -56,19 +56,28 @@ struct arm_spe_pkt {
>  #define SPE_HEADER0_COUNTER			0x98
>  #define SPE_HEADER1_ALIGNMENT			0x0
>  
> -#define SPE_ADDR_PKT_HDR_INDEX_INS		(0x0)
> -#define SPE_ADDR_PKT_HDR_INDEX_BRANCH		(0x1)
> -#define SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT	(0x2)
> -#define SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS	(0x3)
> -
> -#define SPE_ADDR_PKT_NS				BIT(7)
> -#define SPE_ADDR_PKT_CH				BIT(6)
> -#define SPE_ADDR_PKT_EL_OFFSET			(5)
> -#define SPE_ADDR_PKT_EL_MASK			(0x3 << SPE_ADDR_PKT_EL_OFFSET)
> -#define SPE_ADDR_PKT_EL0			(0)
> -#define SPE_ADDR_PKT_EL1			(1)
> -#define SPE_ADDR_PKT_EL2			(2)
> -#define SPE_ADDR_PKT_EL3			(3)
> +#define SPE_HDR_SHORT_INDEX(h)			((h) & GENMASK_ULL(2, 0))
> +#define SPE_HDR_EXTENDED_INDEX(h0, h1)		(((h0) & GENMASK_ULL(1, 0)) << 3 | \
> +						 SPE_HDR_SHORT_INDEX(h1))
> +
> +/* Address packet header */
> +#define SPE_ADDR_PKT_HDR_INDEX_INS		0x0
> +#define SPE_ADDR_PKT_HDR_INDEX_BRANCH		0x1
> +#define SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT	0x2
> +#define SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS	0x3
> +
> +/* Address packet payload */
> +#define SPE_ADDR_PKT_ADDR_BYTE7_SHIFT		56
> +#define SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(v)	((v) & GENMASK_ULL(55, 0))
> +#define SPE_ADDR_PKT_ADDR_GET_BYTE_6(v)		(((v) & GENMASK_ULL(55, 48)) >> 48)
> +
> +#define SPE_ADDR_PKT_GET_NS(v)			(((v) & BIT_ULL(63)) >> 63)
> +#define SPE_ADDR_PKT_GET_EL(v)			(((v) & GENMASK_ULL(62, 61)) >> 61)
> +
> +#define SPE_ADDR_PKT_EL0			0
> +#define SPE_ADDR_PKT_EL1			1
> +#define SPE_ADDR_PKT_EL2			2
> +#define SPE_ADDR_PKT_EL3			3
>  
>  const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
>  
> 


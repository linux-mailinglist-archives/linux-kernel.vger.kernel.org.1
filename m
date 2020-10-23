Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C960F29763C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 19:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753943AbgJWRyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 13:54:39 -0400
Received: from foss.arm.com ([217.140.110.172]:57640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753922AbgJWRyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 13:54:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7003B101E;
        Fri, 23 Oct 2020 10:54:30 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E8D53F719;
        Fri, 23 Oct 2020 10:54:27 -0700 (PDT)
Subject: Re: [PATCH v3 09/20] perf arm-spe: Refactor address packet handling
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
 <20201022145816.14069-10-leo.yan@linaro.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <388f90e9-baa0-33e9-f682-e9e9cd551cf4@arm.com>
Date:   Fri, 23 Oct 2020 18:53:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201022145816.14069-10-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2020 15:58, Leo Yan wrote:

Hi Leo,

> This patch is to refactor address packet handling, it defines macros for
> address packet's header and payload, these macros are used by decoder
> and the dump flow.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  .../util/arm-spe-decoder/arm-spe-decoder.c    | 29 ++++++++--------
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 26 +++++++-------
>  .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 34 ++++++++++++-------
>  3 files changed, 47 insertions(+), 42 deletions(-)
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

Do you know where this comes from? If yes, can you replace the comment
with the reason, so that it says *why* and not *what* the code does?

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
> index 550cd7648c73..156f98d6b8b2 100644
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
> +		packet->index = SPE_ADDR_PKT_HDR_EXTENDED_INDEX(buf[0], buf[1]);
>  	else
> -		packet->index = buf[0] & 0x7;
> +		packet->index = SPE_ADDR_PKT_HDR_SHORT_INDEX(buf[0]);
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
> index 68552ff8a8f7..4111550d2bde 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> @@ -59,19 +59,27 @@ struct arm_spe_pkt {
>  
>  #define SPE_HEADER_SZ(val)			((val & GENMASK_ULL(5, 4)) >> 4)
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
> +/* Address packet header */
> +#define SPE_ADDR_PKT_HDR_SHORT_INDEX(h)		((h) & GENMASK_ULL(2, 0))
> +#define SPE_ADDR_PKT_HDR_EXTENDED_INDEX(h0, h1)	(((h0) & GENMASK_ULL(1, 0)) << 3 | \
> +						 SPE_ADDR_PKT_HDR_SHORT_INDEX(h1))

Did you consider sharing those two with the identical definition for the
extended counter packet? This extended packet seems more like a generic
concept, regardless of the packet type.

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
> +#define SPE_ADDR_PKT_GET_NS(v)			(((v) & BIT(63)) >> 63)

You need BIT_ULL(63) here to make this work on 32-bit systems.

Cheers,
Andre

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


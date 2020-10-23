Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E09297590
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 19:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753103AbgJWRKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 13:10:31 -0400
Received: from foss.arm.com ([217.140.110.172]:56948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753096AbgJWRKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 13:10:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89EC01FB;
        Fri, 23 Oct 2020 10:10:29 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D17703F719;
        Fri, 23 Oct 2020 10:10:27 -0700 (PDT)
Subject: Re: [PATCH v3 07/20] perf arm-spe: Refactor packet header parsing
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
 <20201022145816.14069-8-leo.yan@linaro.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <b1115f4e-7f9c-daa5-36b6-ab2e8369bb67@arm.com>
Date:   Fri, 23 Oct 2020 18:09:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201022145816.14069-8-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2020 15:58, Leo Yan wrote:

Hi,

> The packet header parsing uses the hard coded values and it uses nested
> if-else statements.
> 
> To improve the readability, this patch refactors the macros for packet
> header format so it removes the hard coded values.  Furthermore, based
> on the new mask macros it reduces the nested if-else statements and
> changes to use the flat conditions checking, this is directive and can
> easily map to the descriptions in ARMv8-a architecture reference manual
> (ARM DDI 0487E.a), chapter 'D10.1.5 Statistical Profiling Extension
> protocol packet headers'.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Compared against the previous version, which I had checked already
against the manual. Thanks for the fixes!

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks,
Andre


> ---
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 92 +++++++++----------
>  .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 20 ++++
>  2 files changed, 61 insertions(+), 51 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index c7b6dc016f11..6f2329990729 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -16,28 +16,6 @@
>  #define NS_FLAG		BIT(63)
>  #define EL_FLAG		(BIT(62) | BIT(61))
>  
> -#define SPE_HEADER0_PAD			0x0
> -#define SPE_HEADER0_END			0x1
> -#define SPE_HEADER0_ADDRESS		0x30 /* address packet (short) */
> -#define SPE_HEADER0_ADDRESS_MASK	0x38
> -#define SPE_HEADER0_COUNTER		0x18 /* counter packet (short) */
> -#define SPE_HEADER0_COUNTER_MASK	0x38
> -#define SPE_HEADER0_TIMESTAMP		0x71
> -#define SPE_HEADER0_TIMESTAMP		0x71
> -#define SPE_HEADER0_EVENTS		0x2
> -#define SPE_HEADER0_EVENTS_MASK		0xf
> -#define SPE_HEADER0_SOURCE		0x3
> -#define SPE_HEADER0_SOURCE_MASK		0xf
> -#define SPE_HEADER0_CONTEXT		0x24
> -#define SPE_HEADER0_CONTEXT_MASK	0x3c
> -#define SPE_HEADER0_OP_TYPE		0x8
> -#define SPE_HEADER0_OP_TYPE_MASK	0x3c
> -#define SPE_HEADER1_ALIGNMENT		0x0
> -#define SPE_HEADER1_ADDRESS		0xb0 /* address packet (extended) */
> -#define SPE_HEADER1_ADDRESS_MASK	0xf8
> -#define SPE_HEADER1_COUNTER		0x98 /* counter packet (extended) */
> -#define SPE_HEADER1_COUNTER_MASK	0xf8
> -
>  #if __BYTE_ORDER == __BIG_ENDIAN
>  #define le16_to_cpu bswap_16
>  #define le32_to_cpu bswap_32
> @@ -200,46 +178,58 @@ static int arm_spe_get_addr(const unsigned char *buf, size_t len,
>  static int arm_spe_do_get_packet(const unsigned char *buf, size_t len,
>  				 struct arm_spe_pkt *packet)
>  {
> -	unsigned int byte;
> +	unsigned int hdr;
> +	unsigned char ext_hdr = 0;
>  
>  	memset(packet, 0, sizeof(struct arm_spe_pkt));
>  
>  	if (!len)
>  		return ARM_SPE_NEED_MORE_BYTES;
>  
> -	byte = buf[0];
> -	if (byte == SPE_HEADER0_PAD)
> +	hdr = buf[0];
> +
> +	if (hdr == SPE_HEADER0_PAD)
>  		return arm_spe_get_pad(packet);
> -	else if (byte == SPE_HEADER0_END) /* no timestamp at end of record */
> +
> +	if (hdr == SPE_HEADER0_END) /* no timestamp at end of record */
>  		return arm_spe_get_end(packet);
> -	else if (byte & 0xc0 /* 0y11xxxxxx */) {
> -		if (byte & 0x80) {
> -			if ((byte & SPE_HEADER0_ADDRESS_MASK) == SPE_HEADER0_ADDRESS)
> -				return arm_spe_get_addr(buf, len, 0, packet);
> -			if ((byte & SPE_HEADER0_COUNTER_MASK) == SPE_HEADER0_COUNTER)
> -				return arm_spe_get_counter(buf, len, 0, packet);
> -		} else
> -			if (byte == SPE_HEADER0_TIMESTAMP)
> -				return arm_spe_get_timestamp(buf, len, packet);
> -			else if ((byte & SPE_HEADER0_EVENTS_MASK) == SPE_HEADER0_EVENTS)
> -				return arm_spe_get_events(buf, len, packet);
> -			else if ((byte & SPE_HEADER0_SOURCE_MASK) == SPE_HEADER0_SOURCE)
> -				return arm_spe_get_data_source(buf, len, packet);
> -			else if ((byte & SPE_HEADER0_CONTEXT_MASK) == SPE_HEADER0_CONTEXT)
> -				return arm_spe_get_context(buf, len, packet);
> -			else if ((byte & SPE_HEADER0_OP_TYPE_MASK) == SPE_HEADER0_OP_TYPE)
> -				return arm_spe_get_op_type(buf, len, packet);
> -	} else if ((byte & 0xe0) == 0x20 /* 0y001xxxxx */) {
> -		/* 16-bit header */
> -		byte = buf[1];
> -		if (byte == SPE_HEADER1_ALIGNMENT)
> +
> +	if (hdr == SPE_HEADER0_TIMESTAMP)
> +		return arm_spe_get_timestamp(buf, len, packet);
> +
> +	if ((hdr & SPE_HEADER0_MASK1) == SPE_HEADER0_EVENTS)
> +		return arm_spe_get_events(buf, len, packet);
> +
> +	if ((hdr & SPE_HEADER0_MASK1) == SPE_HEADER0_SOURCE)
> +		return arm_spe_get_data_source(buf, len, packet);
> +
> +	if ((hdr & SPE_HEADER0_MASK2) == SPE_HEADER0_CONTEXT)
> +		return arm_spe_get_context(buf, len, packet);
> +
> +	if ((hdr & SPE_HEADER0_MASK2) == SPE_HEADER0_OP_TYPE)
> +		return arm_spe_get_op_type(buf, len, packet);
> +
> +	if ((hdr & SPE_HEADER0_MASK2) == SPE_HEADER0_EXTENDED) {
> +		/* 16-bit extended format header */
> +		ext_hdr = 1;
> +
> +		hdr = buf[1];
> +		if (hdr == SPE_HEADER1_ALIGNMENT)
>  			return arm_spe_get_alignment(buf, len, packet);
> -		else if ((byte & SPE_HEADER1_ADDRESS_MASK) == SPE_HEADER1_ADDRESS)
> -			return arm_spe_get_addr(buf, len, 1, packet);
> -		else if ((byte & SPE_HEADER1_COUNTER_MASK) == SPE_HEADER1_COUNTER)
> -			return arm_spe_get_counter(buf, len, 1, packet);
>  	}
>  
> +	/*
> +	 * The short format header's byte 0 or the extended format header's
> +	 * byte 1 has been assigned to 'hdr', which uses the same encoding for
> +	 * address packet and counter packet, so don't need to distinguish if
> +	 * it's short format or extended format and handle in once.
> +	 */
> +	if ((hdr & SPE_HEADER0_MASK3) == SPE_HEADER0_ADDRESS)
> +		return arm_spe_get_addr(buf, len, ext_hdr, packet);
> +
> +	if ((hdr & SPE_HEADER0_MASK3) == SPE_HEADER0_COUNTER)
> +		return arm_spe_get_counter(buf, len, ext_hdr, packet);
> +
>  	return ARM_SPE_BAD_PACKET;
>  }
>  
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> index e9ea8e3ead5d..68552ff8a8f7 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> @@ -37,6 +37,26 @@ struct arm_spe_pkt {
>  	uint64_t		payload;
>  };
>  
> +/* Short header (HEADER0) and extended header (HEADER1) */
> +#define SPE_HEADER0_PAD				0x0
> +#define SPE_HEADER0_END				0x1
> +#define SPE_HEADER0_TIMESTAMP			0x71
> +/* Mask for event & data source */
> +#define SPE_HEADER0_MASK1			(GENMASK_ULL(7, 6) | GENMASK_ULL(3, 0))
> +#define SPE_HEADER0_EVENTS			0x42
> +#define SPE_HEADER0_SOURCE			0x43
> +/* Mask for context & operation */
> +#define SPE_HEADER0_MASK2			GENMASK_ULL(7, 2)
> +#define SPE_HEADER0_CONTEXT			0x64
> +#define SPE_HEADER0_OP_TYPE			0x48
> +/* Mask for extended format */
> +#define SPE_HEADER0_EXTENDED			0x20
> +/* Mask for address & counter */
> +#define SPE_HEADER0_MASK3			GENMASK_ULL(7, 3)
> +#define SPE_HEADER0_ADDRESS			0xb0
> +#define SPE_HEADER0_COUNTER			0x98
> +#define SPE_HEADER1_ALIGNMENT			0x0
> +
>  #define SPE_HEADER_SZ(val)			((val & GENMASK_ULL(5, 4)) >> 4)
>  
>  #define SPE_ADDR_PKT_HDR_INDEX_INS		(0x0)
> 


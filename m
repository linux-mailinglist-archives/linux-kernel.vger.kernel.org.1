Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE013287564
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 15:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbgJHNqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 09:46:25 -0400
Received: from foss.arm.com ([217.140.110.172]:58508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbgJHNqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 09:46:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BA701063;
        Thu,  8 Oct 2020 06:46:24 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C61923F70D;
        Thu,  8 Oct 2020 06:46:22 -0700 (PDT)
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Subject: Re: [PATCH v2 04/14] perf arm-spe: Fix packet length handling
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
 <20200929133917.9224-5-leo.yan@linaro.org>
Organization: ARM Ltd.
Message-ID: <230f6fbf-02b4-1ce2-bf80-3cbaa16fb587@arm.com>
Date:   Thu, 8 Oct 2020 14:45:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200929133917.9224-5-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2020 14:39, Leo Yan wrote:
> When process address packet and counter packet, if the packet contains

       processing

> extended header, it misses to account the extra one byte for header
> length calculation, thus returns the wrong packet length.
> 
> To correct the packet length calculation, one possible fixing is simply
> to plus extra 1 for extended header, but will spread some duplicate code
> in the flows for processing address packet and counter packet.
> Alternatively, we can refine the function arm_spe_get_payload() to not
> only support short header and allow it to support extended header, and
> rely on it for the packet length calculation.
> 
> So this patch refactors function arm_spe_get_payload() with a new
> argument 'ext_hdr' for support extended header; the packet processing
> flows can invoke this function to unify the packet length calculation.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

That looks alright to me.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 34 +++++++------------
>  1 file changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 5a8696031e16..4f0aeb62e97b 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -80,14 +80,15 @@ const char *arm_spe_pkt_name(enum arm_spe_pkt_type type)
>  	(1 << (((val) & SPE_HEADER_SZ_MASK) >> SPE_HEADER_SZ_SHIFT))
>  
>  static int arm_spe_get_payload(const unsigned char *buf, size_t len,
> +			       unsigned char ext_hdr,
>  			       struct arm_spe_pkt *packet)
>  {
> -	size_t payload_len = PAYLOAD_LEN(buf[0]);
> +	size_t payload_len = PAYLOAD_LEN(buf[ext_hdr]);
>  
> -	if (len < 1 + payload_len)
> +	if (len < 1 + ext_hdr + payload_len)
>  		return ARM_SPE_NEED_MORE_BYTES;
>  
> -	buf++;
> +	buf += 1 + ext_hdr;
>  
>  	switch (payload_len) {
>  	case 1: packet->payload = *(uint8_t *)buf; break;
> @@ -97,7 +98,7 @@ static int arm_spe_get_payload(const unsigned char *buf, size_t len,
>  	default: return ARM_SPE_BAD_PACKET;
>  	}
>  
> -	return 1 + payload_len;
> +	return 1 + ext_hdr + payload_len;
>  }
>  
>  static int arm_spe_get_pad(struct arm_spe_pkt *packet)
> @@ -128,7 +129,7 @@ static int arm_spe_get_timestamp(const unsigned char *buf, size_t len,
>  				 struct arm_spe_pkt *packet)
>  {
>  	packet->type = ARM_SPE_TIMESTAMP;
> -	return arm_spe_get_payload(buf, len, packet);
> +	return arm_spe_get_payload(buf, len, 0, packet);
>  }
>  
>  static int arm_spe_get_events(const unsigned char *buf, size_t len,
> @@ -143,14 +144,14 @@ static int arm_spe_get_events(const unsigned char *buf, size_t len,
>  	 */
>  	packet->index = PAYLOAD_LEN(buf[0]);
>  
> -	return arm_spe_get_payload(buf, len, packet);
> +	return arm_spe_get_payload(buf, len, 0, packet);
>  }
>  
>  static int arm_spe_get_data_source(const unsigned char *buf, size_t len,
>  				   struct arm_spe_pkt *packet)
>  {
>  	packet->type = ARM_SPE_DATA_SOURCE;
> -	return arm_spe_get_payload(buf, len, packet);
> +	return arm_spe_get_payload(buf, len, 0, packet);
>  }
>  
>  static int arm_spe_get_context(const unsigned char *buf, size_t len,
> @@ -158,8 +159,7 @@ static int arm_spe_get_context(const unsigned char *buf, size_t len,
>  {
>  	packet->type = ARM_SPE_CONTEXT;
>  	packet->index = buf[0] & 0x3;
> -
> -	return arm_spe_get_payload(buf, len, packet);
> +	return arm_spe_get_payload(buf, len, 0, packet);
>  }
>  
>  static int arm_spe_get_op_type(const unsigned char *buf, size_t len,
> @@ -167,41 +167,31 @@ static int arm_spe_get_op_type(const unsigned char *buf, size_t len,
>  {
>  	packet->type = ARM_SPE_OP_TYPE;
>  	packet->index = buf[0] & 0x3;
> -	return arm_spe_get_payload(buf, len, packet);
> +	return arm_spe_get_payload(buf, len, 0, packet);
>  }
>  
>  static int arm_spe_get_counter(const unsigned char *buf, size_t len,
>  			       const unsigned char ext_hdr, struct arm_spe_pkt *packet)
>  {
> -	if (len < 2)
> -		return ARM_SPE_NEED_MORE_BYTES;
> -
>  	packet->type = ARM_SPE_COUNTER;
>  	if (ext_hdr)
>  		packet->index = ((buf[0] & 0x3) << 3) | (buf[1] & 0x7);
>  	else
>  		packet->index = buf[0] & 0x7;
>  
> -	packet->payload = le16_to_cpu(*(uint16_t *)(buf + 1));
> -
> -	return 1 + ext_hdr + 2;
> +	return arm_spe_get_payload(buf, len, ext_hdr, packet);
>  }
>  
>  static int arm_spe_get_addr(const unsigned char *buf, size_t len,
>  			    const unsigned char ext_hdr, struct arm_spe_pkt *packet)
>  {
> -	if (len < 8)
> -		return ARM_SPE_NEED_MORE_BYTES;
> -
>  	packet->type = ARM_SPE_ADDRESS;
>  	if (ext_hdr)
>  		packet->index = ((buf[0] & 0x3) << 3) | (buf[1] & 0x7);
>  	else
>  		packet->index = buf[0] & 0x7;
>  
> -	memcpy_le64(&packet->payload, buf + 1, 8);
> -
> -	return 1 + ext_hdr + 8;
> +	return arm_spe_get_payload(buf, len, ext_hdr, packet);
>  }
>  
>  static int arm_spe_do_get_packet(const unsigned char *buf, size_t len,
> 


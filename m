Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D972C2A2FC0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgKBQZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:25:52 -0500
Received: from foss.arm.com ([217.140.110.172]:33782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbgKBQZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:25:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80FD330E;
        Mon,  2 Nov 2020 08:25:51 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D26963F719;
        Mon,  2 Nov 2020 08:25:49 -0800 (PST)
Date:   Mon, 2 Nov 2020 16:25:36 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andre Przywara <Andre.Przywara@arm.com>,
        James Clark <James.Clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        Wei Li <liwei391@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 20/21] perf arm_spe: Decode memory tagging properties
Message-ID: <20201102162519.GA6882@arm.com>
References: <20201030025724.19157-1-leo.yan@linaro.org>
 <20201030025724.19157-21-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030025724.19157-21-leo.yan@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 02:57:23AM +0000, Leo Yan wrote:
> From: Andre Przywara <andre.przywara@arm.com>
> 
> When SPE records a physical address, it can additionally tag the event
> with information from the Memory Tagging architecture extension.
> 
> Decode the two additional fields in the SPE event payload.
> 
> [leoy: Refined patch to use predefined macros]
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 6 +++++-
>  tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 2 ++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 3fca65e9cbbf..9ec3057de86f 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -371,6 +371,7 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
>  				 char *buf, size_t buf_len)
>  {
>  	int ns, el, idx = packet->index;
> +	int ch, pat;
>  	u64 payload = packet->payload;
>  	int err = 0;
>  
> @@ -388,9 +389,12 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
>  					    "VA 0x%llx", payload);
>  	case SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS:
>  		ns = !!SPE_ADDR_PKT_GET_NS(payload);
> +		ch = !!SPE_ADDR_PKT_GET_CH(payload);
> +		pat = SPE_ADDR_PKT_GET_PAT(payload);
>  		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
>  		return arm_spe_pkt_snprintf(&err, &buf, &buf_len,
> -					    "PA 0x%llx ns=%d", payload, ns);
> +					    "PA 0x%llx ns=%d ch=%d, pat=%x",

Nit: given that this data is all closely related, do we really want the
extra comma here?

(Note, I am not familiar with how this text is consumed, so if there are
other reasons why the comma is needed then that's probably fine.)

> +					    payload, ns, ch, pat);
>  	default:
>  		return 0;
>  	}
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> index 7032fc141ad4..1ad14885c2a1 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> @@ -73,6 +73,8 @@ struct arm_spe_pkt {
>  
>  #define SPE_ADDR_PKT_GET_NS(v)			(((v) & BIT_ULL(63)) >> 63)
>  #define SPE_ADDR_PKT_GET_EL(v)			(((v) & GENMASK_ULL(62, 61)) >> 61)
> +#define SPE_ADDR_PKT_GET_CH(v)			(((v) & BIT_ULL(62)) >> 62)
> +#define SPE_ADDR_PKT_GET_PAT(v)			(((v) & GENMASK_ULL(59, 56)) >> 56)

These seem to match the spec.

With or without addressing the nit above:

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

[...]

Cheers
---Dave

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD5E27AEFC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 15:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgI1NVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 09:21:23 -0400
Received: from foss.arm.com ([217.140.110.172]:51584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgI1NVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 09:21:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CA581063;
        Mon, 28 Sep 2020 06:21:22 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F6F73F73B;
        Mon, 28 Sep 2020 06:21:20 -0700 (PDT)
Date:   Mon, 28 Sep 2020 14:21:17 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Andre Przywara <andre.przywara@arm.com>
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
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/5] perf: arm_spe: Decode SVE events
Message-ID: <20200928132114.GF6642@arm.com>
References: <20200922101225.183554-1-andre.przywara@arm.com>
 <20200922101225.183554-6-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922101225.183554-6-andre.przywara@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 11:12:25AM +0100, Andre Przywara wrote:
> The Scalable Vector Extension (SVE) is an ARMv8 architecture extension
> that introduces very long vector operations (up to 2048 bits).

(8192, in fact, though don't expect to see that on real hardware any
time soon...  qemu and the Arm fast model can do it, though.)

> The SPE profiling feature can tag SVE instructions with additional
> properties like predication or the effective vector length.
> 
> Decode the new operation type bits in the SPE decoder to allow the perf
> tool to correctly report about SVE instructions.


I don't know anything about SPE, so just commenting on a few minor
things that catch my eye here.

> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 48 ++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index a033f34846a6..f0c369259554 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -372,8 +372,35 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  	}
>  	case ARM_SPE_OP_TYPE:
>  		switch (idx) {
> -		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
> +		case 0: {
> +			size_t blen = buf_len;
> +
> +			if ((payload & 0x89) == 0x08) {
> +				ret = snprintf(buf, buf_len, "SVE");
> +				buf += ret;
> +				blen -= ret;

(Nit: can ret be < 0 ?  I've never been 100% clear on this myself for
the s*printf() family -- if this assumption is widespread in perf tool
a lready that I guess just go with the flow.)

I wonder if this snprintf+increment+decrement sequence could be wrapped
up as a helper, rather than having to be repeated all over the place.

> +				if (payload & 0x2)
> +					ret = snprintf(buf, buf_len, " FP");
> +				else
> +					ret = snprintf(buf, buf_len, " INT");
> +				buf += ret;
> +				blen -= ret;
> +				if (payload & 0x4) {
> +					ret = snprintf(buf, buf_len, " PRED");
> +					buf += ret;
> +					blen -= ret;
> +				}
> +				/* Bits [7..4] encode the vector length */
> +				ret = snprintf(buf, buf_len, " EVLEN%d",
> +					       32 << ((payload >> 4) & 0x7));

Isn't this just extracting 3 bits (0x7)?  And what unit are we aiming
for here: is it the number of bytes per vector, or something else?  I'm
confused by the fact that this will go up in steps of 32, which doesn't
seem to match up to the architecure.

I notice that bit 7 has to be zero to get into this if() though.

> +				buf += ret;
> +				blen -= ret;
> +				return buf_len - blen;
> +			}
> +
> +			return snprintf(buf, buf_len, "%s", payload & 0x1 ?
>  					"COND-SELECT" : "INSN-OTHER");
> +			}
>  		case 1:	{
>  			size_t blen = buf_len;
>  
> @@ -403,6 +430,25 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  				ret = snprintf(buf, buf_len, " NV-SYSREG");
>  				buf += ret;
>  				blen -= ret;
> +			} else if ((payload & 0x0a) == 0x08) {
> +				ret = snprintf(buf, buf_len, " SVE");
> +				buf += ret;
> +				blen -= ret;
> +				if (payload & 0x4) {
> +					ret = snprintf(buf, buf_len, " PRED");
> +					buf += ret;
> +					blen -= ret;
> +				}
> +				if (payload & 0x80) {
> +					ret = snprintf(buf, buf_len, " SG");
> +					buf += ret;
> +					blen -= ret;
> +				}
> +				/* Bits [7..4] encode the vector length */
> +				ret = snprintf(buf, buf_len, " EVLEN%d",
> +					       32 << ((payload >> 4) & 0x7));

Same comment as above.  Maybe have a common helper for decoding the
vector length bits so it can be fixed in a single place?

> +				buf += ret;
> +				blen -= ret;
>  			} else if (payload & 0x4) {
>  				ret = snprintf(buf, buf_len, " SIMD-FP");
>  				buf += ret;

Cheers
---Dave

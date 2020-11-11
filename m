Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6CF2AF774
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 18:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgKKRj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 12:39:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgKKRj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 12:39:28 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC0382072C;
        Wed, 11 Nov 2020 17:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605116366;
        bh=UGRPuPGMwJk1uD55KX9lKhIsoRD1FGHg4QUXFcxV5E4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SWxfkImz+3BRcMhl/roAAgJEpPD7oRqNgra2wwxteoc5rp/q1JB5Ag/SC/9BTDbbY
         k4mj1cJZOq8D79UDR5C6P9ejQuZGVomBR8pfSRnd/zMbGbTrixZHZIrAUvU2AiDsx7
         FV/uilgRslqmQzGCkVZplntSnq69JmD3ouV0qETA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D8EA4411D1; Wed, 11 Nov 2020 14:39:22 -0300 (-03)
Date:   Wed, 11 Nov 2020 14:39:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>, Dave Martin <Dave.Martin@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Al Grant <Al.Grant@arm.com>, Wei Li <liwei391@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 06/22] perf arm-spe: Refactor printing string to buffer
Message-ID: <20201111173922.GA380127@kernel.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
 <20201111071149.815-7-leo.yan@linaro.org>
 <20201111153555.GG355344@kernel.org>
 <a1ca3412-3815-e2a8-0334-f3059802df6a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1ca3412-3815-e2a8-0334-f3059802df6a@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 11, 2020 at 03:45:23PM +0000, André Przywara escreveu:
> On 11/11/2020 15:35, Arnaldo Carvalho de Melo wrote:
> 
> Hi Arnaldo,
> 
> thanks for taking a look!
> 
> > Em Wed, Nov 11, 2020 at 03:11:33PM +0800, Leo Yan escreveu:
> >> When outputs strings to the decoding buffer with function snprintf(),
> >> SPE decoder needs to detects if any error returns from snprintf() and if
> >> so needs to directly bail out.  If snprintf() returns success, it needs
> >> to update buffer pointer and reduce the buffer length so can continue to
> >> output the next string into the consequent memory space.
> >>
> >> This complex logics are spreading in the function arm_spe_pkt_desc() so
> >> there has many duplicate codes for handling error detecting, increment
> >> buffer pointer and decrement buffer size.
> >>
> >> To avoid the duplicate code, this patch introduces a new helper function
> >> arm_spe_pkt_snprintf() which is used to wrap up the complex logics, and
> >> it's used by the caller arm_spe_pkt_desc().
> >>
> >> This patch also moves the variable 'blen' as the function's local
> >> variable, this allows to remove the unnecessary braces and improve the
> >> readability.
> >>
> >> Suggested-by: Dave Martin <Dave.Martin@arm.com>
> >> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> >> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> >> ---
> >>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 260 +++++++++---------
> >>  1 file changed, 126 insertions(+), 134 deletions(-)
> >>
> >> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> >> index 04fd7fd7c15f..1970686f7020 100644
> >> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> >> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> >> @@ -9,6 +9,7 @@
> >>  #include <endian.h>
> >>  #include <byteswap.h>
> >>  #include <linux/bitops.h>
> >> +#include <stdarg.h>
> >>  
> >>  #include "arm-spe-pkt-decoder.h"
> >>  
> >> @@ -258,192 +259,183 @@ int arm_spe_get_packet(const unsigned char *buf, size_t len,
> >>  	return ret;
> >>  }
> >>  
> >> +static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
> >> +				const char *fmt, ...)
> >> +{
> >> +	va_list ap;
> >> +	int ret;
> >> +
> >> +	/* Bail out if any error occurred */
> >> +	if (err && *err)
> >> +		return *err;
> >> +
> >> +	va_start(ap, fmt);
> >> +	ret = vsnprintf(*buf_p, *blen, fmt, ap);
> >> +	va_end(ap);
> >> +
> >> +	if (ret < 0) {
> >> +		if (err && !*err)
> >> +			*err = ret;
> >> +
> >> +	/*
> >> +	 * A return value of (*blen - 1) or more means that the
> >> +	 * output was truncated and the buffer is overrun.
> >> +	 */
> >> +	} else if (ret >= ((int)*blen - 1)) {
> >> +		(*buf_p)[*blen - 1] = '\0';
> >> +
> >> +		/*
> >> +		 * Set *err to 'ret' to avoid overflow if tries to
> >> +		 * fill this buffer sequentially.
> >> +		 */
> >> +		if (err && !*err)
> >> +			*err = ret;
> >> +	} else {
> >> +		*buf_p += ret;
> >> +		*blen -= ret;
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> +
> >>  int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> >>  		     size_t buf_len)
> >>  {
> >>  	int ret, ns, el, idx = packet->index;
> >>  	unsigned long long payload = packet->payload;
> >>  	const char *name = arm_spe_pkt_name(packet->type);
> >> +	size_t blen = buf_len;
> >> +	int err = 0;
> >>  
> >>  	switch (packet->type) {
> >>  	case ARM_SPE_BAD:
> >>  	case ARM_SPE_PAD:
> >>  	case ARM_SPE_END:
> >> -		return snprintf(buf, buf_len, "%s", name);
> >> -	case ARM_SPE_EVENTS: {
> >> -		size_t blen = buf_len;
> >> -
> >> -		ret = 0;
> >> -		ret = snprintf(buf, buf_len, "EV");
> >> -		buf += ret;
> >> -		blen -= ret;
> >> -		if (payload & 0x1) {
> >> -			ret = snprintf(buf, buf_len, " EXCEPTION-GEN");
> >> -			buf += ret;
> >> -			blen -= ret;
> >> -		}
> >> -		if (payload & 0x2) {
> >> -			ret = snprintf(buf, buf_len, " RETIRED");
> >> -			buf += ret;
> >> -			blen -= ret;
> >> -		}
> >> -		if (payload & 0x4) {
> >> -			ret = snprintf(buf, buf_len, " L1D-ACCESS");
> >> -			buf += ret;
> >> -			blen -= ret;
> >> -		}
> >> -		if (payload & 0x8) {
> >> -			ret = snprintf(buf, buf_len, " L1D-REFILL");
> >> -			buf += ret;
> >> -			blen -= ret;
> >> -		}
> >> -		if (payload & 0x10) {
> >> -			ret = snprintf(buf, buf_len, " TLB-ACCESS");
> >> -			buf += ret;
> >> -			blen -= ret;
> >> -		}
> >> -		if (payload & 0x20) {
> >> -			ret = snprintf(buf, buf_len, " TLB-REFILL");
> >> -			buf += ret;
> >> -			blen -= ret;
> >> -		}
> >> -		if (payload & 0x40) {
> >> -			ret = snprintf(buf, buf_len, " NOT-TAKEN");
> >> -			buf += ret;
> >> -			blen -= ret;
> >> -		}
> >> -		if (payload & 0x80) {
> >> -			ret = snprintf(buf, buf_len, " MISPRED");
> >> -			buf += ret;
> >> -			blen -= ret;
> >> -		}
> >> +		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s", name);
> >> +	case ARM_SPE_EVENTS:
> >> +		ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "EV");
> >> +
> >> +		if (payload & 0x1)
> >> +			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCEPTION-GEN");
> > 
> > Isn't this 'ret +=' ? Otherwise if any of these arm_spe_pkt_snprintf()
> > calls are made the previous 'ret' value is simply discarded. Can you
> > clarify this?
> 
> ret is the same as err. If err is negative (from previous calls), we
> return that straight away, so it does nothing but propagating the error.

Usually the return of a snprintf is used to account for buffer space, ok
I'll have to read it, which I shouldn't as snprintf has a well defined
meaning...

Ok, now that I look at it, I realize it is not a snprintf() routine, but
something with different semantics, that will look at a pointer to an
integer and then do nothing if it comes with some error, etc, confusing
:-/

> That redundancy gets cleaned up in the next patch.

I'll fixup the bitops part and try to continue.

- Arnaldo
 
> This patch split is somewhat cumbersome, but was done to simplify review
> (originally 06 and 07 were one patch). The combined patch made it hard
> to match the individual changes. If you feel unsure about it, or you
> feel it looks better, you could also merge both 06/22 and 07/22 into a
> single patch.
> 
> Hope that helps.

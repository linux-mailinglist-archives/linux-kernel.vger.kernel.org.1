Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99F42A3CE9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 07:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgKCGk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 01:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgKCGk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 01:40:57 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1634C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 22:40:57 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c20so13325052pfr.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 22:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oIF9pPdLwSg0GekwDc+/mdYbxUWryNa3Y3hlDICI2vU=;
        b=g8NEkNvWaN+ivNp2r4y4crtxYgAistareN7Xo9ZYDnlMhkiqaH8fwiy2mWSWLCf2cE
         NVtCdpWSh4eP+T/nB034m1ZOwlBtf69LoUqtB5ulJi2rCFkbUrc9ZdupaPsbxvaz126w
         Wf0TgMCmMTKBiSIdju2kOY1ipFAeMiSOC23MVB1ELmtrIhBchlHuihPChoEKmF8AQYC2
         VClgnSbsOaQ24vXSCSLTErAU5dAYjHsJWTWiw2dVYkX7S1gb/nkUn1YjUcPx8ALTWQOt
         ceQ+8KhElgtBrynZGl8VljYT6w+jyePS0zZvuablX602LndoDS/l5YbFbhmaeTvSagC/
         hyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oIF9pPdLwSg0GekwDc+/mdYbxUWryNa3Y3hlDICI2vU=;
        b=qVu1lw6z+wlymuooO6h3+4qS/ObAiMsp5hVmRQp97jiWMW1rhVfoTbh+WxwrPhJKNZ
         ZBypKO4FYS855c4g4JMIKe9vBB9G4Jlui6Ta1x01zKSRphxSgnJ0HL5ZSITTZlvyYeM8
         Ytsc12taCNhTQv8IlHX85G5kOTiKuTQGomxFhhHpbsT/XERXHyvqsKmyVFsEeZURpPI7
         0uMTvMXHhctLuEVHVVwhXwgRQ/sSHFrAtLji4gPkER4hmZfiaSwHfA2loYc7igeqWwXW
         k3kN7hztL+ojqaNAgOoVDDfJZ0fZ/IUytp3Qzlw5QeojZ1YcFfYUCFC8+zeF966ozZUQ
         2wDg==
X-Gm-Message-State: AOAM530P2eQDrSe2HBSmUKT0Qp7byROUwelkRCj88wsd6gTek4GAjxiY
        40tA5mk1wiiTTO6ItPZ6r2pUtQ==
X-Google-Smtp-Source: ABdhPJxzwAtRgMDkmKiqijz9xCqNFKuZstNOQ9Bl/bSLK+HkenchYsGG0YcVKWy6kxsipbzsCA7nxA==
X-Received: by 2002:a17:90a:fd08:: with SMTP id cv8mr2173974pjb.203.1604385656951;
        Mon, 02 Nov 2020 22:40:56 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.141.182.112])
        by smtp.gmail.com with ESMTPSA id c187sm16427724pfc.153.2020.11.02.22.40.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Nov 2020 22:40:56 -0800 (PST)
Date:   Tue, 3 Nov 2020 14:40:47 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Dave Martin <Dave.Martin@arm.com>
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
Subject: Re: [PATCH v6 06/21] perf arm-spe: Refactor printing string to buffer
Message-ID: <20201103064047.GD13232@leoy-ThinkPad-X240s>
References: <20201030025724.19157-1-leo.yan@linaro.org>
 <20201030025724.19157-7-leo.yan@linaro.org>
 <20201102170653.GB6882@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102170653.GB6882@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Mon, Nov 02, 2020 at 05:06:53PM +0000, Dave Martin wrote:
> On Fri, Oct 30, 2020 at 02:57:09AM +0000, Leo Yan wrote:
> > When outputs strings to the decoding buffer with function snprintf(),
> > SPE decoder needs to detects if any error returns from snprintf() and if
> > so needs to directly bail out.  If snprintf() returns success, it needs
> > to update buffer pointer and reduce the buffer length so can continue to
> > output the next string into the consequent memory space.
> > 
> > This complex logics are spreading in the function arm_spe_pkt_desc() so
> > there has many duplicate codes for handling error detecting, increment
> > buffer pointer and decrement buffer size.
> > 
> > To avoid the duplicate code, this patch introduces a new helper function
> > arm_spe_pkt_snprintf() which is used to wrap up the complex logics, and
> > it's used by the caller arm_spe_pkt_desc(); if printing buffer is called
> > for multiple times in a flow, the error is a cumulative value and simply
> > returns its final value.
> > 
> > This patch also moves the variable 'blen' as the function's local
> > variable, this allows to remove the unnecessary braces and improve the
> > readability.
> > 
> > Suggested-by: Dave Martin <Dave.Martin@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> This looks like a good refacroting now, but as pointed out by Andre this
> patch is now rather hard to review, since it combines the refactoring
> with other changes.
> 
> If reposting this series, it would be good if this could be split into a
> first patch that introduces arm_spe_pkt_snprintf() and just updates each
> snprintf() call site to use it, but without moving other code around or
> optimising anything, followed by one or more patches that clean up and
> simplify arm_spe_pkt_desc().

I will respin the patch set and follow this approach.

> If the series is otherwise mature though, then this rework may be
> overkill.
> 
> > ---
> >  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 267 ++++++++----------
> >  1 file changed, 117 insertions(+), 150 deletions(-)
> > 
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > index 04fd7fd7c15f..1ecaf9805b79 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > @@ -9,6 +9,7 @@
> >  #include <endian.h>
> >  #include <byteswap.h>
> >  #include <linux/bitops.h>
> > +#include <stdarg.h>
> >  
> >  #include "arm-spe-pkt-decoder.h"
> >  
> > @@ -258,192 +259,158 @@ int arm_spe_get_packet(const unsigned char *buf, size_t len,
> >  	return ret;
> >  }
> >  
> > +static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
> > +				const char *fmt, ...)
> > +{
> > +	va_list ap;
> > +	int ret;
> > +
> > +	/* Bail out if any error occurred */
> > +	if (err && *err)
> > +		return *err;
> > +
> > +	va_start(ap, fmt);
> > +	ret = vsnprintf(*buf_p, *blen, fmt, ap);
> > +	va_end(ap);
> > +
> > +	if (ret < 0) {
> > +		if (err && !*err)
> > +			*err = ret;
> 
> What happens on buffer overrun (i.e., ret >= *blen)?
> 
> It looks to me like we'll advance buf_p too far, blen will wrap around,
> and the string at *buf_p won't be null terminated.  Because the return
> value is still >= 0, this condition will be returned up the stack as
> "success".

Thanks for pointint out this.  I never note for the potential issue
caused by returned value (ret >= *blen);  checked again for the
manual, it says:

"The functions snprintf() and vsnprintf() do not write more than size
bytes (including the terminating null byte ('\0')).  If the output was
truncated due to this limit, then the return value is the number of
characters (excluding  the  terminating  null  byte) which would have
been written to the final string if enough space had been available.
Thus, a return value of size or more means that the output was
truncated."

> Perhaps this can never happen given the actual buffer sizes and strings
> being printed, but it feels a bit unsafe.
> 
> 
> It may be better to clamp the adjustments to *buf_p and *blen to
> *blen - 1 in this case, and explicitly set (*buf_p)[*blen - 1] to '\0'.
> We _may_ want indicate failure in the return from arm_spe_pkt_desc() in
> this situation, but I don't know enough about how this code is called to
> enable me to judge that.

The caller arm_spe_dump() will print out the string if the return
value > 0 [1]; so I think it can simply return the string length which
has been written to the buffer (with the clamped value).  The function
can be refined as below:

static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
				const char *fmt, ...)
{
	va_list ap;
	int ret;

	/* Bail out if any error occurred */
	if (err && *err)
		return *err;

	va_start(ap, fmt);
	ret = vsnprintf(*buf_p, *blen - 1, fmt, ap);
	va_end(ap);

	if (ret < 0) {
		if (err && !*err)
			*err = ret;
	} else {

                /*
                 * A return value of (*blen - 1) or more means that the
                 * output was truncated and the buffer is overrun.
                 */
                if (ret >= (*blen - 1)) {
                        (*buf_p)[*blen - 1] = '\0';

                        /*
                         * Set *err to -1 to avoid overflow if tries to
                         * fill this buffer sequentially.
                         */
		        if (err && !*err)
		        	*err = -1;

                        /* Clamp the size of characters printed */
                        ret = min(ret, *blen);
                }

		*buf_p += ret;
		*blen -= ret;
	}

	return ret;
}

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/arm-spe.c#n116

> (Note, this issue is not introduced by this patch, but this refactoring
> makes it easier to address it in a single place -- so it may now be
> worth doing so.)

Agree.

> > +	} else {
> > +		*buf_p += ret;
> > +		*blen -= ret;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> >  		     size_t buf_len)
> >  {
> > -	int ret, ns, el, idx = packet->index;
> > +	int ns, el, idx = packet->index;
> >  	unsigned long long payload = packet->payload;
> >  	const char *name = arm_spe_pkt_name(packet->type);
> > +	size_t blen = buf_len;
> > +	int err = 0;
> >  
> >  	switch (packet->type) {
> >  	case ARM_SPE_BAD:
> >  	case ARM_SPE_PAD:
> >  	case ARM_SPE_END:
> > -		return snprintf(buf, buf_len, "%s", name);
> > -	case ARM_SPE_EVENTS: {
> > -		size_t blen = buf_len;
> > -
> > -		ret = 0;
> > -		ret = snprintf(buf, buf_len, "EV");
> > -		buf += ret;
> > -		blen -= ret;
> > -		if (payload & 0x1) {
> > -			ret = snprintf(buf, buf_len, " EXCEPTION-GEN");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > -		if (payload & 0x2) {
> > -			ret = snprintf(buf, buf_len, " RETIRED");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > -		if (payload & 0x4) {
> > -			ret = snprintf(buf, buf_len, " L1D-ACCESS");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > -		if (payload & 0x8) {
> > -			ret = snprintf(buf, buf_len, " L1D-REFILL");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > -		if (payload & 0x10) {
> > -			ret = snprintf(buf, buf_len, " TLB-ACCESS");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > -		if (payload & 0x20) {
> > -			ret = snprintf(buf, buf_len, " TLB-REFILL");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > -		if (payload & 0x40) {
> > -			ret = snprintf(buf, buf_len, " NOT-TAKEN");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > -		if (payload & 0x80) {
> > -			ret = snprintf(buf, buf_len, " MISPRED");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > +		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s", name);
> > +	case ARM_SPE_EVENTS:
> > +		arm_spe_pkt_snprintf(&err, &buf, &blen, "EV");
> > +
> > +		if (payload & 0x1)
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCEPTION-GEN");
> > +		if (payload & 0x2)
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " RETIRED");
> > +		if (payload & 0x4)
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-ACCESS");
> > +		if (payload & 0x8)
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-REFILL");
> > +		if (payload & 0x10)
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-ACCESS");
> > +		if (payload & 0x20)
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-REFILL");
> > +		if (payload & 0x40)
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " NOT-TAKEN");
> > +		if (payload & 0x80)
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " MISPRED");
> >  		if (idx > 1) {
> > -			if (payload & 0x100) {
> > -				ret = snprintf(buf, buf_len, " LLC-ACCESS");
> > -				buf += ret;
> > -				blen -= ret;
> > -			}
> > -			if (payload & 0x200) {
> > -				ret = snprintf(buf, buf_len, " LLC-REFILL");
> > -				buf += ret;
> > -				blen -= ret;
> > -			}
> > -			if (payload & 0x400) {
> > -				ret = snprintf(buf, buf_len, " REMOTE-ACCESS");
> > -				buf += ret;
> > -				blen -= ret;
> > -			}
> > +			if (payload & 0x100)
> > +				arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-ACCESS");
> > +			if (payload & 0x200)
> > +				arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-REFILL");
> > +			if (payload & 0x400)
> > +				arm_spe_pkt_snprintf(&err, &buf, &blen, " REMOTE-ACCESS");
> >  		}
> > -		if (ret < 0)
> > -			return ret;
> > -		blen -= ret;
> > -		return buf_len - blen;
> 
> It looks like we now fall off the bottom of the switch() here.  It's
> preferable to add a break, both to document the intended code flow, and
> to avoid accidents if another case is added later.

Will do this.

> > -	}
> > +		return err ?: (int)(buf_len - blen);
> 
> Nit: unexplained type cast.  Does the result definitely fit into an int?
> If not, why doesn't it matter?

The case is to dismiss the compiler warning.

GCC doesn't compliant for the code:

  return buf_len - blen;
  
But GCC compliants type mismatch after change to code:

  return err ?: buf_len - blen;

> Also:
> 
> If the actual return value is important for the caller to determine the
> number of bytes appended, then it would be better to compute it in one
> place.  Otherwise, it would be better to squash all success returns to 0,
> rather than spend effort computing a value that may be misleading or
> wrong anyway.
> 
> In its current form, it's tricky to see whether this patch derives the
> return value consistently for all cases.  In particular, if some code
> patch does one or more arm_spe_pkt_snprintf(), followed by a
> return arm_spe_pkt_snprintf(); then the return value (which only takes
> the last arm_spe_pkt_desc() into account) would be wrong.  It would be
> preferable if the return value for the success case were always
> computed from buf_len and blen, to avoid this risk.  (I'm not saying
> this bug exists, just that it's hard to see from the patch that it
> doesn't exist.)

I think I can go back to return value "buf_len - blen" and don't
check "err" anymore.

If the string buffer is truncated due to size limitation, we can still
return "buf_len - blen" so can allow caller to dump string as
possible.

If arm_spe_pkt_snprintf() returns -1 at the first call, "buf_len" is
equal to "blen", thus return value of "buf_len - blen" will be zero.
For this case, the caller will get to know there have no valid string
and will skip to print anything.

Does this make sense?

> > +
> >  	case ARM_SPE_OP_TYPE:
> >  		switch (idx) {
> > -		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
> > -					"COND-SELECT" : "INSN-OTHER");
> > -		case 1:	{
> > -			size_t blen = buf_len;
> > +		case 0:
> > +			return arm_spe_pkt_snprintf(&err, &buf, &blen,
> > +					payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
> > +		case 1:
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen,
> > +					     payload & 0x1 ? "ST" : "LD");
> >  
> > -			if (payload & 0x1)
> > -				ret = snprintf(buf, buf_len, "ST");
> > -			else
> > -				ret = snprintf(buf, buf_len, "LD");
> > -			buf += ret;
> > -			blen -= ret;
> >  			if (payload & 0x2) {
> > -				if (payload & 0x4) {
> > -					ret = snprintf(buf, buf_len, " AT");
> > -					buf += ret;
> > -					blen -= ret;
> > -				}
> > -				if (payload & 0x8) {
> > -					ret = snprintf(buf, buf_len, " EXCL");
> > -					buf += ret;
> > -					blen -= ret;
> > -				}
> > -				if (payload & 0x10) {
> > -					ret = snprintf(buf, buf_len, " AR");
> > -					buf += ret;
> > -					blen -= ret;
> > -				}
> > +				if (payload & 0x4)
> > +					arm_spe_pkt_snprintf(&err, &buf, &blen, " AT");
> > +				if (payload & 0x8)
> > +					arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCL");
> > +				if (payload & 0x10)
> > +					arm_spe_pkt_snprintf(&err, &buf, &blen, " AR");
> >  			} else if (payload & 0x4) {
> > -				ret = snprintf(buf, buf_len, " SIMD-FP");
> > -				buf += ret;
> > -				blen -= ret;
> > -			}
> > -			if (ret < 0)
> > -				return ret;
> > -			blen -= ret;
> > -			return buf_len - blen;
> > -		}
> > -		case 2:	{
> > -			size_t blen = buf_len;
> > -
> > -			ret = snprintf(buf, buf_len, "B");
> > -			buf += ret;
> > -			blen -= ret;
> > -			if (payload & 0x1) {
> > -				ret = snprintf(buf, buf_len, " COND");
> > -				buf += ret;
> > -				blen -= ret;
> > -			}
> > -			if (payload & 0x2) {
> > -				ret = snprintf(buf, buf_len, " IND");
> > -				buf += ret;
> > -				blen -= ret;
> > +				arm_spe_pkt_snprintf(&err, &buf, &blen, " SIMD-FP");
> >  			}
> > -			if (ret < 0)
> > -				return ret;
> > -			blen -= ret;
> > -			return buf_len - blen;
> > -			}
> > -		default: return 0;
> > +
> > +			return err ?: (int)(buf_len - blen);
> > +
> > +		case 2:
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, "B");
> > +
> > +			if (payload & 0x1)
> > +				arm_spe_pkt_snprintf(&err, &buf, &blen, " COND");
> > +			if (payload & 0x2)
> > +				arm_spe_pkt_snprintf(&err, &buf, &blen, " IND");
> > +
> > +			return err ?: (int)(buf_len - blen);
> > +
> > +		default:
> > +			return 0;
> >  		}
> >  	case ARM_SPE_DATA_SOURCE:
> >  	case ARM_SPE_TIMESTAMP:
> > -		return snprintf(buf, buf_len, "%s %lld", name, payload);
> > +		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %lld", name, payload);
> >  	case ARM_SPE_ADDRESS:
> >  		switch (idx) {
> >  		case 0:
> >  		case 1: ns = !!(packet->payload & NS_FLAG);
> >  			el = (packet->payload & EL_FLAG) >> 61;
> >  			payload &= ~(0xffULL << 56);
> > -			return snprintf(buf, buf_len, "%s 0x%llx el%d ns=%d",
> > +			return arm_spe_pkt_snprintf(&err, &buf, &blen,
> > +					"%s 0x%llx el%d ns=%d",
> >  				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
> > -		case 2:	return snprintf(buf, buf_len, "VA 0x%llx", payload);
> > +		case 2:
> > +			return arm_spe_pkt_snprintf(&err, &buf, &blen,
> > +						    "VA 0x%llx", payload);
> >  		case 3:	ns = !!(packet->payload & NS_FLAG);
> >  			payload &= ~(0xffULL << 56);
> > -			return snprintf(buf, buf_len, "PA 0x%llx ns=%d",
> > -					payload, ns);
> > -		default: return 0;
> > +			return arm_spe_pkt_snprintf(&err, &buf, &blen,
> > +						    "PA 0x%llx ns=%d", payload, ns);
> > +		default:
> > +			return 0;
> >  		}
> >  	case ARM_SPE_CONTEXT:
> > -		return snprintf(buf, buf_len, "%s 0x%lx el%d", name,
> > -				(unsigned long)payload, idx + 1);
> > -	case ARM_SPE_COUNTER: {
> > -		size_t blen = buf_len;
> > -
> > -		ret = snprintf(buf, buf_len, "%s %d ", name,
> > -			       (unsigned short)payload);
> > -		buf += ret;
> > -		blen -= ret;
> > +		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%lx el%d",
> > +					    name, (unsigned long)payload, idx + 1);
> > +	case ARM_SPE_COUNTER:
> > +		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %d ", name,
> > +				     (unsigned short)payload);
> > +
> >  		switch (idx) {
> > -		case 0:	ret = snprintf(buf, buf_len, "TOT"); break;
> > -		case 1:	ret = snprintf(buf, buf_len, "ISSUE"); break;
> > -		case 2:	ret = snprintf(buf, buf_len, "XLAT"); break;
> > -		default: ret = 0;
> > +		case 0:
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, "TOT");
> > +			break;
> > +		case 1:
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, "ISSUE");
> > +			break;
> > +		case 2:
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, "XLAT");
> > +			break;
> > +		default:
> > +			break;
> >  		}
> > -		if (ret < 0)
> > -			return ret;
> > -		blen -= ret;
> > -		return buf_len - blen;
> > -	}
> > +
> > +		return err ?: (int)(buf_len - blen);
> > +
> >  	default:
> >  		break;
> >  	}
> >  
> > -	return snprintf(buf, buf_len, "%s 0x%llx (%d)",
> > -			name, payload, packet->index);
> > +	return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%llx (%d)",
> > +				    name, payload, packet->index);
> 
> Otherwise, the patch looks generally OK, but I'd like to see an answer
> on my points above.

Thanks a lot for reviewing!

Leo

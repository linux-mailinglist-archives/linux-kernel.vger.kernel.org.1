Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C952A5F9A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgKDI3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgKDI3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:29:14 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B245C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 00:29:14 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id x13so15950010pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 00:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=O1auUl+vOthPDtyFar6Tj/RvltdoikDAl5xBg9FKTao=;
        b=X5D7oZe07P8qVGd+EbNhoWTtd0Exs0gRsD0XPXOqEbYKB5Mg/mpYB3qxiki8lP5f9K
         cACmwyGHHt39ixUJxqzmvfpNqi1/WgvocCistVolJpjP+7O0vpI4sLkTBw/NEAT4LGsW
         10IfXyVvV/uZhbxUAhezGdi6hT9eZc0/6RayUYogY0nEWvq8TSL+NOugPKsy8qoBhSHo
         AesBlCm2/dqcxk8Veg0sS7p8deePXVpXJr2imDm0pO5PEd0sRgoSmOkk4qC+8UmgS5Tk
         ewgoNoDMbQhB0Xsxa5xMz86T02zzrKCA45tLQWsUU/ijphymrkQ1k9/HvIjpBAwuMjhS
         4WJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=O1auUl+vOthPDtyFar6Tj/RvltdoikDAl5xBg9FKTao=;
        b=FDM1KTMkM/b/rMWWoVB5DVKsYeH2VcV5kIs5jcQM+dUhS5MmevCwXJo6H9b4khg3NE
         M+KIAz9SqQDB+DjZTsES1BpgljNxLaapwA78VZ8suWK1tMWNrMVSQ0A+Ko6smJXLwMUE
         uFkM7vuDmef+PAiXvzluZ9RrSZTA13lfApkrpDMidsw8xfgTIZ7JXlyGvkCMq4CAoDis
         9QX2lA5aXqbJqfGvClw0gwIT56tbJIGojM4fo7DoqttRDlHRsE8oOzxV/0Jhgw+7htAm
         75l2qYPyp+FtoWgGTjDPVzjOPI9LYYJrhbcTBZtfztP+hgo+II3h5xYKPOwGD8BzxFZG
         L4hw==
X-Gm-Message-State: AOAM533Jpi19smhuzulmVYiM2WACExKr4YeK2veIFXWlRfQr8WSyo4Lf
        RVEUTCViCFguzh9dQFpLHxXr9w==
X-Google-Smtp-Source: ABdhPJy7sRawNMQhWK/OpT+QZZG3eLlOvI2LyMMNETK27E7w1WegEuqkOc21LzAalJxnWVfgiax6yg==
X-Received: by 2002:aa7:87d7:0:b029:163:c013:884e with SMTP id i23-20020aa787d70000b0290163c013884emr28224818pfo.19.1604478553794;
        Wed, 04 Nov 2020 00:29:13 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id k5sm1451128pjs.14.2020.11.04.00.29.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Nov 2020 00:29:12 -0800 (PST)
Date:   Wed, 4 Nov 2020 16:29:06 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <James.Clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        Wei Li <liwei391@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 06/21] perf arm-spe: Refactor printing string to buffer
Message-ID: <20201104082906.GB30816@leoy-ThinkPad-X240s>
References: <20201030025724.19157-1-leo.yan@linaro.org>
 <20201030025724.19157-7-leo.yan@linaro.org>
 <20201102170653.GB6882@arm.com>
 <20201103064047.GD13232@leoy-ThinkPad-X240s>
 <2b7d74c6-898c-75b1-338f-142bd62860c9@arm.com>
 <20201103121304.GM6882@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201103121304.GM6882@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 12:13:04PM +0000, Dave Martin wrote:
> On Tue, Nov 03, 2020 at 10:13:49AM +0000, André Przywara wrote:
> > On 03/11/2020 06:40, Leo Yan wrote:
> > 
> > Hi Dave, Leo,
> > 
> > > On Mon, Nov 02, 2020 at 05:06:53PM +0000, Dave Martin wrote:
> > >> On Fri, Oct 30, 2020 at 02:57:09AM +0000, Leo Yan wrote:
> > >>> When outputs strings to the decoding buffer with function snprintf(),
> > >>> SPE decoder needs to detects if any error returns from snprintf() and if
> > >>> so needs to directly bail out.  If snprintf() returns success, it needs
> > >>> to update buffer pointer and reduce the buffer length so can continue to
> > >>> output the next string into the consequent memory space.
> > >>>
> > >>> This complex logics are spreading in the function arm_spe_pkt_desc() so
> > >>> there has many duplicate codes for handling error detecting, increment
> > >>> buffer pointer and decrement buffer size.
> > >>>
> > >>> To avoid the duplicate code, this patch introduces a new helper function
> > >>> arm_spe_pkt_snprintf() which is used to wrap up the complex logics, and
> > >>> it's used by the caller arm_spe_pkt_desc(); if printing buffer is called
> > >>> for multiple times in a flow, the error is a cumulative value and simply
> > >>> returns its final value.
> > >>>
> > >>> This patch also moves the variable 'blen' as the function's local
> > >>> variable, this allows to remove the unnecessary braces and improve the
> > >>> readability.
> > >>>
> > >>> Suggested-by: Dave Martin <Dave.Martin@arm.com>
> > >>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > >>
> > >> This looks like a good refacroting now, but as pointed out by Andre this
> > >> patch is now rather hard to review, since it combines the refactoring
> > >> with other changes.
> > >>
> > >> If reposting this series, it would be good if this could be split into a
> > >> first patch that introduces arm_spe_pkt_snprintf() and just updates each
> > >> snprintf() call site to use it, but without moving other code around or
> > >> optimising anything, followed by one or more patches that clean up and
> > >> simplify arm_spe_pkt_desc().
> > > 
> > > I will respin the patch set and follow this approach.
> > 
> > Well, I am afraid this is not easily possible.
> > 
> > Dave: this patch is basically following the pattern turning this:
> > ===============
> > 	if (condition) {
> > 		ret = snprintf(buf, buf_len, "foo");
> > 		buf += ret;
> > 		blen -= ret;
> > 	}
> > 	...
> > 	if (ret < 0)
> > 		return ret;
> > 	blen -= ret;
> > 	return buf_len - blen;
> > ===============
> > into this:
> > ---------------
> > 	if (condition)
> > 		arm_spe_pkt_snprintf(&err, &buf, &blen, "foo");
> > 	...
> > 	return err ?: (int)(buf_len - blen);
> > ---------------
> > 
> > And "diff" is getting really ahead of itself here and tries to be super
> > clever, which leads to this hard to read patch.
> > 
> > But I don't think there is anything we can really do here, this is
> > already the minimal version. Leo adds the optimisations only later on,
> > in other patches.

Thanks for explaination, Andre.

> OK, this is only nice-to-have, if feasible -- so I'd say Leo should not
> bother to split this patch up unless it is easy to do and actually does
> make the diff more intelligible!

Anyway, I will give a try, if it needs much time or it's difficult,
I will keep current form.

> > 
> > Cheers,
> > Andre
> > 
> > 
> > > 
> > >> If the series is otherwise mature though, then this rework may be
> > >> overkill.
> > >>
> > >>> ---
> > >>>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 267 ++++++++----------
> > >>>  1 file changed, 117 insertions(+), 150 deletions(-)
> > >>>
> > >>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > >>> index 04fd7fd7c15f..1ecaf9805b79 100644
> > >>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > >>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > >>> @@ -9,6 +9,7 @@
> > >>>  #include <endian.h>
> > >>>  #include <byteswap.h>
> > >>>  #include <linux/bitops.h>
> > >>> +#include <stdarg.h>
> > >>>  
> > >>>  #include "arm-spe-pkt-decoder.h"
> > >>>  
> > >>> @@ -258,192 +259,158 @@ int arm_spe_get_packet(const unsigned char *buf, size_t len,
> > >>>  	return ret;
> > >>>  }
> > >>>  
> > >>> +static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
> > >>> +				const char *fmt, ...)
> > >>> +{
> > >>> +	va_list ap;
> > >>> +	int ret;
> > >>> +
> > >>> +	/* Bail out if any error occurred */
> > >>> +	if (err && *err)
> > >>> +		return *err;
> > >>> +
> > >>> +	va_start(ap, fmt);
> > >>> +	ret = vsnprintf(*buf_p, *blen, fmt, ap);
> > >>> +	va_end(ap);
> > >>> +
> > >>> +	if (ret < 0) {
> > >>> +		if (err && !*err)
> > >>> +			*err = ret;
> > >>
> > >> What happens on buffer overrun (i.e., ret >= *blen)?
> > >>
> > >> It looks to me like we'll advance buf_p too far, blen will wrap around,
> > >> and the string at *buf_p won't be null terminated.  Because the return
> > >> value is still >= 0, this condition will be returned up the stack as
> > >> "success".
> > > 
> > > Thanks for pointint out this.  I never note for the potential issue
> > > caused by returned value (ret >= *blen);  checked again for the
> > > manual, it says:
> > > 
> > > "The functions snprintf() and vsnprintf() do not write more than size
> > > bytes (including the terminating null byte ('\0')).  If the output was
> > > truncated due to this limit, then the return value is the number of
> > > characters (excluding  the  terminating  null  byte) which would have
> > > been written to the final string if enough space had been available.
> > > Thus, a return value of size or more means that the output was
> > > truncated."
> > > 
> > >> Perhaps this can never happen given the actual buffer sizes and strings
> > >> being printed, but it feels a bit unsafe.
> > >>
> > >>
> > >> It may be better to clamp the adjustments to *buf_p and *blen to
> > >> *blen - 1 in this case, and explicitly set (*buf_p)[*blen - 1] to '\0'.
> > >> We _may_ want indicate failure in the return from arm_spe_pkt_desc() in
> > >> this situation, but I don't know enough about how this code is called to
> > >> enable me to judge that.
> > > 
> > > The caller arm_spe_dump() will print out the string if the return
> > > value > 0 [1]; so I think it can simply return the string length which
> > > has been written to the buffer (with the clamped value).  The function
> > > can be refined as below:
> > > 
> > > static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
> > > 				const char *fmt, ...)
> > > {
> > > 	va_list ap;
> > > 	int ret;
> > > 
> > > 	/* Bail out if any error occurred */
> > > 	if (err && *err)
> > > 		return *err;
> > > 
> > > 	va_start(ap, fmt);
> > > 	ret = vsnprintf(*buf_p, *blen - 1, fmt, ap);
> 
> I think this should still be *blen.  Passing *blen - 1 here will limit
> the number of chars of generated text (excluding the '\0') to *blen - 2,
> which does not seem to be what is intended.

Agree, will use *blen.

> > > 	va_end(ap);
> > > 
> > > 	if (ret < 0) {
> > > 		if (err && !*err)
> > > 			*err = ret;
> > > 	} else {
> > > 
> > >                 /*
> > >                  * A return value of (*blen - 1) or more means that the
> > >                  * output was truncated and the buffer is overrun.
> > >                  */
> > >                 if (ret >= (*blen - 1)) {
> > >                         (*buf_p)[*blen - 1] = '\0';
> > > 
> > >                         /*
> > >                          * Set *err to -1 to avoid overflow if tries to
> > >                          * fill this buffer sequentially.
> > >                          */
> > > 		        if (err && !*err)
> > > 		        	*err = -1;
> 
> Makes sense, though the important thing here is to make sure that the
> caller knows the output was truncated.  

For explicitly indicate the output was truncated, here can set
"*err = ret".

> > > 
> > >                         /* Clamp the size of characters printed */
> > >                         ret = min(ret, *blen);
> 
> I'm not sure it matters, but it seems more logical for this to be
> *blen - 1.  Otherwise, the return value counts the '\0' that we just
> added as one of the chars "printed".  That seems a bit odd.
> 
> Alternatively, if nobody cares about the actual number returned, it may
> make sense to stick to snprintf() semantics -- i.e., just return the
> value that snprintf returned.

Good point.  If connect with the below sentence "*blen -= ret", it
uses "ret" to decrease the string size which has been outputted to the
buffer, this is why here clamp the "ret" value.

For stciking the return value to snprintf() semantics and use more
explicit way to handle the case for "ret >= (*blen - 1)", the function
can be refined as:

static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
				const char *fmt, ...)
{
	va_list ap;
	int ret;

	/* Bail out if any error occurred */
	if (err && *err)
		return *err;

	va_start(ap, fmt);
	ret = vsnprintf(*buf_p, *blen, fmt, ap);
	va_end(ap);

	if (ret < 0) {
		if (err && !*err)
			*err = ret;

	/*
	 * A return value of (*blen - 1) or more means that the
	 * output was truncated and the buffer is overrun.
	 */
	} else if (ret >= (*blen - 1)) {
		(*buf_p)[*blen - 1] = '\0';

		/*
		 * Set *err to -1 to avoid overflow if tries to
		 * fill this buffer sequentially.
		 */
		if (err && !*err)
			*err = ret;

		*buf_p += (*blen - 1);
		*blen -= (*blen - 1);
	} else {
		*buf_p += ret;
		*blen -= ret;
	}

	return ret;
}

> > >                 }
> > > 
> > > 		*buf_p += ret;
> > > 		*blen -= ret;
> > > 	}
> > > 
> > > 	return ret;
> > > }
> > > 
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/arm-spe.c#n116
> > > 
> > >> (Note, this issue is not introduced by this patch, but this refactoring
> > >> makes it easier to address it in a single place -- so it may now be
> > >> worth doing so.)
> > > 
> > > Agree.
> > > 
> > >>> +	} else {
> > >>> +		*buf_p += ret;
> > >>> +		*blen -= ret;
> > >>> +	}
> > >>> +
> > >>> +	return ret;
> > >>> +}
> > >>> +
> > >>>  int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> > >>>  		     size_t buf_len)
> > >>>  {
> > >>> -	int ret, ns, el, idx = packet->index;
> > >>> +	int ns, el, idx = packet->index;
> > >>>  	unsigned long long payload = packet->payload;
> > >>>  	const char *name = arm_spe_pkt_name(packet->type);
> > >>> +	size_t blen = buf_len;
> > >>> +	int err = 0;
> > >>>  
> > >>>  	switch (packet->type) {
> > >>>  	case ARM_SPE_BAD:
> > >>>  	case ARM_SPE_PAD:
> > >>>  	case ARM_SPE_END:
> > >>> -		return snprintf(buf, buf_len, "%s", name);
> > >>> -	case ARM_SPE_EVENTS: {
> > >>> -		size_t blen = buf_len;
> > >>> -
> > >>> -		ret = 0;
> > >>> -		ret = snprintf(buf, buf_len, "EV");
> > >>> -		buf += ret;
> > >>> -		blen -= ret;
> > >>> -		if (payload & 0x1) {
> > >>> -			ret = snprintf(buf, buf_len, " EXCEPTION-GEN");
> > >>> -			buf += ret;
> > >>> -			blen -= ret;
> > >>> -		}
> > >>> -		if (payload & 0x2) {
> > >>> -			ret = snprintf(buf, buf_len, " RETIRED");
> > >>> -			buf += ret;
> > >>> -			blen -= ret;
> > >>> -		}
> > >>> -		if (payload & 0x4) {
> > >>> -			ret = snprintf(buf, buf_len, " L1D-ACCESS");
> > >>> -			buf += ret;
> > >>> -			blen -= ret;
> > >>> -		}
> > >>> -		if (payload & 0x8) {
> > >>> -			ret = snprintf(buf, buf_len, " L1D-REFILL");
> > >>> -			buf += ret;
> > >>> -			blen -= ret;
> > >>> -		}
> > >>> -		if (payload & 0x10) {
> > >>> -			ret = snprintf(buf, buf_len, " TLB-ACCESS");
> > >>> -			buf += ret;
> > >>> -			blen -= ret;
> > >>> -		}
> > >>> -		if (payload & 0x20) {
> > >>> -			ret = snprintf(buf, buf_len, " TLB-REFILL");
> > >>> -			buf += ret;
> > >>> -			blen -= ret;
> > >>> -		}
> > >>> -		if (payload & 0x40) {
> > >>> -			ret = snprintf(buf, buf_len, " NOT-TAKEN");
> > >>> -			buf += ret;
> > >>> -			blen -= ret;
> > >>> -		}
> > >>> -		if (payload & 0x80) {
> > >>> -			ret = snprintf(buf, buf_len, " MISPRED");
> > >>> -			buf += ret;
> > >>> -			blen -= ret;
> > >>> -		}
> > >>> +		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s", name);
> > >>> +	case ARM_SPE_EVENTS:
> > >>> +		arm_spe_pkt_snprintf(&err, &buf, &blen, "EV");
> > >>> +
> > >>> +		if (payload & 0x1)
> > >>> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCEPTION-GEN");
> > >>> +		if (payload & 0x2)
> > >>> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " RETIRED");
> > >>> +		if (payload & 0x4)
> > >>> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-ACCESS");
> > >>> +		if (payload & 0x8)
> > >>> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-REFILL");
> > >>> +		if (payload & 0x10)
> > >>> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-ACCESS");
> > >>> +		if (payload & 0x20)
> > >>> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-REFILL");
> > >>> +		if (payload & 0x40)
> > >>> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " NOT-TAKEN");
> > >>> +		if (payload & 0x80)
> > >>> +			arm_spe_pkt_snprintf(&err, &buf, &blen, " MISPRED");
> > >>>  		if (idx > 1) {
> > >>> -			if (payload & 0x100) {
> > >>> -				ret = snprintf(buf, buf_len, " LLC-ACCESS");
> > >>> -				buf += ret;
> > >>> -				blen -= ret;
> > >>> -			}
> > >>> -			if (payload & 0x200) {
> > >>> -				ret = snprintf(buf, buf_len, " LLC-REFILL");
> > >>> -				buf += ret;
> > >>> -				blen -= ret;
> > >>> -			}
> > >>> -			if (payload & 0x400) {
> > >>> -				ret = snprintf(buf, buf_len, " REMOTE-ACCESS");
> > >>> -				buf += ret;
> > >>> -				blen -= ret;
> > >>> -			}
> > >>> +			if (payload & 0x100)
> > >>> +				arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-ACCESS");
> > >>> +			if (payload & 0x200)
> > >>> +				arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-REFILL");
> > >>> +			if (payload & 0x400)
> > >>> +				arm_spe_pkt_snprintf(&err, &buf, &blen, " REMOTE-ACCESS");
> > >>>  		}
> > >>> -		if (ret < 0)
> > >>> -			return ret;
> > >>> -		blen -= ret;
> > >>> -		return buf_len - blen;
> > >>
> > >> It looks like we now fall off the bottom of the switch() here.  It's
> > >> preferable to add a break, both to document the intended code flow, and
> > >> to avoid accidents if another case is added later.
> > > 
> > > Will do this.
> > > 
> > >>> -	}
> > >>> +		return err ?: (int)(buf_len - blen);
> > >>
> > >> Nit: unexplained type cast.  Does the result definitely fit into an int?
> > >> If not, why doesn't it matter?
> > > 
> > > The case is to dismiss the compiler warning.
> > > 
> > > GCC doesn't compliant for the code:
> > > 
> > >   return buf_len - blen;
> > >   
> > > But GCC compliants type mismatch after change to code:
> > > 
> > >   return err ?: buf_len - blen;
> 
> So, does buf_len - blen fit in an int?
> 
> > > 
> > >> Also:
> > >>
> > >> If the actual return value is important for the caller to determine the
> > >> number of bytes appended, then it would be better to compute it in one
> > >> place.  Otherwise, it would be better to squash all success returns to 0,
> > >> rather than spend effort computing a value that may be misleading or
> > >> wrong anyway.
> > >>
> > >> In its current form, it's tricky to see whether this patch derives the
> > >> return value consistently for all cases.  In particular, if some code
> > >> patch does one or more arm_spe_pkt_snprintf(), followed by a
> > >> return arm_spe_pkt_snprintf(); then the return value (which only takes
> > >> the last arm_spe_pkt_desc() into account) would be wrong.  It would be
> > >> preferable if the return value for the success case were always
> > >> computed from buf_len and blen, to avoid this risk.  (I'm not saying
> > >> this bug exists, just that it's hard to see from the patch that it
> > >> doesn't exist.)
> > > 
> > > I think I can go back to return value "buf_len - blen" and don't
> > > check "err" anymore.
> 
> Probably, now that blen is adjusted in one place -- at least for success
> returns.
> 
> We still need to indicate failure though, so we may need to check err
> in some places.
> 
> One option is to have snprintf() semantics for the return value of this
> whole function too, so that the caller can detect truncation (if wanted)
> by comparing the return value against buf_len.  We'd need to make sure
> all callers are updated appropriately if going down that route.
> 
> > > 
> > > If the string buffer is truncated due to size limitation, we can still
> > > return "buf_len - blen" so can allow caller to dump string as
> > > possible.
> 
> This really depends on what the caller is trying to do.  In the case of
> truncation, will we send unparseable junk to userspace?  Will userspace
> be able to detect that this has happened and recover gracefully?

I understand your point: if the string buffer is truncated, it's
pointless to output the string with incomplete info.

> > > If arm_spe_pkt_snprintf() returns -1 at the first call, "buf_len" is
> > > equal to "blen", thus return value of "buf_len - blen" will be zero.
> > > For this case, the caller will get to know there have no valid string
> > > and will skip to print anything.
> > > 
> > > Does this make sense?
> 
> Probably, though it's easy for callers to forget about such conventions
> and assume that 0 means "success".

Okay, let me digist your suggestion :)  So the code can be refined with
below fashion:

    /*
     * arm_spe_pkt_snprintf()'s return value has the same
     * semantics with snprintf();
     *
     * *err = 0: no errors;
     * *err != 0: error occurs.
     */
    int arm_spe_pkt_snprintf(int *err, ...)
    {
        va_list ap;
        int ret;

        /* Bail out if any error occurred */
        if (err && *err)
            return *err;

        va_start(ap, fmt);
        ret = vsnprintf(*buf_p, *blen, fmt, ap);
        va_end(ap);

        if (any failure)  {
            if (err && *err)
                *err = ret;
	}

        ...

	return ret;
    }

    int arm_spe_pkt_desc()
    {
	int err = 0;

        switch (packet->type) {
	case ARM_SPE_END:
            arm_spe_pkt_snprintf(&err, ...);
	    break;
	case ARM_SPE_EVENTS:
            arm_spe_pkt_snprintf(&err, ...);
	    break;
	...
	default:
	    err = -1;
	    break;
	}

	return err;
    }

    void arm_spe_dump()
    {
        int ret;

	...

    	ret = arm_spe_pkt_desc(&packet, desc,
                               ARM_SPE_PKT_DESC_MAX););
	if (!ret)
            color_fprintf(stdout, color, " %s\n", desc);

        ...
    }

Thanks a lot for suggestions,
Leo

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA2029B3EE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 15:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782323AbgJ0O5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 10:57:02 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54173 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1773003AbgJ0Out (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:50:49 -0400
Received: by mail-pj1-f65.google.com with SMTP id g16so902754pjv.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 07:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CyvR9JneEklrUsvYYZJqnYsca6hrhf1CI0ZF67/9Dlo=;
        b=ODK8J7R45eAFb1wo0m9p/iei54jKkur1UwyDpg2qr3VcwEoBgP8e/lEF7nTIu7Z6gx
         kU4eeQ0uhz1yilHJZRbCbYU6I+xC9VS0vtuGWXxf9TKsALusuo4yXgaZ+f+12gYClVOW
         cZ1wakHI7EJYbuQg1K6jwJ0mkvFxmZb2kfeFpM2M9Q4++MH62KCNHM2LGM53sLKK6bCf
         mfl6kHBaxnKggp+PoKRfll/nwC/gN93upIQPuH5/45qYTOAUxhNAK2vFGTeUZe8QEiBd
         5PQGVvA+ZmKmoUGvRFob4MS2bL3uIDi6072LiRvh1TJM1Ci+2G9P7YDs3C7J9K4yGgiO
         SHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CyvR9JneEklrUsvYYZJqnYsca6hrhf1CI0ZF67/9Dlo=;
        b=QOikK7dr+IzL8Y+61qg1uXocqLWbFU+Fsmy9IXg4Fl6U966uOcL/MhK67uL0mYPxjk
         50num7a6vx3lJtT7Al93cR4B3h4kp8NSES2mh0Vcwsla0JOdVpqqJ+oDmuHza9ELhAax
         Kc7JTeVk7eBO49wODZ+U2cO+DqTd4C55pk5N6UtJc5I/8Njey1kxZ3dbYXyWuJU2PFNM
         5S/sCFrVNACIOv3MUBndUc0tNY+msdOzq9cqgtrIsTDAHWQGefmVcfXO16QVX6HSKJw6
         4JbrV7+6GfXksa1JEwdvXciO3Ar5aKWnPL3Doh0WljVtxqz4UF8HA4rvkK3BDmJ5getk
         PxCQ==
X-Gm-Message-State: AOAM533dxROnorRhHK+Qm2oFfb1DeupElzvXX999kIRZcXbSNvs9CxOr
        EUxSGuIcMZ5teoLoSRKsZHX87g==
X-Google-Smtp-Source: ABdhPJy8/gip0AbZng/zxh18rpfrE2dY6eNyLUdUpRUvg1sYMaqC7fFI3Z4YKqdktTHTEciKHWfF0w==
X-Received: by 2002:a17:90a:8906:: with SMTP id u6mr2424984pjn.35.1603810247768;
        Tue, 27 Oct 2020 07:50:47 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id l82sm2723339pfd.102.2020.10.27.07.50.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Oct 2020 07:50:47 -0700 (PDT)
Date:   Tue, 27 Oct 2020 22:50:38 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andre Przywara <Andre.Przywara@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <James.Clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 06/21] perf arm-spe: Refactor printing string to buffer
Message-ID: <20201027145038.GE32667@leoy-ThinkPad-X240s>
References: <20201027030917.15404-1-leo.yan@linaro.org>
 <20201027030917.15404-7-leo.yan@linaro.org>
 <20201027143153.GF27285@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027143153.GF27285@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Tue, Oct 27, 2020 at 02:31:54PM +0000, Dave Martin wrote:
> On Tue, Oct 27, 2020 at 03:09:02AM +0000, Leo Yan wrote:
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
> > the caller arm_spe_pkt_desc() will call it and simply check the returns
> > value.
> > 
> > This patch also moves the variable 'blen' as the function's local
> > variable, this allows to remove the unnecessary braces and improve the
> > readability.
> > 
> > Suggested-by: Dave Martin <Dave.Martin@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 247 ++++++++++--------
> >  1 file changed, 135 insertions(+), 112 deletions(-)
> > 
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > index 04fd7fd7c15f..b400636e6da2 100644
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
> > @@ -258,192 +259,214 @@ int arm_spe_get_packet(const unsigned char *buf, size_t len,
> >  	return ret;
> >  }
> >  
> > +static int arm_spe_pkt_snprintf(char **buf_p, size_t *blen,
> > +				const char *fmt, ...)
> > +{
> > +	va_list ap;
> > +	int ret;
> > +
> > +	va_start(ap, fmt);
> > +	ret = vsnprintf(*buf_p, *blen, fmt, ap);
> > +	va_end(ap);
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*buf_p += ret;
> > +	*blen -= ret;
> > +	return ret;
> > +}
> > +
> 
> This approach seems OK, though I wonder whether all the
> "if (ret < 0) return;" logic is really needed.
> 
> In case of failure, it probably doesn't matter what ends up in buf.
> If not, we could just implement a cumulative error:
> 
> static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
> {
> 
> 	/* ... */
> 
> 	if (ret < 0) {
> 		if (err && !*err)
> 			*err = ret;
> 	} else {
> 		*buf_p += ret;
> 		*blen -= ret;
> 	}
> 
> 	return err ? *err : ret;
> }
> 
> and just return the final value of err.
> 
> 
> 
> >  int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> >  		     size_t buf_len)
> >  {
> >  	int ret, ns, el, idx = packet->index;
> >  	unsigned long long payload = packet->payload;
> >  	const char *name = arm_spe_pkt_name(packet->type);
> > +	size_t blen = buf_len;
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
> > +		return arm_spe_pkt_snprintf(&buf, &blen, "%s", name);
> > +	case ARM_SPE_EVENTS:
> > +		ret = arm_spe_pkt_snprintf(&buf, &blen, "EV");
> > +		if (ret < 0)
> > +			return ret;
> > +
> 
> ...
> 
> Then this becomes
> 
> 	case ARM_SPE_END:
> 		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s", name);
> 	case ARM_SPE_EVENTS:
> 		arm_spe_pkt_snprintf(&ret, &buf, &blen, "%s", name);
> 
> 		if (payload & 0x1)
> 			arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCEPTION-GEN");
> 		if (payload & 0x2)
> 			arm_spe_pkt_snprintf(&err, &buf, &blen, " RETIRED");
> 
> 	/* ... */
> 
> 
> This might be over-engineering, but it does help to condense the code.

I agree this approach is more neat; will follow it to refine code.

Thanks a lot for detailed explaination.

Leo

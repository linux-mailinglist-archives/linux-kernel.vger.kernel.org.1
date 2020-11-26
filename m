Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894972C5724
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 15:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391114AbgKZObk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 09:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391090AbgKZObk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 09:31:40 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C4BC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 06:31:40 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id w16so1871592pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 06:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+ubtj8jLZa0MRBDrFjBps4/mkC6E9QeHa4hph29+zRI=;
        b=KFy53PN8f75TZ2JTPs4lQuzQSbU3KeDtrqcv/DjMx4Sm5OH980mFrJ+GlwoNIaqFlW
         OHX2nbSs8lt/fbbrYXvbcZVA3QV7ffQkfmqwIuoyeVtF9JGN67+0DTycFOsJFbMB/2k/
         fsNn5BFOj8uSXIt8mQvT4ntJOq9iRrZdszvC8fSknXjEdRJWJU6FQetE9n+IINWBQTL8
         mvFEcsnT8a6xMMt7BmAINf542zAzRvKF9s5E+2TToaEY5thQ6HmPeOmRfDtW+pb8Mw0F
         vP3LlWlkwseaZ1/zNmd87pHU+qpCgygtyoM3mQSfzfmA+ciffV5d03DQ/lVG5M4jMY8V
         xsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+ubtj8jLZa0MRBDrFjBps4/mkC6E9QeHa4hph29+zRI=;
        b=AR1vs5SJOkxtVcRzuiOfKwL5Xsiw3wkAmy/+Hj8PDDlBkxQ6BWzIOTi0ZchJpdxzfK
         cfKqtPrswfIzLAxszas8EZQQNez+mcWu0p8JQd2xlR069MZuhqolKR84hchW1TTmSnrL
         uHXLVspP+m3TxKC5WHNJeppDz9ats/5xFp2khURF1xrpy27H8+qsPeqiQSuq5Yt6PrZ2
         pM6fyiOySY7gihdJsGiJiMlrJ35JOdd3u+lkxiZRscDKpAR2a9W0ASGHyp4cHKDkcgUc
         xuJfPlklvOzWlZP0cAnd1Y8JLOUDFRqilbqLMmaDeIHRUEgHK/KjftAYB64htdzYTLwy
         JuWg==
X-Gm-Message-State: AOAM530dcNX0sXeAxFx1azq1qf5bOyUlVcBlji0Sl497ya4OHQ+MHJaM
        P++0S6p0a+zDuyIWSUP/6y4zmw==
X-Google-Smtp-Source: ABdhPJwaq9okUUCJ7FAFdsCBquKjMAadglZa3TEo1eC7grrkTiSW1FMGteOtVNLkqjjyuFAmY/rDZw==
X-Received: by 2002:a63:4925:: with SMTP id w37mr2867451pga.64.1606401099707;
        Thu, 26 Nov 2020 06:31:39 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.127.239.100])
        by smtp.gmail.com with ESMTPSA id x8sm6630415pjr.52.2020.11.26.06.31.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Nov 2020 06:31:39 -0800 (PST)
Date:   Thu, 26 Nov 2020 22:31:33 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 01/16] perf arm-spe: Refactor printing string to buffer
Message-ID: <20201126143133.GB27722@leoy-ThinkPad-X240s>
References: <20201119152441.6972-1-leo.yan@linaro.org>
 <20201119152441.6972-2-leo.yan@linaro.org>
 <20201126121158.GB53384@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126121158.GB53384@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 09:11:58AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Nov 19, 2020 at 11:24:26PM +0800, Leo Yan escreveu:
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
> > arm_spe_pkt_out_string() which is used to wrap up the complex logics,
> > and it's used by the caller arm_spe_pkt_desc().  This patch moves the
> > variable 'blen' as the function's local variable so allows to remove
> > the unnecessary braces and improve the readability.
> > 
> > This patch simplifies the return value for arm_spe_pkt_desc(): '0' means
> > success and other values mean an error has occurred.  To realize this,
> > it relies on arm_spe_pkt_out_string()'s parameter 'err', the 'err' is a
> > cumulative value, returns its final value if printing buffer is called
> > for one time or multiple times.  Finally, the error is handled in a
> > central place, rather than directly bailing out in switch-cases, it
> > returns error at the end of arm_spe_pkt_desc().
> > 
> > This patch changes the caller arm_spe_dump() to respect the updated
> > return value semantics of arm_spe_pkt_desc().
> > 
> > Suggested-by: Dave Martin <Dave.Martin@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> > Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 302 +++++++++---------
> >  tools/perf/util/arm-spe.c                     |   2 +-
> >  2 files changed, 151 insertions(+), 153 deletions(-)
> > 
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > index 671a4763fb47..fbededc1bcd4 100644
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
> > @@ -258,192 +259,189 @@ int arm_spe_get_packet(const unsigned char *buf, size_t len,
> >  	return ret;
> >  }
> >  
> > +static int arm_spe_pkt_out_string(int *err, char **buf_p, size_t *blen,
> > +				  const char *fmt, ...)
> > +{
> > +	va_list ap;
> > +	int ret;
> 
> 
> Ok, from a quick look this continues confusing, but at least its not
> named scnprintf() and then people won't expect the usual semantics.

Shame for the confusion :(

> Applying.

Thanks, Arnaldo.

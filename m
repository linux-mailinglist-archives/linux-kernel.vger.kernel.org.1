Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC0C2AFE30
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgKLFfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgKLDCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 22:02:43 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22384C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 19:02:42 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id c66so3177420pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 19:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=u1Z2NSc7OdBliF+CAohHDIZcKs+1qDehj7Sa56B/doM=;
        b=GrVY67luTLcbY3ajRGiOupAYT4DAGVqI+HmE2CJ3z6l2/BLCLK2zx2aMGiHeVE3ZGI
         C0GreGX01xXTUgSCAfr/egpBmyEWdr8fhAVq4NZ4StcnDKxQKOdO4vikMnlmKhwk0KED
         ZoalMb88kkEUfPnbnFBFS9Brk/v7bv1EucHf1tOYkeHdsZRtbQDKOVSt55Gos0ZFdclI
         mpcVoeSMs9nRqv7CQcnqze3sMpAqu1A2pdtAi3Mse5UiIkusvjNi6QoXGoogbpdKvUDI
         zQFZh6GhjwXsLqN0HeXNwtFQOwbszVt3qdrjy0awGQ0I68lUpmj3dNcIwJzM9G2EtBbn
         4yJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=u1Z2NSc7OdBliF+CAohHDIZcKs+1qDehj7Sa56B/doM=;
        b=YG5ajneXYSXx1MjXLOIko40DxrnLLfifR6WOS5BXWM4K0BMETdCzNUrmw888RmTvWR
         t/BiPImuO1N8Ng7OFaRR+AlZHtcijsDGZWmmzdgu4BDcDvsRkDvo+S3lHUvXUMhJSrj7
         Me4kWWtUkXJODy/hb2Rv0dmKCO5C+stYYZ4Eq4v3R8iIradyfLwxjmdBDXM5EAbDrUxM
         marSROcL846hTlWzJ+nF/Cp5ka8OP/g04A+HqRx4CNMUx6CNUa57rQ0tVByMrthZdtk+
         F5ai8UFRlSuXuRKNmCAVzGuiXuwRKMKv3HqGFFFPn5s3DlHS8e5JRoe7PbsaVhP8Kudq
         JJeQ==
X-Gm-Message-State: AOAM5306N4LBjkTipL8zRPLgyr+LXCkti6Q7kQW6if6M4LfWCH5o8ZdY
        Hl+I8+LOZfoI7lhfihJc0yTquA==
X-Google-Smtp-Source: ABdhPJz74YOaEAuNv8XIKvpgOdBT5TaWqYLDqWohCdfP16gn1Ep0Lhj9hnXmc93P3RymrugY666Ghw==
X-Received: by 2002:a17:90a:1b84:: with SMTP id w4mr7083341pjc.65.1605150161523;
        Wed, 11 Nov 2020 19:02:41 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.127.239.100])
        by smtp.gmail.com with ESMTPSA id h13sm4251423pjj.30.2020.11.11.19.02.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Nov 2020 19:02:40 -0800 (PST)
Date:   Thu, 12 Nov 2020 11:02:35 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Dave Martin' <Dave.Martin@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andre Przywara <Andre.Przywara@arm.com>,
        James Clark <James.Clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Al Grant <Al.Grant@arm.com>, Wei Li <liwei391@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 06/22] perf arm-spe: Refactor printing string to buffer
Message-ID: <20201112030235.GC5852@leoy-ThinkPad-X240s>
References: <20201111071149.815-1-leo.yan@linaro.org>
 <20201111071149.815-7-leo.yan@linaro.org>
 <20201111153555.GG355344@kernel.org>
 <a1ca3412-3815-e2a8-0334-f3059802df6a@arm.com>
 <20201111173922.GA380127@kernel.org>
 <20201111175827.GR6882@arm.com>
 <3dc873b262bd4659a2c6ae935d69c8fc@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3dc873b262bd4659a2c6ae935d69c8fc@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Wed, Nov 11, 2020 at 11:03:47PM +0000, David Laight wrote:
> From: Dave Martin
> > Sent: 11 November 2020 17:58
> > 
> > On Wed, Nov 11, 2020 at 05:39:22PM +0000, Arnaldo Carvalho de Melo wrote:
> > > Em Wed, Nov 11, 2020 at 03:45:23PM +0000, Andr� Przywara escreveu:
> > > > On 11/11/2020 15:35, Arnaldo Carvalho de Melo wrote:
> > > >
> > > > Hi Arnaldo,
> > > >
> > > > thanks for taking a look!
> > > >
> > > > > Em Wed, Nov 11, 2020 at 03:11:33PM +0800, Leo Yan escreveu:
> > > > >> When outputs strings to the decoding buffer with function snprintf(),
> > > > >> SPE decoder needs to detects if any error returns from snprintf() and if
> > > > >> so needs to directly bail out.  If snprintf() returns success, it needs
> > > > >> to update buffer pointer and reduce the buffer length so can continue to
> > > > >> output the next string into the consequent memory space.
> > > > >>
> > > > >> This complex logics are spreading in the function arm_spe_pkt_desc() so
> > > > >> there has many duplicate codes for handling error detecting, increment
> > > > >> buffer pointer and decrement buffer size.
> > > > >>
> > > > >> To avoid the duplicate code, this patch introduces a new helper function
> > > > >> arm_spe_pkt_snprintf() which is used to wrap up the complex logics, and
> > > > >> it's used by the caller arm_spe_pkt_desc().
> > > > >>
> > > > >> This patch also moves the variable 'blen' as the function's local
> > > > >> variable, this allows to remove the unnecessary braces and improve the
> > > > >> readability.
> > > > >>
> > > > >> Suggested-by: Dave Martin <Dave.Martin@arm.com>
> > > > >> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > > >> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> > > > >> ---
> > > > >>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 260 +++++++++---------
> > > > >>  1 file changed, 126 insertions(+), 134 deletions(-)
> > > > >>
> > > > >> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-
> > decoder/arm-spe-pkt-decoder.c
> > > > >> index 04fd7fd7c15f..1970686f7020 100644
> > > > >> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > > > >> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > > > >> @@ -9,6 +9,7 @@
> > > > >>  #include <endian.h>
> > > > >>  #include <byteswap.h>
> > > > >>  #include <linux/bitops.h>
> > > > >> +#include <stdarg.h>
> > > > >>
> > > > >>  #include "arm-spe-pkt-decoder.h"
> > > > >>
> > > > >> @@ -258,192 +259,183 @@ int arm_spe_get_packet(const unsigned char *buf, size_t len,
> > > > >>  	return ret;
> > > > >>  }
> > > > >>
> > > > >> +static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
> > > > >> +				const char *fmt, ...)
> > > > >> +{
> > > > >> +	va_list ap;
> > > > >> +	int ret;
> > > > >> +
> > > > >> +	/* Bail out if any error occurred */
> > > > >> +	if (err && *err)
> > > > >> +		return *err;
> > > > >> +
> > > > >> +	va_start(ap, fmt);
> > > > >> +	ret = vsnprintf(*buf_p, *blen, fmt, ap);
> > > > >> +	va_end(ap);
> > > > >> +
> > > > >> +	if (ret < 0) {
> > > > >> +		if (err && !*err)
> > > > >> +			*err = ret;
> > > > >> +
> > > > >> +	/*
> > > > >> +	 * A return value of (*blen - 1) or more means that the
> > > > >> +	 * output was truncated and the buffer is overrun.
> > > > >> +	 */
> > > > >> +	} else if (ret >= ((int)*blen - 1)) {
> > > > >> +		(*buf_p)[*blen - 1] = '\0';
> > > > >> +
> > > > >> +		/*
> > > > >> +		 * Set *err to 'ret' to avoid overflow if tries to
> > > > >> +		 * fill this buffer sequentially.
> > > > >> +		 */
> > > > >> +		if (err && !*err)
> > > > >> +			*err = ret;
> > > > >> +	} else {
> > > > >> +		*buf_p += ret;
> > > > >> +		*blen -= ret;
> > > > >> +	}
> > > > >> +
> > > > >> +	return ret;
> > > > >> +}
> > > > >> +
> 
> I'm not entirely sure that snprintf() can actually return a negative value.
> 
> Every implementation (except the microsoft one) also always writes a '\0'
> even when the buffer is too short.
> 
> A simple wrapper that lets you append output and detect overflow is:
> 	ret = vsnprintf(buf, len, ...);
> 	if (ret < 0)
> 		/* just in case */
> 		return 0;
> 	return ret > len ? len : ret;
> 
> So on overflow the sum of the lengths is equal to the buffer size
> (ie includes the terminating '\0'.

We had some discussion for the return value in the old patch set, since
we want to keep the same scenmatics for the return value with
vsnprintf(), so the function arm_spe_pkt_snprintf() directly delivers
the return value from vsnprintf().

And if look at the patch 07/22, you could find the 'ret' value is not
really used at the end; the parameter 'err' is used as an accumulative
error value and it will be returned to up stack (0 means success and
non-zero means any failure).

For these two reasons, I'd like to keep as it is rather than converting
to other values.

Thanks for suggestion!
Leo

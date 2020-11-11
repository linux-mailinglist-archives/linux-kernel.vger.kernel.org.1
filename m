Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923012AFC52
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgKLBeh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Nov 2020 20:34:37 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:31904 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727706AbgKKXDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 18:03:55 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-89-Hjz3Y7RkMHS23JXaSvpHwQ-1; Wed, 11 Nov 2020 23:03:48 +0000
X-MC-Unique: Hjz3Y7RkMHS23JXaSvpHwQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 11 Nov 2020 23:03:47 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 11 Nov 2020 23:03:47 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dave Martin' <Dave.Martin@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Andre Przywara <Andre.Przywara@arm.com>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        James Clark <James.Clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>, Al Grant <Al.Grant@arm.com>,
        Wei Li <liwei391@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 06/22] perf arm-spe: Refactor printing string to buffer
Thread-Topic: [PATCH v8 06/22] perf arm-spe: Refactor printing string to
 buffer
Thread-Index: AQHWuFRInoKVOHB17kCDuu646O3VGqnDiy6g
Date:   Wed, 11 Nov 2020 23:03:47 +0000
Message-ID: <3dc873b262bd4659a2c6ae935d69c8fc@AcuMS.aculab.com>
References: <20201111071149.815-1-leo.yan@linaro.org>
 <20201111071149.815-7-leo.yan@linaro.org>
 <20201111153555.GG355344@kernel.org>
 <a1ca3412-3815-e2a8-0334-f3059802df6a@arm.com>
 <20201111173922.GA380127@kernel.org> <20201111175827.GR6882@arm.com>
In-Reply-To: <20201111175827.GR6882@arm.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Martin
> Sent: 11 November 2020 17:58
> 
> On Wed, Nov 11, 2020 at 05:39:22PM +0000, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Nov 11, 2020 at 03:45:23PM +0000, Andrï¿½ Przywara escreveu:
> > > On 11/11/2020 15:35, Arnaldo Carvalho de Melo wrote:
> > >
> > > Hi Arnaldo,
> > >
> > > thanks for taking a look!
> > >
> > > > Em Wed, Nov 11, 2020 at 03:11:33PM +0800, Leo Yan escreveu:
> > > >> When outputs strings to the decoding buffer with function snprintf(),
> > > >> SPE decoder needs to detects if any error returns from snprintf() and if
> > > >> so needs to directly bail out.  If snprintf() returns success, it needs
> > > >> to update buffer pointer and reduce the buffer length so can continue to
> > > >> output the next string into the consequent memory space.
> > > >>
> > > >> This complex logics are spreading in the function arm_spe_pkt_desc() so
> > > >> there has many duplicate codes for handling error detecting, increment
> > > >> buffer pointer and decrement buffer size.
> > > >>
> > > >> To avoid the duplicate code, this patch introduces a new helper function
> > > >> arm_spe_pkt_snprintf() which is used to wrap up the complex logics, and
> > > >> it's used by the caller arm_spe_pkt_desc().
> > > >>
> > > >> This patch also moves the variable 'blen' as the function's local
> > > >> variable, this allows to remove the unnecessary braces and improve the
> > > >> readability.
> > > >>
> > > >> Suggested-by: Dave Martin <Dave.Martin@arm.com>
> > > >> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > >> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> > > >> ---
> > > >>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 260 +++++++++---------
> > > >>  1 file changed, 126 insertions(+), 134 deletions(-)
> > > >>
> > > >> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-
> decoder/arm-spe-pkt-decoder.c
> > > >> index 04fd7fd7c15f..1970686f7020 100644
> > > >> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > > >> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > > >> @@ -9,6 +9,7 @@
> > > >>  #include <endian.h>
> > > >>  #include <byteswap.h>
> > > >>  #include <linux/bitops.h>
> > > >> +#include <stdarg.h>
> > > >>
> > > >>  #include "arm-spe-pkt-decoder.h"
> > > >>
> > > >> @@ -258,192 +259,183 @@ int arm_spe_get_packet(const unsigned char *buf, size_t len,
> > > >>  	return ret;
> > > >>  }
> > > >>
> > > >> +static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
> > > >> +				const char *fmt, ...)
> > > >> +{
> > > >> +	va_list ap;
> > > >> +	int ret;
> > > >> +
> > > >> +	/* Bail out if any error occurred */
> > > >> +	if (err && *err)
> > > >> +		return *err;
> > > >> +
> > > >> +	va_start(ap, fmt);
> > > >> +	ret = vsnprintf(*buf_p, *blen, fmt, ap);
> > > >> +	va_end(ap);
> > > >> +
> > > >> +	if (ret < 0) {
> > > >> +		if (err && !*err)
> > > >> +			*err = ret;
> > > >> +
> > > >> +	/*
> > > >> +	 * A return value of (*blen - 1) or more means that the
> > > >> +	 * output was truncated and the buffer is overrun.
> > > >> +	 */
> > > >> +	} else if (ret >= ((int)*blen - 1)) {
> > > >> +		(*buf_p)[*blen - 1] = '\0';
> > > >> +
> > > >> +		/*
> > > >> +		 * Set *err to 'ret' to avoid overflow if tries to
> > > >> +		 * fill this buffer sequentially.
> > > >> +		 */
> > > >> +		if (err && !*err)
> > > >> +			*err = ret;
> > > >> +	} else {
> > > >> +		*buf_p += ret;
> > > >> +		*blen -= ret;
> > > >> +	}
> > > >> +
> > > >> +	return ret;
> > > >> +}
> > > >> +

I'm not entirely sure that snprintf() can actually return a negative value.

Every implementation (except the microsoft one) also always writes a '\0'
even when the buffer is too short.

A simple wrapper that lets you append output and detect overflow is:
	ret = vsnprintf(buf, len, ...);
	if (ret < 0)
		/* just in case */
		return 0;
	return ret > len ? len : ret;

So on overflow the sum of the lengths is equal to the buffer size
(ie includes the terminating '\0'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


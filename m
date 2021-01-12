Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0912F2DC1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbhALLTH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Jan 2021 06:19:07 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:31307 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbhALLTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:19:04 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-266-OkYGjMEBNu-i6AdjcLHlbQ-1; Tue, 12 Jan 2021 11:17:24 +0000
X-MC-Unique: OkYGjMEBNu-i6AdjcLHlbQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 12 Jan 2021 11:17:18 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 12 Jan 2021 11:17:18 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jiri Olsa' <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        "Jin Yao" <yao.jin@linux.intel.com>
Subject: RE: [PATCH] perf test: Fix shadow stat test for non-bash shells
Thread-Topic: [PATCH] perf test: Fix shadow stat test for non-bash shells
Thread-Index: AQHW6MXUMDKswH4pgUyxCMgfD/u1O6oj1CNw
Date:   Tue, 12 Jan 2021 11:17:18 +0000
Message-ID: <c0d1ac9ce2bf43029c1c97bfcc9029c4@AcuMS.aculab.com>
References: <20210108074712.947223-1-namhyung@kernel.org>
 <20210112093016.GB1252618@krava>
In-Reply-To: <20210112093016.GB1252618@krava>
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

From: Jiri Olsa
> Sent: 12 January 2021 09:30
> 
> On Fri, Jan 08, 2021 at 04:47:12PM +0900, Namhyung Kim wrote:
> > It was using some bash-specific features and failed to parse when
> > running with a different shell like below:
...

You don't need a temporary file, one option is:

> > index 249dfe48cf6a..e2c7ac4ed91d 100755
> > --- a/tools/perf/tests/shell/stat+shadow_stat.sh
> > +++ b/tools/perf/tests/shell/stat+shadow_stat.sh
...
> >  	perf stat -a -A --no-big-num -e cycles,instructions sleep 1  2>&1 | \
> >  	grep ^CPU | \
> >  	while read cpu num evt hash ipc rest
> >  	do
...
> > +		if [ "$evt" = "cycles" ]; then
> > +			echo $cpu $num >> $results

			results="$results $cpu:$num"

> >  			continue
> >  		fi
> >
> >  		# skip if no cycles
> > -		local cyc=${results[$cpu]}
> > -		if [[ -z $cyc ]]; then
> > +		local cyc=$(grep $cpu $results | cut -d' ' -f2)

		cyc=${results##* $cpu:}
		cyc=$(cyc%% *}

> > +		if [ -z "$cyc" ]; then
> >  			continue
> >  		fi

I can't remember when 'local' was invented.
You may find shells that don't support it.
In any case, since this is a small standalone file I'd
remove them just in case.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


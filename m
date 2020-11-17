Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1812B6C60
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgKQRyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:54:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbgKQRyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:54:05 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5731B22202;
        Tue, 17 Nov 2020 17:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605635643;
        bh=rgF0U88Kwfu3xZ3v4Wq/M1IGNiDLELUJTFymISSr95o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DB8zeZmm1bnNGRVjlWBFtk50PmzYoh/PU+5LL0DxoqZp0CpL5Cix1SKYfp3gETPCR
         ywtcYY4wNIjWZwAhmMpZdv2Xl9gGKYxkhADP75Z53+vF7y5Oqc4j8xwTMmMjTUuPF2
         9a6HnzWad9UsdsQhIgFtbwxtUUn+ubzVQxTvoWuk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8623940E29; Tue, 17 Nov 2020 14:54:00 -0300 (-03)
Date:   Tue, 17 Nov 2020 14:54:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 23/24] perf buildid-list: Add support for mmap2's buildid
 events
Message-ID: <20201117175400.GV614220@kernel.org>
References: <20201117110053.1303113-1-jolsa@kernel.org>
 <20201117110053.1303113-24-jolsa@kernel.org>
 <20201117125040.GT614220@kernel.org>
 <20201117152140.GE1216482@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117152140.GE1216482@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 17, 2020 at 04:21:40PM +0100, Jiri Olsa escreveu:
> On Tue, Nov 17, 2020 at 09:50:40AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Nov 17, 2020 at 12:00:52PM +0100, Jiri Olsa escreveu:
> > > Add buildid-list support for mmap2's build id data, so we can
> > > display build ids for dso objects for data without the build
> > > id cache update.
> > 
> > >   $ perf buildid-list
> > >   1805c738c8f3ec0f47b7ea09080c28f34d18a82b /usr/lib64/ld-2.31.so
> > >   d278249792061c6b74d1693ca59513be1def13f2 /usr/lib64/libc-2.31.so
> > > 
> > > By default only dso objects with hits are shown.
> > 
> > Would be interesting to be able to show all the build ids that are
> > there. a 'perf buildid-list --all' or make this under --force?
> 
> ok, will check.. one other tool I think would be handy is
> to show which debuginfo is not available, because it can
> change the report a lot - missing symbols are not getting
> accounted, and their hits are accounted only as separated
> addresses

Right, as below.

So you suggest something like:

  # perf buildid-cache --fetch-missing-debuginfo

?

- Arnaldo

[root@quaco ~]# rpm -qf `which stress-ng`
stress-ng-0.11.21-1.fc32.x86_64
[root@quaco ~]# rpm -q stress-ng-debuginfo
stress-ng-debuginfo-0.07.29-10.fc31.x86_64
[root@quaco ~]# perf record stress-ng -t 1 -c 1
stress-ng: info:  [656926] dispatching hogs: 1 cpu
stress-ng: info:  [656926] successful run completed in 1.02s
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.204 MB perf.data (4082 samples) ]
[root@quaco ~]# perf report | head -20
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 4K of event 'cycles'
# Event count (approx.): 3997318603
#
# Overhead  Command        Shared Object     Symbol                        
# ........  .............  ................  ..............................
#
     7.91%  stress-ng-cpu  stress-ng         [.] 0x0000000000035ed9
     7.15%  stress-ng-cpu  stress-ng         [.] 0x0000000000035ecc
     6.54%  stress-ng-cpu  stress-ng         [.] 0x000000000003bbf6
     4.39%  stress-ng-cpu  stress-ng         [.] 0x000000000003a083
     4.15%  stress-ng-cpu  stress-ng         [.] 0x0000000000065ed8
     3.67%  stress-ng-cpu  stress-ng         [.] 0x0000000000065ecf
     3.41%  stress-ng-cpu  stress-ng         [.] 0x0000000000065ee1
     3.11%  stress-ng-cpu  stress-ng         [.] 0x000000000003bbf2
     2.65%  stress-ng-cpu  stress-ng         [.] 0x000000000003a07b
[root@quaco ~]#


So the above is with a stress-ng-debuginfo package that doesn't matches
the binary installed, so build-id checkign fails, resolving symbols
fail, then:

[root@quaco ~]# rpm -q stress-ng-debuginfo
stress-ng-debuginfo-0.11.21-1.fc32.x86_64
[root@quaco ~]# rpm -q stress-ng
stress-ng-0.11.21-1.fc32.x86_64
[root@quaco ~]#

[root@quaco ~]# rpm -q stress-ng-debuginfo
stress-ng-debuginfo-0.11.21-1.fc32.x86_64
[root@quaco ~]# rpm -q stress-ng
stress-ng-0.11.21-1.fc32.x86_64
[root@quaco ~]# perf report | head -20
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 4K of event 'cycles'
# Event count (approx.): 3997318603
#
# Overhead  Command        Shared Object  Symbol
# ........  .............  .............  .........................................
#
    21.48%  stress-ng-cpu  stress-ng      [.] is_prime
    16.02%  stress-ng-cpu  stress-ng      [.] stress_cpu_sieve
    12.61%  stress-ng-cpu  stress-ng      [.] stress_cpu_cpuid.sse2.2
    11.94%  stress-ng-cpu  stress-ng      [.] ackermann
     8.24%  stress-ng-cpu  stress-ng      [.] stress_cpu_correlate
     3.82%  stress-ng-cpu  stress-ng      [.] queens_try
     2.63%  stress-ng-cpu  stress-ng      [.] stress_cpu_nsqrt.sse2.2
     2.46%  stress-ng-cpu  stress-ng      [.] ccitt_crc16
     2.25%  stress-ng-cpu  stress-ng      [.] stress_cpu_complex_long_double.sse2.2
[root@quaco ~]#

[root@quaco ~]# perf report -v | head -20
build id event received for vmlinux: f72ec65d81949c5ba63ccaa16b59c79d1696bc4d [20]
build id event received for /usr/bin/stress-ng: 82b81bd823dcac393292faaaf40997723ce358a8 [20]
build id event received for [vdso]: a1f89b9b9d2093ae926c550a7de060d435277fbf [20]
build id event received for /usr/lib64/libm-2.31.so: fdf1f1d0761b7392e419d5d72e43d3fd3db6e184 [20]
build id event received for /usr/lib64/libc-2.31.so: d278249792061c6b74d1693ca59513be1def13f2 [20]
Looking at the vmlinux_path (8 entries long)
symsrc__init: build id mismatch for vmlinux.
Using /usr/lib/debug/lib/modules/5.8.14-200.fc32.x86_64/vmlinux for symbols
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 4K of event 'cycles'
# Event count (approx.): 3997318603
#
# Overhead  Command        Shared Object       Symbol                                              
# ........  .............  ..................  ....................................................
#
    21.48%  stress-ng-cpu  /usr/bin/stress-ng  0x35e80  l [.] is_prime
    16.02%  stress-ng-cpu  /usr/bin/stress-ng  0x3bbf6  l [.] stress_cpu_sieve
    12.61%  stress-ng-cpu  /usr/bin/stress-ng  0x65ec6  l [.] stress_cpu_cpuid.sse2.2
    11.94%  stress-ng-cpu  /usr/bin/stress-ng  0x3c66b  l [.] ackermann
     8.24%  stress-ng-cpu  /usr/bin/stress-ng  0x39fd8  l [.] stress_cpu_correlate
     3.82%  stress-ng-cpu  /usr/bin/stress-ng  0x64742  l [.] queens_try
     2.63%  stress-ng-cpu  /usr/bin/stress-ng  0x7a0a8  l [.] stress_cpu_nsqrt.sse2.2
     2.46%  stress-ng-cpu  /usr/bin/stress-ng  0x3400e  l [.] ccitt_crc16
     2.25%  stress-ng-cpu  /usr/bin/stress-ng  0x71761  l [.] stress_cpu_complex_long_double.sse2.2
[root@quaco ~]#
> 
> jirka
> 
> > 
> > - Arnaldo
> >  
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/perf/builtin-buildid-list.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
> > > index e3ef75583514..87f5b1a4a7fa 100644
> > > --- a/tools/perf/builtin-buildid-list.c
> > > +++ b/tools/perf/builtin-buildid-list.c
> > > @@ -77,6 +77,9 @@ static int perf_session__list_build_ids(bool force, bool with_hits)
> > >  	    perf_header__has_feat(&session->header, HEADER_AUXTRACE))
> > >  		with_hits = false;
> > >  
> > > +	if (!perf_header__has_feat(&session->header, HEADER_BUILD_ID))
> > > +		with_hits = true;
> > > +
> > >  	/*
> > >  	 * in pipe-mode, the only way to get the buildids is to parse
> > >  	 * the record stream. Buildids are stored as RECORD_HEADER_BUILD_ID
> > > -- 
> > > 2.26.2
> > > 
> > 
> > -- 
> > 
> > - Arnaldo
> > 
> 

-- 

- Arnaldo

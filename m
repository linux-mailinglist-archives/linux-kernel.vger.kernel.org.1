Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982732F698F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbhANSa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:30:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:49184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbhANSa5 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:30:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D53AC23B1A;
        Thu, 14 Jan 2021 18:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610649016;
        bh=yxP+U1naF2x/75BiAkB62FgxaTsZjjyw+RQ5kurm97k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4L27KdLGSwhEgjft2ZqQ7Mh2jHIpoBvKiswhJMB5iSi9g5+0IoejjtqkDbliAwkn
         rxYRDqrzeF33G9sNbB08j0CgmAby8OjPz5+GiF+TeuBeUgzdKTgAnTx3Q7AhfrR9uy
         609ximeig+HAKTmcxVHjnWRsuFF5u3r1DCVgHhy1xdso01bA2+steoXZeqvMCImZXi
         52M9OFI4MSpN4RZJLRqK/r1YYpsTF3G4uMHTLHTnrFDWvOROKsq/7aR9dpokJp8xZg
         BrkG1tXkaAG/3Rmc5Q6tV8mBltjnaZh1L76J3QShpEm0YfmdGD7/xTNN/PbI2gy6Zi
         ay+j99Phq+vyw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 96E82411E9; Thu, 14 Jan 2021 15:30:47 -0300 (-03)
Date:   Thu, 14 Jan 2021 15:30:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v5] perf stat: Fix wrong skipping for per-die aggregation
Message-ID: <20210114183047.GB307547@kernel.org>
References: <20210113015631.8748-1-yao.jin@linux.intel.com>
 <20210113110701.GC1331835@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113110701.GC1331835@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 13, 2021 at 12:07:01PM +0100, Jiri Olsa escreveu:
> On Wed, Jan 13, 2021 at 09:56:31AM +0800, Jin Yao wrote:
> 
> SNIP
> 
> > 
> > root@lkp-csl-2ap4 ~# ./perf stat -a -I 1000 -e llc_misses.mem_read --per-die -- sleep 5
> >      1.001586691 S0-D0           1            1229440 Bytes llc_misses.mem_read
> >      1.001586691 S0-D1           1             976832 Bytes llc_misses.mem_read
> >      1.001586691 S1-D0           1             938304 Bytes llc_misses.mem_read
> >      1.001586691 S1-D1           1            1227328 Bytes llc_misses.mem_read
> >      2.003776312 S0-D0           1            1586752 Bytes llc_misses.mem_read
> >      2.003776312 S0-D1           1             875392 Bytes llc_misses.mem_read
> >      2.003776312 S1-D0           1             855616 Bytes llc_misses.mem_read
> >      2.003776312 S1-D1           1             949376 Bytes llc_misses.mem_read
> >      3.006512788 S0-D0           1            1338880 Bytes llc_misses.mem_read
> >      3.006512788 S0-D1           1             920064 Bytes llc_misses.mem_read
> >      3.006512788 S1-D0           1             877184 Bytes llc_misses.mem_read
> >      3.006512788 S1-D1           1            1020736 Bytes llc_misses.mem_read
> >      4.008895291 S0-D0           1             926592 Bytes llc_misses.mem_read
> >      4.008895291 S0-D1           1             906368 Bytes llc_misses.mem_read
> >      4.008895291 S1-D0           1             892224 Bytes llc_misses.mem_read
> >      4.008895291 S1-D1           1             987712 Bytes llc_misses.mem_read
> >      5.001590993 S0-D0           1             962624 Bytes llc_misses.mem_read
> >      5.001590993 S0-D1           1             912512 Bytes llc_misses.mem_read
> >      5.001590993 S1-D0           1             891200 Bytes llc_misses.mem_read
> >      5.001590993 S1-D1           1             978432 Bytes llc_misses.mem_read
> > 
> > On no-die system, die_id is 0, actually it's hashmap(socket,0), original behavior
> > is not changed.
> > 
> > Reported-by: Huang Ying <ying.huang@intel.com>
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > ---
> > v5:
> >  Hash key is changed to die_id << 32 | socket.
> >  In pkg_id_hash, return (int64_t)key & 0xffffffff; actually it's socket.
> 
> seems ok, but I'm getting python test fail:

He addressed that in v6, so I've sticked an Acked-by: jolsa, ok?

- Arnaldo
 
> 	$ sudo ./perf test python -v
> 	19: 'import perf' in python                                         :
> 	--- start ---
> 	test child forked, pid 1352066
> 	python usage test: "echo "import sys ; sys.path.append('python'); import perf" | '/usr/bin/python2' "
> 	Traceback (most recent call last):
> 	  File "<stdin>", line 1, in <module>
> 	ImportError: python/perf.so: undefined symbol: hashmap__free
> 	test child finished with -1
> 	---- end ----
> 	'import perf' in python: FAILED!
> 
> jirka
> 

-- 

- Arnaldo

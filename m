Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7792F86AB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 21:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388504AbhAOU21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 15:28:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:55574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbhAOU2Z (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 15:28:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4411E23A5A;
        Fri, 15 Jan 2021 20:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610742462;
        bh=AmJEKHhWTR11eAcP24RbMh6gn4D/k9nz+FpoxQazw5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G/QBsaXoGxg3bpcuHRlpwtXE3HIpTAvLF+O4XkbTvEr2sBc7j+NJE5okFN2g8UmD8
         0vCCDp6yJwZs2mPmipuEIOMhnLVnAxsNHVDbGMYuGl/aLIOHIWR61bG7Ew+60iFESB
         8b1AO3ZK5Sg8TqkhoB3jwxFX9SHOqQJkgP08gINjwLoiIWcUgBlIA5h00A/AOMSMdz
         drZphulCWqfOd1nX6w0wfOEctcjxFubzH3b6+pig3ZH+qc/Uw3m73T+ks61eDmU+7r
         sXjkwGubRntHY9csmsrmfUKnwUPANqtWsOpW+59FOhkPjm+CDTFN0AoNLzMPC6gkk/
         x6v2+fEdjdb6w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ADFCB40522; Fri, 15 Jan 2021 17:28:14 -0300 (-03)
Date:   Fri, 15 Jan 2021 17:28:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        ying.huang@intel.com
Subject: Re: [PATCH v6] perf stat: Fix wrong skipping for per-die aggregation
Message-ID: <20210115202814.GM457607@kernel.org>
References: <20210114012755.1106-1-yao.jin@linux.intel.com>
 <20210114190032.GC1416940@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114190032.GC1416940@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 14, 2021 at 08:00:32PM +0100, Jiri Olsa escreveu:
> On Thu, Jan 14, 2021 at 09:27:55AM +0800, Jin Yao wrote:
> 
> SNIP
> 
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
> > v6:
> >  Fix the perf test python failure by adding hashmap.c to python-ext-sources.
> > 
> >  root@kbl-ppc:~# ./perf test python
> >  19: 'import perf' in python                                         : Ok
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Jin, this is breaking the build in some 32-bit system, can you please
take a look to validate these warnings?

  CC       /tmp/build/perf/util/srcline.o
util/stat.c: In function 'pkg_id_hash':
util/stat.c:285:9: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
  return (int64_t)key & 0xffffffff;
         ^
util/stat.c: In function 'pkg_id_equal':
util/stat.c:291:9: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
  return (int64_t)key1 == (int64_t)key2;
         ^
util/stat.c:291:26: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
  return (int64_t)key1 == (int64_t)key2;
                          ^
util/stat.c: In function 'check_per_pkg':
util/stat.c:342:26: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  if (hashmap__find(mask, (void *)key, NULL))
                          ^
util/stat.c:345:28: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
   ret = hashmap__add(mask, (void *)key, (void *)1);
                            ^
  CC       /tmp/build/perf/tests/expand-cgroup.o

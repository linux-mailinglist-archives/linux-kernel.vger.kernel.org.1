Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32AE2F86BB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 21:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388025AbhAOUb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 15:31:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:55964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbhAOUb1 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 15:31:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2A2F23A5A;
        Fri, 15 Jan 2021 20:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610742646;
        bh=pBJybeyb9dtJbpJVNW+yRCO6JbuqCDAgA9WZSvcUr7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VraRXpQORvQB+RBjkPBNBTXMCqHVaclwz1+zCgrmdpbprX/T4mq+HUSC4JItvLrJQ
         WqSA9M5TnhNVgYubZbUKzjv6rnv3i1HALdnVL8s0z4A9Nu4ShAPBkM6UP6iMdY3loj
         nikREI6LNqqwOssIKFSOQwvoTlZV3Y/6cwqC0OI5HpYQQPJ2jnrst1DOgg43KW18pt
         mGHQYl+cbcloG4m9ov87By67/Wcb9ErhxXYj5KBtRLT0Xxr68ONr8B2hjsSMgEak89
         U+m3uiZs/TvZFufHsa9IkfFWqBHNeWzU1zL2t5stTCmqYtxZ0qIZrGSdIy19RGbQZU
         x/YGMRXAUptLA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 29C6140522; Fri, 15 Jan 2021 17:31:19 -0300 (-03)
Date:   Fri, 15 Jan 2021 17:31:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        ying.huang@intel.com
Subject: Re: [PATCH v6] perf stat: Fix wrong skipping for per-die aggregation
Message-ID: <20210115203119.GN457607@kernel.org>
References: <20210114012755.1106-1-yao.jin@linux.intel.com>
 <20210114190032.GC1416940@krava>
 <20210115202814.GM457607@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115202814.GM457607@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 15, 2021 at 05:28:14PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Jan 14, 2021 at 08:00:32PM +0100, Jiri Olsa escreveu:
> > On Thu, Jan 14, 2021 at 09:27:55AM +0800, Jin Yao wrote:
> > 
> > SNIP
> > 
> > >      2.003776312 S1-D0           1             855616 Bytes llc_misses.mem_read
> > >      2.003776312 S1-D1           1             949376 Bytes llc_misses.mem_read
> > >      3.006512788 S0-D0           1            1338880 Bytes llc_misses.mem_read
> > >      3.006512788 S0-D1           1             920064 Bytes llc_misses.mem_read
> > >      3.006512788 S1-D0           1             877184 Bytes llc_misses.mem_read
> > >      3.006512788 S1-D1           1            1020736 Bytes llc_misses.mem_read
> > >      4.008895291 S0-D0           1             926592 Bytes llc_misses.mem_read
> > >      4.008895291 S0-D1           1             906368 Bytes llc_misses.mem_read
> > >      4.008895291 S1-D0           1             892224 Bytes llc_misses.mem_read
> > >      4.008895291 S1-D1           1             987712 Bytes llc_misses.mem_read
> > >      5.001590993 S0-D0           1             962624 Bytes llc_misses.mem_read
> > >      5.001590993 S0-D1           1             912512 Bytes llc_misses.mem_read
> > >      5.001590993 S1-D0           1             891200 Bytes llc_misses.mem_read
> > >      5.001590993 S1-D1           1             978432 Bytes llc_misses.mem_read
> > > 
> > > On no-die system, die_id is 0, actually it's hashmap(socket,0), original behavior
> > > is not changed.
> > > 
> > > Reported-by: Huang Ying <ying.huang@intel.com>
> > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > > ---
> > > v6:
> > >  Fix the perf test python failure by adding hashmap.c to python-ext-sources.
> > > 
> > >  root@kbl-ppc:~# ./perf test python
> > >  19: 'import perf' in python                                         : Ok
> > 
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> Jin, this is breaking the build in some 32-bit system, can you please
> take a look to validate these warnings?

One such system:

  28    13.75 debian:experimental-x-mipsel  : FAIL mipsel-linux-gnu-gcc (Debian 10.2.1-3) 10.2.1 20201224

 
>   CC       /tmp/build/perf/util/srcline.o
> util/stat.c: In function 'pkg_id_hash':
> util/stat.c:285:9: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>   return (int64_t)key & 0xffffffff;
>          ^
> util/stat.c: In function 'pkg_id_equal':
> util/stat.c:291:9: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>   return (int64_t)key1 == (int64_t)key2;
>          ^
> util/stat.c:291:26: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>   return (int64_t)key1 == (int64_t)key2;
>                           ^
> util/stat.c: In function 'check_per_pkg':
> util/stat.c:342:26: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>   if (hashmap__find(mask, (void *)key, NULL))
>                           ^
> util/stat.c:345:28: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>    ret = hashmap__add(mask, (void *)key, (void *)1);
>                             ^
>   CC       /tmp/build/perf/tests/expand-cgroup.o

-- 

- Arnaldo

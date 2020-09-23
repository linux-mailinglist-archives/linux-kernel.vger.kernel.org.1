Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC24C275BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgIWP15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgIWP14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:27:56 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85B6C21D41;
        Wed, 23 Sep 2020 15:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600874876;
        bh=kfIswk/R6V7zWEtfzxjxV1wwN+uTCotAByHsaCqEmms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XJf9gqXw0UNsh4+QKfN+hoAwiUn73hIsQAUSNNyDIUqjjDJERFYG5S7bobE3yh11R
         GKQBomCrQVqIhMwdaAqY6lOotIhc61R93OSrB3q4C89J80GvZWGK3nGH5J/Vfe0y9s
         NelMNQisc8wavbOQFTN8y4wU+xeDDHpPmEL2Y2sw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A9004400E9; Wed, 23 Sep 2020 12:27:53 -0300 (-03)
Date:   Wed, 23 Sep 2020 12:27:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Nick Gasson <nick.gasson@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Steve MacLean <Steve.MacLean@microsoft.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zou Wei <zou_wei@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/6] Perf tool: Support TSC for Arm64
Message-ID: <20200923152753.GC2517482@kernel.org>
References: <20200914115311.2201-1-leo.yan@linaro.org>
 <20200922120732.GB15124@leoy-ThinkPad-X240s>
 <20200922164906.GA2248446@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922164906.GA2248446@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 22, 2020 at 01:49:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Sep 22, 2020 at 08:07:32PM +0800, Leo Yan escreveu:
> > Hi Arnaldo,
> > 
> > On Mon, Sep 14, 2020 at 07:53:05PM +0800, Leo Yan wrote:
> > > This patch set is to refactor TSC implementation and move TSC code from
> > > x86 folder to util/tsc.c, this allows all archs to reuse the code.  And
> > > alse move the TSC testing from x86 folder to tests so can work as a
> > > common testing.
> > > 
> > > So far, for x86 it needs to support cap_user_time_zero and for Arm64
> > > it needs to support cap_user_time_short.  For architecture specific
> > > code, every arch only needs to implement its own rdtsc() to read out
> > > timer's counter.
> > > 
> > > This patch set has been rebased on the perf/core branch with latest
> > > commit b1f815c479c1 ("perf vendor events power9: Add hv_24x7 core level
> > > metric events") and tested on Arm64 DB410c.
> > 
> > Could you pick up this patch set?  Thanks!
> 
> Yeah, I picked it up now, its a pity nobody provided Acks :-\
> 
> Or have a missed them somehow?

Also:

$ cat dm.log/debian:experimental-x-mips64

  CC       /tmp/build/perf/tests/llvm-src-prologue.o
  CC       /tmp/build/perf/tests/llvm-src-relocation.o
tests/perf-time-to-tsc.c:24:10: fatal error: arch-tests.h: No such file or directory
   24 | #include "arch-tests.h"
      |          ^~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [/git/linux/tools/build/Makefile.build:96: /tmp/build/perf/tests/perf-time-to-tsc.o] Error 1
make[4]: *** Waiting for unfinished jobs....

[perfbuilder@five ~]$ cat dm.log/debian:experimental-x-mipsel | grep "fatal error" -A5
tests/perf-time-to-tsc.c:24:10: fatal error: arch-tests.h: No such file or directory
   24 | #include "arch-tests.h"
      |          ^~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [/git/linux/tools/build/Makefile.build:96: /tmp/build/perf/tests/perf-time-to-tsc.o] Error 1
make[4]: *** Waiting for unfinished jobs....
[perfbuilder@five ~]$ 

[perfbuilder@five ~]$ cat dm.log/fedora:30-x-ARC-uClibc | grep "fatal error" -A5
tests/perf-time-to-tsc.c:24:10: fatal error: arch-tests.h: No such file or directory
 #include "arch-tests.h"
          ^~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [/git/linux/tools/build/Makefile.build:97: /tmp/build/perf/tests/perf-time-to-tsc.o] Error 1
make[4]: *** Waiting for unfinished jobs....
[perfbuilder@five ~]$

[perfbuilder@five ~]$ cat dm.log/ubuntu:18.04-x-s390 | grep "fatal error" -A5
tests/perf-time-to-tsc.c:24:10: fatal error: arch-tests.h: No such file or directory
 #include "arch-tests.h"
          ^~~~~~~~~~~~~~
compilation terminated.
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/tests/perf-time-to-tsc.o' failed
make[4]: *** [/tmp/build/perf/tests/perf-time-to-tsc.o] Error 1
[perfbuilder@five ~]$


Oh, it works for arm64 and powerpc

  69    25.93 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
  70    25.69 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0


  68    79.84 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0, clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  69    25.93 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
  70    25.69 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
  71    11.75 ubuntu:18.04-x-m68k           : FAIL m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  72    25.72 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  73    28.10 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  74    27.84 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  75    12.11 ubuntu:18.04-x-riscv64        : FAIL riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  76    11.85 ubuntu:18.04-x-s390           : FAIL s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  77    12.55 ubuntu:18.04-x-sh4            : FAIL sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  78    11.42 ubuntu:18.04-x-sparc64        : FAIL sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0


[perfbuilder@five ~]$ grep tsc dm.log/ubuntu\:18.04-x-powerpc64
  CC       /tmp/build/perf/tests/perf-time-to-tsc.o
  CC       /tmp/build/perf/util/tsc.o
  CC       /tmp/build/perf/tests/perf-time-to-tsc.o
  CC       /tmp/build/perf/util/tsc.o
  CC       /tmp/build/perf/tests/perf-time-to-tsc.o
  CC       /tmp/build/perf/util/tsc.o
[perfbuilder@five ~]$

Can you please take a look and resubmit? I'm removing the series from my
local branch.

- Arnaldo

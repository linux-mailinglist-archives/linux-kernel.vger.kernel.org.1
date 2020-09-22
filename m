Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB89A2746F5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgIVQtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:49:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgIVQtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:49:10 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16B7120738;
        Tue, 22 Sep 2020 16:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600793349;
        bh=cdXHCF9oAj+yuX5K7JBhj671wsoA6V7y/1bcuOWn4Ls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WBdjHDdOoU2J0KWlc5G+kPG+p+cV16o2ZLBpzjJPpCmd41CopnP0UAVLC5KRl9Ja4
         SSdktonstRSoyKko12tbCpa0e6fqSBzEUJllGFDnruZcM6QU232BAOfhvNRcdTmzJW
         ha+HVEzLxNc7Qe5xpr0tSFoKB7GSActsHpmRFz78=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BDC95400E9; Tue, 22 Sep 2020 13:49:06 -0300 (-03)
Date:   Tue, 22 Sep 2020 13:49:06 -0300
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
Message-ID: <20200922164906.GA2248446@kernel.org>
References: <20200914115311.2201-1-leo.yan@linaro.org>
 <20200922120732.GB15124@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922120732.GB15124@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 22, 2020 at 08:07:32PM +0800, Leo Yan escreveu:
> Hi Arnaldo,
> 
> On Mon, Sep 14, 2020 at 07:53:05PM +0800, Leo Yan wrote:
> > This patch set is to refactor TSC implementation and move TSC code from
> > x86 folder to util/tsc.c, this allows all archs to reuse the code.  And
> > alse move the TSC testing from x86 folder to tests so can work as a
> > common testing.
> > 
> > So far, for x86 it needs to support cap_user_time_zero and for Arm64
> > it needs to support cap_user_time_short.  For architecture specific
> > code, every arch only needs to implement its own rdtsc() to read out
> > timer's counter.
> > 
> > This patch set has been rebased on the perf/core branch with latest
> > commit b1f815c479c1 ("perf vendor events power9: Add hv_24x7 core level
> > metric events") and tested on Arm64 DB410c.
> 
> Could you pick up this patch set?  Thanks!

Yeah, I picked it up now, its a pity nobody provided Acks :-\

Or have a missed them somehow?

- Arnaldo
 
> Leo
> 
> >   $ perf test list
> >     [...]
> >     68: Convert perf time to TSC
> >     [...]
> > 
> >   $ perf test 68 -v
> >     68: Convert perf time to TSC
> >     --- start ---
> >     test child forked, pid 10961
> >     mmap size 528384B
> >     1st event perf time 35715036563417 tsc 686221770989
> >     rdtsc          time 35715036649719 tsc 686221772647
> >     2nd event perf time 35715036660448 tsc 686221772852
> >     test child finished with 0
> >     ---- end ----
> >     Convert perf time to TSC: Ok
> > 
> > Changes from v3:
> > * Added comments for Arm64's rdtsc() for short counter (PeterZ);
> > * Rebased on latest acme/perf/core branch.
> > 
> > Changes from v2:
> > * Refactored patch set to move TSC common code to util/tsc.c (Wei/Al);
> > * Moved TSC testing to perf/tests (Wei);
> > * Dropped Arm SPE timestamp patch so can have clear purpose and easier
> >   reviewing; will send Arm SPE timestamp as separate patch.
> > 
> > 
> > Leo Yan (6):
> >   perf tsc: Move out common functions from x86
> >   perf tsc: Add rdtsc() for Arm64
> >   perf tsc: Calculate timestamp with cap_user_time_short
> >   perf tsc: Support cap_user_time_short for event TIME_CONV
> >   perf tests tsc: Make tsc testing as a common testing
> >   perf tests tsc: Add checking helper is_supported()
> > 
> >  tools/lib/perf/include/perf/event.h           |  4 +
> >  tools/perf/arch/arm64/util/Build              |  1 +
> >  tools/perf/arch/arm64/util/tsc.c              | 21 +++++
> >  tools/perf/arch/x86/include/arch-tests.h      |  1 -
> >  tools/perf/arch/x86/tests/Build               |  1 -
> >  tools/perf/arch/x86/tests/arch-tests.c        |  4 -
> >  tools/perf/arch/x86/util/tsc.c                | 73 +----------------
> >  tools/perf/tests/Build                        |  1 +
> >  tools/perf/tests/builtin-test.c               |  5 ++
> >  .../{arch/x86 => }/tests/perf-time-to-tsc.c   | 13 +++
> >  tools/perf/tests/tests.h                      |  2 +
> >  tools/perf/util/jitdump.c                     | 14 ++--
> >  tools/perf/util/synthetic-events.c            |  8 --
> >  tools/perf/util/tsc.c                         | 81 +++++++++++++++++++
> >  tools/perf/util/tsc.h                         |  5 ++
> >  15 files changed, 143 insertions(+), 91 deletions(-)
> >  create mode 100644 tools/perf/arch/arm64/util/tsc.c
> >  rename tools/perf/{arch/x86 => }/tests/perf-time-to-tsc.c (93%)
> > 
> > -- 
> > 2.17.1
> > 

-- 

- Arnaldo

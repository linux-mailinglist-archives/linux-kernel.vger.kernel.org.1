Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD9A278658
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgIYLzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:55:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbgIYLzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:55:15 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30D7E2083B;
        Fri, 25 Sep 2020 11:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601034914;
        bh=50ZOmvOc2ZlEI23PAbvy1zGSWLYiRVFaYNi2E1GtLCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nHtUJVBKBiSGnwlpY0BocpwbY6jLKBZu33t8o4BFdoFl29xSVt3EZ5LtImcSbDQOs
         m6apuPsNPtsg9o1MOBlllURmLsLI833hCChP2C7grCo96q9Qfk2slMIc9/al1d2UkJ
         MIBX6cdGsydXFb1xku0Jg3gvC0R3cjCHT42JjgWw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 089F7400E9; Fri, 25 Sep 2020 08:55:12 -0300 (-03)
Date:   Fri, 25 Sep 2020 08:55:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>, 0day robot <lkp@intel.com>,
        lkp@lists.01.org
Subject: Re: [perf tools] 77b66fd551:
 perf-sanity-tests.'import_perf'_in_python.fail
Message-ID: <20200925115511.GA2868146@kernel.org>
References: <20200908044228.61197-4-namhyung@kernel.org>
 <20200923091431.GF28663@shao2-debian>
 <CAM9d7cjp-R1WzEn-OOB=p=ir6=3enSKy=kxUu-MfOUwAeXVRcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjp-R1WzEn-OOB=p=ir6=3enSKy=kxUu-MfOUwAeXVRcg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 24, 2020 at 12:04:51PM +0900, Namhyung Kim escreveu:
> On Wed, Sep 23, 2020 at 6:15 PM kernel test robot <rong.a.chen@intel.com> wrote:
> > FYI, we noticed the following commit (built with gcc-9):

> > commit: 77b66fd55195289f5361af4f8a0978a3a90b9363 ("[PATCH 3/4] perf tools: Copy metric events properly when multiply cgroups")
> > url: https://github.com/0day-ci/linux/commits/Namhyung-Kim/perf-stat-Add-multiply-cgroup-option/20200908-124454
> > base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 2cb5383b30d47c446ec7d884cd80f93ffcc31817

> > in testcase: perf-sanity-tests
> > version: perf-x86_64-34d4ddd359db-1_20200909
> > with following parameters:

> >         perf_compiler: gcc
> >         ucode: 0xdc

> > on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz with 16G memory

> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> Thanks for the report.  I'll fix it and send it in the next version.

I'm so glad this is in place, thanks to all involved!

- Arnaldo
 
> Thanks
> Namhyung
> >
> >
> > 2020-09-23 04:43:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 1
> >  1: vmlinux symtab matches kallsyms                       : Ok
> > 2020-09-23 04:43:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 2
> >  2: Detect openat syscall event                           : Ok
> > 2020-09-23 04:43:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 3
> >  3: Detect openat syscall event on all cpus               : Ok
> > 2020-09-23 04:43:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 4
> >  4: Read samples using the mmap interface                 : Ok
> > 2020-09-23 04:43:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 5
> >  5: Test data source output                               : Ok
> > 2020-09-23 04:43:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 6
> >  6: Parse event definition strings                        : Ok
> > 2020-09-23 04:43:46 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 7
> >  7: Simple expression parser                              : Ok
> > 2020-09-23 04:43:46 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 8
> >  8: PERF_RECORD_* events & perf_sample fields             : Ok
> > 2020-09-23 04:43:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 9
> >  9: Parse perf pmu format                                 : Ok
> > 2020-09-23 04:43:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 10
> > 10: PMU events                                            :
> > 10.1: PMU event table sanity                              : Ok
> > 10.2: PMU event map aliases                               : Ok
> > 10.3: Parsing of PMU event table metrics                  : Skip (some metrics failed)
> > 10.4: Parsing of PMU event table metrics with fake PMUs   : Ok
> > 2020-09-23 04:43:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 11
> > 11: DSO data read                                         : Ok
> > 2020-09-23 04:43:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 12
> > 12: DSO data cache                                        : Ok
> > 2020-09-23 04:43:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 13
> > 13: DSO data reopen                                       : Ok
> > 2020-09-23 04:43:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 14
> > 14: Roundtrip evsel->name                                 : Ok
> > 2020-09-23 04:43:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 15
> > 15: Parse sched tracepoints fields                        : Ok
> > 2020-09-23 04:43:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 16
> > 16: syscalls:sys_enter_openat event fields                : Ok
> > 2020-09-23 04:43:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 17
> > 17: Setup struct perf_event_attr                          : Ok
> > 2020-09-23 04:43:54 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 18
> > 18: Match and link multiple hists                         : Ok
> > 2020-09-23 04:43:54 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 19
> > 19: 'import perf' in python                               : FAILED!
> >
> >
> >
> > To reproduce:
> >
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp install job.yaml  # job file is attached in this email
> >         bin/lkp run     job.yaml
> >
> >
> >
> > Thanks,
> > Rong Chen
> >

-- 

- Arnaldo

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4092766B6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 05:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgIXDFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 23:05:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35861 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgIXDFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 23:05:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id z1so2126354wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 20:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fylDCS8rQACBCZ0+ZLPFTIF4ei1ENrnToqEENJpUMHg=;
        b=ElMRP361m6q3xFy1ijNZfZPC+ViXN5si0xYTWNDgfBgVV2GqOLEXKJy8YNUJyGIzAd
         qeckShDWNTQz3YEtJlRj/u1yNDyKyK1DoOoJzkls49ewnKxM52lHDRqPRNT2QJaNrFU8
         dPh6DN9i5zS06Vd4+LfVkkllWV6+bOUfJddzXlTc0NHZ3q8N1DjQfi3ryC/XrdqYVwoN
         tBgoCM5uZg5Hp2BE/Hc3i/nF9O5NQiOdEzAekevc+jGOaWwOjpxnqVSOmmk0R8CAOVUO
         11C1KQxwenGFehMddFdbBdL2YEDJUiZlOBKwDeoUGmzLdug/3NRKBjGgj229zj+Lb940
         VWJw==
X-Gm-Message-State: AOAM530ONKKC0zEFOzfctFqhCQ6z/Qvdij92G0lAjccR5oMrLFZ2+j2y
        /w6N87k4cVw5JaxomypsYxYQ7V7Gc404NnCAed8=
X-Google-Smtp-Source: ABdhPJzV9xbGkWAbAoUviPesKUfLis0c8vXpnyCC6V92BGMGf8WsaIx67ease+E0WZaqsfrecvzzvUCHBH8T1HTXdUY=
X-Received: by 2002:adf:8b48:: with SMTP id v8mr2561457wra.21.1600916717498;
 Wed, 23 Sep 2020 20:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200908044228.61197-4-namhyung@kernel.org> <20200923091431.GF28663@shao2-debian>
In-Reply-To: <20200923091431.GF28663@shao2-debian>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 24 Sep 2020 12:04:51 +0900
Message-ID: <CAM9d7cjp-R1WzEn-OOB=p=ir6=3enSKy=kxUu-MfOUwAeXVRcg@mail.gmail.com>
Subject: Re: [perf tools] 77b66fd551: perf-sanity-tests.'import_perf'_in_python.fail
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Sep 23, 2020 at 6:15 PM kernel test robot <rong.a.chen@intel.com> wrote:
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 77b66fd55195289f5361af4f8a0978a3a90b9363 ("[PATCH 3/4] perf tools: Copy metric events properly when multiply cgroups")
> url: https://github.com/0day-ci/linux/commits/Namhyung-Kim/perf-stat-Add-multiply-cgroup-option/20200908-124454
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 2cb5383b30d47c446ec7d884cd80f93ffcc31817
>
> in testcase: perf-sanity-tests
> version: perf-x86_64-34d4ddd359db-1_20200909
> with following parameters:
>
>         perf_compiler: gcc
>         ucode: 0xdc
>
>
>
> on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz with 16G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>

Thanks for the report.  I'll fix it and send it in the next version.

Thanks
Namhyung

>
>
> 2020-09-23 04:43:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 1
>  1: vmlinux symtab matches kallsyms                       : Ok
> 2020-09-23 04:43:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 2
>  2: Detect openat syscall event                           : Ok
> 2020-09-23 04:43:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 3
>  3: Detect openat syscall event on all cpus               : Ok
> 2020-09-23 04:43:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 4
>  4: Read samples using the mmap interface                 : Ok
> 2020-09-23 04:43:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 5
>  5: Test data source output                               : Ok
> 2020-09-23 04:43:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 6
>  6: Parse event definition strings                        : Ok
> 2020-09-23 04:43:46 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 7
>  7: Simple expression parser                              : Ok
> 2020-09-23 04:43:46 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 8
>  8: PERF_RECORD_* events & perf_sample fields             : Ok
> 2020-09-23 04:43:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 9
>  9: Parse perf pmu format                                 : Ok
> 2020-09-23 04:43:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 10
> 10: PMU events                                            :
> 10.1: PMU event table sanity                              : Ok
> 10.2: PMU event map aliases                               : Ok
> 10.3: Parsing of PMU event table metrics                  : Skip (some metrics failed)
> 10.4: Parsing of PMU event table metrics with fake PMUs   : Ok
> 2020-09-23 04:43:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 11
> 11: DSO data read                                         : Ok
> 2020-09-23 04:43:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 12
> 12: DSO data cache                                        : Ok
> 2020-09-23 04:43:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 13
> 13: DSO data reopen                                       : Ok
> 2020-09-23 04:43:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 14
> 14: Roundtrip evsel->name                                 : Ok
> 2020-09-23 04:43:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 15
> 15: Parse sched tracepoints fields                        : Ok
> 2020-09-23 04:43:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 16
> 16: syscalls:sys_enter_openat event fields                : Ok
> 2020-09-23 04:43:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 17
> 17: Setup struct perf_event_attr                          : Ok
> 2020-09-23 04:43:54 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 18
> 18: Match and link multiple hists                         : Ok
> 2020-09-23 04:43:54 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-77b66fd55195289f5361af4f8a0978a3a90b9363/tools/perf/perf test 19
> 19: 'import perf' in python                               : FAILED!
>
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
>
>
>
> Thanks,
> Rong Chen
>

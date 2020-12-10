Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B542D6502
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393046AbgLJS3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:29:17 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2245 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391956AbgLJS3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 13:29:11 -0500
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CsMmY6vZTz67K4w;
        Fri, 11 Dec 2020 02:25:49 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 10 Dec 2020 19:28:29 +0100
Received: from [10.210.172.228] (10.210.172.228) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 10 Dec 2020 18:28:27 +0000
Subject: Re: [BUG] jevents problem when cross building Re: [PATCH 2/3] perf
 tools: Allow to enable/disable events via control file
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@redhat.com>,
        Alexei Budankov <abudankov@huawei.com>,
        "Jiri Olsa" <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
References: <20201206170519.4010606-1-jolsa@kernel.org>
 <20201206170519.4010606-3-jolsa@kernel.org>
 <7bcde520-e933-c2d6-c960-3f8acdaf6047@huawei.com>
 <20201210162430.GH69683@krava> <20201210171503.GA195565@kernel.org>
 <20201210171903.GB195565@kernel.org> <20201210172608.GC195565@kernel.org>
 <30e7907d-868a-a673-59a7-3bb4766093b4@huawei.com>
 <20201210181708.GD195565@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <1a608e92-d0d0-2e5e-ba7e-e9fa2e02b0f9@huawei.com>
Date:   Thu, 10 Dec 2020 18:27:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201210181708.GD195565@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.172.228]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2020 18:17, Arnaldo Carvalho de Melo wrote:
>> So symbol 'pmu_sys_event_tables' is introduced inhttps://lore.kernel.org/linux-arm-kernel/1607080216-36968-3-git-send-email-john.garry@huawei.com/,
>> but I did not think that you picked any of this series up yet, right?
>>
>> I checked your perf/core branch, and no sign, so which git/branch is this?
> Its unpublished, I'll send it to the tmp.perf/core branch now.

I use cross-compile for arm64 to build, and it's ok.

I notice that the failures are for architectures which don't have an 
entry under pmu-events/arch, so maybe we're missing some 'weak' 
definition of pmu_sys_event_tables.

I'll check now.

John

> 
> More results from testing:
> 
>    59    13.57 ubuntu:16.04-x-arm            : FAIL arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
> 
> [perfbuilder@five ~]$ tail -20 dm.log/ubuntu\:16.04-x-arm
>    CC       /tmp/build/perf/util/expr.o
>    LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
>    LD       /tmp/build/perf/util/perf-in.o
>    LD       /tmp/build/perf/perf-in.o
>    LINK     /tmp/build/perf/perf
> /tmp/build/perf/perf-in.o: In function `pmu_for_each_sys_event':
> /git/linux/tools/perf/util/pmu.c:816: undefined reference to `pmu_sys_event_tables'
> /git/linux/tools/perf/util/pmu.c:816: undefined reference to `pmu_sys_event_tables'
> /tmp/build/perf/perf-in.o: In function `pmu_add_sys_aliases':
> /git/linux/tools/perf/util/pmu.c:886: undefined reference to `pmu_sys_event_tables'
> /git/linux/tools/perf/util/pmu.c:886: undefined reference to `pmu_sys_event_tables'
> collect2: error: ld returned 1 exit status
> Makefile.perf:659: recipe for target '/tmp/build/perf/perf' failed
> make[2]: *** [/tmp/build/perf/perf] Error 1
> Makefile.perf:232: recipe for target 'sub-make' failed
> make[1]: *** [sub-make] Error 2
> Makefile:69: recipe for target 'all' failed
> make: *** [all] Error 2
> make: Leaving directory '/git/linux/tools/perf'
> + exit 1
> [perfbuilder@five ~]$
> 
>    60    26.91 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>    61    25.62 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>    62    26.39 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>    63    25.92 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>    64    25.96 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>    65    89.87 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0, clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
>    66    14.45 ubuntu:18.04-x-arm            : FAIL arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
> 
> [perfbuilder@five ~]$ tail -20 dm.log/ubuntu\:18.04-x-arm
>    CC       /tmp/build/perf/util/pmu-flex.o
>    CC       /tmp/build/perf/util/expr-flex.o
>    CC       /tmp/build/perf/util/expr.o
>    LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
>    LD       /tmp/build/perf/util/perf-in.o
>    LD       /tmp/build/perf/perf-in.o
>    LINK     /tmp/build/perf/perf
> /tmp/build/perf/perf-in.o: In function `pmu_for_each_sys_event':
> /git/linux/tools/perf/util/pmu.c:840: undefined reference to `pmu_sys_event_tables'
> /tmp/build/perf/perf-in.o: In function `perf_pmu__find':
> /git/linux/tools/perf/util/pmu.c:1031: undefined reference to `pmu_sys_event_tables'
> collect2: error: ld returned 1 exit status
> Makefile.perf:659: recipe for target '/tmp/build/perf/perf' failed
> make[2]: *** [/tmp/build/perf/perf] Error 1
> Makefile.perf:232: recipe for target 'sub-make' failed
> make[1]: *** [sub-make] Error 2
> Makefile:69: recipe for target 'all' failed
> make: *** [all] Error 2
> make: Leaving directory '/git/linux/tools/perf'
> + exit 1
> [perfbuilder@five ~]$
> 
>    67    27.63 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
>    68    12.06 ubuntu:18.04-x-m68k           : FAIL m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
> 
> [perfbuilder@five ~]$ tail -20 dm.log/ubuntu\:18.04-x-m68k
>    CC       /tmp/build/perf/util/pmu-flex.o
>    CC       /tmp/build/perf/util/expr-flex.o
>    CC       /tmp/build/perf/util/expr.o
>    LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
>    LD       /tmp/build/perf/util/perf-in.o
>    LD       /tmp/build/perf/perf-in.o
>    LINK     /tmp/build/perf/perf
> /tmp/build/perf/perf-in.o: In function `pmu_for_each_sys_event':
> /git/linux/tools/perf/util/pmu.c:816: undefined reference to `pmu_sys_event_tables'
> /tmp/build/perf/perf-in.o: In function `pmu_add_sys_aliases':
> /git/linux/tools/perf/util/pmu.c:886: undefined reference to `pmu_sys_event_tables'
> collect2: error: ld returned 1 exit status
> Makefile.perf:659: recipe for target '/tmp/build/perf/perf' failed
> make[2]: *** [/tmp/build/perf/perf] Error 1
> Makefile.perf:232: recipe for target 'sub-make' failed
> make[1]: *** [sub-make] Error 2
> Makefile:69: recipe for target 'all' failed
> make: *** [all] Error 2
> make: Leaving directory '/git/linux/tools/perf'
> + exit 1
> [perfbuilder@five ~]$
> 
>    69    27.21 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
>    70    29.40 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
>    71    29.56 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
>    72    63.55 ubuntu:18.04-x-riscv64        : FAIL riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
> 
> [perfbuilder@five ~]$ tail -20 dm.log/ubuntu\:18.04-x-riscv64
>    CC       /tmp/build/perf/util/parse-events-flex.o
>    LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
>    LD       /tmp/build/perf/util/perf-in.o
>    LD       /tmp/build/perf/perf-in.o
>    LINK     /tmp/build/perf/perf
> /tmp/build/perf/perf-in.o: In function `replace_android_lib':
> /git/linux/tools/perf/util/map.c:45: undefined reference to `pmu_sys_event_tables'
> /git/linux/tools/perf/util/map.c:47: undefined reference to `pmu_sys_event_tables'
> /tmp/build/perf/perf-in.o: In function `snprintf':
> /usr/riscv64-linux-gnu/include/bits/stdio2.h:64: undefined reference to `pmu_sys_event_tables'
> /usr/riscv64-linux-gnu/include/bits/stdio2.h:64: undefined reference to `pmu_sys_event_tables'
> collect2: error: ld returned 1 exit status
> Makefile.perf:659: recipe for target '/tmp/build/perf/perf' failed
> make[2]: *** [/tmp/build/perf/perf] Error 1
> Makefile.perf:232: recipe for target 'sub-make' failed
> make[1]: *** [sub-make] Error 2
> Makefile:69: recipe for target 'all' failed
> make: *** [all] Error 2
> make: Leaving directory '/git/linux/tools/perf'
> + exit 1
> [perfbuilder@five ~]$
> 
>    73    24.68 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
>    74    13.29 ubuntu:18.04-x-sh4            : FAIL sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
> 
> [perfbuilder@five ~]$ tail -20 dm.log/ubuntu\:18.04-x-sh4
>    CC       /tmp/build/perf/util/pmu-flex.o
>    CC       /tmp/build/perf/util/expr-flex.o
>    CC       /tmp/build/perf/util/expr.o
>    LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
>    LD       /tmp/build/perf/util/perf-in.o
>    LD       /tmp/build/perf/perf-in.o
>    LINK     /tmp/build/perf/perf
> /tmp/build/perf/perf-in.o: In function `pmu_for_each_sys_event':
> /git/linux/tools/perf/util/pmu.c:840: undefined reference to `pmu_sys_event_tables'
> /tmp/build/perf/perf-in.o: In function `perf_pmu__find':
> /git/linux/tools/perf/util/pmu.c:1031: undefined reference to `pmu_sys_event_tables'
> collect2: error: ld returned 1 exit status
> Makefile.perf:659: recipe for target '/tmp/build/perf/perf' failed
> make[2]: *** [/tmp/build/perf/perf] Error 1
> Makefile.perf:232: recipe for target 'sub-make' failed
> make[1]: *** [sub-make] Error 2
> Makefile:69: recipe for target 'all' failed
> make: *** [all] Error 2
> make: Leaving directory '/git/linux/tools/perf'
> + exit 1
> [perfbuilder@five ~]$
> 
>    75    12.49 ubuntu:18.04-x-sparc64        : FAIL sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
> 
> [perfbuilder@five ~]$ tail -20 dm.log/ubuntu\:18.04-x-sparc64
>    LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
>    LD       /tmp/build/perf/util/perf-in.o
>    LD       /tmp/build/perf/perf-in.o
>    LINK     /tmp/build/perf/perf
> /tmp/build/perf/perf-in.o: In function `pmu_for_each_sys_event':
> /git/linux/tools/perf/util/pmu.c:816: undefined reference to `pmu_sys_event_tables'
> /git/linux/tools/perf/util/pmu.c:816: undefined reference to `pmu_sys_event_tables'
> /tmp/build/perf/perf-in.o: In function `pmu_add_sys_aliases':
> /git/linux/tools/perf/util/pmu.c:886: undefined reference to `pmu_sys_event_tables'
> /tmp/build/perf/perf-in.o: In function `pmu_uncore_alias_match':
> /git/linux/tools/perf/util/pmu.c:732: undefined reference to `pmu_sys_event_tables'
> collect2: error: ld returned 1 exit status
> Makefile.perf:659: recipe for target '/tmp/build/perf/perf' failed
> make[2]: *** [/tmp/build/perf/perf] Error 1
> Makefile.perf:232: recipe for target 'sub-make' failed
> make[1]: *** [sub-make] Error 2
> Makefile:69: recipe for target 'all' failed
> make: *** [all] Error 2
> make: Leaving directory '/git/linux/tools/perf'
> + exit 1
> [perfbuilder@five ~]$
> 
>    76    69.65 ubuntu:19.10                  : Ok   gcc (Ubuntu 9.2.1-9ubuntu2) 9.2.1 20191008, clang version 8.0.1-3build1 (tags/RELEASE_801/final)
>    77    13.58 ubuntu:19.10-x-alpha          : FAIL alpha-linux-gnu-gcc (Ubuntu 9.2.1-9ubuntu1) 9.2.1 20191008
> 
> [perfbuilder@five ~]$ tail -20 dm.log/ubuntu\:19.10-x-alpha
>    CC       /tmp/build/perf/util/expr-bison.o
>    CC       /tmp/build/perf/util/parse-events.o
>    CC       /tmp/build/perf/util/parse-events-flex.o
>    CC       /tmp/build/perf/util/expr-flex.o
>    CC       /tmp/build/perf/util/expr.o
>    CC       /tmp/build/perf/util/pmu.o
>    CC       /tmp/build/perf/util/pmu-flex.o
>    LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
>    LD       /tmp/build/perf/util/perf-in.o
>    LD       /tmp/build/perf/perf-in.o
>    LINK     /tmp/build/perf/perf
> /usr/lib/gcc-cross/alpha-linux-gnu/9/../../../../alpha-linux-gnu/bin/ld: /tmp/build/perf/perf-in.o: in function `pmu_for_each_sys_event':
> /git/linux/tools/perf/util/pmu.c:825: undefined reference to `pmu_sys_event_tables'
> /usr/lib/gcc-cross/alpha-linux-gnu/9/../../../../alpha-linux-gnu/bin/ld: /git/linux/tools/perf/util/pmu.c:825: undefined reference to `pmu_sys_event_tables'
> collect2: error: ld returned 1 exit status
> make[2]: *** [Makefile.perf:659: /tmp/build/perf/perf] Error 1
> make[1]: *** [Makefile.perf:233: sub-make] Error 2
> make: *** [Makefile:70: all] Error 2
> make: Leaving directory '/git/linux/tools/perf'
> + exit 1
> [perfbuilder@five ~]$
> 
>    78    12.64 ubuntu:19.10-x-hppa           : FAIL hppa-linux-gnu-gcc (Ubuntu 9.2.1-9ubuntu1) 9.2.1 20191008
> 
> [perfbuilder@five ~]$ tail -20 dm.log/ubuntu\:19.10-x-hppa
>    CC       /tmp/build/perf/util/pmu.o
>    CC       /tmp/build/perf/util/pmu-flex.o
>    CC       /tmp/build/perf/util/expr-flex.o
>    LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
>    LD       /tmp/build/perf/util/perf-in.o
>    LD       /tmp/build/perf/perf-in.o
>    LINK     /tmp/build/perf/perf
> /usr/lib/gcc-cross/hppa-linux-gnu/9/../../../../hppa-linux-gnu/bin/ld: /tmp/build/perf/perf-in.o: in function `pmu_for_each_sys_event':
> /git/linux/tools/perf/util/pmu.c:825: undefined reference to `pmu_sys_event_tables'
> /usr/lib/gcc-cross/hppa-linux-gnu/9/../../../../hppa-linux-gnu/bin/ld: /git/linux/tools/perf/util/pmu.c:825: undefined reference to `pmu_sys_event_tables'
> /usr/lib/gcc-cross/hppa-linux-gnu/9/../../../../hppa-linux-gnu/bin/ld: /tmp/build/perf/perf-in.o: in function `pmu_add_sys_aliases':
> /git/linux/tools/perf/util/pmu.c:886: undefined reference to `pmu_sys_event_tables'
> /usr/lib/gcc-cross/hppa-linux-gnu/9/../../../../hppa-linux-gnu/bin/ld: /tmp/build/perf/perf-in.o: in function `pmu_for_each_sys_event':
> /git/linux/tools/perf/util/pmu.c:825: undefined reference to `pmu_sys_event_tables'
> collect2: error: ld returned 1 exit status
> make[2]: *** [Makefile.perf:659: /tmp/build/perf/perf] Error 1
> make[1]: *** [Makefile.perf:233: sub-make] Error 2
> make: *** [Makefile:70: all] Error 2
> make: Leaving directory '/git/linux/tools/perf'
> + exit 1
> [perfbuilder@five ~]$
> 
>    79    75.25 ubuntu:20.04                  : Ok   gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, clang version 10.0.0-4ubuntu1
>    80    31.39 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.2.0-5ubuntu1~20.04) 10.2.0
>    81    75.09 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.2.0-13ubuntu1) 10.2.0, Ubuntu clang version 11.0.0-2
> .


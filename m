Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E700D2D63EC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392780AbgLJRqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:46:16 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2243 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392031AbgLJRqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:46:16 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CsLqX0whXz67Nvk;
        Fri, 11 Dec 2020 01:43:20 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 10 Dec 2020 18:45:27 +0100
Received: from [10.210.172.228] (10.210.172.228) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 10 Dec 2020 17:45:26 +0000
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
From:   John Garry <john.garry@huawei.com>
Message-ID: <30e7907d-868a-a673-59a7-3bb4766093b4@huawei.com>
Date:   Thu, 10 Dec 2020 17:44:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201210172608.GC195565@kernel.org>
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


>>>>>> +				evsel_name = cmd_data + sizeof(EVLIST_CTL_CMD_ENABLE_EVSEL_TAG) - 1;
>>
>>>>> It makes sense to check that evsel_name still points
>>>>> into cmd_data buffer after assigning to event name.
>   
>>>> right, will add that
>   
>>> So, I'm finishing test builds, so probably I'll push the first two
>>> patches publicly and then you can send a patch on top of this, ok?
>   
>>> Unless the tests break somewhere and then I'll have to restart, so I'll
>>> fold in whatever gets at that time...
>   
>> That was quick:
>   
>> [perfbuilder@five ~]$ time dm
>> Thu Dec 10 01:44:52 PM -03 2020
>> # export PERF_TARBALL=http://192.168.86.5/perf/perf-5.10.0-rc6.tar.xz
>> # dm
>>     1    78.47 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0, clang version 3.8.0 (tags/RELEASE_380/final)
>>     2   104.38 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822, clang version 3.8.1 (tags/RELEASE_381/final)
>>     3   105.64 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0, clang version 4.0.0 (tags/RELEASE_400/final)
>>     4    96.52 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
>>     5    81.08 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
>>     6    85.20 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
>>     7   106.10 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
>>     8   120.20 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0, Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
>>     9   109.99 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0, Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
>>    10   117.76 alpine:edge                   : Ok   gcc (Alpine 10.2.0) 10.2.0, Alpine clang version 10.0.1
>>    11    69.15 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1), clang version 3.8.0 (tags/RELEASE_380/final)
>>    12    84.55 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1), clang version 10.0.0
>>    13    82.69 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 9.3.1 20200518 (ALT Sisyphus 9.3.1-alt1), clang version 10.0.1
>>    14    66.22 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2), clang version 3.6.2 (tags/RELEASE_362/final)
>>    15   100.16 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-9), clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
>>    16    11.20 android-ndk:r12b-arm          : FAIL arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>>    17    11.90 android-ndk:r15c-arm          : FAIL arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>>    18    26.33 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
>>    19    31.80 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-44)
>>    20   116.02 centos:8                      : Ok   gcc (GCC) 8.3.1 20191121 (Red Hat 8.3.1-5), clang version 9.0.1 (Red Hat 9.0.1-2.module_el8.2.0+309+0c7b6b03)
>>    21    62.27 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 10.2.1 20201106 releases/gcc-10.2.0-475-g099857318c, clang version 10.0.1
>>    22    77.82 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
>>    23: debian:9
>>
>>
>> There I go...
>>
>> [perfbuilder@five ~]$ tail -20 dm.log/android-ndk\:r12b-arm
>>    FLEX     /tmp/build/perf/util/expr-flex.c
>>    CC       /tmp/build/perf/util/pmu-bison.o
>>    CC       /tmp/build/perf/util/expr-bison.o
>>    CC       /tmp/build/perf/util/expr-flex.o
>>    CC       /tmp/build/perf/util/expr.o
>>    CC       /tmp/build/perf/util/parse-events.o
>>    CC       /tmp/build/perf/util/parse-events-flex.o
>>    CC       /tmp/build/perf/util/pmu.o
>>    CC       /tmp/build/perf/util/pmu-flex.o
>>    LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
>>    LD       /tmp/build/perf/util/perf-in.o
>>    LD       /tmp/build/perf/perf-in.o
>>    LINK     /tmp/build/perf/perf
>> /tmp/build/perf/perf-in.o:hist.c:function pmu_for_each_sys_event: error: undefined reference to 'pmu_sys_event_tables'
>> collect2: error: ld returned 1 exit status
>> make[2]: *** [Makefile.perf:659: /tmp/build/perf/perf] Error 1
>> make[1]: *** [Makefile.perf:233: sub-make] Error 2
>> make: *** [Makefile:70: all] Error 2
>> make: Leaving directory '/git/linux/tools/perf'
>> + exit 1
>> [perfbuilder@five ~]
>>
>> Now to figure out who generates this pmu_sys_event_tables, John?
> 
> One more:
> 
> [perfbuilder@five ~]$ tail -20 dm.log/debian\:experimental-x-mips64
>    CC       /tmp/build/perf/util/expr-bison.o
>    CC       /tmp/build/perf/util/parse-events.o
>    CC       /tmp/build/perf/util/pmu.o
>    CC       /tmp/build/perf/util/parse-events-flex.o
>    CC       /tmp/build/perf/util/pmu-flex.o
>    CC       /tmp/build/perf/util/expr-flex.o
>    CC       /tmp/build/perf/util/expr.o
>    LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
>    LD       /tmp/build/perf/util/perf-in.o
>    LD       /tmp/build/perf/perf-in.o
>    LINK     /tmp/build/perf/perf
> /usr/lib/gcc-cross/mips64-linux-gnuabi64/9/../../../../mips64-linux-gnuabi64/bin/ld: /tmp/build/perf/perf-in.o: in function `pmu_for_each_sys_event':
> /git/linux/tools/perf/util/pmu.c:825: undefined reference to `pmu_sys_event_tables'
> /usr/lib/gcc-cross/mips64-linux-gnuabi64/9/../../../../mips64-linux-gnuabi64/bin/ld: /git/linux/tools/perf/util/pmu.c:825: undefined reference to `pmu_sys_event_tables'
> collect2: error: ld returned 1 exit status
> make[2]: *** [Makefile.perf:659: /tmp/build/perf/perf] Error 1
> make[1]: *** [Makefile.perf:233: sub-make] Error 2
> make: *** [Makefile:70: all] Error 2
> make: Leaving directory '/git/linux/tools/perf'
> + exit 1
> [perfbuilder@five ~]$
> 
> And another:
> 
> [perfbuilder@five ~]$ tail -20 dm.log/fedora:24-x-ARC-uClibc
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

Hi Arnaldo,

I'm not sure what is going on here.

So symbol 'pmu_sys_event_tables' is introduced in 
https://lore.kernel.org/linux-arm-kernel/1607080216-36968-3-git-send-email-john.garry@huawei.com/, 
but I did not think that you picked any of this series up yet, right?

I checked your perf/core branch, and no sign, so which git/branch is this?

Thanks,
John

> So far all the cross builds failed.
> 
> - Arnaldo
> .
> 


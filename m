Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697C1270B66
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 09:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgISHW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 03:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgISHW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 03:22:57 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE51C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 00:22:57 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id e4so4164744pln.10
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 00:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IvmPAxgP+DvXbMkceAYl+KYSZpO0LaK7GZqVCMHGftc=;
        b=QDoEUzO4+TSzn+OC+O8mO8r/j5qpSjKCtSvXjB/jd1fWy6fLA2nLzsjPIaJRrGUJ69
         2TMI/AoPobnFlT5TzNMtx+m7zgklvlLPk3NX76XJzZxBAZRL2CJ6G6zl/7lo+kkqYHwC
         UeTAYSS90yobpXZitTxV/2I8f3kM/p2YDCAqhjUQYtoF2NUU7fJFbF9xK+9lqjuMAo0l
         BIzzSNYQJibo4aBMJfpD/0kWBLExnEIhbKg5bIdi7TITRWrqlZIgFszRjc5yGl2IzYgc
         rlvfd2YuvlR0QXqT3IRFs8m3uVfl/nWXa5llsH3XkGLAWkrXY0oVkqjKdoIob7HwjMg/
         V0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IvmPAxgP+DvXbMkceAYl+KYSZpO0LaK7GZqVCMHGftc=;
        b=blJamaCm+3FXPrATn+p8SrIGmgaN7gHKiSc6NjJxII6Io37jdBcgOt0vLMRR0SmySt
         tzJsBCGVRZFBftPLrXWTKX8Qerbe5FkfTHO+tuiij3zwaQZhqfa0kuRIhq+tU6wlgarC
         QgufY81B86H+x1XfzgXK/MBOhWP3FZ9KkOiKdPXW//RkkSlaboXmspolD5vejYbkYILb
         i8Vi3YH8rPjDIyji/Fyxj1AhAcaqLe2s1XA91WgT2F4/pLb1uDdSl2sq0YJbpeCvXb6t
         wdAvEm0+7EFDxRzo5RdXMf40aIYIKxdeVbIDVBvkR1jVkEBJwMTR1BycLFfb30NFjGp5
         ykKQ==
X-Gm-Message-State: AOAM530C74c3b74AB7+k1XwOpZgoyrbNYmmnYOUzKTnhdXEchCxEVmx8
        NeaI++/KL0bRoST7dCiWUkGIdHI9BejGNUwCMdQ=
X-Google-Smtp-Source: ABdhPJxmYugTnUFuQ/jv1aQbmXoHOJnJ72E4Arbfa38T/9iSOt7Oacn0o4v9TESgZ5arXGKIfE+jA6I6P9MOvO+y7uU=
X-Received: by 2002:a17:902:b716:b029:d1:e598:400c with SMTP id
 d22-20020a170902b716b02900d1e598400cmr18602735pls.70.1600500176674; Sat, 19
 Sep 2020 00:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200911215118.2887710-1-robh@kernel.org> <20200912205317.GG1714160@krava>
 <CAL_JsqKwMh9=ppdbY0sAQ8C--aH_XcJR3G4YCq7afAHnfTF9fw@mail.gmail.com>
 <CANW9uytmafiNb_8oua9QY7L9O5BQTBFQBOMS3ZgjQ7aWj8CD2Q@mail.gmail.com> <CAL_JsqLze6DUD4ewV9uh1KDRz0daDUk0aT7y-Dj8+MjFF+LQgw@mail.gmail.com>
In-Reply-To: <CAL_JsqLze6DUD4ewV9uh1KDRz0daDUk0aT7y-Dj8+MjFF+LQgw@mail.gmail.com>
From:   Itaru Kitayama <itaru.kitayama@gmail.com>
Date:   Sat, 19 Sep 2020 16:22:45 +0900
Message-ID: <CANW9uyu_q=xd-nG==GeDrxkwBSu1EycaSKJnm5LH4=K4gh8PPw@mail.gmail.com>
Subject: Re: [PATCH v3 0/10] libperf and arm64 userspace counter access support
To:     Rob Herring <robh@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,
V3 fails to build on ThunderX2:

$ make
  BUILD:   Doing 'make -j224' parallel build

Auto-detecting system features:
...                         dwarf: [ on  ]
...            dwarf_getlocations: [ on  ]
...                         glibc: [ on  ]
...                          gtk2: [ OFF ]
...                        libbfd: [ on  ]
...                        libcap: [ on  ]
...                        libelf: [ on  ]
...                       libnuma: [ on  ]
...        numa_num_possible_cpus: [ on  ]
...                       libperl: [ on  ]
...                     libpython: [ on  ]
...                     libcrypto: [ on  ]
...                     libunwind: [ OFF ]
...            libdw-dwarf-unwind: [ on  ]
...                          zlib: [ on  ]
...                          lzma: [ on  ]
...                     get_cpuid: [ OFF ]
...                           bpf: [ on  ]
...                        libaio: [ on  ]
...                       libzstd: [ on  ]
...        disassembler-four-args: [ on  ]

Makefile.config:604: No libunwind found. Please install
libunwind-dev[el] >=3D 1.1 and/or set LIBUNWIND_DIR
Makefile.config:730: GTK2 not found, disables GTK2 support. Please
install gtk2-devel or libgtk2.0-dev
Makefile.config:965: No libbabeltrace found, disables 'perf data' CTF
format support, please install
libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:1009: No openjdk development package found, please
install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
  CC       arch/arm64/tests/user-events.o
  CC       arch/arm64/tests/arch-tests.o
In file included from arch/arm64/tests/arch-tests.c:4:
/home/users/itaru.kitayama/projects/linux/tools/perf/arch/arm64/include/arc=
h-tests.h:10:5:
error: redundant redeclaration of =E2=80=98test__arch_unwind_sample=E2=80=
=99
[-Werror=3Dredundant-decls]
 int test__arch_unwind_sample(struct perf_sample *sample,
     ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from arch/arm64/tests/arch-tests.c:3:
/home/users/itaru.kitayama/projects/linux/tools/perf/tests/tests.h:134:5:
note: previous declaration of =E2=80=98test__arch_unwind_sample=E2=80=99 wa=
s here
 int test__arch_unwind_sample(struct perf_sample *sample,
     ^~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/users/itaru.kitayama/projects/linux/tools/build/Makefil=
e.build:97:
arch/arm64/tests/arch-tests.o] Error 1
make[6]: *** Waiting for unfinished jobs....
In file included from arch/arm64/tests/user-events.c:13:
/home/users/itaru.kitayama/projects/linux/tools/perf/arch/arm64/include/arc=
h-tests.h:10:5:
error: redundant redeclaration of =E2=80=98test__arch_unwind_sample=E2=80=
=99
[-Werror=3Dredundant-decls]
 int test__arch_unwind_sample(struct perf_sample *sample,
     ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from arch/arm64/tests/user-events.c:12:
/home/users/itaru.kitayama/projects/linux/tools/perf/tests/tests.h:134:5:
note: previous declaration of =E2=80=98test__arch_unwind_sample=E2=80=99 wa=
s here
 int test__arch_unwind_sample(struct perf_sample *sample,
     ^~~~~~~~~~~~~~~~~~~~~~~~
arch/arm64/tests/user-events.c: In function =E2=80=98perf_init=E2=80=99:
arch/arm64/tests/user-events.c:106:7: error: too few arguments to
function =E2=80=98perf_evsel__mmap=E2=80=99
  if (!perf_evsel__mmap(evsel)) {
       ^~~~~~~~~~~~~~~~
In file included from arch/arm64/tests/user-events.c:8:
/home/users/itaru.kitayama/projects/linux/tools/lib/perf/include/perf/evsel=
.h:31:19:
note: declared here
 LIBPERF_API void *perf_evsel__mmap(struct perf_evsel *evsel, size_t length=
);
                   ^~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/users/itaru.kitayama/projects/linux/tools/build/Makefil=
e.build:97:
arch/arm64/tests/user-events.o] Error 1
make[5]: *** [/home/users/itaru.kitayama/projects/linux/tools/build/Makefil=
e.build:139:
tests] Error 2
make[4]: *** [/home/users/itaru.kitayama/projects/linux/tools/build/Makefil=
e.build:139:
arm64] Error 2
make[3]: *** [/home/users/itaru.kitayama/projects/linux/tools/build/Makefil=
e.build:139:
arch] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [Makefile.perf:634: perf-in.o] Error 2
make[1]: *** [Makefile.perf:233: sub-make] Error 2
make: *** [Makefile:70: all] Error 2

On Wed, Sep 16, 2020 at 11:50 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Sep 14, 2020 at 5:14 PM Itaru Kitayama <itaru.kitayama@gmail.com>=
 wrote:
> >
> > Could you point us to your repo too?
>
> Sure, pushed a branch here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git user-perf-ev=
ent-v3
>
> Rob

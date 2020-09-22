Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CC927452D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgIVPYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:24:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgIVPYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:24:11 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 306D523A1E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 15:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600788250;
        bh=e5nNSXIlKC0+0HLOYhCcAxr1si+g6JGN4VtZFVkR9Vk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n2Ypq+FfMntZF9CFO+lVW9VdkBYAGGOwNR6LVG/autyVLsvwaKEs6aBQhxojm2C2L
         UcMpQF197/hnT2hq7dXmV47ziO6bL9qn51Np4KjpK2bQa96soLAmg8rmNXiZGhOgWp
         CW9vVcM1iHdF9sfl7VArZ90sI3zk/sSJKLbDo4cY=
Received: by mail-oi1-f173.google.com with SMTP id 185so21422406oie.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:24:10 -0700 (PDT)
X-Gm-Message-State: AOAM5303g2rScdENYu8YaZB8yxJu7iqt2ZQavNVRAJDFeEwWhqqkJxiT
        Wp2pr4Tn8R+Q4gZ71wUpKlHPNhdmEmNHYBaENg==
X-Google-Smtp-Source: ABdhPJxVLFUeTweccHqZxu+6KovZTVaLWOobJyvUNUc6kPB6ly157GvO2OSpqp7P/YtIFPEqORvQ+5hCZI4btXkmpY8=
X-Received: by 2002:aca:fc07:: with SMTP id a7mr2963229oii.106.1600788249510;
 Tue, 22 Sep 2020 08:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200911215118.2887710-1-robh@kernel.org> <20200912205317.GG1714160@krava>
 <CAL_JsqKwMh9=ppdbY0sAQ8C--aH_XcJR3G4YCq7afAHnfTF9fw@mail.gmail.com>
 <CANW9uytmafiNb_8oua9QY7L9O5BQTBFQBOMS3ZgjQ7aWj8CD2Q@mail.gmail.com>
 <CAL_JsqLze6DUD4ewV9uh1KDRz0daDUk0aT7y-Dj8+MjFF+LQgw@mail.gmail.com> <CANW9uyu_q=xd-nG==GeDrxkwBSu1EycaSKJnm5LH4=K4gh8PPw@mail.gmail.com>
In-Reply-To: <CANW9uyu_q=xd-nG==GeDrxkwBSu1EycaSKJnm5LH4=K4gh8PPw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 22 Sep 2020 09:23:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKsr_0Maiv3CJy2UcjhNB_6bZ_wrgzGyUT_MTQj1KzZRQ@mail.gmail.com>
Message-ID: <CAL_JsqKsr_0Maiv3CJy2UcjhNB_6bZ_wrgzGyUT_MTQj1KzZRQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/10] libperf and arm64 userspace counter access support
To:     Itaru Kitayama <itaru.kitayama@gmail.com>
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

On Sat, Sep 19, 2020 at 1:22 AM Itaru Kitayama <itaru.kitayama@gmail.com> w=
rote:
>
> Rob,
> V3 fails to build on ThunderX2:
>
> $ make
>   BUILD:   Doing 'make -j224' parallel build
>
> Auto-detecting system features:
> ...                         dwarf: [ on  ]
> ...            dwarf_getlocations: [ on  ]
> ...                         glibc: [ on  ]
> ...                          gtk2: [ OFF ]
> ...                        libbfd: [ on  ]
> ...                        libcap: [ on  ]
> ...                        libelf: [ on  ]
> ...                       libnuma: [ on  ]
> ...        numa_num_possible_cpus: [ on  ]
> ...                       libperl: [ on  ]
> ...                     libpython: [ on  ]
> ...                     libcrypto: [ on  ]
> ...                     libunwind: [ OFF ]
> ...            libdw-dwarf-unwind: [ on  ]
> ...                          zlib: [ on  ]
> ...                          lzma: [ on  ]
> ...                     get_cpuid: [ OFF ]
> ...                           bpf: [ on  ]
> ...                        libaio: [ on  ]
> ...                       libzstd: [ on  ]
> ...        disassembler-four-args: [ on  ]
>
> Makefile.config:604: No libunwind found. Please install

I believe this is an existing problem with your setup?

> libunwind-dev[el] >=3D 1.1 and/or set LIBUNWIND_DIR
> Makefile.config:730: GTK2 not found, disables GTK2 support. Please
> install gtk2-devel or libgtk2.0-dev
> Makefile.config:965: No libbabeltrace found, disables 'perf data' CTF
> format support, please install
> libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> Makefile.config:1009: No openjdk development package found, please
> install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
>   CC       arch/arm64/tests/user-events.o
>   CC       arch/arm64/tests/arch-tests.o
> In file included from arch/arm64/tests/arch-tests.c:4:
> /home/users/itaru.kitayama/projects/linux/tools/perf/arch/arm64/include/a=
rch-tests.h:10:5:
> error: redundant redeclaration of =E2=80=98test__arch_unwind_sample=E2=80=
=99
> [-Werror=3Dredundant-decls]
>  int test__arch_unwind_sample(struct perf_sample *sample,
>      ^~~~~~~~~~~~~~~~~~~~~~~~
> In file included from arch/arm64/tests/arch-tests.c:3:
> /home/users/itaru.kitayama/projects/linux/tools/perf/tests/tests.h:134:5:
> note: previous declaration of =E2=80=98test__arch_unwind_sample=E2=80=99 =
was here
>  int test__arch_unwind_sample(struct perf_sample *sample,
>      ^~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[6]: *** [/home/users/itaru.kitayama/projects/linux/tools/build/Makef=
ile.build:97:
> arch/arm64/tests/arch-tests.o] Error 1
> make[6]: *** Waiting for unfinished jobs....
> In file included from arch/arm64/tests/user-events.c:13:
> /home/users/itaru.kitayama/projects/linux/tools/perf/arch/arm64/include/a=
rch-tests.h:10:5:
> error: redundant redeclaration of =E2=80=98test__arch_unwind_sample=E2=80=
=99
> [-Werror=3Dredundant-decls]
>  int test__arch_unwind_sample(struct perf_sample *sample,
>      ^~~~~~~~~~~~~~~~~~~~~~~~
> In file included from arch/arm64/tests/user-events.c:12:
> /home/users/itaru.kitayama/projects/linux/tools/perf/tests/tests.h:134:5:
> note: previous declaration of =E2=80=98test__arch_unwind_sample=E2=80=99 =
was here
>  int test__arch_unwind_sample(struct perf_sample *sample,
>      ^~~~~~~~~~~~~~~~~~~~~~~~

These are due to the above issue.

> arch/arm64/tests/user-events.c: In function =E2=80=98perf_init=E2=80=99:
> arch/arm64/tests/user-events.c:106:7: error: too few arguments to
> function =E2=80=98perf_evsel__mmap=E2=80=99
>   if (!perf_evsel__mmap(evsel)) {

I forgot to update this test. Should be 'perf_evsel__mmap(evsel,
SZ_4K)' here, but that's going to change to 'perf_evsel__mmap(evsel,
0)' with it changing from bytes to pages (minus 1).

Rob

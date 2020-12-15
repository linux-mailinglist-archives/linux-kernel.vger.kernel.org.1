Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2022DAE3D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 14:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgLONoX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Dec 2020 08:44:23 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41863 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgLONoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:44:01 -0500
Received: by mail-lf1-f68.google.com with SMTP id s26so4760979lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 05:43:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dfuHyBcLUhZWK5XF1Usyk52lYgn4b/9OJ2Y1bNxBzKo=;
        b=EADAd2+r70Uj5JDOkdJJ3SER+U2osBc2KGtZVUjPIYaGZM8Usa/hTpiRT6HkXj7wC7
         E1qFFm11vaqpxmEcn9tjqN8ortzeyPL1JA8Sw1a60auFKFvEY/WEaFLzpO1arH2Iu0Uq
         DUu8sdiWTF8tYENmbSXE2y9TnmhBx0WXGOZYry9/4ATyC7Lh67xC4+wZ0Tp1u8n6WaVI
         8PWuMNVD/d1D5w2X0vzReW7E9P31PqzcvBujZ3/4VUxNzpkn6JfjMgI2Yt9nl1nm5w5J
         rux19EDvo+mPKiy5bfk/j1vrrakAseodfPHn9gPfdnyMT8wdC7J1DAWc1impfEjfBdyk
         PfVw==
X-Gm-Message-State: AOAM530IGx4Rcjs1wxQ+NNDJkgcBLsrSOLGb85d7fizX/uzX3B36uiU5
        woFsuwnswUBf1t/gY4cGcx+tpx3cNrW97V8vAr/qxgbQ
X-Google-Smtp-Source: ABdhPJzXpuU/WX6TvfkxuxUnxyyRDcK35iNa4WGJbhyqPBGeJvqP8Ba9kxJtVru270g09OYKt/MfUbV5gpA0s/ydoOU=
X-Received: by 2002:a19:6e0e:: with SMTP id j14mr12437551lfc.374.1608039798310;
 Tue, 15 Dec 2020 05:43:18 -0800 (PST)
MIME-Version: 1.0
References: <20201214105457.543111-1-jolsa@kernel.org>
In-Reply-To: <20201214105457.543111-1-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 15 Dec 2020 22:43:07 +0900
Message-ID: <CAM9d7cgN9TYSM-PQrehN8BPmR7s52WoRCqat4SbPbrhQBp+Tog@mail.gmail.com>
Subject: Re: [PATCHv5 00/15] perf: Add mmap2 build id support
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Frank Ch . Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Mon, Dec 14, 2020 at 7:55 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> adding the support to have buildid stored in mmap2 event,
> so we can bypass the final perf record hunt on build ids.
>
> This patchset allows perf to record build ID in mmap2 event,
> and adds perf tooling to store/download binaries to .debug
> cache based on these build IDs.
>
> Note that the build id retrieval code is stolen from bpf
> code, where it's been used (together with file offsets)
> to replace IPs in user space stack traces. It's now added
> under lib directory.

Thanks for doing this!

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
> v5 changes:
>   - rebased on latest perf/core
>   - several patches already pulled in
>   - fixed trace+probe_vfs_getname.sh output redirection
>   - fixed changelogs [Arnaldo]
>   - renamed BUILD_ID_SIZE to BUILD_ID_SIZE_MAX [Song]
>
> v4 changes:
>   - fixed typo in changelog [Namhyung]
>   - removed force_download bool from struct dso_store_data,
>     because it's not used  [Namhyung]
>
> v3 changes:
>   - added acks
>   - removed forgotten debug code [Arnaldo]
>   - fixed readlink termination [Ian]
>   - fixed doc for --debuginfod=URLs [Ian]
>   - adopted kernel's memchr_inv function and used
>     it in build_id__is_defined function [Arnaldo]
>
> On recording server:
>
>   - on the recording server we can run record with --buildid-mmap
>     option to store build ids in mmap2 events:
>
>     # perf record --buildid-mmap
>     ^C[ perf record: Woken up 2 times to write data ]
>     [ perf record: Captured and wrote 0.836 MB perf.data ]
>
>   - it stores nothing to ~/.debug cache:
>
>     # find ~/.debug
>     find: ‘/root/.debug’: No such file or directory
>
>   - and still reports properly:
>
>     # perf report --stdio
>     ...
>     99.82%  swapper          [kernel.kallsyms]  [k] native_safe_halt
>      0.03%  swapper          [kernel.kallsyms]  [k] finish_task_switch
>      0.02%  swapper          [kernel.kallsyms]  [k] __softirqentry_text_start
>      0.01%  kcompactd0       [kernel.kallsyms]  [k] _raw_spin_unlock_irqrestore
>      0.01%  ksoftirqd/6      [kernel.kallsyms]  [k] slab_free_freelist_hook
>      0.01%  kworker/17:1H-x  [kernel.kallsyms]  [k] slab_free_freelist_hook
>
>   - display used/hit build ids:
>
>     # perf buildid-list | head -5
>     5dcec522abf136fcfd3128f47e131f2365834dd7 /proc/kcore
>     589e403a34f55486bcac848a45e00bcdeedd1ca8 /usr/lib64/libcrypto.so.1.1.1g
>     94569566d4eac7e9c87ba029d43d4e2158f9527e /usr/lib64/libpthread-2.30.so
>     559b9702bebe31c6d132c8dc5cc887673d65d5b5 /usr/lib64/libc-2.30.so
>     40da7abe89f631f60538a17686a7d65c6a02ed31 /usr/lib64/ld-2.30.so
>
>   - store build id binaries into build id cache:
>
>     # perf buildid-cache -a perf.data
>     OK   5dcec522abf136fcfd3128f47e131f2365834dd7 /proc/kcore
>     OK   589e403a34f55486bcac848a45e00bcdeedd1ca8 /usr/lib64/libcrypto.so.1.1.1g
>     OK   94569566d4eac7e9c87ba029d43d4e2158f9527e /usr/lib64/libpthread-2.30.so
>     OK   559b9702bebe31c6d132c8dc5cc887673d65d5b5 /usr/lib64/libc-2.30.so
>     OK   40da7abe89f631f60538a17686a7d65c6a02ed31 /usr/lib64/ld-2.30.so
>     OK   a674f7a47c78e35a088104647b9640710277b489 /usr/sbin/sshd
>     OK   e5cb4ca25f46485bdbc691c3a92e7e111dac3ef2 /usr/bin/bash
>     OK   9bc8589108223c944b452f0819298a0c3cba6215 /usr/bin/find
>
>     # find ~/.debug | head -5
>     /root/.debug
>     /root/.debug/proc
>     /root/.debug/proc/kcore
>     /root/.debug/proc/kcore/5dcec522abf136fcfd3128f47e131f2365834dd7
>     /root/.debug/proc/kcore/5dcec522abf136fcfd3128f47e131f2365834dd7/kallsyms
>
>   - run debuginfod daemon to provide binaries to another server (below)
>     (the initialization could take some time)
>
>     # debuginfod -F /
>
>
> On another server:
>
>   - copy perf.data from 'record' server and run:
>
>     $ find ~/.debug/
>     find: ‘/home/jolsa/.debug/’: No such file or directory
>
>     $ perf buildid-list | head -5
>     No kallsyms or vmlinux with build-id 5dcec522abf136fcfd3128f47e131f2365834dd7 was found
>     5dcec522abf136fcfd3128f47e131f2365834dd7 [kernel.kallsyms]
>     5784f813b727a50cfd3363234aef9fcbab685cc4 /lib/modules/5.10.0-rc2speed+/kernel/fs/xfs/xfs.ko
>     589e403a34f55486bcac848a45e00bcdeedd1ca8 /usr/lib64/libcrypto.so.1.1.1g
>     94569566d4eac7e9c87ba029d43d4e2158f9527e /usr/lib64/libpthread-2.30.so
>     559b9702bebe31c6d132c8dc5cc887673d65d5b5 /usr/lib64/libc-2.30.so
>
>   - report does not show anything (kernel build id does not match):
>
>    $ perf report --stdio
>    ...
>     76.73%  swapper          [kernel.kallsyms]    [k] 0xffffffff81aa8ebe
>      1.89%  find             [kernel.kallsyms]    [k] 0xffffffff810f2167
>      0.93%  sshd             [kernel.kallsyms]    [k] 0xffffffff8153380c
>      0.83%  swapper          [kernel.kallsyms]    [k] 0xffffffff81104b0b
>      0.71%  kworker/u40:2-e  [kernel.kallsyms]    [k] 0xffffffff810f3850
>      0.70%  kworker/u40:0-e  [kernel.kallsyms]    [k] 0xffffffff810f3850
>      0.64%  find             [kernel.kallsyms]    [k] 0xffffffff81a9ba0a
>      0.63%  find             [kernel.kallsyms]    [k] 0xffffffff81aa93b0
>
>   - add build ids does not work, because existing binaries (on another server)
>     have different build ids:
>
>     $ perf buildid-cache -a perf.data
>     No kallsyms or vmlinux with build-id 5dcec522abf136fcfd3128f47e131f2365834dd7 was found
>     FAIL 5dcec522abf136fcfd3128f47e131f2365834dd7 [kernel.kallsyms]
>     FAIL 5784f813b727a50cfd3363234aef9fcbab685cc4 /lib/modules/5.10.0-rc2speed+/kernel/fs/xfs/xfs.ko
>     FAIL 589e403a34f55486bcac848a45e00bcdeedd1ca8 /usr/lib64/libcrypto.so.1.1.1g
>     FAIL 94569566d4eac7e9c87ba029d43d4e2158f9527e /usr/lib64/libpthread-2.30.so
>     FAIL 559b9702bebe31c6d132c8dc5cc887673d65d5b5 /usr/lib64/libc-2.30.so
>     FAIL 40da7abe89f631f60538a17686a7d65c6a02ed31 /usr/lib64/ld-2.30.so
>     FAIL a674f7a47c78e35a088104647b9640710277b489 /usr/sbin/sshd
>     FAIL e5cb4ca25f46485bdbc691c3a92e7e111dac3ef2 /usr/bin/bash
>     FAIL 9bc8589108223c944b452f0819298a0c3cba6215 /usr/bin/find
>
>   - add build ids with debuginfod setup pointing to record server:
>
>     $ perf buildid-cache -a perf.data --debuginfod http://192.168.122.174:8002
>     No kallsyms or vmlinux with build-id 5dcec522abf136fcfd3128f47e131f2365834dd7 was found
>     OK   5dcec522abf136fcfd3128f47e131f2365834dd7 [kernel.kallsyms]
>     OK   5784f813b727a50cfd3363234aef9fcbab685cc4 /lib/modules/5.10.0-rc2speed+/kernel/fs/xfs/xfs.ko
>     OK   589e403a34f55486bcac848a45e00bcdeedd1ca8 /usr/lib64/libcrypto.so.1.1.1g
>     OK   94569566d4eac7e9c87ba029d43d4e2158f9527e /usr/lib64/libpthread-2.30.so
>     OK   559b9702bebe31c6d132c8dc5cc887673d65d5b5 /usr/lib64/libc-2.30.so
>     OK   40da7abe89f631f60538a17686a7d65c6a02ed31 /usr/lib64/ld-2.30.so
>     OK   a674f7a47c78e35a088104647b9640710277b489 /usr/sbin/sshd
>     OK   e5cb4ca25f46485bdbc691c3a92e7e111dac3ef2 /usr/bin/bash
>     OK   9bc8589108223c944b452f0819298a0c3cba6215 /usr/bin/find
>
>   - and report works:
>
>     $ perf report --stdio
>     ...
>     76.73%  swapper          [kernel.kallsyms]    [k] native_safe_halt
>      1.91%  find             [kernel.kallsyms]    [k] queue_work_on
>      0.93%  sshd             [kernel.kallsyms]    [k] iowrite16
>      0.83%  swapper          [kernel.kallsyms]    [k] finish_task_switch
>      0.72%  kworker/u40:2-e  [kernel.kallsyms]    [k] process_one_work
>      0.70%  kworker/u40:0-e  [kernel.kallsyms]    [k] process_one_work
>      0.64%  find             [kernel.kallsyms]    [k] syscall_enter_from_user_mode
>      0.63%  find             [kernel.kallsyms]    [k] _raw_spin_unlock_irqrestore
>
>   - because we have the data in build id cache:
>
>     $ find ~/.debug | head -10
>     .../.debug
>     .../.debug/home
>     .../.debug/home/jolsa
>     .../.debug/home/jolsa/.cache
>     .../.debug/home/jolsa/.cache/debuginfod_client
>     .../.debug/home/jolsa/.cache/debuginfod_client/5dcec522abf136fcfd3128f47e131f2365834dd7
>     .../.debug/home/jolsa/.cache/debuginfod_client/5dcec522abf136fcfd3128f47e131f2365834dd7/executable
>     .../.debug/home/jolsa/.cache/debuginfod_client/5dcec522abf136fcfd3128f47e131f2365834dd7/executable/5dcec522abf136fcfd3128f47e131f2365834dd7
>     .../.debug/home/jolsa/.cache/debuginfod_client/5dcec522abf136fcfd3128f47e131f2365834dd7/executable/5dcec522abf136fcfd3128f47e131f2365834dd7/elf
>     .../.debug/home/jolsa/.cache/debuginfod_client/5dcec522abf136fcfd3128f47e131f2365834dd7/executable/5dcec522abf136fcfd3128f47e131f2365834dd7/debug
>
>
> Available also in:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/build_id
>
> thanks,
> jirka
>
>
> Cc: Frank Ch. Eigler <fche@redhat.com>
> Cc: Mark Wielaard <mjw@redhat.com>
> ---
>  include/linux/buildid.h                           |  12 +++++
>  include/uapi/linux/perf_event.h                   |  42 +++++++++++++++---
>  kernel/bpf/stackmap.c                             | 143 ++----------------------------------------------------------
>  kernel/events/core.c                              |  32 ++++++++++++--
>  lib/Makefile                                      |   3 +-
>  lib/buildid.c                                     | 149 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/perf_event.h             |  42 +++++++++++++++---
>  tools/lib/perf/include/perf/event.h               |  18 ++++++--
>  tools/perf/Documentation/perf-buildid-cache.txt   |  18 +++++++-
>  tools/perf/Documentation/perf-config.txt          |  10 ++++-
>  tools/perf/Documentation/perf-record.txt          |   3 ++
>  tools/perf/builtin-buildid-cache.c                | 241 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  tools/perf/builtin-buildid-list.c                 |   3 ++
>  tools/perf/builtin-record.c                       |  20 +++++++++
>  tools/perf/tests/shell/trace+probe_vfs_getname.sh |   2 +-
>  tools/perf/util/event.c                           |  41 +++++++++++++-----
>  tools/perf/util/evsel.c                           |  10 +++--
>  tools/perf/util/machine.c                         |  24 +++++++---
>  tools/perf/util/map.c                             |   8 +++-
>  tools/perf/util/map.h                             |   3 +-
>  tools/perf/util/perf_api_probe.c                  |  10 +++++
>  tools/perf/util/perf_api_probe.h                  |   1 +
>  tools/perf/util/perf_event_attr_fprintf.c         |   2 +
>  tools/perf/util/probe-event.c                     |   6 +--
>  tools/perf/util/record.h                          |   1 +
>  tools/perf/util/session.c                         |  11 +++--
>  tools/perf/util/symbol-elf.c                      |  37 +++++++++++++++-
>  tools/perf/util/symbol_conf.h                     |   3 +-
>  tools/perf/util/synthetic-events.c                | 121 ++++++++++++++++++++++++++++++++++++++-------------
>  29 files changed, 787 insertions(+), 229 deletions(-)
>

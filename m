Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A702B5DBB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgKQLBO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Nov 2020 06:01:14 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:25545 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727406AbgKQLBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:01:14 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-F62pkKI-OQqggLv5XvzjAA-1; Tue, 17 Nov 2020 06:01:06 -0500
X-MC-Unique: F62pkKI-OQqggLv5XvzjAA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9FD6879524;
        Tue, 17 Nov 2020 11:01:02 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6840B5C1D0;
        Tue, 17 Nov 2020 11:00:54 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     "Frank Ch . Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCHv2 00/24] perf: Add mmap2 build id support
Date:   Tue, 17 Nov 2020 12:00:29 +0100
Message-Id: <20201117110053.1303113-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
adding the support to have buildid stored in mmap2 event,
so we can bypass the final perf record hunt on build ids.

This patchset allows perf to record build ID in mmap2 event,
and adds perf tooling to store/download binaries to .debug
cache based on these build IDs.

Note that the build id retrieval code is stolen from bpf
code, where it's been used (together with file offsets)
to replace IPs in user space stack traces. It's now added
under lib directory.

v2 changes:
  - add size arg to build_id_parse instead of extra function [Alexei]
  - shift build_id_size and build_id [Peter]
  - document new config options [Namhyung]
  - fallback to maj/min/ino* in case build id parse fails [Namhyung]
  - fixed debuginfo retrieval for kernel and modules in buildid-cache
  - keeping the post processing disabled for --buildid-mmap
    because the buildid parsing seems reliable, failing only for vdso,
    vsyscall and annon mappings, which is expected:
      people.redhat.com/~jolsa/buildids.txt


On recording server:

  - on the recording server we can run record with --buildid-mmap
    option to store build ids in mmap2 events:

    # perf record --buildid-mmap
    ^C[ perf record: Woken up 2 times to write data ]
    [ perf record: Captured and wrote 0.836 MB perf.data ]

  - it stores nothing to ~/.debug cache:

    # find ~/.debug
    find: ‘/root/.debug’: No such file or directory

  - and still reports properly:

    # perf report --stdio
    ...
    99.82%  swapper          [kernel.kallsyms]  [k] native_safe_halt
     0.03%  swapper          [kernel.kallsyms]  [k] finish_task_switch
     0.02%  swapper          [kernel.kallsyms]  [k] __softirqentry_text_start
     0.01%  kcompactd0       [kernel.kallsyms]  [k] _raw_spin_unlock_irqrestore
     0.01%  ksoftirqd/6      [kernel.kallsyms]  [k] slab_free_freelist_hook
     0.01%  kworker/17:1H-x  [kernel.kallsyms]  [k] slab_free_freelist_hook

  - display used/hit build ids:

    # perf buildid-list | head -5
    5dcec522abf136fcfd3128f47e131f2365834dd7 /proc/kcore
    589e403a34f55486bcac848a45e00bcdeedd1ca8 /usr/lib64/libcrypto.so.1.1.1g
    94569566d4eac7e9c87ba029d43d4e2158f9527e /usr/lib64/libpthread-2.30.so
    559b9702bebe31c6d132c8dc5cc887673d65d5b5 /usr/lib64/libc-2.30.so
    40da7abe89f631f60538a17686a7d65c6a02ed31 /usr/lib64/ld-2.30.so

  - store build id binaries into build id cache:

    # perf buildid-cache -a perf.data
    OK   5dcec522abf136fcfd3128f47e131f2365834dd7 /proc/kcore
    OK   589e403a34f55486bcac848a45e00bcdeedd1ca8 /usr/lib64/libcrypto.so.1.1.1g
    OK   94569566d4eac7e9c87ba029d43d4e2158f9527e /usr/lib64/libpthread-2.30.so
    OK   559b9702bebe31c6d132c8dc5cc887673d65d5b5 /usr/lib64/libc-2.30.so
    OK   40da7abe89f631f60538a17686a7d65c6a02ed31 /usr/lib64/ld-2.30.so
    OK   a674f7a47c78e35a088104647b9640710277b489 /usr/sbin/sshd
    OK   e5cb4ca25f46485bdbc691c3a92e7e111dac3ef2 /usr/bin/bash
    OK   9bc8589108223c944b452f0819298a0c3cba6215 /usr/bin/find

    # find ~/.debug | head -5
    /root/.debug
    /root/.debug/proc
    /root/.debug/proc/kcore
    /root/.debug/proc/kcore/5dcec522abf136fcfd3128f47e131f2365834dd7
    /root/.debug/proc/kcore/5dcec522abf136fcfd3128f47e131f2365834dd7/kallsyms

  - run debuginfod daemon to provide binaries to another server (below)
    (the initialization could take some time)

    # debuginfod -F /


On another server:

  - copy perf.data from 'record' server and run:

    $ find ~/.debug/
    find: ‘/home/jolsa/.debug/’: No such file or directory

    $ perf buildid-list | head -5
    No kallsyms or vmlinux with build-id 5dcec522abf136fcfd3128f47e131f2365834dd7 was found
    5dcec522abf136fcfd3128f47e131f2365834dd7 [kernel.kallsyms]
    5784f813b727a50cfd3363234aef9fcbab685cc4 /lib/modules/5.10.0-rc2speed+/kernel/fs/xfs/xfs.ko
    589e403a34f55486bcac848a45e00bcdeedd1ca8 /usr/lib64/libcrypto.so.1.1.1g
    94569566d4eac7e9c87ba029d43d4e2158f9527e /usr/lib64/libpthread-2.30.so
    559b9702bebe31c6d132c8dc5cc887673d65d5b5 /usr/lib64/libc-2.30.so

  - report does not show anything (kernel build id does not match):

   $ perf report --stdio
   ...
    76.73%  swapper          [kernel.kallsyms]    [k] 0xffffffff81aa8ebe
     1.89%  find             [kernel.kallsyms]    [k] 0xffffffff810f2167
     0.93%  sshd             [kernel.kallsyms]    [k] 0xffffffff8153380c
     0.83%  swapper          [kernel.kallsyms]    [k] 0xffffffff81104b0b
     0.71%  kworker/u40:2-e  [kernel.kallsyms]    [k] 0xffffffff810f3850
     0.70%  kworker/u40:0-e  [kernel.kallsyms]    [k] 0xffffffff810f3850
     0.64%  find             [kernel.kallsyms]    [k] 0xffffffff81a9ba0a
     0.63%  find             [kernel.kallsyms]    [k] 0xffffffff81aa93b0

  - add build ids does not work, because existing binaries (on another server)
    have different build ids:

    $ perf buildid-cache -a perf.data 
    No kallsyms or vmlinux with build-id 5dcec522abf136fcfd3128f47e131f2365834dd7 was found
    FAIL 5dcec522abf136fcfd3128f47e131f2365834dd7 [kernel.kallsyms]
    FAIL 5784f813b727a50cfd3363234aef9fcbab685cc4 /lib/modules/5.10.0-rc2speed+/kernel/fs/xfs/xfs.ko
    FAIL 589e403a34f55486bcac848a45e00bcdeedd1ca8 /usr/lib64/libcrypto.so.1.1.1g
    FAIL 94569566d4eac7e9c87ba029d43d4e2158f9527e /usr/lib64/libpthread-2.30.so
    FAIL 559b9702bebe31c6d132c8dc5cc887673d65d5b5 /usr/lib64/libc-2.30.so
    FAIL 40da7abe89f631f60538a17686a7d65c6a02ed31 /usr/lib64/ld-2.30.so
    FAIL a674f7a47c78e35a088104647b9640710277b489 /usr/sbin/sshd
    FAIL e5cb4ca25f46485bdbc691c3a92e7e111dac3ef2 /usr/bin/bash
    FAIL 9bc8589108223c944b452f0819298a0c3cba6215 /usr/bin/find

  - add build ids with debuginfod setup pointing to record server:

    $ perf buildid-cache -a perf.data --debuginfod http://192.168.122.174:8002
    No kallsyms or vmlinux with build-id 5dcec522abf136fcfd3128f47e131f2365834dd7 was found
    OK   5dcec522abf136fcfd3128f47e131f2365834dd7 [kernel.kallsyms]
    OK   5784f813b727a50cfd3363234aef9fcbab685cc4 /lib/modules/5.10.0-rc2speed+/kernel/fs/xfs/xfs.ko
    OK   589e403a34f55486bcac848a45e00bcdeedd1ca8 /usr/lib64/libcrypto.so.1.1.1g
    OK   94569566d4eac7e9c87ba029d43d4e2158f9527e /usr/lib64/libpthread-2.30.so
    OK   559b9702bebe31c6d132c8dc5cc887673d65d5b5 /usr/lib64/libc-2.30.so
    OK   40da7abe89f631f60538a17686a7d65c6a02ed31 /usr/lib64/ld-2.30.so
    OK   a674f7a47c78e35a088104647b9640710277b489 /usr/sbin/sshd
    OK   e5cb4ca25f46485bdbc691c3a92e7e111dac3ef2 /usr/bin/bash
    OK   9bc8589108223c944b452f0819298a0c3cba6215 /usr/bin/find

  - and report works:

    $ perf report --stdio
    ...
    76.73%  swapper          [kernel.kallsyms]    [k] native_safe_halt
     1.91%  find             [kernel.kallsyms]    [k] queue_work_on
     0.93%  sshd             [kernel.kallsyms]    [k] iowrite16
     0.83%  swapper          [kernel.kallsyms]    [k] finish_task_switch
     0.72%  kworker/u40:2-e  [kernel.kallsyms]    [k] process_one_work
     0.70%  kworker/u40:0-e  [kernel.kallsyms]    [k] process_one_work
     0.64%  find             [kernel.kallsyms]    [k] syscall_enter_from_user_mode
     0.63%  find             [kernel.kallsyms]    [k] _raw_spin_unlock_irqrestore

  - because we have the data in build id cache:

    $ find ~/.debug | head -10
    .../.debug
    .../.debug/home
    .../.debug/home/jolsa
    .../.debug/home/jolsa/.cache
    .../.debug/home/jolsa/.cache/debuginfod_client
    .../.debug/home/jolsa/.cache/debuginfod_client/5dcec522abf136fcfd3128f47e131f2365834dd7
    .../.debug/home/jolsa/.cache/debuginfod_client/5dcec522abf136fcfd3128f47e131f2365834dd7/executable
    .../.debug/home/jolsa/.cache/debuginfod_client/5dcec522abf136fcfd3128f47e131f2365834dd7/executable/5dcec522abf136fcfd3128f47e131f2365834dd7
    .../.debug/home/jolsa/.cache/debuginfod_client/5dcec522abf136fcfd3128f47e131f2365834dd7/executable/5dcec522abf136fcfd3128f47e131f2365834dd7/elf
    .../.debug/home/jolsa/.cache/debuginfod_client/5dcec522abf136fcfd3128f47e131f2365834dd7/executable/5dcec522abf136fcfd3128f47e131f2365834dd7/debug


Available also in:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/build_id

thanks,
jirka


Cc: Frank Ch. Eigler <fche@redhat.com>
Cc: Mark Wielaard <mjw@redhat.com>
---
Jiri Olsa (24):
      bpf: Move stack_map_get_build_id into lib
      bpf: Add size arg to build_id_parse function
      perf: Add build id data in mmap2 event
      tools headers uapi: Sync tools/include/uapi/linux/perf_event.h
      perf tools: Do not swap mmap2 fields in case it contains build id
      perf tools: Add build_id__is_defined function
      perf tools: Add filename__decompress function
      perf tools: Add support to read build id from compressed elf
      perf tools: Add check for existing link in buildid dir
      perf tools: Use struct extra_kernel_map in machine__process_kernel_mmap_event
      perf tools: Try to load vmlinux from buildid database
      perf tools: Store build id from mmap2 events
      perf tools: Allow mmap2 event to synthesize kernel image
      perf tools: Allow mmap2 event to synthesize modules
      perf tools: Synthesize build id for kernel/modules/tasks
      perf tools: Add support to display build id for mmap2 events
      perf tools: Use machine__for_each_dso in perf_session__cache_build_ids
      perf tools: Add __perf_session__cache_build_ids function
      perf tools: Add is_perf_data function
      perf tools: Add build_id_cache__add function
      perf buildid-cache: Add support to add build ids from perf data
      perf buildid-cache: Add --debuginfod option
      perf buildid-list: Add support for mmap2's buildid events
      perf record: Add --buildid-mmap option to enable mmap's build id

 include/linux/buildid.h                           |  12 ++++++
 include/uapi/linux/perf_event.h                   |  42 ++++++++++++++++---
 kernel/bpf/stackmap.c                             | 143 ++---------------------------------------------------------------
 kernel/events/core.c                              |  36 +++++++++++++++--
 lib/Makefile                                      |   3 +-
 lib/buildid.c                                     | 149 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/perf_event.h             |  42 ++++++++++++++++---
 tools/lib/perf/include/perf/event.h               |  18 +++++++--
 tools/perf/Documentation/perf-buildid-cache.txt   |  18 ++++++++-
 tools/perf/Documentation/perf-config.txt          |  10 ++++-
 tools/perf/Documentation/perf-record.txt          |   3 ++
 tools/perf/builtin-buildid-cache.c                | 243 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/builtin-buildid-list.c                 |   3 ++
 tools/perf/builtin-record.c                       |  20 +++++++++
 tools/perf/tests/shell/trace+probe_vfs_getname.sh |   2 +-
 tools/perf/util/build-id.c                        | 124 ++++++++++++++++++++++++++++++++++++--------------------
 tools/perf/util/build-id.h                        |   8 ++++
 tools/perf/util/data.c                            |  19 +++++++++
 tools/perf/util/data.h                            |   1 +
 tools/perf/util/dso.c                             |  31 ++++++++------
 tools/perf/util/dso.h                             |   2 +
 tools/perf/util/event.c                           |  41 ++++++++++++++-----
 tools/perf/util/evsel.c                           |  10 +++--
 tools/perf/util/machine.c                         |  80 ++++++++++++++++++++++--------------
 tools/perf/util/map.c                             |   8 +++-
 tools/perf/util/map.h                             |   3 +-
 tools/perf/util/perf_api_probe.c                  |  10 +++++
 tools/perf/util/perf_api_probe.h                  |   1 +
 tools/perf/util/perf_event_attr_fprintf.c         |   2 +
 tools/perf/util/probe-event.c                     |   6 +--
 tools/perf/util/record.h                          |   1 +
 tools/perf/util/session.c                         |  11 +++--
 tools/perf/util/symbol-elf.c                      |  37 ++++++++++++++++-
 tools/perf/util/symbol.c                          |  16 ++++++++
 tools/perf/util/symbol_conf.h                     |   3 +-
 tools/perf/util/synthetic-events.c                | 121 +++++++++++++++++++++++++++++++++++++++++--------------
 36 files changed, 968 insertions(+), 311 deletions(-)
 create mode 100644 include/linux/buildid.h
 create mode 100644 lib/buildid.c


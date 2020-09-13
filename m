Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796A8268140
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgIMVDh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 17:03:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42882 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725941AbgIMVDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:03:34 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-GJ72lD4tOU29f_IJmXjpVw-1; Sun, 13 Sep 2020 17:03:22 -0400
X-MC-Unique: GJ72lD4tOU29f_IJmXjpVw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D5A3802B6A;
        Sun, 13 Sep 2020 21:03:19 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCF411002388;
        Sun, 13 Sep 2020 21:03:14 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [RFC 00/26] perf: Add mmap3 support
Date:   Sun, 13 Sep 2020 23:02:47 +0200
Message-Id: <20200913210313.1985612-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
while playing with perf daemon support I realized I need
the build id data in mmap events, so we don't need to care
about removed/updated binaries during long perf runs.

This RFC patchset adds new mmap3 events that copies mmap2
event and adds build id in it. It makes mmap3 the default
mmap event for synthesizing kernel/modules/tasks and adds
some tooling enhancements to enable the workflow below.

Note that the build id retrieval code is stolen from bpf
code, where it's been used (together with file offsets)
to replace IPs in user space stack traces. It's now added
under lib directory.


On recording server:

  - on the recording server we can run record with -B option to
    skip build id scan:

    # perf record -B
    ^C[ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 4.462 MB perf.data ]

    # find ~/.debug
    find: ‘/root/.debug’: No such file or directory

    # perf report
    ...
      97.93%  swapper          [kernel.kallsyms]           [k] native_safe_halt
       0.18%  sshd             [kernel.kallsyms]           [k] avtab_search_node
       0.14%  swapper          [kernel.kallsyms]           [k] __do_softirq
       0.05%  swapper          [kernel.kallsyms]           [k] _raw_spin_unlock_irqrestore
       0.03%  swapper          [kernel.kallsyms]           [k] finish_task_switch

  - display used/hit build ids:

    # perf buildid-list | head -5
    439fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46 [kernel.kallsyms]
    23b87f5b0560481043257e82be670bc97786a171 /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/net/ipv4/netfilter/ip_tables.ko.xz
    d2b3be372bcdd4ebc15e479d2ff803657de0fd1e /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/drivers/block/virtio_blk.ko.xz
    1466a71bcd0ff5c975ee79b72752137c0143d225 /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/fs/xfs/xfs.ko.xz
    ad60d10b38c93bd8738d5aa594e240f01bb328cd /usr/lib/systemd/systemd

  - store build id binaries into build id cache:

    # perf buildid-list --store | head -5
    OK   439fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46 [kernel.kallsyms]
    OK   23b87f5b0560481043257e82be670bc97786a171 /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/net/ipv4/netfilter/ip_tables.ko.xz
    OK   d2b3be372bcdd4ebc15e479d2ff803657de0fd1e /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/drivers/block/virtio_blk.ko.xz
    OK   1466a71bcd0ff5c975ee79b72752137c0143d225 /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/fs/xfs/xfs.ko.xz
    OK   ad60d10b38c93bd8738d5aa594e240f01bb328cd /usr/lib/systemd/systemd

    # find ~/.debug | head -5
    /root/.debug
    /root/.debug/[kernel.kallsyms]
    /root/.debug/[kernel.kallsyms]/439fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46
    /root/.debug/[kernel.kallsyms]/439fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46/kallsyms
    /root/.debug/[kernel.kallsyms]/439fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46/probes

  - run debuginfod daemon to provide binaries to another server (below)

    # debuginfod -F /


On another server:

  - copy perf.data from 'record' server and run:

    $ find ~/.debug/
    find: ‘/home/jolsa/.debug/’: No such file or directory

    $ perf buildid-list | head -5
    No kallsyms or vmlinux with build-id 439fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46 was found
    439fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46 [kernel.kallsyms]
    23b87f5b0560481043257e82be670bc97786a171 /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/net/ipv4/netfilter/ip_tables.ko.xz
    d2b3be372bcdd4ebc15e479d2ff803657de0fd1e /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/drivers/block/virtio_blk.ko.xz
    1466a71bcd0ff5c975ee79b72752137c0143d225 /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/fs/xfs/xfs.ko.xz
    ad60d10b38c93bd8738d5aa594e240f01bb328cd /usr/lib/systemd/systemd

  - report does not show anything (kernel build id does not match):

    $ perf report --stdio
    ...
      97.93%  swapper          [kernel.kallsyms]           [k] 0xffffffffa8b859be
       0.14%  swapper          [kernel.kallsyms]           [k] 0xffffffffa8e00074
       0.11%  sshd             [kernel.kallsyms]           [k] 0xffffffffa855b283
       0.05%  swapper          [kernel.kallsyms]           [k] 0xffffffffa8b85d31
       0.03%  swapper          [kernel.kallsyms]           [k] 0xffffffffa810a220

  - store does not work, existing binaries have different build ids:

    $ perf report --store | head -5
    No kallsyms or vmlinux with build-id 439fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46 was found
    FAIL 439fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46 [kernel.kallsyms]
    FAIL 23b87f5b0560481043257e82be670bc97786a171 /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/net/ipv4/netfilter/ip_tables.ko.xz
    FAIL d2b3be372bcdd4ebc15e479d2ff803657de0fd1e /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/drivers/block/virtio_blk.ko.xz
    FAIL 1466a71bcd0ff5c975ee79b72752137c0143d225 /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/fs/xfs/xfs.ko.xz
    FAIL ad60d10b38c93bd8738d5aa594e240f01bb328cd /usr/lib/systemd/systemd

  - instruct debuginfo client to download them (modules retrieval does not work yet for some reason):

    $ DEBUGINFOD_URLS=http://192.168.122.174:8002 perf report --store  | head -5
    No kallsyms or vmlinux with build-id 439fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46 was found
    OK   439fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46 [kernel.kallsyms]
    FAIL 23b87f5b0560481043257e82be670bc97786a171 /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/net/ipv4/netfilter/ip_tables.ko.xz
    FAIL d2b3be372bcdd4ebc15e479d2ff803657de0fd1e /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/drivers/block/virtio_blk.ko.xz
    FAIL 1466a71bcd0ff5c975ee79b72752137c0143d225 /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/fs/xfs/xfs.ko.xz
    OK   ad60d10b38c93bd8738d5aa594e240f01bb328cd /usr/lib/systemd/systemd

  - and report works:

    $ perf report --stdio
    ...
      97.93%  swapper          [kernel.kallsyms]           [k] native_safe_halt
       0.18%  sshd             [kernel.kallsyms]           [k] avtab_search_node
       0.14%  swapper          [kernel.kallsyms]           [k] __do_softirq
       0.05%  swapper          [kernel.kallsyms]           [k] _raw_spin_unlock_irqrestore
       0.03%  swapper          [kernel.kallsyms]           [k] finish_task_switch

  - because we have the data in build id cache:

    $ find ~/.debug | head -10
    .../.debug
    .../.debug/home
    .../.debug/home/jolsa
    .../.debug/home/jolsa/.cache
    .../.debug/home/jolsa/.cache/debuginfod_client
    .../.debug/home/jolsa/.cache/debuginfod_client/439fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46
    .../.debug/home/jolsa/.cache/debuginfod_client/439fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46/executable
    .../.debug/home/jolsa/.cache/debuginfod_client/439fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46/executable/439fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46
    .../.debug/home/jolsa/.cache/debuginfod_client/439fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46/executable/439fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46/elf
    .../.debug/home/jolsa/.cache/debuginfod_client/439fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46/executable/439fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46/probes


The code still needs some polishing, but I'd like to hear some
opinions on the usage workflow, so it could get adjusted early
on ;-)

For example: should we make -B default now? what about users
that expect build id cache populated? And perhaps some .perfconfig
setup possibility for debuginfod server.

Available also in:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/mmap3

thanks,
jirka


Cc: Alexei Starovoitov <ast@kernel.org>
---
Jiri Olsa (26):
      bpf: Move stack_map_get_build_id into lib
      perf: Introduce mmap3 version of mmap event
      tools headers uapi: Sync tools/include/uapi/linux/perf_event.h
      perf tools: Add filename__decompress function
      perf tools: Add build_id__is_defined function
      perf tools: Add support to read build id from compressed elf
      perf tools: Add check for existing link in buildid dir
      perf tools: Use struct extra_kernel_map in machine__process_kernel_mmap_event
      perf tools: Try load vmlinux from buildid database
      perf tools: Enable mmap3 map event when supported
      perf tools: Add mmap3 support
      perf tools: Set build id for kernel dso objects
      perf tools: Plug in mmap3 event
      perf tools: Add mmap3 events to --show-mmap-events option
      perf tools: Synthesize proc tasks with mmap3
      perf tools: Synthesize modules with mmap3
      perf tools: Synthesize kernel with mmap3
      perf tests: Add mmap3 support for perf record test
      perf tools: Add buildid-list support for mmap3
      perf tools: Add build_id_cache__add function
      perf tools: Add machine__for_each_dso function
      perf tools: Use machine__for_each_dso in perf_session__cache_build_ids
      perf tools: Add __perf_session__cache_build_ids function
      perf tools: Add buildid-list --store option
      perf tools: Move debuginfo download code into get_debuginfo
      perf tools: Add report --store option

 include/linux/buildid.h                        |  11 +++++++
 include/uapi/linux/perf_event.h                |  27 +++++++++++++++-
 kernel/bpf/stackmap.c                          | 143 +++--------------------------------------------------------------------------------
 kernel/events/core.c                           |  38 +++++++++++++++++-----
 lib/Makefile                                   |   3 +-
 lib/buildid.c                                  | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/perf_event.h          |  27 +++++++++++++++-
 tools/lib/perf/include/perf/event.h            |  18 +++++++++++
 tools/perf/Documentation/perf-buildid-list.txt |  12 +++++++
 tools/perf/Documentation/perf-report.txt       |   3 ++
 tools/perf/builtin-annotate.c                  |   1 +
 tools/perf/builtin-buildid-list.c              | 179 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 tools/perf/builtin-c2c.c                       |   1 +
 tools/perf/builtin-diff.c                      |   1 +
 tools/perf/builtin-inject.c                    |  38 ++++++++++++++++++++++
 tools/perf/builtin-kmem.c                      |   1 +
 tools/perf/builtin-mem.c                       |   1 +
 tools/perf/builtin-record.c                    |  14 +++++++++
 tools/perf/builtin-report.c                    |  19 +++++++++++
 tools/perf/builtin-script.c                    |  34 ++++++++++++++++++++
 tools/perf/builtin-trace.c                     |   1 +
 tools/perf/tests/perf-record.c                 |   7 ++++-
 tools/perf/util/build-id.c                     | 179 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------
 tools/perf/util/build-id.h                     |   8 +++++
 tools/perf/util/data-convert-bt.c              |   1 +
 tools/perf/util/dso.c                          |  31 +++++++++++-------
 tools/perf/util/dso.h                          |   2 ++
 tools/perf/util/event.c                        |  32 +++++++++++++++++++
 tools/perf/util/event.h                        |   5 +++
 tools/perf/util/evsel.c                        |   9 +++++-
 tools/perf/util/evsel.h                        |   1 +
 tools/perf/util/machine.c                      | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------
 tools/perf/util/machine.h                      |   6 ++++
 tools/perf/util/map.c                          |   8 +++--
 tools/perf/util/map.h                          |   2 +-
 tools/perf/util/mmap.c                         |   2 +-
 tools/perf/util/perf_event_attr_fprintf.c      |   1 +
 tools/perf/util/probe-event.c                  |   6 ++--
 tools/perf/util/session.c                      |  28 +++++++++++++++++
 tools/perf/util/symbol-elf.c                   |  37 ++++++++++++++++++++--
 tools/perf/util/symbol.c                       |  14 +++++++++
 tools/perf/util/synthetic-events.c             | 132 ++++++++++++++++++++++++++++++++++++++++++++++------------------------------
 tools/perf/util/tool.h                         |   1 +
 43 files changed, 1059 insertions(+), 316 deletions(-)
 create mode 100644 include/linux/buildid.h
 create mode 100644 lib/buildid.c


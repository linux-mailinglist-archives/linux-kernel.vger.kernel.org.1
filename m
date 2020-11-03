Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7002A5050
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 20:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbgKCTox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 14:44:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:35094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbgKCTow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:44:52 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBB1C20732;
        Tue,  3 Nov 2020 19:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604432691;
        bh=WBXc+BZ/I4NcYIdxatU1WXrfBr+J+iL8AtTPOpHziUo=;
        h=From:To:Cc:Subject:Date:From;
        b=tWmDL0DDx3qceKw13Xy/WKnpfO82V76YUrVxLjAryQTeRMulbCDky1Q7gZO2rB1Xu
         I7F/XaST4oGnM7Mt2Nf08jmvZpgKd7y65KMrHXrVGxYLQUaimPap0riweO+F4MOwje
         beCmKEDbV63oAtgP0BXCYEe+KeVffQSpefL5OqNw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        "Justin M . Forbes" <jforbes@fedoraproject.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stanislav Ivanichkin <sivanichkin@yandex-team.ru>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v5.11
Date:   Tue,  3 Nov 2020 16:44:41 -0300
Message-Id: <20201103194441.197821-1-acme@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling, only fixes and a sync of the headers so
that the perf build is silent, please let me know if I made any other
mistake,

Best regards,

- Arnaldo

The following changes since commit b7cbaf59f62f8ab8f157698f9e31642bff525bd0:

  Merge branch 'akpm' (patches from Andrew) (2020-11-02 14:47:37 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.10-2020-11-03

for you to fetch changes up to 5d020cbd86204e51da05628623a6f9729d4b04c8:

  tools feature: Fixup fast path feature detection (2020-11-03 09:24:20 -0300)

----------------------------------------------------------------
perf tools updates for v5.10: 2nd batch.

- Fix visibility attribute in python module init code with newer gcc.

- Fix DRAM_BW_Use 0 issue for CLX/SKX in intel JSON vendor event files.

- Fix the build on new fedora by removing LTO compiler options when
  building perl support.

- Remove broken __no_tail_call attribute.

- Fix segfault when trying to trace events by cgroup.

- Fix crash with non-jited BPF progs.

- Increase buffer size in TUI browser, fixing format truncation.

- Fix printing of build-id for objects lacking one.

- Fix byte swapping for ino_generation field in MMAP2 perf.data records.

- Fix byte swapping for CGROUP perf.data records, for cross arch
  analysis of perf.data files.

- Fix the fast path of feature detection.

- Update kernel header copies.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Test results in the signed tag at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tag/?h=perf-tools-for-v5.10-2020-11-03

----------------------------------------------------------------
Arnaldo Carvalho de Melo (14):
      perf tools: Update copy of libbpf's hashmap.c
      tools headers UAPI: Update process_madvise affected files
      perf scripting python: Avoid declaring function pointers with a visibility attribute
      tools headers UAPI: Sync prctl.h with the kernel sources
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
      tools headers UAPI: Update fscrypt.h copy
      tools x86 headers: Update cpufeatures.h headers copies
      tools x86 headers: Update required-features.h header from the kernel
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools UAPI: Update copy of linux/mman.h from the kernel sources
      tools kvm headers: Update KVM headers from the kernel sources
      tools headers UAPI: Update tools's copy of linux/perf_event.h
      tools include UAPI: Update linux/mount.h copy
      tools feature: Fixup fast path feature detection

Jin Yao (1):
      perf vendor events: Fix DRAM_BW_Use 0 issue for CLX/SKX

Jiri Olsa (2):
      perf tools: Initialize output buffer in build_id__sprintf
      perf tools: Add missing swap for ino_generation

Justin M. Forbes (1):
      perf tools: Remove LTO compiler options when building perl support

Namhyung Kim (1):
      perf tools: Add missing swap for cgroup events

Peter Zijlstra (1):
      perf tools: Remove broken __no_tail_call attribute

Song Liu (1):
      perf hists browser: Increase size of 'buf' in perf_evsel__hists_browse()

Stanislav Ivanichkin (1):
      perf trace: Fix segfault when trying to trace events by cgroup

Tommi Rantala (1):
      perf tools: Fix crash with non-jited bpf progs

 tools/arch/arm64/include/uapi/asm/kvm.h            | 25 +++++++++
 tools/arch/s390/include/uapi/asm/sie.h             |  2 +-
 tools/arch/x86/include/asm/cpufeatures.h           |  6 ++-
 tools/arch/x86/include/asm/disabled-features.h     |  9 +++-
 tools/arch/x86/include/asm/msr-index.h             | 10 ++++
 tools/arch/x86/include/asm/required-features.h     |  2 +-
 tools/arch/x86/include/uapi/asm/kvm.h              | 20 ++++++++
 tools/arch/x86/include/uapi/asm/svm.h              | 13 +++++
 tools/build/feature/test-all.c                     |  1 -
 tools/include/linux/compiler-gcc.h                 | 12 -----
 tools/include/linux/compiler.h                     |  3 --
 tools/include/uapi/asm-generic/unistd.h            |  4 +-
 tools/include/uapi/drm/i915_drm.h                  | 59 ++++++++++++++++++++--
 tools/include/uapi/linux/fscrypt.h                 |  6 +--
 tools/include/uapi/linux/kvm.h                     | 19 +++++++
 tools/include/uapi/linux/mman.h                    |  1 +
 tools/include/uapi/linux/mount.h                   |  1 +
 tools/include/uapi/linux/perf_event.h              |  2 +-
 tools/include/uapi/linux/prctl.h                   |  9 ++++
 tools/include/uapi/linux/vhost.h                   |  4 ++
 tools/perf/Makefile.config                         |  1 +
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  | 11 ++--
 tools/perf/builtin-trace.c                         | 15 +++---
 .../arch/x86/cascadelakex/clx-metrics.json         |  2 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |  2 +-
 tools/perf/tests/dwarf-unwind.c                    | 10 ++--
 tools/perf/ui/browsers/hists.c                     |  2 +-
 tools/perf/util/build-id.c                         |  2 +
 tools/perf/util/hashmap.c                          |  3 ++
 tools/perf/util/hashmap.h                          | 12 +++++
 tools/perf/util/machine.c                          | 11 +++-
 .../util/scripting-engines/trace-event-python.c    |  7 +--
 tools/perf/util/session.c                          | 14 +++++
 tools/perf/util/symbol.c                           |  7 +++
 tools/perf/util/symbol.h                           |  2 +
 35 files changed, 257 insertions(+), 52 deletions(-)

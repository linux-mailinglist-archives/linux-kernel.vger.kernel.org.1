Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5436421BB52
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 18:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgGJQwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 12:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgGJQwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:52:12 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C5FB206F4;
        Fri, 10 Jul 2020 16:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594399931;
        bh=KcvQZrHB38KDnUP8nxJc19jdFdt8oGFue3inzmz/Efc=;
        h=From:To:Cc:Subject:Date:From;
        b=gpIwsoJ/xXbQSIbhAwidVUNkopiZBRtRJr6jm8fYtOsJO0sGFBU4VrzLmpjt8J0+h
         bM3ZPwoxoAqbROw+x/9XrPnXHGuUR8yujViPTR/a4kKu7ko3AQlaCr7An51UhICwox
         /CYhjCD7gHFg3nRhEECbjLxD55E4l8YFtDGAk0TY=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Joel Fernandes <joelaf@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel-team@android.com
Subject: [PATCH 00/18] Allow architectures to override __READ_ONCE()
Date:   Fri, 10 Jul 2020 17:51:44 +0100
Message-Id: <20200710165203.31284-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is version three of the patches I previously posted here:

  v1: https://lore.kernel.org/lkml/20191108170120.22331-1-will@kernel.org/
  v2: https://lore.kernel.org/r/20200630173734.14057-1-will@kernel.org

Changes since v2 include:

  * Actually add the barrier in READ_ONCE() for Alpha!
  * Implement Alpha's smp_load_acquire() using __READ_ONCE(), rather than
    the other way around.
  * Further untangling of header files
  * Use CONFIG_LTO instead of CONFIG_CLANG_LTO

I have booted this on arm64, and build-tested as follows:

  - arm64	allnoconfig, defconfig (also bisected) and allmodconfig
  - arm32	allnoconfig, defconfig and allmodconfig
  - x86_64	allnoconfig, defconfig and allmodcofig
  - alpha	defconfig, defconfig+CONFIG_SMP=y
  - riscv64	defconfig
  - powerpc64	defconfig
  - s390	defconfig
  - sparc32	defconfig, defconfig+CONFIG_SMP=y
  - sparc64	defconfig

Cheers,

Will

Cc: Joel Fernandes <joelaf@google.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Marco Elver <elver@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org>
Cc: linux-alpha@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: kernel-team@android.com

--->8

SeongJae Park (1):
  Documentation/barriers/kokr: Remove references to
    [smp_]read_barrier_depends()

Will Deacon (18):
  tools: bpf: Use local copy of headers including uapi/linux/filter.h
  compiler.h: Split {READ,WRITE}_ONCE definitions out into rwonce.h
  asm/rwonce: Allow __READ_ONCE to be overridden by the architecture
  alpha: Override READ_ONCE() with barriered implementation
  asm/rwonce: Remove smp_read_barrier_depends() invocation
  asm/rwonce: Don't pull <asm/barrier.h> into 'asm-generic/rwonce.h'
  vhost: Remove redundant use of read_barrier_depends() barrier
  alpha: Replace smp_read_barrier_depends() usage with smp_[r]mb()
  locking/barriers: Remove definitions for [smp_]read_barrier_depends()
  Documentation/barriers: Remove references to
    [smp_]read_barrier_depends()
  tools/memory-model: Remove smp_read_barrier_depends() from informal
    doc
  include/linux: Remove smp_read_barrier_depends() from comments
  checkpatch: Remove checks relating to [smp_]read_barrier_depends()
  arm64: Reduce the number of header files pulled into vmlinux.lds.S
  arm64: alternatives: Split up alternative.h
  arm64: cpufeatures: Add capability for LDAPR instruction
  arm64: alternatives: Remove READ_ONCE() usage during patch operation
  arm64: lto: Strengthen READ_ONCE() to acquire when CONFIG_LTO=y

 .../RCU/Design/Requirements/Requirements.rst  |   2 +-
 Documentation/memory-barriers.txt             | 156 +---------
 .../translations/ko_KR/memory-barriers.txt    | 146 +--------
 arch/alpha/include/asm/atomic.h               |  16 +-
 arch/alpha/include/asm/barrier.h              |  59 +---
 arch/alpha/include/asm/pgtable.h              |  10 +-
 arch/alpha/include/asm/rwonce.h               |  35 +++
 arch/arm/include/asm/vdso/gettimeofday.h      |   1 +
 arch/arm64/Kconfig                            |   3 +
 arch/arm64/include/asm/alternative-macros.h   | 276 ++++++++++++++++++
 arch/arm64/include/asm/alternative.h          | 267 +----------------
 arch/arm64/include/asm/cpucaps.h              |   3 +-
 arch/arm64/include/asm/insn.h                 |   3 +-
 arch/arm64/include/asm/kernel-pgtable.h       |   2 +-
 arch/arm64/include/asm/memory.h               |  11 +-
 arch/arm64/include/asm/rwonce.h               |  63 ++++
 arch/arm64/include/asm/uaccess.h              |   1 +
 .../include/asm/vdso/compat_gettimeofday.h    |   1 +
 arch/arm64/include/asm/vdso/gettimeofday.h    |   1 +
 arch/arm64/kernel/alternative.c               |   7 +-
 arch/arm64/kernel/cpufeature.c                |  10 +
 arch/arm64/kernel/entry.S                     |   1 +
 arch/arm64/kernel/vdso/Makefile               |   2 +-
 arch/arm64/kernel/vdso32/Makefile             |   2 +-
 arch/arm64/kernel/vmlinux.lds.S               |   1 -
 arch/arm64/kvm/hyp-init.S                     |   1 +
 arch/riscv/include/asm/vdso/gettimeofday.h    |   1 +
 drivers/vhost/vhost.c                         |   5 -
 include/asm-generic/Kbuild                    |   1 +
 include/asm-generic/barrier.h                 |  19 +-
 include/asm-generic/rwonce.h                  |  80 +++++
 include/linux/compiler.h                      |  83 +-----
 include/linux/nospec.h                        |   2 +
 include/linux/percpu-refcount.h               |   2 +-
 include/linux/ptr_ring.h                      |   2 +-
 mm/memory.c                                   |   2 +-
 scripts/checkpatch.pl                         |   9 +-
 tools/bpf/Makefile                            |   3 +-
 tools/include/uapi/linux/filter.h             |  90 ++++++
 .../Documentation/explanation.txt             |  26 +-
 40 files changed, 636 insertions(+), 769 deletions(-)
 create mode 100644 arch/alpha/include/asm/rwonce.h
 create mode 100644 arch/arm64/include/asm/alternative-macros.h
 create mode 100644 arch/arm64/include/asm/rwonce.h
 create mode 100644 include/asm-generic/rwonce.h
 create mode 100644 tools/include/uapi/linux/filter.h

-- 
2.27.0.383.g050319c2ae-goog


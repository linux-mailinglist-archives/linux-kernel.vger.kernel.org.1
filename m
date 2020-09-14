Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A2F269430
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgINRwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:52:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgINRve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 13:51:34 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D412D20EDD;
        Mon, 14 Sep 2020 17:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600105893;
        bh=+W154uhJfcW+3dGlx8nbYvFm09M/SqFlf9nyb6yidk0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=1AE29D7GV8Mh9ynwf9JgkqD4N6MDy5L0l9ovl3XrpC+RWx15isRlxZLRj9r5vr1RZ
         yHpWTfQpsw5IL2Q/1Wt+UtgFd2XFTZeeKqC9LvtrAbP2/sfNvjOXxCXxRuvWf4j8G0
         Vneq8zUzSBqG2p0mkwQR38U6CVtiGSiWBJG6dWuk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9C58F3522BA0; Mon, 14 Sep 2020 10:51:33 -0700 (PDT)
Date:   Mon, 14 Sep 2020 10:51:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, elver@google.com
Subject: [GIT PULL kcsan] KCSAN commits for v5.10
Message-ID: <20200914175133.GA14094@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ingo!

This pull request contains KCSAN updates for v5.10.  These have been
subjected to LKML review, most recently here:

	https://lore.kernel.org/lkml/20200831181715.GA1530@paulmck-ThinkPad-P72

All of these have also been subjected to the kbuild test robot and
-next testing.  The following changes since v5.9-rc1 are available in
the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git kcsan

for you to fetch changes up to cd290ec24633f51029dab0d25505fae7da0e1eda:

  kcsan: Use tracing-safe version of prandom (2020-08-30 21:50:13 -0700)

----------------------------------------------------------------
Marco Elver (19):
      kcsan: Add support for atomic builtins
      objtool: Add atomic builtin TSAN instrumentation to uaccess whitelist
      kcsan: Add atomic builtin test case
      kcsan: Support compounded read-write instrumentation
      objtool, kcsan: Add __tsan_read_write to uaccess whitelist
      kcsan: Skew delay to be longer for certain access types
      kcsan: Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks
      kcsan: Test support for compound instrumentation
      instrumented.h: Introduce read-write instrumentation hooks
      asm-generic/bitops: Use instrument_read_write() where appropriate
      locking/atomics: Use read-write instrumentation for atomic RMWs
      kcsan: Simplify debugfs counter to name mapping
      kcsan: Simplify constant string handling
      kcsan: Remove debugfs test command
      kcsan: Show message if enabled early
      kcsan: Use pr_fmt for consistency
      kcsan: Optimize debugfs stats counters
      bitops, kcsan: Partially revert instrumentation for non-atomic bitops
      kcsan: Use tracing-safe version of prandom

 include/asm-generic/atomic-instrumented.h          | 330 ++++++++++-----------
 include/asm-generic/bitops/instrumented-atomic.h   |   6 +-
 include/asm-generic/bitops/instrumented-lock.h     |   2 +-
 .../asm-generic/bitops/instrumented-non-atomic.h   |  30 +-
 include/linux/instrumented.h                       |  30 ++
 include/linux/kcsan-checks.h                       |  45 ++-
 kernel/kcsan/core.c                                | 210 +++++++++++--
 kernel/kcsan/debugfs.c                             | 130 ++------
 kernel/kcsan/kcsan-test.c                          | 128 +++++++-
 kernel/kcsan/kcsan.h                               |  12 +-
 kernel/kcsan/report.c                              |  10 +-
 kernel/kcsan/selftest.c                            |   8 +-
 lib/Kconfig.kcsan                                  |   5 +
 scripts/Makefile.kcsan                             |   2 +-
 scripts/atomic/gen-atomic-instrumented.sh          |  21 +-
 tools/objtool/check.c                              |  55 ++++
 16 files changed, 677 insertions(+), 347 deletions(-)

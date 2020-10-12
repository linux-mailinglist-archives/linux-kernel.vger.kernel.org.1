Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7002128BD01
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbgJLPzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbgJLPzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:55:45 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926D2C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 08:55:45 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l24so17523945edj.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 08:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=J22b/w7syzaCBzkYdGdKNNSK+qnL7HdTU6ZmewqeGXE=;
        b=m8yxRnTngqc/OGWZ6wMTzbKI+q7qAYXLW6qXzeezFSXETj/Jk5Qeq++x1L8c5Xc3j6
         Y7NbMcBl0duqhJlZDzZ+4vciAFLdO7YpXUvzFEaCdZSQPNxHr2e/5sSAjd//F1kuAPMn
         wm12GuhXylfyVVPOeZgbitBexdL8vfPJzVvEVcQcWRBW0DfDHInk3BXfY/Hf7CKVO4VA
         Y7fQDwjfLY4meXdFC0cImbrPBv1jC3t13QOxgJoBgSQIcNzOTewdck+JLfviKlec3uZf
         8QcLVfy1VWJ/8LB1SVArOOprjnlB2EZd0Q9UXWPBAWRyaDgZ1KayW2UPMsmJUEvBt1PP
         fWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=J22b/w7syzaCBzkYdGdKNNSK+qnL7HdTU6ZmewqeGXE=;
        b=S+bVNiqZJxlChEjQmGOvT81FvPivnc7R6DdT4txtexbXB1SkPP2sNlDiJyy7KCZSUF
         eTAKBJ3BaW/JYkwB4FBB6nvAw/bK09vzjPRTEcGMymtgsGk4WBRznrduXwclfW6Ihq5X
         UEjubjxC9bj5oA4XimImVFCNqHi8App1shTu6C149EVHHwfj9upX/j0mFwjhhMOozPSn
         I1KnGPlAGyNcg0ymZCyKxYVGey/LK8M0BbvSNYqOaWlyBbgpMZj2OeOS/sUk+YF3AZ0G
         2vz4pT9coQkS5vYLI4xEJEODT9a6hKbx43g4HGV99ZSFbC56qnYPAVtsX7Oxd80PRi0I
         kOHA==
X-Gm-Message-State: AOAM5307K/jgZIVwtFEif1y88mjxLHfGSQw3sZpcldm9/27SOsE1fDzt
        k5J3UL+O7u8GY5UiCTE/7J4=
X-Google-Smtp-Source: ABdhPJy/6BKanCysOzW6UlQurYRbDRCViBL2b43/b31mnaCYL3/ODYd/OOVS4J+XJ0+g8K98lliYOA==
X-Received: by 2002:aa7:da12:: with SMTP id r18mr14534437eds.169.1602518144300;
        Mon, 12 Oct 2020 08:55:44 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id n13sm1081310ejg.93.2020.10.12.08.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 08:55:43 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 12 Oct 2020 17:55:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [GIT PULL] Static calls for v5.10
Message-ID: <20201012155542.GA3557765@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core/static_call git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-static_call-2020-10-12

   # HEAD: 69e0ad37c9f32d5aa1beb02aab4ec0cd055be013 static_call: Fix return type of static_call_init

This tree introduces static_call(), which is the idea of static_branch()
applied to indirect function calls. Remove a data load (indirection) by
modifying the text.

They give the flexibility of function pointers, but with better
performance. (This is especially important for cases where
retpolines would otherwise be used, as retpolines can be pretty
slow.)

API overview:

  DECLARE_STATIC_CALL(name, func);
  DEFINE_STATIC_CALL(name, func);
  DEFINE_STATIC_CALL_NULL(name, typename);

  static_call(name)(args...);
  static_call_cond(name)(args...);
  static_call_update(name, func);

x86 is supported via text patching, otherwise basic indirect calls are used,
with function pointers.

There's a second variant using inline code patching, inspired by jump-labels,
implemented on x86 as well.

The new APIs are utilized in the x86 perf code, a heavy user of function pointers,
where static calls speed up the PMU handler by 4.2% (!).

The generic implementation is not really excercised on other architectures,
outside of the trivial test_static_call_init() self-test.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
 Thanks,

	Ingo

------------------>
Josh Poimboeuf (5):
      compiler.h: Make __ADDRESSABLE() symbol truly unique
      static_call: Add basic static call infrastructure
      static_call: Add inline static call infrastructure
      x86/static_call: Add out-of-line static call implementation
      x86/static_call: Add inline static call implementation for x86-64

Nathan Chancellor (1):
      static_call: Fix return type of static_call_init

Peter Zijlstra (12):
      notifier: Fix broken error handling pattern
      module: Fix up module_notifier return values
      module: Properly propagate MODULE_STATE_COMING failure
      jump_label,module: Fix module lifetime for __jump_label_mod_text_reserved()
      static_call: Avoid kprobes on inline static_call()s
      static_call: Add simple self-test for static calls
      x86/alternatives: Teach text_poke_bp() to emulate RET
      static_call: Add static_call_cond()
      static_call: Handle tail-calls
      static_call: Add some validation
      static_call: Allow early init
      x86/perf, static_call: Optimize x86_pmu methods

Steven Rostedt (VMware) (2):
      tracepoint: Optimize using static_call()
      tracepoint: Fix out of sync data passing by static caller

peterz@infradead.org (1):
      tracepoint: Fix overly long tracepoint names


 arch/Kconfig                            |  13 +
 arch/x86/Kconfig                        |   4 +-
 arch/x86/events/core.c                  | 134 ++++++---
 arch/x86/include/asm/static_call.h      |  40 +++
 arch/x86/include/asm/text-patching.h    |  19 ++
 arch/x86/kernel/Makefile                |   1 +
 arch/x86/kernel/alternative.c           |   5 +
 arch/x86/kernel/kprobes/opt.c           |   4 +-
 arch/x86/kernel/setup.c                 |   2 +
 arch/x86/kernel/static_call.c           |  98 +++++++
 arch/x86/kernel/vmlinux.lds.S           |   1 +
 drivers/oprofile/buffer_sync.c          |   4 +-
 include/asm-generic/vmlinux.lds.h       |  13 +
 include/linux/compiler.h                |   2 +-
 include/linux/module.h                  |   5 +
 include/linux/notifier.h                |  15 +-
 include/linux/static_call.h             | 298 ++++++++++++++++++++
 include/linux/static_call_types.h       |  35 +++
 include/linux/tracepoint-defs.h         |   5 +
 include/linux/tracepoint.h              |  86 ++++--
 include/trace/define_trace.h            |  14 +-
 kernel/Makefile                         |   1 +
 kernel/cpu_pm.c                         |  48 ++--
 kernel/jump_label.c                     |  10 +-
 kernel/kprobes.c                        |   2 +
 kernel/module.c                         |  15 +-
 kernel/notifier.c                       | 144 ++++++----
 kernel/power/hibernate.c                |  39 ++-
 kernel/power/main.c                     |   8 +-
 kernel/power/power.h                    |   3 +-
 kernel/power/suspend.c                  |  14 +-
 kernel/power/user.c                     |  14 +-
 kernel/static_call.c                    | 482 ++++++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c                |   8 +-
 kernel/trace/trace.c                    |   2 +-
 kernel/trace/trace_events.c             |   2 +-
 kernel/trace/trace_printk.c             |   4 +-
 kernel/tracepoint.c                     |  39 ++-
 tools/include/linux/static_call_types.h |  35 +++
 tools/objtool/check.c                   | 138 +++++++++
 tools/objtool/check.h                   |   1 +
 tools/objtool/elf.c                     |   8 +-
 tools/objtool/elf.h                     |   3 +-
 tools/objtool/objtool.h                 |   1 +
 tools/objtool/orc_gen.c                 |   4 +-
 tools/objtool/sync-check.sh             |   1 +
 tools/power/pm-graph/sleepgraph.py      |   2 +-
 47 files changed, 1585 insertions(+), 241 deletions(-)
 create mode 100644 arch/x86/include/asm/static_call.h
 create mode 100644 arch/x86/kernel/static_call.c
 create mode 100644 include/linux/static_call.h
 create mode 100644 include/linux/static_call_types.h
 create mode 100644 kernel/static_call.c
 create mode 100644 tools/include/linux/static_call_types.h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CFA2A9474
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgKFKhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgKFKhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:37:51 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F1CC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 02:37:51 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id n18so793571wrs.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 02:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6M9PqsVQ6w1K95Vv3V5suIvowhnAPGzDV9z7R3SVjWM=;
        b=X+35wcHHLbk44vs217bg5jdDCau+AwyaGVxkHy2AWscagQdnDzs6xLBILWtUWe2gY2
         I46PGliEx6waIAO+EVOldFLjaY6hOi6ZjPYwwF3smlFwb20JeHCyHray5bZLr2kul2sD
         TiT+55HBQmGaSq+vvFwXftqt6EtFaW1DB2K9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6M9PqsVQ6w1K95Vv3V5suIvowhnAPGzDV9z7R3SVjWM=;
        b=qcp/jQFQgA7W9dfWuDwXK56hHAKA8BDBTbGG1USXMBqTOBlsyYLO0iHCe7ddGvRFHi
         moX1SPB22IBQHPVNL36AJKGaC8vMHXKJdy/5oLLIYT7LWlA74w2c2fkfhASYarU3DtrT
         l3LqCJ7GHWvkUdIXPT/qhQ6mhO2yisiuUMMFgFYrtfROs2+yv7+d42EP8Xr2kbTY7MkV
         ACF+fQhWI7zmQL0CxqPq0TjETWRR4o5A+U0G8Q/scqQvVk7HvDhh36Ysv1k3SG95/6Cu
         rq/T1CnupVPYI2VWmHNz5DEPmHOuasPb/OhemKbXNXCZ6ijzmZ4nXHj/oeNRCopckNIX
         Du2Q==
X-Gm-Message-State: AOAM530oLTMUqrMansfOOWRI5rGcBChuQPagsf9//TTlNrAZYuOuiMGa
        vMeU8Y+MFT57yaSpudEdGRHqfKhqNRqpOMQI
X-Google-Smtp-Source: ABdhPJw1Q11+DjsJvGu3FftQ+yUokOXHGd8As2B3AQgserWa1UXtdasyMHRTSCQdzgRt1iyFnklHDg==
X-Received: by 2002:adf:f4c9:: with SMTP id h9mr1846319wrp.332.1604659069744;
        Fri, 06 Nov 2020 02:37:49 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id t1sm1537639wrs.48.2020.11.06.02.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 02:37:49 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v6 0/9] Implement task_local_storage
Date:   Fri,  6 Nov 2020 10:37:38 +0000
Message-Id: <20201106103747.2780972-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

# v5 -> v6

- Using a wrapper for copy_file_range in selftests since it's missing
  in older libcs.
- Added Martin's acks.

# v4 -> v5

- Fixes to selftests as suggested by Martin.
- Added Martin's acks.

# v3 -> v4

- Move the patch that exposes spin lock helpers to LSM programs as the
  first patch as some of the changes in the implementation are actually
  for spin locks.
- Clarify the comment in the bpf_task_storage_{get, delete} helper as
  discussed with Martin.
- Added Martin's ack and rebased.

# v2 -> v3

- Added bpf_spin_locks to the selftests for local storage, found that
  these are not available for LSM programs.
- Made spin lock helpers available for LSM programs (except sleepable
  programs which need more work).
- Minor fixes for includes and added short commit messages for patches
  that were split up for libbpf and bpftool.
- Added Song's acks.

# v1 -> v2

- Updated the refcounting for task_struct and simplified conversion
  of fd -> struct pid.
- Some fixes suggested by Martin and Andrii, notably:
   * long return type for the bpf_task_storage_delete helper (update
     for bpf_inode_storage_delete will be sent separately).
   * Remove extra nullness check to task_storage_ptr in map syscall
     ops.
   * Changed the argument signature of the BPF helpers to use
     task_struct pointer in uapi headers.
   * Remove unnecessary verifier logic for the bpf_get_current_task_btf
     helper.
   * Split the changes for bpftool and libbpf.
- Exercised syscall operations for local storage (kept a simpler verison
  in test_local_storage.c, the eventual goal will be to update
  sk_storage_map.c for all local storage types).
- Formatting fixes + Rebase.

We already have socket and inode local storage since [1]

This patch series:

* Implements bpf_local_storage for task_struct.
* Implements the bpf_get_current_task_btf helper which returns a BTF
  pointer to the current task. Not only is this generally cleaner
  (reading from the task_struct currently requires BPF_CORE_READ), it
  also allows the BTF pointer to be used in task_local_storage helpers.
* In order to implement this helper, a RET_PTR_TO_BTF_ID is introduced
  which works similar to RET_PTR_TO_BTF_ID_OR_NULL but does not require
  a nullness check.
* Implements a detection in selftests which uses the
  task local storage to deny a running executable from unlinking itself.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=f836a56e84ffc9f1a1cd73f77e10404ca46a4616

KP Singh (9):
  bpf: Allow LSM programs to use bpf spin locks
  bpf: Implement task local storage
  libbpf: Add support for task local storage
  bpftool: Add support for task local storage
  bpf: Implement get_current_task_btf and RET_PTR_TO_BTF_ID
  bpf: Fix tests for local_storage
  bpf: Update selftests for local_storage to use vmlinux.h
  bpf: Add tests for task_local_storage
  bpf: Exercise syscall operations for inode and sk storage

 include/linux/bpf.h                           |   1 +
 include/linux/bpf_lsm.h                       |  23 ++
 include/linux/bpf_types.h                     |   1 +
 include/uapi/linux/bpf.h                      |  48 +++
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/bpf_lsm.c                          |   8 +
 kernel/bpf/bpf_task_storage.c                 | 315 ++++++++++++++++++
 kernel/bpf/syscall.c                          |   3 +-
 kernel/bpf/verifier.c                         |  37 +-
 kernel/trace/bpf_trace.c                      |  16 +
 security/bpf/hooks.c                          |   2 +
 .../bpf/bpftool/Documentation/bpftool-map.rst |   3 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/map.c                       |   4 +-
 tools/include/uapi/linux/bpf.h                |  48 +++
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 .../bpf/prog_tests/test_local_storage.c       | 200 ++++++++++-
 .../selftests/bpf/progs/local_storage.c       | 103 ++++--
 18 files changed, 757 insertions(+), 59 deletions(-)
 create mode 100644 kernel/bpf/bpf_task_storage.c

-- 
2.29.1.341.ge80a0c044ae-goog


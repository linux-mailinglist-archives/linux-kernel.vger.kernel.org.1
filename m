Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4BA2A8A4C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732683AbgKEW7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732329AbgKEW6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:58:34 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4848DC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 14:58:32 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p22so3147222wmg.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 14:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z2MoG1dNocrYLMkGvti/5lGWVbZAkgu8eHdWXL51PkE=;
        b=a1PMF0q8b3pGOBvYXofS9aaWLi9CHmO6TYIcj+L84FKVLDxFytw/dUeqAMox4TI5r/
         5ryKWzrHWoshZKyHx8h33Hyy84T2qta8zjWk6hZ84b6NvoptnHxk/OoO1ldtQtF3VVCB
         U3Fi/zyOesG1TJqcjUCQV6nlTQp8Jzn6p3ZbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z2MoG1dNocrYLMkGvti/5lGWVbZAkgu8eHdWXL51PkE=;
        b=T+niuLCab85F3dSzAy3iuB6KCgS+aFFOjhHVc+KSZpXcPih4zAO0Zs1UqCSBKZ8DVp
         lhm1NuZLh/0g/ZbvV/XlYV/XNVlquxYkuSP6xfdP+rEzpXHLDdwAGhX0HJ/IhuCApElv
         TqNYt3SSGLlRXkqyCohTCZMd/fbaTbg0WK61umicpfmJwZyKPILIDYt1opzX+DClCdPx
         PdGywXCoHKwQST9FgnNXBG/qYG0G1e4Q51CWTYK5+r0Gg5eGjAaJwgbtwLP9p3uFZi+v
         FSIqR4d5LP8EhtQ++9UfgENl9NtuBNJL9v9U82Hq9F0TXSuoDDJnFTHW5YAAf0ZfmAhD
         UplA==
X-Gm-Message-State: AOAM5302wPzZBtYJ6vIIrZlwRDPy/ZbQXfpq7ttaZmp0HgrtlTC0ON1D
        rsPwP9nS6LGcnbst5mRD6JyUeDZBVXp4/+JQ
X-Google-Smtp-Source: ABdhPJzE+TyuSRNnF4lzzS++vhH/Sgrw4tMf9yO+PESrUJCOPHFOoUuxq8FLHIqD2Rei3PCZhs7ZHg==
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr4839465wmf.37.1604617110689;
        Thu, 05 Nov 2020 14:58:30 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id f19sm3977366wml.21.2020.11.05.14.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 14:58:29 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v5 0/9] Implement task_local_storage
Date:   Thu,  5 Nov 2020 22:58:18 +0000
Message-Id: <20201105225827.2619773-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

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
 .../bpf/prog_tests/test_local_storage.c       | 195 ++++++++++-
 .../selftests/bpf/progs/local_storage.c       | 103 ++++--
 18 files changed, 752 insertions(+), 59 deletions(-)
 create mode 100644 kernel/bpf/bpf_task_storage.c

-- 
2.29.1.341.ge80a0c044ae-goog


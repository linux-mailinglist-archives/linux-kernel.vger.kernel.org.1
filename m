Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE462A49D7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgKCPbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCPbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:31:39 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EFFC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:31:39 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h62so8386554wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C1OwOdZbVZkD+L5PGfTjlD9ufqYh7WPaMmVHnEknv2k=;
        b=nxbkeczEA9hMFJvKILBbwYimkJFAsHZ2mI4+7iRSpOI0s4xDmH275aqdqHzew39P/4
         MIXRZuqH6wqhC0GNAFUzl3A3gbP6c8tNN3n0Bbckm+v1wTVQgojN97JrgtJbY2q7dbt3
         c4zEdB6qJHS3KmmqPTRUF6kHiDuGdS2vNtRZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C1OwOdZbVZkD+L5PGfTjlD9ufqYh7WPaMmVHnEknv2k=;
        b=kVGQcelbOd0tY1OiCPo5v+XYfkWukY1mIfvFOr2L78/jZPiHhEUjRHhR3z3rhnLwOt
         mpBsOlnnzA0PS/Y1rx5S5W6XiX3kjv7o5v8XF+cZpH3cCoA/7xuzHK1RR0ER3dHi2j6b
         lwuWzvMx2GoiXVLEmewHj3i8mLUwdQ8nef/ukd9nPXnrg/wOLPEg24vv0/pRFsvZ8E4j
         0xUpEhRuquOVe9FN+PrJQgtpNO/BpnrAbB6cHaha0nSCMY6dCKjqx8hggqezX8G4gWBs
         LQS/a/+axRXmuWZUacoWhVip+TMsqsYn2RBAklI4tFzueeyXYA2OvLTX/xseQudI3J8x
         VNAg==
X-Gm-Message-State: AOAM53112bVaizaVBnklrhfn6UgXuq+vWms66iK7KhKu54pq2eBgJ49Y
        5Xu0nPs9qn3IrqoGaMJNDfuDTFoKPjbyxzXG
X-Google-Smtp-Source: ABdhPJwQLMm2OkckMfMF3HwMs+LiH7QUs5htucqAE3ZDwWM1FzDZFaSRk+3rNft1uArL95j1W1LMkw==
X-Received: by 2002:a1c:4144:: with SMTP id o65mr292934wma.171.1604417497765;
        Tue, 03 Nov 2020 07:31:37 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id m126sm2451966wmm.0.2020.11.03.07.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:31:37 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v2 0/8]  Implement task_local_storage
Date:   Tue,  3 Nov 2020 16:31:24 +0100
Message-Id: <20201103153132.2717326-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

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

KP Singh (8):
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
 kernel/bpf/bpf_lsm.c                          |   4 +
 kernel/bpf/bpf_task_storage.c                 | 313 ++++++++++++++++++
 kernel/bpf/syscall.c                          |   3 +-
 kernel/bpf/verifier.c                         |  17 +-
 kernel/trace/bpf_trace.c                      |  16 +
 security/bpf/hooks.c                          |   2 +
 .../bpf/bpftool/Documentation/bpftool-map.rst |   3 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/map.c                       |   4 +-
 tools/include/uapi/linux/bpf.h                |  48 +++
 tools/lib/bpf/libbpf_probes.c                 |   2 +
 .../bpf/prog_tests/test_local_storage.c       | 181 +++++++++-
 .../selftests/bpf/progs/local_storage.c       |  87 +++--
 18 files changed, 705 insertions(+), 51 deletions(-)
 create mode 100644 kernel/bpf/bpf_task_storage.c

-- 
2.29.1.341.ge80a0c044ae-goog


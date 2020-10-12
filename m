Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04C628C494
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 00:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388614AbgJLWPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 18:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387733AbgJLWPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 18:15:35 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90680C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 15:15:34 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u24so15817143pgi.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 15:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=BKYX+JmWfXuwrCDmdV8EzGOvf57b0HcqGp36a/NsrYs=;
        b=Z7tMEutwDeyWrAC5UnbnozDqy6eKxwJc5Rh7LnrrTGwM2z2a1lneHoN75Rd60BFyQQ
         qxeDOFAv+BjEFK4y4Qi75JcSY1z0XOb+fh263beY/+WLp5gwncLCurdTa78HnuX95U/E
         NYW7+z0RYqyTnv8PlOIwItstbg/+bMn06cMC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=BKYX+JmWfXuwrCDmdV8EzGOvf57b0HcqGp36a/NsrYs=;
        b=qxKc86viOm3VQk3KdAR8arE86MlTf4xU1136VFK6+SfDVhhr18ZVwiA+h/iijom+gg
         GUlhC5mG4XrHzUae0Vj2pGa1mpaoKnc+8qT/syEvLFqP1en5QP7qBDV7s5/14AIsIGPE
         j3nPKYlZ7z+GARFy93JjsrJRmpJDWdt71nvE4c9EGWKfhmYCph/BFhHpley39t99xXjE
         fVkG738em6rI78ng9gzFLK46H0JB/6Of7DdLjT4QBFYlYraHkLGJQVFiaK9A44WopvLc
         cvml5pmGR+3QvKWLVulCSTGUiigOTPpITeuVB9gHEvHx0qsTLiuycQRRQNLqiRMXx0fJ
         cqYQ==
X-Gm-Message-State: AOAM532WbIgsFrre4VrenGE/LREy8RSele+d0eAlSfA+G+rl7rI59KLd
        7XcgkFNq5pqaNc+P0mcXcv/KQg==
X-Google-Smtp-Source: ABdhPJypPY6QUWUyRVWmuIUOQMJpWDH5GMtfJQMvdaXxSCkhB88JoiVV53OIF985PG+Pr56L2KzBVw==
X-Received: by 2002:a17:90a:4a8a:: with SMTP id f10mr21779242pjh.60.1602540934064;
        Mon, 12 Oct 2020 15:15:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 128sm12552892pfd.110.2020.10.12.15.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 15:15:33 -0700 (PDT)
Date:   Mon, 12 Oct 2020 15:15:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Denis Efremov <efremov@linux.com>,
        Hulk Robot <hulkci@huawei.com>, Jann Horn <jannh@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        YiFei Zhu <yifeifz2@illinois.edu>, Zou Wei <zou_wei@huawei.com>
Subject: [GIT PULL] seccomp updates for v5.10-rc1
Message-ID: <202010121512.015F57CC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these seccomp updates for v5.10-rc1. The bulk of the changes
are with the seccomp selftests to accommodate some powerpc-specific
behavioral characteristics. Additional cleanups, fixes, and improvements
are also included, noted in the tag description.

Thanks!

-Kees

The following changes since commit e839317900e9f13c83d8711d684de88c625b307a:

  seccomp: don't leave dangling ->notif if file allocation fails (2020-09-08 11:30:16 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.10-rc1

for you to fetch changes up to dfe719fef03d752f1682fa8aeddf30ba501c8555:

  seccomp: Make duplicate listener detection non-racy (2020-10-08 13:17:47 -0700)

----------------------------------------------------------------
seccomp updates for v5.10-rc1

- heavily refactor seccomp selftests (and clone3 selftests dependency) to
  fix powerpc (Kees Cook, Thadeu Lima de Souza Cascardo)
- fix style issue in selftests (Zou Wei)
- upgrade "unknown action" from KILL_THREAD to KILL_PROCESS (Rich Felker)
- replace task_pt_regs(current) with current_pt_regs() (Denis Efremov)
- fix corner-case race in USER_NOTIF (Jann Horn)
- make CONFIG_SECCOMP no longer per-arch (YiFei Zhu)

----------------------------------------------------------------
Denis Efremov (1):
      seccomp: Use current_pt_regs() instead of task_pt_regs(current)

Jann Horn (1):
      seccomp: Make duplicate listener detection non-racy

Kees Cook (18):
      selftests/seccomp: Add test for unknown SECCOMP_RET kill behavior
      selftests/seccomp: Use __NR_mknodat instead of __NR_mknod
      selftests/seccomp: Refactor arch register macros to avoid xtensa special case
      selftests/seccomp: Provide generic syscall setting macro
      selftests/seccomp: mips: Define SYSCALL_NUM_SET macro
      selftests/seccomp: arm: Define SYSCALL_NUM_SET macro
      selftests/seccomp: arm64: Define SYSCALL_NUM_SET macro
      selftests/seccomp: mips: Remove O32-specific macro
      selftests/seccomp: Remove syscall setting #ifdefs
      selftests/seccomp: Convert HAVE_GETREG into ARCH_GETREG/ARCH_SETREG
      selftests/seccomp: Convert REGSET calls into ARCH_GETREG/ARCH_SETREG
      selftests/seccomp: Avoid redundant register flushes
      selftests/seccomp: Remove SYSCALL_NUM_RET_SHARE_REG in favor of SYSCALL_RET_SET
      selftests/seccomp: powerpc: Fix seccomp return value testing
      selftests/seccomp: Record syscall during ptrace entry
      selftests/seccomp: Allow syscall nr and ret value to be set separately
      selftests/seccomp: powerpc: Set syscall return during ptrace syscall exit
      selftests/clone3: Avoid OS-defined clone_args

Rich Felker (1):
      seccomp: kill process instead of thread for unknown actions

YiFei Zhu (1):
      seccomp: Move config option SECCOMP to arch/Kconfig

Zou Wei (1):
      selftests/seccomp: Use bitwise instead of arithmetic operator for flags

 arch/Kconfig                                       |  30 ++
 arch/arm/Kconfig                                   |  15 +-
 arch/arm64/Kconfig                                 |  13 -
 arch/csky/Kconfig                                  |  13 -
 arch/microblaze/Kconfig                            |  18 +-
 arch/mips/Kconfig                                  |  17 -
 arch/parisc/Kconfig                                |  16 -
 arch/powerpc/Kconfig                               |  17 -
 arch/riscv/Kconfig                                 |  13 -
 arch/s390/Kconfig                                  |  17 -
 arch/sh/Kconfig                                    |  16 -
 arch/sparc/Kconfig                                 |  18 +-
 arch/um/Kconfig                                    |  16 -
 arch/x86/Kconfig                                   |  16 -
 arch/xtensa/Kconfig                                |  14 -
 kernel/seccomp.c                                   |  64 ++-
 tools/testing/selftests/clone3/clone3.c            |  45 +--
 .../clone3/clone3_cap_checkpoint_restore.c         |   4 +-
 .../selftests/clone3/clone3_clear_sighand.c        |   2 +-
 tools/testing/selftests/clone3/clone3_selftests.h  |  24 +-
 tools/testing/selftests/clone3/clone3_set_tid.c    |   4 +-
 tools/testing/selftests/pidfd/pidfd_setns_test.c   |   2 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c      | 440 +++++++++++++--------
 23 files changed, 397 insertions(+), 437 deletions(-)

-- 
Kees Cook

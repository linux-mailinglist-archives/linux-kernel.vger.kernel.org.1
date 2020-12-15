Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE34B2DB52E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgLOUcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729847AbgLOUbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:31:00 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC259C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 12:30:19 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id hk16so261854pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 12:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=e9zzm+R2LmFzyZFZHdRmTwcJXBH9UsXNS8qT4LY/cVQ=;
        b=SJ80LmsoLLFWKg/D2ZgRbyTQysPvEX/Yok5wny+rGVVusaF+8XIFjl8SmmqVi4nRz6
         FoSjVHKetPNDeU5P4McQnvsPO8xK164ZYnLJeaUaF7nX9S4RaJ1+bnS44h6yNHVN9iJ+
         pK94BwDpMhk0Q2bTTfcJNEkuK87KPDg/ZdA8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=e9zzm+R2LmFzyZFZHdRmTwcJXBH9UsXNS8qT4LY/cVQ=;
        b=jQeJ1sufB3lkal0JjSr2s6BWajN7nKREooVOvY0f0hC+FtPcVJOPBpk5/tvQ9Ubj8o
         eM1ZPKLYmVOOQxUNVa/QuyfbFscLh/FHBHHCT87FcG0iVANCa9XehcwJw1K8KcznI3na
         vR/6TYvfurxKN207kJ1Aip7hAj1LX3U7k1uIBizukKUeNlFf77cOOADn6gb73C395NjX
         vj7WA0DRJfFU6NMs/FrWyDzz+NstjFJYEDT2hqfREpgNGudobK9Y4lKBu4JU32HCtWK4
         9ucqu1YLrZVwd/yEv+Oj5Rp2iNi9aFFap9tZiA6uTC+I3oAOeW6OLG9cMlxdIMgrQdKC
         GGrQ==
X-Gm-Message-State: AOAM531T5RGXG0IRBet555MY3+U/zc/StIazCpuESa0JZFfuEo8Earld
        pXr4K6KwHJhqG05Fqh88NOwAZg==
X-Google-Smtp-Source: ABdhPJzbYXQTd4WxKaaYP2s5imT1w8vmSWlTqRd4ZQgP64S9MtPmLtE0uWQ+niuha5WGR47g+ZzhWA==
X-Received: by 2002:a17:90a:c203:: with SMTP id e3mr567991pjt.8.1608064219364;
        Tue, 15 Dec 2020 12:30:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b13sm26064375pgr.59.2020.12.15.12.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 12:30:18 -0800 (PST)
Date:   Tue, 15 Dec 2020 12:30:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Shuah Khan <shuah@kernel.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Tyler Hicks <code@tyhicks.com>,
        YiFei Zhu <yifeifz2@illinois.edu>
Subject: [GIT PULL] seccomp updates for v5.11-rc1
Message-ID: <202012151225.4881A90257@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these seccomp updates for v5.11-rc1. The major change here
is finally gaining seccomp constant-action bitmaps, which internally
reduces the seccomp overhead for many real-world syscall filters to O(1),
as discussed at Plumbers this year.

Thanks!

-Kees

The following changes since commit 4c222f31fb1db4d590503a181a6268ced9252379:

  selftests/seccomp: sh: Fix register names (2020-11-20 11:03:08 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.11-rc1

for you to fetch changes up to 2c07343abd8932200a45ff7b10950e71081e9e77:

  selftests/seccomp: Update kernel config (2020-12-02 11:20:54 -0800)

----------------------------------------------------------------
seccomp updates for v5.11-rc1

- Improve seccomp performance via constant-action bitmaps (YiFei Zhu & Kees Cook)

- Fix bogus __user annotations (Jann Horn)

- Add missed CONFIG for improved selftest coverage (Mickaël Salaün)

----------------------------------------------------------------
Jann Horn (1):
      seccomp: Remove bogus __user annotations

Kees Cook (5):
      x86: Enable seccomp architecture tracking
      selftests/seccomp: Compare bitmap vs filter overhead
      arm64: Enable seccomp architecture tracking
      arm: Enable seccomp architecture tracking
      Merge branch 'for-linus/seccomp' into for-next/seccomp

Mickaël Salaün (1):
      selftests/seccomp: Update kernel config

YiFei Zhu (10):
      seccomp/cache: Lookup syscall allowlist bitmap for fast path
      seccomp/cache: Add "emulator" to check if filter is constant allow
      csky: Enable seccomp architecture tracking
      parisc: Enable seccomp architecture tracking
      powerpc: Enable seccomp architecture tracking
      riscv: Enable seccomp architecture tracking
      s390: Enable seccomp architecture tracking
      sh: Enable seccomp architecture tracking
      xtensa: Enable seccomp architecture tracking
      seccomp/cache: Report cache data through /proc/pid/seccomp_cache

 arch/Kconfig                                       |  17 ++
 arch/arm/include/asm/Kbuild                        |   1 -
 arch/arm/include/asm/seccomp.h                     |  11 +
 arch/arm64/include/asm/seccomp.h                   |   9 +
 arch/csky/include/asm/Kbuild                       |   1 -
 arch/csky/include/asm/seccomp.h                    |  11 +
 arch/parisc/include/asm/Kbuild                     |   1 -
 arch/parisc/include/asm/seccomp.h                  |  22 ++
 arch/powerpc/include/asm/seccomp.h                 |  23 ++
 arch/riscv/include/asm/seccomp.h                   |  10 +
 arch/s390/include/asm/seccomp.h                    |   9 +
 arch/sh/include/asm/seccomp.h                      |  10 +
 arch/x86/include/asm/seccomp.h                     |  20 ++
 arch/xtensa/include/asm/Kbuild                     |   1 -
 arch/xtensa/include/asm/seccomp.h                  |  11 +
 fs/proc/base.c                                     |   6 +
 include/linux/seccomp.h                            |   7 +
 kernel/seccomp.c                                   | 296 ++++++++++++++++++++-
 tools/testing/selftests/seccomp/config             |   1 +
 .../testing/selftests/seccomp/seccomp_benchmark.c  | 151 +++++++++--
 tools/testing/selftests/seccomp/settings           |   2 +-
 21 files changed, 590 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm/include/asm/seccomp.h
 create mode 100644 arch/csky/include/asm/seccomp.h
 create mode 100644 arch/parisc/include/asm/seccomp.h
 create mode 100644 arch/xtensa/include/asm/seccomp.h

-- 
Kees Cook

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A663C2A44EE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgKCMR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:17:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbgKCMR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:17:28 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2247A22243;
        Tue,  3 Nov 2020 12:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604405847;
        bh=1yG+ugvbyY332aQcWxBv875AgHKiSKEXSCfbLB3xw2E=;
        h=From:To:Cc:Subject:Date:From;
        b=Z/QB7ey89hqG6c6HYei4ONj3+sYiXpfrd/BDSI16g+huhHXs9hVaoZEbXW/yAjjku
         6gpgHF5UEBd5IgSs5rjaUFeC3OoEi80sJpOX/pv14bUSlena/IVqtVWPe+mORPIp0K
         516mV9okKyG5r2uFhmcirQgemUlQKx1vjOKDFUig=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] Upgrade READ_ONCE() to RCpc acquire on arm64 with LTO
Date:   Tue,  3 Nov 2020 12:17:17 +0000
Message-Id: <20201103121721.5166-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

These patches were previously posted as part of a larger series enabling
architectures to override __READ_ONCE():

  v3: https://lore.kernel.org/lkml/20200710165203.31284-1-will@kernel.org/

With the bulk of that merged, the four patches here override READ_ONCE()
so that it gains RCpc acquire semantics on arm64 when LTO is enabled. We
can revisit this as and when the compiler provides a means for us to reason
about the result of dependency-breaking optimisations. In the meantime,
this unblocks LTO for arm64, which I would really like to see merged so
that we can focus on enabling CFI.

I plan to queue these on their own branch in the arm64 tree for 5.11 at
-rc3.

Cheers,

Will

Cc: Kees Cook <keescook@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org

--->8

Will Deacon (4):
  arm64: alternatives: Split up alternative.h
  arm64: cpufeatures: Add capability for LDAPR instruction
  arm64: alternatives: Remove READ_ONCE() usage during patch operation
  arm64: lto: Strengthen READ_ONCE() to acquire when CONFIG_LTO=y

 arch/arm64/Kconfig                          |   3 +
 arch/arm64/include/asm/alternative-macros.h | 276 ++++++++++++++++++++
 arch/arm64/include/asm/alternative.h        | 267 +------------------
 arch/arm64/include/asm/cpucaps.h            |   3 +-
 arch/arm64/include/asm/insn.h               |   3 +-
 arch/arm64/include/asm/rwonce.h             |  63 +++++
 arch/arm64/kernel/alternative.c             |   7 +-
 arch/arm64/kernel/cpufeature.c              |  10 +
 arch/arm64/kernel/vdso/Makefile             |   2 +-
 arch/arm64/kernel/vdso32/Makefile           |   2 +-
 arch/arm64/kernel/vmlinux.lds.S             |   2 +-
 11 files changed, 364 insertions(+), 274 deletions(-)
 create mode 100644 arch/arm64/include/asm/alternative-macros.h
 create mode 100644 arch/arm64/include/asm/rwonce.h

-- 
2.29.1.341.ge80a0c044ae-goog


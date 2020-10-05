Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4170283FA6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgJETaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:30:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgJETaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:30:08 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAE2A207BC;
        Mon,  5 Oct 2020 19:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601926207;
        bh=bLrVrlAMFW138CfKgGgUmo2QXQO7OYK7GouqRp1dvrs=;
        h=From:To:Cc:Subject:Date:From;
        b=hsUMVkyf2NoICrYoNKKsQ92UXHb7NkC693e8RylFvyxrxi5Jz/fvJcdgk2+OHhK0h
         Z+9oYp74FwQRjT8F0snC0km2k9DpBaIp/9B04eG56R27o8d4opGUzUaxGsN+/x11XD
         ib02QlyBN8D8GGZQwyMOCVZpf5gNRMMzTYdlB47Y=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/2] Clean up x86_32 stackprotector
Date:   Mon,  5 Oct 2020 12:30:02 -0700
Message-Id: <cover.1601925251.git.luto@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86_32 stackprotector is a maintenance nightmare.  Clean it up.  This
disables stackprotector on x86_32 on GCC 8.1 and on all clang
versions -- I'll file a bug for the latter.

Andy Lutomirski (2):
  x86/stackprotector/32: Make the canary into a regular percpu variable
  x86/entry/32: Remove leftover macros after stackprotector cleanups

 arch/x86/Kconfig                          |  7 +-
 arch/x86/Makefile                         |  4 +
 arch/x86/entry/entry_32.S                 | 95 +----------------------
 arch/x86/include/asm/processor.h          | 15 +---
 arch/x86/include/asm/ptrace.h             |  5 +-
 arch/x86/include/asm/segment.h            | 27 ++-----
 arch/x86/include/asm/stackprotector.h     | 79 ++++---------------
 arch/x86/include/asm/suspend_32.h         |  2 -
 arch/x86/kernel/asm-offsets_32.c          |  5 --
 arch/x86/kernel/cpu/common.c              |  5 +-
 arch/x86/kernel/doublefault_32.c          |  4 +-
 arch/x86/kernel/head_32.S                 | 18 +----
 arch/x86/kernel/setup_percpu.c            |  1 -
 arch/x86/kernel/tls.c                     |  8 +-
 arch/x86/kvm/svm/svm.c                    | 11 +--
 arch/x86/lib/insn-eval.c                  |  4 -
 arch/x86/platform/pvh/head.S              | 14 ----
 arch/x86/power/cpu.c                      |  6 +-
 scripts/gcc-x86_32-has-stack-protector.sh |  6 +-
 19 files changed, 56 insertions(+), 260 deletions(-)

-- 
2.26.2


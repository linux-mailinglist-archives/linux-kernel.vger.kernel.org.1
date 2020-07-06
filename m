Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB378215B2B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 17:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgGFPtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 11:49:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60973 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbgGFPtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:49:21 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jsTMt-0005O9-PC; Mon, 06 Jul 2020 15:49:19 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Serge Hallyn <serge@hallyn.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Safonov <dima@arista.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 0/4] nsproxy: support CLONE_NEWTIME with setns()
Date:   Mon,  6 Jul 2020 17:49:08 +0200
Message-Id: <20200706154912.3248030-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <https://lore.kernel.org/lkml/20200625090618.GC151695@gmail.com>
References: <https://lore.kernel.org/lkml/20200625090618.GC151695@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

After having synced with Andrei with the ARM time namespace support
patchset we've decided to make vdso_join_timens() a function that cannot
fail but not yet change its return type so the changes for ARM can
proceed independently. We will simply have a follow-up patch right after
these changes land during the v5.9 merge window that changes
vdso_join_timens() from returning an int to void.

So far setns() with pidfds was missing time namespace support. This was
partially due to it simply not being implemented but also because
vdso_join_timens() could still fail which made switching to multiple
namespaces atomically problematic. This series first fixes
vdso_join_timens() to never fail, introduces timens_commit() and finally
adds CLONE_NEWTIME support for setns().

Thanks!
Christian

Christian Brauner (4):
  timens: make vdso_join_timens() always succeed
  timens: add timens_commit() helper
  nsproxy: support CLONE_NEWTIME with setns()
  tests: add CLONE_NEWTIME setns tests

 arch/x86/entry/vdso/vma.c                     |  5 +-
 include/linux/time_namespace.h                |  6 ++
 kernel/nsproxy.c                              | 21 ++++-
 kernel/time/namespace.c                       | 22 ++----
 tools/testing/selftests/pidfd/pidfd.h         |  4 +
 .../selftests/pidfd/pidfd_setns_test.c        | 76 +++++++++++++++++++
 6 files changed, 115 insertions(+), 19 deletions(-)


base-commit: dcb7fd82c75ee2d6e6f9d8cc71c52519ed52e258
-- 
2.27.0


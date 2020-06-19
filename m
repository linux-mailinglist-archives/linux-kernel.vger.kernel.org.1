Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872FB2010FD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 17:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405103AbgFSPgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 11:36:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39845 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404995AbgFSPgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:36:21 -0400
Received: from ip-109-41-0-196.web.vodafone.de ([109.41.0.196] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jmJ3w-0000bE-6e; Fri, 19 Jun 2020 15:36:16 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Serge Hallyn <serge@hallyn.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 0/3] nsproxy: support CLONE_NEWTIME with setns()
Date:   Fri, 19 Jun 2020 17:35:56 +0200
Message-Id: <20200619153559.724863-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

So far setns() was missing time namespace support. This was partially
due to it simply not being implemented but also because
vdso_join_timens() could still fail which made switching to multiple
namespaces atomically problematic. This series first fixes
vdso_join_timens() to never fail, introduces timens_commit() and finally
adds CLONE_NEWTIME support for setns().

Please note, that arm is currently in the process of adding
vdso_join_timens() support (cf. [1]) so it might make sense to split the
vdso_join_timens() change out and route it to mainline as a fix so both
my series and the arm support can be rebased on top of it. I've Cced the
relevant people and I'm also replying to the arm thread now.

[1]: https://lore.kernel.org/lkml/20200602180259.76361-1-avagin@gmail.com/

Thanks!
Christian

Christian Brauner (3):
  timens: make vdso_join_timens() always succeed
  timens: add timens_commit() helper
  nsproxy: support CLONE_NEWTIME with setns()

 arch/x86/entry/vdso/vma.c      |  6 ++----
 include/linux/time_namespace.h | 13 +++++++++----
 kernel/nsproxy.c               | 21 +++++++++++++++++++--
 kernel/time/namespace.c        | 22 ++++++++--------------
 4 files changed, 38 insertions(+), 24 deletions(-)


base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
-- 
2.27.0


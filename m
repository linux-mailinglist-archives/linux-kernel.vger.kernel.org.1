Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A77129146A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 22:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439145AbgJQU7u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 17 Oct 2020 16:59:50 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:39450 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439135AbgJQU7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 16:59:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E91406231F3E;
        Sat, 17 Oct 2020 22:59:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DhYFasblXd3D; Sat, 17 Oct 2020 22:59:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 75B3760CEF32;
        Sat, 17 Oct 2020 22:59:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yciNccjmzGxw; Sat, 17 Oct 2020 22:59:47 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 524416231F3E;
        Sat, 17 Oct 2020 22:59:47 +0200 (CEST)
Date:   Sat, 17 Oct 2020 22:59:47 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Message-ID: <1807778111.204345.1602968387192.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] uml updates for 5.10
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Index: SNAiCOtYJidXA91rESSXr7ieCXwdSQ==
Thread-Topic: uml updates for 5.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[re-sending, this time with Linus in the recipient list...]

Linus,

The following changes since commit ba4f184e126b751d1bffad5897f263108befc780:

  Linux 5.9-rc6 (2020-09-20 16:33:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.10-rc1

for you to fetch changes up to f06885b3f3e3884f98351d7b72a4fc8400911cde:

  um: vector: Add dynamic tap interfaces and scripting (2020-10-11 23:26:37 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Improve support for non-glibc systems
- Vector: Add support for scripting and dynamic tap devices
- Various fixes for the vector networking driver
- Various fixes for time travel mode

----------------------------------------------------------------
Anton Ivanov (1):
      um: vector: Add dynamic tap interfaces and scripting

Gabriel Krisman Bertazi (1):
      um: Remove dead usage of TIF_IA32

Gaurav Singh (1):
      um: Fix null pointer dereference in vector_user_bpf

Ignat Korchagin (2):
      um: Some fixes to build UML with musl
      um: Allow static linking for non-glibc implementations

Johannes Berg (4):
      um: time-travel: Fix IRQ handling in time_travel_handle_message()
      um: time-travel: Return the sequence number in ACK messages
      um: change sigio_spinlock to a mutex
      um: Clean up stacktrace dump

Li Heng (1):
      um: Remove redundant NULL check

Maciej Żenczykowski (1):
      um: Fix incorrect assumptions about max pid length

Tiezhu Yang (1):
      um: vector: Use GFP_ATOMIC under spin lock

 arch/um/Kconfig               |  6 ++--
 arch/um/drivers/Kconfig       |  6 ++--
 arch/um/drivers/daemon_user.c |  1 +
 arch/um/drivers/pcap_user.c   | 12 ++++----
 arch/um/drivers/slip_user.c   |  2 +-
 arch/um/drivers/vector_kern.c |  4 +--
 arch/um/drivers/vector_user.c | 71 ++++++++++++++++++++++++++++++++-----------
 arch/um/kernel/sigio.c        |  6 ++--
 arch/um/kernel/sysrq.c        |  4 +--
 arch/um/kernel/time.c         | 15 ++++++---
 arch/um/os-Linux/umid.c       |  8 ++---
 arch/um/os-Linux/util.c       |  2 +-
 arch/x86/um/ptrace_64.c       | 13 +-------
 arch/x86/um/user-offsets.c    |  2 +-
 14 files changed, 91 insertions(+), 61 deletions(-)

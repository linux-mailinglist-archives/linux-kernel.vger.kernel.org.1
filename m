Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FFD20C1E9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jun 2020 15:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgF0N6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jun 2020 09:58:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgF0N6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 09:58:15 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6A9D2158C;
        Sat, 27 Jun 2020 13:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593266295;
        bh=zFFmAxQIJ282vX1U5MTEGpJFoSCC8e6dQDRcPHERdds=;
        h=From:To:Cc:Subject:Date:From;
        b=yAESvf8Gfcairgg2gf6m4SeyFniwS9u435AovnO6RhjbHX242Bg6ekMEv02L/JvTq
         92lemG1EhMpXQZFM6LRiRg4tk+BihGTb+JVWiAHrLwNY0xdjo3MHF7bE4Oszig/ANe
         +dIZzzaGJbpCu2PBeWX7wUqKuYMbfdSTJFeYjGfs=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, tycho@tycho.ws,
        nickhu@andestech.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 0/3] riscv: Enable LOCKDEP
Date:   Sat, 27 Jun 2020 13:57:05 +0000
Message-Id: <1593266228-61125-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Lockdep is needed by proving the spinlocks and rwlocks. To support it,
we need to add TRACE_IRQFLAGS codes in kernel/entry.S. These patches
follow Documentation/irqflags-tracing.txt.

Fixup 2 bugs that block the lockdep implementation.

---
Changes in v2
 - Remove sX regs recovery codes which are unnecessary, because
   callee will handle them. Thx Greentime :)

 - Move "restore a0 - a7" to handle_syscall, but if _TIF_SYSCALL_WORK
   is set, "restore a1 - a7" is still duplicated. I prefer a C wrapper
   for syscall.

Guo Ren (2):
  riscv: Fixup static_obj() fail
  riscv: Enable LOCKDEP_SUPPORT & fixup TRACE_IRQFLAGS_SUPPORT

Zong Li (1):
  riscv: Fixup lockdep_assert_held with wrong param cpu_running

 arch/riscv/Kconfig              |  3 +++
 arch/riscv/kernel/entry.S       | 33 ++++++++++++++++++++++++++++++++-
 arch/riscv/kernel/smpboot.c     |  1 -
 arch/riscv/kernel/vmlinux.lds.S |  2 +-
 4 files changed, 36 insertions(+), 3 deletions(-)

-- 
2.7.4


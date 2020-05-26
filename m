Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117A71C586C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgEEOOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729054AbgEEOOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:31 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1C9C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:31 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKr-0000v9-9n; Tue, 05 May 2020 16:14:13 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id C4A7DFFC8D;
        Tue,  5 May 2020 16:14:12 +0200 (CEST)
Message-Id: <20200505134112.272268764@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:41:12 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 2 00/18] x86/entry: Entry/exception code rework,
 syscall and KVM changes
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks!

This is the second part of the rework series. Part 1 can be found here:

 https://lore.kernel.org/r/20200505131602.633487962@linutronix.de

The series has a total of 138 patches and is split into 5 parts. The base
for this series is:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v4-part-1

The full series with all parts applied is available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v4-part-5

The second part, i.e. this series is available from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v4-part-2
 
This part contains the modifications for the syscall entry code and the
adjustment of the KVM code:

 - Move the non entry related ASM code into the regular text section so it
   is not part of the protected section

 - Move the low level entry C code into the .noinstr.text section

 - Make the interaction with lockdep, RCU and tracing correct

 - Move the KVM guest_enter/exit() handling strict vs. RCU and
   instrumentation protection. It's more or less the same problem as the
   syscall entry/exit and needs to be equally restrictive so that the
   rules can be enforced with objtool.

The objtool check for the noinstr.text correctness is not yet added to the
build machinery and has to be invoked manually for now:

   objtool check -fal vmlinux.o

The checking only works for builtin code as objtool cannot do a combined
analysis of vmlinux.o and a module.o

Thanks,

	tglx

8<----------
 arch/x86/entry/Makefile                |    2 
 arch/x86/entry/common.c                |  173 ++++++++++++++++++++++++---------
 arch/x86/entry/entry_32.S              |   35 ++----
 arch/x86/entry/entry_64.S              |   16 +--
 arch/x86/entry/entry_64_compat.S       |   55 ++++------
 arch/x86/entry/thunk_64.S              |   45 +++++++-
 arch/x86/include/asm/hardirq.h         |    4 
 arch/x86/include/asm/irqflags.h        |    3 
 arch/x86/include/asm/kvm_host.h        |    8 +
 arch/x86/include/asm/nospec-branch.h   |    4 
 arch/x86/include/asm/paravirt.h        |    3 
 arch/x86/kernel/ftrace_64.S            |    2 
 arch/x86/kvm/svm/svm.c                 |   66 ++++++++++--
 arch/x86/kvm/svm/vmenter.S             |    2 
 arch/x86/kvm/vmx/ops.h                 |    4 
 arch/x86/kvm/vmx/vmenter.S             |    5 
 arch/x86/kvm/vmx/vmx.c                 |   78 +++++++++++---
 arch/x86/kvm/x86.c                     |    4 
 include/linux/context_tracking.h       |   27 +++--
 include/linux/context_tracking_state.h |    6 -
 kernel/context_tracking.c              |   14 +-
 lib/smp_processor_id.c                 |   10 -
 22 files changed, 391 insertions(+), 175 deletions(-)


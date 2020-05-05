Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDCB1C5865
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgEEOOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729461AbgEEON5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:13:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9A3C061A41
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:13:56 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKH-0000XS-Vy; Tue, 05 May 2020 16:13:38 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 78A5EFFC8D;
        Tue,  5 May 2020 16:13:37 +0200 (CEST)
Message-Id: <20200505134059.970057117@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:21 +0200
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
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V4 part 1 19/36] x86/entry: Exclude low level entry code from
 sanitizing 
References: <20200505131602.633487962@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sanitizers are not really applicable to the fragile low level entry
code. code. Entry code needs to carefully setup a normal 'runtime'
environment.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/Makefile |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -3,6 +3,14 @@
 # Makefile for the x86 low level entry code
 #
 
+KASAN_SANITIZE := n
+UBSAN_SANITIZE := n
+KCOV_INSTRUMENT := n
+
+CFLAGS_REMOVE_common.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong
+CFLAGS_REMOVE_syscall_32.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong
+CFLAGS_REMOVE_syscall_64.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong
+
 OBJECT_FILES_NON_STANDARD_entry_64_compat.o := y
 
 CFLAGS_syscall_64.o		+= $(call cc-option,-Wno-override-init,)


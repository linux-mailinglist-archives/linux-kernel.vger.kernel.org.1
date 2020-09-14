Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29683269273
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgINRFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:05:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39907 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726131AbgINREy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 13:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600103092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ipaNxMrceKkLR5kkwD8SmYi9G7UY5vra0U19CTPpw2U=;
        b=V05WbzHusWAZu8yxwlbHF6tJgZK8N/LNlbRABdfuNlI8V8DYQA+7XXJ+vGbQwnLVYklBXn
        LJWqQmm59oxgsWny84zm2D40sJTV9ZG7RG5s2+8mbC1id7fjqhcnynqyCFkijhvwXgAH4e
        v5Wcr+GOp5nvA3ZChHz6GbZd7X/QZq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-yDaeeV2ANfCTfvtYaOKjxw-1; Mon, 14 Sep 2020 13:04:45 -0400
X-MC-Unique: yDaeeV2ANfCTfvtYaOKjxw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A65C310054FF;
        Mon, 14 Sep 2020 17:04:43 +0000 (UTC)
Received: from treble.redhat.com (ovpn-115-26.rdu2.redhat.com [10.10.115.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B56EE19C4F;
        Mon, 14 Sep 2020 17:04:36 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH] x86/unwind/fp: Fix FP unwinding in ret_from_fork
Date:   Mon, 14 Sep 2020 12:04:22 -0500
Message-Id: <f366bbf5a8d02e2318ee312f738112d0af74d16f.1600103007.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been some reports of "bad bp value" warnings printed by the
frame pointer unwinder:

  WARNING: kernel stack regs at 000000005bac7112 in sh:1014 has bad 'bp' value 0000000000000000

This warning happens when unwinding from an interrupt in
ret_from_fork().  If entry code gets interrupted, the state of the frame
pointer (rbp) may be undefined, which can confuse the unwinder,
resulting in warnings like the above.

There's an in_entry_code() check which normally silences such warnings
for entry code.  But in this case, ret_from_fork() is getting
interrupted.  It recently got moved out of .entry.text, so the
in_entry_code() check no longer works.

We could move it back into .entry.text, but that would break the noinstr
validation because of the call to schedule_tail().

Instead, initialize each new task's RBP to point to the task's entry
regs via an encoded frame pointer.  That will allow the unwinder to
reach the end of the stack gracefully.

Fixes: b9f6976bfb94 ("x86/entry/64: Move non entry code into .text section")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/frame.h | 19 +++++++++++++++++++
 arch/x86/kernel/process.c    |  3 ++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/frame.h b/arch/x86/include/asm/frame.h
index 296b346184b2..fb42659f6e98 100644
--- a/arch/x86/include/asm/frame.h
+++ b/arch/x86/include/asm/frame.h
@@ -60,12 +60,26 @@
 #define FRAME_END "pop %" _ASM_BP "\n"
 
 #ifdef CONFIG_X86_64
+
 #define ENCODE_FRAME_POINTER			\
 	"lea 1(%rsp), %rbp\n\t"
+
+static inline unsigned long encode_frame_pointer(struct pt_regs *regs)
+{
+	return (unsigned long)regs + 1;
+}
+
 #else /* !CONFIG_X86_64 */
+
 #define ENCODE_FRAME_POINTER			\
 	"movl %esp, %ebp\n\t"			\
 	"andl $0x7fffffff, %ebp\n\t"
+
+static inline unsigned long encode_frame_pointer(struct pt_regs *regs)
+{
+	return (unsigned long)regs & 0x7fffffff;
+}
+
 #endif /* CONFIG_X86_64 */
 
 #endif /* __ASSEMBLY__ */
@@ -83,6 +97,11 @@
 
 #define ENCODE_FRAME_POINTER
 
+static inline unsigned long encode_frame_pointer(struct pt_regs *regs)
+{
+	return 0;
+}
+
 #endif
 
 #define FRAME_BEGIN
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 13ce616cc7af..ba4593a913fa 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -42,6 +42,7 @@
 #include <asm/spec-ctrl.h>
 #include <asm/io_bitmap.h>
 #include <asm/proto.h>
+#include <asm/frame.h>
 
 #include "process.h"
 
@@ -133,7 +134,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	fork_frame = container_of(childregs, struct fork_frame, regs);
 	frame = &fork_frame->frame;
 
-	frame->bp = 0;
+	frame->bp = encode_frame_pointer(childregs);
 	frame->ret_addr = (unsigned long) ret_from_fork;
 	p->thread.sp = (unsigned long) fork_frame;
 	p->thread.io_bitmap = NULL;
-- 
2.25.4


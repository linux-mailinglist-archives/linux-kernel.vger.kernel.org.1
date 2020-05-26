Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C421B857A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 12:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgDYKD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 06:03:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25248 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgDYKDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587809013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZPlCk0PttELamKCTK4s9l1Kouhf5hx1XO1514GlOpho=;
        b=H/ugPSsFSaEOn2TU23roAAEvQ26C3grexweHSX1o7c4GduYxvYfYfaMcxTS2EQFD4HoxTV
        QiWu5BIVqLJsOwYizH77SL/5fIgidkoHCYE5LpLhmMNEsgmefhqoKy0SxYQtJx6R0ylhuf
        oxcudMOWQZxNVaTehwJoMYHUn9XVD4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-_b8i9Wm-OdWvmpUnLlS4vw-1; Sat, 25 Apr 2020 06:03:30 -0400
X-MC-Unique: _b8i9Wm-OdWvmpUnLlS4vw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6853E461;
        Sat, 25 Apr 2020 10:03:29 +0000 (UTC)
Received: from treble.redhat.com (ovpn-114-29.rdu2.redhat.com [10.10.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 465AA60624;
        Sat, 25 Apr 2020 10:03:28 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 07/11] x86/unwind: Prevent false warnings for non-current tasks
Date:   Sat, 25 Apr 2020 05:03:06 -0500
Message-Id: <ec424a2aea1d461eb30cab48a28c6433de2ab784.1587808742.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1587808742.git.jpoimboe@redhat.com>
References: <cover.1587808742.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's some daring kernel code out there which dumps the stack of
another task without first making sure the task is inactive.  If the
task happens to be running while the unwinder is reading the stack,
unusual unwinder warnings can result.

There's no race-free way for the unwinder to know whether such a warning
is legitimate, so just disable unwinder warnings for all non-current
tasks.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
---
 arch/x86/kernel/dumpstack_64.c |  3 ++-
 arch/x86/kernel/unwind_frame.c |  3 +++
 arch/x86/kernel/unwind_orc.c   | 40 +++++++++++++++++++---------------
 3 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_6=
4.c
index 87b97897a881..460ae7f66818 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -183,7 +183,8 @@ int get_stack_info(unsigned long *stack, struct task_=
struct *task,
 	 */
 	if (visit_mask) {
 		if (*visit_mask & (1UL << info->type)) {
-			printk_deferred_once(KERN_WARNING "WARNING: stack recursion on stack =
type %d\n", info->type);
+			if (task =3D=3D current)
+				printk_deferred_once(KERN_WARNING "WARNING: stack recursion on stack=
 type %d\n", info->type);
 			goto unknown;
 		}
 		*visit_mask |=3D 1UL << info->type;
diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_fram=
e.c
index a224b5ab103f..54226110bc7f 100644
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -344,6 +344,9 @@ bool unwind_next_frame(struct unwind_state *state)
 	if (IS_ENABLED(CONFIG_X86_32))
 		goto the_end;
=20
+	if (state->task !=3D current)
+		goto the_end;
+
 	if (state->regs) {
 		printk_deferred_once(KERN_WARNING
 			"WARNING: kernel stack regs at %p in %s:%d has bad 'bp' value %p\n",
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 64889da666f4..45166fd50be3 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -8,7 +8,13 @@
 #include <asm/orc_lookup.h>
=20
 #define orc_warn(fmt, ...) \
-	printk_deferred_once(KERN_WARNING pr_fmt("WARNING: " fmt), ##__VA_ARGS_=
_)
+	printk_deferred_once(KERN_WARNING "WARNING: " fmt, ##__VA_ARGS__)
+
+#define orc_warn_current(args...)					\
+({									\
+	if (state->task =3D=3D current)					\
+		orc_warn(args);						\
+})
=20
 extern int __start_orc_unwind_ip[];
 extern int __stop_orc_unwind_ip[];
@@ -446,8 +452,8 @@ bool unwind_next_frame(struct unwind_state *state)
=20
 	case ORC_REG_R10:
 		if (!state->regs || !state->full_regs) {
-			orc_warn("missing regs for base reg R10 at ip %pB\n",
-				 (void *)state->ip);
+			orc_warn_current("missing R10 value at %pB\n",
+					 (void *)state->ip);
 			goto err;
 		}
 		sp =3D state->regs->r10;
@@ -455,8 +461,8 @@ bool unwind_next_frame(struct unwind_state *state)
=20
 	case ORC_REG_R13:
 		if (!state->regs || !state->full_regs) {
-			orc_warn("missing regs for base reg R13 at ip %pB\n",
-				 (void *)state->ip);
+			orc_warn_current("missing R13 value at %pB\n",
+					 (void *)state->ip);
 			goto err;
 		}
 		sp =3D state->regs->r13;
@@ -464,8 +470,8 @@ bool unwind_next_frame(struct unwind_state *state)
=20
 	case ORC_REG_DI:
 		if (!state->regs || !state->full_regs) {
-			orc_warn("missing regs for base reg DI at ip %pB\n",
-				 (void *)state->ip);
+			orc_warn_current("missing RDI value at %pB\n",
+					 (void *)state->ip);
 			goto err;
 		}
 		sp =3D state->regs->di;
@@ -473,15 +479,15 @@ bool unwind_next_frame(struct unwind_state *state)
=20
 	case ORC_REG_DX:
 		if (!state->regs || !state->full_regs) {
-			orc_warn("missing regs for base reg DX at ip %pB\n",
-				 (void *)state->ip);
+			orc_warn_current("missing DX value at %pB\n",
+					 (void *)state->ip);
 			goto err;
 		}
 		sp =3D state->regs->dx;
 		break;
=20
 	default:
-		orc_warn("unknown SP base reg %d for ip %pB\n",
+		orc_warn("unknown SP base reg %d at %pB\n",
 			 orc->sp_reg, (void *)state->ip);
 		goto err;
 	}
@@ -509,8 +515,8 @@ bool unwind_next_frame(struct unwind_state *state)
=20
 	case ORC_TYPE_REGS:
 		if (!deref_stack_regs(state, sp, &state->ip, &state->sp)) {
-			orc_warn("can't dereference registers at %p for ip %pB\n",
-				 (void *)sp, (void *)orig_ip);
+			orc_warn_current("can't access registers at %pB\n",
+					 (void *)orig_ip);
 			goto err;
 		}
=20
@@ -521,8 +527,8 @@ bool unwind_next_frame(struct unwind_state *state)
=20
 	case ORC_TYPE_REGS_IRET:
 		if (!deref_stack_iret_regs(state, sp, &state->ip, &state->sp)) {
-			orc_warn("can't dereference iret registers at %p for ip %pB\n",
-				 (void *)sp, (void *)orig_ip);
+			orc_warn_current("can't access iret registers at %pB\n",
+					 (void *)orig_ip);
 			goto err;
 		}
=20
@@ -532,7 +538,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		break;
=20
 	default:
-		orc_warn("unknown .orc_unwind entry type %d for ip %pB\n",
+		orc_warn("unknown .orc_unwind entry type %d at %pB\n",
 			 orc->type, (void *)orig_ip);
 		break;
 	}
@@ -564,8 +570,8 @@ bool unwind_next_frame(struct unwind_state *state)
 	if (state->stack_info.type =3D=3D prev_type &&
 	    on_stack(&state->stack_info, (void *)state->sp, sizeof(long)) &&
 	    state->sp <=3D prev_sp) {
-		orc_warn("stack going in the wrong direction? ip=3D%pB\n",
-			 (void *)orig_ip);
+		orc_warn_current("stack going in the wrong direction? at %pB\n",
+				 (void *)orig_ip);
 		goto err;
 	}
=20
--=20
2.21.1


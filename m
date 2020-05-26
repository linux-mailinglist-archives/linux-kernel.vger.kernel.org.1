Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37941B1BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 04:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgDUCP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 22:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727109AbgDUCP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 22:15:26 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A480CC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 19:15:24 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id x16so11785511pgi.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 19:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fmDIIvZxhD4Qz7j+wQz+cg0h7Uav/MFkAMZG+HSiNhc=;
        b=Q3Znj2JKTQDjJ9AtVQa9SlDWVy67S5Os3GkR86PFUbKNay/M9+Tf6sl6w+fw+XIwk6
         Ioheosds6Jmo5t0P7WNRlTpO2ptSqHlo3eIJw8OCnjYMQ23Yd5B7siAepCbDRYFrahJ+
         BztZcJusaVR5p/k1SeS9/pX+F8y7qErPvLWbWiADXCzX9beJCFfGlv5BMt1AZCRmwnPY
         ZCmw4JN4e8Nv5jj0xbxDWtwow9lsc6LRX0BxN+cXZdRYUyiQUmW3Xt4kEvyMZzFPEfWH
         JYhyGcgXXCG+xyF/Okyi+vt2zkCaUkp/YchRv4JGn0VZbGlUv8YY/0qjSUdgKrsZKZC+
         qkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fmDIIvZxhD4Qz7j+wQz+cg0h7Uav/MFkAMZG+HSiNhc=;
        b=h2psJ6tOQXUvKk1vTXsaQQbVNSQU1QuaLKhEz2AuLPQOqa1gwxukEXpMIlUkCGkToR
         W5wmhu6dDGJsxsgLqdzXmUiN0djz9nmvOq4WovBWKp1/aieCNe4yqDOSlPjbsx+LccYy
         0Sjq0aaEq7xvTDEVfeAZBuJnBaC4imhWib49SWBr6AvvuUfDX7CJqclEmzcj3bg5SEpu
         yoODOVjm5yOUOR47BS5H0k7aVILkjdw5N8Z9AEwWoirzL0ERSaN4OHRqK7OSAlxt3FQP
         xcmsT5tk0GgTaH25MmfsXrNr2WrDIPYbRKHaQPW8znyOMJMNlPahHIV9pszWzEjuj15K
         Dgcw==
X-Gm-Message-State: AGi0PuZzFqmE9qMvf+WjeLZ1X1/R/5cs1eljVNjBlc7Juz4gRjx4/FTg
        uAta6+cAGoe1vp4a+h0fQoZdB8W1Hfh/rEOdhI4=
X-Google-Smtp-Source: APiQypKP0rnpkpovisrv5VEIou1w3/73lQO+VReT/uCmoOssza/QtX3Z0Kia4pqf4dQTquCPQ6LCYUDifPUCspPK5Pw=
X-Received: by 2002:a65:6859:: with SMTP id q25mr13037367pgt.437.1587435324149;
 Mon, 20 Apr 2020 19:15:24 -0700 (PDT)
Date:   Mon, 20 Apr 2020 19:14:52 -0700
In-Reply-To: <20200421021453.198187-1-samitolvanen@google.com>
Message-Id: <20200421021453.198187-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200421021453.198187-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v12 11/12] arm64: scs: add shadow stacks for SDEI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds per-CPU shadow call stacks for the SDEI handler.
Similarly to how the kernel stacks are handled, we add separate shadow
stacks for normal and critical events.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: James Morse <james.morse@arm.com>
Tested-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/entry.S | 14 +++++++++++++-
 arch/arm64/kernel/scs.c   |  5 +++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 14f0ff763b39..9f7be489d26d 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1058,13 +1058,16 @@ SYM_CODE_START(__sdei_asm_handler)
 
 	mov	x19, x1
 
+#if defined(CONFIG_VMAP_STACK) || defined(CONFIG_SHADOW_CALL_STACK)
+	ldrb	w4, [x19, #SDEI_EVENT_PRIORITY]
+#endif
+
 #ifdef CONFIG_VMAP_STACK
 	/*
 	 * entry.S may have been using sp as a scratch register, find whether
 	 * this is a normal or critical event and switch to the appropriate
 	 * stack for this CPU.
 	 */
-	ldrb	w4, [x19, #SDEI_EVENT_PRIORITY]
 	cbnz	w4, 1f
 	ldr_this_cpu dst=x5, sym=sdei_stack_normal_ptr, tmp=x6
 	b	2f
@@ -1074,6 +1077,15 @@ SYM_CODE_START(__sdei_asm_handler)
 	mov	sp, x5
 #endif
 
+#ifdef CONFIG_SHADOW_CALL_STACK
+	/* Use a separate shadow call stack for normal and critical events */
+	cbnz	w4, 3f
+	adr_this_cpu dst=x18, sym=sdei_shadow_call_stack_normal, tmp=x6
+	b	4f
+3:	adr_this_cpu dst=x18, sym=sdei_shadow_call_stack_critical, tmp=x6
+4:
+#endif
+
 	/*
 	 * We may have interrupted userspace, or a guest, or exit-from or
 	 * return-to either of these. We can't trust sp_el0, restore it.
diff --git a/arch/arm64/kernel/scs.c b/arch/arm64/kernel/scs.c
index 086ad97bba86..656262736eca 100644
--- a/arch/arm64/kernel/scs.c
+++ b/arch/arm64/kernel/scs.c
@@ -14,3 +14,8 @@
 		__aligned(SCS_SIZE)
 
 DEFINE_SCS(irq_shadow_call_stack);
+
+#ifdef CONFIG_ARM_SDE_INTERFACE
+DEFINE_SCS(sdei_shadow_call_stack_normal);
+DEFINE_SCS(sdei_shadow_call_stack_critical);
+#endif
-- 
2.26.1.301.g55bc3eb7cb9-goog


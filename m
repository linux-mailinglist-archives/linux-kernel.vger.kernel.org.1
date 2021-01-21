Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58CF2FF76C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbhAUViZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:38:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31867 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727237AbhAUVb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611264631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PD4RqvfCsC8+iWYehujEIqD8nLBwTnL6KKSCiDK9Stk=;
        b=KhzeSdCa8WRFPqEA0Ah5sCWTk1PdAhCxdKaGAVKwX8cDq+zxqSzWNgRH+NYVQSnuY2sq1U
        gz0JgNjHCGFe/ovrTVY488O/t7DkM2UpGxvId8ajpmyQQxFPSJc8FxixJ+Ge4aRtcS/Vad
        6lAAPE4Y/mmFWhJq6d7Lc0KEIeKCsFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-DjVsEwslNXeElyJxK51zsw-1; Thu, 21 Jan 2021 16:30:29 -0500
X-MC-Unique: DjVsEwslNXeElyJxK51zsw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A25515720;
        Thu, 21 Jan 2021 21:30:27 +0000 (UTC)
Received: from treble.redhat.com (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D527519C59;
        Thu, 21 Jan 2021 21:30:25 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Miroslav Benes <mbenes@suse.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v2 17/20] x86/acpi: Support objtool validation in wakeup_64.S
Date:   Thu, 21 Jan 2021 15:29:33 -0600
Message-Id: <269eda576c53bc9ecc8167c211989111013a67aa.1611263462.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1611263461.git.jpoimboe@redhat.com>
References: <cover.1611263461.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OBJECT_FILES_NON_STANDARD annotation is used to tell objtool to
ignore a file.  File-level ignores won't work when validating vmlinux.o.

Instead, tell objtool to ignore do_suspend_lowlevel() directly with the
STACK_FRAME_NON_STANDARD annotation.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/acpi/Makefile    | 1 -
 arch/x86/kernel/acpi/wakeup_64.S | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/Makefile b/arch/x86/kernel/acpi/Makefile
index f1bb57b0e41e..cf340d85946a 100644
--- a/arch/x86/kernel/acpi/Makefile
+++ b/arch/x86/kernel/acpi/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-OBJECT_FILES_NON_STANDARD_wakeup_$(BITS).o := y
 
 obj-$(CONFIG_ACPI)		+= boot.o
 obj-$(CONFIG_ACPI_SLEEP)	+= sleep.o wakeup_$(BITS).o
diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index 9c9c66662ada..56b6865afb2a 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 .text
 #include <linux/linkage.h>
+#include <linux/objtool.h>
 #include <asm/segment.h>
 #include <asm/pgtable_types.h>
 #include <asm/page_types.h>
@@ -128,6 +129,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
 	FRAME_END
 	jmp	restore_processor_state
 SYM_FUNC_END(do_suspend_lowlevel)
+STACK_FRAME_NON_STANDARD do_suspend_lowlevel
 
 .data
 saved_rbp:		.quad	0
-- 
2.29.2


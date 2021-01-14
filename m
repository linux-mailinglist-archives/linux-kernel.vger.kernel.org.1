Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB79A2F6B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbhANTnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:43:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43643 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730028AbhANTnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610653307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s6vqkn0ZUJ9Zbk8UI1tuyg4i1alvjbstrHik+n/M+0g=;
        b=c3LoyxAIHU08szECpK+a3VQAVR3oHCzoiksJwQE8qz9GpW+59cd2vRvoS+2zB6Nv7Vw2R0
        +Nwo8X1Ot1GgBNKyrdQMIKfVRdUkp7DyW74ZgLn0CKw74jxbpPHpem2nLkK+sbu7lxD/Ge
        ftYLiy24I8xnZ1z45Lshml6jAghtksI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-AePGvTXrNM-NdhZLQk4Tyw-1; Thu, 14 Jan 2021 14:41:45 -0500
X-MC-Unique: AePGvTXrNM-NdhZLQk4Tyw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04CA6800050;
        Thu, 14 Jan 2021 19:41:43 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BC37100AE40;
        Thu, 14 Jan 2021 19:41:37 +0000 (UTC)
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
Subject: [PATCH 18/21] x86/acpi: Support objtool validation in wakeup_64.S
Date:   Thu, 14 Jan 2021 13:40:14 -0600
Message-Id: <afe0721950599de1214c7d4cc52f0c897f969e9c.1610652862.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1610652862.git.jpoimboe@redhat.com>
References: <cover.1610652862.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
index 0b371580e620..cc6846b35cab 100644
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
@@ -127,6 +128,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
 	FRAME_END
 	jmp	restore_processor_state
 SYM_FUNC_END(do_suspend_lowlevel)
+STACK_FRAME_NON_STANDARD do_suspend_lowlevel
 
 .data
 saved_rbp:		.quad	0
-- 
2.29.2


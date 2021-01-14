Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7F82F6B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbhANTn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:43:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729175AbhANTnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610653319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0vEE4omOoEVIIrSo277ugwb7AgXeFGkOd1dV5Hy4GDU=;
        b=NP2Vwcl1I40C9d7WQnZJKHXz4ugewW8gOH0r0VAuoA87GhQxROOYE9TSOPBdhZk6PmvfP9
        +6drtmnjQIBEIjlIfh6opCMWOfQph01BPbCG8XUJq+EBANODIFDIbTCyPWTmlIv7Lf/CKI
        +UJxiO498qYR9zgVLCt9T4fFML8702I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-Ku4PqDyfMuSj9BmsnWN6Gw-1; Thu, 14 Jan 2021 14:41:54 -0500
X-MC-Unique: Ku4PqDyfMuSj9BmsnWN6Gw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A2D7107ACF8;
        Thu, 14 Jan 2021 19:41:53 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A76341001E73;
        Thu, 14 Jan 2021 19:41:50 +0000 (UTC)
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
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 21/21] x86/power: Support objtool validation in hibernate_asm_64.S
Date:   Thu, 14 Jan 2021 13:40:17 -0600
Message-Id: <0df4a9767074ec0f493fefdd4a2e57b4c9c53d00.1610652862.git.jpoimboe@redhat.com>
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

Instead, convert restore_image() and core_restore_code() to be ELF
functions.  Their code is conventional enough for objtool to be able to
understand them.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/power/Makefile           | 1 -
 arch/x86/power/hibernate_asm_64.S | 8 ++++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/power/Makefile b/arch/x86/power/Makefile
index 6907b523e856..3ff80156f21a 100644
--- a/arch/x86/power/Makefile
+++ b/arch/x86/power/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-OBJECT_FILES_NON_STANDARD_hibernate_asm_$(BITS).o := y
 
 # __restore_processor_state() restores %gs after S3 resume and so should not
 # itself be stack-protected
diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index 4ca6d68b0293..fce9ed03e939 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -99,7 +99,7 @@ SYM_FUNC_START(swsusp_arch_suspend)
 	ret
 SYM_FUNC_END(swsusp_arch_suspend)
 
-SYM_CODE_START(restore_image)
+SYM_FUNC_START(restore_image)
 	/* prepare to jump to the image kernel */
 	movq	restore_jump_address(%rip), %r8
 	movq	restore_cr3(%rip), %r9
@@ -114,10 +114,10 @@ SYM_CODE_START(restore_image)
 	/* jump to relocated restore code */
 	movq	relocated_restore_code(%rip), %rcx
 	JMP_NOSPEC rcx
-SYM_CODE_END(restore_image)
+SYM_FUNC_END(restore_image)
 
 	/* code below has been relocated to a safe page */
-SYM_CODE_START(core_restore_code)
+SYM_FUNC_START(core_restore_code)
 	/* switch to temporary page tables */
 	movq	%rax, %cr3
 	/* flush TLB */
@@ -145,4 +145,4 @@ SYM_CODE_START(core_restore_code)
 .Ldone:
 	/* jump to the restore_registers address from the image header */
 	JMP_NOSPEC r8
-SYM_CODE_END(core_restore_code)
+SYM_FUNC_END(core_restore_code)
-- 
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB362FF772
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbhAUVkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:40:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727351AbhAUVcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611264640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gE9aSsrj68xqixz3d6S3bEZJpxp03hmnQvGoyng1Aj4=;
        b=cyZAATdMw4+AWGvSBUJMy21VFsQYJ2mGxFj/qPcz4ilwX+Pyzs2hrAKOZF6v+zMNPDK3qa
        KWA0CfYBHgRu8KfyWTQx1fPhDQPR2TsxPGn+u85ydbLOBDKoSewX6PiyrF7Aye0GJe5J9c
        LoMz5zcDvcLhoNye5oLwbJfqC7UDDh4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-RrxIqSIiOsaPpBMlvy-Izg-1; Thu, 21 Jan 2021 16:30:36 -0500
X-MC-Unique: RrxIqSIiOsaPpBMlvy-Izg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4A3B15725;
        Thu, 21 Jan 2021 21:30:34 +0000 (UTC)
Received: from treble.redhat.com (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8D7D1992D;
        Thu, 21 Jan 2021 21:30:33 +0000 (UTC)
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
Subject: [PATCH v2 20/20] x86/power: Support objtool validation in hibernate_asm_64.S
Date:   Thu, 21 Jan 2021 15:29:36 -0600
Message-Id: <974f8ceb5385e470f72e93974c70ab5c894bb0dc.1611263462.git.jpoimboe@redhat.com>
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
index 91c4602d2b5d..d9bed596d849 100644
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
@@ -115,10 +115,10 @@ SYM_CODE_START(restore_image)
 	movq	relocated_restore_code(%rip), %rcx
 	ANNOTATE_RETPOLINE_SAFE
 	jmpq	*%rcx
-SYM_CODE_END(restore_image)
+SYM_FUNC_END(restore_image)
 
 	/* code below has been relocated to a safe page */
-SYM_CODE_START(core_restore_code)
+SYM_FUNC_START(core_restore_code)
 	/* switch to temporary page tables */
 	movq	%rax, %cr3
 	/* flush TLB */
@@ -147,4 +147,4 @@ SYM_CODE_START(core_restore_code)
 	/* jump to the restore_registers address from the image header */
 	ANNOTATE_RETPOLINE_SAFE
 	jmpq	*%r8
-SYM_CODE_END(core_restore_code)
+SYM_FUNC_END(core_restore_code)
-- 
2.29.2


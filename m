Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AC02FF753
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbhAUVcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:32:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38010 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726437AbhAUVbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611264592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ldEgrsH9LEK5NXXOyW/fZfXe/Y6qZgIym112gLv+Y4=;
        b=AhGXY/kSL7L9oy4C5uERPy2c2emoeVpML3X/Ka7IRz/btVgg2mHIYYvMljh7LkWnsWPDD6
        EYWSElsJ/wlhzIyddhMA0iXBG9AwPKKqIIOq2SY5MxSulHYzmNIZ4yotMv94NYGMBMBHuo
        +unbNe9wqh1lYKgRqi3LrTob7lG1hDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-tFv9y_2QMduZ_GRUnorU4w-1; Thu, 21 Jan 2021 16:29:48 -0500
X-MC-Unique: tFv9y_2QMduZ_GRUnorU4w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8739B107ACE3;
        Thu, 21 Jan 2021 21:29:46 +0000 (UTC)
Received: from treble.redhat.com (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8040B19C59;
        Thu, 21 Jan 2021 21:29:44 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 02/20] objtool: Fix retpoline detection in asm code
Date:   Thu, 21 Jan 2021 15:29:18 -0600
Message-Id: <31f5833e2e4f01e3d755889ac77e3661e906c09f.1611263461.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1611263461.git.jpoimboe@redhat.com>
References: <cover.1611263461.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The JMP_NOSPEC macro branches to __x86_retpoline_*() rather than the
__x86_indirect_thunk_*() wrappers used by C code.  Detect jumps to
__x86_retpoline_*() as retpoline dynamic jumps.

Presumably this doesn't trigger a user-visible bug.  I only found it
when testing vmlinux.o validation.

Fixes: 39b735332cb8 ("objtool: Detect jumps to retpoline thunks")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/arch/x86/special.c      |  2 +-
 tools/objtool/check.c                 |  3 ++-
 tools/objtool/include/objtool/check.h | 11 +++++++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index b4bd3505fc94..e707d9bcd161 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -48,7 +48,7 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 	 * replacement group.
 	 */
 	return insn->offset == special_alt->new_off &&
-	       (insn->type == INSN_CALL || is_static_jump(insn));
+	       (insn->type == INSN_CALL || is_jump(insn));
 }
 
 /*
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3bdd946c2027..081572170f6b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -785,7 +785,8 @@ static int add_jump_destinations(struct objtool_file *file)
 			dest_sec = reloc->sym->sec;
 			dest_off = reloc->sym->sym.st_value +
 				   arch_dest_reloc_offset(reloc->addend);
-		} else if (strstr(reloc->sym->name, "_indirect_thunk_")) {
+		} else if (!strncmp(reloc->sym->name, "__x86_indirect_thunk_", 21) ||
+			   !strncmp(reloc->sym->name, "__x86_retpoline_", 16)) {
 			/*
 			 * Retpoline jumps are really dynamic jumps in
 			 * disguise, so convert them accordingly.
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index f4e041fbdab2..b408636c0201 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -68,6 +68,17 @@ static inline bool is_static_jump(struct instruction *insn)
 	       insn->type == INSN_JUMP_UNCONDITIONAL;
 }
 
+static inline bool is_dynamic_jump(struct instruction *insn)
+{
+	return insn->type == INSN_JUMP_DYNAMIC ||
+	       insn->type == INSN_JUMP_DYNAMIC_CONDITIONAL;
+}
+
+static inline bool is_jump(struct instruction *insn)
+{
+	return is_static_jump(insn) || is_dynamic_jump(insn);
+}
+
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset);
 
-- 
2.29.2


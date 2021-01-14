Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97792F6B60
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbhANTmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:42:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31905 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730092AbhANTmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:42:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610653264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0QxG08i1D5V96wKVQZqYjQtj7/izFU6KXQ17gPdkd9g=;
        b=ODYakcGvId5DOmDl275dwW/VnCk29Ori83bB06vXKLXW311IzcmBaKNoeXk98WLx2kAsE5
        1Ch5qaEuh9LPrQl2KEU1/GlJvx1VUYVwrgGtGBi1Z6HlQonEHxyD57bqa5ABhTvhWUVcOW
        sL+sCk6ZAb4QQqD9phR+/rUKWjjIYWc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-d1WWDjNbPH2lmKAsaTRe6w-1; Thu, 14 Jan 2021 14:41:00 -0500
X-MC-Unique: d1WWDjNbPH2lmKAsaTRe6w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD249800050;
        Thu, 14 Jan 2021 19:40:58 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 597BB100AE40;
        Thu, 14 Jan 2021 19:40:43 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 07/21] objtool: Assume only ELF functions do sibling calls
Date:   Thu, 14 Jan 2021 13:40:03 -0600
Message-Id: <3b25ec550d2c8368b94915bab193e10d1ef11f42.1610652862.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1610652862.git.jpoimboe@redhat.com>
References: <cover.1610652862.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's an inconsistency in how sibling calls are detected in
non-function asm code, depending on the scope of the object.  If the
target code is external to the object, objtool considers it a sibling
call.  If the target code is internal but not a function, objtool
*doesn't* consider it a sibling call.

This can cause some inconsistencies between per-object and vmlinux.o
validation.

Instead, assume only ELF functions can do sibling calls.  This generally
matches existing reality, and makes sibling call validation consistent
between vmlinux.o and per-object.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b1327789d049..d833855f3aa8 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -111,15 +111,20 @@ static struct instruction *prev_insn_same_sym(struct objtool_file *file,
 
 static bool is_sibling_call(struct instruction *insn)
 {
+	/*
+	 * Assume only ELF functions can make sibling calls.  This ensures
+	 * sibling call detection consistency between vmlinux.o and individual
+	 * objects.
+	 */
+	if (!insn->func)
+		return false;
+
 	/* An indirect jump is either a sibling call or a jump to a table. */
 	if (insn->type == INSN_JUMP_DYNAMIC)
 		return list_empty(&insn->alts);
 
-	if (!is_static_jump(insn))
-		return false;
-
 	/* add_jump_destinations() sets insn->call_dest for sibling calls. */
-	return !!insn->call_dest;
+	return (is_static_jump(insn) && insn->call_dest);
 }
 
 /*
@@ -778,7 +783,7 @@ static int add_jump_destinations(struct objtool_file *file)
 			continue;
 
 		reloc = find_reloc_by_dest_range(file->elf, insn->sec,
-					       insn->offset, insn->len);
+						 insn->offset, insn->len);
 		if (!reloc) {
 			dest_sec = insn->sec;
 			dest_off = arch_jump_destination(insn);
@@ -798,18 +803,21 @@ static int add_jump_destinations(struct objtool_file *file)
 
 			insn->retpoline_safe = true;
 			continue;
-		} else if (reloc->sym->sec->idx) {
-			dest_sec = reloc->sym->sec;
-			dest_off = reloc->sym->sym.st_value +
-				   arch_dest_reloc_offset(reloc->addend);
-		} else {
-			/* external sibling call */
+		} else if (insn->func) {
+			/* internal or external sibling call (with reloc) */
 			insn->call_dest = reloc->sym;
 			if (insn->call_dest->static_call_tramp) {
 				list_add_tail(&insn->static_call_node,
 					      &file->static_call_list);
 			}
 			continue;
+		} else if (reloc->sym->sec->idx) {
+			dest_sec = reloc->sym->sec;
+			dest_off = reloc->sym->sym.st_value +
+				   arch_dest_reloc_offset(reloc->addend);
+		} else {
+			/* non-func asm code jumping to another file */
+			continue;
 		}
 
 		insn->jump_dest = find_insn(file, dest_sec, dest_off);
@@ -858,7 +866,7 @@ static int add_jump_destinations(struct objtool_file *file)
 			} else if (insn->jump_dest->func->pfunc != insn->func->pfunc &&
 				   insn->jump_dest->offset == insn->jump_dest->func->offset) {
 
-				/* internal sibling call */
+				/* internal sibling call (without reloc) */
 				insn->call_dest = insn->jump_dest->func;
 				if (insn->call_dest->static_call_tramp) {
 					list_add_tail(&insn->static_call_node,
@@ -2528,7 +2536,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		case INSN_JUMP_CONDITIONAL:
 		case INSN_JUMP_UNCONDITIONAL:
-			if (func && is_sibling_call(insn)) {
+			if (is_sibling_call(insn)) {
 				ret = validate_sibling_call(insn, &state);
 				if (ret)
 					return ret;
@@ -2550,7 +2558,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		case INSN_JUMP_DYNAMIC:
 		case INSN_JUMP_DYNAMIC_CONDITIONAL:
-			if (func && is_sibling_call(insn)) {
+			if (is_sibling_call(insn)) {
 				ret = validate_sibling_call(insn, &state);
 				if (ret)
 					return ret;
-- 
2.29.2


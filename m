Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABE22F6B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbhANTmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:42:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730078AbhANTmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610653242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lBDeXWQUPZjMhLISIL6oFj3KEKWrwKhZsqAUV1rIDpM=;
        b=hGWoNWQwo+6QxkO3J/UJvnKfn3WrdvPqZIslbwwSN2d5iMCTIIVcM8KzEkN0lF4ONB3aAJ
        9+dUD6+zsXfKvz9IikznQJpKgLzKYlgvLk7m/JyeV/TABLACsfghdyAAHFzLDjpL/gxGI3
        ds2hFUNsS/75rRDW7bBNiylfdNRACcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-Gna9NfDIPuCt_iglvM2qjQ-1; Thu, 14 Jan 2021 14:40:38 -0500
X-MC-Unique: Gna9NfDIPuCt_iglvM2qjQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4187B190B2A7;
        Thu, 14 Jan 2021 19:40:37 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03AE61001E73;
        Thu, 14 Jan 2021 19:40:35 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 05/21] objtool: Support retpoline jump detection for vmlinux.o
Date:   Thu, 14 Jan 2021 13:40:01 -0600
Message-Id: <c20f4a7239f3b26b3f2f7735e6674adefcb46e7f.1610652862.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1610652862.git.jpoimboe@redhat.com>
References: <cover.1610652862.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Objtool converts direct retpoline jumps to type INSN_JUMP_DYNAMIC, since
that's what they are semantically.

That conversion doesn't work in vmlinux.o validation because the
indirect thunk function is present in the object, so the intra-object
jump check succeeds before the retpoline jump check gets a chance.

Rearrange the checks: check for a retpoline jump before checking for an
intra-object jump.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 12d48db41626..b1327789d049 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -785,10 +785,6 @@ static int add_jump_destinations(struct objtool_file *file)
 		} else if (reloc->sym->type == STT_SECTION) {
 			dest_sec = reloc->sym->sec;
 			dest_off = arch_dest_reloc_offset(reloc->addend);
-		} else if (reloc->sym->sec->idx) {
-			dest_sec = reloc->sym->sec;
-			dest_off = reloc->sym->sym.st_value +
-				   arch_dest_reloc_offset(reloc->addend);
 		} else if (!strncmp(reloc->sym->name, "__x86_indirect_thunk_", 21) ||
 			   !strncmp(reloc->sym->name, "__x86_retpoline_", 16)) {
 			/*
@@ -802,6 +798,10 @@ static int add_jump_destinations(struct objtool_file *file)
 
 			insn->retpoline_safe = true;
 			continue;
+		} else if (reloc->sym->sec->idx) {
+			dest_sec = reloc->sym->sec;
+			dest_off = reloc->sym->sym.st_value +
+				   arch_dest_reloc_offset(reloc->addend);
 		} else {
 			/* external sibling call */
 			insn->call_dest = reloc->sym;
-- 
2.29.2


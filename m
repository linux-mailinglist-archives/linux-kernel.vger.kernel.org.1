Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64DA2DA2FD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440655AbgLNWGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:06:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27997 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2440148AbgLNWGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607983483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fW75B8TuuWSO4pQv9VG4aA61uFDavRGNu4wKmT1MNjY=;
        b=aoBZuab0hxhxIYXDcusu+VYEXR7qW1vvQIDGxc7EOL/hQ36B15D3m3qLalmDc1mlj/lWw0
        KjJ2VaBDv5CQcYIKWmk7V5R4LiwPWB91a/CP4yUVz0m6EeJRwBL5UoN6hg728e+c4gwWjC
        SmtgyGpkyM6f/bM8E/Mi0w0vI+KzdmQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-B38apv-TNfmiwQxh6Kf2wA-1; Mon, 14 Dec 2020 17:04:40 -0500
X-MC-Unique: B38apv-TNfmiwQxh6Kf2wA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1B188049C1;
        Mon, 14 Dec 2020 22:04:38 +0000 (UTC)
Received: from treble.redhat.com (ovpn-112-170.rdu2.redhat.com [10.10.112.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D13955D9DC;
        Mon, 14 Dec 2020 22:04:37 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux@googlegroups.com,
        Arnd Bergmann <arnd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] objtool: Fix seg fault with Clang non-section symbols
Date:   Mon, 14 Dec 2020 16:04:20 -0600
Message-Id: <ba6b6c0f0dd5acbba66e403955a967d9fdd1726a.1607983452.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Clang assembler likes to strip section symbols, which means objtool
can't reference some text code by its section.  This confuses objtool
greatly, causing it to seg fault.

The fix is similar to what was done before, for ORC reloc generation:

  e81e07244325 ("objtool: Support Clang non-section symbols in ORC generation")

Factor out that code into a common helper and use it for static call
reloc generation as well.

Reported-by: Arnd Bergmann <arnd@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1207
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c   | 11 +++++++++--
 tools/objtool/elf.c     | 26 ++++++++++++++++++++++++++
 tools/objtool/elf.h     |  2 ++
 tools/objtool/orc_gen.c | 29 +++++------------------------
 4 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c6ab44543c92..5f8d3eed78a1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -467,13 +467,20 @@ static int create_static_call_sections(struct objtool_file *file)
 
 		/* populate reloc for 'addr' */
 		reloc = malloc(sizeof(*reloc));
+
 		if (!reloc) {
 			perror("malloc");
 			return -1;
 		}
 		memset(reloc, 0, sizeof(*reloc));
-		reloc->sym = insn->sec->sym;
-		reloc->addend = insn->offset;
+
+		insn_to_reloc_sym_addend(insn->sec, insn->offset, reloc);
+		if (!reloc->sym) {
+			WARN_FUNC("static call tramp: missing containing symbol",
+				  insn->sec, insn->offset);
+			return -1;
+		}
+
 		reloc->type = R_X86_64_PC32;
 		reloc->offset = idx * sizeof(struct static_call_site);
 		reloc->sec = reloc_sec;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 4e1d7460574b..be89c741ba9a 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -262,6 +262,32 @@ struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, uns
 	return find_reloc_by_dest_range(elf, sec, offset, 1);
 }
 
+void insn_to_reloc_sym_addend(struct section *sec, unsigned long offset,
+			      struct reloc *reloc)
+{
+	if (sec->sym) {
+		reloc->sym = sec->sym;
+		reloc->addend = offset;
+		return;
+	}
+
+	/*
+	 * The Clang assembler strips section symbols, so we have to reference
+	 * the function symbol instead:
+	 */
+	reloc->sym = find_symbol_containing(sec, offset);
+	if (!reloc->sym) {
+		/*
+		 * Hack alert.  This happens when we need to reference the NOP
+		 * pad insn immediately after the function.
+		 */
+		reloc->sym = find_symbol_containing(sec, offset - 1);
+	}
+
+	if (reloc->sym)
+		reloc->addend = offset - reloc->sym->offset;
+}
+
 static int read_sections(struct elf *elf)
 {
 	Elf_Scn *s = NULL;
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 807f8c670097..e6890cc70a25 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -140,6 +140,8 @@ struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, uns
 struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len);
 struct symbol *find_func_containing(struct section *sec, unsigned long offset);
+void insn_to_reloc_sym_addend(struct section *sec, unsigned long offset,
+			      struct reloc *reloc);
 int elf_rebuild_reloc_section(struct elf *elf, struct section *sec);
 
 #define for_each_sec(file, sec)						\
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 235663b96adc..9ce68b385a1b 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -105,30 +105,11 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
 	}
 	memset(reloc, 0, sizeof(*reloc));
 
-	if (insn_sec->sym) {
-		reloc->sym = insn_sec->sym;
-		reloc->addend = insn_off;
-	} else {
-		/*
-		 * The Clang assembler doesn't produce section symbols, so we
-		 * have to reference the function symbol instead:
-		 */
-		reloc->sym = find_symbol_containing(insn_sec, insn_off);
-		if (!reloc->sym) {
-			/*
-			 * Hack alert.  This happens when we need to reference
-			 * the NOP pad insn immediately after the function.
-			 */
-			reloc->sym = find_symbol_containing(insn_sec,
-							   insn_off - 1);
-		}
-		if (!reloc->sym) {
-			WARN("missing symbol for insn at offset 0x%lx\n",
-			     insn_off);
-			return -1;
-		}
-
-		reloc->addend = insn_off - reloc->sym->offset;
+	insn_to_reloc_sym_addend(insn_sec, insn_off, reloc);
+	if (!reloc->sym) {
+		WARN("missing symbol for insn at offset 0x%lx",
+		     insn_off);
+		return -1;
 	}
 
 	reloc->type = R_X86_64_PC32;
-- 
2.26.2


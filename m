Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8612F6CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 21:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbhANU5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 15:57:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728414AbhANU5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 15:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610657754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yBGqFp0/AGy67G2GU5MRUO2gAeWdKdgk866e/Nrr2ow=;
        b=hOFCQYYKB59Cp8GFU/tnO33PK+E62emzDAl9vfzB60WmNjCHKpRBjCOZALzlj5fdEDSKsE
        q8UW2Kj9bZjxxJMw+d9N/lRidawNXjIhNeFcCKVIvzKMz027Wwvi0oNwVzlr+l1F5ji0oT
        bESp2JvjLkn1fJ5h8aTjHxWkr2pT2uk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-6gvhsoLSPPuUyzdfBBXneg-1; Thu, 14 Jan 2021 15:55:53 -0500
X-MC-Unique: 6gvhsoLSPPuUyzdfBBXneg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82752806668;
        Thu, 14 Jan 2021 20:55:51 +0000 (UTC)
Received: from treble (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 68D101803B;
        Thu, 14 Jan 2021 20:55:49 +0000 (UTC)
Date:   Thu, 14 Jan 2021 14:55:44 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v1.1 11/21] objtool: Move unsuffixed symbol conversion to a
 helper function
Message-ID: <20210114205544.ehynfby5tummams5@treble>
References: <cover.1610652862.git.jpoimboe@redhat.com>
 <37e341c0f4522656a6320528f0aacb0cb7ff0034.1610652862.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37e341c0f4522656a6320528f0aacb0cb7ff0034.1610652862.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This logic will also be needed for the CONFIG_CFI_CLANG support.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/elf.c | 60 ++++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index be89c741ba9a..6d248a19e2c6 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -262,6 +262,38 @@ struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, uns
 	return find_reloc_by_dest_range(elf, sec, offset, 1);
 }
 
+static int find_unsuffixed_func(const struct elf *elf, struct symbol *sym,
+				const char *suffix, struct symbol **func)
+{
+	char name[MAX_NAME_LEN + 1];
+	const char *loc;
+	size_t len;
+
+	*func = NULL;
+
+	loc = strstr(sym->name, suffix);
+	if (!loc)
+		return 0;
+
+	len = loc - sym->name;
+	if (len > MAX_NAME_LEN) {
+		WARN("%s(): unsuffixed function name exceeds maximum length of %d characters",
+		     sym->name, MAX_NAME_LEN);
+		return -1;
+	}
+
+	strncpy(name, sym->name, len);
+	name[len] = '\0';
+
+	*func = find_symbol_by_name(elf, name);
+	if (!*func || (*func)->type != STT_FUNC) {
+		WARN("%s(): can't find unsuffixed function", sym->name);
+		return -1;
+	}
+
+	return 0;
+}
+
 void insn_to_reloc_sym_addend(struct section *sec, unsigned long offset,
 			      struct reloc *reloc)
 {
@@ -374,7 +406,6 @@ static int read_symbols(struct elf *elf)
 	struct list_head *entry;
 	struct rb_node *pnode;
 	int symbols_nr, i;
-	char *coldstr;
 	Elf_Data *shndx_data = NULL;
 	Elf32_Word shndx;
 
@@ -456,37 +487,20 @@ static int read_symbols(struct elf *elf)
 	/* Create parent/child links for any cold subfunctions */
 	list_for_each_entry(sec, &elf->sections, list) {
 		list_for_each_entry(sym, &sec->symbol_list, list) {
-			char pname[MAX_NAME_LEN + 1];
-			size_t pnamelen;
 			if (sym->type != STT_FUNC)
 				continue;
 
-			if (sym->pfunc == NULL)
+			if (!sym->pfunc)
 				sym->pfunc = sym;
 
-			if (sym->cfunc == NULL)
+			if (!sym->cfunc)
 				sym->cfunc = sym;
 
-			coldstr = strstr(sym->name, ".cold");
-			if (!coldstr)
-				continue;
-
-			pnamelen = coldstr - sym->name;
-			if (pnamelen > MAX_NAME_LEN) {
-				WARN("%s(): parent function name exceeds maximum length of %d characters",
-				     sym->name, MAX_NAME_LEN);
+			if (find_unsuffixed_func(elf, sym, ".cold", &pfunc))
 				return -1;
-			}
 
-			strncpy(pname, sym->name, pnamelen);
-			pname[pnamelen] = '\0';
-			pfunc = find_symbol_by_name(elf, pname);
-
-			if (!pfunc) {
-				WARN("%s(): can't find parent function",
-				     sym->name);
-				return -1;
-			}
+			if (!pfunc)
+				continue;
 
 			sym->pfunc = pfunc;
 			pfunc->cfunc = sym;
-- 
2.29.2


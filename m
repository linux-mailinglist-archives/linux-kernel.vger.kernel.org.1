Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503431B2EBD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 20:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgDUSHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 14:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbgDUSHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:07:39 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A40C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 11:07:38 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id o6so4025598pjl.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 11:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=au6uumjT1zWMK8KDLrkHDsklveSUNzLhdmZb1DNGngU=;
        b=fpmx15OTRr3+QAzH+yoCVT5PkrBO6/jyUfC6ePBBca/zz12ZoK7bbNuCPJat8YIrlc
         jpVy115I+rNwCC3AZ5pj3TxOXF0X40MONWVBzCYd9wY5IiHU+XIPl0uyNrFFhK1fSMKG
         SeVieulfgGVwIkqgeH9aPgMN5g6oXA2ODFW1HEGGqGTLFukOTL+BNr1p+ep+/usVdtC0
         A4bNPbSnftASqIfIAsV92V3pbn9kmx5d3U9XUdl68htx/Fm59BMTOZYBbMd8RZMcPkWV
         BCscd1+Ftf2bAeiJ9F7qNu6zojb5yvU572UA+Apf7jJIS+HbNaEusPawwgmDfCuZQHhh
         0Jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=au6uumjT1zWMK8KDLrkHDsklveSUNzLhdmZb1DNGngU=;
        b=YDptBSqyA1nbxXLzYvbq12qdSHzsiF8Ge0unQuk+i0pCOW8tgPq2BjkTC+l2qJ5xQj
         W25wYOyL3+v3oI8M88bP/TA6v+EJ/B5UvzNt7FTbHqMnDK1NUCW1Km6kaPospmMrZQzs
         GZNS1qSc8v/Lt8E/YU8fUtEkzkwjGiVM4TSxgS3TLp5WIoCU53hPnV0HIZEMJeEahqYA
         IecyXRoQIw5F/8+89HSNsc6nk+qovFhRCEP4537MRwLHpRfrAmdHhkKkBNmP1Ok1D2om
         SMMHnVBxEQSzwfhS8p0mDNLubM4DdSS9qIxGH5G9y8ZlSNFqOkVl6BKEBWZ0gEZ6rWfD
         wHRg==
X-Gm-Message-State: AGi0PuaajWZtnkBxAyoNGWRlgWz6/Qvmrelx/tdV42rCm4xei24gGvMi
        QsFE21yz53jedOebTlRUqca1PF9vzAFeJoA9YwU=
X-Google-Smtp-Source: APiQypIFE/p55Ry6sL96Gs0HWYmVuj/HgnvBESSfawHZ1FkRSX612AAHTmcTqO2ctUvpKAw3DqNgcdWCS7hmUAUphT0=
X-Received: by 2002:a17:90a:77cb:: with SMTP id e11mr7360422pjs.0.1587492457823;
 Tue, 21 Apr 2020 11:07:37 -0700 (PDT)
Date:   Tue, 21 Apr 2020 11:07:24 -0700
In-Reply-To: <20200421180724.245410-1-samitolvanen@google.com>
Message-Id: <20200421180724.245410-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200421180724.245410-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH 3/3] objtool: optimize add_dead_ends for split sections
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running objtool on vmlinux.o compiled with -ffunction-sections,
.rela.discard.(un)reachable often contains relocations that point to
a different section. Instead of iterating through the list of all
instructions each time, store a pointer to the last instruction of
each section when decoding instructions.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 tools/objtool/check.c | 43 ++++++++++++++++++++++++++-----------------
 tools/objtool/check.h |  4 ++++
 tools/objtool/elf.h   |  1 +
 3 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4770fb07b365..7d4104de0a5e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -237,6 +237,7 @@ static void clear_insn_state(struct insn_state *state)
 static int decode_instructions(struct objtool_file *file)
 {
 	struct section *sec;
+	struct section_info *sec_info = NULL;
 	struct symbol *func;
 	unsigned long offset;
 	struct instruction *insn;
@@ -253,6 +254,8 @@ static int decode_instructions(struct objtool_file *file)
 		    strncmp(sec->name, ".discard.", 9))
 			sec->text = true;
 
+		insn = NULL;
+
 		for (offset = 0; offset < sec->len; offset += insn->len) {
 			insn = malloc(sizeof(*insn));
 			if (!insn) {
@@ -279,6 +282,17 @@ static int decode_instructions(struct objtool_file *file)
 			nr_insns++;
 		}
 
+		if (insn) {
+			sec_info = malloc(sizeof(*sec_info));
+			if (!sec_info) {
+				WARN("malloc failed");
+				return -1;
+			}
+
+			sec_info->last_insn = insn;
+			sec->section_info = sec_info;
+		}
+
 		list_for_each_entry(func, &sec->symbol_list, list) {
 			if (func->type != STT_FUNC || func->alias != func)
 				continue;
@@ -312,7 +326,6 @@ static int add_dead_ends(struct objtool_file *file)
 	struct section *sec;
 	struct rela *rela;
 	struct instruction *insn;
-	bool found;
 
 	/*
 	 * By default, "ud2" is a dead end unless otherwise annotated, because
@@ -338,15 +351,13 @@ static int add_dead_ends(struct objtool_file *file)
 		if (insn)
 			insn = list_prev_entry(insn, list);
 		else if (rela->addend == rela->sym->sec->len) {
-			found = false;
-			list_for_each_entry_reverse(insn, &file->insn_list, list) {
-				if (insn->sec == rela->sym->sec) {
-					found = true;
-					break;
-				}
-			}
+			struct section_info *sec_info = (struct section_info *)
+				rela->sym->sec->section_info;
+
+			if (sec_info)
+				insn = sec_info->last_insn;
 
-			if (!found) {
+			if (!insn) {
 				WARN("can't find unreachable insn at %s+0x%x",
 				     rela->sym->sec->name, rela->addend);
 				return -1;
@@ -380,15 +391,13 @@ static int add_dead_ends(struct objtool_file *file)
 		if (insn)
 			insn = list_prev_entry(insn, list);
 		else if (rela->addend == rela->sym->sec->len) {
-			found = false;
-			list_for_each_entry_reverse(insn, &file->insn_list, list) {
-				if (insn->sec == rela->sym->sec) {
-					found = true;
-					break;
-				}
-			}
+			struct section_info *sec_info = (struct section_info *)
+				rela->sym->sec->section_info;
+
+			if (sec_info)
+				insn = sec_info->last_insn;
 
-			if (!found) {
+			if (!insn) {
 				WARN("can't find reachable insn at %s+0x%x",
 				     rela->sym->sec->name, rela->addend);
 				return -1;
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index bc78eca7982e..353677ec85d4 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -47,6 +47,10 @@ struct instruction {
 	struct orc_entry orc;
 };
 
+struct section_info {
+	struct instruction *last_insn;
+};
+
 struct objtool_file {
 	struct elf *elf;
 	struct list_head insn_list;
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index ebbb10c61e24..98f2b41d18e4 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -40,6 +40,7 @@ struct section {
 	int idx;
 	unsigned int len;
 	bool changed, text, rodata;
+	void *section_info;
 };
 
 struct symbol {
-- 
2.26.1.301.g55bc3eb7cb9-goog


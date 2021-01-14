Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055BD2F6B65
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbhANTmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:42:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47772 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730028AbhANTms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610653282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iw7uI9IpjmMU1PfQcTgHZzBKM8vm3zrVcKwZ66h5Qtw=;
        b=JOS1RKEAQGlZ5V7NahSSgLjb3T+pD3ldLulrvdtehWI9v5N7TjeLbtUXs3SHw6kt7vwHBj
        pFjXzchy1r/4lHdWN/Xi513fnLKXAxN7OFCIoJS2zf8E7XnSxY72xz1+d2UwMNYPrIUXpV
        aKQ9KdxD/kAwBonwUaK04RzF6uIom+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-lJ7-07AqOs6K0qTGwyhYsw-1; Thu, 14 Jan 2021 14:41:20 -0500
X-MC-Unique: lJ7-07AqOs6K0qTGwyhYsw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F524190B2A0;
        Thu, 14 Jan 2021 19:41:18 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49A041001E73;
        Thu, 14 Jan 2021 19:41:13 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 12/21] objtool: Add CONFIG_CFI_CLANG support
Date:   Thu, 14 Jan 2021 13:40:08 -0600
Message-Id: <c1889131d5de558e58700ba559e7d8606fe9c680.1610652862.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1610652862.git.jpoimboe@redhat.com>
References: <cover.1610652862.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upcoming CONFIG_CFI_CLANG support uses -fsanitize=cfi, the
non-canonical version of which hijacks function entry by changing
function relocation references to point to an intermediary jump table.

For example:

  Relocation section '.rela.discard.func_stack_frame_non_standard' at offset 0x37e018 contains 6 entries:
      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  0000000000000000  0002944700000002 R_X86_64_PC32          00000000000023f0 do_suspend_lowlevel + 0
  0000000000000008  0003c11900000001 R_X86_64_64            0000000000000008 xen_cpuid$e69bc59f4fade3b6f2b579b3934137df.cfi_jt + 0
  0000000000000010  0003980900000001 R_X86_64_64            0000000000000060 machine_real_restart.cfi_jt + 0
  0000000000000018  0003962b00000001 R_X86_64_64            0000000000000e18 kretprobe_trampoline.cfi_jt + 0
  0000000000000020  000028f300000001 R_X86_64_64            0000000000000000 .rodata + 12
  0000000000000028  000349f400000001 R_X86_64_64            0000000000000018 __crash_kexec.cfi_jt + 0

  0000000000000060 <machine_real_restart.cfi_jt>:
    60: e9 00 00 00 00          jmpq   65 <machine_real_restart.cfi_jt+0x5>
                        61: R_X86_64_PLT32      machine_real_restart-0x4
    65: cc                      int3
    66: cc                      int3
    67: cc                      int3

This breaks objtool vmlinux validation in many ways, including static
call site detection and the STACK_FRAME_NON_STANDARD() macro.

Fix it by converting those relocations' symbol references back to their
original non-jump-table versions.  Note this doesn't change the actual
relocations in the object itself, it just changes objtool's view of
them.

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/elf.c | 28 ++++++++++++++++++++++++++++
 tools/objtool/elf.h |  2 +-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 292f015f7ec6..e357dc34cd7a 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -382,6 +382,11 @@ static int read_sections(struct elf *elf)
 		}
 		sec->len = sec->sh.sh_size;
 
+		/* Detect -fsanitize=cfi related sections */
+		if (!strcmp(sec->name, ".text.__cfi_check") ||
+		    !strncmp(sec->name, ".text..L.cfi.jumptable", 22))
+			sec->cfi_jt = true;
+
 		list_add_tail(&sec->list, &elf->sections);
 		elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
 		elf_hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
@@ -614,6 +619,29 @@ static int read_relocs(struct elf *elf)
 				return -1;
 			}
 
+			/*
+			 * Deal with -fsanitize=cfi (CONFIG_CFI_CLANG), which
+			 * hijacks function entry by arbitrarily changing a lot
+			 * of relocation symbol references to refer to an
+			 * intermediate jump table.  Undo that conversion so
+			 * objtool can make sense of things.
+			 */
+			if (reloc->sym->sec->cfi_jt) {
+				struct symbol *func, *sym;
+
+				if (sym->type == STT_SECTION)
+					sym = find_func_by_offset(sym->sec,
+								  reloc->addend);
+				else
+					sym = reloc->sym;
+
+				if (find_unsuffixed_func(elf, sym, ".cfi_jt", &func))
+					return -1;
+
+				if (func)
+					reloc->sym = func;
+			}
+
 			elf_add_reloc(elf, reloc);
 			nr_reloc++;
 		}
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index e6890cc70a25..bcc524d73f51 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -39,7 +39,7 @@ struct section {
 	char *name;
 	int idx;
 	unsigned int len;
-	bool changed, text, rodata, noinstr;
+	bool changed, text, rodata, noinstr, cfi_jt;
 };
 
 struct symbol {
-- 
2.29.2


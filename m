Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1275E2F6CBC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 21:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbhANU6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 15:58:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24453 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727380AbhANU57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 15:57:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610657793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G9+4Pk0QfMyGrL+EPSU/M84dgufmtwgcIjPfqAvJ8sg=;
        b=IQE7vJZlhtmGmsvRDKO6+pEn0sZ2neH4VgVPzQtXUMblX1LaS/mtPazuLnepyTpWDHtv5d
        r1cZOqV4lGQ+H59p/3GV8o4MlJI1PdcldGHjjAVmdb/Tyc5W8XU3TAF4V+P8sgNKEdGxNH
        u9Tz89uyQcDCQ5Q/Zd4nve9hir9qwZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-d1u3mahQOtyoXoN_KPF6aw-1; Thu, 14 Jan 2021 15:56:29 -0500
X-MC-Unique: d1u3mahQOtyoXoN_KPF6aw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A454107ACF7;
        Thu, 14 Jan 2021 20:56:27 +0000 (UTC)
Received: from treble (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5952E12D7E;
        Thu, 14 Jan 2021 20:56:26 +0000 (UTC)
Date:   Thu, 14 Jan 2021 14:56:24 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v1.1 12/21] objtool: Add CONFIG_CFI_CLANG support
Message-ID: <20210114205624.dpodesrcljpnfsaj@treble>
References: <cover.1610652862.git.jpoimboe@redhat.com>
 <c1889131d5de558e58700ba559e7d8606fe9c680.1610652862.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1889131d5de558e58700ba559e7d8606fe9c680.1610652862.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
index 6d248a19e2c6..142b2ce49328 100644
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
@@ -613,6 +618,29 @@ static int read_relocs(struct elf *elf)
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
+				if (reloc->sym->type == STT_SECTION)
+					sym = find_func_by_offset(reloc->sym->sec,
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


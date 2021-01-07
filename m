Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9D42EC741
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 01:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbhAGAS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 19:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbhAGAS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 19:18:26 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958B3C06136A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 16:17:46 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j1so7022027ybj.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 16:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=lF6425iSo/7VCEtMZN9oNw0V0JdXZmHytXzvDMuDncU=;
        b=YbRzwjA0fz7XypKh56Rf93j+rf/C78PxiUEIqWoFm3/CDY8/jugRj44OIZmX7ZaLj2
         cK4g/WXAFH0LuBIwS/OzMsK35bfp7vOjdm2lirgtzATw7NMo5Bx5qOOc/Pl0306yfyR9
         tHHNaNn1TuxQoJ7YY4L4SG8mtQSOmY8C/vJQA/NAdgh2CqyL/SMzu9TzMzP7+ziNgL5o
         3TX3JmDQCGvMCsh5PHuSI8vAANzRua2HZgJYletbyjHjA2D6zykEUrAUCX/Uu9lxt49d
         8MypnxKoc5lUiKFW6BbogmX3vD7/4zgwP278P00ipGwyEUGRVWBXsJPBJNfloZw9UeEi
         k24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=lF6425iSo/7VCEtMZN9oNw0V0JdXZmHytXzvDMuDncU=;
        b=Li7/zLom6dUFM5YWVv93d5RJnv5dGdaSqeUsckWEyJbntyrCXRdn2X0UwJArVDO79V
         xrkNRCf2P4E0pAEID/Tq9aB4d6R/pEG5CifkETpgHKqHD7r4K7e7tAk+Goy6U6UcoQYW
         zDjybV2o8pOlE2bhaet0plbaV1NFcVMNTYN+mmfUG1nx81zhXXILwchKGEyo/bzTJsS4
         iMKz6eL6HHC6WimCjAyYgZi0XweKT0nUOgeZ1knJBnT6n0YDuZYaZycXHrIpqE8fCUWD
         TMeEYvVvrvRNAvOQzwlNZOPLwfjrdLfT2trgQawwRc2ihCh5HI7MFjx3gGnhAnHSuMwP
         SjdA==
X-Gm-Message-State: AOAM530sYhrU7qvahisn2v1A+Ru+Nqur9IgkYxyQ003qfbE8gtuGSoSG
        hhUjpHZ8XX6H9kr6KRbCJt8Ds7klO7Fl
X-Google-Smtp-Source: ABdhPJyTvuInb6OGHthms8nS9OMjqSA356Hfp2gxG7RBP7/vlspovzEaZBv9tjBGzYFtjlAEExMKbQirmvWZ
Sender: "maskray via sendgmr" <maskray@maskray1.svl.corp.google.com>
X-Received: from maskray1.svl.corp.google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
 (user=maskray job=sendgmr) by 2002:a25:1386:: with SMTP id
 128mr9503757ybt.374.1609978665106; Wed, 06 Jan 2021 16:17:45 -0800 (PST)
Date:   Wed,  6 Jan 2021 16:17:39 -0800
Message-Id: <20210107001739.1321725-1-maskray@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH] x86: Treat R_386_PLT32 as R_386_PC32
From:   Fangrui Song <maskray@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is similar to commit b21ebf2fb4cde1618915a97cc773e287ff49173e "x86:
Treat R_X86_64_PLT32 as R_X86_64_PC32", but for i386.  As far as Linux
kernel is concerned, R_386_PLT32 can be treated the same as R_386_PC32.

R_386_PC32/R_X86_64_PC32 are PC-relative relocation types with the
requirement that the symbol address is significant.
R_386_PLT32/R_X86_64_PLT32 are PC-relative relocation types without the
address significance requirement.

On x86-64, there is no PIC vs non-PIC PLT distinction and an
R_X86_64_PLT32 relocation is produced for both `call/jmp foo` and
`call/jmp foo@PLT` with newer (2018) GNU as/LLVM integrated assembler.

On i386, there are 2 types of PLTs, PIC and non-PIC. Currently the
convention is to use R_386_PC32 for non-PIC PLT and R_386_PLT32 for PIC
PLT, but R_386_PLT32 is arguably preferable for -fno-pic code as well:
this can avoid a "canonical PLT entry" (st_shndx=0, st_value!=0) if the
symbol turns out to be defined externally. Latest Clang (since
961f31d8ad14c66829991522d73e14b5a96ff6d4) can use R_386_PLT32 for
compiler produced symbols (if we drop -ffreestanding for CONFIG_X86_32,
library call optimization can produce newer declarations) and future GCC
may use R_386_PLT32 as well if the maintainers agree to adopt an option
like -fdirect-access-external-data to avoid "canonical PLT entry"/copy
relocations https://gcc.gnu.org/bugzilla/show_bug.cgi?id=98112

Link: https://github.com/ClangBuiltLinux/linux/issues/1210
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Fangrui Song <maskray@google.com>
---
 arch/x86/kernel/module.c | 1 +
 arch/x86/tools/relocs.c  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 34b153cbd4ac..5e9a34b5bd74 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -114,6 +114,7 @@ int apply_relocate(Elf32_Shdr *sechdrs,
 			*location += sym->st_value;
 			break;
 		case R_386_PC32:
+		case R_386_PLT32:
 			/* Add the value, subtract its position */
 			*location += sym->st_value - (uint32_t)location;
 			break;
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index ce7188cbdae5..717e48ca28b6 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -867,6 +867,7 @@ static int do_reloc32(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
 	case R_386_PC32:
 	case R_386_PC16:
 	case R_386_PC8:
+	case R_386_PLT32:
 		/*
 		 * NONE can be ignored and PC relative relocations don't
 		 * need to be adjusted.
@@ -910,6 +911,7 @@ static int do_reloc_real(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
 	case R_386_PC32:
 	case R_386_PC16:
 	case R_386_PC8:
+	case R_386_PLT32:
 		/*
 		 * NONE can be ignored and PC relative relocations don't
 		 * need to be adjusted.
-- 
2.29.2.729.g45daf8777d-goog


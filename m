Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77FB2ED708
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 19:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbhAGS4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 13:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGS4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 13:56:43 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70B7C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 10:56:03 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id t17so5449711pgu.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 10:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Rs0BbOafhHV4Dcur9iSUX1ae/IOL8F95TEfFD8pRkl0=;
        b=UOoIuhcwmfKGhyH/Pi78u7JkbGmtv1SdsseJ020hvVbJbV42lqvQZo2kQgKoY+4Mvx
         OBT8dAYuuXE/L0j0ZFomDQWEAgVPJ+2CkoWhle67GGrb+W2aiJJReGB8LSHJ5fDJJlvM
         WnnqniZeHXYqPt/gxipYxBCHYJH6QeC4ZER/47kSUBP8MHpDSN+De4nWuS22xJ86Sb5+
         F9Iqv18StRmIraKFSVtPlGi7j3/VhOtEt7gucmHa5dyjmqQ+UHsZ5pbxkC4U/MzGSpA4
         JpDSAsulXNGWfF9G55gWWZ+da5Ew/syX5GQE4HYSwcWKbGKH7s0WSm9QBvkWVw9Ycnsa
         rztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Rs0BbOafhHV4Dcur9iSUX1ae/IOL8F95TEfFD8pRkl0=;
        b=RGVZ5F7eY8EUT/dolgyCdIN2J6aKh7m+Kx0ocurAquMxzUe00R0vAZEeHk9bLbFYWm
         XzfOgx7XIybW35TI19Xj+fSG89+tPLpk750Y/tza6X28nxJvHziZUDMi2CX+krbt/PMP
         pq0Y/yFFRNtM12wsb3lPZda7BtMnGxf3tHX71qT51IyssZLFQm8QYxxXhmMyMZaWas2L
         U2WK0TMUkPL/CeDBZcPAlQARJFIQNEAzrK/Gat3zjrnuikCHhpTgCpidvVIPgyV6imeV
         P65Q8QV5FhxYMdj4fnFRPlLuJz4I2F7mymgChT+oHfPSCryTpNj77iJvI3NHj1/DScN8
         3fxQ==
X-Gm-Message-State: AOAM531GdX2CvPNV8E6WabjNDdaxQPep1MKlynmOBFHaOt9gcNSgaS/w
        AHSnQXgvEkugx0zkFlLjydrWqqOqjlk9
X-Google-Smtp-Source: ABdhPJwjcs/GBrhway2oGTdKlOJ674yzGlHXv4x74Mlc8jlI2FbIHJe9FEUjbPZMnxm8tOl7ALlYnB4fwZ/k
Sender: "maskray via sendgmr" <maskray@maskray1.svl.corp.google.com>
X-Received: from maskray1.svl.corp.google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
 (user=maskray job=sendgmr) by 2002:a17:90a:7149:: with SMTP id
 g9mr10484548pjs.12.1610045763206; Thu, 07 Jan 2021 10:56:03 -0800 (PST)
Date:   Thu,  7 Jan 2021 10:55:55 -0800
In-Reply-To: <20210107023145.GA3778412@ubuntu-m3-large-x86>
Message-Id: <20210107185555.2781221-1-maskray@google.com>
Mime-Version: 1.0
References: <20210107023145.GA3778412@ubuntu-m3-large-x86>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v2] x86: Treat R_386_PLT32 as R_386_PC32
From:   Fangrui Song <maskray@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Fangrui Song <maskray@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is similar to commit b21ebf2fb4cd ("x86: Treat R_X86_64_PLT32 as
R_X86_64_PC32"), but for i386.  As far as Linux kernel is concerned,
R_386_PLT32 can be treated the same as R_386_PC32.

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
symbol turns out to be defined externally.

clang-12 -fno-pic (since
https://github.com/llvm/llvm-project/commit/961f31d8ad14c66829991522d73e14b5a96ff6d4)
can emit R_386_PLT32 for compiler produced symbols (if we drop
-ffreestanding for CONFIG_X86_32, library call optimization can produce
newer declarations) and future GCC -fno-pic may emit R_386_PLT32 as well
if an option like -fno-direct-access-external-data is adopted to avoid
canonical PLT entry/copy relocations.

Link: https://github.com/ClangBuiltLinux/linux/issues/1210
Link: https://github.com/llvm/llvm-project/commit/961f31d8ad14c66829991522d73e14b5a96ff6d4
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=98112
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Fangrui Song <maskray@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

---
Change in v2:
* Improve commit message
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


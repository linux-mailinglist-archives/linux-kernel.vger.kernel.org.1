Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE6B2F6E90
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 23:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbhANWtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 17:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730815AbhANWtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 17:49:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246B2C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 14:48:23 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v187so1911691ybv.21
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 14:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=RbsfhVoCXn95CjDh/v1ZbeIm2/iYKTwaoq52D6PfEPY=;
        b=JuCQDAekJiG5HdKehuCqJGAjkuyxlcwDj+qlmc/HReJX5IoAhBrxD4wk92faxiGz0q
         se8iaJ5om2woDhR+QpQ0gSvGSq801b47MjUYZv04QXCV8DP+OAi/GO7uEF0fJdmFuOpY
         oUF/exMaBeMhH+2iQDx2kF3N1wFl056I8v7n+WUKaDffCMRHzFQj3GXnpzTwAGtaYCwN
         JoWc6wM31t1VlGVUbqjK6ML0g1g5jxq96Z5I+v2l1h8s3QGhKvgAciC+fLDadzmdTvXC
         HD/e8DsQZLZHR7+lTGbaZ3QjC5sCmpDM4lJ0U53AevQTleFRjPzSjGAZMWwPoRMgmf9y
         A7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RbsfhVoCXn95CjDh/v1ZbeIm2/iYKTwaoq52D6PfEPY=;
        b=chVouDa/e6fYgwUc2AgZGClDEBO1+eauWabbxWfRYNAUxMV6McWdBy63kzkkOF8LKm
         e6xxooKAXZ0MFeYNWhf019K8rN3AREhgyud8C49XRgwKU+TVhIoPjmfONCc6IC/poMwl
         3j8gJzbGeUdTg+asePckEZzSJ+lJ0VhuOXbEXwPyM/kzHEsCx/Mmi9q68PKF8o6bF94P
         QBL7BdLN/Ym0DzfZa94FpW2aoJFgkxnA7+PhiTcw93+/JA9OfrcYmDfyfAAXBBiAn5K+
         Y8ADls+eTlbMQnTqngjayK+etUisdcqQa8se+51QeDWxW1eJbM0ZvbM1KruX3j0ZFhdD
         E1dg==
X-Gm-Message-State: AOAM530U2kzQ5UHI2UsdRBfoJt+pdesecM93tr5SYhWXwldY+6rLq50G
        8pH0Q85yj154F+Bo6eMlEltfIx38fBzi
X-Google-Smtp-Source: ABdhPJx8UObKMHmLIz7WMbc2YnjaZFuPfuiYZynWknoXYdD64/vPatlAO9H8PSfqCiFVJX5rE+hWjJURH3yK
Sender: "maskray via sendgmr" <maskray@maskray1.svl.corp.google.com>
X-Received: from maskray1.svl.corp.google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
 (user=maskray job=sendgmr) by 2002:a25:b341:: with SMTP id
 k1mr14146305ybg.37.1610664502367; Thu, 14 Jan 2021 14:48:22 -0800 (PST)
Date:   Thu, 14 Jan 2021 14:48:19 -0800
In-Reply-To: <20210107185555.2781221-1-maskray@google.com>
Message-Id: <20210114224819.1608929-1-maskray@google.com>
Mime-Version: 1.0
References: <20210107185555.2781221-1-maskray@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH v3] x86: Treat R_386_PLT32 as R_386_PC32
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
PLT.

clang-12 -fno-pic (since
https://github.com/llvm/llvm-project/commit/a084c0388e2a59b9556f2de0083333232da3f1d6)
can emit R_386_PLT32 for compiler generated function declarations as
well to avoid a canonical PLT entry (st_shndx=0, st_value!=0) if the
symbol turns out to be defined externally. GCC/GNU as will likely keep
using R_386_PC32 because (1) the ABI is legacy (2) the change will drop
a GNU ld non-default visibility ifunc for shared objects.
https://sourceware.org/bugzilla/show_bug.cgi?id=27169

Link: https://github.com/ClangBuiltLinux/linux/issues/1210
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
Change in v3:
* Change the GCC link to the more relevant GNU as link.
* Fix the relevant llvm-project commit id.
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
2.30.0.296.g2bfb1c46d8-goog


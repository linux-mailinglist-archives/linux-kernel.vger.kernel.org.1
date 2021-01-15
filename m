Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CE72F85C2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387929AbhAOTxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387598AbhAOTxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:53:07 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BADC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 11:52:26 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id a11so8294112qto.16
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 11:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hIBuX1lFcyKuQyrZ5+wCeMHBsoAjyJ/AkMUpbHJsyDA=;
        b=vPUz2aDCW5pdZVD7KqFIIagVxy491m4FJi/LuKcocOVjg44wS5kI5kgKz+dwBnL9JX
         uQxW52bGaLwjEJSLkfQYdHoM0/fK993FQ1CrKsVEIbiIld0DLatHwyP7MY6kFzbx6uGl
         BZLmhYS6LI+DlxuGghqj27f7CSqb9ASt00odH4NLFhL1U6zC/AbLRXdhseUFdPmEXTNV
         alCiSATBPsV8olT+/MGL4j9aEt9lP7trzOPDIpbESuqVlHPs3jVxVji3krL5TUKREIUX
         pjmgn5iquINuJMzrnza6CT7/yyDSMzcyiU+75JNykyWO8iZPUWti3aNULASoj0vrU0Bu
         Vktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hIBuX1lFcyKuQyrZ5+wCeMHBsoAjyJ/AkMUpbHJsyDA=;
        b=X2WkbQvjKquve4CL7XbC1mTDYWnRev4Q5YzfhLedtVD4DGn7LstmOneofcoitDol0e
         BTDw6YFPCg/s4PpVmKSuSUcZP0TMUpU5feRNJQkTC9OEcTk4TkkvF2rO1Oime/QxStxQ
         Y2j8/FA0BREPLKmwfq0eTYMeKNmDy5kcAIQM57cvMCiw+A5iT9GglUp7JXPxUFourbv0
         J5zFM8E1I5Xc0d9UEo5iPhD/753KDxfw1uflOQvgF+TiXHvCDmfoFiEpc24dM7qV7MUo
         92pupdz2tgeoVArFhCPzw19h64LEUfAmVkHxFsVuea1ZyIKfofljRsVZneqydD8Q5iKH
         c0tA==
X-Gm-Message-State: AOAM532JY7bXocJC5dAxAuf50DyWfA7w6oR/U8pVqlXztmwNBlA9a4qd
        oV6Lws74qHnpGk9vgM2YlAeYG3m/tL4Wwe7BS5KmQ/3Alqsh0za8g3ePawmh/xHTrR3dZ0p3nbP
        2c8dnDtpTErD+urnahRIo9RUOtLq8jIgvtYoPk9Y4mhdd2KYEaKZI5NnAyrKshW6RWORPtiz8
X-Google-Smtp-Source: ABdhPJxp/LuMeuiKxR5HxdBrN9uDMj+wwFPRaHYDOEyL+aRqs7ah2kIjiukl7fnv05x8XZ9fknjvXwplSime
Sender: "maskray via sendgmr" <maskray@maskray1.svl.corp.google.com>
X-Received: from maskray1.svl.corp.google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
 (user=maskray job=sendgmr) by 2002:ad4:54a3:: with SMTP id
 r3mr13796004qvy.26.1610740345862; Fri, 15 Jan 2021 11:52:25 -0800 (PST)
Date:   Fri, 15 Jan 2021 11:52:22 -0800
In-Reply-To: <20210114211840.GA5617@linux-8ccs>
Message-Id: <20210115195222.3453262-1-maskray@google.com>
Mime-Version: 1.0
References: <20210114211840.GA5617@linux-8ccs>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH v3] module: Ignore _GLOBAL_OFFSET_TABLE_ when warning for
 undefined symbols
From:   Fangrui Song <maskray@google.com>
To:     linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>
Cc:     clang-built-linux@googlegroups.com,
        Sam Ravnborg <sam@ravnborg.org>,
        Fangrui Song <maskray@google.com>,
        Marco Elver <elver@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang-12 -fno-pic (since
https://github.com/llvm/llvm-project/commit/a084c0388e2a59b9556f2de0083333232da3f1d6)
can emit `call __stack_chk_fail@PLT` instead of `call __stack_chk_fail`
on x86.  The two forms should have identical behaviors on x86-64 but the
former causes GNU as<2.37 to produce an unreferenced undefined symbol
_GLOBAL_OFFSET_TABLE_.

(On x86-32, there is an R_386_PC32 vs R_386_PLT32 difference but the
linker behavior is identical as far as Linux kernel is concerned.)

Simply ignore _GLOBAL_OFFSET_TABLE_ for now, like what
scripts/mod/modpost.c:ignore_undef_symbol does. This also fixes the
problem for gcc/clang -fpie and -fpic, which may emit `call foo@PLT` for
external function calls on x86.

Note: ld -z defs and dynamic loaders do not error for unreferenced
undefined symbols so the module loader is reading too much.  If we ever
need to ignore more symbols, the code should be refactored to ignore
unreferenced symbols.

Reported-by: Marco Elver <elver@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1250
Signed-off-by: Fangrui Song <maskray@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Marco Elver <elver@google.com>
Cc: <stable@vger.kernel.org>

---
Changes in v2:
* Fix Marco's email address
* Add a function ignore_undef_symbol similar to scripts/mod/modpost.c:ignore_undef_symbol
---
Changes in v3:
* Fix the style of a multi-line comment.
* Use static bool ignore_undef_symbol.
---
 kernel/module.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 4bf30e4b3eaa..805c49d1b86d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2348,6 +2348,21 @@ static int verify_exported_symbols(struct module *mod)
 	return 0;
 }
 
+static bool ignore_undef_symbol(Elf_Half emachine, const char *name)
+{
+	/*
+	 * On x86, PIC code and Clang non-PIC code may have call foo@PLT. GNU as
+	 * before 2.37 produces an unreferenced _GLOBAL_OFFSET_TABLE_ on x86-64.
+	 * i386 has a similar problem but may not deserve a fix.
+	 *
+	 * If we ever have to ignore many symbols, consider refactoring the code to
+	 * only warn if referenced by a relocation.
+	 */
+	if (emachine == EM_386 || emachine == EM_X86_64)
+		return !strcmp(name, "_GLOBAL_OFFSET_TABLE_");
+	return false;
+}
+
 /* Change all symbols so that st_value encodes the pointer directly. */
 static int simplify_symbols(struct module *mod, const struct load_info *info)
 {
@@ -2395,8 +2410,10 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
 				break;
 			}
 
-			/* Ok if weak.  */
-			if (!ksym && ELF_ST_BIND(sym[i].st_info) == STB_WEAK)
+			/* Ok if weak or ignored.  */
+			if (!ksym &&
+			    (ELF_ST_BIND(sym[i].st_info) == STB_WEAK ||
+			     ignore_undef_symbol(info->hdr->e_machine, name)))
 				break;
 
 			ret = PTR_ERR(ksym) ?: -ENOENT;
-- 
2.30.0.296.g2bfb1c46d8-goog


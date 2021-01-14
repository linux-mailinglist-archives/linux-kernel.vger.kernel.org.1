Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EA42F6D90
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 22:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbhANVzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 16:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbhANVzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 16:55:01 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B85C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:54:20 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e74so3212348ybh.19
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tgOM7SvsAS/8SvjP8wI77AkB8qnFEk/NyLJDnsaz2Ek=;
        b=Nw9ejyj/jm8iXEDGJc7y1QJW0WDCrpoip0qLvOo5Z0mWJnQ8Zd7DabKvObaBaf0zHl
         iwzri++M0/R6H9af7MLTrA7MO2XfhrRpwo8fQhK1Wor2JZZuPHO4z8Ij7iq3rwghTiOa
         TSk4mAJWS9NBCckF3ceaEI2wUOuzQlNdUwHGB8nSx6AjRNePeTNIcjUlrMkizRlc5JRq
         Ik62om6Asn5t2lj4zHr492s4VzvmjR+LFRqcUoCsxQCDzBq5InMZxNm7S0ANeSvhnZyG
         hiiahpPTk27cSe6j6yjsxylzJXdwVPpJyNVnzhjNTGreWSla7sbSp6zPNTan7vx25Rcz
         3X9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tgOM7SvsAS/8SvjP8wI77AkB8qnFEk/NyLJDnsaz2Ek=;
        b=A1xC+HNdPFhjYSDIAJqiVownX0zpCpwCIdITIVRVky9nnFrxf47h4/+K6kFdtwYlwG
         Y/IaVLWd5rPSE3G0r4A1Ey7UT/iW6NbyX2TtRNjuU06crUH1QOoGBYdTwLCU4CksMGnz
         eQ/51I9bAOMuzQhQBRoV9IiZ1OLwEhVSrLtIZFrbmzRNUgdK2Yt97Rn4pl+v3DP8281h
         hlx4U9WFXKtq7FWCDssDjkKKSFKlaySqlukWS8POLo0cIfMBl3yIEQ3PUJyxg/7mvM9R
         SLZPtkVRSTAZHikqksNjgR8rXlTlKmGWd3M1KdRWbC8PtEOz0WkOZ0LziSc5jI1TF9MZ
         cpUQ==
X-Gm-Message-State: AOAM533YZfSZS5ovEm8KKUMepbL1ZTiXwIO7FTNwOXu+W/45ZpbT6OqR
        tP/wLrPJhWDWXOfkPUKn8d/xLSSbF08/NovHe7uSQEr3q5KuxMDiB1HiAMIfcQVh/jHGYBPysGb
        DXcsEBO8yYDwh6AoN3O64b1GvH2qW2MlBAsICtiwjJYRdrOVJCLIcodxyLVCWC78JN9Lr52EH
X-Google-Smtp-Source: ABdhPJw6n2rkQxdu0Ke0FvMxL6+8gxdyLR7DcLUFyfZ/GrHVaRnoHvROkF6v04Oj9JIr4kTe0L4II0A/AZqu
Sender: "maskray via sendgmr" <maskray@maskray1.svl.corp.google.com>
X-Received: from maskray1.svl.corp.google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
 (user=maskray job=sendgmr) by 2002:a25:500b:: with SMTP id
 e11mr13498852ybb.138.1610661259864; Thu, 14 Jan 2021 13:54:19 -0800 (PST)
Date:   Thu, 14 Jan 2021 13:54:16 -0800
In-Reply-To: <20210114211840.GA5617@linux-8ccs>
Message-Id: <20210114215416.993167-1-maskray@google.com>
Mime-Version: 1.0
References: <20210114211840.GA5617@linux-8ccs>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH v2] module: Ignore _GLOBAL_OFFSET_TABLE_ when warning for
 undefined symbols
From:   Fangrui Song <maskray@google.com>
To:     linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>
Cc:     clang-built-linux@googlegroups.com,
        Sam Ravnborg <sam@ravnborg.org>,
        Fangrui Song <maskray@google.com>,
        Marco Elver <elver@google.com>
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
---
 kernel/module.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)
---
Changes in v2:
* Fix Marco's email address
* Add a function ignore_undef_symbol similar to scripts/mod/modpost.c:ignore_undef_symbol

diff --git a/kernel/module.c b/kernel/module.c
index 4bf30e4b3eaa..278f5129bde2 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2348,6 +2348,20 @@ static int verify_exported_symbols(struct module *mod)
 	return 0;
 }
 
+static int ignore_undef_symbol(Elf_Half emachine, const char *name)
+{
+	/* On x86, PIC code and Clang non-PIC code may have call foo@PLT. GNU as
+	 * before 2.37 produces an unreferenced _GLOBAL_OFFSET_TABLE_ on x86-64.
+	 * i386 has a similar problem but may not deserve a fix.
+	 *
+	 * If we ever have to ignore many symbols, consider refactoring the code to
+	 * only warn if referenced by a relocation.
+	 */
+	if (emachine == EM_386 || emachine == EM_X86_64)
+		return !strcmp(name, "_GLOBAL_OFFSET_TABLE_");
+	return 0;
+}
+
 /* Change all symbols so that st_value encodes the pointer directly. */
 static int simplify_symbols(struct module *mod, const struct load_info *info)
 {
@@ -2395,8 +2409,10 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
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


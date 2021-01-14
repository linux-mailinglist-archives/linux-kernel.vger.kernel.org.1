Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD772F5A82
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 06:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbhANFtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 00:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbhANFtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 00:49:20 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBFEC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 21:48:35 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id t16so3508444qvk.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 21:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=JRd7aPz2CbrXde//z5IQRqxIL9i0XgMm4kLv7NJprCw=;
        b=dPgo+lVH4YNAqoaizhDgMnuIeSBqS+X4fe75Dk79/Kt+vDa8gKHoRT7nc9TOIYWqXC
         OCq+Tz7DXh9r5k9e1b/ojDyAmqg4JTvyl8+MXsC96biSIyHss/gpwUXyCK27kjUApD0H
         oGeE/5c/iMmQwC+emfcZRZNzgRamJEktkbjm8SCOTTrLZMYiVfSEyhONpf/Zfo15Ib4V
         oLjtl983j8aYYncde5dsuY3Q88i1en14RJx8hNAWbExUgfQCaC0oWOK4xNogHmiAhcHm
         eGIk0hep2Gx2KWeVGh6/SoqlgmGmTWS/FW5zfdPpaRYzuDvnQO6DeE4dySP/DcGL5FaC
         oxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=JRd7aPz2CbrXde//z5IQRqxIL9i0XgMm4kLv7NJprCw=;
        b=N27sEe96TLomBoTdIsfDulrUo0f9nEFzKpNL5axSb9zHTSU1T9pWzLVQaORYGWjOMf
         3zW8NMFXMAKveQ+wf8dPnY8xgSX6jZ5ITHxpPw4MXWYodsbX2KlVHMZVetG2YKTNinkO
         QTD7NfVs3TYa+UOYXxt4klzJ691BrK+i/TD20h2Fhb5eZ4RqZvGtMNQjwK6hp4jC2jv0
         x/z3mHHy6YabDCFtmZMd9iR91ZdELoFis5i5ycGqk0DMOzeW1/kuFbzbtCwzHYiTNrlV
         npILsT11TVSzvF0txuEJzjGjlJVBa+PTFVVK6svPiuKNddD+Q5t9rojJtn+G5OWKXhZi
         WH0A==
X-Gm-Message-State: AOAM531OBsbem4umShq09E1EA1Kf59j1BBZqupNzNgwz2518AdFyyImL
        yj53zGQMcjxat7ArucE+BW0g0McVRCx37PG54xuIQres7zpEJF8fgSixuAhS3JSo9ajb+HkRX4p
        xa908CflHRdsDMoS2kIkM6Ca7hlnPWsJ449UeVNYfv2EGw5RbJ94hyZxC1uGH+exZ1Vym/D+K
X-Google-Smtp-Source: ABdhPJyL1N6YssZiDMwOxAsoEXmczTBOkCSKEUBDJb8dBcHUq6MtenBUdcc2VtnJW+FYmOMi6KlgQoKS8+xW
Sender: "maskray via sendgmr" <maskray@maskray1.svl.corp.google.com>
X-Received: from maskray1.svl.corp.google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
 (user=maskray job=sendgmr) by 2002:a0c:f812:: with SMTP id
 r18mr5647264qvn.39.1610603314178; Wed, 13 Jan 2021 21:48:34 -0800 (PST)
Date:   Wed, 13 Jan 2021 21:48:31 -0800
Message-Id: <20210114054831.343327-1-maskray@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH] module: Ignore _GLOBAL_OFFSET_TABLE_ when warning for
 undefined symbols
From:   Fangrui Song <maskray@google.com>
To:     linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>
Cc:     clang-built-linux@googlegroups.com,
        Fangrui Song <maskray@google.com>,
        Marco Elver <melver@google.com>
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

Reported-by: Marco Elver <melver@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1250
Signed-off-by: Fangrui Song <maskray@google.com>
---
 kernel/module.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 4bf30e4b3eaa..2e2deea99289 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2395,8 +2395,14 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
 				break;
 			}
 
-			/* Ok if weak.  */
-			if (!ksym && ELF_ST_BIND(sym[i].st_info) == STB_WEAK)
+			/* Ok if weak. Also allow _GLOBAL_OFFSET_TABLE_:
+			 * GNU as before 2.37 produces an unreferenced _GLOBAL_OFFSET_TABLE_
+			 * for call foo@PLT on x86-64.  If the code ever needs to ignore
+			 * more symbols, refactor the code to only warn if referenced by
+			 * a relocation.
+			 */
+			if (!ksym && (ELF_ST_BIND(sym[i].st_info) == STB_WEAK ||
+				      !strcmp(name, "_GLOBAL_OFFSET_TABLE_")))
 				break;
 
 			ret = PTR_ERR(ksym) ?: -ENOENT;
-- 
2.30.0.284.gd98b1dd5eaa7-goog


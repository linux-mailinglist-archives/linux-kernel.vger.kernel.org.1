Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F6926D71B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgIQItU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgIQItN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:49:13 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218B7C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 01:49:12 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a17so1135992wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 01:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oRBptC4sIuVYjiXcshYa7R4ABF1BI07mPrwI7LaWCH4=;
        b=GfuKs9CupTvPHUeC0pLyByeMS9VlPteXtpVvw3eVnMktD3hVWlOva70eptZTmo2p4F
         syBEHJPfteXVSsVWEqvacoBo9SExvMS+GMyjhDJ4wmfFvZ8pXzclt43WjULaVPUC0QgI
         1wLw5SvIvDg+o5mTxDuNVaWtM8eqdxF9XJ8jCGrX7O9VFmVoi3WOOdbagw+2mfNnF4kp
         L+X2xOwfiIFPtAjKtau93s5E2/PGD+cn5geBJ0bF1rq1m7yM461/PAXteqxV/5Cdo1UE
         +cfkyhTugAKAKgqlbiNbz03TyPVT/B7OZjclKKoSf9tlUJYAn4rGdc5IWKri9P0rYKcY
         4KhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oRBptC4sIuVYjiXcshYa7R4ABF1BI07mPrwI7LaWCH4=;
        b=Ojny8L0MKoBafsGik4zj7xnG+5EJEGkDbLlYieqJ+iw0L+ThR/iqTQ8vsWG9H9RuzE
         F5KQ47RddZ5IgWpvOUZA3ajnz9dspX3jPjs1N+pt6LKI89scPXnOmEBviEdKobOpVUXf
         S2ecbh9WrK4BxfEKaVqRpDEC8q+8YZJ/WL7uXlLVh66goKh/VYvQ2QxJ3vDRCxA8ePD0
         35S8EhfjsCefMEZxsYn/zlYM3XYi3Q/2PQGU+Cy3mhjATnXeXD9nD/ZR5wI+GRJEm5JK
         +3zAKXcVVnYACJduR0p8UhhxwqTutm/m45RD3BNHOx6g1uwDs+z2gn5AulD4WAORDz+w
         A7Jg==
X-Gm-Message-State: AOAM5303gngtAF/UEn/rCvMsY8IzRWUV2wb4C7zghQMo1HmbVYy00I+e
        /ZdSAkme3HICkMjM79kVETa87E4nCKb2iM6NZ5M=
X-Google-Smtp-Source: ABdhPJzg2r5tnYvMLW39bXH+VQ0vH58jS1+UjEWLooKh9uZ6VEe1jWbZDjE6mHZeFCA7kZndX9qnBg==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr32318001wrp.187.1600332550694;
        Thu, 17 Sep 2020 01:49:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a58:8532:8700:329c:23ff:fea8:6c81])
        by smtp.gmail.com with ESMTPSA id t22sm11973299wmt.1.2020.09.17.01.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 01:49:10 -0700 (PDT)
From:   Ilie Halip <ilie.halip@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ilie Halip <ilie.halip@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Marco Elver <elver@google.com>,
        Philip Li <philip.li@intel.com>,
        Borislav Petkov <bp@alien8.de>, kasan-dev@googlegroups.com,
        x86@kernel.org, clang-built-linux@googlegroups.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] objtool: ignore unreachable trap after call to noreturn functions
Date:   Thu, 17 Sep 2020 11:49:04 +0300
Message-Id: <20200917084905.1647262-1-ilie.halip@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_UBSAN_TRAP enabled, the compiler may insert a trap instruction
after a call to a noreturn function. In this case, objtool warns that the
ud2 instruction is unreachable.

objtool silences similar warnings (trap after dead end instructions), so
expand that check to include dead end functions.

Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Rong Chen <rong.a.chen@intel.com>
Cc: Marco Elver <elver@google.com>
Cc: Philip Li <philip.li@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: kasan-dev@googlegroups.com
Cc: x86@kernel.org
Cc: clang-built-linux@googlegroups.com
BugLink: https://github.com/ClangBuiltLinux/linux/issues/1148
Link: https://lore.kernel.org/lkml/CAKwvOdmptEpi8fiOyWUo=AiZJiX+Z+VHJOM2buLPrWsMTwLnyw@mail.gmail.com
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
---
 tools/objtool/check.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e034a8f24f46..eddf8bf16b05 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2612,9 +2612,10 @@ static bool is_ubsan_insn(struct instruction *insn)
 			"__ubsan_handle_builtin_unreachable"));
 }
 
-static bool ignore_unreachable_insn(struct instruction *insn)
+static bool ignore_unreachable_insn(struct objtool_file *file, struct instruction *insn)
 {
 	int i;
+	struct instruction *prev_insn;
 
 	if (insn->ignore || insn->type == INSN_NOP)
 		return true;
@@ -2639,8 +2640,11 @@ static bool ignore_unreachable_insn(struct instruction *insn)
 	 * __builtin_unreachable().  The BUG() macro has an unreachable() after
 	 * the UD2, which causes GCC's undefined trap logic to emit another UD2
 	 * (or occasionally a JMP to UD2).
+	 * CONFIG_UBSAN_TRAP may also insert a UD2 after calling a __noreturn
+	 * function.
 	 */
-	if (list_prev_entry(insn, list)->dead_end &&
+	prev_insn = list_prev_entry(insn, list);
+	if ((prev_insn->dead_end || dead_end_function(file, prev_insn->call_dest)) &&
 	    (insn->type == INSN_BUG ||
 	     (insn->type == INSN_JUMP_UNCONDITIONAL &&
 	      insn->jump_dest && insn->jump_dest->type == INSN_BUG)))
@@ -2767,7 +2771,7 @@ static int validate_reachable_instructions(struct objtool_file *file)
 		return 0;
 
 	for_each_insn(file, insn) {
-		if (insn->visited || ignore_unreachable_insn(insn))
+		if (insn->visited || ignore_unreachable_insn(file, insn))
 			continue;
 
 		WARN_FUNC("unreachable instruction", insn->sec, insn->offset);
-- 
2.25.1


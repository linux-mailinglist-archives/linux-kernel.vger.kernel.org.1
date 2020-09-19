Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2E9270B2F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 08:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgISGlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 02:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgISGls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 02:41:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32429C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 23:41:48 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e11so8047200wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 23:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g5DNwEJpdlREbpxxNUWXwnzTcfAjTXzmIWah8QsBFAI=;
        b=gcOYcGHH4MsI7f7Eh8FIRg1V4TNDV8TEC7JFMjCSiWUdFN3wLnF1BoqaW8824MYEpI
         AqGfGUtCN1Bw6s2WafciAgwz5NDFoMDPFWKkbJZNGIdPnUg26ZR9K/Chn9qyyonTOMF3
         yTjwu+dP+oMlZLj+/t6ySUyjCSrzrvaaioNDjF1bivITW33PT84XyHQfXvXeC8xV3nKN
         D9/X6Pt0AVfKkYJqymQezH6gsI/d8p1i0lHCxAntMA68YQRxp/PuPkcv9wPlPMawuWgB
         lrTRl/7JrMywy071UWR5XihWXng2n8d/gp0znS/tJ7VTaXr+Hj3NgUzG8l2IbZcEICE6
         5tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g5DNwEJpdlREbpxxNUWXwnzTcfAjTXzmIWah8QsBFAI=;
        b=QYLrx3w7Jn1rP2afpju5griFWyy59SOR/+K1jKCObmL+ut6o3lf8O+q5c/SAd9c8qj
         SP1nyNkin4Em/xqKdd7HTbMTtb24OSmHBJLhO+79hXyYi5XV72frTx1CpDJmXlvni7OG
         r1zI8Hk5gSsmqVNXU/heqxWP9ZZaUCQ9OjVqV8VAcdpSZnXUe6tfVtt6xAb733HV6U/4
         pL7D1ahBOOExZxP/n8rtOznJU3CMzfSoABrsj6GlL+42by8AqeyVzRY4Cupu5qa93J2h
         9ZJMbafZ9ZqtF+y7osUIFMP1hwxUkLnyMJ6FX6dnWtHITe5BCXS0B3Dyal3TbNsv+lgI
         NugQ==
X-Gm-Message-State: AOAM531pIQl4rmTJIKQ52LcWqFQBpBM3xL5c+bb5bRN+mbUg3cqidk6n
        JULk+pVUjTCCPbfyJBKnwoie9K8FT4/Qol3E
X-Google-Smtp-Source: ABdhPJyyQmRm/XhxusECAnYWa01C3m+PuTeu+pUQuns55to7HoSDQa+DfuYquy7naRRS8WyE5FMazw==
X-Received: by 2002:a1c:9e0e:: with SMTP id h14mr18723255wme.18.1600497706567;
        Fri, 18 Sep 2020 23:41:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a58:8532:8700:329c:23ff:fea8:6c81])
        by smtp.gmail.com with ESMTPSA id l5sm9218927wmf.10.2020.09.18.23.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 23:41:45 -0700 (PDT)
From:   Ilie Halip <ilie.halip@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ilie Halip <ilie.halip@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Marco Elver <elver@google.com>,
        Philip Li <philip.li@intel.com>,
        Borislav Petkov <bp@alien8.de>, kasan-dev@googlegroups.com,
        x86@kernel.org, clang-built-linux@googlegroups.com,
        kbuild test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] objtool: ignore unreachable trap after call to noreturn functions
Date:   Sat, 19 Sep 2020 09:41:18 +0300
Message-Id: <20200919064118.1899325-1-ilie.halip@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918154840.h3xbspb5jq7zw755@treble>
References: <20200918154840.h3xbspb5jq7zw755@treble>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_UBSAN_TRAP enabled, the compiler may insert a trap instruction
after a call to a noreturn function. In this case, objtool warns that the
ud2 instruction is unreachable.

This is a behavior seen with clang, from the oldest version capable of
building the mainline x64_64 kernel (9.0), to the latest experimental
version (12.0).

objtool silences similar warnings (trap after dead end instructions), so
so expand that check to include dead end functions.

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
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
---

Changed in v2:
 - added a mention that this is a clang issue across all versions
 - added Nick's Reviewed-by, Tested-by
 - added Reported-by

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


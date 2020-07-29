Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FD223272A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 23:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgG2Vv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 17:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Vv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 17:51:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D8AC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 14:51:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o8so8108819ybg.16
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 14:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XqcTC2vuCfQSKcre8J8WDJG0kMjtcm07zH5Lw6F6DXE=;
        b=ciUZh/tyeIpxCmoN49V9pS1Pb3wFhICO4qpRrMW4s7CpOO2y4afzwi7mI7svGpNzL7
         TIPXQXit4KOcXK/NFMZknWpABt8PAtcxRHiL93WeER/9d9MWAdYXkZKKHrRJtigDilrQ
         CBL3Vyp4C6ssPu8jj+8QfGdw89fxA5PR1SHMxkeBnfVC8qjsZtwyL+3FLo6utNvFjt48
         7mD5qP2SRDSnmFNVeyLizSsKqxQm9sTn6HWB8f/Hf5W2/pTLZm8pVTPDzYqhM9vu/ee1
         pbHyM622DIC2ZrAc/Y0AgYfFTlZtQJrM0crebAe+ESjSMcrZiVnEEpjnQrN6FEIHDAj5
         Q3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XqcTC2vuCfQSKcre8J8WDJG0kMjtcm07zH5Lw6F6DXE=;
        b=dsiu7w/RYv2ItKlfFzAJ5tgqe8qkCoVX0SiEP9wQ8VK5gtBTM//8FeHtsiFGwAFV5B
         2Y6ZKjOJ9AbMuLgl+4LujObk0e7zbx6Hj6Ed5fWBRlXwHrToqJga3HwMhXfWvCDdETME
         rvlYGM/v8/r0zyE9mOOPJhjH0l4tWFrdMdptsS4quSwh7dAsBvRjLMlGAiASEGJ1SrQ+
         TlHFa0p1FkoYBhz0CpHCLsviFGBouTMQsOiaR5BxueD5wypEpw9vsa6+bjnApGqWcxcs
         Hx1As3LjnD5oRicDr8LV+i8n2KcLulBX4sU3rhKjIDAP0Fg6/DmWosUFK86eajrdfIlf
         iSQQ==
X-Gm-Message-State: AOAM5313BoZ4sy8/2Ex/XIXj/FKaD3AoBZozoyTfxAQOk0yZsu94kGdB
        uFQigkFFlQYvU5mpuiYFM5hxkhz34HmyiSNdb28=
X-Google-Smtp-Source: ABdhPJyMfJOTToVvOJpGfO0ho8OnKO0EPuPzbcMB2MHnlEC4slmPojpIMwvkFTM/tGsMoMggcjg7ygEppHiQECY2j5Y=
X-Received: by 2002:a25:a107:: with SMTP id z7mr719351ybh.310.1596059517661;
 Wed, 29 Jul 2020 14:51:57 -0700 (PDT)
Date:   Wed, 29 Jul 2020 14:51:52 -0700
Message-Id: <20200729215152.662225-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH] arm64/alternatives: move length validation inside the subsection
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f7b93d42945c ("arm64/alternatives: use subsections for replacement
sequences") breaks LLVM's integrated assembler, because due to its
one-pass design, it cannot compute instruction sequence lengths before the
layout for the subsection has been finalized. This change fixes the build
by moving the .org directives inside the subsection, so they are processed
after the subsection layout is known.

Link: https://github.com/ClangBuiltLinux/linux/issues/1078
Cc: <stable@vger.kernel.org> # 4.14+
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/include/asm/alternative.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 12f0eb56a1cc..619db9b4c9d5 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -77,9 +77,9 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
 	"663:\n\t"							\
 	newinstr "\n"							\
 	"664:\n\t"							\
-	".previous\n\t"							\
 	".org	. - (664b-663b) + (662b-661b)\n\t"			\
-	".org	. - (662b-661b) + (664b-663b)\n"			\
+	".org	. - (662b-661b) + (664b-663b)\n\t"			\
+	".previous\n"							\
 	".endif\n"
 
 #define __ALTERNATIVE_CFG_CB(oldinstr, feature, cfg_enabled, cb)	\

base-commit: 6ba1b005ffc388c2aeaddae20da29e4810dea298
-- 
2.28.0.163.g6104cc2f0b6-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D35270672
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 22:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgIRUPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 16:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgIRUPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 16:15:40 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFC3C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:15:39 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id z27so6131238qtu.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TqIl0XsuMws2W7SAyTGgPlMUxJpmV31lTKH8j5/4FZ8=;
        b=lu5o9R8gm3jqcUgmwu4AY/DoLfD5wt5MOlJd0k40tfngeaf8Nt07Vk6ePP9t8NlEZN
         IVqlDHPcBWhQmmotn4u+3EefhUJi4+cheG5oC6RvYmB7RkBMe7EstPG5yMRAIDKgu2g4
         axLl7OmVkBvP92Q0Qbvl1A+S7pF0924SmotebecxUz5whagk2WPh1iNdxekOtLgSwwwo
         0Ns1oRsUkHTg+U1kphL0FSFJspdH6IcYbg1jpew7/hIrVEFAzVHH8yr+R74J5oNr2P3K
         IdJppxeqyy0BnWW1z/jWEr6bH3y/3VeXHdJFclXUQXKes6i8fQsPsWgt1B/kImbNCuTX
         cjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TqIl0XsuMws2W7SAyTGgPlMUxJpmV31lTKH8j5/4FZ8=;
        b=fcTppUZ7gNenIVn5kYBBhM4YEtP1YpK6X+SsjOeYvrXXW5tn9Co9Gf6yVuHxjL4nZR
         nkhE6na3SMbd15bAiOuuw/1LbJkitit9c8rdxoJbcw91I4xYeK4eZMP8DuHK39+nAXYE
         IAo1re+lWZ6auRHp3XYLiWbkU/KgjG4XwG0icIJxrysY/zaX2uKHhxMAABEkG0NrQ7m2
         itTIHA1uLEfNBEFWi3u8/QIJi6+rH6d4brgxCDyV70gNnu/9w3wIL1dX1QU8lg3xZIUz
         EJqYwes0BwoCvDUwSTdmmg30ljXyGYMyStwScQfpIGbB/PpqMLFRLhUP+zMRL3hdrrSS
         qFvQ==
X-Gm-Message-State: AOAM531cxSzErq3DUdbhOs1iOjRUfP52TdqtmlqsW2LAljtnadfCaogf
        aJbCtZ6OLnva8ItQrSAQajM9hwEZmdVOPko/HLE=
X-Google-Smtp-Source: ABdhPJzM+bDDdhQ1yuvEohGu3NxsCeWWPsxJypy/LfG2x1PLzd9dzX2AyM5yRCrQ0RzzRR4VA988AWIJ4v9Gjkgti5E=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:58e7:: with SMTP id
 di7mr18639207qvb.36.1600460139023; Fri, 18 Sep 2020 13:15:39 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:14:31 -0700
In-Reply-To: <20200918201436.2932360-1-samitolvanen@google.com>
Message-Id: <20200918201436.2932360-26-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200918201436.2932360-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 25/30] arm64: vdso: disable LTO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable LTO for the vDSO by filtering out CC_FLAGS_LTO, as there's no
point in using link-time optimization for the small about of C code.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index e836e300440f..aa47070a3ccf 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -30,7 +30,8 @@ ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv	\
 ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 
-CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS)
+CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS) \
+				$(CC_FLAGS_LTO)
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
-- 
2.28.0.681.g6f77f65b4e-goog


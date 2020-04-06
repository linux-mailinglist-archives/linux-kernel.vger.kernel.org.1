Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04F7D19FA89
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 18:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgDFQmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 12:42:00 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:45223 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbgDFQl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:41:59 -0400
Received: by mail-pf1-f202.google.com with SMTP id d8so44645pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4apKHH+0KXGOaGE6jTeN52LWOcENawq8hrV28HQBrcA=;
        b=H7r9/K1Pb2jZ/QTf4eps8FXgNOwBjIplJ83GvJcB7p53k1kwhM1xPQxZLkgvAaK02n
         beraESPrDeb3MtB6jvklmi+/vUcZS4mHBB1OCRD//Yx8vijzVcAIERr2dp1g0QDMqGEH
         /HT1yD1mZDPSkJulcCDMMrG5W512OIw+DI+B5TIlQrfESZv1YUtu4bFOI7koPSLqre4V
         1GvXHs5lxJf7sNgG/FH6hL3WB2A8MbOLzhIcXcIuTXJy/+sRweQg+5SqJEi4k7ntmLnb
         VpUd6/DJobY+aRGS+iUjHZ3if6GvDWbplbrX5is0cinNOSMDE2y/gYC1eTqNbsHLdzRj
         P8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4apKHH+0KXGOaGE6jTeN52LWOcENawq8hrV28HQBrcA=;
        b=oEHtoO0MNe9Q9T5b6PDh0Ag4TKH9Fu3cA1NO/MqOpkxDayMVAdkssXw+kFv4ctYjZt
         Vi3ifZpvMFuWqN6OUe3OOKF8M2nZqTwkTxakZ8K7/mWGxmoVCCdJL9qxhsv9EmhVJzfw
         g29TXVPWHZiXW8aw81C3TdeoX+ITxOS/bR61+rHIKdT11BCdrEUWEk1iu5UtqLHiDnpo
         MPCjR+kqnDC/RjsAkaKsSLqsXqlgxUjWYgXv0k0yWdZjjeRtFyGpTlBvfHHorQbZY9Ka
         pLEMjyWJNKpWAKWAQyx7//41JBhDBKWyCF2mfbD+ox9DLmM7r3VRHrdjFB2oNpdOuxXc
         3Skw==
X-Gm-Message-State: AGi0Pub4XZ4NbiNPlKt1o/pTW2GKfrMlq9oLDdbzdegZPUjCMTCyQxBn
        e5K0lUQEEuEOplqvD7hLDjl7DkLtoti988L5e18=
X-Google-Smtp-Source: APiQypK5eLQJG4otrid1fZuEbwfLIfGLtaeCQl5ykKUwyTbJ+T2+3uqzOPYi+Sh8FFR75wCHX7LWfP4FZsjp9J54Zb4=
X-Received: by 2002:a63:9043:: with SMTP id a64mr22525247pge.308.1586191316557;
 Mon, 06 Apr 2020 09:41:56 -0700 (PDT)
Date:   Mon,  6 Apr 2020 09:41:17 -0700
In-Reply-To: <20200406164121.154322-1-samitolvanen@google.com>
Message-Id: <20200406164121.154322-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200406164121.154322-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v10 08/12] arm64: vdso: disable Shadow Call Stack
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shadow stacks are only available in the kernel, so disable SCS
instrumentation for the vDSO.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index dd2514bb1511..a87a4f11724e 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -25,7 +25,7 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING
 
 VDSO_LDFLAGS := -Bsymbolic
 
-CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
+CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS)
 KBUILD_CFLAGS			+= $(DISABLE_LTO)
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
-- 
2.26.0.292.g33ef6b2f38-goog


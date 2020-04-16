Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1CA1ACD2E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 18:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506907AbgDPQNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 12:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2506871AbgDPQNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:13:09 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F228C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:13:09 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id w14so3469643pfq.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MhRn5bu5/kvUh5QzOzRXssMosuq4vthGJuay/ttgTR4=;
        b=CpB297mheaErr6yv8xzZk9C8e3OlyZuurSZ4iPlqnxBL1rdN7DVreXtQ6hHd7Wghk3
         A5W9OQc4/k6ybv0BMxLVLn8OvbS40EACfZw8xiC3B9iqMWTZ/G+4Y/YX3/JNpQMeDGS3
         ay0rPEcWXkE7+/beHpj+T7HGAeju4SLB85FtaqnWCnPyeZYfmL7ROzgbfHdDeuyse6Mw
         X10A0ECz0Imqt1Wo4UmMjqK65aL12fZ5Eglv5O0xEJh6LVssqIx/QWQa3QbH0ppYnbu+
         0maH/v5qWpKrIiGAPfF4cw/U7QIU4ulRW3FrsdGzWeLWUmoK0Amlfi7T20CvdzF4vk8N
         JCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MhRn5bu5/kvUh5QzOzRXssMosuq4vthGJuay/ttgTR4=;
        b=FtTPu69m8SnrDiLBJPd0GrqJkzEqIlYBTPx7ZPUM4Xnm6k0ZcY8v7ZdiWgm6Q1edxl
         K5eb74chDK1vzD0YF0Rp5enmrn1SSRL2QZ/jEtUftfHyJM/Ydr9gN9ezVljiD2nv/Axy
         kuvzPyUpBZ+3TNXCkypzt+wDCRqHz/jRNNV20oaWImN3H7sQZOh5uP2HNhgTVaNj/cpw
         eQBNh5gO9reQVtp2zmXy6a0ASr3tewvReOrHE8dxBnbysElUh7ZtDs7nF2ZD11Eqitxr
         8AjZiyDnMtI7gQsNtMP88z6pPGU94b+pyBT6wIbJUR2I2j/ycLoWdBecIy32MIZM5ViU
         mjjQ==
X-Gm-Message-State: AGi0PuaT5dMq5ljpMo2Bm7qhuPzGzcripjuXhJKZUjlq1nRijD88ue2s
        /JCbAgMWrJ8L9HkyNaiO3yqMN/xoXMLELRSTiBw=
X-Google-Smtp-Source: APiQypL0T1GFOmyxncLIjxwWs5XI51QswoFv2KQDHvzuxs+kU6I+8aUYgz8VLRqT+kH3Do9DXOfw/WbQdUM/RpiZ80k=
X-Received: by 2002:a17:90a:f407:: with SMTP id ch7mr6146496pjb.72.1587053588956;
 Thu, 16 Apr 2020 09:13:08 -0700 (PDT)
Date:   Thu, 16 Apr 2020 09:12:41 -0700
In-Reply-To: <20200416161245.148813-1-samitolvanen@google.com>
Message-Id: <20200416161245.148813-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200416161245.148813-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v11 08/12] arm64: vdso: disable Shadow Call Stack
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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
2.26.1.301.g55bc3eb7cb9-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A212D7EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 19:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390252AbgLKSt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 13:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389642AbgLKSsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 13:48:54 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4612AC0610F9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 10:47:04 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z62so11728766yba.23
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 10:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=D9wH7plBpsyKB7z0MJo6lESfcO9at50jK7OVp+0NdAo=;
        b=o9YQ2WaCNG8K0/fs9UJt8tjJkZt2V+zu8nGyyzGv31aRlZwzdERkcEEzcsjJzK7Khh
         Fk/jL/s8l2hJliwPNQGXJKzeEfZAhZNL3N7YQubgkjL3MBt3ZaOHRNJKHKyKgl7rzP3r
         CbLCHOiTVvpx23P8dNWk0S8pTKQys5/iAUXEqkbZkIdXP67EvijrZ7suaxN5SM1AiGUg
         Czctp/iCgtSTfOnV6MNPNWCT9Gw6yx2WXcKk+pz2gFHpPVleQlFs2WHsbthps4QXwlxm
         5FQuFyoHqaAxpIDOc7NISukhUKz44T2F+pYRZntubJg1eb5X5qyK7NUJ7/Bfmj3XKKx9
         8T1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D9wH7plBpsyKB7z0MJo6lESfcO9at50jK7OVp+0NdAo=;
        b=MsXpwVQd6kBuKOHT4c17Lyo5rinbAeymrCi0SMlRfMZZ1ooJr4tOynWLymptkpVgL7
         Jv1T5l8s/2gx4FBIfm+oY4geQ65VMqEeJ9kmOXxrA405BVYCG1oR+h2r7XOGad4xSeWc
         Q371btvlkC1MPouu8muaoOCOljctUC9XdU80UT08CFniGcowASSgJmqPDImg5E1GV920
         07yMmbnr+ma85jzkoCDDlyVSx2pZN7BNj6EZUK59An7b1C0RahVinRBH7REBn3XCzwbO
         OSTX538k10kC3RORiu30v5VOBNI5FaYuik4YicAd9EdcZRBQPkxQlTs9H5q5PXVLc1LO
         nGNA==
X-Gm-Message-State: AOAM530z4BQorwr4D4uH2J/jXQ5n1cZgmIXn6FHuqKB/r3dDavSLtsn0
        yLqpqkBRHefUxXYjSVk6KmGR9dplrtj9aMlaQ5o=
X-Google-Smtp-Source: ABdhPJznzuiVO4idqxJMtdzoCHbXvL/GitFw7UhsVnJ6x3E9oWq6Kdg+IUkD+jO4kIRIFWgi1U7nyXaq6VyburgAblw=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:6405:: with SMTP id
 y5mr12176868ybb.328.1607712423523; Fri, 11 Dec 2020 10:47:03 -0800 (PST)
Date:   Fri, 11 Dec 2020 10:46:31 -0800
In-Reply-To: <20201211184633.3213045-1-samitolvanen@google.com>
Message-Id: <20201211184633.3213045-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201211184633.3213045-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v9 14/16] arm64: vdso: disable LTO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable LTO for the vDSO by filtering out CC_FLAGS_LTO, as there's no
point in using link-time optimization for the small amount of C code.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index d65f52264aba..50fe49fb4d95 100644
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
2.29.2.576.ga3fc446d84-goog


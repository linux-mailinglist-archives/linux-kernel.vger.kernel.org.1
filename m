Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054E52D7EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 19:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436756AbgLKStp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 13:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406346AbgLKSss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 13:48:48 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB6BC061A4A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 10:47:00 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id m91so7021882qva.21
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 10:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2x/zjVn7tqzzMwlgW94lOF/53GHge2qEfxVssZKSVKU=;
        b=sVh7pgdYPbhuziZ7RbVkNdr73qN77YcUUWXTQ1tAb3P7jqHRr2p1f5bPxlsX3TaJ0x
         NLRx4jH9CypSCESRGLRonyZ8+kkS3XNyERw+CW+BqWmKtawr0ILqseYbrw/qx5wrEH2B
         VqZ0x9qFDwfElGwb1vEdm1fnMLextKeSpBRqwLQXUche0e5kuofl1+h4UoBzhPS5Diu4
         EguLuAaf07YUp6KSWi5vK+lTKN+85JJaMCLDLqfd6UvMg+GduXve9RFsPVLp74nssXU5
         7G5z+jbgJYyIgkNTgNx96jpD1psInPt090dZnr/BEIQ4zT7bqAbfJUIq9iNE+/XzJIVu
         6Ing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2x/zjVn7tqzzMwlgW94lOF/53GHge2qEfxVssZKSVKU=;
        b=ohaLL6PdsfKRgo3h+6PjY9M+Y/ind9EjtjkYgHQLiZTPwrMoIhlJdNXNE14RKkaiTE
         /Imjbmh+/560CywT9KFUEzUgPnxmbDgmO7ehTEIhtn2+m/P+7w3eo7yyt4sKp5uC0oVG
         JRIGcfiid4y60TKqnQwPkMXIfubJLoOmW8m5B3xQ5g6FJxWdlndX5aVwTzHxaAAx+2gK
         OdYNYTpFHuErZntmSKFwXA8FNYknGniMh5iOcC51PoQAnTaxAxuh8yUAWIyOjXZs6Mzr
         40ojkaa8CUZb8TyJTf34jOHhQ6+T2ypIgxM/Yc8v0kHvVUZgky/1HglelZgcqIl43Yec
         7TAA==
X-Gm-Message-State: AOAM5303wPBO9PggO5a1HYTXVHqzi+UGcKqpll3xbXtykM0aVan50ewF
        2W7O4hdZDZ9/2e8SxsuQWkIKuRKL1vYQdaKLofQ=
X-Google-Smtp-Source: ABdhPJy6JuT0I8NnXRzTs2o4vn7H7iL4bg1V2c7l8tXurWBfldv/1YSed2IdWjWnqXB3B13fccdvqEaMosao7evXpYA=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:a94:: with SMTP id
 ev20mr17352143qvb.56.1607712419531; Fri, 11 Dec 2020 10:46:59 -0800 (PST)
Date:   Fri, 11 Dec 2020 10:46:29 -0800
In-Reply-To: <20201211184633.3213045-1-samitolvanen@google.com>
Message-Id: <20201211184633.3213045-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201211184633.3213045-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v9 12/16] efi/libstub: disable LTO
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

With CONFIG_LTO_CLANG, we produce LLVM bitcode instead of ELF object
files. Since LTO is not really needed here and the Makefile assumes we
produce an object file, disable LTO for libstub.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 drivers/firmware/efi/libstub/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 8a94388e38b3..c23466e05e60 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -38,6 +38,8 @@ KBUILD_CFLAGS			:= $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
 
 # remove SCS flags from all objects in this directory
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+# disable LTO
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 
 GCOV_PROFILE			:= n
 # Sanitizer runtimes are unavailable and cannot be linked here.
-- 
2.29.2.576.ga3fc446d84-goog


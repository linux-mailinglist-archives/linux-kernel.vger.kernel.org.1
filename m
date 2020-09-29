Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0D727DB06
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 23:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgI2VtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 17:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbgI2Vrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 17:47:45 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAB1C0613A9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 14:47:36 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id m13so4063965qtu.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 14:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=19TlqdLHcWDTmI9u6TYfXzttwjA+Dmg1Ug41aa4j6uk=;
        b=Imh3zKnlf2nNedw1LEfjqkhMgHeK71AVCBTejoYYCUi6PprkQk88VjzniR9FHbE1XH
         A/II2EqGYTLeEsZmDBTUvx/jf+f+d3tAzBZHwlmB+xrtw4+Z2cxN48VSSgTsz6Lj1ySD
         au/YMsmvn17ksVH6myXy9K4BV+sk2zN+Jafs8YeXGbiW03h8j+LFgn5hDUVmYV3j8Dwy
         l5E/DW5nnZBvg1KomyJxVSBEJYPTHNIcVL8vsj7kyNFLz2DfWMaRIUqUjSw2EGwIoKgP
         4DyUsfcM0sMb+V2Mle0bHYnakGr+xwU5kaLeprG/fr2kotBwhV+W2FpWkSGvxSxGnZ4G
         GCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=19TlqdLHcWDTmI9u6TYfXzttwjA+Dmg1Ug41aa4j6uk=;
        b=N/TpBLrOo4rykNDziH6vWx57DpWcOlMMI/Jm+UW7WriY7aQ+ZrgU/kyJuR8IkJnMtG
         xT4WQvyp6hWjtfgjT/SmAgXBq7klEKtEdFLAXG+fxxPO4lI7ygxr8wICE4Tj9tx1EWGx
         uMu6xCxcRCtPb58mpESThyWLm0NvmVYthW7sP4zMCb+9KK1CKMSsKA0F4RMEICCJde6T
         M/0318vUNNk+X5E8mv0FqIDZyEPTZIO6dbxWz7M6sCuYH0qvIWuQiMPUZSTe4XIXpvQ4
         BBc13pT+CJtB7TP2FtYAaysvUj1nEBNpwbkDtH5us+z1vXI2bJmDystZ9GMvB+GoG+eI
         DEJw==
X-Gm-Message-State: AOAM532yIKJlRG4lPNlr5OQ6Hqjbx+XDqNRKs+8ang0a3Jf8mhtCHcPB
        utJ7Vt8ZGfBvuoFz7Fi+Jj/iJtAdWDT/tIqs4mM=
X-Google-Smtp-Source: ABdhPJwlpWalcJXzE9B3fP2Zu3YiL4EE4FmSmcZUIR72EOxrhafPHlFtIMBSkfJpTgmFk8E2fcAes0b129xUXc5bjus=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:4594:: with SMTP id
 x20mr6549973qvu.4.1601416055400; Tue, 29 Sep 2020 14:47:35 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:46:29 -0700
In-Reply-To: <20200929214631.3516445-1-samitolvanen@google.com>
Message-Id: <20200929214631.3516445-28-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 27/29] x86, vdso: disable LTO only for vDSO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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

Disable LTO for the vDSO. Note that while we could use Clang's LTO
for the 64-bit vDSO, it won't add noticeable benefit for the small
amount of C code.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/entry/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index ecc27018ae13..9b742f21d2db 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -90,7 +90,7 @@ ifneq ($(RETPOLINE_VDSO_CFLAGS),)
 endif
 endif
 
-$(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
@@ -148,6 +148,7 @@ KBUILD_CFLAGS_32 := $(filter-out -fno-pic,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out -mfentry,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 += -m32 -msoft-float -mregparm=0 -fpic
 KBUILD_CFLAGS_32 += -fno-stack-protector
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
-- 
2.28.0.709.gb0816b6eb0-goog


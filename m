Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6196F24E142
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 21:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgHUTye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 15:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgHUTyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:54:08 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E8CC0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:54:05 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k13so1335830plk.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SwQmKOlsNP/z38IYejjYj+yvvrS1Eywv52+2HVAlv9Q=;
        b=R1LdeZIF9QjkB4RICKULaFwrCsS1XuI99/vuiq4cUyDFMXBxzUFujL6oWyYM2UH1nh
         tWsZAtfxgGw6HkqEKt7TA3Ijkwr1LM5uL39F+VTZxX20aJt3RSZikDLByfg7RB4zZr5x
         8gQzvir0FqNAzAZV4VAGlv9FBJ+2iKZA31XYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SwQmKOlsNP/z38IYejjYj+yvvrS1Eywv52+2HVAlv9Q=;
        b=n96BNj7lHhQSWn5D/3LikHoAC1mWlP9aRf6x0FHyLwhUGJvSOwMeGpS3fMhxOiNQAp
         ugt4IG2sMgf4Q8uxK6iZFOHl4PDNXrndnur/QRJWFP4yDR7hF5pT9zoK10kIakzMyg5i
         C1TZ63QJXEan6zH0pRsBV4HqFL1LmxhNBe5MdBH0+aceMvWl+O0qYaRp/4SqTZykDznM
         b9Se2PJ+RL672IY2mHDJmjIkdsr/pYv33xOy9qknucjFyvyrrTtX8f3vepUsUl+961Li
         t0d2UoULilZmXCJyuN95DdxP8Lq3pRzG9tDhGWIUH4kYwFNE8NFlROXxSzjLFk73dFVd
         mRjA==
X-Gm-Message-State: AOAM530OpqZ8Wrk7DFHQ0EHwNdYqEc/5TWi9D2xM1SdUKdZ9XLXtXh13
        pagOTU4AosbQKrFODlDFIBsTQg==
X-Google-Smtp-Source: ABdhPJy2WKMv8VZqejr2E0c2Supk2WQRHgcBJPLIvDE5jyc3fVqM70J7mGGAwnDLjFOWQ8g7AvXYxw==
X-Received: by 2002:a17:902:9a43:: with SMTP id x3mr3388759plv.31.1598039645460;
        Fri, 21 Aug 2020 12:54:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z77sm3469389pfc.199.2020.08.21.12.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:54:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 14/29] arm64/build: Warn on orphan section placement
Date:   Fri, 21 Aug 2020 12:42:55 -0700
Message-Id: <20200821194310.3089815-15-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly handled in the linker
script.

With all sections now handled, enable orphan section warnings.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6de7f551b821..61a46f56ff33 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -29,6 +29,10 @@ LDFLAGS_vmlinux	+= --fix-cortex-a53-843419
   endif
 endif
 
+# We never want expected sections to be placed heuristically by the
+# linker. All sections should be explicitly named in the linker script.
+LDFLAGS_vmlinux += --orphan-handling=warn
+
 ifeq ($(CONFIG_ARM64_USE_LSE_ATOMICS), y)
   ifneq ($(CONFIG_ARM64_LSE_ATOMICS), y)
 $(warning LSE atomics not supported by binutils)
-- 
2.25.1


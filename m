Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AE420DFDE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 23:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbgF2Ukb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 16:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731674AbgF2TOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:11 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA5CC08EB0D
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:18:53 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y18so6689069plr.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UIGzgreIfTFOxxrVnfdOtVBSBIsQ6xr6g7mQ/APcJYs=;
        b=eIyxYRftnOui04V4XDgcCKRZPnSL1iLVTOLK21hciuVaKMrlO/me6I6zabNcmW51hm
         sEP0n59JEFsgLPSQ4aRAQ2lJpdfBlUFjFZ+BQZG9PBaB8aynL14Bhv8xALE7JNi7Dg0C
         QWW2xnjqIifsayeGW/Ay6Sbs+HR/6nZ4+JWWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UIGzgreIfTFOxxrVnfdOtVBSBIsQ6xr6g7mQ/APcJYs=;
        b=klpXxSDTe9h/mFHbG4tQSBMJQJuIu1lRjcpokrNroeIFJ6hOHDvRQmLyeiUsR3VW11
         Jo6Et9lMcguhMAItlzsInJueQrq++KJRLzHufOfenawsY298p9YVCD8w0DkBkQKeNtdt
         Sp8ixaO7LrTowqjRJ24h8I1687dEOjripmvRfVFKSfHUErjHln+ziz+bhxfCWObe+4RD
         HXx6GxyT4YoPte3sy69wlmIyN85iho8hqA8tHdozrjzF06cH2wt01HZr7GTa+ZzaJv8u
         prHEsmVoLtDOhnRugEAAuRiJsFzSxQbVlvm6QCDrU+6Ia0LUiUODAAQf5LrPV0loZQbN
         u8nA==
X-Gm-Message-State: AOAM531w0h3d1oyUI1o9ICInBhS+XlOOo1033T4kodGYYwhaINzZL3v3
        NQ9lQkrHLNOFvL3W2GfxvYheYw==
X-Google-Smtp-Source: ABdhPJzz69mu7O4q6VbFBjTvIO71CEyN6mZuFliZ3G3JlPVzh4yITRE6mx9hV24nwgpSONTnA4Ny3g==
X-Received: by 2002:a17:90a:1781:: with SMTP id q1mr15164767pja.24.1593411532684;
        Sun, 28 Jun 2020 23:18:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d18sm7737172pjv.25.2020.06.28.23.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:18:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/17] arm64/build: Warn on orphan section placement
Date:   Sun, 28 Jun 2020 23:18:34 -0700
Message-Id: <20200629061840.4065483-12-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly named in the linker
script.

Remove .eh_frame, since there are none left.

Add .plt, .data.rel.ro, .igot.*, and .iplt to discards as they are not
actually used. While .got.plt is also not used, it must be included
otherwise ld.bfd will fail to link with the error:

    aarch64-linux-gnu-ld: discarded output section: `.got.plt'

However, as it'd be better to validate that it stays effectively empty,
add an assert, as suggested by Ard Biesheuvel.

Explicitly include debug sections when they're present.

Finally, enable orphan section warnings.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Makefile             |  4 ++++
 arch/arm64/kernel/vmlinux.lds.S | 11 ++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 895486606f74..fb3aa2d7de4d 100644
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
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index b5a94ec1eada..320ba5ec2adc 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -94,7 +94,8 @@ SECTIONS
 	/DISCARD/ : {
 		*(.interp .dynamic)
 		*(.dynsym .dynstr .hash .gnu.hash)
-		*(.eh_frame)
+		*(.plt) *(.data.rel.ro)
+		*(.igot.*) *(.iplt)
 	}
 
 	. = KIMAGE_VADDR + TEXT_OFFSET;
@@ -244,9 +245,17 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	DWARF_DEBUG
 	ELF_DETAILS
 
 	HEAD_SYMBOLS
+
+	/*
+	 * Make sure that the .got.plt is either completely empty or it
+	 * contains only the lazy dispatch entries.
+	 */
+	.got.plt (INFO) : { *(.got.plt) }
+	ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, ".got.plt not empty")
 }
 
 #include "image-vars.h"
-- 
2.25.1


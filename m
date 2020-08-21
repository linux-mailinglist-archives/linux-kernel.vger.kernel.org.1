Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D71E24E140
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 21:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgHUTy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 15:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgHUTyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:54:08 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD18C0617A2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:54:05 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mw10so1261670pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0UnndhLoIUPQilO6J2hBojAKmFC4OCA3zcUIp6ZOMro=;
        b=Sh9vRY/SnIiq5Ijo9twGKuJvIro+2ScdJC7L8hqNb74wvpnUXW74552MBiBf5c9ho/
         BOqwZzPM/KRTMkdU/ope8Bau3ipHQ8VZu0l4lmJP8/F6K4yUVcmPySQ5Ug2/EOEQUcoO
         ZdMtW7Ylxl5Y+uUwL1z39akrMncft2tc4GNeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0UnndhLoIUPQilO6J2hBojAKmFC4OCA3zcUIp6ZOMro=;
        b=M41a9ULjF5fQYHL/+0IK9FUr8KaHQ6s5wxS6UpkaGf+ttKNAQFCjbc3/Sma0rtFFaK
         5RCA0G1Crj4lV7LCtxWky+vhKs4AuoHP2Va070b931CBEvju0XpOn5znhAqp2YFDcofO
         NrUUoMeVsRtdeOQeCCH2GQq4PmP2UYCnzKv+P6DJIcZqUoXj+Z75zQe+/nGiCmk85hJZ
         S8t0eHeTrUo7cBSuHge4i977oi0TALODrNRK7j+2b613DcAjZFMZPF/63QpRRgivNmAT
         3TqToc1W6IxqPZU4da7OuRRCvYK3gBR5vQFDnzMJi4i8YhudpkA5dD3KXO2W7LsDDTjD
         IPYA==
X-Gm-Message-State: AOAM533n2RCBbcBXiM9eDi43wR18hq4icB8oCTKvYr4ooJZ45xTBznh2
        qf+RZpr3jLqEzZsjg2OKz/GTkw==
X-Google-Smtp-Source: ABdhPJwmCnmOTUQk1XKd+olibX9ZOXDXcitcUxjr93v5Do636rUlnfDVQTuwBKBQgeAByyk2C/5Y4Q==
X-Received: by 2002:a17:90a:6787:: with SMTP id o7mr3611282pjj.76.1598039644813;
        Fri, 21 Aug 2020 12:54:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e2sm3424685pfm.37.2020.08.21.12.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:54:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
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
Subject: [PATCH v6 26/29] x86/boot/compressed: Reorganize zero-size section asserts
Date:   Fri, 21 Aug 2020 12:43:07 -0700
Message-Id: <20200821194310.3089815-27-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For readability, move the zero-sized sections to the end after DISCARDS.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/compressed/vmlinux.lds.S | 44 +++++++++++++++-----------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 3c2ee9a5bf43..ca544a16724b 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -42,19 +42,6 @@ SECTIONS
 		*(.rodata.*)
 		_erodata = . ;
 	}
-	.rel.dyn : {
-		*(.rel.*)
-	}
-	.rela.dyn : {
-		*(.rela.*)
-	}
-	.got : {
-		*(.got)
-	}
-	.got.plt : {
-		*(.got.plt)
-	}
-
 	.data :	{
 		_data = . ;
 		*(.data)
@@ -85,13 +72,34 @@ SECTIONS
 	ELF_DETAILS
 
 	DISCARDS
-}
 
-ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
+	.got.plt (INFO) : {
+		*(.got.plt)
+	}
+	ASSERT(SIZEOF(.got.plt) == 0 ||
 #ifdef CONFIG_X86_64
-ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
+	       SIZEOF(.got.plt) == 0x18,
 #else
-ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
+	       SIZEOF(.got.plt) == 0xc,
 #endif
+	       "Unexpected GOT/PLT entries detected!")
+
+	/*
+	 * Sections that should stay zero sized, which is safer to
+	 * explicitly check instead of blindly discarding.
+	 */
+	.got : {
+		*(.got)
+	}
+	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
+
+	.rel.dyn : {
+		*(.rel.*)
+	}
+	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
 
-ASSERT(SIZEOF(.rel.dyn) == 0 && SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations detected!")
+	.rela.dyn : {
+		*(.rela.*)
+	}
+	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
+}
-- 
2.25.1


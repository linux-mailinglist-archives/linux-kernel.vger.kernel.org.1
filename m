Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA192868A4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 21:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgJGTyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 15:54:02 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35637 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgJGTx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 15:53:57 -0400
Received: by mail-qt1-f193.google.com with SMTP id o21so3089682qtp.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 12:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o5OvaQB6bbpSDlYD+VA1usRAYhfy2fhJn0w2gDouEVE=;
        b=rnk3thEvFbljAn/nNQeFm8xipZwIlwyZEdfSQzPQ2GUsx0xe/8QW0F72NRmI6Vk9Ss
         J1PE8OaOFRdI2UFqRWYWe9Nt/QoKrMACH5WfOiphqX8FsF5heoQ6uHzx/yoYz6+tgMs+
         e3sGX0+yQCslpbXTo5s0ePmzfZMpX244Ji7DRf3aLoQWV43zuBEqZQSo6e0FOf2ZS/6V
         eS+CXK1uI3gMfOVvYTFVG7prrMiCFxL2wuEnm0oCKmK8a9yUNwwMbgGQ7cGs8cJLfhq2
         GEw7z0KoMuRYPtBc02+GpitF7vPWpyIRynu1whuSmHl4iGwoYus1eV8ziQU1CdkIIcF5
         2CJg==
X-Gm-Message-State: AOAM532QrqbFC4L9tbnPkJyEcMwxsV5h30HLStTiT70/1RcIgtws56oh
        8iinBByTpjKJ+E1usqfNsKE=
X-Google-Smtp-Source: ABdhPJyxzDAkeG0d/CsmGAbv2S5rCoN4wqmCIJu246mk34g9fcHMYqEsabQqzytOAjGNMkOQ9N1fzQ==
X-Received: by 2002:aed:2310:: with SMTP id h16mr4998668qtc.323.1602100434466;
        Wed, 07 Oct 2020 12:53:54 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k20sm2287658qtm.44.2020.10.07.12.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 12:53:54 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] x86/boot: Move get_cmd_line_ptr() and COMMAND_LINE_SIZE into misc.h
Date:   Wed,  7 Oct 2020 15:53:48 -0400
Message-Id: <20201007195351.776555-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007195351.776555-1-nivedita@alum.mit.edu>
References: <20201007195351.776555-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move get_cmd_line_ptr() and COMMAND_LINE_SIZE into misc.h for easier
use from multiple files.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/cmdline.c |  8 --------
 arch/x86/boot/compressed/kaslr.c   |  6 ------
 arch/x86/boot/compressed/misc.h    | 13 +++++++++++++
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c
index f1add5d85da9..d0e1d386749d 100644
--- a/arch/x86/boot/compressed/cmdline.c
+++ b/arch/x86/boot/compressed/cmdline.c
@@ -12,14 +12,6 @@ static inline char rdfs8(addr_t addr)
 	return *((char *)(fs + addr));
 }
 #include "../cmdline.c"
-unsigned long get_cmd_line_ptr(void)
-{
-	unsigned long cmd_line_ptr = boot_params->hdr.cmd_line_ptr;
-
-	cmd_line_ptr |= (u64)boot_params->ext_cmd_line_ptr << 32;
-
-	return cmd_line_ptr;
-}
 int cmdline_find_option(const char *option, char *buffer, int bufsize)
 {
 	return __cmdline_find_option(get_cmd_line_ptr(), option, buffer, bufsize);
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index b59547ce5b19..f3286a3bef36 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -36,12 +36,6 @@
 #define STATIC
 #include <linux/decompress/mm.h>
 
-#define _SETUP
-#include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
-#undef _SETUP
-
-extern unsigned long get_cmd_line_ptr(void);
-
 /* Simplified build-specific string for starting entropy. */
 static const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
 		LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION;
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 6d31f1b4c4d1..95aacc361f78 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -25,6 +25,10 @@
 #include <asm/bootparam.h>
 #include <asm/desc_defs.h>
 
+#define _SETUP
+#include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
+#undef _SETUP
+
 #define BOOT_CTYPE_H
 #include <linux/acpi.h>
 
@@ -70,6 +74,15 @@ static inline void debug_puthex(unsigned long value)
 #endif
 
 /* cmdline.c */
+static inline
+unsigned long get_cmd_line_ptr(void)
+{
+	unsigned long cmd_line_ptr = boot_params->hdr.cmd_line_ptr;
+
+	cmd_line_ptr |= (u64)boot_params->ext_cmd_line_ptr << 32;
+
+	return cmd_line_ptr;
+}
 int cmdline_find_option(const char *option, char *buffer, int bufsize);
 int cmdline_find_option_bool(const char *option);
 
-- 
2.26.2


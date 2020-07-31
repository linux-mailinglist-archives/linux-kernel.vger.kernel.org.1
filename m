Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49B0234E25
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 01:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgGaXJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 19:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgGaXIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:08:44 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78770C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:08:44 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y206so4890956pfb.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GiVQAgnHSmh3I5R0gtbyLBJa4hDaxzbWftSOld1BSI0=;
        b=eXzbc1BPKkTHPMZyF8VMqMXApjwlt+Z0Q4rDhEXSO/t0UYVMGhVF2JvNEDOO9RLwvH
         2iTlarNmR2z09AgsvCjkYUsb5PlzXqXLkM6GENu0SdaRyStQUuDsuPkPWsufjYyiDb2N
         XwF2edaq78XYfUe1PD8t2h2H1ccKfVc9P+lhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GiVQAgnHSmh3I5R0gtbyLBJa4hDaxzbWftSOld1BSI0=;
        b=k27z16iWQ0EJkR7iaZgxvqhP4w07EvP3ShEopuNI4IOKXNuDCQnLgu8jdAZjeEEFnd
         g2J3jmeYHad9S3IKCDDzNNxUTa8tu6bCZkkgYD1HCCnVldYQBW8Nwq+lucYpzUTS4BFp
         XZ7bw692jqddM/muTMQU6Z4hmZEIy83B+UzPUoj4U187G9G5GaO82YnGIA5vhPierQrS
         klBt0ZaGOXB7osjNA3B6L6S6GhSp7VlS3AnDADr3kDW7XAt+i6b/jPkK5y1QiQSsQH/t
         AqgiH6itD/fXajy1tLWoq3/vQSGk5cPEYHy2y706ecc+4V5+k29iR4NWPU2XdQcWByex
         6iOg==
X-Gm-Message-State: AOAM533iGCpRktFMyCYLUz/JNo+v4EbO9Dsze4BvSs0aRzl9dt7BTPQL
        OIPJQhNR7phNNUiZHhEHWCq2/Q==
X-Google-Smtp-Source: ABdhPJyRco/+NDd+heFvXx5i5JyQetAJX+BYme+lc8pixFz7LH/UuTvXw+HXPYf+c6sJEWtGbRKmtQ==
X-Received: by 2002:a63:6ca:: with SMTP id 193mr5786021pgg.269.1596236924037;
        Fri, 31 Jul 2020 16:08:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o23sm12166552pfd.126.2020.07.31.16.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:08:39 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 14/36] efi/libstub: Disable -mbranch-protection
Date:   Fri, 31 Jul 2020 16:07:58 -0700
Message-Id: <20200731230820.1742553-15-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding --orphan-handling=warn to more architectures,
disable -mbranch-protection, as EFI does not yet support it[1].  This was
noticed due to it producing unwanted .note.gnu.property sections (prefixed
with .init due to the objcopy build step).

However, we must also work around a bug in Clang where the section is
still emitted for code-less object files[2], so also remove the section
during the objcopy.

[1] https://lore.kernel.org/lkml/CAMj1kXHck12juGi=E=P4hWP_8vQhQ+-x3vBMc3TGeRWdQ-XkxQ@mail.gmail.com
[2] https://bugs.llvm.org/show_bug.cgi?id=46480

Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: linux-efi@vger.kernel.org
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/firmware/efi/libstub/Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index b4f8c80cc591..d7d395ede89f 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -18,7 +18,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
 cflags-$(CONFIG_ARM64)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
-				   -fpie $(DISABLE_STACKLEAK_PLUGIN)
+				   -fpie $(DISABLE_STACKLEAK_PLUGIN) \
+				   $(call cc-option,-mbranch-protection=none)
 cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
@@ -66,6 +67,12 @@ lib-$(CONFIG_X86)		+= x86-stub.o
 CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
+# Even when -mbranch-protection=none is set, Clang will generate a
+# .note.gnu.property for code-less object files (like lib/ctype.c),
+# so work around this by explicitly removing the unwanted section.
+# https://bugs.llvm.org/show_bug.cgi?id=46480
+STUBCOPY_FLAGS-y		+= --remove-section=.note.gnu.property
+
 #
 # For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
 # .bss section, so the .bss section of the EFI stub needs to be included in the
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BAA234E0D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 01:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgGaXJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 19:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgGaXIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:08:51 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAC9C0617A5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:08:51 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t10so12768081plz.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1/odabPwHQ2/Ek+CjiibQWaFn9uH/zMNlMmZjncvN+I=;
        b=JAuYbSstQfukYE+Gb0Ne3AWJsz3y+BlIBQzjuLdwl34WW/5cbPcD0t5CHhdrnYt4P3
         xCUUA6EqSYHRyEaYtQDNEDCQom38Ssx+gnWJzailUIVVZGprbqvIEm49kDNsHFrs+06/
         VGIh/ScEhC/6EEEQyATwr44GVOS6GPHdqpL10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1/odabPwHQ2/Ek+CjiibQWaFn9uH/zMNlMmZjncvN+I=;
        b=o0IpeEmaiJdHQTHmNDG4QCiFBIe4wK7v4sbqrqXe8ZB6pqYo7PlEt8svnqQa1H/9pc
         wUWWR/VrobRraiGKsevOd2lTjesDl5KZ+9TxrWqcJlrG1UwbjtUquu4a9Jbs1dXtJ4K8
         znNOjKgk5Q5Kwr8i0I+R/Qmga0rHccNclXrRgjhUbdnfft5rehdffdOIwSn37UeAQ1SQ
         tNiF4cchqmo1KLBK4mIe//8rUx8O/73LNzb1HSEtKtNXJJ3X2OAwens460QsXcLZwJMk
         FoMtERajWUut/yXjve+4AdpBFP8YRy4C56xHtGyBlw4e7DCNvKRcrR7q+GoHxiZJb+Rm
         MclA==
X-Gm-Message-State: AOAM531LGnM/dXC7zhFRZ2YG0QOPREkY6wumKQ9TpgHu1lOJHz6QybSo
        FIG0KJqVwwq2xVbDWs2JV9wURQ==
X-Google-Smtp-Source: ABdhPJxMsEgUP85f2oRI5I8YFPTSXC9amM4W7Q94F6/Za32NnrZP42b5jtXzGrIuUujHM4rhfoKpRQ==
X-Received: by 2002:a17:90a:dc06:: with SMTP id i6mr5914699pjv.161.1596236930832;
        Fri, 31 Jul 2020 16:08:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b20sm4306905pfo.88.2020.07.31.16.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:08:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
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
Subject: [PATCH v5 36/36] arm/build: Assert for unwanted sections
Date:   Fri, 31 Jul 2020 16:08:20 -0700
Message-Id: <20200731230820.1742553-37-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for warning on orphan sections, enforce
expected-to-be-zero-sized sections (since discarding them might hide
problems with them suddenly gaining unexpected entries).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/include/asm/vmlinux.lds.h | 10 ++++++++++
 arch/arm/kernel/vmlinux-xip.lds.S  |  2 ++
 arch/arm/kernel/vmlinux.lds.S      |  2 ++
 3 files changed, 14 insertions(+)

diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
index 6624dd97475c..e0d49fd756f7 100644
--- a/arch/arm/include/asm/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -52,6 +52,16 @@
 		ARM_MMU_DISCARD(*(__ex_table))				\
 		COMMON_DISCARDS
 
+/*
+ * Sections that should stay zero sized, which is safer to explicitly
+ * check instead of blindly discarding.
+ */
+#define ARM_ASSERTS							\
+	.plt (NOLOAD) : {						\
+		*(.iplt) *(.rel.iplt) *(.iplt) *(.igot.plt)		\
+	}								\
+	ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
+
 #define ARM_DETAILS							\
 		ELF_DETAILS						\
 		.ARM.attributes 0 : { *(.ARM.attributes) }
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 11ffa79751da..50136828f5b5 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -152,6 +152,8 @@ SECTIONS
 	STABS_DEBUG
 	DWARF_DEBUG
 	ARM_DETAILS
+
+	ARM_ASSERTS
 }
 
 /*
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index dc672fe35de3..5f4922e858d0 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -151,6 +151,8 @@ SECTIONS
 	STABS_DEBUG
 	DWARF_DEBUG
 	ARM_DETAILS
+
+	ARM_ASSERTS
 }
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-- 
2.25.1


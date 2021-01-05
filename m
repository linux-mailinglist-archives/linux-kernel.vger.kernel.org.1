Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A171F2EB20D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbhAESGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbhAESGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:06:41 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48C9C06179F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:06:00 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c124so356219wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4s4kC7CHwiZm9mv2QHLBsiW5mNoTxM3uNeHHcwGbjn8=;
        b=Xp8q0HPzSd/L5ty1dj9Lhbtp9EHrG0IFlx9wI2ylD0ujpGx5iKDRejeLVXFUQMsIC6
         GtYZ1r97VgBDtNlCFXQGyhBxyH2UgV0oAMFgNf+zfEn2uNaW5F5ZY5hFU4rBBotBttZV
         Ez9NqLsfLybCw1F6vLmJlhU41dkQdfwSjXaOlTM0w4sScV4zD8rB/ZQ+zzoZAlxO23um
         pTKRQ1kmXyWQBERElli5iZ6nuyYSAhtOUuugXxR7GluR3vLn7BwITKmm9cqdVPbQw+PH
         Xf5ji8WYrP2AnhiRdel2xu2wl3gBJQc6NlmPfhaPPqQ42kWvfaUkxEvmSf4xWnlilhU6
         zv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4s4kC7CHwiZm9mv2QHLBsiW5mNoTxM3uNeHHcwGbjn8=;
        b=K6Dvap7r6lFqt4V3Lw+PtqeGy2h4clcPOZa7jzXuJPvA9eKj0yhfjuNpHO6emrdbar
         WmtB58LxvpDMhc3nbTYLLrMzD9hdVGs/e7X0WSShtNGsYUy40FPtZ0JLoTreslxo3HYn
         9V972wHXB6ffEWJID7CgjwY2m5owUhW+ueDKYAFrvRO5/ud1yZGG0ExgxR3GG5ZPfki2
         LZCPHYI84H7mbeD6KMWDJ5dKolfwNMtunYJ6yPkaR46SJBBfGKCiRIWPQqZxY/rngjAf
         gWpSy0uG2GzCrCBvJrN3up2VFxAqz9MxopJUQqGOWa8zQeplJxZDn7tDZ3Z6AFfZGtrS
         Y82g==
X-Gm-Message-State: AOAM533E9pLkmBJn5GldDrj9gF8WdYH58L3y6AP9/W3X203o3/baR11O
        8Nx14mZwBgkUwDy+R3wGOpCtSQ==
X-Google-Smtp-Source: ABdhPJxRBFRzG613rtvyFJCeGLgpeoBl59v2l9QUF4TI9LzcY5VpziqmJ9QhA/8AH0mZ8DHe5XtmjA==
X-Received: by 2002:a1c:2d8a:: with SMTP id t132mr289011wmt.119.1609869959397;
        Tue, 05 Jan 2021 10:05:59 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:4957:71a5:7b5c:c94f])
        by smtp.gmail.com with ESMTPSA id t10sm745477wrp.39.2021.01.05.10.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 10:05:58 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 3/8] KVM: arm64: Add symbol at the beginning of each hyp section
Date:   Tue,  5 Jan 2021 18:05:36 +0000
Message-Id: <20210105180541.65031-4-dbrazdil@google.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105180541.65031-1-dbrazdil@google.com>
References: <20210105180541.65031-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generating hyp relocations will require referencing positions at a given
offset from the beginning of hyp sections. Since the final layout will
not be determined until the linking of `vmlinux`, modify the hyp linker
script to insert a symbol at the first byte of each hyp section to use
as an anchor. The linker of `vmlinux` will place the symbols together
with the sections.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/hyp_image.h | 29 +++++++++++++++++++++++++++--
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S  |  4 ++--
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/hyp_image.h b/arch/arm64/include/asm/hyp_image.h
index daa1a1da539e..f97b774b58f4 100644
--- a/arch/arm64/include/asm/hyp_image.h
+++ b/arch/arm64/include/asm/hyp_image.h
@@ -7,6 +7,9 @@
 #ifndef __ARM64_HYP_IMAGE_H__
 #define __ARM64_HYP_IMAGE_H__
 
+#define HYP_CONCAT(a, b)	__HYP_CONCAT(a, b)
+#define __HYP_CONCAT(a, b)	a ## b
+
 /*
  * KVM nVHE code has its own symbol namespace prefixed with __kvm_nvhe_,
  * to separate it from the kernel proper.
@@ -21,9 +24,31 @@
  */
 #define HYP_SECTION_NAME(NAME)	.hyp##NAME
 
+/* Symbol defined at the beginning of each hyp section. */
+#define HYP_SECTION_SYMBOL_NAME(NAME) \
+	HYP_CONCAT(__hyp_section_, HYP_SECTION_NAME(NAME))
+
+/*
+ * Helper to generate linker script statements starting a hyp section.
+ *
+ * A symbol with a well-known name is defined at the first byte. This
+ * is used as a base for hyp relocations (see gen-hyprel.c). It must
+ * be defined inside the section so the linker of `vmlinux` cannot
+ * separate it from the section data.
+ */
+#define BEGIN_HYP_SECTION(NAME)				\
+	HYP_SECTION_NAME(NAME) : {			\
+		HYP_SECTION_SYMBOL_NAME(NAME) = .;
+
+/* Helper to generate linker script statements ending a hyp section. */
+#define END_HYP_SECTION					\
+	}
+
 /* Defines an ELF hyp section from input section @NAME and its subsections. */
-#define HYP_SECTION(NAME) \
-	HYP_SECTION_NAME(NAME) : { *(NAME NAME##.*) }
+#define HYP_SECTION(NAME)			\
+	BEGIN_HYP_SECTION(NAME)			\
+		*(NAME NAME##.*)		\
+	END_HYP_SECTION
 
 /*
  * Defines a linker script alias of a kernel-proper symbol referenced by
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
index cfdc59b4329b..cd119d82d8e3 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -22,7 +22,7 @@ SECTIONS {
 	 * alignment for when linking into vmlinux.
 	 */
 	. = ALIGN(PAGE_SIZE);
-	HYP_SECTION_NAME(.data..percpu) : {
+	BEGIN_HYP_SECTION(.data..percpu)
 		PERCPU_INPUT(L1_CACHE_BYTES)
-	}
+	END_HYP_SECTION
 }
-- 
2.29.2.729.g45daf8777d-goog


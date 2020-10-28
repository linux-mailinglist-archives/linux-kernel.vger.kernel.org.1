Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48D429DC12
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390657AbgJ2AVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgJ2AUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:20:55 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D39DC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:20:55 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t14so907183pgg.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lIDedNlfgZ1oog3IrHLVaiNsZPdquv/snadYKp5vh58=;
        b=AQPWAMS61o9C2pgZgGy869tf3lXXylVcqXe+ikHWir/EyId4ku2Uf4dVFHo75eRxM0
         pU70ulSbdeyn4CjKwEO9adG6Mnz4iOyxseQEmvlzHIkrnGErHk3m3EshZMBhm59jPQHD
         VI7t12b5AQU91NcmIRc6DBggtiuW4Fb+Gu1Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lIDedNlfgZ1oog3IrHLVaiNsZPdquv/snadYKp5vh58=;
        b=Ue/QwJB0bZLxeZpj2toZ351vpfhZtKemTvdERBWZV0fP5g0ElibXo7hZAypjTcdL2v
         wdcNYVEbygUcF5irDiFssD8Q/6uEOlkDYGqgVCy7nbPyu352u+Q9IVVGObqOcrtFOLkF
         p3L5oHIazLXSbe1BvGketUbxQlz+W0bTjwolrf9KrdRhidXFxyf+gf0ngQuHF+swGr2n
         Yedf9aIi81qMs49gL7hqm7mD0QTwAWLi0kynkahRTUyxWRy/mwp2880baD6CHk9hagfb
         XUM924MTH6ZcN+/3VlPvVT+ZJI8OGDk6I5jjnNQNPUIBpfU+aRbj2ClpzFwgBckQj/Xp
         XxnQ==
X-Gm-Message-State: AOAM5331KalEiKfssDaE5qJyd9UWKHMwdQBsJ0hW7gOkpCEZw96mfFR8
        HV3x9QbGdRq4EY/ceZGicd1I9dP6TwOY9w==
X-Google-Smtp-Source: ABdhPJyC5mG5Vd1iSzO7J5KCCw8uK60zFkD3M2QaSd8ZJFFK04kgCWtjeWEJlAdQcSZ2tE/Xgk1QMQ==
X-Received: by 2002:a63:2021:: with SMTP id g33mr4048563pgg.5.1603844405194;
        Tue, 27 Oct 2020 17:20:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b4sm3590451pfi.208.2020.10.27.17.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 17:20:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <yifeifz2@illinois.edu>
Cc:     Kees Cook <keescook@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm: Enable seccomp architecture tracking
Date:   Tue, 27 Oct 2020 17:20:00 -0700
Message-Id: <20201028002000.2666043-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201028002000.2666043-1-keescook@chromium.org>
References: <20201028002000.2666043-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable seccomp constant action bitmaps, we need to have a static
mapping to the audit architecture and system call table size. Add these
for arm.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/include/asm/Kbuild    |  1 -
 arch/arm/include/asm/seccomp.h | 11 +++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/include/asm/seccomp.h

diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 383635b68763..4a0848aef207 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -4,7 +4,6 @@ generic-y += extable.h
 generic-y += flat.h
 generic-y += local64.h
 generic-y += parport.h
-generic-y += seccomp.h
 
 generated-y += mach-types.h
 generated-y += unistd-nr.h
diff --git a/arch/arm/include/asm/seccomp.h b/arch/arm/include/asm/seccomp.h
new file mode 100644
index 000000000000..e9ad0f37d2ba
--- /dev/null
+++ b/arch/arm/include/asm/seccomp.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_SECCOMP_H
+#define _ASM_SECCOMP_H
+
+#include <asm-generic/seccomp.h>
+
+#define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_ARM
+#define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+#define SECCOMP_ARCH_NATIVE_NAME	"arm"
+
+#endif /* _ASM_SECCOMP_H */
-- 
2.25.1


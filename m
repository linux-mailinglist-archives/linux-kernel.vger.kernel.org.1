Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD6D29D481
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgJ1Vwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbgJ1VwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:52:25 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC95C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:52:25 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o9so278474plx.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zePcVpRarotahzKaCqRZdaRiSEtxo4yNeBKHniB4eyw=;
        b=Ip+vX9JL9N8kIaUG315SCQn7OHiL1Siu3qJGMMfD1qIc2wMLjGAf76ochUWLBx4b4c
         UH7oRFW+f9qhKEw8TsPIPiUmeVnU6cZryiX6HhRh9z+iuZrUzyHP1rDAoY9bS8xeTtGh
         wScjE5D6hmrl10gcmIv03ScLnPyG4hoTfiMOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zePcVpRarotahzKaCqRZdaRiSEtxo4yNeBKHniB4eyw=;
        b=BBm+WcDjNVPGUM4lZjtX84gP3RnZyBIQIzlsISxJDSichHtDioP2MeQPMXkkUtO3r7
         dQTNf915wTnu7F+WA/NS8mKvEMxez0nbsmPpTot5rSA0Xz1irqgIPeIbXWzNa3MTgOoU
         lobc93nucApd96n1akqCJjANgK8ymtJkMhcx66PhYSV8i5JCues+cvseqiBsNa3DJsXd
         PehxrN2wqPGqgsZfbnrCyX3MeAGGcLcutvH4+MowlYVD5xZHTJocOa9N1SzOz9AfT5/u
         TnrVyGlWBvjnBAUcq4uPnr5fSZk/7oZbym/ztGFnEMcyHNks74tMDGRYDrd9yXBhWl10
         JIsA==
X-Gm-Message-State: AOAM531LKzD+09IOr4hqOa2A/JLuNuj+k2AVxL2fQkGo8oPNe50iBr/W
        qrVcaEwH2Gt2wItZoyxUEtx8pLRSFeo4fg==
X-Google-Smtp-Source: ABdhPJyI+1hrqGTtsa7QmeTYy6tIsfzCNRfbTeJmr5zZ9RgR4ofeC4umHMgn4fZDY3IOEG5FjQWg7g==
X-Received: by 2002:a17:902:8f96:b029:d6:293f:ed44 with SMTP id z22-20020a1709028f96b02900d6293fed44mr4985406plo.72.1603844406434;
        Tue, 27 Oct 2020 17:20:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d145sm3776584pfd.136.2020.10.27.17.20.04
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
Subject: [PATCH 1/2] arm64: Enable seccomp architecture tracking
Date:   Tue, 27 Oct 2020 17:19:59 -0700
Message-Id: <20201028002000.2666043-2-keescook@chromium.org>
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
for arm64.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/seccomp.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/seccomp.h b/arch/arm64/include/asm/seccomp.h
index c36387170936..40f325e7a404 100644
--- a/arch/arm64/include/asm/seccomp.h
+++ b/arch/arm64/include/asm/seccomp.h
@@ -19,4 +19,19 @@
 
 #include <asm-generic/seccomp.h>
 
+#ifdef CONFIG_ARM64
+# define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_AARCH64
+# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+# define SECCOMP_ARCH_NATIVE_NAME	"arm64"
+# ifdef CONFIG_COMPAT
+#  define SECCOMP_ARCH_COMPAT		AUDIT_ARCH_ARM
+#  define SECCOMP_ARCH_COMPAT_NR	__NR_compat_syscalls
+#  define SECCOMP_ARCH_COMPAT_NAME	"arm"
+# endif
+#else /* !CONFIG_ARM64 */
+# define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_ARM
+# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+# define SECCOMP_ARCH_NATIVE_NAME	"arm"
+#endif
+
 #endif /* _ASM_SECCOMP_H */
-- 
2.25.1


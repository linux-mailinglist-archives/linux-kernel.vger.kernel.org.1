Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4B11FAA6B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 09:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgFPHuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 03:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgFPHt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:49:58 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB77C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:49:48 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a127so9089960pfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LpGj0LlWhL2sX6NdVIScVPST1vvxv4HP5Xz6PQqXsUs=;
        b=mBMsu/H37l5/82lF78S3TFrEkOg5oaDeSPvONr2tsAmEU8cRaPFfhq+CvSo+fcCXID
         IaaYZg3VqQimghB/9or2O9e8aLGitYBJVNAhSN6fjjNL8HkLB1nz+Zgd5nThB33PKaA+
         TdE8nGpBIfY9arDLD7VJCBRTPkHDuKf0fytoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LpGj0LlWhL2sX6NdVIScVPST1vvxv4HP5Xz6PQqXsUs=;
        b=tlmGc0wVmSWcSB5WLvgsLMKjgh2djbUf7H8ciyzZ/SuREMcSUPww5b+oKMj/NkG2RO
         V0nrgjSgQeYXSzc4IYYrmOz1B31XVrGbhwY9sZX1vX2TlqhzdQimUzzQcf2aY/a3oVY3
         ONd5V/jWapSCN2rq7aA4An4bhdYHcEh09g6bTzG+/btEx3M/E8PWR1rml9UDi+FW9nPr
         NsZ0ntE6uu1EW96YYDvKd8e394iKLfRpJqK0/Blbq7Vus98q4IcUVwpB7WmqNUtCFGll
         vM667YG4QIGuKre2xajOxfzGFzegmLv1BgHo0wpIj4zirS4ApRINn+pOt25f2KHfZJH6
         CfIw==
X-Gm-Message-State: AOAM533E8Oqw8jFAmJ91wPx2FeaxVLXPOb2l6+nQ7zEmuRGGxbA27rTP
        5rSqD5M2MYMpdq3CM9cW2z/VBQ==
X-Google-Smtp-Source: ABdhPJySFd7sCS5BogiTiTKCUdeWwjE8zpkNMModdzfibmP1Pshjj5uSx9ng6G7MEky9Ar+74tfsDQ==
X-Received: by 2002:a62:1bc5:: with SMTP id b188mr970686pfb.119.1592293788235;
        Tue, 16 Jun 2020 00:49:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l23sm13485938pgc.55.2020.06.16.00.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:49:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>, x86@kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 7/8] x86: Enable seccomp constant action bitmaps
Date:   Tue, 16 Jun 2020 00:49:33 -0700
Message-Id: <20200616074934.1600036-8-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200616074934.1600036-1-keescook@chromium.org>
References: <20200616074934.1600036-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that CPU-local kernel TLB flushes are available to seccomp, define
the specific architectures seccomp should be expected to reason about,
so that constant action bitmaps can be enabled for x86.

TODO: handle x32 via a "synthetic architecture" check, like done in
syscall entry.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Kconfig               | 1 +
 arch/x86/include/asm/syscall.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6a0cc524882d..0f7a0abab88f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -149,6 +149,7 @@ config X86
 	select HAVE_ARCH_COMPAT_MMAP_BASES	if MMU && COMPAT
 	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_SECCOMP_BITMAP		if !X86_X32
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 7cbf733d11af..b89e86f4c061 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -97,6 +97,7 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	memcpy(&regs->bx + i, args, n * sizeof(args[0]));
 }
 
+#define SECCOMP_ARCH		AUDIT_ARCH_I386
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_I386;
@@ -152,6 +153,10 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	}
 }
 
+#define SECCOMP_ARCH		AUDIT_ARCH_X86_64
+#ifdef CONFIG_COMPAT
+#define SECCOMP_ARCH_COMPAT	AUDIT_ARCH_I386
+#endif
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	/* x32 tasks should be considered AUDIT_ARCH_X86_64. */
-- 
2.25.1


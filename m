Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBB22AA925
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 06:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgKHFRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 00:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgKHFRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 00:17:38 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7289BC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 21:17:38 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 10so4327158wml.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 21:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vUd6dOqdaOWw315aR0DaswcpfTZy/jRQxum4V+Ace34=;
        b=DyO5TdvXGIW3umY4xtrgWizP3A2aAZwUGxv6+dU2uEDkKIX+BLZY8pYQV9lKibvunC
         3+ZKvwDHe3rJ6NvGf9opUeFCT+9ksalRilRutQfSdICVTFWalVdvpYzf/+M3Ae6kRoXt
         Swx5wzJTGvr4OQ/MMjguWf0ewSBxguOP8ObI1V8QWW/+q4PKLkrnzjgLKds0hwWyAQNr
         cvtGqgjSNNhfoKnI8/4KqCi2PfM/0O3FHJUDBq//78oWZ4So2wKE1/ZHAwl09tLhTcuY
         xxlzS6fYqPeCajHUw72d2CfLoHNXcsNAnp2/y7DJ1i4uGIJGrXzwjzUU2uPLSC0tbQPA
         5p1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vUd6dOqdaOWw315aR0DaswcpfTZy/jRQxum4V+Ace34=;
        b=Vq3yv0SQHR4S+pExPyCTnbpMXuBPHnbnpXndtGVHUXybtDN/n/CdB6fRCrUOhV7Z3T
         rWjTYbMPc7XEvT35VoukDplFm6USbrhU0FuZ7JvYJTUOu+3geRtqiGEIf4JGzO4Q0bC6
         PuRlLbaNRjlCGemu1310JQLgq155FxmNMHa+TLdg+LFtM1g+WkiRvVcHJpp6BnebtG1g
         TtS1UmhuhksbbBrYCfvwAG238F6PzCt8vT177CcXNzpnrvI1tsIbEfwxcG9EKE4IkzIH
         1kc1OTVBbgDzyLbYt87mRWoj61HU5hG+CHQ97QBRkjWglA3ZByuolWM24oVfs1suJA/2
         EGdg==
X-Gm-Message-State: AOAM533O4upUr59cc9vDp9AVBzWIktQl7aKQa2MBosx3MT+oNHGV56x/
        8exu3gul4cAArBoiphO8AAYXJSMauIk4249t
X-Google-Smtp-Source: ABdhPJyf40y2NIrNfMJo2pbmAsRC6pzfkHEuGCTePTp8z+b9n7j04SFKCAxCLgCv+7nw1EJSl3Vs7g==
X-Received: by 2002:a1c:b104:: with SMTP id a4mr7553746wmf.138.1604812656972;
        Sat, 07 Nov 2020 21:17:36 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id r10sm8378462wmg.16.2020.11.07.21.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 21:17:36 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/19] arm64: Use in_compat_task() in arch_setup_additional_pages()
Date:   Sun,  8 Nov 2020 05:17:13 +0000
Message-Id: <20201108051730.2042693-4-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108051730.2042693-1-dima@arista.com>
References: <20201108051730.2042693-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of providing compat_arch_setup_additional_pages(), check if the
task is compatible from personality, which is set earlier in
load_elf_binary(). That will align code with powerpc and sparc, also
it'll allow to completely remove compat_arch_setyp_addtional_pages()
macro after doing the same for x86, simiplifying the binfmt code
in the end.

Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm64/include/asm/elf.h |  5 -----
 arch/arm64/kernel/vdso.c     | 21 ++++++++++-----------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index d1073ffa7f24..a81953bcc1cf 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -237,11 +237,6 @@ do {									\
 #else
 #define COMPAT_ARCH_DLINFO
 #endif
-struct linux_binprm;
-extern int aarch32_setup_additional_pages(struct linux_binprm *bprm,
-					  int uses_interp);
-#define compat_arch_setup_additional_pages \
-					aarch32_setup_additional_pages
 
 #endif /* CONFIG_COMPAT */
 
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index cee5d04ea9ad..1b710deb84d6 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -401,29 +401,24 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
 	return PTR_ERR_OR_ZERO(ret);
 }
 
-int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+static int aarch32_setup_additional_pages(struct linux_binprm *bprm,
+					  int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
 	int ret;
 
-	if (mmap_write_lock_killable(mm))
-		return -EINTR;
-
 	ret = aarch32_kuser_helpers_setup(mm);
 	if (ret)
-		goto out;
+		return ret;
 
 	if (IS_ENABLED(CONFIG_COMPAT_VDSO)) {
 		ret = __setup_additional_pages(VDSO_ABI_AA32, mm, bprm,
 					       uses_interp);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
-	ret = aarch32_sigreturn_setup(mm);
-out:
-	mmap_write_unlock(mm);
-	return ret;
+	return aarch32_sigreturn_setup(mm);
 }
 #endif /* CONFIG_COMPAT */
 
@@ -460,7 +455,11 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
-	ret = __setup_additional_pages(VDSO_ABI_AA64, mm, bprm, uses_interp);
+	if (is_compat_task())
+		ret = aarch32_setup_additional_pages(bprm, uses_interp);
+	else
+		ret = __setup_additional_pages(VDSO_ABI_AA64, mm, bprm, uses_interp);
+
 	mmap_write_unlock(mm);
 
 	return ret;
-- 
2.28.0


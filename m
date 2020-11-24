Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598312C19F9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgKXA3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgKXA3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:29:41 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C9EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:29:40 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id z7so4762753wrn.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UcCIRGmM/YGnwPjlfTDRcJXaiwDGJ+twdQ1gGnVL/d4=;
        b=RZhdgZQgGKcvNlF0S2Og7vrX1ONcPaiqJntZ7SQRw+joDv1hzDZUZ71RQZeqKcTQYz
         JQ/RfY1etQnuRbg/dDc7tRS/ZLkf7m7qjWLj66Tl0Uzlmt4qceRVoNbYBQB7Q45FZLtS
         /pNckThh9WoT6+NzquyLeIjyFIwuIJSJitzccp6KEpJo3YxZxxv6iKIXQEwft0GU5wLX
         BTq3QXPePovxGqTE0nmR8IZPnafEsh9Z0Uz9MIDHnSD8af0nUB7DwlbjBApLIqe7xqtM
         iFPOSstwEIrmjREf50HaOZrqTztLA2azbTCTlu546LPh9vNUlOBp0EH2X2d/DThcYUh0
         WkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UcCIRGmM/YGnwPjlfTDRcJXaiwDGJ+twdQ1gGnVL/d4=;
        b=QDM8ym6iqsQDQLIaG90+9MvBMBBkkV80x14onbK/J8y5PHedr8fJYp9TY6DIwexjEi
         bEr+iGZZY8lLv7bcVBvQWXZZq3n+8hnEhjdw58erVkX4+pHShGjV5hpNnqAKf3+crapj
         DfySzbfa+aeOeQFxRsIr47ic+1W/Lt3HUdC+MqYSvA7/5PZbC9518ejN/AMTmt6Yybab
         7b4FtFmBVGPnneZk5upS+gc/R+A5V4c+bTMQPENwXBYFG+rl9tpOZhzabU34zCb++hW8
         kCP0A/xDxv8lAOk5TfEb0biPA9aqZp1+D6n+eF6eIIgIjnyudVLwKnQO2VVqFAx8Ilbp
         DLfA==
X-Gm-Message-State: AOAM532vFXxmhXNI8n5Dy3Y3w27MwuNNgAwyaWLFPl6QrpWAwSjWe2lp
        cbozuO+rF/DeHK2M0Yt0348Vwbp7BjCAADep
X-Google-Smtp-Source: ABdhPJz5mg886vklcWq45WgpwsfzCRLLiJShXuFPm0RDpQervJuhQAt1rtPXEs4MPY6n9x0ZpEik1Q==
X-Received: by 2002:adf:8030:: with SMTP id 45mr2191712wrk.407.1606177778887;
        Mon, 23 Nov 2020 16:29:38 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id c6sm25047360wrh.74.2020.11.23.16.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 16:29:38 -0800 (PST)
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
Subject: [PATCH v2 03/19] arm64: Use in_compat_task() in arch_setup_additional_pages()
Date:   Tue, 24 Nov 2020 00:29:16 +0000
Message-Id: <20201124002932.1220517-4-dima@arista.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124002932.1220517-1-dima@arista.com>
References: <20201124002932.1220517-1-dima@arista.com>
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
2.29.2


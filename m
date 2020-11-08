Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBE22AA92C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 06:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgKHFR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 00:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgKHFRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 00:17:49 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502E6C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 21:17:49 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id d12so3819093wrr.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 21:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Inxj3rXOOa/Uc3tNUhb6BsLuuKfgQtrmtyqYGld3mIo=;
        b=VYqn3MMrGJ2Fsltf5YdAdM6zN9PRvm+73VlkOed2ExPEQtjvbTSnWniXrEm3+M7lgu
         KwLZFa/Ur9/kYSrOOAFmHjuWMHtIClCHmsXDyE9p+47obRihGfVEPBbRrX3MDO9HHDSJ
         MRUQ8dw22R2n6AQglvZxkrRFc2XFVemDj0hSclHpUXFKps+LI/ebjiSyvsrFRrB5AOzM
         FiTCA6PF4Q0s9luZt+AnzgQoAz4NQrRsk6TTmcDoV4WhaT/XpX6PeS0BaqIdgFexeXjb
         R9gCwCvZRPZ8WkLeOPl34UwfbfGSdNy6Yk3TaA4Ew8Jw+gPECso346iEfLlBMM4UVAFk
         RYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Inxj3rXOOa/Uc3tNUhb6BsLuuKfgQtrmtyqYGld3mIo=;
        b=a6hJh4JL2+/PxQh6BYHSavPmCkBi8c+RyFgsmuDDvJASWh7/THl5H1zx5Mw5bNizm7
         S3zc2dNkELExs4BoIgYiHGir7yKtAbJOp4Ggpivyr8MdtUgB5AcYo95ORJM+C2lLl6Ux
         WUyn1KaJiD3MOnMdCzcterDwkvzN6OkMBTXrtbflpbEm6mieCLH+47+CvVRbR7/MH+mi
         kYbqyXNT9WMSAUgBr86zxqSE4U7Bdz+6bERD04qAPrOvSPMu0iWKcrI0TUGzktrSBM2m
         /2AA4RIfka3PlKW+YpOY7UHF2iD4lK2tD6dRLCsrqtnuLZlSHlckcoJCXcOUK8frlmgs
         9SiA==
X-Gm-Message-State: AOAM531LfOHdXqnZa2ZJIzU4FmGpx9S76rfnImWsBamgrFPmanfKvwcR
        JzY02xk+/u2FRtQanSCrMJBUzIXfyGBddbcd
X-Google-Smtp-Source: ABdhPJyfNqCa1YvjmbN7bEzfCHzqel04Kq2DiWfnBBG1wnBvHOwjvUwX2jQGpwR7/0F630jR2EwX+w==
X-Received: by 2002:adf:cd87:: with SMTP id q7mr10994321wrj.169.1604812667859;
        Sat, 07 Nov 2020 21:17:47 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id r10sm8378462wmg.16.2020.11.07.21.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 21:17:47 -0800 (PST)
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
        Will Deacon <will@kernel.org>, x86@kernel.org
Subject: [PATCH 11/19] mm/mmap: Make vm_special_mapping::mremap return void
Date:   Sun,  8 Nov 2020 05:17:21 +0000
Message-Id: <20201108051730.2042693-12-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108051730.2042693-1-dima@arista.com>
References: <20201108051730.2042693-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously .mremap() callback needed (int) return to provide way to
restrict resizing of a special mapping. Now it's restricted by
providing .may_split = special_mapping_split.

Removing (int) return simplifies further changes to
special_mapping_mremap() as it won't need save ret code from the
callback. Also, it removes needless `return 0` from callbacks.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm/kernel/process.c | 3 +--
 arch/arm64/kernel/vdso.c  | 4 +---
 arch/mips/vdso/genvdso.c  | 3 +--
 arch/x86/entry/vdso/vma.c | 4 +---
 include/linux/mm_types.h  | 2 +-
 mm/mmap.c                 | 2 +-
 6 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 0e90cba8ac7a..5f4eced738f5 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -376,11 +376,10 @@ static unsigned long sigpage_addr(const struct mm_struct *mm,
 static struct page *signal_page;
 extern struct page *get_signal_page(void);
 
-static int sigpage_mremap(const struct vm_special_mapping *sm,
+static void sigpage_mremap(const struct vm_special_mapping *sm,
 		struct vm_area_struct *new_vma)
 {
 	current->mm->context.sigpage = new_vma->vm_start;
-	return 0;
 }
 
 static const struct vm_special_mapping sigpage_mapping = {
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 666338724a07..91c1b7c716b7 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -78,12 +78,10 @@ static union {
 } vdso_data_store __page_aligned_data;
 struct vdso_data *vdso_data = vdso_data_store.data;
 
-static int vdso_mremap(const struct vm_special_mapping *sm,
+static void vdso_mremap(const struct vm_special_mapping *sm,
 		struct vm_area_struct *new_vma)
 {
 	current->mm->context.vdso = (void *)new_vma->vm_start;
-
-	return 0;
 }
 
 static int __vdso_init(enum vdso_abi abi)
diff --git a/arch/mips/vdso/genvdso.c b/arch/mips/vdso/genvdso.c
index 09e30eb4be86..0303d30cde03 100644
--- a/arch/mips/vdso/genvdso.c
+++ b/arch/mips/vdso/genvdso.c
@@ -259,13 +259,12 @@ int main(int argc, char **argv)
 	fprintf(out_file, "#include <linux/linkage.h>\n");
 	fprintf(out_file, "#include <linux/mm.h>\n");
 	fprintf(out_file, "#include <asm/vdso.h>\n");
-	fprintf(out_file, "static int vdso_mremap(\n");
+	fprintf(out_file, "static void vdso_mremap(\n");
 	fprintf(out_file, "	const struct vm_special_mapping *sm,\n");
 	fprintf(out_file, "	struct vm_area_struct *new_vma)\n");
 	fprintf(out_file, "{\n");
 	fprintf(out_file, "	current->mm->context.vdso =\n");
 	fprintf(out_file, "	(void *)(new_vma->vm_start);\n");
-	fprintf(out_file, "	return 0;\n");
 	fprintf(out_file, "}\n");
 
 	/* Write out the stripped VDSO data. */
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 5b9020742e66..65780a0164e3 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -86,15 +86,13 @@ static void vdso_fix_landing(const struct vdso_image *image,
 #endif
 }
 
-static int vdso_mremap(const struct vm_special_mapping *sm,
+static void vdso_mremap(const struct vm_special_mapping *sm,
 		struct vm_area_struct *new_vma)
 {
 	const struct vdso_image *image = current->mm->context.vdso_image;
 
 	vdso_fix_landing(image, new_vma);
 	current->mm->context.vdso = (void __user *)new_vma->vm_start;
-
-	return 0;
 }
 
 #ifdef CONFIG_TIME_NS
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6a6b078b9d6a..b035caff6abe 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -772,7 +772,7 @@ struct vm_special_mapping {
 				struct vm_area_struct *vma,
 				struct vm_fault *vmf);
 
-	int (*mremap)(const struct vm_special_mapping *sm,
+	void (*mremap)(const struct vm_special_mapping *sm,
 		     struct vm_area_struct *new_vma);
 };
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 61f72b09d990..2376f3972f13 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3434,7 +3434,7 @@ static int special_mapping_mremap(struct vm_area_struct *new_vma,
 		return -EFAULT;
 
 	if (sm->mremap)
-		return sm->mremap(sm, new_vma);
+		sm->mremap(sm, new_vma);
 
 	return 0;
 }
-- 
2.28.0


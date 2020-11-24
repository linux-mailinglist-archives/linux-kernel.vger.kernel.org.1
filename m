Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA132C1A04
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbgKXA35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729837AbgKXA3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:29:53 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E799C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:29:53 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 64so7175404wra.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XVsRCIfnrfRqNuTPjeUSzqHgSqfC4eyusfjMOiRdEhE=;
        b=NRcT6Bc322Vr74HXeazFStjtx39X3nqeFsq849Ht8QZ+ZqBChoiaY2kAo+QfnBr7za
         6cpXIJOlFGQSaLGP3QkflH2vkKyxfa6f+11l5Mhge4jghfW+XFImQBUAP/mykM6SDImU
         pK12Y9bgRqzl69ivKG/AFuiIxyejhSLBqtH2LTEGqFFSFxx0s8RtkK+C6q3SOfuX67P+
         CrR1MisLBKZ4KxFY7/x7CPruwJrHC745QVX4aeFNcY14teAMr6iLD3KGfH5nYJM52YS7
         dj1SErG09MFmjcNfeQK1Ts3yBjKfCCniFeTpk8d045YNSSknV6VBLdExscpV4cklC+2z
         BH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XVsRCIfnrfRqNuTPjeUSzqHgSqfC4eyusfjMOiRdEhE=;
        b=FJvLUN5f6YPuMHP0N1s7Kq+55cEFftiB665AtVwmZSgK+FjkumgdTCEV/CgFOQ/nXy
         ZBlRZkx6pwJlgn4hr/WjYSExgDXgQCFMB4Ic/GxlhfnxmkLrR1E52GFsvi41j6Hv7aej
         Tg8CUX9C3Laa1eofxVIW+XrrF7wvlbiH6j5xhfjmEgS6Slb+IHUgxS4lji/IDXWFI2GU
         sl6zSpDgu7kFjwGdbsetmCcaV/VaS73SQYFQFFKBzkN+RqQdAoxzGU+TKJEHnboheYGW
         1olx8TDRSmbRUALDHVb+MEwMWZHr42YoqsRbdC5QnTQON8nwrGbkf0ova1RH6dERFoYB
         EMnw==
X-Gm-Message-State: AOAM530mwKZethygAqo3C5/vnZGw4HWfhKMzntuBS3yKxwS5t7DnQHh1
        xNdfXX6kw5u8zk+r0QRaQPrfgJW9ZrbbdJ2I
X-Google-Smtp-Source: ABdhPJxAOevugGCTNJmU6H3iz0oXabQYYwcS+eyv3tNqQ1CCTXCI2D98F465Hvtq43iNKBwW8e2fQg==
X-Received: by 2002:a5d:6503:: with SMTP id x3mr2266719wru.151.1606177791610;
        Mon, 23 Nov 2020 16:29:51 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id c6sm25047360wrh.74.2020.11.23.16.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 16:29:50 -0800 (PST)
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
Subject: [PATCH v2 11/19] mm/mmap: Make vm_special_mapping::mremap return void
Date:   Tue, 24 Nov 2020 00:29:24 +0000
Message-Id: <20201124002932.1220517-12-dima@arista.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124002932.1220517-1-dima@arista.com>
References: <20201124002932.1220517-1-dima@arista.com>
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
index 65df8abd90bd..95a257927dae 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -780,7 +780,7 @@ struct vm_special_mapping {
 				struct vm_area_struct *vma,
 				struct vm_fault *vmf);
 
-	int (*mremap)(const struct vm_special_mapping *sm,
+	void (*mremap)(const struct vm_special_mapping *sm,
 		     struct vm_area_struct *new_vma);
 };
 
diff --git a/mm/mmap.c b/mm/mmap.c
index d0d458632c1b..17fe59a9780b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3433,7 +3433,7 @@ static int special_mapping_mremap(struct vm_area_struct *new_vma,
 		return -EFAULT;
 
 	if (sm->mremap)
-		return sm->mremap(sm, new_vma);
+		sm->mremap(sm, new_vma);
 
 	return 0;
 }
-- 
2.29.2


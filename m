Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CFA27948E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 01:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbgIYXN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 19:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgIYXN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 19:13:58 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A408CC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:13:57 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id k14so4183499edo.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:mime-version:date:message-id:subject:to:cc;
        bh=L+IBKxZ0QcO0B3h5t+5jOzhzbzhKa2XA+CIt/FMH1ZU=;
        b=QUvhulOg1NGwk/mf4srFts8KcoGxxZiH8tNot324c6UXUzdCnR2i74d8kyZm5AS0O+
         mKLGW/kzPRw/o6KPsbBhuMnEdRVRzMVylfNrGDc//9vOvYe5hFxlyn4l+L/gulbovgMB
         ZboS38medD690GgkrdnX3OiESGxCDtFJr2xXaUpAOGUZhVrJEgAeWUg1lNXRVdPHw1ZA
         AUcumQEefbPNtBUFZaWmYCHFj3MrwV2XjRk9WKJipjJtPXMP9Sk0IGE4PtkuY8EuGkH0
         xvYjVU8koXY2XaGs8c9EypzHVGSyCwU2WLJIKVbpim45Ku68vunua8ur7NBWbBB95be4
         Cutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to:cc;
        bh=L+IBKxZ0QcO0B3h5t+5jOzhzbzhKa2XA+CIt/FMH1ZU=;
        b=aAm3Fw3sdyjgEpYALv3ZF8nZr3vuNVV0gF/xRv65Krsur0RIWvwKsmFLtSt8rqIM+1
         4qxAVvHjfaJL21wjT4tWRzy3qjKKS9e65FlGcgQwo+fHf0Jc5YAIIjlAjDT3ma/lDq9I
         HebbXyg1m6jNxqpu22yh0NIue55jAZOhSnoSYFOA7bpxyLV/0DWmFOmi2Imgfs5/nW48
         ayD+p+D/+NjwlwBzL5NnOybT9DGRtOqYWPuw1qf4SVCmOG5PaGp39/VolZjc3+BZDUyP
         ddp4C/h0u1FdfPjJCVrgXA9QvOkM8MmUQFq1FhvT6Nk9u6JK2YEa4NLZyODNmxZ/fysT
         89kQ==
X-Gm-Message-State: AOAM5313wQ0cTFt6EvoIUG46u9l+oFMA8x+AqrHkqrg95X0ies7gxG6H
        1JiAGrcQmrZGGuXkeIRLZn5RUFjpBKeljjsSQunYqQ==
X-Google-Smtp-Source: ABdhPJwfShpjQL3TbayUPK58WzanTDcYUE/rKStFhRifVnZvS65bVakkOVt0vLIUM/TnAYUxztYRt6rzxFoPbFuqfo8=
X-Received: by 2002:a50:ccd2:: with SMTP id b18mr3904033edj.51.1601075636081;
 Fri, 25 Sep 2020 16:13:56 -0700 (PDT)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Sep 2020 16:13:55 -0700
From:   Jann Horn <jannh@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Date:   Fri, 25 Sep 2020 16:13:55 -0700
Message-ID: <CAG48ez3hxeXU29UGWRH-gRXX2jb5Lc==npbXFt8UDrWO4eHZdQ@mail.gmail.com>
Subject: [PATCH] nios2: Take mmap lock in cacheflush syscall
To:     Ley Foon Tan <ley.foon.tan@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to take the mmap lock around find_vma() and subsequent use of the
VMA. Otherwise, we can race with concurrent operations like munmap(), which
can lead to use-after-free accesses to freed VMAs.

Fixes: 1000197d8013 ("nios2: System calls handling")
Signed-off-by: Jann Horn <jannh@google.com>
---
To the maintainers:
I can't easily test this patch - I don't even have a nios2 compiler.
If you have tested this patch, you may want to add a CC stable tag to this.

 arch/nios2/kernel/sys_nios2.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/nios2/kernel/sys_nios2.c b/arch/nios2/kernel/sys_nios2.c
index cd390ec4f88b..2c8f8bd850c9 100644
--- a/arch/nios2/kernel/sys_nios2.c
+++ b/arch/nios2/kernel/sys_nios2.c
@@ -22,6 +22,7 @@ asmlinkage int sys_cacheflush(unsigned long addr,
unsigned long len,
 				unsigned int op)
 {
 	struct vm_area_struct *vma;
+	struct mm_struct *mm = current->mm;

 	if (len == 0)
 		return 0;
@@ -34,16 +35,21 @@ asmlinkage int sys_cacheflush(unsigned long addr,
unsigned long len,
 	if (addr + len < addr)
 		return -EFAULT;

+	if (mmap_read_lock_killable(mm))
+		return -EINTR;
 	/*
 	 * Verify that the specified address region actually belongs
 	 * to this process.
 	 */
-	vma = find_vma(current->mm, addr);
-	if (vma == NULL || addr < vma->vm_start || addr + len > vma->vm_end)
+	vma = find_vma(mm, addr);
+	if (vma == NULL || addr < vma->vm_start || addr + len > vma->vm_end) {
+		mmap_read_unlock();
 		return -EFAULT;
+	}

 	flush_cache_range(vma, addr, addr + len);

+	mmap_read_unlock();
 	return 0;
 }


base-commit: 6d28cf7dfede6cfca5119a0d415a6a447c68f3a0
-- 
2.28.0.681.g6f77f65b4e-goog

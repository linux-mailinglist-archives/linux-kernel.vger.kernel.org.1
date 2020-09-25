Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6941A27946A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 00:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgIYW5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 18:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgIYW5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 18:57:51 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC22C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 15:57:50 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id e23so800398eja.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 15:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:mime-version:date:message-id:subject:to:cc;
        bh=YTJqkpgJ8oGbu26zT6SqE6IfywbetOrrOLJaZFmqFLI=;
        b=HxUfyd/eapx5d9+natJZmF1OG6ii97A3mF0U2oxOdhVMVqS8P8a7nBqozCJ6gvy4aH
         6WX8ebltB7J3oiM8Lp4cRRoErs1EzN8fe/0oGNyRPGWHSYHK/MQ3bbXE8eu6FsxFek/u
         hXzwQzjyF3KTWQx2QkP3FgJf3ujEcfJryviQXuq4bz2kht1UVDIsoX6A+DuD5ZIl4ROc
         eT57/7CXn7tfDWT2R5zugAdpnopNXbDwPBk7RE049IaE/UAI4KNCNr0RK6NQQt8qj8MH
         PbrzOtvvBR7ABllsGQooitoQxONXuD24h4BCE/fM3g8U+vfViMayp39EMgBkFiw7DAz7
         ma7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to:cc;
        bh=YTJqkpgJ8oGbu26zT6SqE6IfywbetOrrOLJaZFmqFLI=;
        b=a7blGBwx7MdvUEprhHV1dW3H/PDhV7KEzh8nGWI9BZrIpTS/+kVLUu9LeQZFIxruRP
         62YC2tnGCH4HiTG/1HyxjRxthq/ImdjQLvhYxQdPUG/SkCKEyvVVbeNxqMY3gLJ5hogB
         LsSKlQgKknE95C92XE/3fmEpr+4APDO2K7JBfkmYHumD6BjGFA+YVzRwd6eno/tXGpWH
         ZPsTpCPrMgvYdep5MqgHkkRkkjEkwRHyVQNxoQoUj4lGfDnJj2G2kqpBGb4wQ4CgEZuM
         5xr0y3S2B1OxhwuWcy7hOtkg8unHc1ObAaQR4jxz/4tgZj3b80BcchGvGzGhDAShIomV
         EY0g==
X-Gm-Message-State: AOAM533lnh80Lse0mMT2l5fYLA4sjkF/q1hWIE0FYtmhBhaLIBmGNg4U
        f8gl3piQeddcNYSlqqjMry9b1iciESHOUNcYTryMqQ==
X-Google-Smtp-Source: ABdhPJwzZMwvLlbmrBUiDCYiZCqbWehbbMddoxwGMHXx99+i0Ne8EE4+NVOKVeBtzLPiYiiV8yCtpiA/p1c82yQCQJM=
X-Received: by 2002:a17:907:94cf:: with SMTP id dn15mr5168167ejc.114.1601074669251;
 Fri, 25 Sep 2020 15:57:49 -0700 (PDT)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Sep 2020 15:57:48 -0700
From:   Jann Horn <jannh@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Date:   Fri, 25 Sep 2020 15:57:48 -0700
Message-ID: <CAG48ez1UnQEMok9rqFQC4XHBaMmBe=eaedu8Z_RXdjFHTna_LA@mail.gmail.com>
Subject: [PATCH] nds32: Take mmap lock in cacheflush syscall
To:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to take the mmap lock around find_vma() and subsequent use of the
VMA. Otherwise, we can race with concurrent operations like munmap(), which
can lead to use-after-free accesses to freed VMAs.

Fixes: 1932fbe36e02 ("nds32: System calls handling")
Signed-off-by: Jann Horn <jannh@google.com>
---
To the maintainers:
I can't easily test this patch - I don't even have an nds32 compiler.
If you have tested this patch, you may want to add a CC stable tag to this.

 arch/nds32/kernel/sys_nds32.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/nds32/kernel/sys_nds32.c b/arch/nds32/kernel/sys_nds32.c
index cb2d1e219bb3..836deecea83d 100644
--- a/arch/nds32/kernel/sys_nds32.c
+++ b/arch/nds32/kernel/sys_nds32.c
@@ -28,12 +28,18 @@ SYSCALL_DEFINE4(fadvise64_64_wrapper,int, fd, int,
advice, loff_t, offset,

 SYSCALL_DEFINE3(cacheflush, unsigned int, start, unsigned int, end, int, cache)
 {
+	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	bool flushi = true, wbd = true;
+	int ret;

-	vma = find_vma(current->mm, start);
-	if (!vma)
-		return -EFAULT;
+	if (mmap_read_lock_killable(mm))
+		return -EINTR;
+	vma = find_vma(mm, start);
+	if (!vma) {
+		ret = -EFAULT;
+		goto out;
+	}
 	switch (cache) {
 	case ICACHE:
 		wbd = false;
@@ -44,11 +50,15 @@ SYSCALL_DEFINE3(cacheflush, unsigned int, start,
unsigned int, end, int, cache)
 	case BCACHE:
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 	cpu_cache_wbinval_range_check(vma, start, end, flushi, wbd);
+	ret = 0;

-	return 0;
+out:
+	mmap_read_unlock(mm);
+	return ret;
 }

 SYSCALL_DEFINE2(fp_udfiex_crtl, unsigned int, cmd, unsigned int, act)

base-commit: 6d28cf7dfede6cfca5119a0d415a6a447c68f3a0
-- 
2.28.0.681.g6f77f65b4e-goog

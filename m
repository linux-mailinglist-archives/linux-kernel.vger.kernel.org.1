Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF58B28190A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388233AbgJBRTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBRTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:19:32 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DFAC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 10:19:32 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z17so2753219lfi.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 10:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f11Np4EabR5kyo8frCO/ZNHz5Z8j1seV9AzKGqNc86k=;
        b=Q/Q4/e7p8AVkLKqFMUwWuG6tUqSA2klNHBX1Fw5WjuZ8L3rFNisQ9IsKOih+d/8wtg
         Fl4Hdtumi06e1+TDaavddHoE6LOj7dyR87ZUOAzWOFvL2SODPLQyLRShhr3HsU0gBEy9
         HWt11koNZgYPaFh1izrBBFR50NohWsnhVo+UAeMo0BMHps4UkX4O/Goe/Yvi2MQO6DkC
         IScMDHymx6kUiEhF10x7IVODm7IM9yLPVIuG3QIXEhMDNnkR0PbYYWiSyvDdakLGey5k
         +JbZmzyKD+JBL8grQjho2bfIgxNrDfsMLwtwWlgsfNR9KrsLrL286QvcpcFSUWOOKwea
         jNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f11Np4EabR5kyo8frCO/ZNHz5Z8j1seV9AzKGqNc86k=;
        b=uKKv5Q4R8/dSIZG3UfoavCEHTNJnZqcUeYeTBkE+9OU/rIctQ9q6TRStSoKi0gGSTe
         MgzGlsibYZNtueKiN1VgAiJsl25fNORVO8bAcli59CYGv67Ob+qyPZDnniWH5FR/+rBW
         jqlXh62oE1jwVnVGZa05sC90M7Yuaof3M7C5ApKZgOXZRGrqhLfj1r1mHKYIayyvCIfN
         M6jvyjzl9rHA1PthmlwaOqm+NFm8uuhwSqV5HD5bT24UrND7SB+SROqg2n3x/kcleBDk
         ezBx+lfp2pNuy4rT1BLt/x+s/4gAmC7rP6iZnOAQo4fbF5fBW2mji9aqGHqygQztAcTF
         b20A==
X-Gm-Message-State: AOAM533eQvI2vv8zn3kF9j7sNGCi0Q3DfhxbB3LFAAoTaCsm4JXFv9PR
        hPDEDmollY1PhBOqq95OODedAzUAS4E=
X-Google-Smtp-Source: ABdhPJzHtmKRCFkSaQLI/UXyy6dZxCBOVWzX5T5QEeqdtDZczqa16aYvFi+BYVgk4EZDG6GCEfJgjA==
X-Received: by 2002:ac2:4d10:: with SMTP id r16mr1135238lfi.58.1601659170679;
        Fri, 02 Oct 2020 10:19:30 -0700 (PDT)
Received: from localhost.localdomain (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id m204sm409012lfd.307.2020.10.02.10.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 10:19:30 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH] mm: optionally disable brk()
Date:   Fri,  2 Oct 2020 20:19:21 +0300
Message-Id: <20201002171921.3053-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The brk() system call allows to change data segment size (heap). This
is mainly used by glibc for memory allocation, but it can use mmap()
and that results in more randomized memory mappings since the heap is
always located at fixed offset to program while mmap()ed memory is
randomized.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 init/Kconfig    | 15 +++++++++++++++
 kernel/sys_ni.c |  2 ++
 mm/mmap.c       |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index c5ea2e694f6a..53735ac305d8 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1851,6 +1851,20 @@ config SLUB_MEMCG_SYSFS_ON
 	  controlled by slub_memcg_sysfs boot parameter and this
 	  config option determines the parameter's default value.
 
+config BRK_SYSCALL
+	bool "Enable brk() system call" if EXPERT
+	default y
+	help
+	  Enable the brk() system call that allows to change data
+	  segment size (heap). This is mainly used by glibc for memory
+	  allocation, but it can use mmap() and that results in more
+	  randomized memory mappings since the heap is always located
+	  at fixed offset to program while mmap()ed memory is
+	  randomized.
+
+	  If unsure, say Y for maximum compatibility.
+
+if BRK_SYSCALL
 config COMPAT_BRK
 	bool "Disable heap randomization"
 	default y
@@ -1862,6 +1876,7 @@ config COMPAT_BRK
 	  /proc/sys/kernel/randomize_va_space to 2 or 3.
 
 	  On non-ancient distros (post-2000 ones) N is usually a safe choice.
+endif # BRK_SYSCALL
 
 choice
 	prompt "Choose SLAB allocator"
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 4d59775ea79c..3ffa5c4002e1 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -299,6 +299,8 @@ COND_SYSCALL(recvmmsg_time32);
 COND_SYSCALL_COMPAT(recvmmsg_time32);
 COND_SYSCALL_COMPAT(recvmmsg_time64);
 
+COND_SYSCALL(brk);
+
 /*
  * Architecture specific syscalls: see further below
  */
diff --git a/mm/mmap.c b/mm/mmap.c
index 489368f43af1..653be2c8982a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -188,6 +188,7 @@ static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
 
 static int do_brk_flags(unsigned long addr, unsigned long request, unsigned long flags,
 		struct list_head *uf);
+#ifdef CONFIG_BRK_SYSCALL
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
 	unsigned long retval;
@@ -286,6 +287,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	mmap_write_unlock(mm);
 	return retval;
 }
+#endif
 
 static inline unsigned long vma_compute_gap(struct vm_area_struct *vma)
 {
-- 
2.28.0


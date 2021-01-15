Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B342F7261
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 06:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733199AbhAOFlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 00:41:47 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11016 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732057AbhAOFlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 00:41:32 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DH9430WsTzj7RG;
        Fri, 15 Jan 2021 13:39:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Fri, 15 Jan 2021 13:40:41 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        <palmerdabbelt@google.com>, Atish Patra <atish.patra@wdc.com>
CC:     Palmer Dabbelt <palmer@dabbelt.com>, <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 2/4] initramfs: Provide a common initrd reserve function
Date:   Fri, 15 Jan 2021 13:46:04 +0800
Message-ID: <20210115054606.124502-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115054606.124502-1-wangkefeng.wang@huawei.com>
References: <20210115054606.124502-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures(eg, ARM and riscv) have similar logic to
check and reserve the memory of initrd, let's provide a common
function reserve_initrd_mem() to reduce duplicated code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/initrd.h |  6 ++++++
 init/initramfs.c       | 45 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index fc30ac30e10e..85c15717af34 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -18,6 +18,12 @@ extern int initrd_below_start_ok;
 extern unsigned long initrd_start, initrd_end;
 extern void free_initrd_mem(unsigned long, unsigned long);
 
+#ifdef CONFIG_BLK_DEV_INITRD
+extern void __init reserve_initrd_mem(void);
+#else
+static inline void __init reserve_initrd_mem(void) {}
+#endif
+
 extern phys_addr_t phys_initrd_start;
 extern unsigned long phys_initrd_size;
 
diff --git a/init/initramfs.c b/init/initramfs.c
index 55b74d7e5260..f75c89e9d602 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -535,6 +535,51 @@ extern unsigned long __initramfs_size;
 #include <linux/initrd.h>
 #include <linux/kexec.h>
 
+void __init reserve_initrd_mem(void)
+{
+	phys_addr_t start;
+	unsigned long size;
+
+	/* Ignore the virtul address computed during device tree parsing */
+	initrd_start = initrd_end = 0;
+
+	if (!phys_initrd_size)
+		return;
+	/*
+	 * Round the memory region to page boundaries as per free_initrd_mem()
+	 * This allows us to detect whether the pages overlapping the initrd
+	 * are in use, but more importantly, reserves the entire set of pages
+	 * as we don't want these pages allocated for other purposes.
+	 */
+	start = round_down(phys_initrd_start, PAGE_SIZE);
+	size = phys_initrd_size + (phys_initrd_start - start);
+	size = round_up(size, PAGE_SIZE);
+
+	if (!memblock_is_region_memory(start, size)) {
+		pr_err("INITRD: 0x%08llx+0x%08lx is not a memory region",
+		       (u64)start, size);
+		goto disable;
+	}
+
+	if (memblock_is_region_reserved(start, size)) {
+		pr_err("INITRD: 0x%08llx+0x%08lx overlaps in-use memory region\n",
+		       (u64)start, size);
+		goto disable;
+	}
+
+	memblock_reserve(start, size);
+	/* Now convert initrd to virtual addresses */
+	initrd_start = (unsigned long)__va(phys_initrd_start);
+	initrd_end = initrd_start + phys_initrd_size;
+	initrd_below_start_ok = 1;
+
+	return;
+disable:
+	pr_cont(" - disabling initrd\n");
+	initrd_start = 0;
+	initrd_end = 0;
+}
+
 void __weak __init free_initrd_mem(unsigned long start, unsigned long end)
 {
 #ifdef CONFIG_ARCH_KEEP_MEMBLOCK
-- 
2.26.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5962A140C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 08:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgJaHje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 03:39:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6684 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgJaHjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 03:39:17 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CNWJz4PxRz15PPG;
        Sat, 31 Oct 2020 15:39:15 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 31 Oct 2020 15:39:07 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <dyoung@redhat.com>,
        <bhe@redhat.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <corbet@lwn.net>, <John.P.donnelly@oracle.com>,
        <bhsharma@redhat.com>, <prabhakar.pkin@gmail.com>
CC:     <horms@verge.net.au>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <nsaenzjulienne@suse.de>, <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <chenzhou10@huawei.com>, <xiexiuqi@huawei.com>,
        <guohanjun@huawei.com>, <huawei.libin@huawei.com>,
        <wangkefeng.wang@huawei.com>,
        John Donnelly <John.p.donnelly@oracle.com>
Subject: [PATCH v13 8/8] kdump: update Documentation about crashkernel
Date:   Sat, 31 Oct 2020 15:44:37 +0800
Message-ID: <20201031074437.168008-9-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201031074437.168008-1-chenzhou10@huawei.com>
References: <20201031074437.168008-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For arm64, the behavior of crashkernel=X has been changed, which
tries low allocation in DMA zone or DMA32 zone if CONFIG_ZONE_DMA
is disabled, and fall back to high allocation if it fails.

We can also use "crashkernel=X,high" to select a high region above
DMA zone, which also tries to allocate at least 256M low memory in
DMA zone automatically (or the DMA32 zone if CONFIG_ZONE_DMA is disabled).

"crashkernel=Y,low" can be used to allocate specified size low memory.

So update the Documentation.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Tested-by: John Donnelly <John.p.donnelly@oracle.com>
---
 Documentation/admin-guide/kdump/kdump.rst     | 23 ++++++++++++++++---
 .../admin-guide/kernel-parameters.txt         | 12 ++++++++--
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 75a9dd98e76e..bde5f994d185 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -299,7 +299,16 @@ Boot into System Kernel
    "crashkernel=64M@16M" tells the system kernel to reserve 64 MB of memory
    starting at physical address 0x01000000 (16MB) for the dump-capture kernel.
 
-   On x86 and x86_64, use "crashkernel=64M@16M".
+   On x86 use "crashkernel=64M@16M".
+
+   On x86_64, use "crashkernel=X" to select a region under 4G first, and
+   fall back to reserve region above 4G. And go for high allocation
+   directly if the required size is too large.
+   We can also use "crashkernel=X,high" to select a region above 4G, which
+   also tries to allocate at least 256M below 4G automatically and
+   "crashkernel=Y,low" can be used to allocate specified size low memory.
+   Use "crashkernel=Y@X" if you really have to reserve memory from specified
+   start address X.
 
    On ppc64, use "crashkernel=128M@32M".
 
@@ -316,8 +325,16 @@ Boot into System Kernel
    kernel will automatically locate the crash kernel image within the
    first 512MB of RAM if X is not given.
 
-   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
-   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
+   On arm64, use "crashkernel=X" to try low allocation in DMA zone (or
+   DMA32 zone if CONFIG_ZONE_DMA is disabled), and fall back to high
+   allocation if it fails.
+   We can also use "crashkernel=X,high" to select a high region above
+   DMA zone, which also tries to allocate at least 256M low memory in
+   DMA zone automatically (or the DMA32 zone if CONFIG_ZONE_DMA is disabled).
+   "crashkernel=Y,low" can be used to allocate specified size low memory.
+   Use "crashkernel=Y@X" if you really have to reserve memory from
+   specified start address X. Note that the start address of the kernel,
+   X if explicitly specified, must be aligned to 2MiB (0x200000).
 
 Load the Dump-capture Kernel
 ============================
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 526d65d8573a..b2955d9379e8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -738,6 +738,9 @@
 			[KNL, X86-64] Select a region under 4G first, and
 			fall back to reserve region above 4G when '@offset'
 			hasn't been specified.
+			[KNL, arm64] Try low allocation in DMA zone (or DMA32 zone
+			if CONFIG_ZONE_DMA is disabled), fall back to high allocation
+			if it fails when '@offset' hasn't been specified.
 			See Documentation/admin-guide/kdump/kdump.rst for further details.
 
 	crashkernel=range1:size1[,range2:size2,...][@offset]
@@ -754,6 +757,8 @@
 			Otherwise memory region will be allocated below 4G, if
 			available.
 			It will be ignored if crashkernel=X is specified.
+			[KNL, arm64] range in high memory.
+			Allow kernel to allocate physical memory region from top.
 	crashkernel=size[KMG],low
 			[KNL, X86-64] range under 4G. When crashkernel=X,high
 			is passed, kernel could allocate physical memory region
@@ -762,13 +767,16 @@
 			requires at least 64M+32K low memory, also enough extra
 			low memory is needed to make sure DMA buffers for 32-bit
 			devices won't run out. Kernel would try to allocate at
-			at least 256M below 4G automatically.
+			least 256M below 4G automatically.
 			This one let user to specify own low range under 4G
 			for second kernel instead.
 			0: to disable low allocation.
 			It will be ignored when crashkernel=X,high is not used
 			or memory reserved is below 4G.
-
+			[KNL, arm64] range in low memory.
+			This one let user to specify a low range in DMA zone for
+			crash dump kernel (or the DMA32 zone if CONFIG_ZONE_DMA
+			is disabled).
 	cryptomgr.notests
 			[KNL] Disable crypto self-tests
 
-- 
2.20.1


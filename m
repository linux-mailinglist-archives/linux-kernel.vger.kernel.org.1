Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D712FC28F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404211AbhASRwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:52:07 -0500
Received: from m12-11.163.com ([220.181.12.11]:51600 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391524AbhASOv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=zRHOb2PfEh1w+OV/Fv
        PiPRQrZc0sHezKYe+j3QOylIg=; b=jQxEpBilipjA5g6kI/YEeKlUyMm7Gym8R4
        d/QAuaAAxPSLFa7xJ/ZcF8zbcLAHy5NGW5vTKlwlHrj6rclgvyuDNRKGuQ+Wrbfb
        LULln1UKAF8TsOWoGZqcnDa2fYXCXq/q7bC/FbEaRirxoOPxO81E3uGrGuwkgB0Q
        VhFUV8Wpw=
Received: from localhost.localdomain (unknown [223.87.231.20])
        by smtp7 (Coremail) with SMTP id C8CowACXdNTZ2gZg8tlVJg--.38522S2;
        Tue, 19 Jan 2021 21:12:58 +0800 (CST)
From:   Hailong liu <carver4lio@163.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hailong Liu <liu.hailong6@zte.com.cn>
Subject: [PATCH 6/6] arm/mm/ptdump:Add address markers for KASAN regions
Date:   Tue, 19 Jan 2021 21:12:28 +0800
Message-Id: <20210119131228.8162-1-carver4lio@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: C8CowACXdNTZ2gZg8tlVJg--.38522S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1kXF4fKFy5JrWxXryrJFb_yoW8WF4xpr
        9xAr9xurW8J3W7XayjkrsFqryYkr4DZFZrZr429w4YyF15AFyIqF1Ik34fA3y2qFWrJr4r
        uFnYyryYqF4DXw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joFALUUUUU=
X-Originating-IP: [223.87.231.20]
X-CM-SenderInfo: xfdu4v3uuox0i6rwjhhfrp/xtbCCwQfnV3Le1O3CAABsN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hailong Liu <liu.hailong6@zte.com.cn>

ARM has recently supported KASAN, so I think that it's time to add KASAN
regions for PTDUMP on ARM.

I have tested this patch with QEMU + vexpress-a15. Both CONFIG_ARM_LPAE
and no CONFIG_ARM_LPAE.

The result after patching looks like this:
1 CONFIG_ARM_LPAE=y
---[ Kasan shadow start ]---
0x6ee00000-0x7af00000         193M     RW NX SHD MEM/CACHED/WBWA
0x7b000000-0x7f000000          64M     ro NX SHD MEM/CACHED/WBWA
---[ Kasan shadow end ]---
---[ Modules ]---
---[ Kernel Mapping ]---
......
---[ vmalloc() Area ]---
......
---[ vmalloc() End ]---
---[ Fixmap Area ]---
---[ Vectors ]---
......
---[ Vectors End ]---

Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
---
 arch/arm/mm/dump.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
index c18d23a5e5f1..93ff0097f00b 100644
--- a/arch/arm/mm/dump.c
+++ b/arch/arm/mm/dump.c
@@ -19,6 +19,10 @@
 #include <asm/ptdump.h>
 
 static struct addr_marker address_markers[] = {
+#ifdef CONFIG_KASAN
+	{ KASAN_SHADOW_START,	"Kasan shadow start"},
+	{ KASAN_SHADOW_END,	"Kasan shadow end"},
+#endif
 	{ MODULES_VADDR,	"Modules" },
 	{ PAGE_OFFSET,		"Kernel Mapping" },
 	{ 0,			"vmalloc() Area" },
@@ -429,8 +433,11 @@ static void ptdump_initialize(void)
 				if (pg_level[i].bits[j].nx_bit)
 					pg_level[i].nx_bit = &pg_level[i].bits[j];
 			}
-
+#ifdef CONFIG_KASAN
+	address_markers[4].start_address = VMALLOC_START;
+#else
 	address_markers[2].start_address = VMALLOC_START;
+#endif
 }
 
 static struct ptdump_info kernel_ptdump_info = {
-- 
2.17.1


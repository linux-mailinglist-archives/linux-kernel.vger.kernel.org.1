Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDEF2FD42D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 16:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbhATPfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 10:35:37 -0500
Received: from m12-18.163.com ([220.181.12.18]:42555 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390900AbhATPex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=WcGGIHmekyaog93XsE
        BBCUmq5nOTA4s3EjGiGY44s40=; b=kXA+RBCWydYS60FKAZ2qTbkz5VnNC97lt+
        u7Fvow5iOm+ArcmHypkJyl4Wjaoc3XHti7RCoSzF02td8+6724leXiJIVQpNlvh6
        +8OYy43y9vA/otvtI2n3sawT1m4FLxeSxhJnVG59rxX+syiUpKpwhJoUpN0ZQ3Sm
        hvoCQ6yK8=
Received: from localhost.localdomain (unknown [223.87.231.20])
        by smtp14 (Coremail) with SMTP id EsCowAAHDwNlJwhgl1Z_QA--.23708S2;
        Wed, 20 Jan 2021 20:51:50 +0800 (CST)
From:   Hailong liu <carver4lio@163.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Hailong Liu <liu.hailong6@zte.com.cn>
Subject: [RESEND PATCH v2] arm/mm/ptdump:Add address markers for KASAN regions
Date:   Wed, 20 Jan 2021 20:50:10 +0800
Message-Id: <20210120125010.10896-1-carver4lio@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EsCowAAHDwNlJwhgl1Z_QA--.23708S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1kXF4fCFWxAw1DJFWkWFg_yoW8Ww4kpr
        nxAry3urWrA3W7XayjkrsrtryYkr4DZa9rZr42gw4YyFy5AFyIqF4IkaySy3y2qFWrJw4r
        uFnayryYqF4DJw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jTSoXUUUUU=
X-Originating-IP: [223.87.231.20]
X-CM-SenderInfo: xfdu4v3uuox0i6rwjhhfrp/xtbCCw4gnV3Le2RxvgAAs+
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hailong Liu <liu.hailong6@zte.com.cn>

ARM has recently supported KASAN, so I think that it's time to add KASAN
regions for PTDUMP on ARM.

I have tested this patch with QEMU + vexpress-a15. Both CONFIG_ARM_LPAE
and no CONFIG_ARM_LPAE.

The result after patching looks like this:
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

v2:
- fix the puzzling subject and the description due to my
carelessness.

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



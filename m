Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7DA2C2990
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389040AbgKXO1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:27:37 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7980 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389036AbgKXO1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:27:37 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CgRDV1ZXjzhY2g;
        Tue, 24 Nov 2020 22:27:06 +0800 (CST)
Received: from DESKTOP-8N3QUD5.china.huawei.com (10.67.101.227) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 24 Nov 2020 22:27:12 +0800
From:   Guohua Zhong <zhongguohua1@huawei.com>
To:     <lkp@intel.com>
CC:     <joern@lazybastard.org>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <miquel.raynal@bootlin.com>, <nixiaoming@huawei.com>,
        <patrick@baymotion.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <wangle6@huawei.com>, <young.liuyang@huawei.com>,
        <zhongguohua1@huawei.com>
Subject: [PATCH] phram: Allow the user to set the erase page size.
Date:   Tue, 24 Nov 2020 22:27:11 +0800
Message-ID: <20201124142711.28716-1-zhongguohua1@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <202011241612.Ib9Nt9Ln-lkp@intel.com>
References: <202011241612.Ib9Nt9Ln-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.101.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Permit the user to specify the erase page size as a parameter.
This solves two problems:

- phram can access images made by mkfs.jffs2.  mkfs.jffs2 won't
create images with erase sizes less than 8KiB; many architectures
define PAGE_SIZE as 4KiB.

- Allows more effective use of small capacity devices.  JFFS2
needs somewhere between 2 and 5 empty pages for garbage collection;
and for an NVRAM part with only 32KiB of space, a smaller erase page
allows much better utilization in applications where garbage collection
is important.

Signed-off-by: Patrick O'Grady <patrick@baymotion.com>
Reviewed-by: Joern Engel <joern@logfs.org>
Link: https://lore.kernel.org/lkml/CAJ7m5OqYv_=JB9NhHsqBsa8YU0DFRoP7C+W10PY22wonAGJK=A@mail.gmail.com/
[Guohua Zhong: fix token array index out of bounds and update patch for kernel master branch]
Signed-off-by: Guohua Zhong <zhongguohua1@huawei.com>
---
 drivers/mtd/devices/phram.c | 52 +++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
index 087b5e86d1bf..1729b94b2abf 100644
--- a/drivers/mtd/devices/phram.c
+++ b/drivers/mtd/devices/phram.c
@@ -6,14 +6,14 @@
  * Usage:
  *
  * one commend line parameter per device, each in the form:
- *   phram=<name>,<start>,<len>
+ *   phram=<name>,<start>,<len>[,<erasesize>]
  * <name> may be up to 63 characters.
- * <start> and <len> can be octal, decimal or hexadecimal.  If followed
+ * <start>, <len>, and <erasesize> can be octal, decimal or hexadecimal.  If followed
  * by "ki", "Mi" or "Gi", the numbers will be interpreted as kilo, mega or
- * gigabytes.
+ * gigabytes. <erasesize> is optional and defaults to PAGE_SIZE.
  *
  * Example:
- *	phram=swap,64Mi,128Mi phram=test,900Mi,1Mi
+ *	phram=swap,64Mi,128Mi phram=test,900Mi,1Mi,64Ki
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -26,6 +26,7 @@
 #include <linux/moduleparam.h>
 #include <linux/slab.h>
 #include <linux/mtd/mtd.h>
+#include <asm/div64.h>
 
 struct phram_mtd_list {
 	struct mtd_info mtd;
@@ -88,7 +89,7 @@ static void unregister_devices(void)
 	}
 }
 
-static int register_device(char *name, phys_addr_t start, size_t len)
+static int register_device(char *name, phys_addr_t start, size_t len, uint32_t erasesize)
 {
 	struct phram_mtd_list *new;
 	int ret = -ENOMEM;
@@ -115,7 +116,7 @@ static int register_device(char *name, phys_addr_t start, size_t len)
 	new->mtd._write = phram_write;
 	new->mtd.owner = THIS_MODULE;
 	new->mtd.type = MTD_RAM;
-	new->mtd.erasesize = PAGE_SIZE;
+	new->mtd.erasesize = erasesize;
 	new->mtd.writesize = 1;
 
 	ret = -EAGAIN;
@@ -204,22 +205,23 @@ static inline void kill_final_newline(char *str)
 static int phram_init_called;
 /*
  * This shall contain the module parameter if any. It is of the form:
- * - phram=<device>,<address>,<size> for module case
- * - phram.phram=<device>,<address>,<size> for built-in case
- * We leave 64 bytes for the device name, 20 for the address and 20 for the
- * size.
- * Example: phram.phram=rootfs,0xa0000000,512Mi
+ * - phram=<device>,<address>,<size>[,<erasesize>] for module case
+ * - phram.phram=<device>,<address>,<size>[,<erasesize>] for built-in case
+ * We leave 64 bytes for the device name, 20 for the address , 20 for the
+ * size and 20 for the erasesize.
+ * Example: phram.phram=rootfs,0xa0000000,512Mi,65536
  */
-static char phram_paramline[64 + 20 + 20];
+static char phram_paramline[64 + 20 + 20 + 20];
 #endif
 
 static int phram_setup(const char *val)
 {
-	char buf[64 + 20 + 20], *str = buf;
-	char *token[3];
+	char buf[64 + 20 + 20 + 20], *str = buf;
+	char *token[4];
 	char *name;
 	uint64_t start;
 	uint64_t len;
+	uint64_t erasesize = PAGE_SIZE;
 	int i, ret;
 
 	if (strnlen(val, sizeof(buf)) >= sizeof(buf))
@@ -228,7 +230,7 @@ static int phram_setup(const char *val)
 	strcpy(str, val);
 	kill_final_newline(str);
 
-	for (i = 0; i < 3; i++)
+	for (i = 0; i < 4; i++)
 		token[i] = strsep(&str, ",");
 
 	if (str)
@@ -253,11 +255,25 @@ static int phram_setup(const char *val)
 		goto error;
 	}
 
-	ret = register_device(name, start, len);
+	if (token[3]) {
+		ret = parse_num64(&erasesize, token[3]);
+		if (ret) {
+			parse_err("illegal erasesize\n");
+			goto error;
+		}
+	}
+
+	if (len == 0 || erasesize == 0 || erasesize > len
+	    || erasesize > UINT_MAX || do_div(len, (uint32_t)erasesize) != 0) {
+		parse_err("illegal erasesize or len\n");
+		goto error;
+	}
+
+	ret = register_device(name, start, len, (uint32_t)erasesize);
 	if (ret)
 		goto error;
 
-	pr_info("%s device: %#llx at %#llx\n", name, len, start);
+	pr_info("%s device: %#llx at %#llx for erasesize %#llx\n", name, len, start, erasesize);
 	return 0;
 
 error:
@@ -298,7 +314,7 @@ static int phram_param_call(const char *val, const struct kernel_param *kp)
 }
 
 module_param_call(phram, phram_param_call, NULL, NULL, 0200);
-MODULE_PARM_DESC(phram, "Memory region to map. \"phram=<name>,<start>,<length>\"");
+MODULE_PARM_DESC(phram, "Memory region to map. \"phram=<name>,<start>,<length>[,<erasesize>]\"");
 
 
 static int __init init_phram(void)
-- 
2.12.3


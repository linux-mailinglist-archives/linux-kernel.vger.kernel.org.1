Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E49B2790DC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 20:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgIYSjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 14:39:05 -0400
Received: from m12-15.163.com ([220.181.12.15]:48754 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbgIYSjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 14:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=QyxXF
        vM0apX/hfN8xhdDiavcUL+dbBENIYuDPC48tb8=; b=T4YlAJrcUPhI9IESDot6X
        ULpCWEquJOW5WVQ8Kg02ZF/3ajidZ2y6Zk6ITSVDrQRFi6Z+zywgGttqbpCuCevs
        KAy2CNCVBm7XgSpw7eAGSQkWbPLTXhWF12igxe99L3+1zLZE//WIxtF2TAWU6xJl
        nYnZNKglF6xHdF7Enh3MGk=
Received: from localhost (unknown [101.86.214.224])
        by smtp11 (Coremail) with SMTP id D8CowACH4aPpOG5f04wxDw--.53071S2;
        Sat, 26 Sep 2020 02:37:29 +0800 (CST)
Date:   Sat, 26 Sep 2020 02:37:29 +0800
From:   Hui Su <sh_def@163.com>
To:     catalin.marinas@arm.com, corbet@lwn.net, akpm@linux-foundation.org,
        mchehab+huawei@kernel.org, davem@davemloft.net, robh@kernel.org,
        yamada.masahiro@socionext.com, sam@ravnborg.org,
        jpoimboe@redhat.com, rostedt@goodmis.org,
        miguel.ojeda.sandonis@gmail.com, divya.indi@oracle.com,
        sh_def@163.com, tomas.winkler@intel.com, dhowells@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm,kmemleak-test.c: move kmemleak-test.c to samples dir
Message-ID: <20200925183729.GA172837@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: D8CowACH4aPpOG5f04wxDw--.53071S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr45Kw1xAw43Cr1xWF4kWFg_yoWrJr13pr
        4Fvr1ftrn7Ar1UW3y8tFyrGryUtwn7WFnruFWrZw4UXF9rXw18ZrsIk3y2yay3JayxWFWf
        Gas7KFy7Cr1rJ3JanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwID7UUUUU=
X-Originating-IP: [101.86.214.224]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiJgmqX1v2eVoAzwAAsb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemleak-test.c is just a kmemleak test module, which
also can not be used as a built-in kernel module.
Thus, i think it may should not be in mm dir, and move
the kmemleak-test.c to samples/kmemleak/kmemleak-test.c.
Fix the spelling of built-in by the way.

Signed-off-by: Hui Su <sh_def@163.com>
---
 Documentation/dev-tools/kmemleak.rst     | 2 +-
 MAINTAINERS                              | 2 +-
 mm/Makefile                              | 1 -
 samples/Makefile                         | 1 +
 samples/kmemleak/Makefile                | 3 +++
 {mm => samples/kmemleak}/kmemleak-test.c | 2 +-
 6 files changed, 7 insertions(+), 4 deletions(-)
 create mode 100644 samples/kmemleak/Makefile
 rename {mm => samples/kmemleak}/kmemleak-test.c (98%)

diff --git a/Documentation/dev-tools/kmemleak.rst b/Documentation/dev-tools/kmemleak.rst
index a41a2d238af2..1c935f41cd3a 100644
--- a/Documentation/dev-tools/kmemleak.rst
+++ b/Documentation/dev-tools/kmemleak.rst
@@ -229,7 +229,7 @@ Testing with kmemleak-test
 
 To check if you have all set up to use kmemleak, you can use the kmemleak-test
 module, a module that deliberately leaks memory. Set CONFIG_DEBUG_KMEMLEAK_TEST
-as module (it can't be used as bult-in) and boot the kernel with kmemleak
+as module (it can't be used as built-in) and boot the kernel with kmemleak
 enabled. Load the module and perform a scan with::
 
         # modprobe kmemleak-test
diff --git a/MAINTAINERS b/MAINTAINERS
index 190c7fa2ea01..8172787535fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9712,8 +9712,8 @@ M:	Catalin Marinas <catalin.marinas@arm.com>
 S:	Maintained
 F:	Documentation/dev-tools/kmemleak.rst
 F:	include/linux/kmemleak.h
-F:	mm/kmemleak-test.c
 F:	mm/kmemleak.c
+F:	samples/kmemleak/kmemleak-test.c
 
 KMOD KERNEL MODULE LOADER - USERMODE HELPER
 M:	Luis Chamberlain <mcgrof@kernel.org>
diff --git a/mm/Makefile b/mm/Makefile
index d5649f1c12c0..d73aed0fc99c 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -94,7 +94,6 @@ obj-$(CONFIG_GUP_BENCHMARK) += gup_benchmark.o
 obj-$(CONFIG_MEMORY_FAILURE) += memory-failure.o
 obj-$(CONFIG_HWPOISON_INJECT) += hwpoison-inject.o
 obj-$(CONFIG_DEBUG_KMEMLEAK) += kmemleak.o
-obj-$(CONFIG_DEBUG_KMEMLEAK_TEST) += kmemleak-test.o
 obj-$(CONFIG_DEBUG_RODATA_TEST) += rodata_test.o
 obj-$(CONFIG_DEBUG_VM_PGTABLE) += debug_vm_pgtable.o
 obj-$(CONFIG_PAGE_OWNER) += page_owner.o
diff --git a/samples/Makefile b/samples/Makefile
index 754553597581..c3392a595e4b 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -28,3 +28,4 @@ subdir-$(CONFIG_SAMPLE_VFS)		+= vfs
 obj-$(CONFIG_SAMPLE_INTEL_MEI)		+= mei/
 subdir-$(CONFIG_SAMPLE_WATCHDOG)	+= watchdog
 subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)	+= watch_queue
+obj-$(CONFIG_DEBUG_KMEMLEAK_TEST)	+= kmemleak/
diff --git a/samples/kmemleak/Makefile b/samples/kmemleak/Makefile
new file mode 100644
index 000000000000..16b6132c540c
--- /dev/null
+++ b/samples/kmemleak/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_DEBUG_KMEMLEAK_TEST) += kmemleak-test.o
diff --git a/mm/kmemleak-test.c b/samples/kmemleak/kmemleak-test.c
similarity index 98%
rename from mm/kmemleak-test.c
rename to samples/kmemleak/kmemleak-test.c
index e19279ff6aa3..7b476eb8285f 100644
--- a/mm/kmemleak-test.c
+++ b/samples/kmemleak/kmemleak-test.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * mm/kmemleak-test.c
+ * samples/kmemleak/kmemleak-test.c
  *
  * Copyright (C) 2008 ARM Limited
  * Written by Catalin Marinas <catalin.marinas@arm.com>
-- 
2.25.1



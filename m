Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B64029EAB6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgJ2Ldo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:33:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:57036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgJ2LcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:32:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5BBB1AF73;
        Thu, 29 Oct 2020 11:32:23 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 03/17] vt: keyboard, sort includes
Date:   Thu, 29 Oct 2020 12:32:08 +0100
Message-Id: <20201029113222.32640-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201029113222.32640-1-jslaby@suse.cz>
References: <20201029113222.32640-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many includes and it is hard to check if something is there or
not. So sort them alphabetically.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/keyboard.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 275093a15564..9e45feb15a3e 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -26,27 +26,26 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/consolemap.h>
-#include <linux/module.h>
-#include <linux/sched/signal.h>
-#include <linux/sched/debug.h>
-#include <linux/tty.h>
-#include <linux/tty_flip.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/jiffies.h>
+#include <linux/kbd_diacr.h>
+#include <linux/kbd_kern.h>
+#include <linux/leds.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/nospec.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/sched/debug.h>
+#include <linux/sched/signal.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/leds.h>
-
-#include <linux/kbd_kern.h>
-#include <linux/kbd_diacr.h>
-#include <linux/vt_kern.h>
-#include <linux/input.h>
-#include <linux/reboot.h>
-#include <linux/notifier.h>
-#include <linux/jiffies.h>
+#include <linux/tty_flip.h>
+#include <linux/tty.h>
 #include <linux/uaccess.h>
+#include <linux/vt_kern.h>
 
 #include <asm/irq_regs.h>
 
-- 
2.29.1


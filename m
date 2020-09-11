Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15B426656D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgIKRCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:02:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:20337 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbgIKRCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 13:02:17 -0400
IronPort-SDR: kG/TI9bj2zn/VIJeWDO99kYqNN+2bynWDPNTRN1vj94acUl8mKau/+lNa4YkxyFjb/3Ldl5A9v
 /hZ9xf7xeTbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="146498577"
X-IronPort-AV: E=Sophos;i="5.76,416,1592895600"; 
   d="scan'208";a="146498577"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 10:02:06 -0700
IronPort-SDR: vh4+am3jvD02ZmCgMhNvAZqXdtgsl9B9g0pE1buw3RJEzOntlOYiz9/mEWqaidP8/SMlujYecw
 DM6AnNH3O9cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,416,1592895600"; 
   d="scan'208";a="450050159"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 11 Sep 2020 10:02:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 74B1115C; Fri, 11 Sep 2020 20:02:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] kernel.h: Move oops_in_progress to printk.h
Date:   Fri, 11 Sep 2020 20:02:02 +0300
Message-Id: <20200911170202.8565-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The oops_in_progress is defined in printk.c, so it's logical
to move oops_in_progress to printk.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/debug_locks.h | 2 +-
 include/linux/kernel.h      | 1 -
 include/linux/printk.h      | 2 ++
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/debug_locks.h b/include/linux/debug_locks.h
index e7e45f0cc7da..2915f56ad421 100644
--- a/include/linux/debug_locks.h
+++ b/include/linux/debug_locks.h
@@ -2,9 +2,9 @@
 #ifndef __LINUX_DEBUG_LOCKING_H
 #define __LINUX_DEBUG_LOCKING_H
 
-#include <linux/kernel.h>
 #include <linux/atomic.h>
 #include <linux/bug.h>
+#include <linux/printk.h>
 
 struct task_struct;
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 6a4e875f198e..dc249ed1a3d5 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -526,7 +526,6 @@ extern unsigned int sysctl_oops_all_cpu_backtrace;
 #endif /* CONFIG_SMP */
 
 extern void bust_spinlocks(int yes);
-extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 extern int panic_timeout;
 extern unsigned long panic_print;
 extern int panic_on_oops;
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 34c1a7be3e01..f749a2c2e7a5 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -12,6 +12,8 @@
 extern const char linux_banner[];
 extern const char linux_proc_banner[];
 
+extern int oops_in_progress;	/* If set, an oops, panic(), BUG() or die() is in progress */
+
 #define PRINTK_MAX_SINGLE_HEADER_LEN 2
 
 static inline int printk_get_level(const char *buffer)
-- 
2.28.0


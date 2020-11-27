Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB782C6A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbgK0RAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730675AbgK0RAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:00:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01202C0613D1;
        Fri, 27 Nov 2020 09:00:00 -0800 (PST)
Date:   Fri, 27 Nov 2020 17:59:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606496398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=RFkjTP9QzRKQlpwVItvBbIws3yHer7rpZ/roaXq7NEM=;
        b=sX4HGBbDIqvtI8XgQWvXoNXDcfwRCD8FS2nz2xOltQtOxrCopgxPmcHxmIiLZLB7k9d/OK
        GyD4L3Ym5wHY91QGt00yBANHGDywcMNYcnv19qv4PoHs2nzVp/Czva03V8JwR9X69IhEYE
        bcTE7bAtZ38W9GsFwMmoHzL4Rur0q61A/HiGRWXy4roGXnh62DvR3mIiiuyR9fL6XMuaeT
        3RBhm2A6NiohpQ8rX7OsW6StRHXENCEWn1CFBRfppQqfebHeUhVFchyieU+Crv+qAswUj0
        Y9un1KPRHCHMgsvJVfIX363KQYzD2DKkQc6JE5O/v/Gnjm6TX6rdgVx9/HgOow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606496398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=RFkjTP9QzRKQlpwVItvBbIws3yHer7rpZ/roaXq7NEM=;
        b=jaWtljdH/F13UlFLr6YQfT9dDv7TL6EwyzTgt1KYTXoehhGKeBv/ZhyW6BfKmbLQQUc+H6
        jhMAshCp3pKNxkAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.10-rc5-rt11
Message-ID: <20201127165957.eukejthckysmjk76@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.10-rc5-rt11 patch set. 

Changes since v5.10-rc5-rt10:

  - The workaround for the IMX clock driver failure has been replaced
    with a another patch which was proposed upstream.

  - Tweak the rtmutex patches to build a allnoconfig with RT enabled.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.10-rc5-rt10 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10-rc5-rt10-rt11.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.10-rc5-rt11

The RT patch against v5.10-rc5 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10-rc5-rt11.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patches-5.10-rc5-rt11.tar.xz

Sebastian
diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 3b393cb072951..dbacdd70af2e1 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -5,7 +5,7 @@ config MXC_CLK
 	depends on ARCH_MXC || COMPILE_TEST
 
 config MXC_CLK_SCU
-	tristate "IMX SCU clock"
+	tristate
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on IMX_SCU && HAVE_ARM_SMCCC
 
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index b8bf9460c91d7..dd6a737d060b4 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -26,9 +26,9 @@ obj-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
 obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o
 obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
 
-obj-$(CONFIG_MXC_CLK_SCU)	+= clk-imx-scu.o
-clk-imx-scu-y			:= clk-scu.o clk-lpcg-scu.o
-obj-$(CONFIG_CLK_IMX8QXP)	+= clk-imx8qxp.o clk-imx8qxp-lpcg.o
+obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o
+clk-imx-scu-$(CONFIG_CLK_IMX8QXP) += clk-scu.o clk-imx8qxp.o
+clk-imx-lpcg-scu-$(CONFIG_CLK_IMX8QXP) += clk-lpcg-scu.o clk-imx8qxp-lpcg.o
 
 obj-$(CONFIG_CLK_IMX1)   += clk-imx1.o
 obj-$(CONFIG_CLK_IMX25)  += clk-imx25.o
diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
index 336dce43da82d..1f0e44f921aee 100644
--- a/drivers/clk/imx/clk-lpcg-scu.c
+++ b/drivers/clk/imx/clk-lpcg-scu.c
@@ -115,4 +115,3 @@ struct clk_hw *imx_clk_lpcg_scu(const char *name, const char *parent_name,
 
 	return hw;
 }
-EXPORT_SYMBOL_GPL(imx_clk_lpcg_scu);
diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index 026a33606ae53..b8b2072742a56 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -9,7 +9,6 @@
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/slab.h>
-#include <linux/module.h>
 
 #include "clk-scu.h"
 
@@ -133,7 +132,6 @@ int imx_clk_scu_init(void)
 {
 	return imx_scu_get_handle(&ccm_ipc_handle);
 }
-EXPORT_SYMBOL_GPL(imx_clk_scu_init);
 
 /*
  * clk_scu_recalc_rate - Get clock rate for a SCU clock
@@ -389,5 +387,3 @@ struct clk_hw *__imx_clk_scu(const char *name, const char * const *parents,
 
 	return hw;
 }
-EXPORT_SYMBOL_GPL(__imx_clk_scu);
-MODULE_LICENSE("GPL");
diff --git a/include/linux/spinlock_types_up.h b/include/linux/spinlock_types_up.h
index b0243ba07fb78..d9b371fa13e09 100644
--- a/include/linux/spinlock_types_up.h
+++ b/include/linux/spinlock_types_up.h
@@ -1,6 +1,10 @@
 #ifndef __LINUX_SPINLOCK_TYPES_UP_H
 #define __LINUX_SPINLOCK_TYPES_UP_H
 
+#if !defined(__LINUX_SPINLOCK_TYPES_H) && !defined(__LINUX_RT_MUTEX_H)
+# error "please don't include this file directly"
+#endif
+
 /*
  * include/linux/spinlock_types_up.h - spinlock type definitions for UP
  *
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index c1203c14fee92..b5cd1e278eb58 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -65,6 +65,7 @@ config PREEMPT_RT
 	bool "Fully Preemptible Kernel (Real-Time)"
 	depends on EXPERT && ARCH_SUPPORTS_RT
 	select PREEMPTION
+	select RT_MUTEXES
 	help
 	  This option turns the kernel into a real-time kernel by replacing
 	  various locking primitives (spinlocks, rwlocks, etc.) with
diff --git a/localversion-rt b/localversion-rt
index d79dde624aaac..05c35cb580779 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt10
+-rt11

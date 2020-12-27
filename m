Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0372E308F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 10:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgL0JPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 04:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgL0JPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 04:15:45 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8B6C061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 01:15:05 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id t6so4218909plq.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 01:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wIgha9GtBqOktnyqlkwbboJhrovQmVp7OgpmsYVIqBc=;
        b=Z+4xUjgs1ofeqmMmyzvrMlrkz4NeS7Y1e7KpOKp+8MNUgyxrCgUPrZjPlnd3x11Nzk
         lKfOGq1wRbqSqUDnF+gU/UUGWS009MMkSHboVcLf62WR3FTOI8EJ1JqZLKwSCpZRO14z
         23XnCrdTB+cMLWajgYmUE+A7fwF7QI0DWSnnauAx+fDXy5T9yc3bCrotTrlmVAjEByfk
         BRX6auABVNHdJKBUdp1xDRUFPncl0JgeEt3vS92saWCmtwFQ4cempY75vfYVKx1UQg7g
         Slb3237+A/pNQICLdE4qMwq1GYGGfjip1iRu2PweVKZAVmcDpOAt13lx4DnOBq2Z554d
         hY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=wIgha9GtBqOktnyqlkwbboJhrovQmVp7OgpmsYVIqBc=;
        b=JxArkAkcx2MPFlTxSVbqbcSg1kXxJT1IIqP/C8orViJlAZqfmEdV5uU0axaK2TLUrd
         qCkK8BZV15KdpnPlL0ahuadx6hjacOzZXC8IBST2/fffzjGrNbctB9X0guC4q0CFoTDS
         190o4ha7oxlcbJ+BTGL/RCqGOGu7wDRalunra8TElPshgRBFJ0zOmasgCqxUwDECRdC0
         kEuzPgoaXvCY7j81cyMNof803WjEIEtbR9xWwXM7pmqGZvPaOD4v4AWcfsMJkQ4nW6fY
         DA8hmEFfGwjB2S86YrykT0fp3W+8rSkcYfBQsgDO65h758HhsT8c5EkiXTnhiUFuf2zn
         N8Ew==
X-Gm-Message-State: AOAM531j/BLs/Uztpy0ud0MwcYHmtrrsRQS6ggzAlxud/IRHq+76nqsl
        Pj94dSqoXFQDmgUFaRIPeLQ=
X-Google-Smtp-Source: ABdhPJzpTSlUqZlKpbJegbLFz0pjPycQkTclmti+hIxyQ3+FkXf8QXQL9mwZ0CkxHpcHaNEWDgbHCQ==
X-Received: by 2002:a17:902:9f97:b029:da:357b:22b0 with SMTP id g23-20020a1709029f97b02900da357b22b0mr18499215plq.73.1609060504688;
        Sun, 27 Dec 2020 01:15:04 -0800 (PST)
Received: from voyager.ozlabs.ibm.com (region97.lnk.telstra.net. [110.143.27.102])
        by smtp.gmail.com with ESMTPSA id q70sm10860236pja.39.2020.12.27.01.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 01:15:03 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: [PATCH] openrisc: restart: Call common handlers before hanging
Date:   Sun, 27 Dec 2020 19:44:46 +1030
Message-Id: <20201227091446.118437-1-joel@jms.id.au>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently openrisc will print a message and then hang in an infinite
loop when rebooting.

This patch adopts some code from ARM, which calls the common restart
infrastructure and hangs after a small delay if the restart infra
doesn't do anything.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
Geert has a patch[1] for the litex soc code that adds a restart hander.
Openrisc doesn't hit that code path, this patch fixes that.

[1] https://github.com/geertu/linux/commit/7d09dc0797a8208a11eb7c0c2156c1a4c120180f

 arch/openrisc/kernel/process.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 3c98728cce24..181448f74316 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -34,6 +34,7 @@
 #include <linux/init_task.h>
 #include <linux/mqueue.h>
 #include <linux/fs.h>
+#include <linux/reboot.h>
 
 #include <linux/uaccess.h>
 #include <asm/io.h>
@@ -49,10 +50,16 @@
  */
 struct thread_info *current_thread_info_set[NR_CPUS] = { &init_thread_info, };
 
-void machine_restart(void)
+void machine_restart(char *cmd)
 {
-	printk(KERN_INFO "*** MACHINE RESTART ***\n");
-	__asm__("l.nop 1");
+	do_kernel_restart(cmd);
+
+	/* Give a grace period for failure to restart of 1s */
+	mdelay(1000);
+
+	/* Whoops - the platform was unable to reboot. Tell the user! */
+	pr_emerg("Reboot failed -- System halted\n");
+	while (1);
 }
 
 /*
-- 
2.29.2


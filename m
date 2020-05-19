Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BD01D8C41
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 02:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgESA0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 20:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgESA0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 20:26:24 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7C8C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 17:26:24 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id m11so12659265qka.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 17:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vSJnwcwzJ6JQ8cOkRgXkpxTwGHhwzzMaFtdAARFsxXA=;
        b=Fp5I1zLjyad2CUSFmsDYAcObjn71acu20n11AnJLUVFXrJo5RMDOe5M2EqavYD23Ws
         G8wGk/jMQywcMZRmiaM6f2QXt7OE1tvnkE0Z4KCP9J/NyJzodUsQKAOG+W5Z9hL6YmVA
         ztf6oeTYJrRfQGG4DWolxcRm6ABmRqBeIVx2kjHP+c6VzOvOFkCxm+bm0ggvEf0TitGQ
         4nK/Vws5/yPko9TF4FzkCNe7pu4rsS/NHwJdLDM/nGV+FOT99ho8mep++0upq61Zwk0t
         jVCzkLfDAYPaVZx1hvttS+U4oaEEQfVgEc3dpX7Ulw33WWVQ0a3FAWv61TT99P1jTX26
         n98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vSJnwcwzJ6JQ8cOkRgXkpxTwGHhwzzMaFtdAARFsxXA=;
        b=P49S8MGgClWapOEmRVhCrGTPwzKFpQg2Jz5+1ovesdXMrlqdw6BeV1pqkEMseqCbtV
         j//REOhq4Qicj/vzfgzwWnACIBErLZRyXePCRUY0ez2PLjZssaG4eaYxzG3tHsNMT+ic
         g8U5uJMmZtQJ7nHlZy7PE+/hSU/635Mcc3lEUeiV6Gt6AFBor+/l3c+BkT0uUKnNuOgj
         +YEvWCl3ZV2AsqujBoiAHcgIjWvh9YouddO25Od2O1oCsY5CZwJA35THBAReGAl/6VvE
         snwEryhRwv1r2KDwk8xTb7IXcV4DOF9YOjqY7buOT8tvmQsTd91p8G9omNAJFWeyO60q
         QOCw==
X-Gm-Message-State: AOAM533qkJ4m9bKTyiL+W5KAcnSgjLvzsksLErrb8YL2vA2erTI9gcsX
        Vxg3RVS0KlLcT4pEb7UY5RY=
X-Google-Smtp-Source: ABdhPJxc6ks256v3X/1qy6T5tU1qAbCGp8bsiXZlDzOdzp8HLmooSIIpu97YX77sV39D4Ma6oHkFFA==
X-Received: by 2002:a37:b5c3:: with SMTP id e186mr17102893qkf.158.1589847983534;
        Mon, 18 May 2020 17:26:23 -0700 (PDT)
Received: from LeoBras.aus.stglabs.ibm.com (177-131-65-239.dynamic.desktop.com.br. [177.131.65.239])
        by smtp.gmail.com with ESMTPSA id e34sm2284048qtb.21.2020.05.18.17.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 17:26:22 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Allison Randal <allison@lohutok.net>,
        Leonardo Bras <leobras.c@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] powerpc/crash: Use NMI context for printk when starting to crash
Date:   Mon, 18 May 2020 21:25:58 -0300
Message-Id: <20200519002558.202929-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if printk lock (logbuf_lock) is held by other thread during
crash, there is a chance of deadlocking the crash on next printk, and
blocking a possibly desired kdump.

At the start of default_machine_crash_shutdown, make printk enter
NMI context, as it will use per-cpu buffers to store the message,
and avoid locking logbuf_lock.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Leonardo Bras <leobras.c@gmail.com>

---
Changes since v2:
- Changes usage of printk_nmi_enter() to nmi_enter()
  (Suggested by Nick Piggin)

Changes since v1:
- Added in-code comment explaining the need of context change
- Function moved to the start of default_machine_crash_shutdown,
  to avoid locking any printk on crashing routine.
- Title was 'Use NMI context for printk after crashing other CPUs'

---
 arch/powerpc/kexec/crash.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index d488311efab1..53c5cf9b6d3c 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/types.h>
+#include <linux/hardirq.h>
 
 #include <asm/processor.h>
 #include <asm/machdep.h>
@@ -311,6 +312,13 @@ void default_machine_crash_shutdown(struct pt_regs *regs)
 	unsigned int i;
 	int (*old_handler)(struct pt_regs *regs);
 
+	/*
+	 * Avoid hardlocking with irresponsive CPU holding logbuf_lock,
+	 * by using printk nmi_context
+	 */
+	if (!in_nmi())
+		nmi_enter();
+
 	/*
 	 * This function is only called after the system
 	 * has panicked or is otherwise in a critical state.
-- 
2.25.4


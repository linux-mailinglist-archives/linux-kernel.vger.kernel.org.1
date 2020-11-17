Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA132B700B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgKQU2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgKQU2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:28:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753F6C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 12:28:34 -0800 (PST)
Message-Id: <20201117202753.806376613@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605644912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=KIW6Z97AETGhVsDUrbooniTCntl/TWYOWn0uKGkwzVE=;
        b=HivOjFFYwN684QOooMSJd51MkiHkH/DXJAmglSRdpceDyVEpAEVfxRvwQsz38nWRt80hfM
        blFRMiQJio64JSxH+UzZE+Oq7gA7Xn5/3Sdoo819ugaoUpwnO2DOjMPQAxgqBstjfxEZzr
        9GsiKa8G3FbtC4wVn3FaGzSWKJt5v2jFBDXlYqHaYY3O+G/hucLOv9ZbUtH7maIOk1Bffc
        3aHnKCSgmPTPpRXyZeDg/8X7//9cuBAs5D0AYwdhl/dWKI6EWqb3Fkiew/Um3HJ/Mwp2TP
        GVB3m4H+kBikRDWK31ilqVDMNQvZf4U/uFJYCB8BFrmWCDQOJpycY+O6aydJgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605644912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=KIW6Z97AETGhVsDUrbooniTCntl/TWYOWn0uKGkwzVE=;
        b=wCS+/CHoLogSVs775JTRhMXYOCz8i++CobhclIFb0fouJVLh33nAgiTLQpc02ONBYM7/Se
        7u36ztzhARf+NfDA==
Date:   Tue, 17 Nov 2020 21:23:35 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Mark Mossberg <mark.mossberg@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Jann Horn <jannh@google.com>, kyin@redhat.com,
        Borislav Petkov <bp@alien8.de>
Subject: [patch v2 2/2] x86/uaccess: Document copy_from_user_nmi()
References: <20201117202333.869470686@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the functionality of copy_from_user_nmi() to avoid further
confusion. Fix the typo in the existing comment while at it.

Requested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/lib/usercopy.c |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

--- a/arch/x86/lib/usercopy.c
+++ b/arch/x86/lib/usercopy.c
@@ -9,9 +9,23 @@
 
 #include <asm/tlbflush.h>
 
-/*
- * We rely on the nested NMI work to allow atomic faults from the NMI path; the
- * nested NMI paths are careful to preserve CR2.
+/**
+ * copy_from_user_nmi - NMI safe copy from user
+ * @to:		Pointer to the destination buffer
+ * @from:	Pointer to a user space address of the current task
+ * @n:		Number of bytes to copy
+ *
+ * Returns: The number of not copied bytes. 0 is success, i.e. all bytes copied
+ *
+ * Contrary to other copy_from_user() variants this function can be called
+ * from NMI context. Despite the name it is not restricted to be called
+ * from NMI context. It is safe to be called from any other context as
+ * well. It disables pagefaults across the copy which means a fault will
+ * abort the copy.
+ *
+ * For NMI context invocations this relies on the nested NMI work to allow
+ * atomic faults from the NMI path; the nested NMI paths are careful to
+ * preserve CR2.
  */
 unsigned long
 copy_from_user_nmi(void *to, const void __user *from, unsigned long n)
@@ -27,7 +41,7 @@ copy_from_user_nmi(void *to, const void
 	/*
 	 * Even though this function is typically called from NMI/IRQ context
 	 * disable pagefaults so that its behaviour is consistent even when
-	 * called form other contexts.
+	 * called from other contexts.
 	 */
 	pagefault_disable();
 	ret = __copy_from_user_inatomic(to, from, n);


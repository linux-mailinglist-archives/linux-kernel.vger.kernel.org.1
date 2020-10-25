Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759A5298210
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 15:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416604AbgJYOZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 10:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416587AbgJYOZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 10:25:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778EEC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 07:25:47 -0700 (PDT)
Date:   Sun, 25 Oct 2020 14:25:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603635946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=XsWgXoHwPfDwgi0mOtNPh2+NZeCVxNltsspdsh+8Uu0=;
        b=Odx2EHJvfZpzJJeWYSCJQXQdbRh/Jy9wVthgjsK7bXtoIXqEXM3KmVhapsDTwbAd0JjzTX
        ejspuWmsjWOGGAe19XFm84iULfAYuXhRbs8Po4kL3W17JeOxgYv+zsFVpJL/lmygkpXHXd
        lga7wsszypTcKXiM0/nkqedh57s5FvbNEDNX/eonZHfwH1MbuA4/3KFZ6O9EzVV2NS5tIV
        ewLMe9jHfLSbeFJ/WTTTJSPD09XaeIWS4Bne0NHbBpDp2R4D/UB71ojeoLEbdszod5pBfg
        H70/++3Kvlouj9goWPgwnvnjc9yXeAQ752h8AAy0a6HhMy9t4MTaG5gkQqIAkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603635946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=XsWgXoHwPfDwgi0mOtNPh2+NZeCVxNltsspdsh+8Uu0=;
        b=zEE6wooFnUoLejuU3xGeEziX55c6jGZ0Vgcc9E56SJPIkufcJD/XXFLemTb9BtvvQn/5Il
        H70TNzIobd3hKaDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for 5.10-rc1
References: <160363590465.1234.11586095980767794789.tglx@nanos>
Message-ID: <160363590947.1234.141731936248952516.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-10-25

up to:  20802fef73a5: x86/traps: Fix #DE Oops message regression


Restore the original #DE Oops message so tools which parse crash or dmesg
find what they expect.

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      x86/traps: Fix #DE Oops message regression


 arch/x86/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 81a2fb711091..316ce1c09e84 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -195,7 +195,7 @@ static __always_inline void __user *error_get_trap_addr(struct pt_regs *regs)
 
 DEFINE_IDTENTRY(exc_divide_error)
 {
-	do_error_trap(regs, 0, "divide_error", X86_TRAP_DE, SIGFPE,
+	do_error_trap(regs, 0, "divide error", X86_TRAP_DE, SIGFPE,
 		      FPE_INTDIV, error_get_trap_addr(regs));
 }
 


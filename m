Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02E42D10BC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgLGMmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLGMmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:42:31 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F64C0613D0;
        Mon,  7 Dec 2020 04:41:50 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id b73so13508184edf.13;
        Mon, 07 Dec 2020 04:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P77beCy6AQ8QNMP70wp9CxeR5AsWVGLx/OAVKO8zAHQ=;
        b=g4PWfcE9CAHUcJFUTPa3Avicm9TbJ/V4xHPkiMGnUBlxALL2bL9ixlTKUuGBNtcbvo
         XnRf+/P2/2c+madNtqfs1gDguKqwaUFZ7l38Umf6tmV5JyiJTzJjV5b9+rW4kMUF2biR
         n0lIcs5q3Z7FTrqNkTHDTBMA0Z/d0ZUzCkFrUe3ECxz6jtM+0tNIuDsdGQ7LtFHJLb1y
         SD3owWUXfZ9/jD+86ohZKcF2+TuuSmBejuibyqXWX6mpXzZCpprHso4U5SAnAA1PFJwh
         d5mUJmAMdDArTmfsnvekYU5x4xUYHuKGnJ7dfC7unxBLMOEtqJ49RS+GabiNwtYewQSp
         ZgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P77beCy6AQ8QNMP70wp9CxeR5AsWVGLx/OAVKO8zAHQ=;
        b=qyVmtpK2baU7RsMY5ehe5xS2Muhkcs61zYF7edwLJiLrOeJzJp7XM5s5Uea8xS8L4h
         PoF0GNDBJMuZYJVKUEAwMIhpldxX+OCrkOrqFlf6JecxBF6y+4C1MPbnytlPDR/twcz8
         fE50r7RTxAFZiiYqi8yMDD66OM+bO0OV7GUuoGYae/BErXEnTQr49swvRrzjD+iNBt0z
         GlqKrcRL4ecGfYJxR7ZPOw19SawKMclLfB4Sh6B4aQZKXbLBjnFoosPwIw7l4DiwJ7OB
         hwTpRJ+TURVabA+LfZNUdA7oFwYtFdUkmyXVho8Wf6Pha+/MAm64cPAfymME79srx+NE
         3EdA==
X-Gm-Message-State: AOAM531UK8sPDcwxFjySWN3DqshWEV0rn4qz0XVVrq5mbxAtrHwSwobh
        wxYOYm8Bjoj6LkTcKDElXeU=
X-Google-Smtp-Source: ABdhPJxFnWwFbxGDSa3RmuKZqL1EdpyKGz5GO+85Zkj0DIoo4lKfRcE9DR3DI9zHsaApOBFn9bx9RQ==
X-Received: by 2002:aa7:d94e:: with SMTP id l14mr8251203eds.98.1607344909431;
        Mon, 07 Dec 2020 04:41:49 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d4a:c600:c0f8:50a9:4ab0:a9ab])
        by smtp.gmail.com with ESMTPSA id b19sm9540356edx.47.2020.12.07.04.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 04:41:48 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] x86: ia32_setup_rt_frame(): propagate __user annotations properly
Date:   Mon,  7 Dec 2020 13:41:41 +0100
Message-Id: <20201207124141.21859-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 57d563c82925 ("x86: ia32_setup_rt_frame(): consolidate uaccess
areas") dropped a __user annotation in a cast when refactoring __put_user()
to unsafe_put_user().

Hence, since then, sparse warns in arch/x86/ia32/ia32_signal.c:350:9:

  warning: cast removes address space '__user' of expression
  warning: incorrect type in argument 1 (different address spaces)
    expected void const volatile [noderef] __user *ptr
    got unsigned long long [usertype] *

Add the __user annotation to restore the propagation of address spaces.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master (v5.10-rc7) and next-20201204

Thomas, Ingo, Boris, please pick this minor non-urgent clean-up patch.

 arch/x86/ia32/ia32_signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 81cf22398cd1..5e3d9b7fd5fb 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -347,7 +347,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	 */
 	unsafe_put_user(*((u64 *)&code), (u64 __user *)frame->retcode, Efault);
 	unsafe_put_sigcontext32(&frame->uc.uc_mcontext, fp, regs, set, Efault);
-	unsafe_put_user(*(__u64 *)set, (__u64 *)&frame->uc.uc_sigmask, Efault);
+	unsafe_put_user(*(__u64 *)set, (__u64 __user *)&frame->uc.uc_sigmask, Efault);
 	user_access_end();
 
 	if (__copy_siginfo_to_user32(&frame->info, &ksig->info))
-- 
2.17.1


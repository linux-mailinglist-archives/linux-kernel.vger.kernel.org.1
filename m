Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEC22D10A5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgLGMhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgLGMhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:37:06 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306B1C0613D0;
        Mon,  7 Dec 2020 04:36:26 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id b2so13541926edm.3;
        Mon, 07 Dec 2020 04:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3F9a+4BPPHQGDVUkgQU5FOs1lv9LqzWI0XFtxPTAvZM=;
        b=nCSF0XiUTBIm804n9ZL7eFCK5qRBQKGHgEAHODQeh68bR8K3HAlpbT3DhIVgG0kuGi
         Bv3y2OHTQHw3PboThADzMg5vRhKuj60R1Vt1rLCRY0NqVwH8kEwVG8+jJKvrMGq1IUyM
         bqzV0D9XP+gFsgvobtSNUKw/IdWVUaMArvSyiVAFkSnJpQC0sO9qk2oo5KZDbR/ycvHv
         mAx4D3UL4gd/Qjr0MKKdfmXgiiKr7izHhB2t09lxb3YdxA74frmvpBz+nLgzwS6NeXin
         is44iX0bYS1CPIAtJbIHHa96rym6bJX967g+BNNsjU5QWWFAI8sNCLsAc+hFKISDHFZa
         N/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3F9a+4BPPHQGDVUkgQU5FOs1lv9LqzWI0XFtxPTAvZM=;
        b=GRsJ0Noh1Gh0PO310caXifthvemg4QQ3XugL/Jwvk4VijjA9dvPO5hSAD2+7grLyv+
         zytHrLKdbddl1QfGKuNQ7ljWNKIYrr+scIESsoufDYIC28mCH7bSD/U4a8dKswII55er
         UGeNzj4tYC1VYD7VFY+y6i2hZNqkd+TQd7ZFgKK1jChe3Y3xsqQMtXF5s29fpHvb3dTd
         bNARQTHq5wHhR83Z42s+cqJKP6ewBjqwRF90GTMFkJNGL8WbaLFgLIWwT2wPFq1fWXUG
         KwvW6ulYKKLXHwTonxXbrJZupNuw93dwqFTbDGw6TW9vN499zZyYAfy6CG+IlRXEvEAC
         OwQg==
X-Gm-Message-State: AOAM533zdh4OYbmBPvDR3FClA00QZH/ZTRvWyw6svMeRS2gnVGekzr9T
        mCbJ0rHKUXB2RzOKQw/Btac=
X-Google-Smtp-Source: ABdhPJweJrOmGBOU5/Namwt36BVVcuLdpVSB+RtbkNLmAkeuqM3MBXOwwsIV+IT9Iv8rsoIZtXY8+w==
X-Received: by 2002:a05:6402:1a2f:: with SMTP id be15mr19734241edb.209.1607344584891;
        Mon, 07 Dec 2020 04:36:24 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d4a:c600:c0f8:50a9:4ab0:a9ab])
        by smtp.gmail.com with ESMTPSA id k17sm12096790ejh.103.2020.12.07.04.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 04:36:24 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
Cc:     Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Serge Hallyn <serge@hallyn.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        kernel-janitors@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] signal: propagate __user annotations properly
Date:   Mon,  7 Dec 2020 13:36:10 +0100
Message-Id: <20201207123610.18246-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3eb39f47934f ("signal: add pidfd_send_signal() syscall") introduced
copy_siginfo_from_user_any(), but missed to add the __user annotation to
the user pointer that is passed as second argument.

Hence, when copy_siginfo_from_user_any() calls copy_siginfo_from_user(),
sparse warns:

  kernel/signal.c:3716:46: warning: incorrect type in argument 2 (different address spaces)
  kernel/signal.c:3716:46:    expected struct siginfo const [noderef] [usertype] __user *from
  kernel/signal.c:3716:46:    got struct siginfo [usertype] *info

And when pidfd_send_signal() calls copy_siginfo_from_user_any(), sparse
warns as well:

  kernel/signal.c:3776:58: warning: incorrect type in argument 2 (different address spaces)
  kernel/signal.c:3776:58:    expected struct siginfo [usertype] *info
  kernel/signal.c:3776:58:    got struct siginfo [noderef] [usertype] __user *info

Add the __user annotation to repair this chain of propagating __user
annotations.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master (v5.10-rc7) and next-20201204

Christian, please pick this minor non-urgent clean-up patch.

 kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 5736c55aaa1a..e969b3bc815f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3701,7 +3701,7 @@ static bool access_pidfd_pidns(struct pid *pid)
 	return true;
 }
 
-static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo, siginfo_t *info)
+static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo, siginfo_t __user *info)
 {
 #ifdef CONFIG_COMPAT
 	/*
-- 
2.17.1


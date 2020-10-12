Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A3328AB80
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 03:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgJLBsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 21:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgJLBsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 21:48:42 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C0CC0613D0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 18:48:42 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z22so12796637wmi.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 18:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Egc2g1s4c25bC1m2WOZ1u2/TqRkKnNmhG2I4XAl2dTI=;
        b=Y40pGiZPqAof6VouNq0+ourFU4bmZXSYyZtSdX4j/Fid8buNEu4Tdb391+FWFwNQO0
         TqjWIzI+NV7Q7eZk+iwy1F7m8toUwObyGlZHedu8x3GZqos1tdNFHnVf9Uv+X0RNvwa7
         v2iFruxiVWPOVO/3n5muqbyxEXXB4Q/T87vr+znyHquzxzBceREq/mwFp0Y/x0aGyWrw
         TQGI5RZ+OaHI1+/eNiwiYni27xaijXPgoRvaFlzToGZ1LtxMQvT2DVLnLWgbzkJ2PxlR
         zYL5ykSkAr+xMGDH0Pkn+3CIhAfFF7T1fq03nfNFejhM3sBzqhBMbOBGMEZlc0SX3wVn
         b7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Egc2g1s4c25bC1m2WOZ1u2/TqRkKnNmhG2I4XAl2dTI=;
        b=ozSDQQsTdO5Oz6sv1Y9UZIELmrhzGzhKfoybz3r8pQ//48szQpseO8LjzaSOzpF05q
         pDQ6ebJfyAnpa1TZ3p+KYduztAv7GYuBEKK7wZlmdisq6TB1W/Wxm/8U+ouBbhqwvQv6
         K9l/kw7BG8zyHQlg1GOPiaF/arOmphpIo/0ppwP0DXPYFMWqQfJ6h8Oh9DQwUtviXBnw
         bRkpRkPJwz16gh9k5tnDriOr172FjsHO8P6IQJipCMWmlse1fOLIvyBfkoVgmSMkA1pG
         qS7s3WIXJqKSaXBglLT9Wq9TbdYgeGPbCWLtO9wTKQvNSeQmv9mEfpZBDL0Dg+OhAZRN
         Adgg==
X-Gm-Message-State: AOAM531CZ4dc4stwDO+AGhRWYXGMbND5HWV7+CdAZ+1i+VembPsFN568
        QJLlqq814J/1RJJ1OgZWcYD/iA==
X-Google-Smtp-Source: ABdhPJwXZqRs/voCiPycmmzVSzvpjBw4F5QVqYhVjQ79vub102+DvRzK5g6N8eFW1+uSvZsZ/DS+2Q==
X-Received: by 2002:a1c:59c3:: with SMTP id n186mr8644345wmb.32.1602467320984;
        Sun, 11 Oct 2020 18:48:40 -0700 (PDT)
Received: from debian (trinity-students-nat.trin.cam.ac.uk. [131.111.193.104])
        by smtp.gmail.com with ESMTPSA id k18sm4306829wrx.96.2020.10.11.18.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 18:48:40 -0700 (PDT)
Received: from jrtc27 by debian with local (Exim 4.94)
        (envelope-from <jrtc27@jrtc27.com>)
        id 1kRmx5-0003jb-UC; Mon, 12 Oct 2020 02:48:39 +0100
From:   Jessica Clarke <jrtc27@jrtc27.com>
To:     linux-x86_64@vger.kernel.org
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: Fix x32 System V message queue syscalls
Date:   Mon, 12 Oct 2020 02:48:37 +0100
Message-Id: <20201012014837.14305-1-jrtc27@jrtc27.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

POSIX specifies that the first field of the supplied msgp, namely mtype,
is a long, not a __kernel_long_t, and it's a user-defined struct due to
the variable-length mtext field so we can't even bend the spec and make
it a __kernel_long_t even if we wanted to. Thus we must use the compat
syscalls on x32 to avoid buffer overreads and overflows in msgsnd and
msgrcv respectively.

Due to erroneously including the first 4 bytes of mtext in the mtype
this would previously also cause non-zero msgtyp arguments for msgrcv to
search for the wrong messages, and if sharing message queues between x32
and non-x32 (i386 or x86_64) processes this would previously cause mtext
to "move" and, depending on the direction and ABI combination, lose the
first 4 bytes.

Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
---
 arch/x86/entry/syscalls/syscall_64.tbl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f30d6ae9a..7ee40989e 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -77,8 +77,8 @@
 66	common	semctl			sys_semctl
 67	common	shmdt			sys_shmdt
 68	common	msgget			sys_msgget
-69	common	msgsnd			sys_msgsnd
-70	common	msgrcv			sys_msgrcv
+69	64	msgsnd			sys_msgsnd
+70	64	msgrcv			sys_msgrcv
 71	common	msgctl			sys_msgctl
 72	common	fcntl			sys_fcntl
 73	common	flock			sys_flock
@@ -404,3 +404,5 @@
 545	x32	execveat		compat_sys_execveat
 546	x32	preadv2			compat_sys_preadv64v2
 547	x32	pwritev2		compat_sys_pwritev64v2
+548	x32	msgsnd			compat_sys_msgsnd
+549	x32	msgrcv			compat_sys_msgrcv
-- 
2.28.0


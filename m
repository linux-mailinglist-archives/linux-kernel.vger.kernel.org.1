Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F3128B8F3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389593AbgJLN4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730521AbgJLNpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:45:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358AEC0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:45:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z22so13815388wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uj1/vIk16HyKqaqPulVeiknpIIXXOxKSMs7wtuz5yCA=;
        b=TRQPAXmCoIFwbwIJOxG3vMY7u+uf48PaQpmbcCVpz0KjfQErNIMXFd4SM2xF1qqIHB
         +RvheOPF2kRRKD0gVtiiTWNIBtii9oZJ4H7ESaTgqbUoIKlSAqMstj6yLGBXD1o0SSrk
         7d7iTYeOmQq4606rhAplTR7UkMbDXh6B7wucFfz/9+T3KJB6+WFaqA09tdCVQCT0epSc
         mpgTO3LE2o7ZAaxbXE5/X5mUBoBwoH0y4nFAZjTiUYPTUsSQ2jUr38Wu7Tovl9zzvceb
         1QdDR8uo13BSCTHR+fD0BqQZdUkcpLvVyKDOlPGPQ3mqB3yU3KuChWLvU8ydfYnN4pI+
         n8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uj1/vIk16HyKqaqPulVeiknpIIXXOxKSMs7wtuz5yCA=;
        b=d6jb+HhUtYPEX+tRsHVMO32BCSxKNMA5+8Hk1VGmVEd3ZXSnVvKgiotNINSuoaNlzO
         fUt0zZep3JgFMGHIi6+wG++jX7BEfucZCLNEdKZ0Ma8Vfmdl7U2d/3C6MLua4KCJl+cM
         2udkQwzq1WI/Ex8dVOk2bewY5Pbca9thGuH/4oV+6w8BHTn+YCsuB2MDzpnL+R2d3JIf
         ahdehRhs91Ip1rELWbrXC6g+8m/Jre6JDq3QPa5nfxyiXMWE4djDRcOPJ4lxmeymrG7g
         b3Bte4D/5EiBDM/Ml0A0yFPgZeKVkIaYRaXaSgDJce3xVOCyzLed/4k6Iv/X7zAP/MKx
         V3NQ==
X-Gm-Message-State: AOAM531Tsm9Ekm8r6f5+OODfDH5MGGSlVI9S4Ip9cKn6jCRQ0dBIZuvm
        aNSIUcKMaYL3eglpKCdCuSjRjg==
X-Google-Smtp-Source: ABdhPJxRENSFxKFd4Hwwv6BoTu7JigR7kZqw+N9o21tOMKn1cHulrxZtrDf9Sacsm7MJXV7LnZnTTw==
X-Received: by 2002:a1c:1b15:: with SMTP id b21mr11168736wmb.143.1602510299002;
        Mon, 12 Oct 2020 06:44:59 -0700 (PDT)
Received: from debian (trinity-students-nat.trin.cam.ac.uk. [131.111.193.104])
        by smtp.gmail.com with ESMTPSA id h1sm22662075wrx.33.2020.10.12.06.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:44:58 -0700 (PDT)
Received: from jrtc27 by debian with local (Exim 4.94)
        (envelope-from <jrtc27@jrtc27.com>)
        id 1kRy8H-0000Vc-Rd; Mon, 12 Oct 2020 14:44:57 +0100
From:   Jessica Clarke <jrtc27@jrtc27.com>
To:     linux-x86_64@vger.kernel.org
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86: Fix x32 System V message queue syscalls
Date:   Mon, 12 Oct 2020 14:44:44 +0100
Message-Id: <20201012134444.1905-1-jrtc27@jrtc27.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <1156938F-A9A3-4EE9-B059-2294A0B9FBFE@jrtc27.com>
References: <1156938F-A9A3-4EE9-B059-2294A0B9FBFE@jrtc27.com>
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

I have verified that the test at the end of [1] now gives the correct
result on x32 ("PAYL" not "PAY" as I erroneously claimed it should be in
the above email) and that both i386 and amd64 give the same output with
that test as before.

[1] <1156938F-A9A3-4EE9-B059-2294A0B9FBFE@jrtc27.com>

Changes since v1:
 * Uses the same syscall numbers for x32 as amd64 and the current x32
   rather than (further) breaking ABI by allocating new ones from the
   legacy x32 range

 arch/x86/entry/syscalls/syscall_64.tbl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f30d6ae9a..f462123f3 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -77,8 +77,10 @@
 66	common	semctl			sys_semctl
 67	common	shmdt			sys_shmdt
 68	common	msgget			sys_msgget
-69	common	msgsnd			sys_msgsnd
-70	common	msgrcv			sys_msgrcv
+69	64	msgsnd			sys_msgsnd
+69	x32	msgsnd			compat_sys_msgsnd
+70	64	msgrcv			sys_msgrcv
+70	x32	msgrcv			compat_sys_msgrcv
 71	common	msgctl			sys_msgctl
 72	common	fcntl			sys_fcntl
 73	common	flock			sys_flock
-- 
2.28.0


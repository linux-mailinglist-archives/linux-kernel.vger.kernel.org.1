Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152892679DC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 13:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgILLLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 07:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgILLIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 07:08:48 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48091C0617A4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 04:08:31 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z19so9072926pfn.8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 04:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jbIVGVeXL3UcD5Zx3+0sHrDQsZkQmD0nziWY3w5+YuI=;
        b=LqQ/QyMbPHbN/COohSTcKyMAKLl5cT78qQitFk8CTTS3dxBKp0xZo1Q2/Pnj7vV2qy
         RLb83+qRl281SbYQByqtCv58OW/cIMeoQuNZP7O7zHoBXuxMSUgD493bWxSJcqnwYYg9
         rLdRfx2N0xOFGRKseP1KmNGFygnsLvdtukIbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jbIVGVeXL3UcD5Zx3+0sHrDQsZkQmD0nziWY3w5+YuI=;
        b=EApTorAaMAbyhluS8hX8tOhA4cK/GluPjal3lFMvUFiDSXTJxUxs9FFwq69raiENdD
         NJ3sjkQ5skDj3ISEkWqhAcjWkXhoFoD51fsNZLphXf9LnaC7DaQCzYNpGzokz+j40SoT
         UmjamzwEZ4uOU87FS4ekGxQO24UvvXANNzFfj9u4CG+B0+b4rgrFZGxg29QeyE3Yu03Q
         9PF2DbiMyAiQG20pvjDPVmDYsE81JqqfDE3NhccRWtQcg2FwLxRduy3CiJvjh9KPQMES
         JUpDsfJqnuPoZA8+ArC1P5TBtYFanf7HUC9b+76tFgVgl3vPdMrIiUmYzBaJlfFGLQ2L
         6eTg==
X-Gm-Message-State: AOAM531g+TOZhZozqB6SGuLqc3UTWbQDryjJ69GK/dQlUJBCIcWe4rCq
        m/4kvI9ZiZ/WxraGK0qm6azoBw==
X-Google-Smtp-Source: ABdhPJxPd8dhUmxmmh/f8D3tYc3els9U203dCey201+Libct5mZfeDfZE6CqjRDTC4JFXw6rBxndIA==
X-Received: by 2002:a05:6a00:1b:b029:13e:d13d:a101 with SMTP id h27-20020a056a00001bb029013ed13da101mr5730307pfk.29.1599908908451;
        Sat, 12 Sep 2020 04:08:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x20sm4980626pfr.190.2020.09.12.04.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 04:08:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/15] selftests/seccomp: arm64: Define SYSCALL_NUM_SET macro
Date:   Sat, 12 Sep 2020 04:08:10 -0700
Message-Id: <20200912110820.597135-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200912110820.597135-1-keescook@chromium.org>
References: <20200912110820.597135-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the arm64 special-case in change_syscall().

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 27 +++++++++----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 610fc036e374..cfa606d96086 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1717,6 +1717,18 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 #elif defined(__aarch64__)
 # define ARCH_REGS		struct user_pt_regs
 # define SYSCALL_NUM(_regs)	(_regs).regs[8]
+# ifndef NT_ARM_SYSTEM_CALL
+#  define NT_ARM_SYSTEM_CALL 0x404
+# endif
+# define SYSCALL_NUM_SET(_regs, _nr)				\
+	do {							\
+		struct iovec __v;				\
+		typeof(_nr) __nr = (_nr);			\
+		__v.iov_base = &__nr;				\
+		__v.iov_len = sizeof(__nr);			\
+		EXPECT_EQ(0, ptrace(PTRACE_SETREGSET, tracee,	\
+				    NT_ARM_SYSTEM_CALL, &__v));	\
+	} while (0)
 # define SYSCALL_RET(_regs)	(_regs).regs[0]
 #elif defined(__riscv) && __riscv_xlen == 64
 # define ARCH_REGS		struct user_regs_struct
@@ -1852,23 +1864,10 @@ void change_syscall(struct __test_metadata *_metadata,
 #if defined(__x86_64__) || defined(__i386__) || defined(__powerpc__) || \
 	defined(__s390__) || defined(__hppa__) || defined(__riscv) || \
 	defined(__xtensa__) || defined(__csky__) || defined(__sh__) || \
-	defined(__mips__) || defined(__arm__)
+	defined(__mips__) || defined(__arm__) || defined(__aarch64__)
 	{
 		SYSCALL_NUM_SET(regs, syscall);
 	}
-
-#elif defined(__aarch64__)
-# ifndef NT_ARM_SYSTEM_CALL
-#  define NT_ARM_SYSTEM_CALL 0x404
-# endif
-	{
-		iov.iov_base = &syscall;
-		iov.iov_len = sizeof(syscall);
-		ret = ptrace(PTRACE_SETREGSET, tracee, NT_ARM_SYSTEM_CALL,
-			     &iov);
-		EXPECT_EQ(0, ret);
-	}
-
 #else
 	ASSERT_EQ(1, 0) {
 		TH_LOG("How is the syscall changed on this architecture?");
-- 
2.25.1


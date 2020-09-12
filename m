Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EE02679B6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 13:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgILLJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 07:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgILLIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 07:08:47 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE87EC06179E
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 04:08:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id j7so2146924plk.11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 04:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QKhJot8+to6qKu+kMYm4kysaXKnRZz6+eVc9HFtoAC0=;
        b=derYVmOCJvHNh5vXBTIqRN639+QYp2Ima9wlNPyQ9WhsVt6z+ujiUK93WRnZUcsgJa
         56K/8/zjGpnrL9kAoptHwuckPAButJImWrCCwyiO9DiDVHsrbxalUoEMQIqQZVyppWc6
         Ee+YDqjRz8veoXRbQfqxsgmDU3EojdbmbMZp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKhJot8+to6qKu+kMYm4kysaXKnRZz6+eVc9HFtoAC0=;
        b=fciHQI4IywJlx+e7cxCrcLcEIfNRTnevRxD24Yw3Tz1PS/vJ2ZsOohECxLo6lBbMzC
         lcS3zJF7RcWwoiZt+cimxE7LWLUrO77JUhiOt6fEY/iBtp20zf9I4sxN5FYz3kIv2RHv
         fKgRl46HodmBPerP35eGL4/9FwXUyFaZPmUHAUL9GOAJrJzq3HrKl5VlWuTfxQUyt1v/
         /5b4uULYq0xXqNVOwifqS/6mznkF70gblPIIzip/CzhdUSojyfgLnbGBqn3R2B2y77ZA
         RFqLKfJat3XpQ3kS4qcprNrPUao7unystmsbntu/fvNn9mRIaL0gbCBJ+LhGt5gqXHTi
         wjog==
X-Gm-Message-State: AOAM531zLitrcdn5AWkFsC8tgTfRze5l/zK1g/1u/giSx7Cl9cot1hiy
        E0m1SFuhfKOpHR3EgR5tC9fmWA==
X-Google-Smtp-Source: ABdhPJy+dZm2QFai7sfR0m9YcZtzGf7C5BX6vbAvfQk3QaGiefAxnuL3yTjBJPD1CaoCvlCi+ojigA==
X-Received: by 2002:a17:90b:3241:: with SMTP id jy1mr6101351pjb.10.1599908907078;
        Sat, 12 Sep 2020 04:08:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s8sm5388984pfd.153.2020.09.12.04.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 04:08:23 -0700 (PDT)
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
Subject: [PATCH 04/15] selftests/seccomp: arm: Define SYSCALL_NUM_SET macro
Date:   Sat, 12 Sep 2020 04:08:09 -0700
Message-Id: <20200912110820.597135-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200912110820.597135-1-keescook@chromium.org>
References: <20200912110820.597135-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the arm special-case in change_syscall().

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 02a9a6599746..610fc036e374 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1708,6 +1708,11 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 #elif defined(__arm__)
 # define ARCH_REGS		struct pt_regs
 # define SYSCALL_NUM(_regs)	(_regs).ARM_r7
+# ifndef PTRACE_SET_SYSCALL
+#  define PTRACE_SET_SYSCALL   23
+# endif
+# define SYSCALL_NUM_SET(_regs, _nr)	\
+		EXPECT_EQ(0, ptrace(PTRACE_SET_SYSCALL, tracee, NULL, _nr))
 # define SYSCALL_RET(_regs)	(_regs).ARM_r0
 #elif defined(__aarch64__)
 # define ARCH_REGS		struct user_pt_regs
@@ -1847,20 +1852,11 @@ void change_syscall(struct __test_metadata *_metadata,
 #if defined(__x86_64__) || defined(__i386__) || defined(__powerpc__) || \
 	defined(__s390__) || defined(__hppa__) || defined(__riscv) || \
 	defined(__xtensa__) || defined(__csky__) || defined(__sh__) || \
-	defined(__mips__)
+	defined(__mips__) || defined(__arm__)
 	{
 		SYSCALL_NUM_SET(regs, syscall);
 	}
 
-#elif defined(__arm__)
-# ifndef PTRACE_SET_SYSCALL
-#  define PTRACE_SET_SYSCALL   23
-# endif
-	{
-		ret = ptrace(PTRACE_SET_SYSCALL, tracee, NULL, syscall);
-		EXPECT_EQ(0, ret);
-	}
-
 #elif defined(__aarch64__)
 # ifndef NT_ARM_SYSTEM_CALL
 #  define NT_ARM_SYSTEM_CALL 0x404
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1EB2679BC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 13:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgILLKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 07:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgILLJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 07:09:10 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FFFC061383
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 04:08:32 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s65so7140198pgb.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 04:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k9Scn27yFC+W9ArnzObQ75YlAm/mAi2yXdvN+WcxI8I=;
        b=NvsFIwxBor6gbhPRLZwb/jVT/T+nX6Z+XVHXFtFu/TcUGNP3/MncUQtopjc936YDWp
         R3xYst7NJXA6aVBOzW2yqYtx004tCHQMSEjrxUDj6uvghiw4gRHuKyf6orJdFpOnqppR
         k41JqT9G2h68b34eiIX80bwMoGJZHY/CSxIQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k9Scn27yFC+W9ArnzObQ75YlAm/mAi2yXdvN+WcxI8I=;
        b=mcZ3LjFuvNxnJ3EquayjQpzRgU6k3FvTxL+kHXePJh9T2ZgveMWE87PFPMj51kxRHP
         nsnq21KpfY4tLCXqMjJ364ZSQr1DIkKpWH9S3pqoGaQa5qfP1A29kW3tCzvAs5U/5QUv
         sQD/uRZUlCMzvzY3d/BdXUPB5Swao66c80zRp558QkGPAocEhqi6VxqueTs8flqxSuk7
         j9tbSVZqPlYz8vzqpBLUl8mCwRSkfaX3r6r/DraIRv8eXSrgf91AJ/fcIqD+4Lvw9fdE
         Ns32JMPmXCcB3tTphW/v4Q4cq0hxCR82lrosCRvh3KUQA4KWxA6yw0lVHQv/cvmtnGah
         WUmQ==
X-Gm-Message-State: AOAM532XYEjiGFIMLgUcRsVNQk/6I+XhA55Zmi/hel3LFqAifht8hl34
        5n4AODN83JGHgHaH/UAq02L7ZA==
X-Google-Smtp-Source: ABdhPJxOfgT/KlEkxzDrBNa4LGCxQcYJ5lPhAwfQMk4WTnlFoUysQ4K+RWVpU1AXIS+4PLjRZ0yExg==
X-Received: by 2002:a63:60e:: with SMTP id 14mr4570723pgg.343.1599908911776;
        Sat, 12 Sep 2020 04:08:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x7sm4139666pjv.16.2020.09.12.04.08.26
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
Subject: [PATCH 09/15] selftests/seccomp: Convert REGSET calls into ARCH_GETREG/ARCH_SETREG
Date:   Sat, 12 Sep 2020 04:08:14 -0700
Message-Id: <20200912110820.597135-10-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200912110820.597135-1-keescook@chromium.org>
References: <20200912110820.597135-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consolidate the REGSET logic into the new ARCH_GETREG() and
ARCH_SETREG() macros, avoiding more #ifdef code in function bodies.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 42 +++++++------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index a986f2332327..d9346121b89b 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1828,26 +1828,29 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 #if defined(__x86_64__) || defined(__i386__) || defined(__mips__)
 # define ARCH_GETREGS(_regs)	ptrace(PTRACE_GETREGS, tracee, 0, &(_regs))
 # define ARCH_SETREGS(_regs)	ptrace(PTRACE_SETREGS, tracee, 0, &(_regs))
+#else
+# define ARCH_GETREGS(_regs)	({					\
+		struct iovec __v;					\
+		__v.iov_base = &(_regs);				\
+		__v.iov_len = sizeof(_regs);				\
+		ptrace(PTRACE_GETREGSET, tracee, NT_PRSTATUS, &__v);	\
+	})
+# define ARCH_SETREGS(_regs)	({					\
+		struct iovec __v;					\
+		__v.iov_base = &(_regs);				\
+		__v.iov_len = sizeof(_regs);				\
+		ptrace(PTRACE_SETREGSET, tracee, NT_PRSTATUS, &__v);	\
+	})
 #endif
 
 /* Architecture-specific syscall fetching routine. */
 int get_syscall(struct __test_metadata *_metadata, pid_t tracee)
 {
 	ARCH_REGS regs;
-#ifdef ARCH_GETREGS
-	EXPECT_EQ(0, ARCH_GETREGS(regs)) {
-		return -1;
-	}
-#else
-	struct iovec iov;
 
-	iov.iov_base = &regs;
-	iov.iov_len = sizeof(regs);
-	EXPECT_EQ(0, ptrace(PTRACE_GETREGSET, tracee, NT_PRSTATUS, &iov)) {
-		TH_LOG("PTRACE_GETREGSET failed");
+	EXPECT_EQ(0, ARCH_GETREGS(regs)) {
 		return -1;
 	}
-#endif
 
 	return SYSCALL_NUM(regs);
 }
@@ -1857,18 +1860,10 @@ void change_syscall(struct __test_metadata *_metadata,
 		    pid_t tracee, int syscall, int result)
 {
 	ARCH_REGS regs;
-#ifdef ARCH_GETREGS
+
 	EXPECT_EQ(0, ARCH_GETREGS(regs)) {
 		return;
 	}
-#else
-	int ret;
-	struct iovec iov;
-	iov.iov_base = &regs;
-	iov.iov_len = sizeof(regs);
-	ret = ptrace(PTRACE_GETREGSET, tracee, NT_PRSTATUS, &iov);
-	EXPECT_EQ(0, ret);
-#endif
 
 	SYSCALL_NUM_SET(regs, syscall);
 
@@ -1881,14 +1876,7 @@ void change_syscall(struct __test_metadata *_metadata,
 #endif
 
 	/* Flush any register changes made. */
-#ifdef ARCH_SETREGS
 	EXPECT_EQ(0, ARCH_SETREGS(regs));
-#else
-	iov.iov_base = &regs;
-	iov.iov_len = sizeof(regs);
-	ret = ptrace(PTRACE_SETREGSET, tracee, NT_PRSTATUS, &iov);
-	EXPECT_EQ(0, ret);
-#endif
 }
 
 void tracer_seccomp(struct __test_metadata *_metadata, pid_t tracee,
-- 
2.25.1


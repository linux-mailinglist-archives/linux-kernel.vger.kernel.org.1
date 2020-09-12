Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BCD2679DF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 13:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgILLLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 07:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgILLIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 07:08:36 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CB1C061796
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 04:08:26 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id v15so8207599pgh.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 04:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OInAC9GW/Qn15XLBfoA31qdN7XBIGKQcBMz86oeUNCI=;
        b=d1mnMUsez3jOBFoeA7qprWEYhqBNscyNUCJRSrHACM1kolvFIIVwE0oTDarfqfRRyt
         EZVqDdMOBIDrx85v7uTznjrh1+fZH1TRrnXTBVJXU5uxfzDk9SrvZpuEZ3qybLVI/4Vi
         38ppObnAfNv4LDTV+R926cyWt9vORTT60LLnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OInAC9GW/Qn15XLBfoA31qdN7XBIGKQcBMz86oeUNCI=;
        b=I2682zCfb8/vVg1QhfXHZfcFLVJuxHEKRd8wg+jgYFpcr4r9rq+qD8ZWYsfPGO7XVE
         QPBXE3ycqt6jRUyyd2pptv3cGjV6Yfi26uZvufgi90xe7NWB5JBYurA6swISWs1lUc9c
         iv0tjuE+JjbChq3yw9Mc9zMiA9lgIHfgM9mpfATMJZBtCTBbCnQBkuUDFlAIR3Ci22wS
         gtaISJSNs2XVHmMW/S0f1+iDwK1Sd9NTyMck6Rg3DbhdZ/JAv2DxXCuOQJcHqS3a4711
         Hha8rP6XHhgSZRMLOJdXmlMM9MQYfkH3lEG/79BC0hSQhl5q2XYfLcMK/qQJxsj6CmjM
         15gA==
X-Gm-Message-State: AOAM532FaOP7X6z2KAYIHJZAeYFy+Cx/qxSuRueLAF/UxRbaYqUd4efC
        /uuhqC65eHTupYNZ1QjgVZFsGA==
X-Google-Smtp-Source: ABdhPJyDPU6BahqLywZ5Wass8ihB9w09WdZMZEJjPIamOh7TwZSYjVn9+opdSDMO1VWUvStVtnivFw==
X-Received: by 2002:a65:5a0b:: with SMTP id y11mr4507630pgs.395.1599908905771;
        Sat, 12 Sep 2020 04:08:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b10sm4811155pff.85.2020.09.12.04.08.23
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
Subject: [PATCH 03/15] selftests/seccomp: mips: Define SYSCALL_NUM_SET macro
Date:   Sat, 12 Sep 2020 04:08:08 -0700
Message-Id: <20200912110820.597135-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200912110820.597135-1-keescook@chromium.org>
References: <20200912110820.597135-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the mips special-case in change_syscall().

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 1c83e743bfb1..02a9a6599746 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1742,6 +1742,13 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 # define ARCH_REGS		struct pt_regs
 # define SYSCALL_NUM(_regs)	(_regs).regs[2]
 # define SYSCALL_SYSCALL_NUM	regs[4]
+# define SYSCALL_NUM_SET(_regs, _nr)			\
+	do {						\
+		if ((_regs).regs[2] == __NR_O32_Linux)	\
+			(_regs).regs[4] = _nr;		\
+		else					\
+			(_regs).regs[2] = _nr;		\
+	} while (0)
 # define SYSCALL_RET(_regs)	(_regs).regs[2]
 # define SYSCALL_NUM_RET_SHARE_REG
 #elif defined(__xtensa__)
@@ -1839,17 +1846,11 @@ void change_syscall(struct __test_metadata *_metadata,
 
 #if defined(__x86_64__) || defined(__i386__) || defined(__powerpc__) || \
 	defined(__s390__) || defined(__hppa__) || defined(__riscv) || \
-	defined(__xtensa__) || defined(__csky__) || defined(__sh__)
+	defined(__xtensa__) || defined(__csky__) || defined(__sh__) || \
+	defined(__mips__)
 	{
 		SYSCALL_NUM_SET(regs, syscall);
 	}
-#elif defined(__mips__)
-	{
-		if (SYSCALL_NUM(regs) == __NR_O32_Linux)
-			regs.SYSCALL_SYSCALL_NUM = syscall;
-		else
-			SYSCALL_NUM_SET(regs, syscall);
-	}
 
 #elif defined(__arm__)
 # ifndef PTRACE_SET_SYSCALL
-- 
2.25.1


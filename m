Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD472679C2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 13:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgILLKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 07:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgILLJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 07:09:22 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEE3C061388
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 04:08:33 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f2so6185071pgd.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 04:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pONZKNsoYmecan6Kvfo6IohiIkOTvwMfLoaC7wDxjJY=;
        b=AHH/amkQdeWLyBAxU3pffopTPxgFrBFBprJ+PpEdvWf1lAYD5H+lgruCFy2n/X0+XX
         yY7j6ILtJvVkoXTgPU/Q0Nx0Ff/quYRXHPXNvwJmR6j+U5zNUucDghfcm6CBWGBetvGy
         4eTIchjU58tkxxv/jWjM7df5Qqcmyycxt1Xts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pONZKNsoYmecan6Kvfo6IohiIkOTvwMfLoaC7wDxjJY=;
        b=BkvhXYY0AmksdYY8O3Mxpw8FLNny6n2sRRi0nbah9/s4H2qhd1JrsVDhvkGdOGY+xS
         cttXHY8WbY1U0YQCV88ttxU8lsx6gzp/L7pYeIxndKKIeaiNEI+9LHNS5948pQfb4MoU
         UZMqng8oHqmHR3Cok8ji2qtv7UHLSWqpLlsP06LXqbJoVYoC+fsM9C6aJvJ/yMu10x51
         NfM+pUou5hSRwYG4IrmrFjPAS5Lt9fy8qtwSdeHEFz+30Ij3HnLJl0bWypCY05zngUO1
         TZzK/F2Y6lOP3GynWOuWSMo6pURxN8aKpSk37Ri2I4amlEoZlUREwxdmTx+WL7PsYeV8
         0y9A==
X-Gm-Message-State: AOAM530a/C30sQmt1W+nC+6V89bm8GGXmVWjqQNp8dNN7H4qwWLZmVbF
        zLec3DgK54Ezb352IE/vcbEYIw==
X-Google-Smtp-Source: ABdhPJxh5feYLWNyYkQfm0AMemI2YVevpROI7r4tOHO1a8H0MHk0I/H+X87vqakNf9zn1pnikeC7qw==
X-Received: by 2002:a05:6a00:8c5:b029:13e:ce2c:88bd with SMTP id s5-20020a056a0008c5b029013ece2c88bdmr5950676pfu.0.1599908913398;
        Sat, 12 Sep 2020 04:08:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id np1sm4004435pjb.2.2020.09.12.04.08.27
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
Subject: [PATCH 12/15] selftests/seccomp: powerpc: Fix seccomp return value testing
Date:   Sat, 12 Sep 2020 04:08:17 -0700
Message-Id: <20200912110820.597135-13-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200912110820.597135-1-keescook@chromium.org>
References: <20200912110820.597135-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On powerpc, the errno is not inverted, and depends on ccr.so being
set. Add this to a powerpc definition of SYSCALL_RET_SET().

Co-developed-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Link: https://lore.kernel.org/linux-kselftest/20200911181012.171027-1-cascardo@canonical.com/
Fixes: 5d83c2b37d43 ("selftests/seccomp: Add powerpc support")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 623953a53032..bbab2420d708 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1750,6 +1750,21 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 # define ARCH_REGS		struct pt_regs
 # define SYSCALL_NUM(_regs)	(_regs).gpr[0]
 # define SYSCALL_RET(_regs)	(_regs).gpr[3]
+# define SYSCALL_RET_SET(_regs, _val)				\
+	do {							\
+		typeof(_val) _result = (_val);			\
+		/*						\
+		 * A syscall error is signaled by CR0 SO bit	\
+		 * and the code is stored as a positive value.	\
+		 */						\
+		if (_result < 0) {				\
+			SYSCALL_RET(_regs) = -result;		\
+			(_regs).ccr |= 0x10000000;		\
+		} else {					\
+			SYSCALL_RET(_regs) = result;		\
+			(_regs).ccr &= ~0x10000000;		\
+		}						\
+	} while (0)
 #elif defined(__s390__)
 # define ARCH_REGS		s390_regs
 # define SYSCALL_NUM(_regs)	(_regs).gprs[2]
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E39A273750
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgIVA0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgIVA0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:26:30 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9C6C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 17:26:30 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id k14so10464300pgi.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 17:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f/2N6mzSda+euBdN9YLPr/ei4P32nyFOAmhVMyjcn2g=;
        b=jjRfaFPz462gb4Nx/t7Kbgiq55j07WhQp0rVjx2vn6ic2xOQPz2pMwyjRY6wfWrYgY
         +XVcjoaM1cOKkbm2+/fldKBYi6hUdAI8WnsTRU3MQZwgiJ3n7u3L0HCHlBmOZjTvlWGn
         MRNX5K2SLaw0woDbKPfl0U2wumDWIIGE+Uurk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f/2N6mzSda+euBdN9YLPr/ei4P32nyFOAmhVMyjcn2g=;
        b=WI0nBl+PxVFN5POmkkt765TC6QSRpmQA1mGpCYasC34KSNObnS3q2NOwdFj8IUwop8
         RoXeghgJkBYmoowcbll8poDL2tal2KrYnrZdIdDQ95wACJk1NqmTAj3acLF3MCtqRjH1
         5MeERVAvxcAaOtvPJd/fPyLIfdwv9LNtR6qP1LRPvCkE5X51BdPTxmt7Qf87lbwDUcRR
         oZdXQqFCb/RJs4WTg8UUkF/nlX/uBBRLXCmkmztu3e6k8z+y7I3VcDZInf9PCDzc4RN7
         h5zPMpEONr69T1s9cqtp0BVYjxxYlt3+DLb0scyxZkVIucijqLt2ce8WYIZOFyBNDier
         72Ag==
X-Gm-Message-State: AOAM5303FyaC7LjEVAVe69vC48Oy/T+z5WLzz5hbRadnq4P3EbOQUyWw
        ZOLeWkhnZn8JlnYLgstLGvHMTg==
X-Google-Smtp-Source: ABdhPJz4O4A3jWBBL5m0YJIuyrVwlUjdyRvpPSH47+TXpRBZit2zPSflscLfljcESVyvzelRLYFs3A==
X-Received: by 2002:a62:d44e:0:b029:13c:1611:652f with SMTP id u14-20020a62d44e0000b029013c1611652fmr1929971pfl.15.1600734389830;
        Mon, 21 Sep 2020 17:26:29 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id m21sm12913815pfo.13.2020.09.21.17.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 17:26:29 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Jackie Liu <liuyun01@kylinos.cn>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: crypto: Add an option to assume NEON XOR is the fastest
Date:   Mon, 21 Sep 2020 17:26:08 -0700
Message-Id: <20200921172603.1.Id9450c1d3deef17718bd5368580a3c44895209ee@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On every boot time we see messages like this:

[    0.025360] calling  calibrate_xor_blocks+0x0/0x134 @ 1
[    0.025363] xor: measuring software checksum speed
[    0.035351]    8regs     :  3952.000 MB/sec
[    0.045384]    32regs    :  4860.000 MB/sec
[    0.055418]    arm64_neon:  5900.000 MB/sec
[    0.055423] xor: using function: arm64_neon (5900.000 MB/sec)
[    0.055433] initcall calibrate_xor_blocks+0x0/0x134 returned 0 after 29296 usecs

As you can see, we spend 30 ms on every boot re-confirming that, yet
again, the arm64_neon implementation is the fastest way to do XOR.
...and the above is on a system with HZ=1000.  Due to the way the
testing happens, if we have HZ defined to something slower it'll take
much longer.  HZ=100 means we spend 300 ms on every boot re-confirming
a fact that will be the same for every bootup.

Trying to super-optimize the xor operation makes a lot of sense if
you're using software RAID, but the above is probably not worth it for
most Linux users because:
1. Quite a few arm64 kernels are built for embedded systems where
   software raid isn't common.  That means we're spending lots of time
   on every boot trying to optimize something we don't use.
2. Presumably, if we have neon, it's faster than alternatives.  If
   it's not, it's not expected to be tons slower.
3. Quite a lot of arm64 systems are big.LITTLE.  This means that the
   existing test is somewhat misguided because it's assuming that test
   results on the boot CPU apply to the other CPUs in the system.
   This is not necessarily the case.

Let's add a new config option that allows us to just use the neon
functions (if present) without benchmarking.

NOTE: One small side effect is that on an arm64 system _without_ neon
we'll end up testing the xor_block_8regs_p and xor_block_32regs_p
versions of the function.  That's presumably OK since we already test
all those when KERNEL_MODE_NEON is disabled.

ALSO NOTE: presumably the way to do better than this is to add some
sort of per-CPU-core lookup table and jump to a per-CPU-core-specific
XOR function each time xor is called.  Without seeing evidence that
this would really help someone, though, that doesn't seem worth it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/Kconfig           | 15 +++++++++++++++
 arch/arm64/include/asm/xor.h |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 64ae5e4eb814..fc18df45a5f8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -306,6 +306,21 @@ config SMP
 config KERNEL_MODE_NEON
 	def_bool y
 
+menuconfig FORCE_NEON_XOR_IF_AVAILABLE
+	bool "Assume neon is fastest for xor if the CPU supports it"
+	default y
+	depends on KERNEL_MODE_NEON
+	help
+	  Normally the kernel will run through several different XOR
+	  algorithms at boot, timing them on the boot processor to see
+	  which is fastest. This can take quite some time. On many
+	  machines it's expected that, if NEON is available, it's going
+	  to provide the fastest implementation. If you set this option
+	  we'll skip testing this every boot and just assume NEON is the
+	  fastest if present. Setting this option will speed up your
+	  boot but you might end up with a less-optimal xor
+	  implementation.
+
 config FIX_EARLYCON_MEM
 	def_bool y
 
diff --git a/arch/arm64/include/asm/xor.h b/arch/arm64/include/asm/xor.h
index 947f6a4f1aa0..1acb290866ab 100644
--- a/arch/arm64/include/asm/xor.h
+++ b/arch/arm64/include/asm/xor.h
@@ -57,6 +57,10 @@ static struct xor_block_template xor_block_arm64 = {
 	.do_4   = xor_neon_4,
 	.do_5	= xor_neon_5
 };
+#ifdef CONFIG_FORCE_NEON_XOR_IF_AVAILABLE
+#define XOR_SELECT_TEMPLATE(FASTEST) \
+	(cpu_has_neon() ? &xor_block_arm64 : FASTEST)
+#else /* ! CONFIG_FORCE_NEON_XOR_IF_AVAILABLE */
 #undef XOR_TRY_TEMPLATES
 #define XOR_TRY_TEMPLATES           \
 	do {        \
@@ -66,5 +70,6 @@ static struct xor_block_template xor_block_arm64 = {
 			xor_speed(&xor_block_arm64);\
 		} \
 	} while (0)
+#endif /* ! CONFIG_FORCE_NEON_XOR_IF_AVAILABLE */
 
 #endif /* ! CONFIG_KERNEL_MODE_NEON */
-- 
2.28.0.681.g6f77f65b4e-goog


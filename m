Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F662E74EC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgL2VoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgL2VoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:44:22 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DCEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 13:43:42 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id 2so9844822qtt.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 13:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HyTMgo2VSftHBiDIe/SLp0txxvwc3jI6o6j5ZlWh/dw=;
        b=f0dILRFveWykzV+Z08AvfOmj26DARStkXTD2rimwgfWkfyVMqtfKDgl3xemZfvShcu
         wchzqQrdG3m9iLk3zCc2lgOa4be5mWmA4hJxWlc9OIqKOIavkMFv6U0Wjp6biO7jNHxK
         VMfU2h8EmtfFqiB1wQ3c5h10hPIZ7hfjpQAmzIEK/42ryVwsOtWnfffmx2hRQxlvPRm+
         lRPE3BxPkpJITLJ7pTCbUOWEdU8v3PPQzLPhxT2jCXyBltLlN/cFMCVqIUwTYvGWhpfP
         ahaKWxBfxutvEc4bFDrcIH5LZPJsw0wSv2gcWlpWUfD8WAA4MzYvetKlsExY7T9FmwSZ
         aFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HyTMgo2VSftHBiDIe/SLp0txxvwc3jI6o6j5ZlWh/dw=;
        b=P7B60UnutGI26Smtp0Xk2YIYvPa5+eF4Yyi7cwlwFUoB0BQi8FO8/9ZoEiX6vLEKFR
         e5qNBlwtrfXl6fwiZ+cq5fRhNzTbCDKT0F0vBOphOB1vOEn4NcobiqBbPIdWD50wbEZ4
         hzEhZJAzhReryDbV2dJBzAU9jii9RWnbiob7hDmnUq9Zx1zbWnSBDAEiNYkB2LUEO/fh
         JioN7KssHpaeOvtO3RcOXioNoOaB6YDqN/VYc6mE+jaYsmQRXQLyg48dyfKOyo9eZjbs
         EYFtDGv6VhwGJ+Tv1PCp3CFJk+3YggukIUf2FTciM4oHTnDGHggfoE8+POtnr/wBQ0OC
         Xeyg==
X-Gm-Message-State: AOAM5331wgKBQYrBSdcBx53XQnQsFhfK7VRyzq0l8BVvrz97XEgiSVvY
        P+Pr6snCsczNq5xVUzl2cUnKZ/NU260=
X-Google-Smtp-Source: ABdhPJxNRqILS8BFoDpnYl60ROLPkm6ALqjECJjXraNE4zHWZETdZN9t0HskLPCKTUrnD0VAHbTDpA==
X-Received: by 2002:ac8:1184:: with SMTP id d4mr50229998qtj.103.1609278221078;
        Tue, 29 Dec 2020 13:43:41 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id 17sm25725927qtb.17.2020.12.29.13.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 13:43:40 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] KVM: arm64: Fix section mismatches around hyp_cpu_pm_{init,exit}
Date:   Tue, 29 Dec 2020 14:43:36 -0700
Message-Id: <20201229214336.4098955-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fa8c3d65538a ("KVM: arm64: Keep nVHE EL2 vector installed")
inadvertently changed clang's inlining decisions around
hyp_cpu_pm_{init,exit}, causing the following section mismatch warnings:

WARNING: modpost: vmlinux.o(.text+0x95c6c): Section mismatch in
reference from the function kvm_arch_init() to the function
.init.text:hyp_cpu_pm_exit()
The function kvm_arch_init() references
the function __init hyp_cpu_pm_exit().
This is often because kvm_arch_init lacks a __init
annotation or the annotation of hyp_cpu_pm_exit is wrong.

WARNING: modpost: vmlinux.o(.text+0x97054): Section mismatch in
reference from the function init_subsystems() to the function
.init.text:hyp_cpu_pm_init()
The function init_subsystems() references
the function __init hyp_cpu_pm_init().
This is often because init_subsystems lacks a __init
annotation or the annotation of hyp_cpu_pm_init is wrong.

Remove the __init annotation so that there are no warnings regardless of
how functions are inlined.

Fixes: 1fcf7ce0c602 ("arm: kvm: implement CPU PM notifier")
Fixes: 06a71a24bae5 ("arm64: KVM: unregister notifiers in hyp mode teardown path")
Link: https://github.com/ClangBuiltLinux/linux/issues/1230
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm64/kvm/arm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 6e637d2b4cfb..71a49eae9ea0 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1574,12 +1574,12 @@ static struct notifier_block hyp_init_cpu_pm_nb = {
 	.notifier_call = hyp_init_cpu_pm_notifier,
 };
 
-static void __init hyp_cpu_pm_init(void)
+static void hyp_cpu_pm_init(void)
 {
 	if (!is_protected_kvm_enabled())
 		cpu_pm_register_notifier(&hyp_init_cpu_pm_nb);
 }
-static void __init hyp_cpu_pm_exit(void)
+static void hyp_cpu_pm_exit(void)
 {
 	if (!is_protected_kvm_enabled())
 		cpu_pm_unregister_notifier(&hyp_init_cpu_pm_nb);

base-commit: 5c8fe583cce542aa0b84adc939ce85293de36e5e
-- 
2.30.0


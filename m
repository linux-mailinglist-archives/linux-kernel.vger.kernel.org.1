Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C442CC591
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbgLBSnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387885AbgLBSnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:43:04 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F31C061A51
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:41:44 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id z7so5174375wrn.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y2p8Ay2XnBVL3vmtVVdiQ6iCXfVcEKgd2S1Ri8Ky5yc=;
        b=RVZK76j4k6bFwiXLgYuFF1wtJaBoX2V07k5mb0zz2XzuAWmLJ1i+F8W5NohjH00/sj
         gWlE7qrSAwcbIAEG3hSs7PAR248eOVkY6Xm3SGr2s7GCAbFd1nsA3SXKbGnzIxFSrkg8
         irlXEGzEcD3yJ1mQ7deVRYJx/fqkEt/rYVXS4dv7nID08H9qJKazcokqFUOi0xPNWDmc
         wSiS1Rr8Nrm4KLg51r8BdgmhZJ5lT0++p3Ln9OxqEdQrrLW0MIdiVj2Hn7v3NIVuTRH5
         LzsCZkvPa5kTdTcpPz8VJgGlrbBlyP+9VsdgTapGlKyPChgjeyjIeM7KiQROiHGleMKZ
         qLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2p8Ay2XnBVL3vmtVVdiQ6iCXfVcEKgd2S1Ri8Ky5yc=;
        b=H16LKfneoZC9FhDZXKV32s+R0P+JE/j0MeVA9sH4U1xFsaa1DHVJ4eK1p5sswU4bGl
         EHISXs1oSIRSGbH+lK8kf8EFKxxN5sKALKPn24piA8iJfkqoEAThm+R4lfRgUIUg474t
         EmIdOGsFe3yejoTd7CeVF5u3O07iIdfgoLjA7X7IcqgD8agyGKtA4kuxuEkr83URZgaE
         xDQoo2K1mIZNS9KnmCYhnrrSNOivHm/ZjAPrIW2D845vzYmsJvMb6tgyDQuKgugdTDwq
         v3JcI5gLb0eg7RnixzE9T6ESiXiDOMPaekKMNmtkS6S1yVDf4V0/3m52DR1D/vXeQ/FG
         fF/Q==
X-Gm-Message-State: AOAM533a7fxTn6J+wUEP7Mif7XZByl4B8O2+JGwvJC4csm5jpGWpAUwO
        wkgmyHOGDtjZzOe5uYMXk1KyJQ==
X-Google-Smtp-Source: ABdhPJxAQnxesV8ENz1UWdK5eE8OCnghkt8xaIi7bsuMXjZf93/bl2MjqeL5MAHnTzF9beINxPa0Kg==
X-Received: by 2002:adf:c443:: with SMTP id a3mr5093368wrg.249.1606934502768;
        Wed, 02 Dec 2020 10:41:42 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:5ddd:b7c5:e3c9:e87a])
        by smtp.gmail.com with ESMTPSA id v20sm2813264wmh.44.2020.12.02.10.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:41:41 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v4 07/26] arm64: Make cpu_logical_map() take unsigned int
Date:   Wed,  2 Dec 2020 18:41:03 +0000
Message-Id: <20201202184122.26046-8-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202184122.26046-1-dbrazdil@google.com>
References: <20201202184122.26046-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU index should never be negative. Change the signature of
(set_)cpu_logical_map to take an unsigned int.

This still works even if the users treat the CPU index as an int,
and will allow the hypervisor's implementation to check that the index
is valid with a single upper-bound check.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/smp.h | 4 ++--
 arch/arm64/kernel/setup.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 2e7f529ec5a6..bcb01ca15325 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -46,9 +46,9 @@ DECLARE_PER_CPU_READ_MOSTLY(int, cpu_number);
  * Logical CPU mapping.
  */
 extern u64 __cpu_logical_map[NR_CPUS];
-extern u64 cpu_logical_map(int cpu);
+extern u64 cpu_logical_map(unsigned int cpu);
 
-static inline void set_cpu_logical_map(int cpu, u64 hwid)
+static inline void set_cpu_logical_map(unsigned int cpu, u64 hwid)
 {
 	__cpu_logical_map[cpu] = hwid;
 }
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 133257ffd859..2f2973bc67c7 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -276,7 +276,7 @@ arch_initcall(reserve_memblock_reserved_regions);
 
 u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
 
-u64 cpu_logical_map(int cpu)
+u64 cpu_logical_map(unsigned int cpu)
 {
 	return __cpu_logical_map[cpu];
 }
-- 
2.29.2.454.gaff20da3a2-goog


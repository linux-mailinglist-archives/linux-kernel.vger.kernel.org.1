Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF4B1BD1E0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 03:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgD2BuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 21:50:21 -0400
Received: from mx140-tc.baidu.com ([61.135.168.140]:33259 "EHLO
        tc-sys-mailedm02.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726158AbgD2BuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 21:50:21 -0400
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm02.tc.baidu.com (Postfix) with ESMTP id 142A811C0063;
        Wed, 29 Apr 2020 09:50:07 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, peterz@infradead.org, ggherdovich@suse.cz,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com
Subject: [PATCH] x86: move turbo_disabled() out of intel_set_max_freq_ratio
Date:   Wed, 29 Apr 2020 09:50:07 +0800
Message-Id: <1588125007-8799-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move the turbo_disabled before intel_set_max_freq_ratio,
when turbo is disabled, the max frequency ratio is a const
value, it is unnecessary to read MSR_TURBO_RATIO* msr to
compute

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 arch/x86/kernel/smpboot.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fe3ab9632f3b..8979c459df2f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1987,7 +1987,7 @@ static bool intel_set_max_freq_ratio(void)
 out:
 	arch_turbo_freq_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE,
 					base_freq);
-	arch_set_max_freq_ratio(turbo_disabled());
+	arch_set_max_freq_ratio(false);
 	return true;
 }
 
@@ -2009,6 +2009,9 @@ static void init_freq_invariance(void)
 	if (smp_processor_id() != 0 || !boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return;
 
+	if (turbo_disabled())
+		return;
+
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
 		ret = intel_set_max_freq_ratio();
 
-- 
2.16.2


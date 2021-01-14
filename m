Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EC02F5FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 12:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbhANLS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 06:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbhANLS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 06:18:57 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BAFC061573
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 03:18:17 -0800 (PST)
Received: from zn.tnic (p200300ec2f1aa900c3e77ed14333c97a.dip0.t-ipconnect.de [IPv6:2003:ec:2f1a:a900:c3e7:7ed1:4333:c97a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AA8261EC04DF;
        Thu, 14 Jan 2021 12:18:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610623095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=AUnm8/C5Wu8bRF8KIcyg7mxOGIQM/6pSluKScrzmO9g=;
        b=k+9o3Dy1dbH5KAXe9bAvNRqgdgCaLmuxM0e1mPnLHTdbl2bLwULl+uXMRNWSonQ175z28S
        I0ntb9J1Te6Q+kkHu3dgN0RWWU0JGNUEMFvf5iiFbXt9uTnuSn2IIMwgIYtvrQUrzE0I6K
        YZLfUGihMF2Bz3+u+96ihE4JXDNUnwA=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] x86/topology: Make __max_die_per_package available unconditionally
Date:   Thu, 14 Jan 2021 12:18:14 +0100
Message-Id: <20210114111814.5346-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Move it outside of CONFIG_SMP in order to avoid ifdeffery at the usage
sites.

Fixes: 76e2fc63ca40 ("x86/cpu/amd: Set __max_die_per_package on AMD")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/topology.h | 4 ++--
 arch/x86/kernel/cpu/topology.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 488a8e848754..9239399e5491 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -110,6 +110,8 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
 #define topology_die_id(cpu)			(cpu_data(cpu).cpu_die_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
 
+extern unsigned int __max_die_per_package;
+
 #ifdef CONFIG_SMP
 #define topology_die_cpumask(cpu)		(per_cpu(cpu_die_map, cpu))
 #define topology_core_cpumask(cpu)		(per_cpu(cpu_core_map, cpu))
@@ -118,8 +120,6 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
 extern unsigned int __max_logical_packages;
 #define topology_max_packages()			(__max_logical_packages)
 
-extern unsigned int __max_die_per_package;
-
 static inline int topology_max_die_per_package(void)
 {
 	return __max_die_per_package;
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 1068002c8532..8678864ce712 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -25,10 +25,10 @@
 #define BITS_SHIFT_NEXT_LEVEL(eax)	((eax) & 0x1f)
 #define LEVEL_MAX_SIBLINGS(ebx)		((ebx) & 0xffff)
 
-#ifdef CONFIG_SMP
 unsigned int __max_die_per_package __read_mostly = 1;
 EXPORT_SYMBOL(__max_die_per_package);
 
+#ifdef CONFIG_SMP
 /*
  * Check if given CPUID extended toplogy "leaf" is implemented
  */
-- 
2.29.2


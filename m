Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA0D277C74
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 01:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgIXXt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 19:49:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbgIXXt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 19:49:57 -0400
Received: from sstabellini-ThinkPad-T480s.hsd1.ca.comcast.net (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D590F239EC;
        Thu, 24 Sep 2020 23:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600991397;
        bh=fRW1ZHqPHqZ48BxIvmHLvJMqcd/CjP5KGt6za+X8upo=;
        h=From:To:Cc:Subject:Date:From;
        b=ibTGX1WNRLvzLVxqQjXiWejMwgm0qp2FymbUjSI03Q6aCiLjE9B2v9kYJbja0qvDZ
         dnlMXblBKt6KiV6m/4tIdKFIvqtAegPLT7cMK5iLBXumckmutbIIPngVVVGazfM1Fz
         QOVhwEVae4X2Qo9X67C2d2B2KeK8lqXZGhN9/Oqs=
From:   Stefano Stabellini <sstabellini@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     sstabellini@kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Bertrand Marquis <Bertrand.Marquis@arm.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com
Subject: [PATCH] xen/arm: do not setup the runstate info page if kpti is enabled
Date:   Thu, 24 Sep 2020 16:49:55 -0700
Message-Id: <20200924234955.15455-1-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

The VCPUOP_register_runstate_memory_area hypercall takes a virtual
address of a buffer as a parameter. The semantics of the hypercall are
such that the virtual address should always be valid.

When KPTI is enabled and we are running userspace code, the virtual
address is not valid, thus, Linux is violating the semantics of
VCPUOP_register_runstate_memory_area.

Do not call VCPUOP_register_runstate_memory_area when KPTI is enabled.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
CC: Bertrand Marquis <Bertrand.Marquis@arm.com>
CC: boris.ostrovsky@oracle.com
CC: jgross@suse.com
---
 arch/arm/include/asm/xen/page.h   | 5 +++++
 arch/arm/xen/enlighten.c          | 6 ++++--
 arch/arm64/include/asm/xen/page.h | 6 ++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/xen/page.h b/arch/arm/include/asm/xen/page.h
index 31bbc803cecb..dc7f6e91aafa 100644
--- a/arch/arm/include/asm/xen/page.h
+++ b/arch/arm/include/asm/xen/page.h
@@ -1 +1,6 @@
 #include <xen/arm/page.h>
+
+static inline bool xen_kernel_unmapped_at_usr(void)
+{
+	return false;
+}
diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index e93145d72c26..ea76562af1e9 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -158,7 +158,8 @@ static int xen_starting_cpu(unsigned int cpu)
 	BUG_ON(err);
 	per_cpu(xen_vcpu, cpu) = vcpup;
 
-	xen_setup_runstate_info(cpu);
+	if (!xen_kernel_unmapped_at_usr())
+		xen_setup_runstate_info(cpu);
 
 after_register_vcpu_info:
 	enable_percpu_irq(xen_events_irq, 0);
@@ -387,7 +388,8 @@ static int __init xen_guest_init(void)
 		return -EINVAL;
 	}
 
-	xen_time_setup_guest();
+	if (!xen_kernel_unmapped_at_usr())
+		xen_time_setup_guest();
 
 	if (xen_initial_domain())
 		pvclock_gtod_register_notifier(&xen_pvclock_gtod_notifier);
diff --git a/arch/arm64/include/asm/xen/page.h b/arch/arm64/include/asm/xen/page.h
index 31bbc803cecb..dffdc773221b 100644
--- a/arch/arm64/include/asm/xen/page.h
+++ b/arch/arm64/include/asm/xen/page.h
@@ -1 +1,7 @@
 #include <xen/arm/page.h>
+#include <asm/mmu.h>
+
+static inline bool xen_kernel_unmapped_at_usr(void)
+{
+	return arm64_kernel_unmapped_at_el0();
+}
-- 
2.17.1


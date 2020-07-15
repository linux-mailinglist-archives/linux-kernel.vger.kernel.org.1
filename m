Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B1B2202C0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 05:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgGODKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 23:10:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7854 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727906AbgGODKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 23:10:02 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 79BF4C1F2898EE7D984B;
        Wed, 15 Jul 2020 11:09:55 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Jul 2020
 11:09:46 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] powerpc/smp: Remove unused inline functions
Date:   Wed, 15 Jul 2020 11:09:26 +0800
Message-ID: <20200715030926.30236-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 441c19c8a290 ("powerpc/kvm/book3s_hv: Rework the secondary inhibit code")
left behind this, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/powerpc/include/asm/smp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 49a25e2400f2..5d5a7596d144 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -176,8 +176,6 @@ extern void __cpu_die(unsigned int cpu);
 /* for UP */
 #define hard_smp_processor_id()		get_hard_smp_processor_id(0)
 #define smp_setup_cpu_maps()
-static inline void inhibit_secondary_onlining(void) {}
-static inline void uninhibit_secondary_onlining(void) {}
 static inline const struct cpumask *cpu_sibling_mask(int cpu)
 {
 	return cpumask_of(cpu);
-- 
2.17.1



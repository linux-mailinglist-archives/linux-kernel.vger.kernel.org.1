Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EAA26D113
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 04:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgIQCYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 22:24:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12805 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725858AbgIQCYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 22:24:22 -0400
X-Greylist: delayed 969 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 22:24:21 EDT
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AA4D2DF177FD101B59EF;
        Thu, 17 Sep 2020 10:08:10 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 10:08:04 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <christophe.leroy@csgroup.eu>, <yangyingliang@huawei.com>
Subject: [PATCH -next v2] powerpc/book3s64: fix link error with CONFIG_PPC_RADIX_MMU=n
Date:   Thu, 17 Sep 2020 10:06:43 +0800
Message-ID: <20200917020643.90375-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix link error when CONFIG_PPC_RADIX_MMU is disabled:
powerpc64-linux-gnu-ld: arch/powerpc/platforms/pseries/lpar.o:(.toc+0x0): undefined reference to `mmu_pid_bits'

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
  v2:
    - enclose radix_init_pseries with CONFIG_PPC_RADIX_MMU
    - remove CONFIG_PPC_RADIX_MMU in radix__init_new_context()
---
 arch/powerpc/platforms/pseries/lpar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index baf24eacd268..764170fdb0f7 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -1724,6 +1724,7 @@ void __init hpte_init_pseries(void)
 		pseries_lpar_register_process_table(0, 0, 0);
 }
 
+#ifdef CONFIG_PPC_RADIX_MMU
 void radix_init_pseries(void)
 {
 	pr_info("Using radix MMU under hypervisor\n");
@@ -1731,6 +1732,7 @@ void radix_init_pseries(void)
 	pseries_lpar_register_process_table(__pa(process_tb),
 						0, PRTB_SIZE_SHIFT - 12);
 }
+#endif
 
 #ifdef CONFIG_PPC_SMLPAR
 #define CMO_FREE_HINT_DEFAULT 1
-- 
2.25.1


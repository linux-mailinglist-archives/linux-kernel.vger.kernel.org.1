Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBED519C371
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 15:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388174AbgDBN7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 09:59:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40164 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727412AbgDBN7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:59:52 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9923666935139C50D3D6;
        Thu,  2 Apr 2020 21:59:43 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Apr 2020
 21:59:37 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <gregkh@linuxfoundation.org>,
        <christophe.leroy@c-s.fr>, <allison@lohutok.net>,
        <armijn@tjaldur.nl>, <tglx@linutronix.de>,
        <aneesh.kumar@linux.ibm.com>, <yuehaibing@huawei.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] powerpc/mm: ptdump: Add missing include <asm/vio.h>
Date:   Thu, 2 Apr 2020 21:58:28 +0800
Message-ID: <20200402135828.37308-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc build fails:

arch/powerpc/mm/ptdump/hashpagetable.c: In function ‘pseries_find’:
arch/powerpc/mm/ptdump/hashpagetable.c:262:18: error: ‘H_SUCCESS’ undeclared (first use in this function); did you mean ‘FL_ACCESS’?
   if (lpar_rc != H_SUCCESS)
                  ^~~~~~~~~
                  FL_ACCESS

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 65e701b2d2a8 ("powerpc/ptdump: drop non vital #ifdefs")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/powerpc/mm/ptdump/hashpagetable.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/ptdump/hashpagetable.c b/arch/powerpc/mm/ptdump/hashpagetable.c
index b6ed9578382f..8ea5f9a3b658 100644
--- a/arch/powerpc/mm/ptdump/hashpagetable.c
+++ b/arch/powerpc/mm/ptdump/hashpagetable.c
@@ -20,6 +20,7 @@
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <asm/plpar_wrappers.h>
+#include <asm/vio.h>
 #include <linux/memblock.h>
 #include <asm/firmware.h>
 
-- 
2.17.1



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78D623EB60
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 12:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgHGKUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 06:20:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9252 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726511AbgHGKUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 06:20:08 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4114BBCFA8119EC0047F;
        Fri,  7 Aug 2020 18:20:04 +0800 (CST)
Received: from linux_supse12sp4_workstation.huawei.com (10.67.189.177) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 7 Aug 2020 18:19:56 +0800
From:   chenzefeng <chenzefeng2@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <christophe.leroy@c-s.fr>,
        <tglx@linutronix.de>, <chenzefeng2@huawei.com>,
        <bigeasy@linutronix.de>, <npiggin@gmail.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <zengweilin@huawei.com>
Subject: [PATCH] powerpc:entry_32: correct the path and function name in the comment
Date:   Fri, 7 Aug 2020 18:19:56 +0800
Message-ID: <20200807101956.67454-1-chenzefeng2@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.177]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the comment for file's directory and function name changed.

Fixes: facd04a904ff ("powerpc: convert to copy_thread_tls")
Fixes: 14cf11af6cf6 ("powerpc: Merge enough to start building in arch/powerpc.")

Signed-off-by: chenzefeng <chenzefeng2@huawei.com>
---
 arch/powerpc/kernel/entry_32.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 8420abd4ea1c..9937593d3a33 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -696,8 +696,8 @@ handle_dabr_fault:
  * to the "_switch" path.  If you change this , you'll have to
  * change the fork code also.
  *
- * The code which creates the new task context is in 'copy_thread'
- * in arch/ppc/kernel/process.c
+ * The code which creates the new task context is in 'copy_thread_tls'
+ * in arch/powerpc/kernel/process.c
  */
 _GLOBAL(_switch)
 	stwu	r1,-INT_FRAME_SIZE(r1)
-- 
2.12.3


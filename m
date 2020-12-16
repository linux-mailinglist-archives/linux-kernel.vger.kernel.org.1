Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4802DC0D9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgLPNNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:13:02 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9453 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgLPNNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:13:02 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CwwWV22P9zhrLY;
        Wed, 16 Dec 2020 21:11:50 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Wed, 16 Dec 2020 21:12:13 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-alpha@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] alpha: kernel: convert comma to semicolon
Date:   Wed, 16 Dec 2020 21:12:41 +0800
Message-ID: <20201216131241.14447-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 arch/alpha/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 4c7b0414a3ff..71041347d189 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -256,7 +256,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 		childstack->r26 = (unsigned long) ret_from_kernel_thread;
 		childstack->r9 = usp;	/* function */
 		childstack->r10 = kthread_arg;
-		childregs->hae = alpha_mv.hae_cache,
+		childregs->hae = alpha_mv.hae_cache;
 		childti->pcb.usp = 0;
 		return 0;
 	}
-- 
2.22.0


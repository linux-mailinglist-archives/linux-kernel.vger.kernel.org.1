Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930A82E0AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgLVNd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:33:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10063 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbgLVNd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:33:56 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D0chN09SrzM6q8;
        Tue, 22 Dec 2020 21:32:20 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 22 Dec 2020 21:33:08 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <jason.wessel@windriver.com>, <daniel.thompson@linaro.org>,
        <kgdb-bugreport@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
CC:     <dianders@chromium.org>, Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] misc: use DIV_ROUND_UP macro to do calculation
Date:   Tue, 22 Dec 2020 21:33:44 +0800
Message-ID: <20201222133344.19753-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't open-code DIV_ROUND_UP() kernel macro.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/misc/kgdbts.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
index 945701bce553..cd086921a792 100644
--- a/drivers/misc/kgdbts.c
+++ b/drivers/misc/kgdbts.c
@@ -139,9 +139,8 @@ static int restart_from_top_after_write;
 static int sstep_state;
 
 /* Storage for the registers, in GDB format. */
-static unsigned long kgdbts_gdb_regs[(NUMREGBYTES +
-					sizeof(unsigned long) - 1) /
-					sizeof(unsigned long)];
+static unsigned long kgdbts_gdb_regs[DIV_ROUND_UP(NUMREGBYTES,
+				     sizeof(unsigned long)i)];
 static struct pt_regs kgdbts_regs;
 
 /* -1 = init not run yet, 0 = unconfigured, 1 = configured. */
-- 
2.22.0


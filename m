Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92702B1598
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 06:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgKMFnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 00:43:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8078 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgKMFnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 00:43:00 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CXS6S4KDszLvT5;
        Fri, 13 Nov 2020 13:42:40 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 13 Nov 2020 13:42:45 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] panic: Avoid dump_stack() twice
Date:   Fri, 13 Nov 2020 13:47:47 +0800
Message-ID: <20201113054747.177919-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stacktrace will be dumped twice on ARM64 after commit 3f388f28639f
("panic: dump registers on panic_on_warn"), will not dump_stack
when no regs as before.

Fixes: 3f388f28639f ("panic: dump registers on panic_on_warn")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 kernel/panic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 396142ee43fd..332736a72a58 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -605,7 +605,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 		panic("panic_on_warn set ...\n");
 	}
 
-	dump_stack();
+	if (!regs)
+		dump_stack();
 
 	print_irqtrace_events(current);
 
-- 
2.26.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6802E0AB2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgLVNbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:31:09 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10060 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgLVNbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:31:08 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D0cd62MCyzM841;
        Tue, 22 Dec 2020 21:29:30 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Tue, 22 Dec 2020 21:30:16 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <tytso@mit.edu>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] char: use DIV_ROUND_UP macro to do calculation
Date:   Tue, 22 Dec 2020 21:30:26 +0800
Message-ID: <20201222133026.19412-1-zhengyongjun3@huawei.com>
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
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2a41b21623ae..37b59e05d298 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -359,7 +359,7 @@
 #define EXTRACT_SIZE		10
 
 
-#define LONGS(x) (((x) + sizeof(unsigned long) - 1)/sizeof(unsigned long))
+#define LONGS(x) DIV_ROUND_UP(x, sizeof(unsigned long))
 
 /*
  * To allow fractional bits to be tracked, the entropy_count field is
-- 
2.22.0


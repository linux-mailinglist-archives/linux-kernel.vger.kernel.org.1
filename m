Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798B526BCD2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgIPGWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:22:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12724 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbgIPGVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:21:00 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 24B353DBC1CD16BBCEBB;
        Wed, 16 Sep 2020 14:20:59 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 16 Sep 2020 14:20:49 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
CC:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH -next] s390/ap: remove unnecessary spin_lock_init()
Date:   Wed, 16 Sep 2020 14:21:30 +0800
Message-ID: <20200916062130.190910-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spinlock ap_poll_timer_lock is initialized statically. It is
unnecessary to initialize by spin_lock_init().

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/s390/crypto/ap_bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 24a1940b8..231a98c91 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1575,7 +1575,6 @@ static int __init ap_module_init(void)
 	 */
 	if (MACHINE_IS_VM)
 		poll_timeout = 1500000;
-	spin_lock_init(&ap_poll_timer_lock);
 	hrtimer_init(&ap_poll_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	ap_poll_timer.function = ap_poll_timeout;
 
-- 
2.23.0


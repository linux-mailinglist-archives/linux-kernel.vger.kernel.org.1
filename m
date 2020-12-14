Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F132D9925
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438404AbgLNNo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:44:57 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9882 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436725AbgLNNoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:44:25 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CvjJT4RFQz7FqB;
        Mon, 14 Dec 2020 21:43:05 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 21:43:33 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] s390/crypto/zcrypt_cex2a: convert comma to semicolon
Date:   Mon, 14 Dec 2020 21:44:03 +0800
Message-ID: <20201214134403.4723-1-zhengyongjun3@huawei.com>
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
 drivers/s390/crypto/zcrypt_cex2a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/zcrypt_cex2a.c b/drivers/s390/crypto/zcrypt_cex2a.c
index 226a5612e855..62ceeb7fc125 100644
--- a/drivers/s390/crypto/zcrypt_cex2a.c
+++ b/drivers/s390/crypto/zcrypt_cex2a.c
@@ -175,7 +175,7 @@ static int zcrypt_cex2a_queue_probe(struct ap_device *ap_dev)
 	atomic_set(&zq->load, 0);
 	ap_queue_init_state(aq);
 	ap_queue_init_reply(aq, &zq->reply);
-	aq->request_timeout = CEX2A_CLEANUP_TIME,
+	aq->request_timeout = CEX2A_CLEANUP_TIME;
 	aq->private = zq;
 	rc = zcrypt_queue_register(zq);
 	if (rc) {
-- 
2.22.0


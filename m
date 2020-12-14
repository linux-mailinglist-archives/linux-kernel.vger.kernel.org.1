Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDDD2D9923
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408022AbgLNNoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:44:22 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9526 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439966AbgLNNoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:44:04 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CvjJ53pgmzhsn5;
        Mon, 14 Dec 2020 21:42:45 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 21:43:10 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] s390/crypto/zcrypt_cex4: convert comma to semicolon
Date:   Mon, 14 Dec 2020 21:43:41 +0800
Message-ID: <20201214134341.4671-1-zhengyongjun3@huawei.com>
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
 drivers/s390/crypto/zcrypt_cex4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/zcrypt_cex4.c b/drivers/s390/crypto/zcrypt_cex4.c
index f5195bca1d85..f4a6d3744241 100644
--- a/drivers/s390/crypto/zcrypt_cex4.c
+++ b/drivers/s390/crypto/zcrypt_cex4.c
@@ -631,7 +631,7 @@ static int zcrypt_cex4_queue_probe(struct ap_device *ap_dev)
 	atomic_set(&zq->load, 0);
 	ap_queue_init_state(aq);
 	ap_queue_init_reply(aq, &zq->reply);
-	aq->request_timeout = CEX4_CLEANUP_TIME,
+	aq->request_timeout = CEX4_CLEANUP_TIME;
 	aq->private = zq;
 	rc = zcrypt_queue_register(zq);
 	if (rc) {
-- 
2.22.0


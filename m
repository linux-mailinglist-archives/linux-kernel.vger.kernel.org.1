Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A631B2604
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 14:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgDUM3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 08:29:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2856 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbgDUM3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:29:42 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DBC97F69B83155C471DB;
        Tue, 21 Apr 2020 20:29:36 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Apr 2020 20:29:29 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <freude@linux.ibm.com>, <heiko.carstens@de.ibm.com>,
        <gor@linux.ibm.com>, <borntraeger@de.ibm.com>,
        <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] s390/zcrypt: fix kzalloc-simple.cocci warnings
Date:   Tue, 21 Apr 2020 20:35:48 +0800
Message-ID: <1587472548-105240-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below warning reported by coccicheck

drivers/s390/crypto/zcrypt_ep11misc.c:198:8-15: WARNING:
kzalloc should be used for cprb, instead of kmalloc/memset

Fixes: 7384eb725e2d ("s390/zcrypt: add new low level ep11 functions support file")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/s390/crypto/zcrypt_ep11misc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index 004ce02..3c3d403 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -195,11 +195,10 @@ static inline struct ep11_cprb *alloc_cprb(size_t payload_len)
 	size_t len = sizeof(struct ep11_cprb) + payload_len;
 	struct ep11_cprb *cprb;
 
-	cprb = kmalloc(len, GFP_KERNEL);
+	cprb = kzalloc(len, GFP_KERNEL);
 	if (!cprb)
 		return NULL;
 
-	memset(cprb, 0, len);
 	cprb->cprb_len = sizeof(struct ep11_cprb);
 	cprb->cprb_ver_id = 0x04;
 	memcpy(cprb->func_id, "T4", 2);
-- 
2.6.2


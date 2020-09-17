Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993B726D54D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgIQHwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:52:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42042 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726353AbgIQHvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:51:46 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F0F2A4E0C82E24E3C83E;
        Thu, 17 Sep 2020 15:51:30 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 15:51:23 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
CC:     <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>,
        "Liu Shixin" <liushixin2@huawei.com>
Subject: [PATCH -next] tee: optee: fix type warning of sizeof in pool_op_alloc()
Date:   Thu, 17 Sep 2020 16:13:56 +0800
Message-ID: <20200917081356.2083345-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sizeof() when applied to a pointer typed expression should gives the
size of the pointed data, even if the data is a pointer.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/tee/optee/shm_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
index d767eebf30bd..9fdc667b5df0 100644
--- a/drivers/tee/optee/shm_pool.c
+++ b/drivers/tee/optee/shm_pool.c
@@ -31,7 +31,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 		unsigned int nr_pages = 1 << order, i;
 		struct page **pages;
 
-		pages = kcalloc(nr_pages, sizeof(pages), GFP_KERNEL);
+		pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
 		if (!pages)
 			return -ENOMEM;
 
-- 
2.25.1


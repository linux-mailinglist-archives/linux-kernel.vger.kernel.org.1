Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68D826BCD3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgIPGWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:22:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12299 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726212AbgIPGUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:20:55 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EE1D8B69CD03527DFCD8;
        Wed, 16 Sep 2020 14:20:50 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Wed, 16 Sep 2020 14:20:39 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     <qat-linux@intel.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] crypto: qat - remove unnecessary mutex_init()
Date:   Wed, 16 Sep 2020 14:21:21 +0800
Message-ID: <20200916062121.190541-1-miaoqinglang@huawei.com>
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

The mutex adf_ctl_lock is initialized statically. It is
unnecessary to initialize by mutex_init().

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/crypto/qat/qat_common/adf_ctl_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_ctl_drv.c b/drivers/crypto/qat/qat_common/adf_ctl_drv.c
index 71d0c44aa..eb9b3be9d 100644
--- a/drivers/crypto/qat/qat_common/adf_ctl_drv.c
+++ b/drivers/crypto/qat/qat_common/adf_ctl_drv.c
@@ -416,8 +416,6 @@ static long adf_ctl_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 
 static int __init adf_register_ctl_device_driver(void)
 {
-	mutex_init(&adf_ctl_lock);
-
 	if (adf_chr_drv_create())
 		goto err_chr_dev;
 
-- 
2.23.0


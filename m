Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D23426F00F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 04:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgIRCkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 22:40:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33634 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728246AbgIRCkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 22:40:05 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 77798DD5430AFF1AA5CD;
        Fri, 18 Sep 2020 10:40:03 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 10:39:54 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] eeprom: ee1004: use module_i2c_driver to simplify the code
Date:   Fri, 18 Sep 2020 11:02:25 +0800
Message-ID: <20200918030225.3902750-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the module_i2c_driver() macro to make the code smaller
and a bit simpler.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/misc/eeprom/ee1004.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index b081c67416d7..252e15ba65e1 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -280,18 +280,7 @@ static struct i2c_driver ee1004_driver = {
 	.remove = ee1004_remove,
 	.id_table = ee1004_ids,
 };
-
-static int __init ee1004_init(void)
-{
-	return i2c_add_driver(&ee1004_driver);
-}
-module_init(ee1004_init);
-
-static void __exit ee1004_exit(void)
-{
-	i2c_del_driver(&ee1004_driver);
-}
-module_exit(ee1004_exit);
+module_i2c_driver(ee1004_driver);
 
 MODULE_DESCRIPTION("Driver for EE1004-compliant DDR4 SPD EEPROMs");
 MODULE_AUTHOR("Jean Delvare");
-- 
2.25.1


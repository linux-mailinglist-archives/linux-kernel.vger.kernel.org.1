Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5F22684E7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 08:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgINGcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 02:32:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45792 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726078AbgINGbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 02:31:31 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2733BEA770FA9B6ED669;
        Mon, 14 Sep 2020 14:31:27 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 14 Sep 2020
 14:31:20 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] extcon: axp288: use module_platform_driver to simplify the code
Date:   Mon, 14 Sep 2020 14:54:00 +0800
Message-ID: <20200914065400.3726302-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

module_platform_driver() makes the code simpler by eliminating
boilerplate code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/extcon/extcon-axp288.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
index 525345367260..fdb31954cf2b 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -491,18 +491,7 @@ static struct platform_driver axp288_extcon_driver = {
 		.pm = &axp288_extcon_pm_ops,
 	},
 };
-
-static int __init axp288_extcon_init(void)
-{
-	return platform_driver_register(&axp288_extcon_driver);
-}
-module_init(axp288_extcon_init);
-
-static void __exit axp288_extcon_exit(void)
-{
-	platform_driver_unregister(&axp288_extcon_driver);
-}
-module_exit(axp288_extcon_exit);
+module_platform_driver(axp288_extcon_driver);
 
 MODULE_AUTHOR("Ramakrishna Pallala <ramakrishna.pallala@intel.com>");
 MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939CC21B1F3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 11:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgGJJFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 05:05:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7290 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726496AbgGJJFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:05:38 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7670EF0BE4FE5E3372A5;
        Fri, 10 Jul 2020 17:02:41 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Fri, 10 Jul 2020
 17:02:32 +0800
From:   Lu Wei <luwei32@huawei.com>
To:     <alex.hung@canonical.com>, <dvhart@infradead.org>,
        <andy@infradead.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <acelan.kao@canonical.com>,
        <andy.shevchenko@gmail.com>, <luwei32@huawei.com>
Subject: [PATCH v3 2/2] intel-vbtn: Fix return value check in check_acpi_dev()
Date:   Fri, 10 Jul 2020 17:04:23 +0800
Message-ID: <1594371863-20827-3-git-send-email-luwei32@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594371863-20827-1-git-send-email-luwei32@huawei.com>
References: <1594371863-20827-1-git-send-email-luwei32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function check_acpi_dev(), if it fails to create
platform device, the return value is ERR_PTR() or NULL.
Thus it must use IS_ERR_OR_NULL to check return value.

Fixes: 332e0812 ("intel-vbtn: new driver for Intel Virtual Button")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Lu Wei <luwei32@huawei.com>
---
v2->v3
- Modify format

 drivers/platform/x86/intel-vbtn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index b588093..e1aa526 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -251,7 +251,7 @@ check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
 		return AE_OK;

 	if (acpi_match_device_ids(dev, ids) == 0)
-		if (acpi_create_platform_device(dev, NULL))
+		if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL)))
 			dev_info(&dev->dev,
 				 "intel-vbtn: created platform device\n");

--
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43391BD7E2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 11:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgD2JFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 05:05:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3338 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726423AbgD2JFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:05:44 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9925BE945948337D28CD;
        Wed, 29 Apr 2020 17:05:41 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Wed, 29 Apr 2020 17:05:32 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <ibm-acpi@hmh.eng.br>, <dvhart@infradead.org>,
        <andy@infradead.org>, <ibm-acpi-devel@lists.sourceforge.net>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangxiongfeng2@huawei.com>
Subject: [PATCH] platform/x86: thinkpad_acpi: Remove always false 'value < 0' statement
Date:   Wed, 29 Apr 2020 16:59:40 +0800
Message-ID: <1588150780-53718-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 'value' is declared as unsigned long, the following statement is
always false.
	value < 0

So let's remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 8eaadba..0f70448 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9548,7 +9548,7 @@ static ssize_t tpacpi_battery_store(int what,
 		if (!battery_info.batteries[battery].start_support)
 			return -ENODEV;
 		/* valid values are [0, 99] */
-		if (value < 0 || value > 99)
+		if (value > 99)
 			return -EINVAL;
 		if (value > battery_info.batteries[battery].charge_stop)
 			return -EINVAL;
-- 
1.7.12.4


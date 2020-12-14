Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670142D98D4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439555AbgLNNbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:31:47 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9172 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439514AbgLNNbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:31:39 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cvj1j11Sxz15f77;
        Mon, 14 Dec 2020 21:30:17 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 21:30:44 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <jim.cromie@gmail.com>, <jdelvare@suse.com>, <linux@roeck-us.net>
CC:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Zheng Yongjun" <zhengyongjun3@huawei.com>
Subject: [PATCH -next] hwmon/pc87360: convert comma to semicolon
Date:   Mon, 14 Dec 2020 21:31:14 +0800
Message-ID: <20201214133114.3516-1-zhengyongjun3@huawei.com>
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
 drivers/hwmon/pc87360.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 94f4b8b4a2ba..6a9ba23cd302 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -1700,8 +1700,8 @@ static int __init pc87360_device_add(unsigned short address)
 			continue;
 		res[res_count].start = extra_isa[i];
 		res[res_count].end = extra_isa[i] + PC87360_EXTENT - 1;
-		res[res_count].name = "pc87360",
-		res[res_count].flags = IORESOURCE_IO,
+		res[res_count].name = "pc87360";
+		res[res_count].flags = IORESOURCE_IO;
 
 		err = acpi_check_resource_conflict(&res[res_count]);
 		if (err)
-- 
2.22.0


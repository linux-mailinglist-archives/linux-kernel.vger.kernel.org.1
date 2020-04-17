Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D3C1ADAC1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 12:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgDQKM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 06:12:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59814 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbgDQKM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:12:28 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3DF91F30C4E3912C6557;
        Fri, 17 Apr 2020 18:12:24 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Apr 2020
 18:12:13 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <computersforpeace@gmail.com>, <kdasu.kdev@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] mtd: rawnand: brcmnand: Remove unused including <linux/version.h>
Date:   Fri, 17 Apr 2020 18:11:29 +0800
Message-ID: <20200417101129.35556-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove including <linux/version.h> that don't need it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index e4e3ceeac38f..57076c3d98dc 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -4,7 +4,6 @@
  */
 
 #include <linux/clk.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-- 
2.17.1



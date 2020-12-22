Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B232E0A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 13:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgLVMmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 07:42:54 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9546 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgLVMmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 07:42:53 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D0bYh5WXczhwlb;
        Tue, 22 Dec 2020 20:41:28 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Tue, 22 Dec 2020 20:42:04 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <axboe@kernel.dk>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] ata/pata_macio: use DIV_ROUND_UP macro to do calculation
Date:   Tue, 22 Dec 2020 20:42:36 +0800
Message-ID: <20201222124236.18998-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't open-code DIV_ROUND_UP() kernel macro.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/ata/pata_macio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index e47a28271f5b..43f11d991df2 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -84,8 +84,8 @@ static const char* macio_ata_names[] = {
  */
 
 /* Number of IDE_SYSCLK_NS ticks, argument is in nanoseconds */
-#define SYSCLK_TICKS(t)		(((t) + IDE_SYSCLK_NS - 1) / IDE_SYSCLK_NS)
-#define SYSCLK_TICKS_66(t)	(((t) + IDE_SYSCLK_66_NS - 1) / IDE_SYSCLK_66_NS)
+#define SYSCLK_TICKS(t)		DIV_ROUND_UP(t, IDE_SYSCLK_NS)
+#define SYSCLK_TICKS_66(t)	DIV_ROUND_UP(t, IDE_SYSCLK_66_NS)
 #define IDE_SYSCLK_NS		30	/* 33Mhz cell */
 #define IDE_SYSCLK_66_NS	15	/* 66Mhz cell */
 
-- 
2.22.0


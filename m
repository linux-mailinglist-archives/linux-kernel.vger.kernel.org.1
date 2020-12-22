Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C52E2E0AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgLVNcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:32:20 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9635 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgLVNcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:32:20 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D0cfl03SJz15hCF;
        Tue, 22 Dec 2020 21:30:55 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Tue, 22 Dec 2020 21:31:30 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <davem@davemloft.net>, <linux-ide@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <benh@kernel.crashing.org>, <paulus@samba.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] ide/pmac: use DIV_ROUND_UP macro to do calculation
Date:   Tue, 22 Dec 2020 21:32:05 +0800
Message-ID: <20201222133205.19579-1-zhengyongjun3@huawei.com>
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
 drivers/ide/pmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index ea0b064b5f56..6c0237af610d 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -105,8 +105,8 @@ static const char* model_name[] = {
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


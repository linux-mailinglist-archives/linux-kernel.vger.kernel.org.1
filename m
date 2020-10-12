Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93FE28AC4B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 04:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgJLCuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 22:50:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38202 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726098AbgJLCuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 22:50:20 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E62B1613D6B31E5941E5;
        Mon, 12 Oct 2020 10:50:17 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Mon, 12 Oct 2020 10:50:10 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <sre@kernel.org>, <gustavoars@kernel.org>, <pavel@ucw.cz>
CC:     <linux-kernel@vger.kernel.org>, <jingxiangfeng@huawei.com>
Subject: [PATCH] HSI: omap_ssi: Don't jump to free ID in ssi_add_controller()
Date:   Mon, 12 Oct 2020 10:56:43 +0800
Message-ID: <20201012025643.6883-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current code, it jumps to ida_simple_remove() when ida_simple_get()
failes to allocate an ID. Just return to fix it.

Fixes: 0fae198988b8 ("HSI: omap_ssi: built omap_ssi and omap_ssi_port into one module")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/hsi/controllers/omap_ssi_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index fa69b94debd9..7596dc164648 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -355,7 +355,7 @@ static int ssi_add_controller(struct hsi_controller *ssi,
 
 	err = ida_simple_get(&platform_omap_ssi_ida, 0, 0, GFP_KERNEL);
 	if (err < 0)
-		goto out_err;
+		return err;
 	ssi->id = err;
 
 	ssi->owner = THIS_MODULE;
-- 
2.17.1


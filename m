Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0221C5055
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 10:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgEEIaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 04:30:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38950 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725766AbgEEIaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 04:30:18 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0F2CFF8EC9A9A5F69EF6;
        Tue,  5 May 2020 16:30:16 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Tue, 5 May 2020
 16:30:05 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] clk: Remove unused inline function clk_debug_reparent
Date:   Tue, 5 May 2020 16:30:01 +0800
Message-ID: <20200505083001.52564-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no callers in-tree anymore.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/clk/clk.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 39c59f063aa0..5501041c91fc 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3295,10 +3295,6 @@ static int __init clk_debug_init(void)
 late_initcall(clk_debug_init);
 #else
 static inline void clk_debug_register(struct clk_core *core) { }
-static inline void clk_debug_reparent(struct clk_core *core,
-				      struct clk_core *new_parent)
-{
-}
 static inline void clk_debug_unregister(struct clk_core *core)
 {
 }
-- 
2.17.1



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DC62E0AD3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgLVNdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:33:44 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10062 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbgLVNdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:33:43 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D0ch7104FzM7VF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 21:32:07 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Tue, 22 Dec 2020 21:32:53 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] mfd/mcp-sa11x0: use DIV_ROUND_UP to calculate rw_timeout
Date:   Tue, 22 Dec 2020 21:33:26 +0800
Message-ID: <20201222133326.19698-1-zhengyongjun3@huawei.com>
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
 drivers/mfd/mcp-sa11x0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/mcp-sa11x0.c b/drivers/mfd/mcp-sa11x0.c
index 98fa0af0e56e..4629dff187cd 100644
--- a/drivers/mfd/mcp-sa11x0.c
+++ b/drivers/mfd/mcp-sa11x0.c
@@ -214,8 +214,7 @@ static int mcp_sa11x0_probe(struct platform_device *dev)
 	 * rate.  This is the period for 3 64-bit frames.  Always
 	 * round this time up.
 	 */
-	mcp->rw_timeout = (64 * 3 * 1000000 + mcp->sclk_rate - 1) /
-			  mcp->sclk_rate;
+	mcp->rw_timeout = DIV_ROUND_UP(64 * 3 * 1000000, mcp->sclk_rate);
 
 	ret = mcp_host_add(mcp, data->codec_pdata);
 	if (ret == 0)
-- 
2.22.0


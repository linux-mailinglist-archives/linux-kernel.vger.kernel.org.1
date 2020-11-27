Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1819F2C621A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 10:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgK0Jmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 04:42:49 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8187 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbgK0Jmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 04:42:45 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cj8mM1zT2zkhFX;
        Fri, 27 Nov 2020 17:42:11 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 27 Nov 2020 17:42:32 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@siol.net>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH 2/3] crypto: sun8i - fix reference leak in sun8i-ce
Date:   Fri, 27 Nov 2020 17:46:45 +0800
Message-ID: <20201127094646.121735-3-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201127094646.121735-1-miaoqinglang@huawei.com>
References: <20201127094646.121735-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_sync will increment pm usage counter even it
failed. Forgetting to putting operation will result in a
reference leak here.

A new function pm_runtime_resume_and_get is introduced in
[0] to keep usage counter balanced. So We fix the reference
leak by replacing it with new funtion.

[0] dd8088d5a896 ("PM: runtime: Add  pm_runtime_resume_and_get to deal with usage counter")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index 158422ff5..00194d1d9 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -932,7 +932,7 @@ static int sun8i_ce_probe(struct platform_device *pdev)
 	if (err)
 		goto error_alg;
 
-	err = pm_runtime_get_sync(ce->dev);
+	err = pm_runtime_resume_and_get(ce->dev);
 	if (err < 0)
 		goto error_alg;
 
-- 
2.23.0


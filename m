Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BACF27251C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgIUNOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:14:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42280 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727127AbgIUNJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:09:59 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AB584AD019DE5FA38497;
        Mon, 21 Sep 2020 21:09:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:09:51 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] drm: omapdrm: dss: simplify the return expression of hdmi_init_pll_data
Date:   Mon, 21 Sep 2020 21:10:15 +0800
Message-ID: <20200921131015.91422-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the return expression.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/gpu/drm/omapdrm/dss/hdmi_pll.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c b/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
index cf2b000f3..c3e85b636 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
@@ -131,7 +131,6 @@ static int hdmi_init_pll_data(struct dss_device *dss,
 {
 	struct dss_pll *pll = &hpll->pll;
 	struct clk *clk;
-	int r;
 
 	clk = devm_clk_get(&pdev->dev, "sys_clk");
 	if (IS_ERR(clk)) {
@@ -151,11 +150,7 @@ static int hdmi_init_pll_data(struct dss_device *dss,
 
 	pll->ops = &hdmi_pll_ops;
 
-	r = dss_pll_register(dss, pll);
-	if (r)
-		return r;
-
-	return 0;
+	return dss_pll_register(dss, pll);
 }
 
 int hdmi_pll_init(struct dss_device *dss, struct platform_device *pdev,
-- 
2.23.0


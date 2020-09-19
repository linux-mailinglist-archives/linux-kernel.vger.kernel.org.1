Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401C5270C44
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 11:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgISJqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 05:46:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13770 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbgISJqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 05:46:33 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 78282EC0C9926CB3A791;
        Sat, 19 Sep 2020 17:46:30 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Sat, 19 Sep 2020
 17:46:23 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Liu Shixin" <liushixin2@huawei.com>
Subject: [PATCH -next] drm/omap: dsi: simplify the return expression of dsi_init_pll_data
Date:   Sat, 19 Sep 2020 18:08:52 +0800
Message-ID: <20200919100852.1639163-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the return expression.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/gpu/drm/omapdrm/dss/dsi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index eeccf40bae41..cac0d1993dab 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -5015,7 +5015,6 @@ static int dsi_init_pll_data(struct dss_device *dss, struct dsi_data *dsi)
 {
 	struct dss_pll *pll = &dsi->pll;
 	struct clk *clk;
-	int r;
 
 	clk = devm_clk_get(dsi->dev, "sys_clk");
 	if (IS_ERR(clk)) {
@@ -5030,11 +5029,7 @@ static int dsi_init_pll_data(struct dss_device *dss, struct dsi_data *dsi)
 	pll->hw = dsi->data->pll_hw;
 	pll->ops = &dsi_pll_ops;
 
-	r = dss_pll_register(dss, pll);
-	if (r)
-		return r;
-
-	return 0;
+	return dss_pll_register(dss, pll);
 }
 
 /* -----------------------------------------------------------------------------
-- 
2.25.1


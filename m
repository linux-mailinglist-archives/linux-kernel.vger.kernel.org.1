Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B42272514
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbgIUNOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:14:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13755 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726690AbgIUNKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:10:06 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1CB52DA434280CFD50D1;
        Mon, 21 Sep 2020 21:10:05 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:09:54 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] drm/panel: simplify the return expression of td028ttec1_prepare
Date:   Mon, 21 Sep 2020 21:10:18 +0800
Message-ID: <20200921131018.91513-1-miaoqinglang@huawei.com>
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
 drivers/gpu/drm/panel/panel-tpo-td028ttec1.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c b/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
index 037c14fd6..ba0c00d1a 100644
--- a/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
+++ b/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
@@ -242,13 +242,8 @@ static int td028ttec1_prepare(struct drm_panel *panel)
 static int td028ttec1_enable(struct drm_panel *panel)
 {
 	struct td028ttec1_panel *lcd = to_td028ttec1_device(panel);
-	int ret;
 
-	ret = jbt_ret_write_0(lcd, JBT_REG_DISPLAY_ON, NULL);
-	if (ret)
-		return ret;
-
-	return 0;
+	return jbt_ret_write_0(lcd, JBT_REG_DISPLAY_ON, NULL);
 }
 
 static int td028ttec1_disable(struct drm_panel *panel)
-- 
2.23.0


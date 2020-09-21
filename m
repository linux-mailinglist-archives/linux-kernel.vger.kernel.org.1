Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A698272515
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgIUNOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:14:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13801 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727212AbgIUNKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:10:06 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E30D6ADE57EAF59913BA;
        Mon, 21 Sep 2020 21:10:02 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:09:53 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] drm/omap: dss: simplify the return expression of dss_setup_default_clock()
Date:   Mon, 21 Sep 2020 21:10:17 +0800
Message-ID: <20200921131017.91468-1-miaoqinglang@huawei.com>
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
 drivers/gpu/drm/omapdrm/dss/dss.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dss.c b/drivers/gpu/drm/omapdrm/dss/dss.c
index 6ccbc29c4..b74579270 100644
--- a/drivers/gpu/drm/omapdrm/dss/dss.c
+++ b/drivers/gpu/drm/omapdrm/dss/dss.c
@@ -672,7 +672,6 @@ static int dss_setup_default_clock(struct dss_device *dss)
 	unsigned long max_dss_fck, prate;
 	unsigned long fck;
 	unsigned int fck_div;
-	int r;
 
 	max_dss_fck = dss->feat->fck_freq_max;
 
@@ -687,11 +686,7 @@ static int dss_setup_default_clock(struct dss_device *dss)
 		    * dss->feat->dss_fck_multiplier;
 	}
 
-	r = dss_set_fck_rate(dss, fck);
-	if (r)
-		return r;
-
-	return 0;
+	return dss_set_fck_rate(dss, fck);
 }
 
 void dss_set_venc_output(struct dss_device *dss, enum omap_dss_venc_type type)
-- 
2.23.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF92270C46
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 11:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgISJqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 05:46:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54758 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726200AbgISJqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 05:46:36 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 85546458D285ADC0F536;
        Sat, 19 Sep 2020 17:46:31 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Sat, 19 Sep 2020
 17:46:21 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <lima@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] drm/lima: simplify the return expression of lima_devfreq_target
Date:   Sat, 19 Sep 2020 18:08:50 +0800
Message-ID: <20200919100850.1639111-1-liushixin2@huawei.com>
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
 drivers/gpu/drm/lima/lima_devfreq.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
index bbe02817721b..5914442936ed 100644
--- a/drivers/gpu/drm/lima/lima_devfreq.c
+++ b/drivers/gpu/drm/lima/lima_devfreq.c
@@ -35,18 +35,13 @@ static int lima_devfreq_target(struct device *dev, unsigned long *freq,
 			       u32 flags)
 {
 	struct dev_pm_opp *opp;
-	int err;
 
 	opp = devfreq_recommended_opp(dev, freq, flags);
 	if (IS_ERR(opp))
 		return PTR_ERR(opp);
 	dev_pm_opp_put(opp);
 
-	err = dev_pm_opp_set_rate(dev, *freq);
-	if (err)
-		return err;
-
-	return 0;
+	return dev_pm_opp_set_rate(dev, *freq);
 }
 
 static void lima_devfreq_reset(struct lima_devfreq *devfreq)
-- 
2.25.1


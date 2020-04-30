Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B541BF163
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 09:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgD3Has (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 03:30:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3392 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726412AbgD3Har (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:30:47 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9B475ACED6C4FA6FBC0D;
        Thu, 30 Apr 2020 15:30:45 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 30 Apr 2020 15:30:35 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next v2] drm/mcde: dsi: Fix return value check in mcde_dsi_bind()
Date:   Thu, 30 Apr 2020 07:31:45 +0000
Message-ID: <20200430073145.52321-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428141459.87624-1-weiyongjun1@huawei.com>
References: <20200428141459.87624-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_drm_find_bridge() function returns NULL on error, it doesn't return
error pointers so this check doesn't work.

Fixes: 5fc537bfd000 ("drm/mcde: Add new driver for ST-Ericsson MCDE")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
v1 - > v2: add fixes and fix the subject
---
 drivers/gpu/drm/mcde/mcde_dsi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde/mcde_dsi.c
index 7af5ebb0c436..e705afc08c4e 100644
--- a/drivers/gpu/drm/mcde/mcde_dsi.c
+++ b/drivers/gpu/drm/mcde/mcde_dsi.c
@@ -1073,10 +1073,9 @@ static int mcde_dsi_bind(struct device *dev, struct device *master,
 			panel = NULL;
 
 			bridge = of_drm_find_bridge(child);
-			if (IS_ERR(bridge)) {
-				dev_err(dev, "failed to find bridge (%ld)\n",
-					PTR_ERR(bridge));
-				return PTR_ERR(bridge);
+			if (!bridge) {
+				dev_err(dev, "failed to find bridge\n");
+				return -EINVAL;
 			}
 		}
 	}




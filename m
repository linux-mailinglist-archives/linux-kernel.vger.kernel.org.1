Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC372B0658
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgKLNXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:23:14 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7181 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgKLNXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:23:13 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CX2N458s4z15VD0;
        Thu, 12 Nov 2020 21:23:00 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Nov 2020 21:23:02 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <jernej.skrabec@siol.net>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <wangxiongfeng2@huawei.com>, <chenzhou10@huawei.com>
Subject: [PATCH] drm/sun4i: dw-hdmi: fix error return code in sun8i_dw_hdmi_bind()
Date:   Thu, 12 Nov 2020 21:14:51 +0800
Message-ID: <1605186891-47282-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code from the error handling case instead
of 0 in function sun8i_dw_hdmi_bind().

Fixes: b7c7436a5ff0 ("drm/sun4i: Implement A83T HDMI driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index d4c0804..f010fe8 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -208,6 +208,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 	phy_node = of_parse_phandle(dev->of_node, "phys", 0);
 	if (!phy_node) {
 		dev_err(dev, "Can't found PHY phandle\n");
+		ret = -ENODEV;
 		goto err_disable_clk_tmds;
 	}
 
-- 
1.7.12.4


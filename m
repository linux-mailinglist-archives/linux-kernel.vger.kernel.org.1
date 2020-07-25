Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7C422D584
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 08:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgGYGbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 02:31:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51526 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726273AbgGYGbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 02:31:11 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9D84E36C33CB5477DF20;
        Sat, 25 Jul 2020 14:31:06 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 25 Jul 2020 14:30:58 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] drm: xlnx: Fix typo in parameter description
Date:   Sat, 25 Jul 2020 06:34:29 +0000
Message-ID: <20200725063429.172139-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in parameter description.

Fixes: d76271d22694 ("drm: xlnx: DRM/KMS driver for Xilinx ZynqMP DisplayPort Subsystem")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/gpu/drm/xlnx/zynqmp_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 821f7a71e182..3d53638ab15e 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -44,7 +44,7 @@ MODULE_PARM_DESC(aux_timeout_ms, "DP aux timeout value in msec (default: 50)");
  */
 static uint zynqmp_dp_power_on_delay_ms = 4;
 module_param_named(power_on_delay_ms, zynqmp_dp_power_on_delay_ms, uint, 0444);
-MODULE_PARM_DESC(aux_timeout_ms, "DP power on delay in msec (default: 4)");
+MODULE_PARM_DESC(power_on_delay_ms, "DP power on delay in msec (default: 4)");
 
 /* Link configuration registers */
 #define ZYNQMP_DP_LINK_BW_SET				0x0




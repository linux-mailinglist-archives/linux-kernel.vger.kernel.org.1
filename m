Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35668296C4D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461668AbgJWJp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:45:58 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47562 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461555AbgJWJp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:45:57 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09N9jXjC079273;
        Fri, 23 Oct 2020 04:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603446333;
        bh=vd/rQ8Z51OitxruTppvHsOzxNO2Z78PVRSBR/5M5zMk=;
        h=From:To:CC:Subject:Date;
        b=c1tHVgdTnRhcXT9gX9bvJRksoPbgIC5b1dTUMDWlbmmg/qfB//8HmH6b8NwPPrRpH
         +x5fA3AEkbGkdmx8dvKTmHPpcFNzmHxeyIsTRxm1yWru6kvwDMGrsgATH+SnWyU/Jp
         uMZ9pTiBJMoFAJ6xs7dQbZSc2WStqShwA6q4awN8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09N9jXcw091988
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Oct 2020 04:45:33 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 23
 Oct 2020 04:45:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 23 Oct 2020 04:45:32 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09N9jUfl007401;
        Fri, 23 Oct 2020 04:45:30 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <hyun.kwon@xilinx.com>, <laurent.pinchart@ideasonboard.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm: xlnx: Use dma_request_chan for DMA channel request
Date:   Fri, 23 Oct 2020 12:46:02 +0300
Message-ID: <20201023094602.5630-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to use the of_dma_request_slave_channel() directly as
dma_request_chan() is going to try to get the channel via OF as well.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 98bd48f13fd1..a4405d081aca 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -28,7 +28,6 @@
 #include <linux/dmaengine.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_dma.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
@@ -1316,8 +1315,7 @@ static int zynqmp_disp_layer_request_dma(struct zynqmp_disp *disp,
 
 		snprintf(dma_channel_name, sizeof(dma_channel_name),
 			 "%s%u", dma_names[layer->id], i);
-		dma->chan = of_dma_request_slave_channel(disp->dev->of_node,
-							 dma_channel_name);
+		dma->chan = dma_request_chan(disp->dev, dma_channel_name);
 		if (IS_ERR(dma->chan)) {
 			dev_err(disp->dev, "failed to request dma channel\n");
 			ret = PTR_ERR(dma->chan);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

